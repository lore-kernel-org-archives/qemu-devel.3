Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D82C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsIHq-00033W-FW; Wed, 12 Mar 2025 05:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsIGz-0002op-ML
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 05:21:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsIGt-0005qb-DD
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 05:21:08 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxaWpPUNFnrDSTAA--.55119S3;
 Wed, 12 Mar 2025 17:13:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxb8dNUNFnc69FAA--.62463S3;
 Wed, 12 Mar 2025 17:13:51 +0800 (CST)
Subject: Re: Bad error handling in loongarch's kvm_arch_init_vcpu(), need
 advice
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <87wmcumylv.fsf@pond.sub.org>
 <4999e31e-c502-40f2-bf80-3c857aa50da7@redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <0a1fb6ff-6944-d6fb-bda9-3f166fe8b999@loongson.cn>
Date: Wed, 12 Mar 2025 17:13:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4999e31e-c502-40f2-bf80-3c857aa50da7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8dNUNFnc69FAA--.62463S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFW3Cr13uF4DtrWrCFWxAFc_yoW8Gw47pr
 WxGa4DAryDC3WkJwnFvrnrX34jyryDJa4DXw1DJa43GwsIkrnF9rWjqrnFg345urWrtw4r
 Ja1DX3s8uayUAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxUzsqWUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.105,
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



On 2025/3/12 下午4:59, Paolo Bonzini wrote:
> On 3/12/25 09:39, Markus Armbruster wrote:
>> scripts/coccinelle/error-use-after-free.cocci led me to
>> target/loongarch/kvm/kvm.c:
>>
>>          ret = kvm_cpu_check_lsx(cs, &local_err);
>>          if (ret < 0) {
>>              error_report_err(local_err);
>>
>> Reporting an error, but continue anyway.  This is suspicious.
>>
>>          }
>>
>>          ret = kvm_cpu_check_lasx(cs, &local_err);
>>
>> Passing non-null @local_error to kvm_cpu_check_lasx().  This is wrong.
>> When kvm_cpu_check_lasx() fails and passes &local_error to error_setg(),
>> error_setv()'s assertion will fail.
>>
>> Two possible fixes:
>>
>> 1. If continuing after kvm_cpu_check_lasx() failure is correct, we need
>> to clear @local_error there.  Since it's not actually an error then, we
>> should almost certainly not use error_report_err() there.  *Maybe*
>> warn_report_err().
>>
>> 2. If continuing is wrong, we probably need to return ret.
> 
> Indeed the correct fix is to return ret, since the Error is set whenever 
> an OnOffAuto property is "on" and KVM does not support a feature.
yes, it should return ret immediately, if user forces to enable the 
feature however KVM does not support.

Will submit a patch to fix it, and thanks for reporting.

Regards
Bibo Mao
> 
> Same for all those below.
> 
> Paolo
> 


