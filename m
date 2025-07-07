Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06362C83F0A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpal-0005OA-LX; Mon, 07 Jul 2025 13:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYpac-0005C1-WB
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYpab-00060z-6D
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751909110;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQci3fqek21R+COSXStaejW9Snm1UGS4WsZYUzf869s=;
 b=c06y2Ervw6/pRlooX3uL5xh3wsAr5NYbBtDHrOpPDIL5O9+xlQ76aAKkpXvrzs+ei1smEi
 r7YR6QyrqFqiZhRd3emN6cHRYG4g5gC1tfsODqelpaMYXCCLl5FazrPxKHSPuWxVlP4q4G
 /dZxdxwhh/YmbMZeYCgwfGLWqZe2g1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-cu3MLIi5MqSF9azdGfqeKw-1; Mon, 07 Jul 2025 13:25:09 -0400
X-MC-Unique: cu3MLIi5MqSF9azdGfqeKw-1
X-Mimecast-MFC-AGG-ID: cu3MLIi5MqSF9azdGfqeKw_1751909108
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso24335585e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751909108; x=1752513908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQci3fqek21R+COSXStaejW9Snm1UGS4WsZYUzf869s=;
 b=WvPQswCnE7RgDqb11UrxTXos9z4GiPIViLn31npNi32kGX/5ycED/Zjly/hjc7BcD6
 QE9D8gd6omcstQvDgL0cWKuvBXXj69Lg1s/9VSOcLKOlIh9dzgL85VZq5gSgWcI0xrSw
 zvTe4rZi01iOosLDdsaP4gtM2rrhRHS6HxVI8CUjKlKl/YUNwv3MDl+ftzWEP5Zxz3nA
 pzGkxBgWuZfau66VgUuAkIfRfIY1b8+hydX5UkGrg7lfGM3b4gJoKkz2DSwPq8TQRXAh
 SLrXEQ/IodtX4IN5qD4iNTtVlsUtK+ariGGCf+0sln/DVnl41wpN/IpBGeS3OVTZOwU5
 cqRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1tWvp4PvZ8WyJ0ye8SivbOWENLdryG3nJEoTE1RgMixkRrVE+9fbSEYb0R7ga2JdvvZ+3Nmcrwimu@nongnu.org
X-Gm-Message-State: AOJu0Ywe+G3eO+/FN8WqfVhmLILhZq2B3SjmkHxpdvDVCFK90+5yaAZR
 4+/wBRjuQN1YjAJFZCcgkDW5ooQIa2A9UiHJaTlN40XRxdOJmX52dXk4Bauec7X/enyep05+E/w
 Kxcoee6//pstLoT1gYB/ZrKIcStgjZ+mdjnf6Csj5YcdjXpxcUKhAorqY
X-Gm-Gg: ASbGncvcPv5Mhv6B+TlhJ99jbKWhgaw4FFgE1c0kNUKJERUngFUBoNdhr8t65g07/b0
 DSHcWPkLLkA5aF6hO4P8TYezNx7JUEUVHNLXLuli0Gjusc1Dl/alNqh0YjLWgAuD7w9LgFI6YPT
 wHenE0/HjZnJojHE4+i4yYBSugLwkdcU33HrzPfKsTHK5JsV+qeWb2ZPnItjFHrXAujOU8Wuj2t
 ICwOR1J/7R7DMIprKDdly9FpsmG4PwXsUEhPwcN7ufqbnJqNlE8Zx1BI5wCycZkYBHgQijZIfgQ
 h4npeMc+I8IxBNXcRKBDtfZgoJthNvUxIaQbDS51Dyba92xYM932gAretL/D0zzsCL45bA==
X-Received: by 2002:a05:600c:a4b:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-454b4ec46d0mr97376245e9.32.1751909107767; 
 Mon, 07 Jul 2025 10:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/qOdixyfNMg7eHc5kapYqDFxEsfkT42QE2VVqGkQQ5n+Urx1WIEiXF9znmKP2B4j9WKI+fA==
X-Received: by 2002:a05:600c:a4b:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-454b4ec46d0mr97375995e9.32.1751909107150; 
 Mon, 07 Jul 2025 10:25:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b162a3ccsm118058915e9.12.2025.07.07.10.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 10:25:06 -0700 (PDT)
Message-ID: <d87b733a-c8d3-4038-9159-60806d5a6186@redhat.com>
Date: Mon, 7 Jul 2025 19:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/intc/arm_gicv3_kvm: Migrate GICD_TYPER2
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Marc Zyngier <maz@kernel.org>
References: <20250707161018.585469-1-peter.maydell@linaro.org>
 <20250707161018.585469-3-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250707161018.585469-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 7/7/25 6:10 PM, Peter Maydell wrote:
