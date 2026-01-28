Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BC9D25B41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 11:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl3Sh-0000sP-D8; Wed, 28 Jan 2026 06:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl3Sd-0000rJ-TT
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 06:11:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl3Sb-0007Il-Us
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 06:11:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48069a48629so16823245e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 03:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769598703; x=1770203503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rUlYfuFFlHwb/4+Ks/ahGh7pF7bQwCyWbgngiqUb94=;
 b=Z9Xhj0eqQ5AWTYf+PmLx8pcALRTlceztDqxvDhXGPbL3BDc/JsR6NZPZGuwH+LyB/C
 VjpveJYQ8sK5BIlDqLoqeBW0K9qSlVxe/k8/g8/E3O6PbvASOH8bWrvSCfLqUl5F9Iu/
 96d1HZg2fpfb1OCuDwlY86Tj0usPAWQr1GrBExkfsb6CvNbh6nquCpjQ7kgtu+TU8Oar
 4vfgazaXkrdJUWDjN5DNrlYFEnMFKHLRoaUVjlQQcvL45hEEb1BhzzexSU/yKDTLVMe+
 3usQp2M0mhmDNfizlx1xfU2Kq6i7ZLDhol9F8sbXIvcI/OQxZoSxWnhIHzXfphwBTv6S
 sawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769598703; x=1770203503;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3rUlYfuFFlHwb/4+Ks/ahGh7pF7bQwCyWbgngiqUb94=;
 b=MozjqFUhPsISCuVSubk5Yt4UjbwwcS0OJl3b7bH83b+rBqiWScjA/a/VY1TSNkutDS
 QCceE3q41QRcK6EZQG1XGaAMqk2iIr+qRfE+7LDWbgVVi8EaEntBkV4rk3D44pi26oNr
 f7wbAVuNDuPzvzLbjH88Lsw2nn62O9eZAGpHwCWBOtvv7Asit+FSIU81AX6p3sDawxe6
 zPKznH3DyyskeboVOaNKY5oJGmKzBTLgLQLD2qb8lJE/W+PXbbb3KO4bYI+F/x4bAiBu
 JqvQW4/JofzcYy/OpLrGA0IutfFRcs/CBlq0UMxn0tGW43E+J2r54bDfiWs77wCKRxkx
 pRFw==
X-Gm-Message-State: AOJu0Yw2t2+Wvxb7/AR9I3Ky+SwqR4eQ0PESw+P9UKF64pWkCa4eI+0L
 9pmqczNDRLdL1iHFpIYj47YKnkTNJKgMScyR0SCnB6yATjFvCZZKNKgdRyNrWc9xp74=
X-Gm-Gg: AZuq6aJnYytxKG71FVOsldk+3BOh/yDDfMEdq68h3Z02Z5jsWWT4Mdic+wNhbdugLST
 5wnpm6U30/pW1B6eE06n4tiiTZYu7RfxRn4PsntQm04dqB9R+hh67TI8ZS+qxe/T/Qegr1Uk6m2
 os6OxjIJiBEtfjmdEk9z0xM2PtqoZCKwbhucVuDdvU26vtajjhlzV/+GpQgMTuj363cfTocMRjd
 CS4kbNzVCr5VQfKiDCgzz3IfCD3WKAcbr8Q5YPot0A05uWcL0AwDvweDSCkZyq5K9gDD7N/o45M
 jeRXLVj5gI3dJ0NKPrKey3pufyLY5whvWoO4PO76bV8tOfOSFYt7LzpL36smfg3oUTqMPkdKUCW
 YE14e6ar8goIX11caVdJIJjQv9ybj4yZRSxoG7w6DHZPEubPXbEbS1MioNNWnnoBhssb7B5fuFD
 +fkqLXmF03OtY=
X-Received: by 2002:a05:600c:450b:b0:480:3338:2939 with SMTP id
 5b1f17b1804b1-48069c6097emr56075205e9.26.1769598703236; 
 Wed, 28 Jan 2026 03:11:43 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56068sm52234255e9.13.2026.01.28.03.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 03:11:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C90E85F7F5;
 Wed, 28 Jan 2026 11:11:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,  Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Gustavo Bueno Romero
 <gustavo.romero@linaro.org>,  Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v4 03/11] plugins: use complete filename for defining
 plugins sources
In-Reply-To: <20260124182921.531562-4-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 24 Jan 2026 10:29:13 -0800")
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
 <20260124182921.531562-4-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 28 Jan 2026 11:11:41 +0000
Message-ID: <87cy2uat5e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  contrib/plugins/meson.build   | 10 +++++-----
>  tests/tcg/plugins/meson.build |  7 +++++--
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 6915ffa5fbc..3d2d7862e0c 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -1,15 +1,15 @@
> -contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotbl=
ocks',
> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigge=
r',
> -                   'traps', 'uftrace']
> +contrib_plugins =3D ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.=
c',
> +                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c=
',
> +                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']

Argh this keeps conflicting with other changes. Maybe we should make
this a dumb list:

  contrib_plugins =3D [ ]
  contrib_plugins +=3D 'bbv.c'
  contrib_plugins +=3D 'cache.c'

etc?

>  if host_os !=3D 'windows'
>    # lockstep uses socket.h
> -  contrib_plugins +=3D 'lockstep'
> +  contrib_plugins +=3D 'lockstep.c'
>  endif
>=20=20
>  t =3D []
>  if get_option('plugins')
>    foreach i : contrib_plugins
> -    t +=3D shared_module(i, files(i + '.c'),
> +    t +=3D shared_module(fs.stem(i), files(i),
>                         dependencies: plugins_deps)
>    endforeach
>  endif
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index d7823704616..303f97f9679 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -1,7 +1,10 @@
> +test_plugins =3D ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', =
'mem.c',
> +                'reset.c', 'syscall.c', 'patch.c']
> +
>  t =3D []
>  if get_option('plugins')
> -  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset=
', 'syscall', 'patch']
> -    t +=3D shared_module(i, files(i + '.c'),
> +  foreach i : test_plugins
> +    t +=3D shared_module(fs.stem(i), files(i),
>                         dependencies: plugins_deps)
>    endforeach
>  endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

