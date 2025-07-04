Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CD9C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXg59-0003sZ-2p; Fri, 04 Jul 2025 09:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXg57-0003rv-8y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:03:57 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXg54-00016R-IF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:03:57 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8600a33792so605686276.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751634232; x=1752239032; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwW+K+s3MMXLuj1meDNa1wI7pdgz+LYYco3rFHvLV30=;
 b=iqg0By+ETE0jD2tbCNtDvfApIcZSpXEJClSMxWaEb6gTiUKvOMnGQ9jKgx1aUZBgun
 svHJjtl6UHlFInuOAx6rLF12gxlyAx7FSjX3RQDKuiFclyArn6Sjh+q3h9pzRxcWModt
 xSZ1eiJjkC7vj90d6EVH3XWVwY6PxKWA83qAFeXb/8a9gLO8UiW910GvUQYxPxanieIm
 BrwLIKohJrlX/Jlwb88vViNuamStObOa4URXbPl75qNoh9Hm0yM9HQaopxyqAYBQNEJ8
 iAgzhmRSfRgXRzmsG76efLf1Z5lFlBNC3VpYTdhlTrd6XTfeIgzsT7hYuxwnJg8sR2Aq
 5y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751634232; x=1752239032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FwW+K+s3MMXLuj1meDNa1wI7pdgz+LYYco3rFHvLV30=;
 b=byZMSySrEcl8+o0Cs7nfv0xxPF0bINQrZn+ki0ImgzyZtlfhgupJ4x7qMs+YL4S0bD
 1UNXp+4rAl0WOXoFIAlBCkzuFUA8Wv95FZyY2/wTH+moZUFXjYuc7Xdy4yIbO54kbUgu
 EqhdWDYhknax4Uov3piIA32L6sCGUB5XgqOWvSiSbNNpRM4nfa4i+JiZQAYb7LWfj67+
 VH9NjJTi/EQrbw6edQFSjd/3ZPjaYdX+38F0bbYbU2B3EHmQBITi+GNIVAWVQI/dEqDk
 /LeNZ9+tAylwVsCMqD6y0+A3MCLgbRQ5x12rwrHwCvz9qT9a4QHfkFvGw1TO2UpAvGXN
 oMOw==
X-Gm-Message-State: AOJu0YzmNWMdU42lEQP4ggGWBb7+f0FUAtt16F13QEvYJUvL0EO7Veoc
 GNZPq3ul/BZFG3PgUsHiBu1w2/r4NxAZMpYVuKhHsAe2xMSrA0P3V7uIzNWqvgnKiJSKsGrdwIh
 G7o2yIa1Rm8gybtt7zwa0Jf3LhgYMPxE9gSiJGzQTNIlxIAxcOVC+
X-Gm-Gg: ASbGnctE9sHr2rJGJxS5j3nTri5afG1IYtLsys/bL009PKgctq77oEAj4KWW7NsnxP5
 6xBhPBrvgy3KsjWsacPTKFFGky+weggzqkWCqn3wkWcUNABIacTKq3uQGzH2KrU20HFfbmaz9Mg
 YZl4woNrf+T2dxNlTvkR8A16WgXOoPZChPlfPCU2SsLlqT
X-Google-Smtp-Source: AGHT+IF+c5EgzFng7hZvgo2/mMwQZYJnDlYCJKxinyxUjpOwVwN7lfObz6CJ25ORLlOd+Hx79rMhNw4xX23kFK3h15Y=
X-Received: by 2002:a05:690c:6105:b0:70e:2cfb:1848 with SMTP id
 00721157ae682-71668e382b1mr31524887b3.31.1751634232388; Fri, 04 Jul 2025
 06:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-3-philmd@linaro.org>
In-Reply-To: <20250630130937.3487-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 14:03:40 +0100
X-Gm-Features: Ac12FXx7P3ArMOGQRe61EH7qWxFpfmO4w_v5IJ9p8OK_V08-WhWfAYP9Z-BfgG0
Message-ID: <CAFEAcA8KBTfJqUbBeUm9_=JoMf133Tt3tcWhJ=sSSy-Yc6Cdcg@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: Only allow disabling NEON when using TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 30 Jun 2025 at 14:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Only allow disabling NEON when using TCG.
>
> This avoids confusing user experience:
>
>   $ qemu-system-aarch64 -M virt -accel hvf \
>                         -cpu host,neon=3Doff,vfp=3Doff,vfp-d32=3Doff
>   qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neithe=
r
>
>   $ qemu-system-aarch64 -M virt -accel hvf \
>                         -cpu host,neon=3Doff,vfp=3Doff,vfp-d32=3Doff
>   qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neithe=
r
>
>   $ qemu-system-aarch64 -M virt -accel hvf \
>                         -cpu host,neon=3Doff,vfp=3Doff,vfp-d32=3Doff
>   qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=3Doff: Pro=
perty 'host-arm-cpu.vfp-d32' not found

I don't know about users, but I'm definitely confused.
Aren't these three all the same command line ? What's
the problem it's trying to show ?

-- PMM

