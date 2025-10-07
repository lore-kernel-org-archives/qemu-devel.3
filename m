Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D1ECCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68e3-000825-Tl; Tue, 07 Oct 2025 10:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68e1-0007zC-3U
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:26:25 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68dy-0004or-3D
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:26:24 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-635401a8f5aso6889003d50.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759847175; x=1760451975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dI/+xF9c5C0CJKAVVpvG45vrmOQqi9/gLVngvJOEKeI=;
 b=aXLXLkZVxL0T/SArAeNPOvgMHkc8vUQcB9gNKLQ6OdBCF5qtmlusaoWAiUyv6q5NHA
 cCXR5Mb/WPTKfib57Dnjgb9Z+S99OWTBIexgCTyTpTvZNAzFlU7QA5/nKPI6VJgeJX4B
 3LIbnRUeuWAsAWkCw/mDk+mnhyAIVkRN4D/6jQKVyY6aD6gvQB6F/8eU39EUWsDMJvbQ
 KE9sqz5XbKsZrkRwp9S3yd6spOikGLOKFyE4+vYFSFUtSotrxoh8zxZFmF8yq6m7XvMQ
 eFdV1Itsgr6Z7w/ad98YaqrGvuIYkabG9NhHVaMo/pC7GUL1XuHhYmi32J53T6kOGBNe
 qSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759847175; x=1760451975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dI/+xF9c5C0CJKAVVpvG45vrmOQqi9/gLVngvJOEKeI=;
 b=ty8gBZewUrXDJUqE0JNd2ITndqhtVX8/oawQQO0RRaqNaDupGcvQNpw6nCy9y86251
 1IgOmcbb1mdT4KZMXaf2WK6QAFmNuLFCf7+s5BC8M+KKzNWbsGf+XP/beQZluPWMhKO2
 3ddBjbqoABYuSFzz2aNG8cGPxDK9L89Q+pneilXJuu5a4/Ygpur8K8ZaVTNU9PK6m5Hh
 Xtd2xmvokbdHwNGXfaRG6XHTeZH3KUqS/YOv2dSaG1/27XwCa5TCSXhnJr7S5AUHLFEF
 IH7099PCmqYvtK2Rv1w60geShhuZ62ST/CVuadsVj53katjATK0z7ANOT/141WyBswC2
 14Pw==
X-Gm-Message-State: AOJu0Yz6UhKFyl1AXtlcLk1jUVMwJEmQ5wFiH6MuLnea7ZUCvInN3f9r
 T6DLVjwEta1CqlXbMq0ClfbI3SwioGHqzw76n3DoNmvr4363VoZ4R8aZ9Ve1QyiNm8m2w6YWdVc
 jVPVDbvCxLxZYv4nV0vuvB3VL7Cs0aIMxzWmkZE1EZQ==
X-Gm-Gg: ASbGncumCtUbXj9bm0cKgnTMDLnfdl6rotTER7cCpW0xRwPgfpXkNVOlUasnCjvodxT
 uNn6obzNN8FkQQVi5H3N3g9tundPCRuCIBA8je6Ha/xGjIVDsqMQV3hl4p24vpCZItJKlVSIG0R
 fS/+O8kdY+QMpsK6zBPzGX1p4e2B32TOooDnlF+YIa9tCPf4qNM+BtC9qf6W3IQhtJoRePFDKhh
 3cyVB4m2WE8AhJMuhL7KNARpN12kMvJCxHZBdK7tydarBs=
X-Google-Smtp-Source: AGHT+IHzKTljwEunbKa+FNSKjQrRQv0JLDroM+spja3yji1VjMK604lmHohapAMidHKA6m+C719l2pAnPYt/PuBFTAc=
X-Received: by 2002:a53:bbc2:0:b0:63b:7b61:df69 with SMTP id
 956f58d0204a3-63b9a10aaccmr12960332d50.47.1759847175072; Tue, 07 Oct 2025
 07:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251003170800.997167-1-richard.henderson@linaro.org>
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 15:26:03 +0100
X-Gm-Features: AS18NWCtxZ978AAkLjYesGD7o8LHFxdwT1LxsOHfDcai8k6qPFi2zkyrmF7gdus
Message-ID: <CAFEAcA_=B12vT2UOSBH2O209agNxNCrzONbQp08q=wiZ_036AQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/73] target/arm: Implement FEAT_GCS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 3 Oct 2025 at 18:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes from v5:
>   - Master now includes the accel/tcg/ patches.
>   - Updated TF-A/TF-RMM tests for FEAT_S1PIE and FEAT_GCS.
>
> Patches lacking review:
>   34-target-arm-Make-helper_exception_return-system-on.patch
>   35-target-arm-Export-cpsr_-read_for-write_from-_spsr.patch
>   38-target-arm-Add-arm_hcr_el2_nvx_eff.patch
>   39-target-arm-Use-arm_hcr_el2_nvx_eff-in-access_nv1.patch
>   40-target-arm-Split-out-access_nv1_with_nvx.patch
>   48-target-arm-Implement-GCSPUSHM.patch


I've reviewed these; other than the 32 vs 4 array size thing I
think we're good to go. I've put the FEAT_RME_GPC2 series that
you reckoned would conflict with this into the arm pullreq I
just sent out, so once that's upstream if you send out a
rebased series we can get it in fairly quickly I think.

thanks
-- PMM

