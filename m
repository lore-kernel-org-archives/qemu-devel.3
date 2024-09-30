Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238B1CF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svENp-0008V6-MY; Mon, 30 Sep 2024 07:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svENn-0008TY-Rv; Mon, 30 Sep 2024 07:16:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svENm-0002cy-6E; Mon, 30 Sep 2024 07:16:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U5EF6j024730;
 Mon, 30 Sep 2024 11:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
 GKRlHWcb/56O4IUGSQfsBfE7H+t0Po+712yRPq1QDY=; b=DnG0XjEnY8m1V39ie
 AVkgbr3buWRp5pQuTOAqx+IorkfwUK431rbyitMlRvjQgJGVIqsAkNwdDgVNjkCL
 lzI5mdoZ++qls35G+uj0wJE22xoncqqXzxlzM/KKAwKWVg/J/bethuIPSHUiugxE
 8fXZbNntF32UrK9/dRp+CgeqGKT1IAjHWlw9LwRTJLVBOrUdFoSGJJ147bB5Q5+x
 tUiFWOzDxUHPNa7tYVlf/S6BYU0hevTX0uxAzwxLRVFoOibjWHZkqdXJhnllFnQc
 dz1GcOozDenf8YaxMnSOD1zXpLoWra6u8KobozFVh4h+MAoGO3vor57xomWgK1Fk
 1YYgw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap9g4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:15:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UBDYIc023507;
 Mon, 30 Sep 2024 11:15:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap9g4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:15:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48U8pUTX002767;
 Mon, 30 Sep 2024 11:15:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu0wv0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 11:15:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UBFr8058458616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 11:15:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5392A20040;
 Mon, 30 Sep 2024 11:15:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62D1520043;
 Mon, 30 Sep 2024 11:15:52 +0000 (GMT)
Received: from [9.179.23.43] (unknown [9.179.23.43])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Sep 2024 11:15:52 +0000 (GMT)
Message-ID: <8938437c-dd89-4c9a-bb53-7949c5fc3a67@linux.ibm.com>
Date: Mon, 30 Sep 2024 13:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/14] s390x/pv: check initial, not maximum RAM size
To: David Hildenbrand <david@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-11-david@redhat.com>
 <c6d51e5a0bd3e222a1fb3354e31bf2edcc3a59d2.camel@linux.ibm.com>
 <72e7a377-60ab-45ed-9136-327fa4dd9e4c@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <72e7a377-60ab-45ed-9136-327fa4dd9e4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eqN0G_PCuN8VmFv5GnTLrd5j2gT5yIm_
X-Proofpoint-GUID: BdmHNpFZfM4f6HaEEAKo0dh35KvrP_58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_09,2024-09-27_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=919 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300078
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Am 24.09.24 um 22:17 schrieb David Hildenbrand:
> On 24.09.24 18:22, Nina Schoetterl-Glausch wrote:
>> On Tue, 2024-09-10 at 19:58 +0200, David Hildenbrand wrote:
>>> We actually want to check the available RAM, not the maximum RAM size.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> Nit below.
>>> ---
>>>   target/s390x/kvm/pv.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
>>> index dde836d21a..424cce75ca 100644
>>> --- a/target/s390x/kvm/pv.c
>>> +++ b/target/s390x/kvm/pv.c
>>> @@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>>>        * If the feature is not present or if the VM is not larger than 2 GiB,
>>>        * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
>>>        */
>>> -    if ((MACHINE(ms)->maxram_size <= 2 * GiB) ||
>>> +    if ((MACHINE(ms)->ram_size <= 2 * GiB) ||
>>>           !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
>>>           return false;
>>>       }
>>
>> If I understood the kernel code right, the decision is made wrt
>> the size of the gmap address space, which is the same as the
>> limit set for the VM. So using s390_get_memory_limit would be
>> semantically cleaner.
> 
> I wonder if we should just drop the RAM size check. Not convinced the slightly faster reboot for such small VMs is really relevant? Makes the code more complicated than really necessary.

IIRC there have been functional issues with small guests and asnyc. Claudio, do you remember?

