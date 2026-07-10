Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480CFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 01:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whzkf-0003vg-AO; Thu, 09 Jul 2026 21:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1whzkd-0003v1-7B
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1whzka-0000cM-JH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783645794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vU3hPcH9uK2S/V3s3NOUeMIyXN/zNySGMIX6rPdTN8A=;
 b=b02ThrQ/hqYV6XYQ7uqouccoJUlgq8tkDuLRcuaYdtdc/LnDwLfVQ0jJ5Ul6aXUuswLPCq
 538EP1qobTlaG06tC4pWc0/962DaSAqX1l/41QzgaoVRgbWDJvHOYWtmeXNPohMGfT1h0d
 gdMdvsJOU1fYVbiV4Zs2w6cXGeZNzD0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-8_9vSng0MXig898snq3Ocw-1; Thu, 09 Jul 2026 21:09:53 -0400
X-MC-Unique: 8_9vSng0MXig898snq3Ocw-1
X-Mimecast-MFC-AGG-ID: 8_9vSng0MXig898snq3Ocw_1783645792
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso596983a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 18:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783645792; x=1784250592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vU3hPcH9uK2S/V3s3NOUeMIyXN/zNySGMIX6rPdTN8A=;
 b=jTnHy1xaT2+oV4HhkGnCG6YKf2r84CQ9e3BPGv4wWfrA/ghgh9mxtTVvMuwW3pFpbc
 8Rat5E23ZNEdi2xYRJ4W/+4BHcWagCtztjudGcgUktOQl5faTmZNtUP5tFtaY/x4yWA4
 JXR54MyAgsZKir1VEyjrdTgVMBlmTW/mg4MOFoSDn2CSbSy11pHL1Uc89yTcJ9VJaX7L
 woVvdV6K3p5pTUgwnhVhcc5wvstN7FNv86J4bO3yz/3ZwABPYoOwyht7ZGziw8VZ1TId
 5FQYywItG6mjQCqeKSnmwO77GTmi/YQ/gfmtMMSI5ik1h8i11ZXF0EUjBxr04hBBGNhs
 xW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783645792; x=1784250592;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vU3hPcH9uK2S/V3s3NOUeMIyXN/zNySGMIX6rPdTN8A=;
 b=i5BICzA07C5/ifnJK+fN/eihbVkgP7pvAnUTpdAz3N597jvdI+fSqlvZlUa9rBw0O/
 BSe7+hD050L4FINxlAUIWmXe9D/jC02r4kqZLji4kAf/glaTKC/4P5j4fWp6XqMp/Fea
 woMxwm+upus/ivgmiEsGlsa3XLRrXD3AHVESJ74mKWs/ZLVvzD6/c1XfAWbEtDIvC2kU
 yvRZpXQIozS1ipStx8Th9ZKNf1fQTOvM17Ta2lU/rQxs8+s7oNYzQ1q+KoO3uSGHkkpY
 nucbThvX6BAz67oj/l/xN6XAlQwCS3JfRjnOH12UDc1c5xDAZEX8DrevXmBzimXZca9E
 esgw==
X-Gm-Message-State: AOJu0Ywa50QSdaNCz3r7kcHxe2I81Ouylfa1AwaQGlSuopg5HcXUf9us
 GHHzXeQy+2nLzUnH27jc9Y0S/K64U/HjGUKviDslKpd5f/3pE14caBNHzaH6TjvJ5XrN93UpJYj
 p6h8d076fPkal8Fu3k8gUSNgtngut+CqW8+AK6PIGqcqSbx4r+mkLqTk9
X-Gm-Gg: AfdE7cn9bLVnftLJO7q5SBx8DQraTnO62q4RmFIxUbx1tRLmpp72zmSLbezHLHojJdF
 7r2afncd6t70xJqbXvxCkXlq04XEeLvKvHZMEJovFDR3lIyYkB03L1D34J0cnWUgSD17wARI6Pv
 ehjmrVZ031ZkfdTfecedJqqceLyTa7ytkhU3wO9uMAJ/WqTJ1fH7WEdyByBLhf/+tI8Zr6jZ40i
 M94rjoE77mHjbJQShuq3tKdLdjmO8aZEV8aWV/bIpc/wGIar7IcOKDqoWZB4qOehoOH9dMdh/k+
 M0yc3tirxs8TkfPcJk211bdDMl+F0LY/VEbX3VqkYWBfXkIAJHkBFa4aSl0JcpWtcjvie1jTEgT
 uLo24OurtqRrW+rdeadJqrhgTjy/l8K+l+dchs8sEHVb6Xh6QAamqYA==
