Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9EAD5C0D1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QFw-0003vw-Cy; Fri, 08 Nov 2024 09:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9QFv-0003vh-55
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:46:35 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9QFt-0005Bz-BO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:46:34 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53b34ed38easo2230153e87.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731077191; x=1731681991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tDjv5Ue222Uqs3FJy1SVZJvL76C/64OoVFtj4M6HuzM=;
 b=egC734cgSJFQv4SLuHs7k2QL299OMsaoEatKHwa6Qkl7WvvVBrdz0FevJ7fkmj1VPm
 1LxsROcCD3DQ+NQdqv75OsTfnb4B0iCetOEdjKkvKjbpy0G7Ku7soTH5TcAddbGs3MVg
 mUkhMoYQ5KBjjYzY0t4ucj+hIXWNbggzJUWL4vB0CvF9VnRR29ktJAxMVP3qer08pWeu
 zu3/UnMs/CGHUie95zMySDIHM1vfOUtAGY9l7NPMjXruXYztaaxMWsVBOaCMdBVxaiBv
 ymKjyGL9deYQUE1d1iVutcwTP1j3QkmffOyHQHEOGs1dkM07r4AstCSLrqm5JiXB4KLz
 vJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731077191; x=1731681991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tDjv5Ue222Uqs3FJy1SVZJvL76C/64OoVFtj4M6HuzM=;
 b=W38Ya+qXnWUflEIrGfmQzCNOTlepcalJl9gQ+czR9GyYgw9dhB+lJi4LfJfHZ4a8cb
 UvOckoVXlC7WvqHkSTQzSaEE4/lS0TUr2UgAbUXns6jwPmVH5yIV0xZbNsn4qfpLXsJd
 +srTs1rfjNEL7jBHavPNUlmIwhQsgMRNS/kmDST1WOrtXs2msDs774aXswrxqrW2e68i
 uEiWmmDhvvun2yC+bMXOn84cGHx/i1A1KW6sRkxnLBlIfzWGIQT+1wUI3bf/sJHNQUwH
 caWg5DdIIFP4ep6ynZPLdb1WzAyr2Yfl47sTCJwNfM6I/B2bTxjTS0DaUy/rHExk7M7I
 7jnw==
X-Gm-Message-State: AOJu0Ywa5ukvo/oxCRK8Fjreu8mQJCYE0HfQ1ys9aFgu0+Q0pgCiaGUg
 O/9RS/of4rOw+8AYg0sepfStoiQRMgKGKsoRHLOhLaflp2oP9/eO/jNtrnZ+V4AVN/gk38pjIPs
 sWkd1FNJESdF48o92ur+Akc50rXX0b3LQOkATCw==
X-Google-Smtp-Source: AGHT+IFb0J7um3b2jRvW4RUC1U6YFO05OMY5KixGMN0/LdS67mrh8nB+rUaYa0QD/wdRNNh3/aRRblqTDmOQTRrXL5Q=
X-Received: by 2002:a05:6512:ba0:b0:539:968a:9196 with SMTP id
 2adb3069b0e04-53d862eb455mr1605991e87.48.1731077190830; Fri, 08 Nov 2024
 06:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20241108081620.3663-1-its@irrelevant.dk>
In-Reply-To: <20241108081620.3663-1-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 14:46:20 +0000
Message-ID: <CAFEAcA8vsXyO1AJBEEOt+GBcYW-SC-4QrF0bmEd1dB3q2JRsxQ@mail.gmail.com>
Subject: Re: [PULL 0/1] nvme queue
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Fri, 8 Nov 2024 at 08:16, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi,
>
> The following changes since commit feef1866d1366d651e6a3cb8c9cf1a9aabb81395:
>
>   Merge tag 'pull-riscv-to-apply-20241107' of https://github.com/alistair23/qemu into staging (2024-11-07 15:08:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241108
>
> for you to fetch changes up to 9529aa6bb4d18763f5b4704cb4198bd25cbbee31:
>
>   hw/nvme: fix handling of over-committed queues (2024-11-08 09:14:30 +0100)
>
> ----------------------------------------------------------------
> nvme queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

