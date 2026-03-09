Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E8F4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeHF-0003e4-JH; Mon, 09 Mar 2026 13:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzeGP-0002zC-97
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:19:32 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzeGJ-00066j-Gl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:19:26 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ae222d978so11566538d50.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076759; cv=none;
 d=google.com; s=arc-20240605;
 b=Jxc8x0Vuz8NeQCLdjIFtol9MqCqwifTCmweG5MOcbsAeNsqjXq97rVWH6yaYRhlJfj
 Ds4lAEdeovfvHnTLV7jKwQOqD1lAHjCHV/UjCQK6THydlEcG+AjKTBgN2O9bM5SBPRKf
 RTOfJrK8H9IpZ+EYgNJThcNSc+fSTql7UXlBZ5Nnb3b+vKQaUyXnCOVnAQsmz0v6j1RL
 ke8ng4FpEH9nbJAuYTSK9Z/+MTj2ezmCAXkw4GhQCA+NWcsofbLTENper7DVp7tM54IO
 fFfTdWQ3jC2DFzLfD/4ygnd5/mZkVHEBy4KhFKNKlL3cLN8zYjiyp+JkvvZihd3FOvNI
 3iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e1icfSzBEGmBZeRhMGqoRrI2tobydFyn/cbQS+74P9A=;
 fh=hkJYBzlLFB1Hu+yotcIJBiJRRwI/iNOrLzc4m4v/pUY=;
 b=AJoAniEX1JDSqkHCyRRQy+xVGIQH+52Mim8H4zYlpmbFsQwifpsAYK2PkAY21I5l8Z
 +fpe6RikGrEpYAU0aelVcv0AeTBemsg7KIYRfR8mD2SFN9kKnScbsUsaFjuvBcbdNCUO
 4ofp1Cwl5qZT7ezo4sGjNCfj9YkekPdtwJ7F9ctiPRrSSRBo+MGtAqp/7AL3bG7C7hUh
 frRt5gKAKJmds8/1k4OOzd30Zd6DrGTx5hqug8lu9FFBXJHytpT3+poCk0ywtm7scZNr
 Ggx6l5rzYXkapnnY1pHvgPmBuB5kVKPgAVKLEQODwO3Iv/Nl8AnzaWsNun9C4sjyY0nV
 ST+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773076759; x=1773681559; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1icfSzBEGmBZeRhMGqoRrI2tobydFyn/cbQS+74P9A=;
 b=kTCHKQjxUgrkCG1T7Zdotr4h4LEzlmTLlA947RepxCf6XPqke1A/fcMXvTDN5ZPkpD
 y80YRPWpLX3rosmHNt4raDFHlR41fHWEJe9yYoVE84Cfc5eLqMRP+K0SVUi0pOXnIGqR
 NZbAQ3CCIvDBLalcLMsLe1YKxxHk3sVSI/FFN7nlgJVBSIqFDIf1n5Cc+MPDJ1HpATGW
 D2Nbkuhn9Gc2xLjgMYU4j9K0hsUthh/VNs6D0oCKrZfGEybjWumxz/1RW0gl66ZhenFS
 Z8cDrXO7NDmHIpXw3Ih/62+AKA0G3+zgbgos7KACsfZlBwmv4S6zX1oX8v7AY/yzDgnU
 RWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076759; x=1773681559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1icfSzBEGmBZeRhMGqoRrI2tobydFyn/cbQS+74P9A=;
 b=GAZYNuNkX9y5efpnYbDDyBq0ePi2at4yzqmkT8Vr4twvqwuBIuP4HLByVT7okIh42I
 J2RIuXJh16W2ZK4ld8qZV04lyGS1vLUXTzYDVxyCj0mTu7Ql7zbrVjDSfHWEEoT+Riyp
 +MMLaoFHBKy/PUme8lOUemIjFviR5a06/OYYBRlNY5+R392VQbhnKk4m3BUCNxarWHSv
 FtX44QxK0euA3uTx6T24lc3WptUDHXlRVJtA4JEG2TpBwpEFsg+AcT7gLIUHdz5a1ueJ
 jlECNEGdwSIv6rTmCkVu/AuQMI3hNrmLmGQAiMotECRzKTRsMRaKC5jWjp/wycWi/Hdl
 05bQ==
X-Gm-Message-State: AOJu0YxIbc7qdrJra8qw7H4tycK5cJ0Uss5YERqN7uwGjVmfz3XN83Qu
 J/IlAcWo5UBQAF8rjdO9lQ/95AzAh6fNhyt9M5XJiD5mMtQDlzb6dl/WUbv4oD15A0KH1G5YCfz
 x98KIBX3BSCC8XWfOxUE6tZghxPhYjZffjd5TkQ5mCg==
X-Gm-Gg: ATEYQzyvRQZN8Knm9n2h5TKCYzP/7XceoM0uj0/1uog48PgpeEbIUzz9rCqEAiE7ur+
 0jxuRcabybNuz/7R2ESABqqhokCN9F0MDABs3cLAeO5CKkOojKfR5l/GL+sg5ABGLYdhHHiKCfE
 TyHccODD7aM4jlNvDjDEfxeF5HaV7lHNriRZ+FOswbaLDuLP4uW2KFvZo/GBHIBCVQL1KmJHTj8
 uxlR46Gp3NURKSOMjpShMlvYR13yKLTESPit6Mb09YrpF9XzKhvgMmcrF6ujjNPz1ye2iDbHVnh
 R61QzOTAx5BMm9DV09/5XMQDPuHb/1F649o6QWG+YS2iW29jrqEWFw9aZNgWJoYaLqg=
X-Received: by 2002:a53:b199:0:b0:63f:bc75:6ead with SMTP id
 956f58d0204a3-64d1407f32bmr8955581d50.9.1773076758886; Mon, 09 Mar 2026
 10:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260309134711.5312-1-deller@kernel.org>
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 17:19:07 +0000
X-Gm-Features: AaiRm51YJXGdXUtzIIEqYOmfneSZUGPcW5Ne5E0H2BuCgYRbvHd99VU-lShCxK0
Message-ID: <CAFEAcA_1u_Rx6dvgWJKnpeo3Uca_emAdqv3-ka6NTyLU2aNH3w@mail.gmail.com>
Subject: Re: [PULL 00/10] Linux user for v11 patches
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Mon, 9 Mar 2026 at 13:48, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 084a6c6e73a8670f3d5144b88d617a76fae207a8:
>
>   Merge tag 'hw-misc-20260308' of https://github.com/philmd/qemu into staging (2026-03-09 09:39:12 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11-pull-request
>
> for you to fetch changes up to e6e84085069ccf2d083223aef67d008fbee20915:
>
>   linux-user: Improve formatting for mremap() (2026-03-09 14:37:01 +0100)
>
> ----------------------------------------------------------------
> linux-user patches for qemu v11
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