X-Received: by 2002:a05:6a20:d708:b0:3c0:b62a:2b8c with SMTP id
 adf61e73a8af0-3c0bd3983famr11784208637.70.1783645792252; 
 Thu, 09 Jul 2026 18:09:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:d708:b0:3c0:b62a:2b8c with SMTP id
 adf61e73a8af0-3c0bd3983famr11784169637.70.1783645791764; 
 Thu, 09 Jul 2026 18:09:51 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d7c8bsm37162096c88.12.2026.07.09.18.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 18:09:50 -0700 (PDT)
Message-ID: <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
Date: Fri, 10 Jul 2026 11:09:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-2-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> This is a temporary patch intended for testing purposes only. It provides
> definitions related to supporting Realms by the QEMU-VMM.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   linux-headers/asm-arm64/kvm.h |  9 +++++++++
>   linux-headers/linux/kvm.h     | 21 +++++++++++++++++----
>   2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index 6aefe7973814..4c08631ec7d2 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
>   	__u64 reserved;
>   };
>   
> +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
> +struct kvm_arm_rmi_populate {
> +	__u64 base;
> +	__u64 size;
> +	__u64 source_uaddr;
> +	__u32 flags;
> +	__u32 reserved;
> +};
> +
>   #define KVM_ARM_TAGS_TO_GUEST		0
>   #define KVM_ARM_TAGS_FROM_GUEST		1
>   
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 50e87ed72c20..dae6e5ba8457 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -685,11 +685,21 @@ struct kvm_enable_cap {
>   #define KVM_S390_SIE_PAGE_OFFSET 1
>   
>   /*
> - * On arm64, machine type can be used to request the physical
> - * address size for the VM. Bits[7-0] are reserved for the guest
> - * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> - * value 0 implies the default IPA size, 40bits.
> + * On arm64, machine type can be used to request both the machine type and
> + * the physical address size for the VM.
> + *
> + * Bits[31-30] are reserved for the ARM specific machine type.
> + *
> + * Bits[7-0] are reserved for the guest PA size shift (i.e, log2(PA_Size)).
> + * For backward compatibility, value 0 implies the default IPA size, 40bits.
>    */
> +#define KVM_VM_TYPE_ARM_SHIFT		30
> +#define KVM_VM_TYPE_ARM_MASK		(0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
> +#define KVM_VM_TYPE_ARM(_type)		\
> +	(((_type) << KVM_VM_TYPE_ARM_SHIFT) & KVM_VM_TYPE_ARM_MASK)
> +#define KVM_VM_TYPE_ARM_NORMAL		KVM_VM_TYPE_ARM(0)
> +#define KVM_VM_TYPE_ARM_REALM		KVM_VM_TYPE_ARM(1)
> +
>   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)

The definitions in this section aren't exactly same to that in (v14) host series,
leading to KVM_VM_TYPE_ARM_REALM = 0 in my environment and the realm guest can't
be started with the following error message. At least, KVM_VM_TYPE_ARM_MASK has
been redefined with different values.

   qemu-system-aarch64: KVM does not support guest_memfd

   ----> linux-headers/linux/kvm.h

   #define KVM_VM_TYPE_ARM_SHIFT          30
   #define KVM_VM_TYPE_ARM_MASK           (0x3ULL << KVM_VM_TYPE_ARM_SHIFT)

   #define KVM_VM_TYPE_ARM_MASK           (KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
                                           KVM_VM_TYPE_ARM_PROTECTED)

After syncing the definitions with those in (v14) host series, I'm able to boot
a simple realm guest (no virtio devices) with one warning.

   qemu-system-aarch64: Failed to enable KVM_CAP_ARM_NISV_TO_USER cap

Thanks,
Gavin

> @@ -719,6 +729,8 @@ struct kvm_enable_cap {
>   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
>   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
>   
> +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> +
>   /*
>    * Extension capability list.
>    */
> @@ -985,6 +997,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_S390_USER_OPEREXEC 246
>   #define KVM_CAP_S390_KEYOP 247
>   #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_ARM_RMI 249
>   
>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;


