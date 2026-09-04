Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED541C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2N5v-0002fY-4t; Fri, 04 Sep 2026 02:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1x2N5t-0002en-D4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1x2N5r-0001R2-Lx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788502085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1L2vnFo353yjGYAyJ7gKR3siRLiMzHI6F79fs117Ik=;
 b=LYgmjmvexuAflRQ4M+VHkqAtNexVM5jd+/veV1LHVxRATWmYw+uSshwSeMGf85etGTi5jx
 UNfuPvOGY0iNoEqe9XPHOXnQbIcmiDB0Q3w6MFzHkwYUVUbB4n53exdBbaS4U+wroWhcla
 4DLQ+ihcl9OmsiGAacLx/l2s62Y7Co4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-oAmzGI1pOSyfX3ZP5BeCYw-1; Fri, 04 Sep 2026 02:08:04 -0400
X-MC-Unique: oAmzGI1pOSyfX3ZP5BeCYw-1
X-Mimecast-MFC-AGG-ID: oAmzGI1pOSyfX3ZP5BeCYw_1788502083
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398d0010cfaso1276482a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788502083; x=1789106883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J1L2vnFo353yjGYAyJ7gKR3siRLiMzHI6F79fs117Ik=;
 b=sH+CZTVgSJWM2rStDgf+VYW593gcO6P64Xxf3bal8306U7theL28ou6zgS9F/Otom9
 veAqvumaYzjzVDcfoh4nhHT0sOV+tkFER8ejmfjuk+J2izuLVt2lHhn42xq6tw8Zh5YZ
 geyGFnQj8z2kf/1g97SrINp6NbKQsjdRVFzSTuOGXxyInXwQ9L//mklMZGnqCrBA3P3p
 uwz8RHgBcDKhi30RnDwvXe7hadGWvdOJbC9OXNrnzojop3oQalraBHQJLfIgMKQAvJTj
 iF4SSkI14wf2G1Y4+RQceaRssBLnAgNufcLJGZ2NxhQY3WKQMLiR6XGK2jcgu8WtJ/If
 GExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788502083; x=1789106883;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J1L2vnFo353yjGYAyJ7gKR3siRLiMzHI6F79fs117Ik=;
 b=rN9et6RvKPxuARB8vN4ej7ND+1C46Hwp3dSQI78BGv/LQOKiDgbcGaKB/IprDIIv9K
 xVbZwuiprim0ioFdylMjstkA/jNGiCxI4HoaNXv6bGnfhgbAfEynYFh4s3PqX/uAetkH
 Os2QnpjmR3pnvaJ6sdGXDme/K0tR1zZhSBfwg0kPOz/OZYflYDXfXOT2a+uxvt3hu3FF
 co8Bt4FUaUPa2Gqg6jDGSn18i8BvlwMl5mG85nU5hCFqw78sNxGbmOltpmZxCcJuHlZV
 3WaUSIyezNYY1cQdA0zydFjsTgSAlN/UN6JDhc2DxHcx/Pw1iNrltJq/mfhHUW6dQfp9
 Ie8Q==
X-Gm-Message-State: AFuF++kYOGXJOXuVsDSfQoyosgZyfO52wG/iriQQ/Ok8Mg72b4SKJMIH
 N/SjNhLXig9I2ONU2yvoojj3NnugXf6E/Q+Z3JLXvTkph4RP0ux7w8z16kR/dJvsVDOB2rXCN0u
 cFlKe2FPYxbicsWUuf3VXigQ/jY74LUpcC9dKWKdeclvilf50fyMbKIDm
