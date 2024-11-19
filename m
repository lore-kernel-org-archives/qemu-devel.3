Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333FDD44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDOys-0003Q4-VZ; Tue, 19 Nov 2024 09:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDOyq-0003Pe-Vn
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:13:24 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDOyp-0003rU-Dz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:13:24 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cfaa02c716so1177096a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732025601; x=1732630401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jx41v9BGhl28go6eSkoYYRKJ1NuKjbZRTpl+oEAlBlM=;
 b=mVrKoUgxIMvL5sk1mxs5SkUVq5SVJDvCTzHvzU5I54hRLE07dEIDTf2EUGAPVB+658
 G13fPVnov4hM9DP7IePUCJYJmW8fENBOsHHjtOhMezWN6hIzVE96Rwky/dIVHAuIVuKm
 mw/mCT4rCJRmxNRoTQmSB9VJoBKCd6Ud75dRugnJj49D0g2gq158qNkgV7la59JDVwkk
 M+MGkxls1dhUI3nuJw0nsPG1Y1dgRqGLNkXMAM3QX4aF1jpYFT6A1TDSKG3AA2md3jPM
 61iVAWlrjSRHzTuAYgkZc89/gjZmgmG8DIO5krMPFBAgqbVUK8nDjJv/lFMVMfVpGoi6
 BNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732025601; x=1732630401;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jx41v9BGhl28go6eSkoYYRKJ1NuKjbZRTpl+oEAlBlM=;
 b=TEBZVwkB5UjCfUG1DInMOGaKphMk7PVBsUpwuKcxVx/PAgYWi5mfw33xIxLwGBNlm1
 ZJxbZk3nWERyioD9Qfv0Qoch5B+D8LZu2T/ocOVuHoDwmVWMU+9+CV0b44+pDI5pIRft
 xIRx8ECVPWYKbN7G8qdhBWiHVzMtoP/kbIb8UvVbw6csJdbZZRlPLp4ib5YeQ1Zz88S9
 SSvebwdFLAVMYZPYxfLr2ak7PeUG+JKRq2hGMcWe8TrZxUShXwpn3ouRAIh2GXuC2+8N
 4wl9mgpwMe/rzG5kU/IZWA48IzPQCotZkgL/xqJMmGigCDVrcOJnmZ0nJX7k/K7Fz3rX
 JZBQ==
X-Gm-Message-State: AOJu0YwIyJMh81/8riPyb7uNYxVlGSfvOIaL4tPHABjWhiJXnKj44mE5
 8cEJEKvAk03OCh0rzLLtes35uJ47Vz7yJLIiKZaEjh759zmK+hqbLvDuDw/nErY=
X-Google-Smtp-Source: AGHT+IFuWqqJ/gtrOjoGY57WRIWH6GlP3VXgJiN11BsQBU22TzM4HKp7YiD2giVO0ETA6L/lzLGTKQ==
X-Received: by 2002:a05:6402:2693:b0:5cf:68f4:e2db with SMTP id
 4fb4d7f45d1cf-5cf8fc17c47mr12004689a12.9.1732025600651; 
 Tue, 19 Nov 2024 06:13:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79c0ac7fsm5781300a12.55.2024.11.19.06.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:13:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58E3E5F769;
 Tue, 19 Nov 2024 14:13:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 0/3] plugins: generate list of symbols automatically
In-Reply-To: <20241112212622.3590693-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 12 Nov 2024 13:26:19 -0800")
References: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 14:13:19 +0000
Message-ID: <87wmgzpb0g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Now that meson build for plugins was merged, we can cleanup another part =
with
> the symbols file.
> It has to be kept in sync between the header (qemu-plugin.h) and the symb=
ols
> file. This has proved to be error prone and tedious.
>
> We solve this by generating this list from header directly using a python
> script. Dependencies are triggered correctly, and the file is regenerated=
 if the
> header is modified, as expected.
>
> v4:
> fix second patch to apply cleanly on master (was applied from a previous =
series
> to enable windows clang build before).

Queued to plugins/next, thanks.

I'm not sure if it meets the criteria for 9.2 post freeze although it
seems pretty safe from looking at it.

>
> Pierrick Bouvier (3):
>   plugins: add missing export for qemu_plugin_num_vcpus
>   plugins: detect qemu plugin API symbols from header
>   plugins: eradicate qemu-plugins.symbols static file
>
>  MAINTAINERS                    |  1 +
>  include/qemu/qemu-plugin.h     |  1 +
>  plugins/meson.build            | 12 +++++--
>  plugins/qemu-plugins.symbols   | 59 ----------------------------------
>  scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++
>  5 files changed, 56 insertions(+), 62 deletions(-)
>  delete mode 100644 plugins/qemu-plugins.symbols
>  create mode 100755 scripts/qemu-plugin-symbols.py

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

