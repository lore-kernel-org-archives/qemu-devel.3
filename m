Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1025AE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYn0-0000re-PB; Wed, 08 Jan 2025 11:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVYmx-0000qa-4S
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:20:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVYmv-00052U-4X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:20:10 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885nWN022193;
 Wed, 8 Jan 2025 16:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CnZ3sr
 bJt0cP4JdgPxPckzOr1Y3+76fhg5za1EYESxY=; b=Z7lXZzlZB8V5FEr/MkqGcj
 PLRqYYRE0W4nsRumCuHZ4JMf4S9MYcNL3/nP++EmrI4wTntXEatZutldPiLQqVkE
 jArfuah/YdVZ0UXBMdUQzO3eAtu1Bq5Pr2/dtfP9sfYBD5Ewq/vX57V5jCmJcBpa
 CJmoAU2KKJuaOrpZgKX3VOKSh79ZNzQw3d4CZK6vmGtX8YD/2ceuI6VyYdAwIOy7
 aEBXL29tLMCKQkbF3la9UOM+Jln569uY3vhV03GffqDD/EHIt3N8+QGqZQCVO0Ba
 04y00e7aHUKnR9svEmZ1tzFGnu7sQc37x0KrdNRF1qPsxwBS+ET7mrWw/2BuVAtA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj3a7qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 16:20:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DKEax013659;
 Wed, 8 Jan 2025 16:20:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap0j7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 16:20:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508GK43C64356782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 16:20:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFA2B2004B;
 Wed,  8 Jan 2025 16:20:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5507F20040;
 Wed,  8 Jan 2025 16:20:03 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 16:20:03 +0000 (GMT)