X-Gm-Gg: AYBFou3eBHZ9Rk/oY8G7QTltWIXuI29BRmK08vZg2pEjviRpe4MPzOKdkK7/UQryi6x
 jwTiVwLtz7rYLjWtNBgH7uL3ACMBn/SXhs5Jq+Y9YHRiDPj1rXm97WP4fZ6zf8t9B90uuaxpCfS
 ab29iKA3BOOsdPCZZFbTvWxDfnsoBw61JC2y2NqxMkzuU2qESSz1xhuSKvUok4bj433Iz2Ceots
 PN8alZXg1fgGKnfX0sYSy2qt/bRhIWR6lhAoPZSDmKx2tu2NRWY0k7QdqYS3rQxm365WpIfT0vg
 AMz2QXswwBuBNN1p1/c7kxzBH074KlLCqYRnfqibB5rZQ4nFlrgDla4Y7lluykXl2DvOj+qN8cr
 0Eyh5NrkC1H2ColNYxOSTViL2IrvZ8OoGiQ+pVh5wqA==
X-Received: by 2002:a17:90b:586c:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39b2623ef65mr6524581a91.24.1788502083064; 
 Thu, 03 Sep 2026 23:08:03 -0700 (PDT)
X-Received: by 2002:a17:90b:586c:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39b2623ef65mr6523936a91.24.1788502077992; 
 Thu, 03 Sep 2026 23:07:57 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bdf26c5sm3852026eec.27.2026.09.03.23.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 23:07:57 -0700 (PDT)
Message-ID: <b06c933e-b8fd-4e03-8f50-9a9086542ccf@redhat.com>
Date: Fri, 4 Sep 2026 16:07:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 01/24] linux-headers: Add RME related definitions
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-2-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Mathieu,

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> This is a temporary patch intended for testing purposes only. It provides
> definitions related to supporting Realms by the QEMU-VMM.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   linux-headers/asm-arm64/kvm.h |  9 +++++++++
>   linux-headers/linux/kvm.h     | 10 +++++++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
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
> index 29f81c05aca2..8b7627f11447 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -689,14 +689,19 @@ struct kvm_enable_cap {
>    * address size for the VM. Bits[7-0] are reserved for the guest
>    * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>    * value 0 implies the default IPA size, 40bits.
> + *
> + * Bits[30-31] are reserved for the VM type
>    */
>   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>   
> +#define KVM_VM_TYPE_ARM_NORMAL		0
> +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
>   #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
>   #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
> -					 KVM_VM_TYPE_ARM_PROTECTED)
> +					 KVM_VM_TYPE_ARM_PROTECTED | \
> +					 KVM_VM_TYPE_ARM_REALM)
>   
>   /*
>    * ioctls for /dev/kvm fds:
> @@ -719,6 +724,8 @@ struct kvm_enable_cap {
>   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
>   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
>   
> +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> +
>   /*
>    * Extension capability list.
>    */
> @@ -988,6 +995,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_S390_HPAGE_2G 249
>   #define KVM_CAP_PPC_COMPAT_CAPS 250
>   #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
> +#define KVM_CAP_ARM_RMI 252
>   

Both KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI aren't consistent to
the definitions in Steven Price's (v16) host series [1]. They need corrections as
below. Otherwise, realm VM can't be started and the following errors are raised by
qemu.

[1] https://lore.kernel.org/kvm/20260803134403.80630-14-steven.price@arm.com/

root@host:~# qemu-system-aarch64 -enable-kvm                  \
-object rme-guest,id=rme0,convert-in-place=on                 \
-machine virt,gic-version=3,confidential-guest-support=rme0   \
-m 2G -cpu host                                               \
-smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2  \
-object memory-backend-guest-memfd,id=mem0,size=2G,share=on   \
-numa node,nodeid=0,cpus=0-3,memdev=mem0                      \
-serial mon:stdio -monitor none -nographic -nodefaults        \
-kernel /mnt/linux/arch/arm64/boot/Image                      \
-initrd /mnt/buildroot/output/images/rootfs.cpio.xz           \
-append earlycon=pl011,mmio,0x10009000000
     :
qemu-system-aarch64: VM doesn't support Realms
qemu-system-aarch64: failed to initialize kvm: No such device


-#define KVM_CAP_PPC_COMPAT_CAPS 250
-#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
-#define KVM_CAP_ARM_RMI 252
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 250
+#define KVM_CAP_ARM_RMI 251

>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;

Thanks,
Gavin


