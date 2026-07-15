Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA3EC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk0oE-00038R-6u; Wed, 15 Jul 2026 10:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wk0oB-00038A-Fk; Wed, 15 Jul 2026 10:41:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wk0o9-00035m-TH; Wed, 15 Jul 2026 10:41:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FEBcMg2697995; Wed, 15 Jul 2026 14:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MXXHjb
 oYNX0R9Lj+Tz31cHiQ7DadrPTYokAh/2UcgrM=; b=AY/9SiBb4HXqEUeaqqHKVA
 zmL8FQQgZtgOz7ceJff4GuWbODoip4AsSQAFIH1cuADTbyUMOs00pZQ9Q1nuthCb
 A7u9E3wStW0PtkFuo19hMphgggdHcl3sEwrS8N5RBntjFhn/DD0mfXHRkDnHtbIv
 9GHjLmNCaVfkOBDWYkJ+XyXtmIKUQS24UPBTsft4AIw82S62YbxCmk6lbgoeTalU
 2YeRWsQke7zm1akLtwUo7GDLcxkF5hrvzSMu/2sS9/YnUFzeLWpnkcxc0t8AtzYh
 nsiUm93y8Z3zw5Pu6FpKJ9SrSCBVVIv2YSDJWIC7L6f8aZ4u5OvGavGnKkX/Ungg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33cm7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 14:41:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FEYfxH022107;
 Wed, 15 Jul 2026 14:41:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k0fga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 14:41:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FEfnDH31392288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 14:41:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E16420043;
 Wed, 15 Jul 2026 14:41:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C711D20040;
 Wed, 15 Jul 2026 14:41:46 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.31.84])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 14:41:46 +0000 (GMT)
Message-ID: <a2fde2b73930cfe5e555da8660598dc464c72127.camel@linux.ibm.com>
Subject: Re: [PATCH 6/7] target/ppc: Reorder PPC2 flags
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, milesg@linux.ibm.com
Date: Wed, 15 Jul 2026 20:11:45 +0530
In-Reply-To: <20260715125634.2107320-7-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-7-rathc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0NiBTYWx0ZWRfX2HX9n9TWw4gu
 7H2nU+Q5Mh3vVDMiirnfXBTyNTlltrWVNsfkloKHFg/h0807u0MF1KpvaxS13tSoDMD0dOmW20t
 Tz1GsMKgPClEJ6ospcSGpk5rPLSjrEY=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a579c33 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=mh3y59ApBgj6EL45U_8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1VtYC7PRbrOkyhd2we7ZEUEkUhTU0nxp
X-Proofpoint-ORIG-GUID: xN8SnrWKOdVEaspG7m0nm-TfYVFQmLzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0NiBTYWx0ZWRfX6UvRLLp+W90t
 Ft/IskqEKKwbhROsSh5DvPLQa8CvhDKkA7XvUtbP3QcyGTZ362WNuKXHmcXjhbqhGZwyNq4wCgl
 OvcWAT2Y8FhYZRxk4g1NfIKGSuivs9KVddkHaEJzioV9tvjDbP9jcXI5NbNDYRMfXFlwAz+4KVt
 3VUF902nvYOdjhSH2Ab99iyT2nRrIf7slN2xY+5NF5mxvuzX48Fs4UOgsicOdVBjYtXIrx8zlZ9
 YZBN7fGKeBlOgNCFI68NJjeygrt0IlSui+r4+0Y1CeK8H8x84/UfrX1yYryox5YmYLPpgSN+FVw
 BDn9JAaQ1qa3MRtGu77G+ezv42g6x8VQQDSRfCeZnwUrEPa4xYZtyG387zmsZUXitP836ksz5NJ
 pDEvxjHFEqfPjHt9yBwohASp8GHuFHDXn6fwh8btRGT0KkDU4bLrLhaZjnV22eLtaf7vBi30qYb
 gctcSq+vO0DMw2+Dsvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150146
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDE4OjI2ICswNTMwLCBDaGlubWF5IFJhdGggd3JvdGU6Cj4g
K8KgwqDCoCBQUEMyX0JDREFfSVNBMjA2wqDCoCA9IDB4MDAwMDAwMDAwMDA0MDAwMFVMTCwKPiDC
oMKgwqDCoCAvKiBQUEU0Mgo+IGluc3RydWN0aW9uc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqAgUFBDMl9QUEU0MsKgwqDCoMKgwqDCoMKg
wqAgPSAweDAwMDAwMDAwMDA4MDAwMDBVTEwsCj4gK8KgwqDCoCBQUEMyX1BQRTQywqDCoMKgwqDC
oMKgwqDCoCA9IDB4MDAwMDAwMDAwMDA4MDAwMFVMTCwKPiDCoMKgwqDCoCAvKiBQUEU0MlgKPiBp
bnN0cnVjdGlvbnPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICov
Cj4gLcKgwqDCoCBQUEMyX1BQRTQyWMKgwqDCoMKgwqDCoMKgID0gMHgwMDAwMDAwMDAxMDAwMDAw
VUxMLAo+ICvCoMKgwqAgUFBDMl9QUEU0MljCoMKgwqDCoMKgwqDCoCA9IDB4MDAwMDAwMDAwMDEw
MDAwMFVMTCwKPiDCoMKgwqDCoCAvKiBQUEU0MlhNCj4gaW5zdHJ1Y3Rpb25zwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgIFBQQzJfUFBFNDJYTcKg
wqDCoMKgwqDCoCA9IDB4MDAwMDAwMDAwMjAwMDAwMFVMTCwKPiArwqDCoMKgIFBQQzJfUFBFNDJY
TcKgwqDCoMKgwqDCoCA9IDB4MDAwMDAwMDAwMDIwMDAwMFVMTCwKPiDCoAoKSGkgQ2hpbm1heSwg
CgogV291bGQgaXQgYmUgZmluZSBpZiB3ZSBjYW4gZG8gc29tZXRoaW5nIGxpa2UgdGhpcyBpbnN0
ZWFkPwoKUFBDMl9QUEU0MlhNICA9ICgxdWxsIDw8IDIxKTsKCkl0IHdvdWxkIGJlIGVhc3kgdG8g
c2VlIHdoZXJlIHRoZSBnYXBzIGFyZSBmcm9tIG5leHQgdGltZS4KCn5TaGl2YW5nLiAKCg==


