Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E7109C047
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RTE-0004uT-Ml; Wed, 25 Mar 2026 12:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RTD-0004tw-2X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:52:39 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RTB-0008F1-Jr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:52:38 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso69744d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774457556; cv=none;
 d=google.com; s=arc-20240605;
 b=VyLxizzD484uTYAyh/8TQS5oZXMTjUd9UwiMsKQrIkp7yXZeGMdhFBhMFcCusCpTga
 ow5qB9KZif8Ei1Be+hGJ8P0xgulrFaWeN9mnUJ6P7GeIq9C33gp7sFcFwQ11rGUpbZsq
 s32F5TUdmHENzXher2TC/2jdeW+k81preD+o8LUK/D0ZcBxoVt3r5onEG/4btM9384GG
 VsnCQQrLCbY9zGllF1PLvWPiCDF6eueu2KLZMLrO/aiEMzCBqakv1YipAwM0OJ0WZS0u
 oy0bcKMpZia7rbkHQ207DBGCx7R0FEzT1C1DWxHs/fkvUMV2ebcCf/S00hkzsJAPEyKt
 xvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rKgNBrGMX1soi3imkw6mstSWReDztH8H29hZ0NUa3xQ=;
 fh=sNd4ajktOwMQuqZAp02nD30X7U3yalsWqZsXZzugyjY=;
 b=igOO2xV23eWc4QrAnJ9m6yp0jYuquwYgU/fCldLxaqarLNYD3kFqWhn6/vuxbp2k1I
 oWLRAYdlbnw9PqoapsRmPNhLnjco35oqs+28upOqfz3pF9IrbrqtO6gTA9IUhfF5+8pL
 WiFeVi+CJ+Mv5Ou//WChpulmw62y2K/xJqHFl7T4w2paQMnLk45s9eTGIUQvPpUUAXY5
 AAQLkqxlSOISfBPhT5E+MRWWkwCHdR8To2J/3VPZBmXMTk6LZt2A7cPy9GfLB/OuI/IX
 hSGamQHsRea/BC8ybu8ea6C6QgLdy81WhGr/FNPVz0AF5BjbD7StsLNXTlK/N2c2hmey
 BllA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774457556; x=1775062356; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rKgNBrGMX1soi3imkw6mstSWReDztH8H29hZ0NUa3xQ=;
 b=AU3dKjHYVtRVMc4AH7PD7yYkwKPMAXdssGDh+y8oiPMhaTbYXt2MntJm6pC4oS4R1e
 Q7PTxfIVfDlzPxSFRn+EVZ5vX/HUWx8HiibGYpZvwcbTJQG0cVcG7qCFDzCMYmwkzc9E
 zRMqf8mgnnDytG4aXbxUzHhXWTvnhFATUthHh0Q4rtpsZ77bZMaNHR+gfutHI6Zf+MVZ
 fmmxSkaLyFYwTrIO8i77nIAeyDOIwLGKq69SdAYJzwkfHg8KrBJZMcivxPn26eQOEUFP
 wtHoXQd+Tc6OWwjXfwy3Czi5aGJ6ghl3BZTfCX9RDOa5zYOUsW8neD/IpJMc4pLH6ivu
 keUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457556; x=1775062356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKgNBrGMX1soi3imkw6mstSWReDztH8H29hZ0NUa3xQ=;
 b=jBJmVXZAn5HUJV+bOH5CKEGd3gSTI+2MZVr9V0WKGB63aPEGw2ZgdG/KYCpdxbipgx
 2qc01znesQ7r/EmDQTAKQwMLfMpXTvehBslNMpfr52dOV+RSAzpz0qZa8v3tqq9Aq1Lv
 tNr6hrW6793TQir56ery0V4Xx8Iz/VxKERp6N/OW04RPn1edgCKcoYesYgm/2E6xP5P7
 PAMf2vgTT9wVfUHfXFm/PrHep3yZVpiUdiIrr1lLwipVpFRpHOPgZB2+GaLPT7Wly7Qk
 7Z11G1HhzeZD9kyGidEbv1Kgp0l3C+xcZcByAqKazM4M4yb6tH7rAcQHkMg5iT9HjSaD
 9rxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRuwkEjJkEer4+FKYHWL1duH0Xs8kJTKWwczMo/u8kuE2wByZWiiOytMpWzuCMblcDa5D5VtS9KJnB@nongnu.org
X-Gm-Message-State: AOJu0Yy9jx4YB7WOKmzvI3XaQJ2EV9HO8rsfcb5HzvYHXTMFLfiSpAHY
 cD5GxKiVbIYmsnZnAt3SXxBLCFE9bgSm7qXTaSC5NentBAMWZ1jIhzzWosxy8fW7661caLKvLFv
 BU9NIICOcvmkt3FVpT0Q1uHQ1hTxlmqFZjRy0Tem7Rw==
X-Gm-Gg: ATEYQzyuSrmAG224M40dHf4DqQ6gEcfbQmELPVPgtimlFPez065NVirTwFzwLAGasN0
 GK1ZEDMJt4YjSzbEuR77Ydv6lYwxpd8c+cUUt8909/Bic5mPv80UZnzfxt3YGYbSDMzGaM1AfQ9
 KAWfwK0snSLmBgsyh3FjXdtocYa846G79qXIMcQfF/cwK3YAeaxI6VuLzmyWu6Zpd9zauYzS2hz
 YVBePWKrpy/FFYIBAkZ/+ppMijN2FGbAAUO+DXugZaCHs9qd/QwC+a91tpDzuSq0QGlZDM+yu49
 2TMXWLGBYEd6emdcwmb0ljRVQVQl17D+pdFSQ9kTVGGSYMy4H7hO14sMP5jDDWG/3O4=
X-Received: by 2002:a05:690e:4193:b0:63f:b4d8:1f32 with SMTP id
 956f58d0204a3-64ee609d986mr3801442d50.20.1774457556205; Wed, 25 Mar 2026
 09:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260324185619.296946-1-kwolf@redhat.com>
In-Reply-To: <20260324185619.296946-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2026 16:52:24 +0000
X-Gm-Features: AQROBzBE01dr4UVWzo0BLHwWOFxoZv8-Ok4Ok5r_WaKBO3JHPHDxqBW8mc4jyQA
Message-ID: <CAFEAcA_dc7+dOCJFZL5=un=LsYdJBLAZ64bSfnUEQJTVQNZhOg@mail.gmail.com>
Subject: Re: [PULL 0/4] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 24 Mar 2026 at 18:57, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-24 10:41:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kmwolf/qemu.git tags/for-upstream
>
> for you to fetch changes up to cf9cdaea6e24d13dfdf8402f6829d2ca4dca864b:
>
>   io-uring: Resubmit tails of short writes (2026-03-24 19:55:09 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - linux-aio/io-uring: Resubmit tails of short reads/writes
> - curl: Fix memory leak




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

