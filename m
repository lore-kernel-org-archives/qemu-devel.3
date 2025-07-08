Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDFFC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 19:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEBS-0002qC-IW; Tue, 08 Jul 2025 15:40:54 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZBOc-0008ML-96
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZBMH-0004Qk-CB
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751992626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYadxeNHyeft4vuJmFk2+Tsydm/dqPzo99hMINpb82I=;
 b=WHbc9BXmhWUrX5H5eUSnSjIH/mMqhsjvozj27dcbIAfOzcqtFaXiIDLsNay7ekcHUec8Ln
 uJ0QX3sghKPbYMlCyM0/zrCa+9VtgtlopL/95AnVN1QSunovTsj4soRwiX0keObcsBjnlu
 J4LHQzFA1tgaVLOWDqz90U2VTe3qxK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-8xgDUb7oM4iVAIrBPJzkIw-1; Tue, 08 Jul 2025 11:58:11 -0400
X-MC-Unique: 8xgDUb7oM4iVAIrBPJzkIw-1
X-Mimecast-MFC-AGG-ID: 8xgDUb7oM4iVAIrBPJzkIw_1751990290
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso2566514f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 08:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751990290; x=1752595090;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYadxeNHyeft4vuJmFk2+Tsydm/dqPzo99hMINpb82I=;
 b=RqXlCp08JUvummzvOpXr0Wzcf0zFtoQaNVNjziWbxoHTiVYFC8fNvl40cRLF4j08VK
 zwA4S6veFGwOxb4Hhig7Niab8E2PZRKoNpk6VVFdl4hu8AGY9OsAFwOFpy5zgDHC6oCx
 V/D78/Yie3glWp0MHGEH5oGA+WnnRNsTSUqEZXsWqtVE5iuaFUQ8tiOGDJ963anIj1/x
 Kl3EFIIHabtMqq0wLjoawhKSX7jhlyD1oCi79uhB7f9PREfShkxlbVG88VW5LZEIjJkA
 AHk0ry6O2Mp4xqwbgfHpR2yCvBmed+69byvpZMxKZ7Akhql5M74CXvMDd1hyWW/14+jv
 Ho9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiVvqbi0WNMi+SEsskeU7GFbe8rbTjylbKg2pCMC0tDJwYS4A+rDYoL2zO7J2NoIBAm+uYnGuWmEQf@nongnu.org
X-Gm-Message-State: AOJu0YxhI99ufPrDBqPJMV8/DPDuaLAjpbtVcPEz1H4L2qptnuYkv/iA
 TAKxHcw3vP12iZtsynvzhqEN/7UujIGD4hXBLu9K0JsStY+HFJ3orfaQOnQMER0BDgRrLggPgrh
 gMAl+0wgJatOXCG4lWASutySVuh1iSQVZ9kzUow3pasO2/qLpU03GS5kq
X-Gm-Gg: ASbGncukKCDUxGJUN4DGcdw+zXD3DMdYWNRzpMINOZ06fi0qSl7ThLz/wy/hCknYMPz
 mzyEHIoUI8qo7Ng8b4O95DlJ0LB25xwXJAqCziJ4wCyFl6O6iIEDByUmKoEc3Y3rgi0TQ3ufNLC
 WdUAW49/xsn14RyK4/oRW91hQSskcbbN67Vl71TX4w+fZRFbPai66Vz8Yu/+AXGpjNUDlq9gGHo
 jUNHtOzIh5UcNWU7s0U3nYLwlsqdetENICjXtsDgV/dc7wADo4I0lnn+oghV5xVzvLqWY/WDeCU
 glXA+iOp6PZ2CDyF9hFwoeOeN+TOpfgv5Fb1IwnRlC1dUH4RNZs5fW3cELaKor0LB9Gxuw==
X-Received: by 2002:adf:e19b:0:b0:3a4:cb4f:ac2a with SMTP id
 ffacd0b85a97d-3b4970110d9mr11589212f8f.21.1751990290078; 
 Tue, 08 Jul 2025 08:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETcHu6CEeeMdueEEZSQvTMD1QVOKBXPassNN6jhIRLrSSvV4Nc26FmmOeLp5VorEoAoAkvWw==
X-Received: by 2002:adf:e19b:0:b0:3a4:cb4f:ac2a with SMTP id
 ffacd0b85a97d-3b4970110d9mr11589186f8f.21.1751990289510; 
 Tue, 08 Jul 2025 08:58:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d2749sm26893205e9.25.2025.07.08.08.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 08:58:08 -0700 (PDT)
Message-ID: <60bb1600-b9ea-4fd6-8292-79f7a9b6d82c@redhat.com>
Date: Tue, 8 Jul 2025 17:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/intc/arm_gicv3_kvm: Drop DPRINTF macro
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250708115238.667050-1-peter.maydell@linaro.org>
 <20250708115238.667050-4-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708115238.667050-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/8/25 1:52 PM, Peter Maydell wrote:
> We don't generally like DPRINTF debug macros, preferring tracepoints.
> In this case the macro is used in only three places (reset, realize,
> and in the unlikely event the host kernel doesn't have GICv3 register
> access support). These don't seem worth converting to tracepoints,
> so simply delete the macro and its uses.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
> If anybody needs to debug this code they can add useful tracepoints
> at that point. I don't think these DPRINTFs will help at all.
> ---
>  hw/intc/arm_gicv3_kvm.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 8e34d08b415..e118c1b1f04 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -34,14 +34,6 @@
>  #include "target/arm/cpregs.h"
>  
>  
> -#ifdef DEBUG_GICV3_KVM
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, "kvm_gicv3: " fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  #define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
>  typedef struct KVMARMGICv3Class KVMARMGICv3Class;
>  /* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
> @@ -721,14 +713,11 @@ static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
>      KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
>      uint32_t reg;
>  
> -    DPRINTF("Reset\n");
> -
>      if (kgc->parent_phases.hold) {
>          kgc->parent_phases.hold(obj, type);
>      }
>  
>      if (s->migration_blocker) {
> -        DPRINTF("Cannot put kernel gic state, no kernel interface\n");
>          return;
>      }
>  
> @@ -807,8 +796,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>      Error *local_err = NULL;
>      int i;
>  
> -    DPRINTF("kvm_arm_gicv3_realize\n");
> -
>      kgc->parent_realize(dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);


