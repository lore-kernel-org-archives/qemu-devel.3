Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34B8C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdB4L-0000LH-Os; Thu, 22 Feb 2024 10:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdB4K-0000L4-GP
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:33:04 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdB4G-0001Fm-Fp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:33:04 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56559248adcso204662a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708615978; x=1709220778; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYKOw0V2LO8N+rtWpZWayjhzSDOUcSorDpZXhPCifiM=;
 b=g1Yb5Mxe8vhZ9xVeZilYLcO88y3TpWzEbdOb7aAyJEmmf6zNrbjaBiBQIU5qx03X7G
 Mw8e5UFQ4BBLWp7+1l1cvZzb0g17yoEbIeNkdf/hFuZW4/pX6ORsFaiSeatw/uDAaU/m
 z4d/anNbSbF9pO44b6LL4x7IK7dV2WPRaCcbws916Idc4dt9AG3Nit67n1fB5gJv0ZZ0
 zhn4bwA2Lj1BB72L/6fIjOjJCEMLFbZdNqS0MrAong7uGL72yzxaS+M6snn4IngwgYwZ
 o7/hpj+iEr+sVDBVRCxTKk4knYZS0XQ6qX9X2Ki7/ogHTgTnv3ClKtgQ1RQWy5PNYEVv
 R+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615978; x=1709220778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYKOw0V2LO8N+rtWpZWayjhzSDOUcSorDpZXhPCifiM=;
 b=wUArqRtbCLUQOX7H3U2LZNnEylwxsNr8Hwp4WVUKS8PGUIr/orX3pkC9cRkbKtfjZb
 +7Sn7Mj4mBr7+/xgV411o+7xrbmIACSK3rgb2/nWirCbCud/e0Ed8C3ffQLUu9FkrUqi
 WQ3q0GWGiSAx+QM+cKuT6UKTr2hwaS4UEzNUZLXierrpWXORZWI/FzH4XqKHkmvfKGLJ
 XQMVVayWqhNGRCGJkL+TOfNGTJJwz9UIlVzoypf8UJ3sQaDvQI5RSmpagScOiSbPoIkS
 BfZl+A84PS41P3bl7N3MV5wVVPUoAFpcOBVAFPwr56kjN9MlASnc95Xy0mAFwjvoMEB0
 1ggw==
X-Gm-Message-State: AOJu0Yw6EhSWzQuCVsdPpjNpkDg6hLpETbNWIvZBWIgOp2IVdXelLFC9
 qWxCaZug6IPAU38M0LHtWcFG8xe9yoXSkiC2yGac2TmrmldzvULTTCrhznLI3e3LQGTkldNS0Xz
 GDDSkpTjUx+kxDUCEtdZtNTrul/OO/KcjpZ2kNw==
X-Google-Smtp-Source: AGHT+IGxmwaCPlBxITERyQ6qj0sJWu2n0rTrApZtoduUbEb99sSXY7iKcehwUAup0jqoenKlcI9Y0TtBhgm8teMsO88=
X-Received: by 2002:aa7:d358:0:b0:565:4e5c:2815 with SMTP id
 m24-20020aa7d358000000b005654e5c2815mr595347edr.24.1708615978631; Thu, 22 Feb
 2024 07:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 15:32:46 +0000
Message-ID: <CAFEAcA_eJ_uKqU33piABxTw5aeBHUoZ0FDaEvi8aJ+jJu5KK3w@mail.gmail.com>
Subject: Re: [PULL 00/34] Trivial patches for 2024-02-22
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 22 Feb 2024 at 11:29, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-02-20 10:11:08 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 185311130f54ead75c407cdf83004d575829b5d2:
>
>   system/vl: Update description for input grab key (2024-02-22 08:59:16 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2024-02-22
>
> The bulk is a spelling fixes series from Manos Pitsidianakis.
> Plus a few small things in other places.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

