Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866F0D5C0CF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Q7n-0000jR-QN; Fri, 08 Nov 2024 09:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Q7h-0000gy-DF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:38:06 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Q7f-0003v5-Bd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:38:04 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so1585466f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731076682; x=1731681482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3GE53KQDBqUNSJql7R8fIEH6vXKaz/NQVAib4k9BmtY=;
 b=wl7R485brXPo7P2zgKX4gj3C+VVy3GVKIf4deLo3uyNqcCZbzfwCbXyNjhdsKayf3w
 cSXmh8Qwy6ZNYcvEtgn3p3g0NGOgycBBpmBNCAYl8um7DbbrFEa98R5KqV9m/ptbhRmR
 8LuKqafQM3gxm5UPqPKWeW8zC1+8O6Z1WEG2ubFEaN4ydV9cIyOb9Mf5Iq20SrICcDg4
 GMwx9SjXNj5sF0FLbTPdRI07BYKzz+tR6tQx/bpg+vHQYUIqkkuBHzBS5VaBJYT7PZ1C
 BdJEW/OCypO9djBKIexrpTeFbTy3Kqc01cMjFDJTSnvAEI19tFbmz3xnXDsg20O6k5yd
 rlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731076682; x=1731681482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3GE53KQDBqUNSJql7R8fIEH6vXKaz/NQVAib4k9BmtY=;
 b=NwSjsAOGftGnCte7MWPOsBMEhsoYa9qN5oOoNifb4v4OFQ603kQJNb5A7welEpofpD
 uB4jYMax6zSL3V9SG+nPMhU5CMmEW0NYPts7VCo3QwskTcPHfHAXkbwXTUa9e5yFpDRR
 3NBxW3lCLtxDTYJesBXUlAtMY/NxA8GmR5bfSL5Q1ZBAIXWQrbgKzBUCabZ0hgH8Kwa5
 PzarhXttMG2UalSB2AJISz4jBpYbPk3PBx+Q1ayPAnerbc/MEAdxS4/xpP4l0wvczdOH
 p3bSy7h6vx5OC2cf1Abf6e5gy2wbqgfU4lzxC2sUpHqY9qI6n1o44BXEO3yrbn4RZdgg
 BdqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhntu6IlF0Y7yOZ4tVJIjIHu9I/5YUwpKeHX96QbR6+ESBxJ485DrL8mGGxAeAadaZDdXM/ITL1r8l@nongnu.org
X-Gm-Message-State: AOJu0YyQ7ocxNzkGLojya/m4cH/C5IkHMSiHhqYjhECQcZIYgmLPqrvp
 c26OMlIV0QlWiNO37jfhX+LnUOhEJtlTajGoFsaIQ2WG2hki8Rj9INKmou1DnZM=
X-Google-Smtp-Source: AGHT+IHsQ9PHCoK9BI8AKVjXG67Q6K1NAK6OwPdHdLyTWcvhE8kDSQHN49qeQmWsAGd9aP9EkH6soQ==
X-Received: by 2002:a05:6000:178d:b0:368:37ac:3f95 with SMTP id
 ffacd0b85a97d-381f17255b9mr2195710f8f.31.1731076681762; 
 Fri, 08 Nov 2024 06:38:01 -0800 (PST)
Received: from [172.16.22.241] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda03e8asm5098572f8f.90.2024.11.08.06.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 06:38:01 -0800 (PST)
Message-ID: <9100ea2c-21e4-4f04-91fa-8b56986abcdf@linaro.org>
Date: Fri, 8 Nov 2024 14:37:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-mem: unplug memory only during system resets,
 not device resets
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
References: <20241025104103.342188-1-david@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025104103.342188-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi David,

On 25/10/24 11:41, David Hildenbrand wrote:
> We recently converted from the LegacyReset to the new reset framework
> in commit c009a311e939 ("virtio-mem: Use new Resettable framework instead
> of LegacyReset") to be able to use the ResetType to filter out wakeup
> resets.
> 
> However, this change had an undesired implications: as we override the
> Resettable interface methods in VirtIOMEMClass, the reset handler will
> not only get called during system resets (i.e., qemu_devices_reset())
> but also during any direct or indirect device rests (e.g.,
> device_cold_reset()).
> 
> Further, we might now receive two reset callbacks during
> qemu_devices_reset(), first when reset by a parent and later when reset
> directly.
> 
> The memory state of virtio-mem devices is rather special: it's supposed to
> be persistent/unchanged during most resets (similar to resetting a hard
> disk will not destroy the data), unless actually cold-resetting the whole
> system (different to a hard disk where a reboot will not destroy the data):
> ripping out system RAM is something guest OSes don't particularly enjoy,
> but we want to detect when rebooting to an OS that does not support
> virtio-mem and wouldn't be able to detect+use the memory -- and we want
> to force-defragment hotplugged memory to also shrink the usable device
> memory region. So we rally want to catch system resets to do that.
> 
> On supported targets (e.g., x86), getting a cold reset on the
> device/parent triggers is not that easy (but looks like PCI code
> might trigger it), so this implication went unnoticed.
> 
> However, with upcoming s390x support it is problematic: during
> kdump, s390x triggers a subsystem reset, ending up in
> s390_machine_reset() and calling only subsystem_reset() instead of
> qemu_devices_reset() -- because it's not a full system reset.
> 
> In subsystem_reset(), s390x performs a device_cold_reset() of any
> TYPE_VIRTUAL_CSS_BRIDGE device, which ends up resetting all children,
> including the virtio-mem device. Consequently, we wrongly detect a system
> reset and unplug all device memory, resulting in hotplugged memory not
> getting included in the crash dump -- undesired.
> 
> We really must not mess with hotplugged memory state during simple
> device resets. To fix, create+register a new reset object that will only
> get triggered during qemu_devices_reset() calls, but not during any other
> resets as it is logically not the child of any other object.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/virtio-mem.c         | 103 +++++++++++++++++++++++----------
>   include/hw/virtio/virtio-mem.h |  12 +++-
>   2 files changed, 83 insertions(+), 32 deletions(-)


> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(VirtioMemSystemReset, virtio_mem_system_reset, VIRTIO_MEM_SYSTEM_RESET, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })

Please fix style when applying :)

> diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
> index a1af144c28..abde1c4101 100644
> --- a/include/hw/virtio/virtio-mem.h
> +++ b/include/hw/virtio/virtio-mem.h


> +struct VirtioMemSystemReset {
> +    Object parent;

And add a newline here, thanks!

>       ResettableState reset_state;
> +    VirtIOMEM *vmem;
>   };
>   
>   struct VirtIOMEMClass {


