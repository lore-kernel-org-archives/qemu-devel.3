Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1636ACF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssm42-0000W4-8S; Mon, 23 Sep 2024 12:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1ssm3r-0008C6-1r
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:37:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1ssm3n-0002RN-SW
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:37:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N2mlcQ011766;
 Mon, 23 Sep 2024 16:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 Ka9pSNVQmHjIUyexwJHXesfqr0pJBh36w4kiIGgBMm8=; b=OVFTggYUpVi4jia9
 0r/z4yCUP8Es4atukY8vucXhx1XTl413Jm05/e1kJd8L3iTFfNHmRuV61fJ+ne1j
 kfHQUj1reR2rr+ncQruAszqO5/fKy9blXEtzzH20kAZ6kOGYN3/rRSdFLlZFfrw+
 3ytdFejkimGHIH6ddia7jj9gvovaUokp3BzU3Zf4WJfX5v18vhVJ0Xs+ZW10bbPJ
 bTfgHYVnOb2Yh8GfylaLmDjBJESfzbQz4uMj7kdM2JVvVLppKk7ub9w8Eo/fVgPl
 jr5qFnPvMwIL7K0pbuHEpWIK8YHG4LEhpKgBWSTdZPCKiPwzmWvajNC/ViFKy2XV
 13cTow==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14rnj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:37:13 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGbD7a024657;
 Mon, 23 Sep 2024 16:37:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt14rng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:37:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NE2YGK008688;
 Mon, 23 Sep 2024 16:37:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v0yny1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:37:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGbAq712255566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:37:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75F532004B;
 Mon, 23 Sep 2024 16:37:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F00AB20040;
 Mon, 23 Sep 2024 16:37:09 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:37:09 +0000 (GMT)
Message-ID: <c9b5a4f2171371d29bbbc3e61cd49c441ab0d3d6.camel@linux.ibm.com>
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Mon, 23 Sep 2024 18:37:09 +0200
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UY49uTG9QuG_S64pqryLqnUJeP-cu2S_
X-Proofpoint-GUID: 25ZUjRom1hEf4Vst9sfdO0OEABU4pNvv
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=686
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

