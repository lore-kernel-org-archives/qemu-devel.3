Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D842C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 21:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueKEA-0005O4-OF; Tue, 22 Jul 2025 17:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ueKE8-0005L7-IZ; Tue, 22 Jul 2025 17:08:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ueKE6-0000Ab-33; Tue, 22 Jul 2025 17:08:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHumep023034;
 Tue, 22 Jul 2025 21:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ep+iCB
 kmn16NTRT7jW2HYzDAm6WJ3mhkVw1jtNIbKLE=; b=dsR83FYbWnMhLYKVtDeYsH
 3SfMqDx9swT/fk28cpEg4QHUOf0RNki8Bvk7x8TX8q9toG24U7VnyrzTDObVA3tZ
 7TLh73lxgxjr9dr9sSPP19KlwviWyq6XFrJg8GksLFFI7BYCwi7PijmTph+njepG
 UUDUFBpl1hIjG6JVJQ6CM1NK54y2DZM13cJcL/OLdIOa0BRjHXjD0lr/0600W1g3
 Zk0KFS0jc6qyxyUVxECtW4wO8iVRpNctcHL4V2rqa0S9ZZahDRVl5p6BbTTp3Lz6
 nD7zg1awgwh/vEkZFJTXxNiowo92p/pPu2WihzkB7NIr1+FWgzY54MaQZYXN5+6w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffu8y2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:08:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56MI5hbw012867;
 Tue, 22 Jul 2025 21:08:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p304xv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:08:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56ML8YBO36176416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 21:08:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2323358050;
 Tue, 22 Jul 2025 21:08:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1D4C58045;
 Tue, 22 Jul 2025 21:08:32 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 22 Jul 2025 21:08:32 +0000 (GMT)
Message-ID: <472af922-f52a-412b-a504-ae92122b8d60@linux.ibm.com>
Date: Tue, 22 Jul 2025 17:08:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/28] s390x/diag: Introduce DIAG 320 for certificate
 store facility
From: Collin Walling <walling@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-6-zycai@linux.ibm.com>
 <5847016f-f4e7-49ca-82dd-3fb062a8ec0c@linux.ibm.com>
 <5979bc7c-631f-4673-8d75-a94106a0b541@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5979bc7c-631f-4673-8d75-a94106a0b541@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9C9agpUddYlRPRIU4Sh_9-7ZnX9ozCNk
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=687ffdd4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=YbaQ4-TPXBYpC4DU5YcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9C9agpUddYlRPRIU4Sh_9-7ZnX9ozCNk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE4MiBTYWx0ZWRfX6EB18sLEP/ps
 cwRwgHOH86AARAmtt7zH6I0nnjf6n+cu13xwqn3YfaLoZp91y9QcSkLWRqx2wWQZ41WdcEBip3m
 Dimpz3LIvYCvKQ6B4TVtwaRCmzg4vVM0lsjPjkHaoh1dVTJm+2/HE39O+cDtB7Y1e5u5wuHAnAd
 SOr2bksKQ77XYoD7fTcRJyxkJytvKa2+Buc2YwKVL1dJ5ZSXGQW1qfNWnVGKAXw1nvong2z2YTL
 Ki0h/XGfTbPpzxZtXiPAHxVYbC7wnkLdAepgppGNJnC2xkCiGMFMJY/N92RdLavaTMVPOd2u1jh
 M6RaHa+Srvn90Jfch4j6hcNNKaXlHdP+4eh9/1V1WqQVGNvqY1FiT/C6wOHyQtveHx889YSba9o
 dvHZQ9Q0UosxaxwRNLE0kd3buHTdZIHPqdYrIdQiu7XwbgWDsvlTj2Pt+RNBOnCJ6oV9Scut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220182
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/21/25 17:39, Collin Walling wrote:
> On 7/21/25 17:26, Collin Walling wrote:
>> On 7/11/25 17:10, Zhuoying Cai wrote:
> 
> [...]
> 
>>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>>> index 8f655a4b7f..d5b3694600 100644
>>> --- a/target/s390x/kvm/kvm.c
>>> +++ b/target/s390x/kvm/kvm.c
>>> @@ -98,6 +98,7 @@
>>>  #define DIAG_TIMEREVENT                 0x288
>>>  #define DIAG_IPL                        0x308
>>>  #define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
>>> +#define DIAG_CERT_STORE                 0x320
>>>  #define DIAG_KVM_HYPERCALL              0x500
>>>  #define DIAG_KVM_BREAKPOINT             0x501
>>>  
>>> @@ -1560,6 +1561,16 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
>>>      }
>>>  }
>>>  
>>> +static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
>>> +{
>>> +    uint64_t r1, r3;
>>> +
>>> +    r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
>>> +    r3 = run->s390_sieic.ipa & 0x000f;
>>> +
>>> +    handle_diag_320(&cpu->env, r1, r3, RA_IGNORED);
>>> +}
> 
> One more piece I forgot to add here:
> 
> This handler function should check if the required facilities are
> installed for DIAG 320.  For now, the Certificate Store facility is used
> to indicate DIAG 320 is provided and possibly subcodes 0-3 are
> available.  Please add a feature check here and throw a program
> specification interrupt if the facility is not available before
> handle_diag_320 is called.
> 

Ack, sorry.  I think I was too far into the weeds w.r.t. to fencing this
off that I more-or-less duplicated this feedback in another spot.  I
realize now that fencing this feature off in handle_diag_320() makes
more sense, as TCG also invokes it and should handled for that case as well.

My other sentence in the previous reply "In patch 4, you introduce the
feature bit for DIAG 320" should be disregarded, as I see it's already
there in that function.  My bad.

>>> +
>>>  #define DIAG_KVM_CODE_MASK 0x000000000000ffff
>>>  
>>>  static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
> 
> [...]
> 


-- 
Regards,
  Collin