> The GICD_TYPER2 register is new for GICv4.1.  As an ID register, we
> migrate it so that on the destination the kernel can check that the
> destination supports the same configuration that the source system
> had.  This avoids confusing behaviour if the user tries to migrate a
> VM from a GICv3 system to a GICv4.1 system or vice-versa.  (In
> practice the inability to migrate between different CPU types
> probably already prevented this.)
>
> Note that older kernels pre-dating GICv4.1 support in the KVM GIC
> will just ignore whatever userspace writes to GICD_TYPER2, so
> migration where the destination is one of those kernels won't have
> this safety-check.
>
> (The reporting of a mismatch will be a bit clunky, because this
> file currently uses error_abort for all failures to write the
> data to the kernel. Ideally we would fix this by making them
> propagate the failure information back up to the post_load hook
> return value, to cause a migration failure.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/intc/arm_gicv3_common.h |  6 ++++++
>  hw/intc/arm_gicv3_common.c         | 24 ++++++++++++++++++++++++
>  hw/intc/arm_gicv3_kvm.c            |  6 ++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index a3d6a0e5077..bcbcae1fbe7 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -267,6 +267,12 @@ struct GICv3State {
>      GICv3CPUState *gicd_irouter_target[GICV3_MAXIRQ];
>      uint32_t gicd_nsacr[DIV_ROUND_UP(GICV3_MAXIRQ, 16)];
>  
> +    /*
> +     * GICv4.1 extended ID information. This is currently only needed
> +     * for migration of a KVM GIC.
> +     */
> +    uint32_t gicd_typer2;
> +
>      GICv3CPUState *cpu;
>      /* List of all ITSes connected to this GIC */
>      GPtrArray *itslist;
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 1cee68193ca..7b09771310e 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -275,6 +275,29 @@ const VMStateDescription vmstate_gicv3_gicd_nmi = {
>      }
>  };
>  
> +static bool gicv3_typer2_needed(void *opaque)
> +{
> +    /*
> +     * GICD_TYPER2 ID register for GICv4.1. Was RES0 for
> +     * GICv3 and GICv4.0; don't migrate if zero for backwards
> +     * compatibility.
> +     */
> +    GICv3State *cs = opaque;
> +
> +    return cs->gicd_typer2 != 0;
> +}
> +
> +const VMStateDescription vmstate_gicv3_gicd_typer2 = {
> +    .name = "arm_gicv3/gicd_typer2",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = gicv3_typer2_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(gicd_typer2, GICv3State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_gicv3 = {
>      .name = "arm_gicv3",
>      .version_id = 1,
> @@ -304,6 +327,7 @@ static const VMStateDescription vmstate_gicv3 = {
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gicv3_gicd_no_migration_shift_bug,
>          &vmstate_gicv3_gicd_nmi,
> +        &vmstate_gicv3_gicd_typer2,
>          NULL
>      }
>  };
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 3be3bf6c28d..0302beb0c07 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -332,6 +332,9 @@ static void kvm_arm_gicv3_put(GICv3State *s)
>      kvm_gicr_access(s, GICR_TYPER + 4, 0, &regh, false);
>      redist_typer = ((uint64_t)regh << 32) | regl;
>  
> +    reg = s->gicd_typer2;
> +    kvm_gicd_access(s, GICD_TYPER2, &reg, true);
> +
I don't know if there is any rationale about the access order. I see
most of the dist reg accesses are done below in the function after rdist
ones, although the GICD_CTLR is also here. If there is a rationale a
comment may be useful to avoid another dev to do something wrong. I
remember that for the ITS for instance some speicifc ordering needed to
be enforced.

While at it you can also fix the missing bracket at
 /* Distributor state (shared between all CPUs */

same remark on the guest side and same missing bracket ;-)
>      reg = s->gicd_ctlr;
>      kvm_gicd_access(s, GICD_CTLR, &reg, true);
>  
> @@ -519,6 +522,9 @@ static void kvm_arm_gicv3_get(GICv3State *s)
>      kvm_gicr_access(s, GICR_TYPER + 4, 0, &regh, false);
>      redist_typer = ((uint64_t)regh << 32) | regl;
>  
> +    kvm_gicd_access(s, GICD_TYPER2, &reg, false);
> +    s->gicd_typer2 = reg;
> +
>      kvm_gicd_access(s, GICD_CTLR, &reg, false);
>      s->gicd_ctlr = reg;
>  
Others looks good to me

Eric


