Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F4C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 17:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPQhJ-0001f5-QK; Thu, 04 Jul 2024 13:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQhH-0001eG-N4
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:56:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQhG-00057V-1Q
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:56:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367975543a8so580520f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720115799; x=1720720599; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2uba2BfP6iG9Wk4uJoNKMxlW7ISWFqPZV3/BU965vT0=;
 b=rk/I2MkmwZfnr9BJBbN/a9mLkqdzLopMmt+UAlqYYs0jmJCMOLdykc4hnhHmZUlhvo
 tyxmwXcu5N5aSbila37ZMF4lzUZgOEEMGJsEvdwu78Mftc93Xot5Zeg7lLw+B22V8u99
 XIvtf7udg6Q4LeKS57NjMdUSz2GDkb0Q5N43nJrxhEr5HRgDGmJnc4BxgeAhtBrAZvJj
 g6L4UZRzJ+fGKnMnmIX3GTr+jV7BVhRNFyfg83FBxe78pHtIpzrL55AbamAuGf2/JJ11
 ZP0v3+PAtmJm7SlVFPizWNhGK4ugAXvcuv3C6O5BtRkflCUcrEgFnmmvZ/j13Meufzbo
 YK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720115799; x=1720720599;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uba2BfP6iG9Wk4uJoNKMxlW7ISWFqPZV3/BU965vT0=;
 b=t6pzr8NE/QG2PuPJtogci2rNUzUhlG/O9R0FvW2vCyHkuj0BEh6XZj6i1POq+XeV06
 RmiV6hu6WSrhR9PUiz30YihGQtCKyaCWVJR39HICerKB5DBO5Zn4OqOAabTaJyNWmIIK
 YmjqMF60GLTkwkOU3bOx9DSL3IWvRlymTM/kCklbDNdazq67xV8FHv3mYn5gA4QdlbMC
 9Hx6qx+vkW32sZGl0NMmFo3WkmKBN89/dARfJhX5hIYFflud9Z03fcHa8YEEn1tM4Vtx
 fAh7kHgguVg1I0m98yAh+WUfyge2IL+ewVZkJKZ2d5TebyYHt/hQIcrvjqKP7KMEMLQz
 xKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgMnTS9uJwFLeZ+WHO1IV0JeFT0+N42oigZl0hb9AM+Yc1919Na847Frd+97pSzN4nwcrCypD3y23fO3t6NLeFStF5Scg=
X-Gm-Message-State: AOJu0YyzqUxZeRA0CpUlJ737tXISFbKOYPz4yBO17ZRwkuJ5WUHRsRcg
 VBdiEfBWVE2LW9WD6AH7SBpd6cTWv4wQX5zRKeLXMP4aFWuYQAcTnTiGm9NghGk=
X-Google-Smtp-Source: AGHT+IHcRdCgPrf2lHbhNyGyyCy6bgp35UfJI3iUUWMUnCljydY+Ok/dxEQ/+xpFau3KpMXCYCZ57Q==
X-Received: by 2002:adf:fa04:0:b0:367:9b8a:b76b with SMTP id
 ffacd0b85a97d-3679dd80341mr1745075f8f.57.1720115799361; 
 Thu, 04 Jul 2024 10:56:39 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36789fd7a0esm7194768f8f.104.2024.07.04.10.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 10:56:39 -0700 (PDT)
Date: Thu, 4 Jul 2024 18:56:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 02/19] hw/arm/smmu: Fix IPA for stage-2 events
Message-ID: <20240704175652.GB1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-3-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701110241.2005222-3-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 01, 2024 at 11:02:24AM +0000, Mostafa Saleh wrote:
> For the following events (ARM IHI 0070 F.b - 7.3 Event records):
> - F_TRANSLATION
> - F_ACCESS
> - F_PERMISSION
> - F_ADDR_SIZE
> 
> If fault occurs at stage 2, S2 == 1 and:
>   - If translating an IPA for a transaction (whether by input to
>     stage 2-only configuration, or after successful stage 1 translation),
>     CLASS == IN, and IPA is provided.
> 
> At the moment only CLASS == IN is used which indicates input
> translation.
> 
> However, this was not implemented correctly, as for stage 2, the code
> only sets the  S2 bit but not the IPA.
> 
> This field has the same bits as FetchAddr in F_WALK_EABT which is
> populated correctly, so we don’t change that.
> The setting of this field should be done from the walker as the IPA address
> wouldn't be known in case of nesting.
> 
> For stage 1, the spec says:
>   If fault occurs at stage 1, S2 == 0 and:
>   CLASS == IN, IPA is UNKNOWN.
> 
> So, no need to set it to for stage 1, as ptw_info is initialised by zero in
> smmuv3_translate().
> 
> Fixes: e703f7076a “hw/arm/smmuv3: Add page table walk for stage-2”
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/arm/smmu-common.c | 10 ++++++----
>  hw/arm/smmuv3.c      |  4 ++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index eb2356bc35..8a8c718e6b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -448,7 +448,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>       */
>      if (ipa >= (1ULL << inputsize)) {
>          info->type = SMMU_PTW_ERR_TRANSLATION;
> -        goto error;
> +        goto error_ipa;
>      }
>  
>      while (level < VMSA_LEVELS) {
> @@ -494,13 +494,13 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>           */
>          if (!PTE_AF(pte) && !cfg->s2cfg.affd) {
>              info->type = SMMU_PTW_ERR_ACCESS;
> -            goto error;
> +            goto error_ipa;
>          }
>  
>          s2ap = PTE_AP(pte);
>          if (is_permission_fault_s2(s2ap, perm)) {
>              info->type = SMMU_PTW_ERR_PERMISSION;
> -            goto error;
> +            goto error_ipa;
>          }
>  
>          /*
> @@ -509,7 +509,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>           */
>          if (gpa >= (1ULL << cfg->s2cfg.eff_ps)) {
>              info->type = SMMU_PTW_ERR_ADDR_SIZE;
> -            goto error;
> +            goto error_ipa;
>          }
>  
>          tlbe->entry.translated_addr = gpa;
> @@ -522,6 +522,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>      }
>      info->type = SMMU_PTW_ERR_TRANSLATION;
>  
> +error_ipa:
> +    info->addr = ipa;
>  error:
>      info->stage = 2;
>      tlbe->entry.perm = IOMMU_NONE;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2d1e0d55ec..9dd3ea48e4 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -949,6 +949,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_TRANSLATION;
>                  event.u.f_translation.addr = addr;
> +                event.u.f_translation.addr2 = ptw_info.addr;
>                  event.u.f_translation.rnw = flag & 0x1;
>              }
>              break;
> @@ -956,6 +957,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_ADDR_SIZE;
>                  event.u.f_addr_size.addr = addr;
> +                event.u.f_addr_size.addr2 = ptw_info.addr;
>                  event.u.f_addr_size.rnw = flag & 0x1;
>              }
>              break;
> @@ -963,6 +965,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_ACCESS;
>                  event.u.f_access.addr = addr;
> +                event.u.f_access.addr2 = ptw_info.addr;
>                  event.u.f_access.rnw = flag & 0x1;
>              }
>              break;
> @@ -970,6 +973,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_PERMISSION;
>                  event.u.f_permission.addr = addr;
> +                event.u.f_permission.addr2 = ptw_info.addr;
>                  event.u.f_permission.rnw = flag & 0x1;
>              }
>              break;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

