Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854ACC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weqVn-0000rJ-8S; Wed, 01 Jul 2026 04:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weqVg-0000qG-Un; Wed, 01 Jul 2026 04:41:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weqVc-0008Ud-2k; Wed, 01 Jul 2026 04:41:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6618IrI8195455; Wed, 1 Jul 2026 08:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hmhty5
 /4biwvmUDqRXBuLPtRgvVRow+cjNFCtObiWd4=; b=n9nxevcFBhBkivL7LZOcyp
 YlJ0ZTrQuQwxGd/2tEXXjLMwc5+tYpGw2z2i4BflgqS8GRNECjSnr+j6aT/Gwxsz
 GijH87bik+55mCFqdkgkFqgItgoDG81o/1Zpj4T/cxwI7mYicJPM0q1BMjtVB+ie
 R3PJx3kaJvkhUhpFRahKEvO7OC6czVS7UeN+qMdSWltTPqc1ok0CGjczbSskrhEg
 FrjeWgxktNsuoch6xNMsaxT6+uqn5rWvsvHkH5pN+KC4/bTTr+eg8bUtvv1v1Rc4
 SxxYDL14qa4jXQ4On/pE5a57siNC6CeaRccyqoU8QVItgHdxZIIosEPw7Xybk8vg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mju5xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 08:41:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YhqB017226;
 Wed, 1 Jul 2026 08:41:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqemkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 08:41:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6618fKee30016014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 08:41:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 283D02004B;
 Wed,  1 Jul 2026 08:41:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 310D320040;
 Wed,  1 Jul 2026 08:41:19 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 08:41:18 +0000 (GMT)
Message-ID: <ea947f1ec44ed4b513545ae1d5be1fc455233064.camel@linux.ibm.com>
Subject: Re: [PATCH 17/17] cpu: Use interval-tree for CPUBreakpoint
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Date: Wed, 01 Jul 2026 14:11:18 +0530
In-Reply-To: <20260701030443.1382447-18-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX/EIIr5GMkDOt
 u7AGW/OGc3anShRmf0qlHaP+TooZCvszQ1KTN70Kkj0jrpC40Z67G8rj60v/4nrT9r7t/qczq9K
 C8Qx46X4VxrYZ93G5HNTPWVfHujpQxwMTv1LiLyob621s4fthZpWqiVJAQaj70oN0eRJVQnRdgl
 LwAJf4xUJNO8WT35QvYarG5dTWRwDf2o4wxywcHUeSjDPhdmSeo5FmvF0cwR0SaECKxOvbvzaL2
 rYbpEMwcKWR92adxgDhBdOkrRbcy8PLhbD9E80WZeevZW4JXL7PhogaX4VtmApNKFA/x5E8onfD
 Fyma3kWALWnFTx6iRi8QcBvhB/7tzFjf2nOiRSCu9rRUz2924tXay1mjVTesX6mbAyNfpqr8XGn
 hxifgRZ7VQTraib3YMSn76/HDnRgfZq1Q62uz7wPB/uL6HUyaHjtgannECO598RzHbdqPrn0FRY
 z2UvVjFFiZX+x3jl82Q==
X-Proofpoint-GUID: QbfCVw2IhVtcfXqOvHQF8n1N7EGihEPQ
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a44d2b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=l4yQKMJeipP3SqVgYxcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX0AMMUIJGbsFV
 SHixAF4JsiFZF5VUmJfkqmI91xPMgUjk6Ft3eYclxmwQ56dLxg0/g2/TLUasAdRi6doVGVhzwah
 4wQaaYv40sH+UzyjFcLavgqtcczZmkM=
X-Proofpoint-ORIG-GUID: QbfCVw2IhVtcfXqOvHQF8n1N7EGihEPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

T24gVHVlLCAyMDI2LTA2LTMwIGF0IDIwOjA0IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToKPiAtwqDCoMKgIGlmIChtYXRjaF9wYWdlKSB7Cj4gK8KgwqDCoCBuID0gaW50ZXJ2YWxfdHJl
ZV9pdGVyX2ZpcnN0KCZjcHUtPmJyZWFrcG9pbnRzLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjICYgVEFSR0VUX1BB
R0VfTUFTSywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwYyB8IH5UQVJHRVRfUEFHRV9NQVNLKTsKPiArwqDCoMKgIGlm
IChuKSB7ClRoaXMgbG9naWMgc2VlbXMgZ3JlYXQuIEkgdGVzdGVkIHRoaXMgcGF0Y2ggc2VyaWVz
LCBvbiB0aGUgcHBjIGtlcm5lbApicmVha3BvaW50cyB1c2VjYXNlLiBJdCBzZWVtcyB0byBwZXJm
b3JtIHNsaWdodGx5IGJldHRlciB0aGFuIEdUcmVlCmltcGxlbWVudGF0aW9uLgoKTWF5YmUgdGhp
cyBjYW4gb3BlbiB0aGUgd2F5IHRvIGhhdmUgYGJyZWFrLXJhbmdlYCBzdXBwb3J0IGZyb20gZ2Ri
PwoKVGhhbmtzCn5TaGl2YW5nCg==


