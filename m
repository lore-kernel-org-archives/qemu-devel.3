Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509F1CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 10:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXzMv-0007ia-Kb; Fri, 12 Jun 2026 06:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXzMq-0007iE-PF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 06:44:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXzMo-0008KV-I7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 06:44:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490b7866869so7971305e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781261039; x=1781865839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UwC+ATP9TI+ZrYjLmY+KHfm+qCQFT+QpceOxnuQKFc=;
 b=D+5eZFFKc7C/WLKRsZZauNVMKICYhRicf69BZxJqVhWu+VMfj5m0ne7KwvvleL4/dy
 MfyzbZBy8W5kML6mBmT+d5G3d0I4yXaRspd82OXW+UOp5a/CIvlapFoc6LXM81wpt+U1
 A11jgarnqlzD4rswhLO4u/fYIBa1hfK2xTrh+5iKwOVT0EH+NG83u76nBc0YXaham11T
 o000F3irbhmEQtskVGmPYGpOe5FhdXx8r1mdCG8i3Rt+O68CzmHUYN+u+W9Ts8EZqg/l
 8tsmNPD58xhFE7Pk5g++qm8zNl8G9vhOv/YT1AMmlOSLdSeuUEj0o2WrCdeiulIIv23W
 oODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781261039; x=1781865839;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+UwC+ATP9TI+ZrYjLmY+KHfm+qCQFT+QpceOxnuQKFc=;
 b=IzNeyeUKvq7V7NSgKgxbI5cH3payYd8Z0JJNYAjz2PgD6tnm569eaAnOPjq4cr2g3g
 EFYSL2He43ofkSK8NLiksziqCmuAqiVXCIPrdMJkjs6jLjyttB7s06GK7yrQPgLzqDa5
 i6p5sV1lDMuGaYOtz9skNyiHMODIFX5/2yqgEVw8hoU1VS7BnFtKfQhYz+3GA93T8dcW
 7FqB1lwgHwWpzJGJ+Du+rcSQbx+BIli98NzO9yaBI59M1ineeu0ZOGQIcOxWVUmhzmS5
 c8TEP9wr/fyIHxTEwzD5SSyupeYEFYoSJeUVjcpohA7A1PiYpF+9G6fA5vbySGLD/+AD
 NnNg==
X-Gm-Message-State: AOJu0YzS3zabuqbGlbeLxLkeC7XZhbhqlj1zbwUMJkdC1Z/035h4UX/n
 yBkybZCo9p12EYfFN31lvTARnqL/zt3/X9Uy87PVan5FvvQT3B8JW4bEclaorR60lOI=
X-Gm-Gg: Acq92OEaYaLlUQDv1tFbvZVii0VnxV337SwQKs9Nno+DGNJonz4pNmn4+37OVl//sXW
 xeiIp/X3qJyJGMWBhd9et9QXTGF3sirYwTcBoBYW0lnnoDcS7Ie7YII++r3H0sNFrf+4CRe+JIh
 KxTTJHf6B1r+X2IdxDkw5k/5hO5HDa7z1Iuudkt3vdvUsk6WFlBAD8cqDMqINwI5eAKPPKVuU/Y
 3LFKsJ4xmGTMbHrOq+pI19vuAwaZz/W1dAgavqeNoVKEEHo5VL09Q1lKqVs58/LUmOQ6UvBv3mm
 yiM5ZlhP6U4Y+OqiKG/indHub5SeEDNXZMDtp3ZGAk66nnjeQWPKMYUZfNl7Ck1x5w+CkHXDyTK
 BuWbBWXmJLD+A7kho2QN05RwP/RCCJRv5DcytH4uhawzzaUIvqtmN5v2am4TY9eG0K9ASVVt9Hw
 DLuhxGTA66KdARRIG2KaKsIyY=
X-Received: by 2002:a05:600c:4514:b0:490:e1e6:8988 with SMTP id
 5b1f17b1804b1-490ec4c0327mr28612785e9.7.1781261038971; 
 Fri, 12 Jun 2026 03:43:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea95c512sm32499335e9.2.2026.06.12.03.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 03:43:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 349DF5F814;
 Fri, 12 Jun 2026 11:43:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ziyang Zhang <functioner@sjtu.edu.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhengwei Qi <qizhwei@sjtu.edu.cn>,  Yun
 Wang <yunwang94@sjtu.edu.cn>,  Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
Subject: Re: [PATCH 1/1] plugins: use int64_t for the syscall filter return
 value
In-Reply-To: <20260612055642.589337-2-functioner@sjtu.edu.cn> (Ziyang Zhang's
 message of "Fri, 12 Jun 2026 13:56:42 +0800")
References: <20260612055642.589337-1-functioner@sjtu.edu.cn>
 <20260612055642.589337-2-functioner@sjtu.edu.cn>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 12 Jun 2026 11:43:57 +0100
