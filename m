Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDEECCD1A1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KVR-0008As-RP; Thu, 16 Oct 2025 05:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9KVQ-0008Ab-75
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:42:44 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9KVI-0003A7-Ur
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:42:42 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-63cd60ca2b2so621269d50.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760607755; x=1761212555; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V6rOswSehswh0XIgMOOQrsdytpAZ+iR4TYOhcF6U7ZQ=;
 b=EuBUKcdccRkc7MxiPp0TO05dRd/ArtUP5D1M+xeYUF2WJ79KTjiIAd4eKof1GIqfk5
 QYKLI2rkyQZ4Rj7KQ9g2n8fQnFJAITTbwj4n4Jhfqv92ZtQ654VNlImMeDHx0yN63Hnk
 H0DirK/y/RBKya/XKnUEHViwgcl4n6iC+BIsehBoOUQHmpgfjIdHPrvUz4IWz3fh824r
 QXCgKQeT7b7J13shEII5LgumJsZzbAVZDHy5eFCpRvNKV+wKTuGHPAqLQmiSTSd2+w8s
 Ie7rda6D4G/Xc7c0dB+l74SmADEZ0rhWIdvnsbx8jpH4gtdNyRCJe4pDqqWtltoI8skr
 xlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760607755; x=1761212555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V6rOswSehswh0XIgMOOQrsdytpAZ+iR4TYOhcF6U7ZQ=;
 b=hV7ud3Ca0njd3ZuckYwyXgdBvC+pjtdVUzJWqDg6vALLqunP0C/TtEW7nuUXLcTpL5
 JfE0Eg5O8GBmwFU6+EFECxgfenXOHLfyDcqg4tYqds/N8Ge1LrQ9KSNL6dmHJYv5Qw54
 /pn/VVvSQ2jxPXzT4FeLRwCaTMfeyKC7Hjvr1Mk3+0O8n1QQILT4Gv757ULHDHXvkRFj
 AXF67OwVuV4fHi/ZEOSV9rwBeVOLRlFhFPb1S7j/B9ZbQ6du+5ZurblP/Acr18cooAlB
 kAkcVteIVuOFUsCfhnfCeh4DQisjc7cKT5T+bPwRvrJzcMQqq7pEp7Xyib5bgAKBmE51
 1ntA==
X-Gm-Message-State: AOJu0Ywl19zYH2G1A5qfYf9zDejIKfpWrkodXA6EJou6hMVfecyuLAHS
 QfEZ1CrxBI146s85hGBi+kjVi/0lnekgxs5Qf812/9sdVoddA0wa5OoFstKnK7bUYc9XRqE+E7c
 vXQiFDMhmxO2Y+F/BDj+N9Q2wvUte/kLSIMsFiVv9MP8gENlyVQyg
X-Gm-Gg: ASbGncv+nwT7labjUHjE19V3SjOumMvUcYiNbPSjrgwHWnXWyv6Upv8qecNzUwgJFcu
 58mlLIslYuMyamAktrjphwJwUpy4rpecKD6Ae3AXBewx3cJzoyXieET4jduCbBDEqM8K38Ofct8
 AmaI94O0TgEElB+Zu1C9d8DX4LpX2KSaTE0XWncWuOtTtNmZM4GeL03QyBYCDkazGob0DyhQzPa
 ELGJ2h1/QtUckWUMxLSPKpr1VELxQSUhCSTHrA9Acde+ogGDGGG01l0jx1u0a2V0A==
X-Google-Smtp-Source: AGHT+IFCXbmvh4mNTeiCOeqBezWjctrUf2+bf/buK/iCka9aUTo/uH1NjlIpgeLbXNIs28qMqwOzFvKDHVW3xc3964o=
X-Received: by 2002:a05:690e:1287:b0:63e:12d7:8f35 with SMTP id
 956f58d0204a3-63e12d79256mr206375d50.49.1760607754958; Thu, 16 Oct 2025
 02:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251014195017.421681-1-richard.henderson@linaro.org>
In-Reply-To: <20251014195017.421681-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 10:42:23 +0100
X-Gm-Features: AS18NWC8K0ufqNl7Cgw4af0HhhAnRft205TH4114Baj3fD58ykMu5ZGK5myrOHc
Message-ID: <CAFEAcA-tT_CH-SM2q58EcZnKNW+wtWF71wywJ88+qtPaRNRj0g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] target/arm: Implement FEAT_AIE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 14 Oct 2025 at 20:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This feature adds new registers so that we can support 16 attribute
> indirection indexes.  It is a pre-requisite for FEAT_D128.
>
> Changes for v2:
>   - Update arm_emulate_firmware_reset.
>
> r~
>
> Richard Henderson (7):
>   target/arm: Add isar feature test for FEAT_AIE
>   target/arm: Implement MAIR2_ELx and AMAIR2_ELx
>   target/arm: Add AIE to ARMVAParameters
>   target/arm: Drop trivial assert vs attrindx
>   target/arm: Use el local indexing mair_el
>   target/arm: Honor param.aie in get_phys_addr_lpae
>   target/arm: Enable FEAT_AIE for -cpu max
>



Applied to target-arm.next, thanks.

-- PMM

