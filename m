Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49622E674BD
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 14:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXhM4-0004Un-J9; Mon, 22 Dec 2025 09:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vXhM2-0004Tw-Dr
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:57:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vXhM0-0002X8-8t
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766415462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v09E60ZCznPxnmoN+eZ10YTbyviNvXITWhmByYg1Hpw=;
 b=KjnJaXM8fgy/WB+Jd9JZYf4XVIMge8NDkdGosnAKes0Y18juSEabAI1+v2Ayuh/XSaa6Es
 nf4JVCn4OyuL0kW1WpU+KQE6DO7tLM8w+ahul+3XbJ595FtE/NDW9wE4e2rHGMXQOcQEjk
 mnSFcinYzSyRvDnSoPFKC/OKdnyL0RU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ImmwUpJPOPKqvQ-9PprzFA-1; Mon, 22 Dec 2025 09:57:41 -0500
X-MC-Unique: ImmwUpJPOPKqvQ-9PprzFA-1
X-Mimecast-MFC-AGG-ID: ImmwUpJPOPKqvQ-9PprzFA_1766415460
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso22230425e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 06:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766415460; x=1767020260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=v09E60ZCznPxnmoN+eZ10YTbyviNvXITWhmByYg1Hpw=;
 b=pCqRZan8YsgGWKRvO3mQU+O3Ui5Nm58HVPBEgOJIia+aJf/NXc6trPTlJ3sXybTcJ7
 N2zkBu946xiLwFOvbcERfazXmlyZX/U9w/wbVuos7qZTG6GGyvRcgWhNNd/B5vxoRLQs
 j7dHE/JYxOjt+OttjU3GBHrfz+3jt3KpKZ7HoqZKGcH3ycjxVnW40JoOmwn6t0N/CCXQ
 PxvswvvTv558sFpiGWuFNWxquCi078wt4Edr4v3hIVqRMhM3kK+N0c/7EJ5IaQl0FJE0
 eoPJ+YmdvFYlQlvcGIzLhR0x29bpLQBCv5WuYDbCkdRMPeNPgP1iG9+qk5COh72HaunP
 cbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766415460; x=1767020260;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v09E60ZCznPxnmoN+eZ10YTbyviNvXITWhmByYg1Hpw=;
 b=i0B49uvu/eefGilLk+/EHUfE+12RR7oRDZg7wxiGNMirb9xtIRqNvRqYKUJrpknllx
 Q+F32lZ7KPUk6bJGPQZZgE0JMVyBWstxcjsm+YONxRJk4P9nB6MpumuXOV28Ym8SfyZ9
 4ApQaKXkdCXzpx0slqZNcBx3DXK8NhZsPs2Lk9rzJS/ETVaAeRDUZb+j+SWo74uRS7pi
 o6M2iBLa7DYk5KfiwVREpz+xqU6/aoIa6ZU0WEZ4fl4EsC0VyMV070ShOmw8bj9HK1Qi
 Hs8B5TcF5nTZ5M7iJ8KyXstPLNhvVll4TqalN7JDIZwfM5gJ35HoE8SOmip88ZzbhSSc
 JZcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBgQy4cnCcPH2VZDQlroukkI40mITeWi+rjP8arrKEqLAi+PBer29tBgJfuYcKLAk6lKvm7JMp8XP4@nongnu.org
X-Gm-Message-State: AOJu0YzoyVc0u6pWLdvMF6BsUGsCFqq6Eb/71HHSAEPoJhtCL1kKFMX9
 HEkTnHnSdEQqn1/jFg7Hzk9raxInRKgb+QfVMYumu8mkPHjYwB9f7hdY2HNddFeoAl9phMc8H+Q
 beAcBmiQypqYEiiFRQkpjUmp1W+SGOA/l0epTzyQaS6RemqsZFZfy3MdP
X-Gm-Gg: AY/fxX7o7kja89h6g1nZ3IhqaJ0gsoNqQrtjY59rk5wBcy+EfRBH6d2dzAeLs99R6P0
 33IRdYWbsOxBtsgFovW203zK8XYTzOSYseeZyz+tM56VD3oEvZJlBBmzmYRH2o1bZOE3H8D4j26
 f62J/mGVs7/Qn4jNt99h1UlG7BWLJIc2/0JzpUWUq6x10frE2x4z5MntSkKeBLmGzeDCW5QJEPA
 0ulxs1rjF4JTwEkCV36baZtD4s5F6Rej38UqmfB3kwtohOY05f7BvXf4xeA5Z8B4F+QXbmC5x5o
 ycEoFB3T2WOqkhnuMERQ+RH4fbBeWwT2fH1E9ZyBhGVjye0b74phQVC5AHjkv1Gz0vkf1jGR61e
 CfiQYZdC1Hjt5YoZ1+yAiYRni0bxBLp+nWW4/JQwVQhWoyQ==
X-Received: by 2002:a05:600c:c0d7:b0:47a:9b80:7b36 with SMTP id
 5b1f17b1804b1-47be299905emr123237585e9.2.1766415460135; 
 Mon, 22 Dec 2025 06:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSFzRRBCh0qyBQSF1zKvJlvok8YN1P5mU02/vb/stJXLrqYrBKTFqEU8PTIORNiGMgZgA1Hg==
