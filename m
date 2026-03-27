Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38BC10ED651
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w64JM-0006Ce-VO; Fri, 27 Mar 2026 06:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w64JK-0006BR-O4; Fri, 27 Mar 2026 06:21:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w64JJ-0002c3-6P; Fri, 27 Mar 2026 06:21:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6GvoZ510428; Fri, 27 Mar 2026 10:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1wr9iW
 PaDdD7PBEK7DiA6LmiNb5NYDtx5163hls7N0s=; b=TRORcBL6sMAoACspQ9UIov
 lKyh/mIw2Ja7BM81QkqeZk3kpUgoYNhIjJMJCbWrYGz5tiAaPyCabgSH8486OIMB
 cZKco1DglQ1kjoSqKbSMk0VyozCmYQqIF1K5DSOQM1zrs7uxGzqrAaUXo1NkmBF4
 pBcCySKriZdnhrFO/mn1VBPSBtQRGyESRQyOIif0NehKK01NysEenGWqy9jfyB1x
 pJlsDMj96jEF/PtYdw09ShqWWuZPl/421724bBD8ZecOqcs5o0N1/FA8U/2X/glb
 JXW6QHpW5Cf2CRd0sHCwHA2UL7CVmScpW0N5Gwd9UTqaqWw0CveZY6xQ4lCv1s6g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa9mra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 10:20:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R6U77d008745;
 Fri, 27 Mar 2026 10:20:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nny2n6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 10:20:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RAKc5w25101020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 10:20:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33B7920040;
 Fri, 27 Mar 2026 10:20:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EEC020043;
 Fri, 27 Mar 2026 10:20:35 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.30.68])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 10:20:35 +0000 (GMT)
Message-ID: <347e3900187b5ab05fc32307ff8a40fc631708a3.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/pnv: generate dtb after machine initialization is
 complete
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>, BALATON
 Zoltan	 <balaton@eik.bme.hu>, qemu-stable@nongnu.org, Nathan Chancellor	
 <nathan@kernel.org>, Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 15:50:34 +0530
In-Reply-To: <acUTurZoQJf8jRhJ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260324135026.247418-1-shivangu@linux.ibm.com>
 <acUTurZoQJf8jRhJ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: NE0s5iVH7CpjnTNmEAvUKwoi1rMqw13S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3NSBTYWx0ZWRfXxwfbqzOOiCwd
 xxpwNmwAtDrysvOo6IimX5HoJHjxIj/jm2ieV1Y1KwwXbeq92bJhChEX7ZlQyXyd8WPU5T7rv9a
 +Teha5mcYTKGQWRk6b9KURN00tDAdYcH2tNlDCBDLIBrflaM+aOapJ+LZY9Zla8VK+Xxxv7nmoI
 v9mJnXn/4+zxiy9g19+aL85E+trnMPaJwh2OXeSr+Na0g4/BVh6aJ3NhGXE1KkpdOofJkyC5GLB
 dfEmLyAsqQtC1h9O5Hij4cxPZtxWU5ymDNGBZoR0tOdvga8zWBitmg1d4cYEdr0+YwOElH0jTlQ
 p6kT42J80iKgk4uTXq7ZmaH1YNbEhweeOTe7WL2WrGwq+CR0cTAu4hLYr1fzEOqCWMza0xpZwXs
 Ya2ubVFhfVK6gP23VyTaEKdE7xoNbmNTLvjZpkM9Pr1RZdIa+Ak7tzseJUTtj3s2PlLRqlUw3BC
 rgOx8vwVAHZn1XzLHTg==
X-Proofpoint-GUID: 140Q1T9y7Zck5mPflh-Eiqna_JZ3BJGd
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c659fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=GZB6G2VIWCd0oaCZ0iAA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270075
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gVGh1LCAyMDI2LTAzLTI2IGF0IDE2OjQ2ICswNTMwLCBBZGl0eWEgR3VwdGEgd3JvdGU6Cj4g
Cj4gQnV0IHN0aWxsIHRoZSBkdHMgd2UgaGF2ZSBpcyBkaWZmZXJlbnQgZnJvbSB3aGF0IHdlIHNo
b3VsZCBoYXZlIGF0Cj4gcG52X3Jlc2V0LiBBZGRpbmcgYSBwbnZfZHRfY3JlYXRlIGF0IHRoZSBl
bmQgb2YgcG52X3Jlc2V0LCBhcyBpdCB1c2VkCj4gdG8KPiBiZSBiZWZvcmUsIGdpdmVzIG1lIGEg
J2JtYycgbm9kZSBhbHNvIGluIGRldmljZSB0cmVlLgo+IAo+IAkkIGRpZmYgL3RtcC9kdHMubWFj
aGluZWRvbmUgL3RtcC9kdHMucG52cmVzZXQgCj4gCTE2YTE3LDMzCj4gCT7CoMKgwqDCoMKgwqAg
Ym1jIHsKPiAJPiAKPiAJPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2Vuc29ycyB7Cj4g
CT7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxs
cyA9IDwweDAwPjsKPiAJPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICNhZGRyZXNzLWNlbGxzID0gPDB4MDE+Owo+IAk+IAo+IAk+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2Vuc29yQDAgewo+IAk+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlwbWktc2Vuc29y
LXR5cGUgPSA8MHgyMz47Cj4gCT7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXBtaS1lbnRpdHktaW5zdGFuY2UgPQo+IDwweDAxPjsK
PiAJPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpcG1pLWVudGl0eS1pZCA9IDwweDIzPjsKPiAJPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpcG1pLXNlbnNvci1yZWFk
aW5nLXR5cGUgPQo+IDwweDZmPjsKPiAJPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImlibSxpcG1pLQo+IHNl
bnNvciI7Cj4gCT7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MDA+Owo+IAk+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiAJPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsKPiAJPsKgwqDCoMKgwqDCoCB9Owo+IAk+IAo+IAo+IFRoaXMgaXNuJ3QgaGFuZGxlZCBhdCBt
YWNoaW5lX2luaXRfZG9uZSBhcyAncG52LT5ibWMnIGlzIG5vdCBzZXQgYXQKPiB0aGlzCj4gdGlt
ZQo+IApZZWEsIHRoYXQgc2VlbXMgbGlrZSBhIGJ1Zy4gVGhhbmtzIGZvciBjaGVja2luZyB0aGlz
LiBJIHRoaW5rLCBpbGwgbW92ZQp0aGUgcG52LT5ibWMgaW5pdGlhbGl6YXRpb24gdG8gbWFjaGlu
ZV9pbml0X2RvbmUgYWxzby4gQW5kIHNlbmQgYSB2Mi4KCgp+U2hpdmFuZy4K


