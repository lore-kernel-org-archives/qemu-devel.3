Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE30C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 18:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roozB-0005kl-Vt; Mon, 25 Mar 2024 14:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rooz6-0005kD-Vi; Mon, 25 Mar 2024 14:23:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rooz5-0005tQ-9Z; Mon, 25 Mar 2024 14:23:48 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PGxWGt025788; Mon, 25 Mar 2024 18:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kt+WZGl+8Rmzq/QAJ7IKvGc+u63cp7OXfFulUaP3cqU=;
 b=KluLvKWso+u46XDVZQ0/eHXE2OMvBRIvGKzETiYPPrBAm4V8c6nacV0XCuPPNMY4a8tu
 IhmIEyCpjqoj3w/DwOYOlYKGZUb4lz7nLFNvC2Cy1TuqZ6bVCLSGgOgPkLcOh7Ju6xFC
 CL5M6xBqQKStaorGsXCjutJ+YUItR4e3XPIb5TUngo2F0YH2/hW9oChRycEV/tM8eyks
 0z5WHZ9/S1XrtbxYdUjVou5RE+peh2dBg0pmOM95jr3/7QhQRl10Khp/H8/BPjuYWgyr
 VUKQM61+eUYHR+6HE1Gz24H0UsZ6zMUyYDwFF2CsLN3A7713wOPxoeFszyp2mabDYnow lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3d8u06bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 18:23:43 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PINgxd029119;
 Mon, 25 Mar 2024 18:23:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3d8u06b8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 18:23:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PHARqZ028620; Mon, 25 Mar 2024 18:23:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp2wuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 18:23:42 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PINdV256820142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 18:23:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EF2658068;
 Mon, 25 Mar 2024 18:23:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28D2358069;
 Mon, 25 Mar 2024 18:23:38 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.34.64]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 18:23:38 +0000 (GMT)
Message-ID: <25acfa771509675ff6924393897fa648c0cd72af.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/s390x: Include missing 'cpu.h' header
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Date: Mon, 25 Mar 2024 14:23:37 -0400
In-Reply-To: <20240322162822.7391-1-philmd@linaro.org>
References: <20240322162822.7391-1-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V1VfundV1ZUn2kEk22OMx07VY_-1_Xni
X-Proofpoint-ORIG-GUID: 4QkaDsJ0jMEJh87l3EnQiPIpARlA3TzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_16,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=910 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDE3OjI4ICswMTAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToKPiAiY3B1LmgiIGlzIGltcGxpY2l0bHkgaW5jbHVkZWQuIEluY2x1ZGUgaXQgZXhw
bGljaXRseSB0bwo+IGF2b2lkIHRoZSBmb2xsb3dpbmcgZXJyb3Igd2hlbiByZWZhY3RvcmluZyBo
ZWFkZXJzOgo+IAo+IMKgIGh3L3MzOTB4L3MzOTAtc3RhdHRyaWIuYzo4Njo0MDogZXJyb3I6IHVz
ZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIKPiAnVEFSR0VUX1BBR0VfU0laRScKPiDCoMKgwqDC
oMKgIGxlbiA9IHNhYy0+cGVla19zdGF0dHIoc2FzLCBhZGRyIC8gVEFSR0VUX1BBR0VfU0laRSwg
YnVmbGVuLAo+IHZhbHMpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF4KPiDCoCBody9zMzkw
eC9zMzkwLXN0YXR0cmliLmM6OTQ6NTg6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlm
aWVyCj4gJ1RBUkdFVF9QQUdFX01BU0snCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhZGRyIC8gVEFSR0VUX1BBR0VfU0laRSwgbGVuLCBhZGRyICYKPiB+VEFSR0VU
X1BBR0VfTUFTSyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBeCj4gwqAgaHcvczM5MHgvczM5MC1zdGF0dHJpYi5jOjIyNDo0MDogZXJy
b3I6IHVzZSBvZiB1bmRlY2xhcmVkCj4gaWRlbnRpZmllciAnVEFSR0VUX1BBR0VfQklUUycKPiDC
oMKgwqDCoMKgwqDCoMKgwqAgcWVtdV9wdXRfYmU2NChmLCAoc3RhcnRfZ2ZuIDw8IFRBUkdFVF9Q
QUdFX0JJVFMpIHwKPiBTVEFUVFJfRkxBR19NT1JFKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBeCj4gwqAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGh3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5j
OjE3Ogo+IMKgIGh3L3MzOTB4L3MzOTAtdmlydGlvLWhjYWxsLmg6MjI6Mjc6IGVycm9yOiB1bmtu
b3duIHR5cGUgbmFtZQo+ICdDUFVTMzkwWFN0YXRlJwo+IMKgIGludCBzMzkwX3ZpcnRpb19oeXBl
cmNhbGwoQ1BVUzM5MFhTdGF0ZSAqZW52KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KPiAtLS0KPiDCoGh3L3MzOTB4L3Mz
OTAtdmlydGlvLWhjYWxsLmggfCAyICsrCj4gwqBody9zMzkweC9zMzkwLXN0YXR0cmliLmPCoMKg
wqDCoCB8IDEgKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKClRoZXNlIGFy
ZW4ndCB0aGUgb25seSBpbXBsaWNpdCB1c2VycyBvZiBjcHUuaCBpbiBody9zMzkweC8gYnV0IGlm
IHRoaXMKc29sdmVzIG9uZSBwcm9ibGVtLCB0aGVuIHRoYXQncyBnb29kLgoKQWNrZWQtYnk6IEVy
aWMgRmFybWFuIDxmYXJtYW5AbGludXguaWJtLmNvbT4K