T24gTW9uLCAyMDI0LTA5LTIzIGF0IDE4OjEyICswMjAwLCBJbHlhIExlb3Noa2V2aWNoIHdyb3Rl
Ogo+IEhpLAo+IAo+IE9uIHJlcG9ydGluZyBhIGJyZWFrcG9pbnQgaW4gYSBub24tbm9uLXN0b3Ag
bW9kZSwgR0RCIHJlbW90ZXMgbXVzdAo+IHN0b3AKPiBhbGwgdGhyZWFkcy4gQ3VycmVudGx5IHFl
bXUtdXNlciBkb2Vzbid0IGRvIHRoYXQsIGJyZWFraW5nIHRoZQo+IGRlYnVnZ2luZyBzZXNzaW9u
IGZvciBhdCBsZWFzdCB0d28gcmVhc29uczogY29uY3VycmVudCBhY2Nlc3MgdG8gdGhlCj4gR0RC
IHNvY2tldCwgYW5kIGFuIGFzc2VydGlvbiB3aXRoaW4gR0RCIFsxXS4KPiAKPiBUaGlzIHNlcmll
cyBmaXhlcyB0aGlzIGJ5IGltcG9ydGluZyBwYXVzZV9hbGxfdmNwdXMoKSBmcm9tIHFlbXUtCj4g
c3lzdGVtLgo+IFRoaXMgaW4gdHVybiByZXF1aXJlcyBpbnRyb2R1Y2luZyBCUUwgYW5kIGEgZmV3
IHN0dWJzIHRvIHFlbXUtdXNlci4KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gSWx5YQo+IAo+IFsxXSBo
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMjQ2NQo+IAo+IEls
eWEgTGVvc2hrZXZpY2ggKDE4KToKPiDCoCBnZGJzdHViOiBNYWtlIGdkYl9nZXRfY2hhcigpIHN0
YXRpYwo+IMKgIGdkYnN0dWI6IE1vdmUgcGh5X21lbW9yeV9tb2RlIHRvIEdEQlN5c3RlbVN0YXRl
Cj4gwqAgZ2Ric3R1YjogTW92ZSBnZGJfc3lzY2FsbF9tb2RlIHRvIEdEQlN5c2NhbGxTdGF0ZQo+
IMKgIGdkYnN0dWI6IEZhY3RvciBvdXQgZ2RiX3RyeV9zdG9wKCkKPiDCoCBhY2NlbC90Y2c6IEZh
Y3RvciBvdXQgY3B1X2V4ZWNfdXNlcigpCj4gwqAgcWVtdS10aHJlYWQ6IEludHJvZHVjZSBRRU1V
X01VVEVYX0lOSVRJQUxJWkVSCj4gwqAgcWVtdS10aHJlYWQ6IEludHJvZHVjZSBRRU1VX0NPTkRf
SU5JVElBTElaRVIKPiDCoCByZXBsYXk6IEFkZCByZXBsYXlfbXV0ZXhfe2xvY2ssdW5sb2NrfSgp
IHN0dWJzIGZvciBxZW11LXVzZXIKPiDCoCBxZW11LXRpbWVyOiBQcm92aWRlIHFlbXVfY2xvY2tf
ZW5hYmxlKCkgc3R1YiBmb3IgcWVtdS11c2VyCj4gwqAgY3B1OiBVc2UgQlFMIGluIHFlbXUtdXNl
cgo+IMKgIGFjY2VsL3RjZzogVW5pZnkgdXNlciBpbXBsZW1lbnRhdGlvbnMgb2YgcWVtdV9jcHVf
a2ljaygpCj4gwqAgY3B1OiBUcmFjayBDUFVzIGV4ZWN1dGluZyBzeXNjYWxscwo+IMKgIGNwdTog
SW1wbGVtZW50IGNwdV90aHJlYWRfaXNfaWRsZSgpIGZvciBxZW11LXVzZXIKPiDCoCBjcHU6IElu
dHJvZHVjZSBjcHVfaXNfcGF1c2VkKCkKPiDCoCBjcHU6IFNldCBjdXJyZW50X2NwdSBlYXJseSBp
biBxZW11LXVzZXIKPiDCoCBjcHU6IEFsbG93IHBhdXNpbmcgYW5kIHJlc3VtaW5nIENQVXMgaW4g
cWVtdS11c2VyCj4gwqAgZ2Ric3R1YjogUGF1c2UgYWxsIENQVXMgYmVmb3JlIHNlbmRpbmcgc3Rv
cCByZXBsaWVzCj4gwqAgdGVzdHMvdGNnOiBTdHJlc3MgdGVzdCB0aHJlYWQgYnJlYWtwb2ludHMK
PiAKPiDCoGFjY2VsL3RjZy91c2VyLWV4ZWMtc3R1Yi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgNCAtCj4gwqBhY2NlbC90Y2cvdXNlci1leGVjLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDU1ICsrKysrKwo+
IMKgYnNkLXVzZXIvYWFyY2g2NC90YXJnZXRfYXJjaF9jcHUuaMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgNiArLQo+IMKgYnNkLXVzZXIvYXJtL3RhcmdldF9hcmNoX2NwdS5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKy0KPiDCoGJzZC11c2VyL2ZyZWVic2Qvb3Mt
c3lzY2FsbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsKPiDCoGJz
ZC11c2VyL2kzODYvdGFyZ2V0X2FyY2hfY3B1LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDUgKy0KPiDCoGJzZC11c2VyL21haW4uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICstCj4gwqBic2QtdXNl
ci94ODZfNjQvdGFyZ2V0X2FyY2hfY3B1LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NSArLQo+IMKgY3B1LWNvbW1vbi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTc5Cj4gKysrKysrKysrKysrKysrKysr
Cj4gwqBnZGJzdHViL2dkYnN0dWIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNyArLQo+IMKgZ2Ric3R1Yi9pbnRlcm5hbHMuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NCArLQo+IMKgZ2Ric3R1Yi9zeXNjYWxscy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyMCArLQo+IMKgZ2Ric3R1Yi9zeXN0ZW0uY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDE4ICstCj4gwqBnZGJzdHViL3VzZXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyOCArKy0KPiDCoGluY2x1ZGUv
ZXhlYy9jcHUtY29tbW9uLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxNSArKwo+IMKgaW5jbHVkZS9leGVjL3JlcGxheS1jb3JlLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTMgKysKPiDCoGluY2x1ZGUvaHcvY29yZS9jcHUu
aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAx
ICsKPiDCoGluY2x1ZGUvcWVtdS90aHJlYWQtcG9zaXguaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsKPiDCoGluY2x1ZGUvcWVtdS90aHJlYWQtd2luMzIuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsKPiDCoGluY2x1ZGUv
c3lzZW11L2NwdXMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCA2IC0KPiDCoGluY2x1ZGUvc3lzZW11L3JlcGxheS5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEzIC0tCj4gwqBsaW51eC11c2VyL2Fh
cmNoNjQvY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUg
Ky0KPiDCoGxpbnV4LXVzZXIvYWxwaGEvY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gwqBsaW51eC11c2VyL2FybS9jcHVfbG9vcC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gwqBsaW51
eC11c2VyL2hleGFnb24vY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDUgKy0KPiDCoGxpbnV4LXVzZXIvaHBwYS9jcHVfbG9vcC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+IMKgbGludXgtdXNlci9pMzg2L2Nw
dV9sb29wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICst
Cj4gwqBsaW51eC11c2VyL2xvb25nYXJjaDY0L2NwdV9sb29wLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNSArLQo+IMKgbGludXgtdXNlci9tNjhrL2NwdV9sb29wLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gwqBsaW51eC11c2VyL21h
aW4uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDkgKy0KPiDCoGxpbnV4LXVzZXIvbWljcm9ibGF6ZS9jcHVfbG9vcC5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+IMKgbGludXgtdXNlci9taXBzL2NwdV9s
b29wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4g
wqBsaW51eC11c2VyL29wZW5yaXNjL2NwdV9sb29wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNSArLQo+IMKgbGludXgtdXNlci9wcGMvY3B1X2xvb3AuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+IMKgbGludXgtdXNlci9y
aXNjdi9jcHVfbG9vcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDUgKy0KPiDCoGxpbnV4LXVzZXIvczM5MHgvY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gwqBsaW51eC11c2VyL3NoNC9jcHVfbG9vcC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gwqBs
aW51eC11c2VyL3NwYXJjL2NwdV9sb29wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNSArLQo+IMKgbGludXgtdXNlci9zeXNjYWxsLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTIgKysKPiDCoGxpbnV4LXVz
ZXIveHRlbnNhL2NwdV9sb29wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDUgKy0KPiDCoHJlcGxheS9zdHVicy1zeXN0ZW0uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsKPiDCoHN0dWJzL21lc29uLmJ1aWxk
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgOCArCj4gwqBzdHVicy9xZW11LXRpbWVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArCj4gwqBzdHVicy9yZXBsYXkt
bXV0ZXguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxMCArCj4gwqBzdHVicy9yZXBsYXktdG9vbHMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDggLQo+IMKgc3lzdGVtL2NwdXMuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxNzIgKy0tLS0tLS0tLS0tLS0tLQo+IC0KPiDCoHRlc3RzL3RjZy9tdWx0aWFyY2gv
TWFrZWZpbGUudGFyZ2V0wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEzICstCj4gwqAuLi4vZ2Ri
c3R1Yi90ZXN0LXRocmVhZC1icmVha3BvaW50LXN0cmVzcy5wecKgIHzCoCAyOCArKysKPiDCoC4u
Li90Y2cvbXVsdGlhcmNoL3RocmVhZC1icmVha3BvaW50LXN0cmVzcy5jwqAgfMKgIDkyICsrKysr
KysrKwo+IMKgNDkgZmlsZXMgY2hhbmdlZCwgNTUyIGluc2VydGlvbnMoKyksIDMyNyBkZWxldGlv
bnMoLSkKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBzdHVicy9xZW11LXRpbWVyLmMKPiDCoGNyZWF0
ZSBtb2RlIDEwMDY0NCBzdHVicy9yZXBsYXktbXV0ZXguYwo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3RjZy9tdWx0aWFyY2gvZ2Ric3R1Yi90ZXN0LXRocmVhZC0KPiBicmVha3BvaW50LXN0
cmVzcy5weQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9tdWx0aWFyY2gvdGhyZWFk
LWJyZWFrcG9pbnQtc3RyZXNzLmMKCkNvcnJlY3Rpb246IHRoZSBzdWJqZWN0IHNob3VsZCBoYXZl
ICJxZW11LXVzZXIiIGluc3RlYWQgb2YgInFlbXUtY3B1Ii4K

