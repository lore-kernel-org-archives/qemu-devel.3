Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4353C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 12:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkNqt-0004Ux-Oq; Wed, 13 Mar 2024 08:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkNqr-0004Tw-Kb
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:36:57 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkNqp-00075q-U2
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 08:36:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso7799024a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710333414; x=1710938214; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ae2qj2tXKdWYGUD521QaECeJ+KQU36G42PI4WE273VI=;
 b=xptmrvzdOUFoaGPgwQI0SUwkRB1tz9vr2gASZMS7I+l1Kiys5fBC4rVlc1mUEOTVQ0
 5uHBDiN2ZR6GVlCudnqdK/RmwsjoWuP5qgSJm+eIq8eTJJQDo49pq1JLgGMZ2H3oIng5
 87mH81vvDXDE/E3W7imx6IVhGu0+UOnKoMc+0y79wqZ2AXdmvrk43lCefiDbzhlsizCc
 fSZm/jOS/Jwx8ObO9LqcHE6Ar3kWA2sNdGRErPDlz7LpySAT8bMZrgbz/Im6kWsagQr7
 gt/p+gB0RnPqASKlPgCZPaJAZ9y9/8wKzG6mE27JZUEVMj6MnmEEqDgNB0aa4iKOOUbf
 Uo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710333414; x=1710938214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ae2qj2tXKdWYGUD521QaECeJ+KQU36G42PI4WE273VI=;
 b=T9s6ITdyzan+/nmVLy3vSnqY6oqPdXpAY6yMedhZedTLoPneG4dkle59j1gStTKW49
 5uxayhhhq7bUQwwPxVPkO4nOKDMHuagwO0bV4XJgbhFrUTvPCWKzQvVYFYD5PFZlkK1f
 gMj06j8a6luohPeaRUe3e3eEjsZR9Ogn4W//q2ZTVrmrXB7QYXURStluNqxopBbj6sp6
 HhVHf941ViKJRha4fL7Ra97KAkkqqZFvWERwxJDHGkD3vQp2bJlDVI6OI1J+gAg33Rct
 GJH4lh1qztMK9tQjzoxluoFcfYFN6rxEaLyoR8HSxHFqovAIV7OYLUhKPSRzSkfeKVQH
 LZvg==
X-Gm-Message-State: AOJu0YwO14STeUlD/Bmz48pl3PFG6egSo1YGnCcoCtMWyXJQMR3Dfott
 tpmVvRhcpS+mKlT/tPUOdTpkNM+2hNOHRJG0sOBDq0+e6/Ts4Wxj27+5SAU2ZoKJieQ+4JIaTk4
 pDFW2YyPuFkdALX+/kW/uerrmzk5nS31hiSZYnInodjGqpab3
X-Google-Smtp-Source: AGHT+IGKdVWr3muvu+n1KLvehz2GTMzZCxx3mFCtmVaBrvesuA/UkndK6PvxFpUv6bNHsS/oRvc1Ma9uXO79kQ1vFJo=
X-Received: by 2002:a50:a695:0:b0:566:2aff:2d38 with SMTP id
 e21-20020a50a695000000b005662aff2d38mr9808277edc.26.1710333414433; Wed, 13
 Mar 2024 05:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240312172622.58652-8-its@irrelevant.dk>
In-Reply-To: <20240312172622.58652-8-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 12:36:43 +0000
Message-ID: <CAFEAcA-Aymr5vVqxsvcn-H2yhCLioazW4QETu2F_x0=CztKArw@mail.gmail.com>
Subject: Re: [PULL v2 0/6] hw/nvme updates
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, 
 Yanan Wang <wangyanan55@huawei.com>, Keith Busch <kbusch@kernel.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 12 Mar 2024 at 17:26, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi,
>
> Sorry about the compilation error in v1. Did a full CI run for v2.
>
>   https://gitlab.com/birkelund/qemu/-/pipelines/1210559370
>
>
>
> The following changes since commit 8f3f329f5e0117bd1a23a79ab751f8a7d3471e4b:
>
>   Merge tag 'migration-20240311-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-03-12 11:35:41 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request
>
> for you to fetch changes up to fa905f65c5549703279f68c253914799b10ada47:
>
>   hw/nvme: add machine compatibility parameter to enable msix exclusive bar (2024-03-12 16:05:53 +0100)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

