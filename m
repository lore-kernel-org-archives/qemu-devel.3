Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D82CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64hM-0004b2-Rq; Tue, 07 Oct 2025 06:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64hL-0004am-2F
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:13:35 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64hJ-0005fC-Hw
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:13:34 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-633bca5451cso6371705d50.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759832012; x=1760436812; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MU2SNYZpn/hA1jxyI/T3LhwbWp9Pf3dNlmcOfsZd9CM=;
 b=ZiAQROiLzJxBc340AOh8TbhRu8iPKW3PcKmNVM9NWTPaSLuIwlnbnELBIoZX8fwfLq
 G2ffM81gcGcH4Yhc+6hUJTqmOUaL5WpSf4tBb4jqFzqFeRIGhqkv74kNzXsHzVjnr6lq
 1ZJHsHB5a9Zl3o/O2PQ77EWe7kWG3ZczYb2QpKDP0BQ7ufM09vBuBtVQFjQWXNrq1OAN
 3iVUlnr9g08Zn4nGTiWajam8kSGcoF3FnsFDFnef3Q1iskUv0XLSo3SK/M0yozqGRcYG
 k3+SoymwsYvSdpzVGl1068h3BIHuaL2kC3f2TvgS+05ltsr09hdt1a+OdodNZVlobUJH
 b6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759832012; x=1760436812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MU2SNYZpn/hA1jxyI/T3LhwbWp9Pf3dNlmcOfsZd9CM=;
 b=Loo+CxSThUM+knurifHZOuEvTKlPdpKpjwSe6XGnlHNwxx1oUA9BDcaUerLVH+F+cl
 YZy9uPNszJLKrG0Yjf0b477prNcMatLgL5bYgOx49AOSMyVx64j/eTKXG8P3hyZScN8l
 CbvMyaynFZon41iWjHWQK0ln9gLeHQUVCW8PMgHZN9lQjFQB1deKTWZ4NBStastGNAYB
 fFfROQtZd3vTHWVxGJtSGUuRFGPdVpyb1VN9cs9MoGb08d2MfPhTQtpGcshpaMSGYj/x
 WZnjFsFx7EOPEpuSbRCParVgA6hO8bq8KhdLuO3neqe/LiXPA7gLwAT43+V0XRVadDzz
 h3NQ==
X-Gm-Message-State: AOJu0YyZc/n91SYcoJV7FBKKLwvU0qICvQFszrXioqCnuRoGsWj2ikUJ
 t4Jx8ie5BsSr9MaPDmVOikMl5EnSPwdRKC5gyNI60ejH42ydzE+Xc56AFKS6yAII7wP1i9FxbWz
 RptzokEln/c8PShpnX4Ynj6vg2g8ANwSeGJf96/grqA==
X-Gm-Gg: ASbGnct2/yFnHIMbshiE/hqD23ZrA+U/8C8jjECoZWrxi1Zr7tFGWjYU4vPD1Dtm/Je
 ZG/z3VXGu4ed9IUcL/L8jIOmbERgbjp10wpE9KCRQIaCWyicGCJM0EGQTA4THZ2AMQo4ZbA1yGm
 2NQdh2zvXEHBoOQbcdnUFh3lSJX+ix5276VoL7lwKj0iZGy8XIfF+lftfo1aq8Vepl397x6dA2u
 K+IBgmhwUPc0QKjSBBdqE/1GEbsrXJ8icOi
X-Google-Smtp-Source: AGHT+IGSyA7h4JkuIhXWF8AJj7jwP0nk0r0UGmxuI+FsGWY9MOTlbK3LBlq76PCz9ulHyv+hona9kf8bJ72o0Z1akXI=
X-Received: by 2002:a53:c40d:0:b0:636:1fd9:1bc with SMTP id
 956f58d0204a3-63b9a060cbbmr9929473d50.8.1759832012052; Tue, 07 Oct 2025
 03:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251003170800.997167-1-richard.henderson@linaro.org>
 <20251003170800.997167-39-richard.henderson@linaro.org>
In-Reply-To: <20251003170800.997167-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 11:13:20 +0100
X-Gm-Features: AS18NWBlNgrnsKg8CRJZ0w1WHOOTpWO9DgSuUWsSpP6nqVKKYYwH08v0KfkuOss
Message-ID: <CAFEAcA_7iEN6VqXW=urCG6=wB2=Xgt1WMp0yxpJnd_34hddL2w@mail.gmail.com>
Subject: Re: [PATCH v6 38/73] target/arm: Add arm_hcr_el2_nvx_eff
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 3 Oct 2025 at 18:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement the pseudocode function EffectiveHCR_EL2_NVx.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

