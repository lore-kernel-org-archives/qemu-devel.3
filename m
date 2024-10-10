Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3653CCF07DD
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypEH-0005q4-Qv; Thu, 10 Oct 2024 05:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypEC-0005pi-SC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:13:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypEA-0002Kl-Oz
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:13:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A73ce6015899;
 Thu, 10 Oct 2024 09:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 UeD+vxSgC/uVbuZF1G+r9EF26fle9y5VO8LIWPdQEYo=; b=W2aQbLlErkMESzV1
 1sxmFFPOAKcthovE5OtIwlT4ykcm8ylQclwp+SiSuwsCftdGBWcn/T7Oqd+/5vvr
 /18IHky4iDmMR84E8QymSniRM+pC5rv5mF3vXtk7+J7Xe3RprQz3whTEsyxZUNH0
 CVyQ5kpoYSVtyNq3YNZr+96fPEtrykztPCACZ/xaAqwaZqRVOC9uXdlT0x43HZ64
 xvJ08MVPxNuIZuirgcTdNqqivsSZ27UEMT3HYkP+AESCRJ91vLq54zUr0J36NXcr
 1QU7E4D7EII614StyZAEd1+o23Eekt37OmoSpeDeb+Nw8sHRmKPcYbg+BmJqsNgF
 o6Ckdw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426a6mgnej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:12:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A9CsaP019788;
 Thu, 10 Oct 2024 09:12:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 426a6mgnef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:12:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A8rCGY011512;
 Thu, 10 Oct 2024 09:12:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xy166-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:12:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A9Cp9V19661072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 09:12:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 205D72004D;
 Thu, 10 Oct 2024 09:12:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDAE92004E;
 Thu, 10 Oct 2024 09:12:50 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 09:12:50 +0000 (GMT)
Message-ID: <185fb6e53fea761b13842b883bf3a46972760f12.camel@linux.ibm.com>
Subject: PING: [PATCH v2 0/5] linux-user/i386: Emulate orig_ax
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Thu, 10 Oct 2024 11:12:50 +0200
In-Reply-To: <20240912093012.402366-1-iii@linux.ibm.com>
References: <20240912093012.402366-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HuSr1XCvXT2tlz5M1OnNdGFp5ZwCTga_
X-Proofpoint-GUID: 53b734ukd5XfxL-sA6_nV9JKiR_EzFmN
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gVGh1LCAyMDI0LTA5LTEyIGF0IDExOjI4ICswMjAwLCBJbHlhIExlb3Noa2V2aWNoIHdyb3Rl
Ogo+IHYxOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDA4MDIwOTU5
NDIuMzQ1NjUtMS1paWlAbGludXguaWJtLmNvbS8KPiB2MSAtPiB2MjogTW92ZSBvcmlnX2F4IGRl
Y2xhcmF0aW9uIGhpZ2hlciwgc2ltcGxpZnkgZ2RiX3dyaXRlX3JlZygpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGZvciBUQVJHRVRfTE9OR19CSVRTID09IDMyIChSaWNoYXJkKS4KPiAKPiBIaSwKPiAK
PiBDdXJyZW50bHkgZ2Ric3R1YiBpcyBiYXJlbHkgdXNhYmxlIHdpdGggaTM4Ni1saW51eC11c2Vy
OiBHREIgY2Fubm90Cj4gZXZlbiBwYXJzZSBhIHNoYXJlZCBsaWJyYXJ5IGxpc3QsIHNvIG5vIHN5
bWJvbHMgYXJlIGF2YWlsYWJsZS4gVGhpcwo+IGJvaWxzIGRvd24gdG8gdW5hdmFpbGFiaWxpdHkg
b2YgaW5mbyBwcm9jLCB3aGljaCBpcyBnYXRlZCBiZWhpbmQKPiBvcmcuZ251LmdkYi5pMzg2Lmxp
bnV4LiBTZWUgYW1kNjRfbGludXhfaW5pdF9hYmkoKTsgaW5mbyBwcm9jIGlzCj4gZW5hYmxlZCBi
eSBhbWQ2NF9saW51eF9pbml0X2FiaV9jb21tb24oKSAtPiBsaW51eF9pbml0X2FiaSgpLgo+IAo+
IFRoaXMgc2VyaWVzIGFkZHMgb3JpZ19heCBzdXBwb3J0IHRvIHRoZSBlbXVsYXRvciBhbmQgZ2Ri
c3R1YiwgYW5kCj4gZW5hYmxlcyB0aGUgZXhpc3RpbmcgdGVzdC1wcm9jLW1hcHBpbmdzLnB5IG9u
IGkzODYuCj4gCj4gQmVzdCByZWdhcmRzLAo+IElseWEKPiAKPiBJbHlhIExlb3Noa2V2aWNoICg1
KToKPiDCoCBpbmNsdWRlL2V4ZWM6IEludHJvZHVjZSBlbnZfY3B1X2NvbnN0KCkKPiDCoCBsaW51
eC11c2VyL2kzODY6IEVtdWxhdGUgb3JpZ19heAo+IMKgIHRhcmdldC9pMzg2L2dkYnN0dWI6IEZh
Y3RvciBvdXQgZ2RiX2dldF9yZWcoKSBhbmQgZ2RiX3dyaXRlX3JlZygpCj4gwqAgdGFyZ2V0L2kz
ODYvZ2Ric3R1YjogRXhwb3NlIG9yaWdfYXgKPiDCoCB0ZXN0cy90Y2c6IFJ1biB0ZXN0LXByb2Mt
bWFwcGluZ3MucHkgb24gaTM4Ngo+IAo+IMKgY29uZmlncy90YXJnZXRzL2kzODYtbGludXgtdXNl
ci5tYWvCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstCj4gwqBjb25maWdzL3RhcmdldHMv
eDg2XzY0LWxpbnV4LXVzZXIubWFrwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstCj4gwqBnZGIt
eG1sL2kzODYtMzJiaXQtbGludXgueG1swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMTEgKysKPiDCoGdkYi14bWwvaTM4Ni02NGJpdC1saW51eC54bWzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMSArKwo+IMKgaW5jbHVkZS9leGVjL2NwdS1jb21t
b24uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEzICsrLQo+
IMKgbGludXgtdXNlci9lbGZsb2FkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICstCj4gwqBsaW51eC11c2VyL2kzODYvY3B1X2xvb3Au
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKwo+IMKgbGlu
dXgtdXNlci9xZW11LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA0ICsKPiDCoHRhcmdldC9pMzg2L2NwdS5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4g
wqB0YXJnZXQvaTM4Ni9jcHUuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgdGFyZ2V0L2kzODYvZ2Ric3R1Yi5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTAyICsrKysr
KysrKysrKysrLS0KPiAtLQo+IMKgLi4uL211bHRpYXJjaC9nZGJzdHViL3Rlc3QtcHJvYy1tYXBw
aW5ncy5wecKgwqAgfMKgIDE3ICsrLQo+IMKgMTIgZmlsZXMgY2hhbmdlZCwgMTM1IGluc2VydGlv
bnMoKyksIDM4IGRlbGV0aW9ucygtKQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGdkYi14bWwvaTM4
Ni0zMmJpdC1saW51eC54bWwKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBnZGIteG1sL2kzODYtNjRi
aXQtbGludXgueG1sCgpIaSwKCkkgd291bGQgbGlrZSB0byBwaW5nIHRoaXMgc2VyaWVzLgpQYXRj
aGVzIDEtNCBoYXZlIFItYiwgcGF0Y2ggNSBoYXMgb25seSBBLWIuCgpCZXN0IHJlZ2FyZHMsCkls
eWEK

