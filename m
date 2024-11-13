Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48326D462CF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFl0-0003l4-Ik; Wed, 13 Nov 2024 10:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBFkz-0003kw-3J
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 10:58:13 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBFkx-0002Ow-2k
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 10:58:12 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cf745608c8so144894a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 07:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731513489; x=1732118289; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qhsZB6/5bF3/i9eeOIsJ3jk8wCCU6uoguzBm+XmF38Q=;
 b=RneOC3PB/PbPRi4QLIcgCdb2kFEkpPbbH74MlKii7HYxilFgb+R5CKgO8dxaxHFiC1
 HuiZNk0RQsW4DA/mGSkSptZGWe4ycKWgfCsEsFcICzAVnCfKRn3MIAl107QoSsZGKRdW
 a56O8gBqSv6Ek42wfkqLasFvEk8lypqkP+7H+LnU2TY35QEHF2puilo8++by5wH/rZOE
 4lgR5iqQSQp7yY/ztkaPZikhHRAh/KLK0hLhC88pPH+tNQLWxN5yjF9Lq7/n1hugXgjh
 SbPPAJkuPyTRXcKCjkciePt5MbijjqW90bNitXTBtwWcIFLuReO5+Qup54Ms5DhD4Llo
 YLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731513489; x=1732118289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qhsZB6/5bF3/i9eeOIsJ3jk8wCCU6uoguzBm+XmF38Q=;
 b=ZLLGg3IyfN4ca5WQcz7aKJxpLMfeo4UGtQCLlxDTCT+f8E9UfhtuCBZw+/PaKOs21w
 zBzJWmdZdHTPEaP2u3tdJNqg+aU8NAgLo/di4TOzZ8CrlpuOanqM24m7oVr9rBAXKC+K
 C415tYIb07Au1WDBcN4lp8iX3EcJ8k234/kvFpyN7zXfaHdgXrKEHTMpxERRhFZLSZ/3
 iELUpfhAtTxcf/INWlH1cutKuwvlcg7RRGnKc86lfXkUTMzXLq04qusIYYuQU6bChKlR
 idgedYSgmAiQtenPQWJnuaQ8DHCg91zmoZ5bfGk7MTBsrqfBnjMQJalh4h2LEAM+CRfc
 P/4g==
X-Gm-Message-State: AOJu0Yw5KP+aY9kEkXCfAQ/DrKo46xrGtXXoBOkqfbfSZu0McZ7aL8pA
 4GZQZMQwVoYwVm0NiWH3jpn3JHsd+Di3R43bGNcxpsm9q1Sl9uo0JoskRGKkcyYUMP0kcee/shT
 6PkNWK9hn2AGoIbB0jJOd+lOgeP5JCpsIfJlR5Q==
X-Google-Smtp-Source: AGHT+IE/gVFnOvMj9ZhE44axKHulugQDzUv36ey8l1Xhmm2ySTZg4Bzr7s521kguoZsADb6YzBjxuUBSgSfz05e0U6o=
X-Received: by 2002:a05:6402:5113:b0:5cb:7877:a633 with SMTP id
 4fb4d7f45d1cf-5cf0a472923mr18009447a12.33.1731513488974; Wed, 13 Nov 2024
 07:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20241111100701.2620020-1-kraxel@redhat.com>
In-Reply-To: <20241111100701.2620020-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Nov 2024 15:57:58 +0000
Message-ID: <CAFEAcA83zip4PnAxjQp-Qiquwzqf=cVwRmxsKGeyAXvqwzg=qw@mail.gmail.com>
Subject: Re: [PATCH] edk2: update submodule to edk2-stable202408.01
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 11 Nov 2024 at 10:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Updates the subhook submodule to point to a edk2 mirror repo.
> Fixes recursive cloning of the edk2 submodule.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2660
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  roms/edk2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/roms/edk2 b/roms/edk2
> index b158dad150bf..4dfdca63a934 160000
> --- a/roms/edk2
> +++ b/roms/edk2
> @@ -1 +1 @@
> -Subproject commit b158dad150bf02879668f72ce306445250838201
> +Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
> --
> 2.47.0

Shouldn't this also come with an update of the binaries?
I know that in this case there's not supposed to be any
change to the edk sources, but I kind of expected that the
process of "update the edk submodule" ought to be
standardised to the extent that it would produce new
binary blobs to match the submodule bump.

thanks
-- PMM

