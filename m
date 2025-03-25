Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA66C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwru-0004An-Jp; Tue, 25 Mar 2025 01:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twwrt-0004AT-65
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 01:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twwrr-0001Y8-FT
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 01:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742880626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vFE2uo8E4oe0rMUlR1JpVgCzM5SoEIjjgWNHFAXJjmc=;
 b=MTc2CONDnyriqgl6WnKTDng9m20d54YTQibEL7ccQZ5PjzDlOW1zuk8o/Gez5D9XCFsgWt
 7abVvlSyPPlPQbKExKRvk52NPmzZBFqKURkjoYhebpZAX2+2dvatd6RtEufH9FEMmRSV6b
 d7Ysu2SzKfwbJJ5L/IXNfs7AklS9ZkM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-ATXH-5QLM1SfaWQTTwN2pA-1; Tue, 25 Mar 2025 01:30:19 -0400
X-MC-Unique: ATXH-5QLM1SfaWQTTwN2pA-1
X-Mimecast-MFC-AGG-ID: ATXH-5QLM1SfaWQTTwN2pA_1742880619
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e6b2b8339fso5059119a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 22:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742880618; x=1743485418;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vFE2uo8E4oe0rMUlR1JpVgCzM5SoEIjjgWNHFAXJjmc=;
 b=pF/2jb2YlV+mepYCitmh9/hdYO3Bt6EbeMMM36Z3zHZw3QzQwDAziq65mkCkMhegXT
 /rrjo4f5QWNLjUTi05yptW9D+r96NbQ9t9y97vJoa69COT0SH3vaH9CEVfcRToqByNks
 atsPEr0+BmVXSRLpbk3FcgJUYv8gz66drlHcbcTRvXCS+iDgzuhAP9pqp10GDTWdHsxn
 He+S/2mxQ6Bep5oOPJE4vuFZac0u4IlySK5no6eRCjzo4v8sGV/pyMEmWH6yT0H0mv8P
 6DQECNxKN6j9fQJRaL3N6GVxycM06AmFzj9Y8+0UgtCMA/wjLbj5Sn8RjI6gUTOwwTdB
 XTEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMpdjofIqjYNnebQ+Ycmjf7XxivHB/xDbzhHFxY7k+RCspVrUyTegMXG0lGsytl9msan+bOMZqA6/t@nongnu.org
X-Gm-Message-State: AOJu0YxdXz983LEwbizvo5BQEKwPwhd3Mx1WhCTNWKGWhRBeCQyxSA+M
 dhX1YDPdxVMpS+/HS3BuLfRWkya94+L6TdF1cCtZBNpQq8MSxMiVn/mKxQCa5ZSD1g61esf/f17
 +yf1/T80KphBnJGsipTQwtKfrCAL7M0z9Ax/Fs/Cclmb7tQ5vX/lj
X-Gm-Gg: ASbGncu17B7XwcIHKrRaUpublA3qVYRk8h4Y0Msxw5v3EFEnGLQ9dp4NjzuA95EJl1o
 uxvbY55Z42kcFZRRD7VUpRSy/DkrJooWXb170Fvufdzn13DU+YSpymt8DOQ1h8PYCcEQgs8ujVX
 sCrDxW4RXVwtqIvM6yI0CmQqT4HMYcZsw16ve5ZxncEyys5zR5kJ/lEFXU+K6Q/zO6N2a1Kz29A
 L21qJfmIntTHYTV3PBRnVIsB7pAX2GakUrP5Jb53ixOgZwtzHhfTNIYyHDAYL6ijfesHYNCcsyW
 kWipVurD4s6iYiiEUHctn1L/Af0HhskYcRNl0EAy40EB
X-Received: by 2002:a05:6402:35c4:b0:5d9:82bc:ad06 with SMTP id
 4fb4d7f45d1cf-5ebcd40b07dmr14710992a12.3.1742880618584; 
 Mon, 24 Mar 2025 22:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfX8qJiGhiAcLmaDEqRh2MT3MYOvj4WEcRdcTgpadea/7gEF6vrLDstcCnsSmhTTQviNA0XQ==
X-Received: by 2002:a05:6402:35c4:b0:5d9:82bc:ad06 with SMTP id
 4fb4d7f45d1cf-5ebcd40b07dmr14710954a12.3.1742880618102; 
 Mon, 24 Mar 2025 22:30:18 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-54.web.vodafone.de. [109.42.49.54])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebcd0c6f47sm7054496a12.52.2025.03.24.22.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 22:30:16 -0700 (PDT)
Message-ID: <6e7af38e-5dcb-4ba9-ab6b-1379504641e7@redhat.com>
Date: Tue, 25 Mar 2025 06:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] target/s390x: Declare
 s390_set_qemu_cpu_model/cpu_list in cpu_models.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250324185837.46506-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/03/2025 19.58, Philippe Mathieu-Daudé wrote:
> Both s390_cpu_list() and s390_set_qemu_cpu_model() are
> defined in cpu_models.c, move their declarations in the
> related "cpu_models.h" header. Use full path to header
> in s390-virtio-ccw.c file.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/cpu.h         | 4 ----
>   target/s390x/cpu_models.h  | 3 +++
>   hw/s390x/s390-virtio-ccw.c | 2 +-
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 5b7992deda6..8dd1936e3e2 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -900,11 +900,7 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>   }
>   
>   
> -/* cpu_models.c */
> -void s390_cpu_list(void);
>   #define cpu_list s390_cpu_list
> -void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
> -                             const S390FeatInit feat_init);
>   
>   
>   /* helper.c */
> diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
> index 71d4bc2dd4a..f701bc0b532 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -113,6 +113,9 @@ static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
>   }
>   S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
>                                       S390FeatBitmap features);
> +void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
> +                             const S390FeatInit feat_init);
> +void s390_cpu_list(void);
>   
>   bool kvm_s390_cpu_models_supported(void);
>   bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 75b32182eb0..4f11c75b625 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -35,7 +35,7 @@
>   #include "hw/s390x/css-bridge.h"
>   #include "hw/s390x/ap-bridge.h"
>   #include "migration/register.h"
> -#include "cpu_models.h"
> +#include "target/s390x/cpu_models.h"
>   #include "hw/nmi.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/s390x/tod.h"

Reviewed-by: Thomas Huth <thuth@redhat.com>


