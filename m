Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947CDD62072
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 10:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDLaH-00045C-1X; Tue, 19 Nov 2024 05:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLaE-00044V-Ch
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:35:46 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDLaC-0003Fb-Pm
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 05:35:46 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb51f39394so8163381fa.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 02:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732012538; x=1732617338; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=16rnG3iWNwgDJp/bIhG1Pd+2PUC7GzJVZrCyS8BlbjA=;
 b=RfWuMGlpwL9zA6S0I67XqBf/b7sEqf1yWuADQhffbKyyiXL/qfjmgzPZe4/TrOJy2t
 BOLp8Dd2YXGaUBl7y4r8A/in7/5Sa22I/WHlHg4xU1EtRh4Cvd9aioB6cfACTo2i/rMN
 G/gKLsW5BIAeN8i3B9s6Jhae2/hYF5rOgK7MzmhCnVQsvlRlvzeyoEbM7SshbrNGzc2Z
 Ym9/46OEgglQQqdv93mciSem856AHNjdqYgqkDZzUkjLiTvXecnjw57+MLar0a450Z2G
 kJMRrL8xgdyFbHZCb9zWkm78Sh4WTuul2/AFnsPhYYc4X474Ce9CpmxRWhbBudTB7PFk
 ACfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012538; x=1732617338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16rnG3iWNwgDJp/bIhG1Pd+2PUC7GzJVZrCyS8BlbjA=;
 b=txtq/nwbDgHbQGnjRuP+Cje6P1hx3N032BeateMviQqddxZemboe716CdMZtKc/N0b
 16c+Q51//nNnnmkOkNj01JeIP0g0Gah9KaM9rzYT2zUTjqK7qd4Mh7rZpuJbuqohnvlN
 CuP+1srPMRhxaInB14L/OeyECxxVMeMY2R28WippGDHVTm5m5LsDHuWofJaYeZ9MuyRU
 YoUqqpgKP62KY2UisSe3SYsP0Vn9Kl50oWRhQo05PCDCvevaTnmP2CeLt6368UunhbXz
 ObE4PJcmU/5ip7pJJyfLbUprw5NcAiSrpJOtqi9MGXB/boEd7hjG+6jpG1/DUOVkwoZx
 WzYQ==
X-Gm-Message-State: AOJu0YxT9OGrssE4e4jdyXG7U7tsx4xfaAnYPgkmoXSp4Z2Foea2r6oA
 BoYwsUWE3dV49/hEQbdLJaqjJbvGtxI1Ns79jLStii4enovwlMdQ6rdzSCPiTSRyIAHKCST6KUh
 VE4B8vhGEoQn3hgVfAPcI5TNB9tRdsBqwIu1CKg==
X-Google-Smtp-Source: AGHT+IE7caqnznxwJMDuHoGyQIRmamaPvZpgyXKuXnL39/v9kPvqfcB/WxnHGQfTGUT0L/bU9cbwPA7FhzpQvXKElmI=
X-Received: by 2002:a2e:a58c:0:b0:2fb:599a:a8e9 with SMTP id
 38308e7fff4ca-2ff609121ecmr55199411fa.15.1732012537967; Tue, 19 Nov 2024
 02:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20241118193627.1826228-3-eblake@redhat.com>
In-Reply-To: <20241118193627.1826228-3-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 10:35:26 +0000
Message-ID: <CAFEAcA96g-PObvHZ55eE_ztvZ3ATahcG-HUk5iBQ2p_RM-2-UA@mail.gmail.com>
Subject: Re: [PULL for -rc1 0/1] NBD patches for 2024-11-18
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Mon, 18 Nov 2024 at 19:38, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8ccdb:
>
>   Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into staging (2024-11-16 18:16:46 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-11-18
>
> for you to fetch changes up to efd3dda312129b91986f85976afbda58d40f757f:
>
>   nbd-server: Silence server warnings on port probes (2024-11-18 09:06:17 -0600)
>
> ----------------------------------------------------------------
> NBD patches for 2024-11-18
>
> - Eric Blake: Silence qemu-nbd on harmless client port probes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

