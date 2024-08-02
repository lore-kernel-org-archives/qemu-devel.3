Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB52C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZs9V-00073W-R1; Fri, 02 Aug 2024 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sZs9T-0006yp-KW
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sZs9R-0006sb-EU
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722604614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Rdk22TaS/iLiVvcnWLKLcnLzcA/PCehb6evie521EY=;
 b=QacOeUElNycKFtRFyu08akHAnWn+3Wvtytgmild413YqSeVfZUBQP0YSuTJoIgmZdbeYB3
 AxLUFKqylAGzx0brjHK7LL8yhhcAAJC2TMz/ogXhs9ExFExz2FZW9SWabM+UvrUjJab1UY
 Lq7fJKHs73a8vrVHPdc6LS8WOi/W+F4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-MoMadAuFN_-RtowhBnGDYw-1; Fri,
 02 Aug 2024 09:16:50 -0400
X-MC-Unique: MoMadAuFN_-RtowhBnGDYw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66EB61955F65; Fri,  2 Aug 2024 13:16:48 +0000 (UTC)
Received: from localhost (dhcp-192-176.str.redhat.com [10.33.192.176])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68BD9300018D; Fri,  2 Aug 2024 13:16:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, darren@os.amperecomputing.com, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] arm/kvm: add support for MTE
In-Reply-To: <a622440f-9f39-4d30-bdb6-ed571a152793@os.amperecomputing.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
 <a622440f-9f39-4d30-bdb6-ed571a152793@os.amperecomputing.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 02 Aug 2024 15:16:43 +0200
Message-ID: <87y15f6p50.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 02 2024, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:

> Hi Peter,
>
> On 16-07-2024 09:15 pm, Peter Maydell wrote:
>> On Tue, 9 Jul 2024 at 07:05, Ganapatrao Kulkarni
>> <gankulkarni@os.amperecomputing.com> wrote:
>>>
>>> Extend the 'mte' property for the virt machine to cover KVM as
>>> well. For KVM, we don't allocate tag memory, but instead enable
>>> the capability.
>>>
>>> If MTE has been enabled, we need to disable migration, as we do not
>>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>>> off with KVM unless requested explicitly.
>>>
>>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>>> which broke TCG since it made the TCG -cpu max
>>> report the presence of MTE to the guest even if the board hadn't
>>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>>> then tried to use MTE QEMU would segfault accessing the
>>> non-existent tag RAM.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>> 
>> In target/arm/cpu.c:arm_cpu_realizefn() there is this code:
>> 
>>      if (cpu_isar_feature(aa64_mte, cpu)) {
>>          /*
>>           * The architectural range of GM blocksize is 2-6, however qemu
>>           * doesn't support blocksize of 2 (see HELPER(ldgm)).
>>           */
>>          if (tcg_enabled()) {
>>              assert(cpu->gm_blocksize >= 3 && cpu->gm_blocksize <= 6);
>>          }
>> 
>> #ifndef CONFIG_USER_ONLY
>>          /*
>>           * If we do not have tag-memory provided by the machine,
>>           * reduce MTE support to instructions enabled at EL0.
>>           * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>           */
>>          if (cpu->tag_memory == NULL) {
>>              cpu->isar.id_aa64pfr1 =
>>                  FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>>          }
>> #endif
>>      }
>> 
>> With this patch, for KVM we will end up going through the
>> "squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
>> set cpu->tag_memory and this is still using that as its check.
>> 
>> More generally, how does the enabling of the MTE KVM cap
>> interact with the ID_AA64PFR1_EL1 value that we read from
>> the host in kvm_arm_get_host_cpu_features() ? We care that we
>> have the right ID register values because we use ID field
>> checks to determine whether the vcpu has a feature or not,
>> even in the KVM case.
>
> Using ID_AA64PFR1_EL1.MTE bits seems to have issues with the Linux 
> kernel implementation.
> This register is sensitized to user space and value read differs time to 
> time. ID_AA64PFR1_EL1 register read at the beginning of qemu code will 
> have the MTE bits cleared/masked. However ID_AA64PFR1_EL1.MTE bits are 
> unmasked and shows the real value of MTE after ioctl KVM_CAP_ARM_MTE is 
> executed to enable MTE.
> In QEMU,. isar.id_aa64pfr1 is read at the very beginning and cached, by 
> creating dummy(kvm_arm_create_scratch_host_vcpu) interfaces(fds) for 
> kvm, vm and vcpu. At later stages use of isar.id_aa64pfr1.mte at 
> function like arm_cpu_realizefn does not show the right value and code 
> never enters the "if (cpu_isar_feature(aa64_mte, cpu)" loop.
>
> Not sure about other feature bits, but for MTE, using isar.id_aa64pfr1 
> may not be appropriate but I do see it is getting used already many 
> places of the code. I am not sure how it is behaving on emulator/TCG mode?
>
> Having said that, I have tried to remove the sensitization of 
> ID_AA64PFR1_EL1 for MTE bits in the kernel, but that will have bigger 
> problem like the VM boot crashes with the default compiled qemu binary 
> with normal VM boot itself, since VM detects as MTE present and starts 
> init of it.

Not sure if you've seen
https://lore.kernel.org/all/20240723072004.1470688-1-shahuang@redhat.com/,
which aims to make aa64pfr1 writable by userspace -- but still needs
special handling for MTE. (That series also masks out MTEX and MTE_frac
because the Linux kernel does not yet handle them; might become relevant
if we want to support it from QEMU at some time in the future, but then
the command line would also need some thought.)

I fear that we'll be stuck with special handling for the MTE bits in
aa64pfr1 because the kernel will not want to break its userspace API.


