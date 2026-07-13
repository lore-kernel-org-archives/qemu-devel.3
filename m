Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0851AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj9Fo-00051T-8V; Mon, 13 Jul 2026 01:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj9Fe-00050E-IA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 01:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj9Fc-0006tC-11
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 01:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783920642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23/NITmBPzrv2YP7GXVDIa8jJVxWfBFqHFpVj1/RdOY=;
 b=ap78OqRA4hTtrOEBnZV+c7Zpw/kycxNoQP1oCiReKyUfm9AeLfF2SjZFvQaLrUBU0U8w1x
 ff7lvUBEpHo8rC3TqIBb76W+JtUJ2h9UKr3nJQnqG4BVDZaPpmmMGKAeg+899Y24VJkbad
 Gyvnwef+pNsE4p/8EnFI2+nuUK0D7X4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-7jIS1BQhMtKvQOIMp4-ZSQ-1; Mon, 13 Jul 2026 01:30:41 -0400
X-MC-Unique: 7jIS1BQhMtKvQOIMp4-ZSQ-1
X-Mimecast-MFC-AGG-ID: 7jIS1BQhMtKvQOIMp4-ZSQ_1783920640
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so1878004a12.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783920640; x=1784525440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=23/NITmBPzrv2YP7GXVDIa8jJVxWfBFqHFpVj1/RdOY=;
 b=TY29Zr52WVkk9uIoXF2A8HS5olZeqcSSBjNomrYANx81hpXXKolni7vLjUl5vAhL8k
 mEKNlljxIjfLu85IPVNLdg4m0p7pkcwTPd/46SpmZDOuq99tuxuYumDVaUhyhdxEN4QO
 0b6EaN1ju2yHJycLoXEh4SnkWq7IHDuY5B0vOS0juNOO9S5l59GJ9X56K1JT9XEiN9Vm
 YHT+ag1i+RKTkj1JUT2q1cjvnZrI87hJVBR+sYIqp6kMkH0sosNQ6v3lvPru9KbvRAn2
 offOC3wPIR1pyxgFYB8J+dptBrcpQskgmABigInr91/GPcEK9KzPV9Z33JpEBT0lhf1f
 sRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783920640; x=1784525440;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=23/NITmBPzrv2YP7GXVDIa8jJVxWfBFqHFpVj1/RdOY=;
 b=NEIRebQ8XJ1PWyA2Y/2C39tKXeB4vnp9xrQh5KmCweNyUnt4l23UQkb6sSfK9BSvSs
 wzXw00xvF8GhQDFyNbHci+YzR3quMD/BQrDwbFfwzDusXyUon3XbfCEEcpgK/Mnho8VF
 TGzzxhZqb83/I+msIRPMaiyWY2cHyrTdSkG3sltelCe5SSwQt/vxLgsnbjChS5GwAIHG
 +Bra0dAr4js5S33Gd7DgkqbxmItsMspfV2fJptPZBhSyBBYtruMbcQhNQ1WRQVhBWLwO
 /3+HY69XlWUGYe1TiwxLafr0mIeQ4wce6ygfryuegvYIVASPaHZZDTHWmbS8bHlKTHxe
 W+jg==
X-Gm-Message-State: AOJu0YzHc7qqMsYuQx8HAs5KaM2Rr6H3J9trRcfuaL8P+Gi1rvhSNoVf
 SeMiQGIAbgAxIP3EEt0kIgt+Ms6NQBCv5HwHwKgsdza6J+CMurJjihQ7F9jAdCyjL5I6WAqfvuj
 HYjJi+WzMpRxtyl6VVD8LsBWeIB4ie12W7vo+7IhJqcsglxqiw9ZSQIi3
