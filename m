Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEDDD38FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg4Gx-0005a9-H6; Wed, 14 Jan 2026 12:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vg4Fe-0004UB-Ry
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:01:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vg4Fc-0000Aq-9Z
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:01:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so8845e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768410101; x=1769014901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9PwIxFVqudhs5izSnQFfuJDKUqCyCdBCiBL8qMkB50=;
 b=hftjJ0rm2xJhIKS9shKixjLVX0w5yz6OO1ZAwfBLU9LVXMlnYI3QfPPRWXpeuYG9CS
 2O3UWL577yAyzg7dltCU+5YuGkkDQReOOJ5PmlPZsXv619rdQ5zWmz84ztMmQK+w1D18
 9XvUoZMma8cXntfeG26GwKIxQK2LAiwru53zw2DPOWCnTcqioh9mffobIjTLclzG4T7D
 F2kYhUqYVH8u7fWLcOIZRqNgbSSAsa8xe3cXEabkhSAExnIsZEFpExUe5pDydTq6YIFW
 VlGj5P9BoK0wQ6meFiqSH8D94ABMO//UOpgR+FJDdl5vjluo1IEqGae7kZXWU9NyqEVx
 aUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768410101; x=1769014901;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9PwIxFVqudhs5izSnQFfuJDKUqCyCdBCiBL8qMkB50=;
 b=lS5BOMxbmwls6p0kQlWbm4lAUlds+hevJA2s1ycsm/emelftrnxQxstfja2/q2lcEN
 bfBEPV/pkqcaOHm6QX6m+3wlaO2stJHOBme2/q9NtYLi8jPzJJUcnwAyjh1HQyeo5T2o
 aDR9z250ApFlQvZoIh0VyZVivzFaord/VQHpdGMtrXZ+PrHePMVSBKHQA4p4NVAPoeIQ
 behcMgePomJTib7IkzxYbV7P2uCO51guEkfKjqH6PiIyplvSrJaMShM8xknREod7iQlC
 1dM4zCVoiIr/K8o7H6LTzbAJcIr/Vy7t0CaQ6JKeNh6VBnQKZ+1vPioD8YYTdQURDxMX
 t+Ag==
X-Gm-Message-State: AOJu0YxI4n5fsXUcxycKEDf5CNddZaKrkmUoWbwQTQeUm8bKEe7skCrC
 yBzODE57nPGPDLRHQ0cwCiIcB+gNjZTnSc7qmmfgudXQjgVhfDnD0a2mcMfif23Lp7I=
X-Gm-Gg: AY/fxX7Xf9Y/f0tgSnPtPv/7SuHzoROx/LqURuSXKvurt0nrpRk5KHClSs4OQ97IgU0
 xRO+9BI/tgDG5FvTAvdVyAptu1u6xm/lRK/IQr5efy+X74HyLZBPG4CPOoTATiPnk3xErB1DirU
 fb2sGRRhy4ob4BxiEtsREIi/eKTu+fpvq6RUnDZSU4HnK6uNzGj08qtpJ44m2TnDlG1HuYiaLfT
 REs8HjVKMtnfArVKhYTdI7XegCqdYXfCd09K9XqkwViK97FNDDcjgqCPp4fuvVkzcOlLQmpwkI5
 M//D9lWlEi/l4pyZp3D+c4SICs2uImPW4XG/18QDe9HgzgCuibRzAyto81tnlIIuLVS+T54EyZk
 lkbS4jGrjmD2i5UelK0njW6Gfd/dVQZU1vXqAulwpk1KX8mvsaAQTiAEjoWFbg5AHRYJZ3FSQrT
 MDKc18qI3ZGL0=
X-Received: by 2002:a05:600c:35c6:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-47ee32e5c66mr41852275e9.3.1768410100797; 
 Wed, 14 Jan 2026 09:01:40 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b267661sm929505e9.13.2026.01.14.09.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 09:01:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 34D805F7EF;
 Wed, 14 Jan 2026 17:01:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org,  gustavo.romero@linaro.org
Subject: Re: [PATCH] configure: Remove duplicated entry of --gdb in the help
 text
In-Reply-To: <20260114155355.82096-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 14 Jan 2026 16:53:55 +0100")
References: <20260114155355.82096-1-thuth@redhat.com>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Wed, 14 Jan 2026 17:01:39 +0000
Message-ID: <878qe0jfgs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> Since --gdb has recently been added to meson_options.txt, the help
> text shows up twice in the output of "./configure --help":
>
>  $ ./configure --help | grep gdb
>    --gdb=3DGDB-path           gdb to use for gdbstub tests [/usr/bin/gdb]
>    --gdb=3DVALUE              Path to GDB

It's a shame to loose the default value - is there anyway for the meson
version to show the auto-detected value?

>
> Remove the entry from "configure" to fix this duplication.
>
> Fixes: b46b3818cf8 ("tests/functional: Provide GDB to the functional test=
s")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configure b/configure
> index ef5157cf903..093dd7b01eb 100755
> --- a/configure
> +++ b/configure
> @@ -899,7 +899,6 @@ Advanced options (experts only):
>    --cpu=3DCPU                Build for host CPU [$cpu]
>    --disable-containers     don't use containers for cross-building
>    --container-engine=3DTYPE  which container engine to use [$container_e=
ngine]
> -  --gdb=3DGDB-path           gdb to use for gdbstub tests [$gdb_bin]
>  EOF
>    meson_options_help
>  cat << EOF

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

