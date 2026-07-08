Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2D0C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSs1-0003eB-Se; Wed, 08 Jul 2026 10:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1whSrz-0003dX-6I; Wed, 08 Jul 2026 10:03:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1whSrx-0003nJ-IL; Wed, 08 Jul 2026 10:03:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668CJFa72337005; Wed, 8 Jul 2026 14:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=I4IxKfqA01T+234O01+LQi8/m6ecoOkJixZfwnuqWyY=; b=Y5frSsaeMDfs
 bxZnbM2TxAP0U5hXI6rtxzyoYjx1ExifFopy6Ab91JTrCu5tGfOd+dLfTWuroPPJ
 yPyxjUIDvpz8O5+YZV0/q1Ed8PEvR+AkKCtDR74SwJxp4ZWFZ/sA4Yq07qY9TsD+
 9t0xN0ckZpaj1hJjEWJ8Gm84FW+GTNexktPIyoWxVlqiK6v8Xb0elg/Uh7rlHfWn
 QUmKCMMa17MDy7CN6r3Kv2Czy/hrM6tEIU1ayc0cfK30VgTFt1PNewaBdr8jh+uK
 gLzIpQcgi32OR3PCwcNEodlNlEcrVL+9g/kUzpyfEl1AxKErCEPvCpV8mUAXg4XI
 Y9KKwiyBTg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsw2yr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 14:03:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668DnbcR005577;
 Wed, 8 Jul 2026 14:03:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw8fac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 14:03:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668E3DIX58392902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 14:03:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0161E5804B;
 Wed,  8 Jul 2026 14:03:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6078E58066;
 Wed,  8 Jul 2026 14:03:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 14:03:11 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 08 Jul 2026 16:03:10 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com,
 qemu-stable <qemu-stable@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud?=
 =?UTF-8?Q?=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v11 01/21] target/s390x: Fix wrong address handling in
 address loops
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <d5436f34-5489-4335-bf83-74b924e04140@tls.msk.ru>
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-2-freude@linux.ibm.com>
 <3e31b38c-0561-4f37-b2c4-97c10e6f232f@tls.msk.ru>
 <d5436f34-5489-4335-bf83-74b924e04140@tls.msk.ru>
Message-ID: <a38386d1eb7c0809e62a4e3399f8ea0e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nS-CXDA6uRN6KE0nJe9hK-afP3wOClZO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzNSBTYWx0ZWRfX7ShiCEucEmvr
 wSsD5W9PkGQzl+hOd6EHPNmgg24qTAM1OkBY4QQEoADe1wvQRmR1hkdH/p1nHEO+qbramthoJg3
 /m2oKdoXw+HOjYTUJNNafENmmG3GGms=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e58a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=jEcIRefS23jSGVE7dd0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nS-CXDA6uRN6KE0nJe9hK-afP3wOClZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzNSBTYWx0ZWRfX+v+q7Q3jnjTL
 O/zGQKu89ZTwR4J0xpyJIGFK5JTSlONx9CDgdKPQ9lzworChpkzqB6QHEb1Ap5xSJMkuNAL6Zyf
 4mBmKNco6gwjfyu0ZSXc7bfh9CrF/RpUOOK+Fy7kyZqtzSWD6w6inYSMGZrXOfvoMTddf1lX0bm
 gDAflEX4i4KqIzuZ8GrPJ3gSj/Wj+lbP3kMhshPLUeir0Fl7dOHg2FM5dJV3lC3LQ4s7IsJGED0
 MIcPFT7HLfaxAKF69NwDT+WW0QbnT1nHxtdhTSwkhVBnykDCxQE2+kzL8vQcwAJgRf+XrEpB3Dz
 yD6sSmCP8wHObu0k7iB+KxQm8/1Rwtf/FEl5wFDxjJxrWjuDEsRKbrL83ryAaPhn3bAS6fyH68g
 GVdFh6/pLbe1s3uCWzqTdTJ7Awfk/VWvfXKblTaaBVEGIZIqZoHGMltr+r+lzMWfu1JNZ9zTZ4i
 JKU5zrN5onjEF8QcTdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-07-08 13:18, Michael Tokarev wrote:
> On 08.07.2026 13:37, Michael Tokarev wrote:
>> On 07.07.2026 19:17, Harald Freudenberger wrote:
>>> The loop increments addr by the element stride (+= 4) before calling
>>> wrap_address, but then overwrites the loop addr with the wrapped
>>> value. On the next iteration the stride is applied to the wrapped
>>> address of the previous element, not to the original unwrapped
>>> address. This results in every element after the first is read from a
>>> wrong (wrapped) address.
>>> 
>>> Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>   target/s390x/tcg/crypto_helper.c | 12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>> 
>> This feels like qemu-stable material.
>> I'm picking this change up for currently active stable qemu series.
>> Please let me know if I shouldn't.
> 
> Um, this was a bit premature.
> 
> This particular commit requires a previous commit in this area,
> de96db79 "target/s390x: Compile crypto_helper.c as common unit".
> It's easy to back-port across, but since this change ("Fix wrong
> address handling...") hasn't been marked as for-stable, I'm *not*
> doing that.  If this change is actually needed in -stable, please
> let me know.  Also, is it okay to pick up the previous change
> ("compile as common unit") to -stable too, to avoid fixing up
> subsequent changes.
> 
> Thanks,
> 
> /mjt

Fine with me. However, Connie replied to my v10 series that she
wants to pick this patch. However, it is yet not on the qemu
master branch.