X-Gm-Gg: AfdE7cm5H7Spkbihp/0jfeXYhWGIQxXSKkesMiKSyC7oao5YUjxVn0VbWfwKJJj5r25
 DcOP4xItzQu3ctPIyXdS23TU4LKquRNAMatNRNuf2Lps8ttrRHNO9E5ojECG7b6PtRH2Ym3H6Wo
 V/YQ5X+CNYEZkYC0pFA4aakgrxQA6PhI0QqcG/XZtTueEULMUhrMx/Py5B9r1rhKnOn7kQvNbEt
 wF+4Fv1e2yZ1PYIyHLkTiKppAnTcuOLzWq0dGyINFem/zb/THSXuJUuWixQT8VuWkbF8yWZl/FD
 WsuQGs1Ilcs/0fFDNnQfynwvf9cmVz6dGNDl/AsRtwjD05HaepNaFPUjvmoWcD/aqyn4SigpWIv
 D43PoexHdR35iBbOiolVztsoNPn0vsB0WYS0touJYC1iebM2Kn7qUMw==
X-Received: by 2002:a05:6a00:1d90:b0:842:2ddb:e305 with SMTP id
 d2e1a72fcca58-8488975aab7mr6391951b3a.43.1783920640058; 
 Sun, 12 Jul 2026 22:30:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d90:b0:842:2ddb:e305 with SMTP id
 d2e1a72fcca58-8488975aab7mr6391920b3a.43.1783920639587; 
 Sun, 12 Jul 2026 22:30:39 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a30026410sm1590698b3a.19.2026.07.12.22.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 22:30:38 -0700 (PDT)
Message-ID: <ac26ac91-6809-4429-9750-e7d671e952bc@redhat.com>
Date: Mon, 13 Jul 2026 15:30:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 07/25] target/arm/kvm: Create scratch Realm VM when
 requested
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-8-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-8-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a Realm is requested, create a scratch Realm VM by setting bit 8
> of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> for the guest PA size.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c  | 8 ++++++++
>   target/arm/kvm-stub.c | 5 +++++
>   target/arm/kvm.c      | 4 +++-
>   target/arm/kvm_arm.h  | 8 ++++++++
>   4 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 90c1d30ba24c..f763d5ed6199 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -99,3 +99,11 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
>   
>       cpu->kvm_rme = true;
>   }
> +
> +int kvm_arm_rme_vm_type(void)
> +{
> +    if (rme_guest) {
> +        return KVM_VM_TYPE_ARM_REALM;
> +    }
> +    return 0;
> +}

We had official name for 0, which is KVM_VM_TYPE_ARM_NORMAL. Another question if
it's worthwhile to have this helper since it's equivalent to something as below,
which can be directly applied to the caller.


     int vm_type = (current_machine && current_machine->cgs) ? KVM_VM_TYPE_ARM_REALM :
                                                               KVM_VM_TYPE_ARM_NORMAL;


> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 4ab6f08637d1..6d52f172c5df 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -129,3 +129,8 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
>   {
>       g_assert_not_reached();
>   }
> +
> +int kvm_arm_rme_vm_type(void)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4c212ed0c337..6aa1cd04e484 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -108,6 +108,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>   {
>       int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
>       int max_vm_pa_size;
> +    int vm_type;
>   
>       kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
>       if (kvmfd < 0) {
> @@ -117,8 +118,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>       if (max_vm_pa_size < 0) {
>           max_vm_pa_size = 0;
>       }
> +    vm_type = kvm_arm_rme_vm_type();
>       do {
> -        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
> +        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
>       } while (vmfd == -1 && errno == EINTR);
>       if (vmfd < 0) {
>           goto err;
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 12ed1eee18b4..65ec1b970606 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -259,4 +259,12 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s);
>    */
>   void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
>   
> +/**
> + * kvm_arm_rme_vm_type
> + * @ms: the machine state
> + *
> + * Returns the Realm KVM VM type if the user requested a Realm, 0 otherwise.
> + */
> +int kvm_arm_rme_vm_type(void);
> +
>   #endif

Thanks,
Gavin


