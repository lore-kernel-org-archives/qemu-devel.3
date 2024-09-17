Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BCCCAC580
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqZVv-0005jW-QX; Tue, 17 Sep 2024 10:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZVt-0005gG-JP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:49:09 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZVs-00035M-2T
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:49:09 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-536584f6c84so7122039e87.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726584546; x=1727189346; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MgW8Dmc0EyT5RPvm+iEVwzlDSht+yrTrpS5okgVEKXU=;
 b=QXPrqt6Cr9k+c8wsMoJsbbdwX4Xs/CmR9nOgknDZHOp8oGDwy2ChVH4j/+AoAPttyi
 IfLUXzBzPLTm0hjZ8GF806+GviFZQm9ENF43mYWTbQdIMcg5mDuAeM7pKlHEqa8YwC/Z
 rcTUjKyMhNf81Vk1UUxBOwLxwDbAL09LgwX2oNGfLc0Ji+T5tfRqBiEESu/sthnKuxAG
 Biq37D3fjMDO/b/uNUqFEgZpJ56Mv9/RcTlUH0Y9iOye2M3pcXbIZx7n8BvQmHpn3feP
 VQaK5fC1ni+6xLxgMpDs+4PBs+eIW2xo3WQZuKzaHy0PrKR+SyPmAfxBHjh4VjH7ubid
 N1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726584546; x=1727189346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MgW8Dmc0EyT5RPvm+iEVwzlDSht+yrTrpS5okgVEKXU=;
 b=bDO99bOsYdl77GdkuVqsq2vTGDRipE9TBXHsbimSaZa4Rd621PIE+TK3Ksy4IfZnor
 dOxdnx+TAxVt/OIhh/IZtG9Vuu6v9O+WPXQ/g8flwwLtAd9eelVD2INLM73ddQKEYqDX
 8YOldf3gCvjuNS4IAituaK+68TynS+3lFvv3EAr8Hr6BYXMxzcKl8zQGm9Wg8jEJBktQ
 DuMIUFgMkIF/3kc3Gh0qE1v5/PZlJP9pDml4rEL32u3s21NDkqRtiqkpRW3z0D5up8hj
 O/ZwLmbhcQDUtOb7+GhyB0YKfun0EOc9mwhNAJFSfdg7kiiP7msM0iKSu86FMslPbx2g
 bmfA==
X-Gm-Message-State: AOJu0YzWdJcoDrWNCf7zPJKJRCnw8vFbo6yxaeQgtUurYVkyeXSzpLbF
 1+4b2Dm6WPV8WmrYCF5SJ/op6WPLGoZs7x0vVBm0i208HzhuiRW9HtjFJvyo3Ff7wrfDmYj+z/f
 sdNrmY/2WeKU5UFu22qUhxW4M51guYyIqGhpHjQ==
X-Google-Smtp-Source: AGHT+IF9meMcbbefXFxI+Jq0tySOsPyCWmrQq46T5MDu9f6c3krcdR7MZIW55kPVwqRM+8Y/pGWwK3T2F1gn0WYfgvQ=
X-Received: by 2002:a05:6512:3056:b0:52e:fefe:49c9 with SMTP id
 2adb3069b0e04-53678fd185bmr11364657e87.36.1726584545905; Tue, 17 Sep 2024
 07:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240917114313.616836-1-stefanha@redhat.com>
In-Reply-To: <20240917114313.616836-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 15:48:55 +0100
Message-ID: <CAFEAcA8p3MFCga9pu5LzmT+Qsxr-SSzyfppHe+Gt6NOLLGPPRA@mail.gmail.com>
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Tue, 17 Sept 2024 at 12:44, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a:
>
>   Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into staging (2024-09-15 18:27:40 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 89cd6254b80784a1b3f574407192493ef92fe65f:
>
>   hw/block: fix uint32 overflow (2024-09-17 12:12:30 +0200)
>
> ----------------------------------------------------------------
> Pull request
>
> An integer overflow fix for the last zone on a zoned block device whose
> capacity is not a multiple of the zone size.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

