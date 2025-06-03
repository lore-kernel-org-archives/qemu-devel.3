Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DF6C5B559
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNrE-0001sg-Vb; Tue, 03 Jun 2025 05:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMNrA-0001s6-2a
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMNr7-0007Mo-QP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748942567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5FCDRrYRIIQ9WpUx0P2R0xplBU+9ItxfE+BT5HqCI8=;
 b=TtkSMN2N5V28hOHlLW2DibDp/ga5VNvRRtu+Eiy3wqnQYQETPvUG6uYJ4m57Fko1i9MmGM
 qyIp3eotAX7yqV41X9B/xWByXOAZ+7ISgNHisYMSDEpSzwdhhgW2WUsc0RUUHgrhRROGWx
 0t+WnXD7tlImWfJLD9XR7Al71wMJxEo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-X5vV9_XLNq6k6GpXMb4pHw-1; Tue, 03 Jun 2025 05:22:45 -0400
X-MC-Unique: X5vV9_XLNq6k6GpXMb4pHw-1
X-Mimecast-MFC-AGG-ID: X5vV9_XLNq6k6GpXMb4pHw_1748942564
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso2768160f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 02:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748942564; x=1749547364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5FCDRrYRIIQ9WpUx0P2R0xplBU+9ItxfE+BT5HqCI8=;
 b=aAhwLpaqlXF2W4AAXJYv+S7Z/YxwnrPuxGhHg8zq7tX20zL9ABLeMTnD2zvy7IXM2b
 qmDBGJ0gzNnWppG05TUEDyPAp+jS9U4UxasnlTzxgOr9ELu4iBWM3Ru//Bc6uCx67Z+K
 gJjpkI4Zu9E1jHdBHREtYSjCaQS3r+umynzm+jYjEfYmzolVZjtv+RKs2NugRWA5mXLH
 JCjHE0iKJVNUJ0ZAOIcZoM2dU1Ku6EcNGIeVspCAV8Thr60bxvsCF3OUR/eXwXdVhX8P
 qHMoieF/VEIl9Mvn8JR9Y8CGjmlsdIb1nbZTBLbr3e+yFxPymhpNBDt3qS0z7W7HqeYM
 AI9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2k2ZZoAmbxjyWOs1wrYBZKJPjt/Asxg/wFan1In7vqyQMaX8iQ632QU6RAmK/ysPnkXAxRQDabqjU@nongnu.org
X-Gm-Message-State: AOJu0YyAJ3qua4HMBBQ5FgB3XwgDnVIxNIP2Z7cxR+D2j8zpyzItORQT
 LpV7ycSi4uagvWjfIOJPIsDhclbe2msqDNLokCFbxewlGhbj0HpN9vlYYDnRBhZQ36rAYtrJugq
 nJMqS0kGWyg0WkqtP4pgru7jtokmLWWVGdycPwS7xVmt0L8G1k3AtqSz9
X-Gm-Gg: ASbGncu/Zqkxs0UYwvLHNpjJwzHPswIcPNwuiLwkOjG2XYQcpzjObTw/l6rGFyRQ/4O
 t/l7tUYsrsFesHjTjC2miA8GPl1z+XWU79I2Nz/e6OqkIaP/2zikdKnl/BM49EessIOL776uUrO
 xPPGNzXXFPdIJgi3l4Bv/8K22tlqWPSkEKqm3CT8IlcYwv8v5jIF8Buy9Uaj0NY9jj95NhFhlGA
 rRgrnhNxBn8iyguXuP2LiV/q/cpqWrNHaXowgeK/JRPrjrXtzw9kuSE0lpgmxPHVgAdsAU8lvtY
 NcrujXWxXeZZtNtBzchJX/l6qq3pw9zi
X-Received: by 2002:a5d:584e:0:b0:3a4:e65d:5d8c with SMTP id
 ffacd0b85a97d-3a4f7a9d5ddmr13205884f8f.40.1748942563670; 
 Tue, 03 Jun 2025 02:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW/MvLRL5RJ8S9VlcvyGEqzjuKVxNMZaSYGCIHX97snUBRd0DMj5jsiMIBZGn1KUVgHUsovw==
X-Received: by 2002:a5d:584e:0:b0:3a4:e65d:5d8c with SMTP id
 ffacd0b85a97d-3a4f7a9d5ddmr13205862f8f.40.1748942563314; 
 Tue, 03 Jun 2025 02:22:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006946sm153904635e9.31.2025.06.03.02.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 02:22:42 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:22:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] i386/cpu: Rename enable_cpuid_0x1f to force_cpuid_0x1f
Message-ID: <20250603112239.01eb3d01@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250603050305.1704586-2-xiaoyao.li@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
 <20250603050305.1704586-2-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue,  3 Jun 2025 01:03:03 -0400
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> The name of "enable_cpuid_0x1f" isn't right to its behavior because the
> leaf 0x1f can be enabled even when "enable_cpuid_0x1f" is false.
> 
> Rename it to "force_cpuid_0x1f" to better reflect its behavior.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Suggested by Igor at https://lore.kernel.org/qemu-devel/20250513144515.37615651@imammedo.users.ipa.redhat.com/
> ---
>  target/i386/cpu.h     | 4 ++--
>  target/i386/kvm/tdx.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1146465c8c62..aaef6a2a6767 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2270,7 +2270,7 @@ struct ArchCPU {
>      bool enable_cpuid_0xb;
>  
>      /* Force to enable cpuid 0x1f */
> -    bool enable_cpuid_0x1f;
> +    bool force_cpuid_0x1f;
>  
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
> @@ -2540,7 +2540,7 @@ void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
>  
>  static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
>  {
> -    return cpu->enable_cpuid_0x1f ||
> +    return cpu->force_cpuid_0x1f ||
>             x86_has_extended_topo(cpu->env.avail_cpu_topo);
>  }
>  
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 0a21ae555c5c..17e671f1710f 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -746,7 +746,7 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
>      /* invtsc is fixed1 for TD guest */
>      object_property_set_bool(OBJECT(cpu), "invtsc", true, &error_abort);
>  
> -    x86cpu->enable_cpuid_0x1f = true;
> +    x86cpu->force_cpuid_0x1f = true;
>  }
>  
>  static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,