Message-ID: <0237238565528cf7a34e180e10b0c97c5a496724.camel@linux.ibm.com>
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Wed, 08 Jan 2025 17:20:03 +0100
In-Reply-To: <87bjwhb8ou.fsf@draig.linaro.org>
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <87bjwhb8ou.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CS5YuYZur76ISOneWVGc1m63NGsbndXQ
X-Proofpoint-GUID: CS5YuYZur76ISOneWVGc1m63NGsbndXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080133
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gV2VkLCAyMDI1LTAxLTA4IGF0IDE1OjU2ICswMDAwLCBBbGV4IEJlbm7DqWUgd3JvdGU6Cj4g
SWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+IHdyaXRlczoKPiAKPiA+IEhpLAo+
ID4gCj4gPiBPbiByZXBvcnRpbmcgYSBicmVha3BvaW50IGluIGEgbm9uLW5vbi1zdG9wIG1vZGUs
IEdEQiByZW1vdGVzIG11c3QKPiA+IHN0b3AKPiA+IGFsbCB0aHJlYWRzLiBDdXJyZW50bHkgcWVt
dS11c2VyIGRvZXNuJ3QgZG8gdGhhdCwgYnJlYWtpbmcgdGhlCj4gPiBkZWJ1Z2dpbmcgc2Vzc2lv
biBmb3IgYXQgbGVhc3QgdHdvIHJlYXNvbnM6IGNvbmN1cnJlbnQgYWNjZXNzIHRvCj4gPiB0aGUK
PiA+IEdEQiBzb2NrZXQsIGFuZCBhbiBhc3NlcnRpb24gd2l0aGluIEdEQiBbMV0uCj4gPiAKPiA+
IFRoaXMgc2VyaWVzIGZpeGVzIHRoaXMgYnkgaW1wb3J0aW5nIHBhdXNlX2FsbF92Y3B1cygpIGZy
b20gcWVtdS0KPiA+IHN5c3RlbS4KPiA+IFRoaXMgaW4gdHVybiByZXF1aXJlcyBpbnRyb2R1Y2lu
ZyBCUUwgYW5kIGEgZmV3IHN0dWJzIHRvIHFlbXUtdXNlci4KPiAKPiBJcyB0aGVyZSBhIGNvbmNs
dXNpb24gdG8gdGhpcyBkZXNpZ24gY2hvaWNlPyBJJ2QgbGlrZSB0byBhdm9pZAo+IGJyaW5naW5n
Cj4gaW4gYSBidW5jaCBvZiBzeXN0ZW0tbW9kZSBpbmZyYXN0cnVjdHVyZSBpZiB0aGUgZXhpc3Rp
bmcgZXhjbHVzaXZlCj4gY29kZQo+IHdvdWxkIHdvcmsuIEZvciB0aGF0IEknbGwgZGVmZXIgdG8g
dGhlIGxpbnV4LXVzZXIgbWFpbnRhaW5lciBvcgo+IFJpY2hhcmQKPiB3aG8ga25vd3MgdGhlIGNv
ZGUgYmV0dGVyIHRoYW4gSSBkby4KCkkgd2FudGVkIHRvIHJlLWltcGxlbWVudCBwYXJraW5nIENQ
VXMgdXNpbmcgYSByZXNlcnZlZCBob3N0IHNpZ25hbC4KSSd2ZSBzdWJtaXR0ZWQgdGhlIGZvdW5k
YXRpb25zIGZvciB0aGlzIGluIFsxXSwgYW5kIEknbSBjdXJyZW50bHkKd2FpdGluZyBmb3IgdGhl
IHJldmlldy4KClsxXQpodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMjE2
MTIzNDEyLjc3NDUwLTEtaWlpQGxpbnV4LmlibS5jb20vCgo+IAo+IEkgY291bGQgY2VydGFpbmx5
IGhhcnZlc3QgdGhlIGVhcmx5IGNsZWFuLXVwIHBhdGNoZXMgdG8ga2VlcCB0aGUKPiBkZWx0YQo+
IGxvdyB3aGlsZSB0aGUgZGV0YWlscyBhcmUgd29ya2VkIG91dC4gSXMgdGhlcmUgZ29pbmcgdG8g
YmUgYSB2Mj8KCkl0IHdvdWxkIGJlIGdyZWF0IGlmIGNsZWFuLXVwIHBhdGNoZXMgY291bGQgYmUg
dGFrZW4gc2VwYXJhdGVseSwgc2luY2UKSU1ITyB0aGV5IG1ha2Ugc2Vuc2Ugb24gdGhlaXIgb3du
LiBJIHBsYW4gdG8gc2VuZCBhIHYyIGFmdGVyIFsxXSBpcwppbnRlZ3JhdGVkLgoKPiA+IEJlc3Qg
cmVnYXJkcywKPiA+IElseWEKPiA+IAo+ID4gWzFdIGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXBy
b2plY3QvcWVtdS8tL2lzc3Vlcy8yNDY1Cj4gPiAKPiA+IElseWEgTGVvc2hrZXZpY2ggKDE4KToK
PiA+IMKgIGdkYnN0dWI6IE1ha2UgZ2RiX2dldF9jaGFyKCkgc3RhdGljCj4gPiDCoCBnZGJzdHVi
OiBNb3ZlIHBoeV9tZW1vcnlfbW9kZSB0byBHREJTeXN0ZW1TdGF0ZQo+ID4gwqAgZ2Ric3R1Yjog
TW92ZSBnZGJfc3lzY2FsbF9tb2RlIHRvIEdEQlN5c2NhbGxTdGF0ZQo+ID4gwqAgZ2Ric3R1Yjog
RmFjdG9yIG91dCBnZGJfdHJ5X3N0b3AoKQo+ID4gwqAgYWNjZWwvdGNnOiBGYWN0b3Igb3V0IGNw
dV9leGVjX3VzZXIoKQo+ID4gwqAgcWVtdS10aHJlYWQ6IEludHJvZHVjZSBRRU1VX01VVEVYX0lO
SVRJQUxJWkVSCj4gPiDCoCBxZW11LXRocmVhZDogSW50cm9kdWNlIFFFTVVfQ09ORF9JTklUSUFM
SVpFUgo+ID4gwqAgcmVwbGF5OiBBZGQgcmVwbGF5X211dGV4X3tsb2NrLHVubG9ja30oKSBzdHVi
cyBmb3IgcWVtdS11c2VyCj4gPiDCoCBxZW11LXRpbWVyOiBQcm92aWRlIHFlbXVfY2xvY2tfZW5h
YmxlKCkgc3R1YiBmb3IgcWVtdS11c2VyCj4gPiDCoCBjcHU6IFVzZSBCUUwgaW4gcWVtdS11c2Vy
Cj4gPiDCoCBhY2NlbC90Y2c6IFVuaWZ5IHVzZXIgaW1wbGVtZW50YXRpb25zIG9mIHFlbXVfY3B1
X2tpY2soKQo+ID4gwqAgY3B1OiBUcmFjayBDUFVzIGV4ZWN1dGluZyBzeXNjYWxscwo+ID4gwqAg
Y3B1OiBJbXBsZW1lbnQgY3B1X3RocmVhZF9pc19pZGxlKCkgZm9yIHFlbXUtdXNlcgo+ID4gwqAg
Y3B1OiBJbnRyb2R1Y2UgY3B1X2lzX3BhdXNlZCgpCj4gPiDCoCBjcHU6IFNldCBjdXJyZW50X2Nw
dSBlYXJseSBpbiBxZW11LXVzZXIKPiA+IMKgIGNwdTogQWxsb3cgcGF1c2luZyBhbmQgcmVzdW1p
bmcgQ1BVcyBpbiBxZW11LXVzZXIKPiA+IMKgIGdkYnN0dWI6IFBhdXNlIGFsbCBDUFVzIGJlZm9y
ZSBzZW5kaW5nIHN0b3AgcmVwbGllcwo+ID4gwqAgdGVzdHMvdGNnOiBTdHJlc3MgdGVzdCB0aHJl
YWQgYnJlYWtwb2ludHMKPiA+IAo+ID4gwqBhY2NlbC90Y2cvdXNlci1leGVjLXN0dWIuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgLQo+ID4gwqBhY2NlbC90
Y2cvdXNlci1leGVjLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDU1ICsrKysrKwo+ID4gwqBic2QtdXNlci9hYXJjaDY0L3RhcmdldF9hcmNoX2Nw
dS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICstCj4gPiDCoGJzZC11c2VyL2FybS90
YXJnZXRfYXJjaF9jcHUuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICst
Cj4gPiDCoGJzZC11c2VyL2ZyZWVic2Qvb3Mtc3lzY2FsbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDEwICsKPiA+IMKgYnNkLXVzZXIvaTM4Ni90YXJnZXRfYXJjaF9jcHUu
aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+ID4gwqBic2QtdXNlci9t
YWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgOCArLQo+ID4gwqBic2QtdXNlci94ODZfNjQvdGFyZ2V0X2FyY2hfY3B1
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+ID4gwqBjcHUtY29tbW9uLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCAxNzkKPiA+ICsrKysrKysrKysrKysrKysrKwo+ID4gwqBnZGJzdHViL2dkYnN0
dWIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxNyArLQo+ID4gwqBnZGJzdHViL2ludGVybmFscy5owqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICstCj4gPiDCoGdkYnN0
dWIvc3lzY2FsbHMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMjAgKy0KPiA+IMKgZ2Ric3R1Yi9zeXN0ZW0uY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE4ICstCj4g
PiDCoGdkYnN0dWIvdXNlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI4ICsrLQo+ID4gwqBpbmNsdWRlL2V4ZWMvY3B1
LWNvbW1vbi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTUg
KysKPiA+IMKgaW5jbHVkZS9leGVjL3JlcGxheS1jb3JlLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMTMgKysKPiA+IMKgaW5jbHVkZS9ody9jb3JlL2NwdS5owqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+
ID4gwqBpbmNsdWRlL3FlbXUvdGhyZWFkLXBvc2l4LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqAgOCArCj4gPiDCoGluY2x1ZGUvcWVtdS90aHJlYWQtd2luMzIuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsKPiA+IMKgaW5jbHVk
ZS9zeXNlbXUvY3B1cy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoMKgIDYgLQo+ID4gwqBpbmNsdWRlL3N5c2VtdS9yZXBsYXkuaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMyAtLQo+ID4gwqBsaW51eC11
c2VyL2FhcmNoNjQvY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDUgKy0KPiA+IMKgbGludXgtdXNlci9hbHBoYS9jcHVfbG9vcC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKy0KPiA+IMKgbGludXgtdXNlci9hcm0vY3B1
X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSAr
LQo+ID4gwqBsaW51eC11c2VyL2hleGFnb24vY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDUgKy0KPiA+IMKgbGludXgtdXNlci9ocHBhL2NwdV9sb29wLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gPiDCoGxp
bnV4LXVzZXIvaTM4Ni9jcHVfbG9vcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNSArLQo+ID4gwqBsaW51eC11c2VyL2xvb25nYXJjaDY0L2NwdV9sb29wLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+ID4gwqBsaW51eC11c2VyL202OGsv
Y3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUg
Ky0KPiA+IMKgbGludXgtdXNlci9tYWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA5ICstCj4gPiDCoGxpbnV4LXVzZXIvbWlj
cm9ibGF6ZS9jcHVfbG9vcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+
ID4gwqBsaW51eC11c2VyL21pcHMvY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDUgKy0KPiA+IMKgbGludXgtdXNlci9vcGVucmlzYy9jcHVfbG9v
cC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKy0KPiA+IMKgbGludXgt
dXNlci9wcGMvY3B1X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgNSArLQo+ID4gwqBsaW51eC11c2VyL3Jpc2N2L2NwdV9sb29wLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQo+ID4gwqBsaW51eC11c2VyL3Mz
OTB4L2NwdV9sb29wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NSArLQo+ID4gwqBsaW51eC11c2VyL3NoNC9jcHVfbG9vcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4gPiDCoGxpbnV4LXVzZXIvc3BhcmMvY3B1
X2xvb3AuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA1ICstCj4g
PiDCoGxpbnV4LXVzZXIvc3lzY2FsbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEyICsrCj4gPiDCoGxpbnV4LXVzZXIveHRlbnNhL2NwdV9s
b29wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKy0KPiA+IMKg
cmVwbGF5L3N0dWJzLXN5c3RlbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDggKwo+ID4gwqBzdHVicy9tZXNvbi5idWlsZMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDggKwo+
ID4gwqBzdHVicy9xZW11LXRpbWVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArCj4gPiDCoHN0dWJzL3JlcGxheS1tdXRleC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEw
ICsKPiA+IMKgc3R1YnMvcmVwbGF5LXRvb2xzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4IC0KPiA+IMKgc3lzdGVtL2NwdXMuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxNzIgKy0tLS0tLS0tLS0tLS0KPiA+IC0tLQo+ID4gwqB0ZXN0cy90Y2cvbXVsdGlhcmNo
L01ha2VmaWxlLnRhcmdldMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMyArLQo+ID4gwqAuLi4v
Z2Ric3R1Yi90ZXN0LXRocmVhZC1icmVha3BvaW50LXN0cmVzcy5wecKgIHzCoCAyOCArKysKPiA+
IMKgLi4uL3RjZy9tdWx0aWFyY2gvdGhyZWFkLWJyZWFrcG9pbnQtc3RyZXNzLmPCoCB8wqAgOTIg
KysrKysrKysrCj4gPiDCoDQ5IGZpbGVzIGNoYW5nZWQsIDU1MiBpbnNlcnRpb25zKCspLCAzMjcg
ZGVsZXRpb25zKC0pCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBzdHVicy9xZW11LXRpbWVyLmMK
PiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHN0dWJzL3JlcGxheS1tdXRleC5jCj4gPiDCoGNyZWF0
ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvbXVsdGlhcmNoL2dkYnN0dWIvdGVzdC10aHJlYWQtCj4g
PiBicmVha3BvaW50LXN0cmVzcy5weQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNn
L211bHRpYXJjaC90aHJlYWQtYnJlYWtwb2ludC1zdHJlc3MuYwo+IAoK


