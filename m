Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E56CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTiK-0002G5-Vs; Wed, 08 Jul 2026 10:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1whTiJ-00029P-BB; Wed, 08 Jul 2026 10:57:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1whTiH-0002q2-Nm; Wed, 08 Jul 2026 10:57:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668CIFBL3748051; Wed, 8 Jul 2026 14:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=edffyY4BVBzPyErgozeepHL7BRVr1M7UBTLXj0fNOl0=; b=iP52u5arLmJf
 rjb+srLFR+eEKaqb2W2BzvzXHVwwJsqwpdn/1TPAW7F7EIRezQVjohpseW6TFr/g
 fyoezr3DjCzCdyxV7+fquTHnQs8BMoBy/rObRb/vBo2iq9yImeOuyHXFI3gmeJBt
 W3PvKA1lv7NjlVXEdkXjvnar7qy/VG4oUXsS5uXxDcRNGxYY+IU4BHojcVHoB2KB
 tARL4yEoCiEjMgGdt/hfQEdMZz2Vf1loz2uiEFbb+i+X7zk5rlyiYH8HZQL9Qwl8
 wjR037RKG+xPb7PJcdZ+1jfW+cJr0I9chG286eBBDpsQw8r8RAlF2yFlVcsKXTpX
 3pv1q+vvbQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqvp6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 14:57:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668EYhtR000722;
 Wed, 8 Jul 2026 14:57:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg89rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 14:57:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668EvJnb33424088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 14:57:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15E985805B;
 Wed,  8 Jul 2026 14:57:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD2B058058;
 Wed,  8 Jul 2026 14:57:17 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 14:57:17 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 08 Jul 2026 16:57:17 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com,
 qemu-stable <qemu-stable@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud?=
 =?UTF-8?Q?=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v11 01/21] target/s390x: Fix wrong address handling in
 address loops
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <87zf01in2z.fsf@redhat.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-2-freude@linux.ibm.com>
 <3e31b38c-0561-4f37-b2c4-97c10e6f232f@tls.msk.ru>
 <d5436f34-5489-4335-bf83-74b924e04140@tls.msk.ru>
 <a38386d1eb7c0809e62a4e3399f8ea0e@linux.ibm.com> <87zf01in2z.fsf@redhat.com>
Message-ID: <cbd3f1f1757c0b7740c20cecefc8ccfd@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0NiBTYWx0ZWRfXzYC1ynE9a3S8
 L9lPqWbAfN5M7vEm7NL3Wet89ckVnzhUu0/sZJ2apgrdSODQg0KXLXxXRtx102/dS5OT6ngc2m5
 /O2SkK7lrL+1RLtpCNhElF8ye6KffhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0NiBTYWx0ZWRfX+qmtPtVO/hba
 oH8pVRDGFa0FEn8+3fFZC07TV/MQdejsjXE635DnUI8hE4VvexmwLWJV6f7j4LmXlY3YtTO3F/2
 uido9Z3xY4x5LbYoKu7nRsg+RCJfJ+pn+RemNoFQ3hcf+N+yB9C+xu0ziNVUGWx3EMMHjznZScJ
 BhAjZEil7A9TUg+RX7Eyo+IDd/62OL6A8r+Z8u+eBDVMfSyZlhp0DhakQy276Ct/zJ22cOIGyzp
 Dg079g1M8+m8m/09MNDv8vkUZbLQfTXRlTb8S2hxBKlFkNyBS+JyBZNfK9sj/aEby+H1o38bZZD
 RQtyynU0TmRo1DWbMw40v/JzxOQ5oJFCjsuCYDwFVIYP81ncUr6KM69WKO1M+dvl1qd6DVUlC08
 UNEB4LhNny6VExRIhljCwwbrxkWqCOEgYIxvGtsZW9XPWqcAD1Hbpv9D09/+8X4FyajmA/RVDJL
 +0MTGPAwXjLFdYSUUqg==
X-Proofpoint-GUID: _EoQ-jtAyxmpSdE_E8QgQCFwXOH_W0eR
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4e6551 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=iL7ffvFh4Ipb49WVzmgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _EoQ-jtAyxmpSdE_E8QgQCFwXOH_W0eR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 2026-07-08 16:16, Cornelia Huck wrote:
> On Wed, Jul 08 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> On 2026-07-08 13:18, Michael Tokarev wrote:
>>> On 08.07.2026 13:37, Michael Tokarev wrote:
>>>> On 07.07.2026 19:17, Harald Freudenberger wrote:
>>>>> The loop increments addr by the element stride (+= 4) before 
>>>>> calling
>>>>> wrap_address, but then overwrites the loop addr with the wrapped
>>>>> value. On the next iteration the stride is applied to the wrapped
>>>>> address of the previous element, not to the original unwrapped
>>>>> address. This results in every element after the first is read from 
>>>>> a
>>>>> wrong (wrapped) address.
>>>>> 
>>>>> Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
>>>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>>>> ---
>>>>>   target/s390x/tcg/crypto_helper.c | 12 ++++--------
>>>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>> 
>>>> This feels like qemu-stable material.
>>>> I'm picking this change up for currently active stable qemu series.
>>>> Please let me know if I shouldn't.
>>> 
>>> Um, this was a bit premature.
>>> 
>>> This particular commit requires a previous commit in this area,
>>> de96db79 "target/s390x: Compile crypto_helper.c as common unit".
>>> It's easy to back-port across, but since this change ("Fix wrong
>>> address handling...") hasn't been marked as for-stable, I'm *not*
>>> doing that.  If this change is actually needed in -stable, please
>>> let me know.  Also, is it okay to pick up the previous change
>>> ("compile as common unit") to -stable too, to avoid fixing up
>>> subsequent changes.
>>> 
>>> Thanks,
>>> 
>>> /mjt
>> 
>> Fine with me. However, Connie replied to my v10 series that she
>> wants to pick this patch. However, it is yet not on the qemu
>> master branch.
> 
> Should be now, as the s390 update was pulled?

Yes, it is on master now.

