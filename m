Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B08B1075286
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w39ox-0000KV-Jj; Thu, 19 Mar 2026 05:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w39ov-0000KA-Bp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w39ot-0004X1-Nt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773913054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGaE7payo31vN5nckUePWJzlNeeZUJn0LKB0Ltt7P2s=;
 b=NROyUF7AhX3IJ8iGbE7e5YRyTx1Dt9mIHaMkArAwYJOtMZDeTLih0IO4mDRAdHwXL/xuiG
 vJyloS6vl4+f9BKXBAufy1SGeg0oa/e/qx/XKFqcFjK0IGwpgrqv4MUQ8QaTm7v1eIACxy
 Jg6e58uYelWeVIUAWHBVmh6o+gZ2XW4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-xysIVyBNMou703fPY5UbSQ-1; Thu, 19 Mar 2026 05:37:33 -0400
X-MC-Unique: xysIVyBNMou703fPY5UbSQ-1
X-Mimecast-MFC-AGG-ID: xysIVyBNMou703fPY5UbSQ_1773913052
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853553944fso5798785e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 02:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913052; x=1774517852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGaE7payo31vN5nckUePWJzlNeeZUJn0LKB0Ltt7P2s=;
 b=QAsjXWlWpY2z+e6r1H+OPdqi+/6fuBobisuSeW2X7L1UDoTbAHznUrArWlXrkLuFr4
 ctxGcvqxZuLkUH4uSDsAKkmhG+ntg0v7EbQBNffFNQlw0FCCiJbcA6LC5hg0//QviXbb
 +SUU+PCcSQzXgHluSYZ33+s1P/NMFfj1IW7U+GH4RNGKpS+0X2S9owrjTGebDv6LatQp
 YuxH47mIOB4rj9ciHIjNIvfTGH9P06pEWda3xj8I7nV0vkJtrI6wkUs7XKmv933B9PC/
 svK0FHTdPzlaCczYdU+bP+WSbCERHivsbl6yGoxLlyGQwjD6q83bhSh6d14qD6Yf0vpc
 nRkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcJlGM9+EynpXWBy0qcG6fofpvfr5cPym20EAbnNRaWyiCh9uLMxJOXGtEooymVV38q9hvoI0Thoh9@nongnu.org
X-Gm-Message-State: AOJu0YzJjZozaiiHHQdmg/VWQCJta480zH6w7nQiZPmz7+cEwCwbbaEI
 PdxGk33HICcfu2GtoZC1Ad3/QMwEVE+8BVY8XcJ7/oEQXvnSQc/BJDCpQ/a4c0QSSPV9j4zhRVj
 4H8MHAAOKkd7mGG26I/5cSf2oYAtG1ceJjAA0VbFvg4NAPB76NGiYD0pl
X-Gm-Gg: ATEYQzxZiws6xWoAc9mEPSIe+zMoivljIvA2uW4d+Qm4X37+8FmGaghUK/HCrq58jZm
 mqd4GHMXau6y20hkLMeSjhYd6g45xh2rDFAiKRASfRQ/Twh/Ws++gWXxcdaTwbXuGRnW2BZNLqK
 Cv04E/zOOI9l9dr2RSUGNv8oeyz/wRCU04Tsyq0MsPcpglmsxIgCsBi2KkoNh6/o1E2WLuqaXOS
 SixdqLpKL4PxOYfT1smopaxoh7GcfZfKkk0z91+ZYjg6Sek0ElmMXRpBheFEIabfx07UBGdyxqy
 n1mJM49zVFvyYQIh+3qwbvoruaw+V8w/pMMOcntCEV9VC9uCI7IIMh0h/ckK9UUmrazgPx0SWOW
 mdDzFNmbsXf0jgYLXm5qzgGRcBm5JY5XJ/SUuwqq6dMuE9a0oSc8t8uS/Pty3zSj+X2dKjg==
X-Received: by 2002:a05:600c:64c3:b0:485:38f1:5cec with SMTP id
 5b1f17b1804b1-486f8b324a1mr42322965e9.7.1773913052149; 
 Thu, 19 Mar 2026 02:37:32 -0700 (PDT)
X-Received: by 2002:a05:600c:64c3:b0:485:38f1:5cec with SMTP id
 5b1f17b1804b1-486f8b324a1mr42322485e9.7.1773913051633; 
 Thu, 19 Mar 2026 02:37:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fc3b98f2sm17799505e9.14.2026.03.19.02.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 02:37:30 -0700 (PDT)
Message-ID: <7f14c3d4-4d46-4c03-b977-d5b57d7845bd@redhat.com>
Date: Thu, 19 Mar 2026 10:37:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/arm/smmuv3-accel: Change RIL property to
 OnOffAuto
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-4-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260318184907.4060030-4-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/18/26 7:49 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Change accel SMMUv3 RIL property from bool to OnOffAuto. The 'auto'
> value is not implemented, as this commit is meant to set the property
> to the correct type and avoid breaking JSON/QMP when the auto mode is
> introduced. A future patch will implement resolution of the 'auto'
> value to match the host SMMUv3 RIL support.
>
> Fixes: bd715ff5bda9 ("hw/arm/smmuv3-accel: Add a property to specify RIL support")
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c   |  6 ++++--
>  hw/arm/smmuv3.c         | 11 ++++++++---
>  include/hw/arm/smmuv3.h |  2 +-
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index f21a6a9997..c31b64295e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -823,8 +823,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>          return;
>      }
>  
> -    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
> -    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
> +    /* Only override RIL if user explicitly set OFF */
> +    if (s->ril == ON_OFF_AUTO_OFF) {
> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
> +    }
>  
>      /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>      if (s->ats == ON_OFF_AUTO_ON) {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a683402a0c..ea285bdf64 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1975,9 +1975,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "ats auto mode is not supported");
>          return false;
>      }
> +    if (s->ril == ON_OFF_AUTO_AUTO) {
> +        error_setg(errp, "ril auto mode is not supported");
> +        return false;
> +    }
>  
>      if (!s->accel) {
> -        if (!s->ril) {
> +        if (s->ril == ON_OFF_AUTO_OFF) {
>              error_setg(errp, "ril can only be disabled if accel=on");
>              return false;
>          }
> @@ -2137,7 +2141,7 @@ static const Property smmuv3_properties[] = {
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> @@ -2167,7 +2171,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>          "configured in nested mode for vfio-pci dev assignment");
>      object_class_property_set_description(klass, "ril",
> -        "Disable range invalidation support (for accel=on)");
> +        "Disable range invalidation support (for accel=on). ril=auto "
> +        "is not supported.");
>      object_class_property_set_description(klass, "ats",
>          "Enable/disable ATS support (for accel=on). Please ensure host "
>          "platform has ATS support before enabling this. ats=auto is not "
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ce51a5b9b4..c35e599bbc 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,7 +69,7 @@ struct SMMUv3State {
>      struct SMMUv3AccelState *s_accel;
>      uint64_t msi_gpa;
>      Error *migration_blocker;
> -    bool ril;
> +    OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
>      uint8_t ssidsize;


