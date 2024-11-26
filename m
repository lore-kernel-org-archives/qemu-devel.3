Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31E0D3B985
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtpF-0007E8-RP; Tue, 26 Nov 2024 06:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFtpE-0007DX-C0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:33:48 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFtpC-0005Sh-P6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:33:48 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb5111747cso61544441fa.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620824; x=1733225624; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Coc/GZi/Hjv7KwkRvm/OxQePoh9q2uA0j6f6zi8DU8Q=;
 b=jcn2yI3cAQvWojiniqM7xJDFNuXXMllVkxyj8kqWxbLjodFxzqpdKnsG9mhODpv3ye
 qlJuio8iPcWPJoFIUMVbJWdFst0q+cmTDy1w4kR1IIXglnXB7RWUOzLBijAi7jKC5Twf
 4SDofP2VciCH/6k1kHSDd+mQOeSfScKkoLIVtnp50hcUqNxytBU81jfAF2uq9LPlmO6k
 WXW1QkEWQDGTci6SI4DUQtKKp5mpv9aGAOiCwGGmWOjaMThB7YXOobgelNYHVOViJpbd
 CCmhS2zEffwHAS43RhDpTshLlivmLg6U+tF+3E2olJxbOi6YUbO7x9CjlbautxxhXUXE
 YtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620824; x=1733225624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Coc/GZi/Hjv7KwkRvm/OxQePoh9q2uA0j6f6zi8DU8Q=;
 b=PMFwLRoK8uWQqe85kxs6ymoGwEC8uv13U6f0AmkeTwsO8YifBtdQ/LXn7kHSp8R+4x
 bqjy8BD/m78mnZ5VFZF0JhvzL+nSFBQO/LnvFSF9w5ae7clSOoKfWArD8qT6Q4uWnsqJ
 H2RYtwjhAnaz4sEgJ50L7HDVuYGWMEP+1BE2bypraxizxy9MeZ5hQXN7TAmA8YyeFEn8
 4CuNncWS7G4jAsP0o5YS3ByvM8j/GwJiUNObc6z+wSX4EKRamoYfWMhdcoPdB2XTRrZz
 k04WVoEs56LY2PvaICE5OafHnTOZYonQ4zEdwWky2sckn1oe2ODshYN+T5Zn6Djsemxv
 7nRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjs3cP+os2AufdH3DZMAS5gH8GzTWIlQG5+oaOp6wiNXBRMVpRn+TC2TPHUm+9YhX8OXA8Ajz2oN+v@nongnu.org
X-Gm-Message-State: AOJu0YzbaB7w+HS2NMYo2toHTzzc/SsBx4cGXeKfy+v/gv2eZwbh4j6k
 fmGDg07THVRB2ObX5R/srwC9mhXIuFY908SdcCdsZhResgdiEv5gDcxEzpHcjcGnVlw9K9O5aYt
 AcGqE0qRzYB2+1LNM9QLLlhcEeD8SY/mbmbpxug==
X-Gm-Gg: ASbGnctuYs27ljmcxnGd9KAipuEdfnfYHhBzAXZqZ+IhlK/Swxr2XpDggjeRDiz2LDT
 E7IgJN9ZH71IuPWgNg6sP5MsHNj6Z22ZU
X-Google-Smtp-Source: AGHT+IEq6L2BzDsm95PfgAbRrp0nG3qGC/rFeHs3ZcoGWp6g+R6vZSPXRE/RhzeLSzvvIekl5JXLOC3BmLcIRbletLQ=
X-Received: by 2002:a2e:a591:0:b0:2ff:4ce0:d268 with SMTP id
 38308e7fff4ca-2ffa70f6dbfmr86257301fa.2.1732620824285; Tue, 26 Nov 2024
 03:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20241125100541.26259-1-kwolf@redhat.com>
In-Reply-To: <20241125100541.26259-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 11:33:33 +0000
Message-ID: <CAFEAcA8idMxfbzZdBou2sHZ=uK_mw26HgC0H_aLg2eMskHdOHA@mail.gmail.com>
Subject: Re: [PULL v4 00/10] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Mon, 25 Nov 2024 at 10:06, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 6b99bb046dd36a6dd5525b8f88c2dcddae49222a:
>
>   Merge tag 'pull-lu-20241122' of https://gitlab.com/rth7680/qemu into staging (2024-11-24 13:39:06 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to fbdea3d6c13d5a75895c287a004c6f1a6bf6c164:
>
>   ssh: Do not switch session to non-blocking mode (2024-11-25 11:03:42 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Fix qmp_device_add() to not throw non-scalar options away (fixes
>   iothread-vq-mapping being silently ignored in device_add)
> - Fix qdev property crash with integer PCI addresses and JSON -device
> - iotests: Fix mypy failure
> - parallels: Avoid potential integer overflow
> - ssh: libssh broke with non-blocking sessions, use a blocking one for now
> - Fix crash in migration_is_running()
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