X-Received: by 2002:a05:600c:c0d7:b0:47a:9b80:7b36 with SMTP id
 5b1f17b1804b1-47be299905emr123237465e9.2.1766415459723; 
 Mon, 22 Dec 2025 06:57:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm22345919f8f.22.2025.12.22.06.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 06:57:39 -0800 (PST)
Message-ID: <5098c504-f68c-42c9-9c3a-3b0854418857@redhat.com>
Date: Mon, 22 Dec 2025 15:57:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-headers: Update to Linux v6.19-rc1
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, kjaju@nvidia.com, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-2-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251222135357.143339-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

+Magnus, +Paolo

On 12/22/25 14:53, Shameer Kolothum wrote:
> Mainly for adding support for VFIO DMABUF. While at it, update all
> headers.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
> I was getting this error from update-linux-headers script:
> 
> cp: cannot stat '/tmp/tmp.OfzanvZP6L/headers/include/asm/unistd_32.h':
>   No such file or directory
> 
> I used the hunk below to fix it. This likely requires another patch,
> though. If this is the right fix, I will include that in v2.
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 844d9cb9f5..d09d8cf4c6 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -154,7 +154,6 @@ EOF
>       mkdir -p "$output/include/standard-headers/asm-$arch"
>       if [ $arch = s390 ]; then
>           cp_portable "$hdrdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
> -        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
>           cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
>       fi
>       if [ $arch = arm64 ]; then

[ ... ]

> diff --git a/linux-headers/linux/mshv.h b/linux-headers/linux/mshv.h
> index 5bc83db6a3..acceeddc1c 100644
> --- a/linux-headers/linux/mshv.h
> +++ b/linux-headers/linux/mshv.h
> @@ -26,6 +26,7 @@ enum {
>   	MSHV_PT_BIT_LAPIC,
>   	MSHV_PT_BIT_X2APIC,
>   	MSHV_PT_BIT_GPA_SUPER_PAGES,
> +	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
>   	MSHV_PT_BIT_COUNT,
>   };
>   
> @@ -41,6 +42,8 @@ enum {
>    * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
>    * @pt_isolation: MSHV_PT_ISOLATION_*
>    *
> + * This is the initial/v1 version for backward compatibility.
> + *
>    * Returns a file descriptor to act as a handle to a guest partition.
>    * At this point the partition is not yet initialized in the hypervisor.
>    * Some operations must be done with the partition in this state, e.g. setting
> @@ -52,6 +55,37 @@ struct mshv_create_partition {
>   	__u64 pt_isolation;
>   };
>   
> +#define MSHV_NUM_CPU_FEATURES_BANKS 2
> +
> +/**
> + * struct mshv_create_partition_v2
> + *
> + * This is extended version of the above initial MSHV_CREATE_PARTITION
> + * ioctl and allows for following additional parameters:
> + *
> + * @pt_num_cpu_fbanks: Must be set to MSHV_NUM_CPU_FEATURES_BANKS.
> + * @pt_cpu_fbanks: Disabled processor feature banks array.
> + * @pt_disabled_xsave: Disabled xsave feature bits.
> + *
> + * pt_cpu_fbanks and pt_disabled_xsave are passed through as-is to the create
> + * partition hypercall.
> + *
> + * Returns : same as above original mshv_create_partition
> + */
> +struct mshv_create_partition_v2 {
> +	__u64 pt_flags;
> +	__u64 pt_isolation;
> +	__u16 pt_num_cpu_fbanks;
> +	__u8  pt_rsvd[6];		/* MBZ */
> +	__u64 pt_cpu_fbanks[MSHV_NUM_CPU_FEATURES_BANKS];
> +	__u64 pt_rsvd1[2];		/* MBZ */
> +#if defined(__x86_64__)
> +	__u64 pt_disabled_xsave;
> +#else
> +	__u64 pt_rsvd2;			/* MBZ */
> +#endif
> +} __attribute__((packed));
> +
>   /* /dev/mshv */
>   #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
>   
> @@ -89,7 +123,7 @@ enum {
>    * @rsvd: MBZ
>    *
>    * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
> - * Mappings can't overlap in GPA space or userspace.
> + * Mappings can't overlap in GPA space.
>    * To unmap, these fields must match an existing mapping.
>    */
>   struct mshv_user_mem_region {
> @@ -288,4 +322,84 @@ struct mshv_get_set_vp_state {
>    * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
>    */
>   
> +/* Structure definitions, macros and IOCTLs for mshv_vtl */
> +
> +#define MSHV_CAP_CORE_API_STABLE        0x0
> +#define MSHV_CAP_REGISTER_PAGE          0x1
> +#define MSHV_CAP_VTL_RETURN_ACTION      0x2
> +#define MSHV_CAP_DR6_SHARED             0x3
> +#define MSHV_MAX_RUN_MSG_SIZE                256
> +
> +struct mshv_vp_registers {
> +	__u32 count;	/* supports only 1 register at a time */
> +	__u32 reserved; /* Reserved for alignment or future use */
> +	__u64 regs_ptr;	/* pointer to struct hv_register_assoc */
> +};

I am seeing errors due to the redefinition of 'struct mshv_vp_registers',
already available in file : include/hw/hyperv/hvgdk_mini.h.


Does include/hw/hyperv/hvgdk_mini.h need some clean up first ?

Thanks,

C.