Message-ID: <87se6sdonm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Ziyang Zhang <functioner@sjtu.edu.cn> writes:

> The syscall return value passed back through the syscall filter
> callback is semantically signed: negative values encode errno codes.
> Declaring the sysret pointer as uint64_t * is therefore misleading and
> forces callers to launder the value through an unsigned temporary.
>
> Change the sysret pointer to int64_t * across the public plugin API
> typedef (qemu_plugin_vcpu_syscall_filter_cb_t), the internal
> qemu_plugin_vcpu_syscall_filter() prototypes and stub, its
> implementation in plugins/core.c, the linux-user caller, and the
> in-tree example plugins.
>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  include/plugins/qemu-plugin.h | 2 +-
>  include/qemu/plugin.h         | 4 ++--
>  linux-user/syscall.c          | 2 +-
>  plugins/core.c                | 2 +-
>  tests/tcg/plugins/setpc.c     | 2 +-
>  tests/tcg/plugins/syscall.c   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
> index 4eb1d2cd85..8eb10b1f48 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -870,7 +870,7 @@ typedef bool
>                                          int64_t num, uint64_t a1, uint64=
_t a2,
>                                          uint64_t a3, uint64_t a4, uint64=
_t a5,
>                                          uint64_t a6, uint64_t a7, uint64=
_t a8,
> -                                        uint64_t *sysret);
> +                                        int64_t *sysret);
>=20=20
>  /**
>   * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callb=
ack
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index ddd77bd82c..1ce4b281c1 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -174,7 +174,7 @@ bool
>  qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>                                  uint64_t a2, uint64_t a3, uint64_t a4,
>                                  uint64_t a5, uint64_t a6, uint64_t a7,
> -                                uint64_t a8, uint64_t *sysret);
> +                                uint64_t a8, int64_t *sysret);
>=20=20
>  void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
>                               uint64_t value_low,
> @@ -290,7 +290,7 @@ static inline bool
>  qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>                                  uint64_t a2, uint64_t a3, uint64_t a4,
>                                  uint64_t a5, uint64_t a6, uint64_t a7,
> -                                uint64_t a8, uint64_t *sysret)
> +                                uint64_t a8, int64_t *sysret)
>  {
>      return false;
>  }
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f4b74ad350..63c0a5f8f3 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -14378,7 +14378,7 @@ static bool send_through_syscall_filters(CPUState=
 *cpu, int num,
>                                           abi_long arg7, abi_long arg8,
>                                           abi_long *sysret)
>  {
> -    uint64_t sysret64 =3D 0;
> +    int64_t sysret64 =3D 0;
>      bool filtered =3D qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, ar=
g2,
>                                                      arg3, arg4, arg5, ar=
g6,
>                                                      arg7, arg8,
>  &sysret64);

All of the arguments here are abi_long which go to int32_t or
target_long->int64_t so perhaps we should be using that for all args to
ensure signedness is correct?

> diff --git a/plugins/core.c b/plugins/core.c
> index 2324bbffa3..58f293462a 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -596,7 +596,7 @@ bool
>  qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>                                  uint64_t a2, uint64_t a3, uint64_t a4,
>                                  uint64_t a5, uint64_t a6, uint64_t a7,
> -                                uint64_t a8, uint64_t *sysret)
> +                                uint64_t a8, int64_t *sysret)
>  {
>      struct qemu_plugin_cb *cb, *next;
>      enum qemu_plugin_event ev =3D QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
> diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
> index 8f2d025e24..23862eaaf0 100644
> --- a/tests/tcg/plugins/setpc.c
> +++ b/tests/tcg/plugins/setpc.c
> @@ -27,7 +27,7 @@ static bool vcpu_syscall_filter(qemu_plugin_id_t id, un=
signed int vcpu_index,
>                                  int64_t num, uint64_t a1, uint64_t a2,
>                                  uint64_t a3, uint64_t a4, uint64_t a5,
>                                  uint64_t a6, uint64_t a7, uint64_t a8,
> -                                uint64_t *sysret)
> +                                int64_t *sysret)
>  {
>      if (num =3D=3D MAGIC_SYSCALL) {
>          if (a1 =3D=3D SETPC) {
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 5658f83087..76d52b98aa 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -174,7 +174,7 @@ static bool vcpu_syscall_filter(qemu_plugin_id_t id, =
unsigned int vcpu_index,
>                                  int64_t num, uint64_t a1, uint64_t a2,
>                                  uint64_t a3, uint64_t a4, uint64_t a5,
>                                  uint64_t a6, uint64_t a7, uint64_t a8,
> -                                uint64_t *sysret)
> +                                int64_t *sysret)
>  {
>      /* Special syscall to test the filter functionality. */
>      if (num =3D=3D 4096 && a1 =3D=3D 0x66CCFF) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

