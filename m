Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71280D597A4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAy81-0000u1-MS; Tue, 12 Nov 2024 16:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAy7x-0000tY-Dc
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:08:45 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAy7v-0002oM-UH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:08:45 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so6163981e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731445721; x=1732050521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmdEFgq45obI7C56tRv6Ix6570wzi8bDm2li0JdWk1g=;
 b=XAFg2ukg2yO/A5pfw/Pwq+IpQtDvAdh6i/Ge1EeCh+Pw0RJx+jgbJCsRdf52Fj39LT
 NzAmthdYgQQYMRvWBaOAMu8gGvVwvCgNmUs5cl2/gvWBvWrFRVzUiY+uFKHxQszbCBpE
 vnG55ECkTDgkqLI/02Ach3+IEZjq9XWRnnq+zOYGpYWaWJWPJ+TLndjn53gNEeooKFpn
 8NtzFAfvalgKwVtdDnibtE8dSgA4kIWZDGAb4lwd7GX8d21C7GWw47IBv3y3s6DTReN7
 yNllPI2bcVu1UCKfxGfUSai+TOiS4/O6gSVsXGGlyHck1riCjiCbKfMrXjDLoqwSIHoR
 7ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731445721; x=1732050521;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KmdEFgq45obI7C56tRv6Ix6570wzi8bDm2li0JdWk1g=;
 b=wWSCWRi/VaSXUVHXm3ya022XO9IZ5jtS3K1I3NbB5gE5HqdJR+nXWMh12aiNgTxYyo
 6QMY6V+WiNr8Jxgh/mfYY9Zv5gA4FNsk5FD7WoShv3kSu2PMNyNACtyc+2nt4EfalVBk
 wwP73EimEgvACL/EpOL4pgzMOVHmNJoVyabWDMxvHHKcLlsxeFV/agtYAey5iuae52w9
 IbxE3xF+GtE9FTxm9N+cQBcwSXRZBf8Q0n+sjFTwI94hEDdy317vq2kQUQL+PEgDq6K0
 3TZBeg1znoHQEFCdoK3UAol7NB0ZGhfak533N2cl0l1ok5wqju2ffOw9vi5sPp6tVuOQ
 QwVQ==
X-Gm-Message-State: AOJu0YwqAo5/rHAERAbpD2XgRD5jw3xWtf8V7eebiNpb2jSjqdK2tlZx
 sM42BysMxbbcfWzL+f8dGUkd0pxyufkCGJCkWhZLSHaqeoFlZ435wN+mCJAiaOg=
X-Google-Smtp-Source: AGHT+IHwXPU+OvJ7K6tH4OQnaXMusEVgTrsO34ZcPGeX4OiEY+tJUkLA9PGvxdRqd3cPJvUNJvSfRQ==
X-Received: by 2002:a05:6512:3403:b0:53b:2114:92a7 with SMTP id
 2adb3069b0e04-53d862f359cmr9372372e87.52.1731445721055; 
 Tue, 12 Nov 2024 13:08:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc50ddsm781442166b.103.2024.11.12.13.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:08:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 930115F7CB;
 Tue, 12 Nov 2024 21:08:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Cleber
 Rosa <crosa@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  John
 Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/3] plugins: generate list of symbols automatically
In-Reply-To: <20241106170923.2976750-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 6 Nov 2024 09:09:20 -0800")
References: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 12 Nov 2024 21:08:39 +0000
Message-ID: <877c98upm0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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
> Pierrick Bouvier (3):
>   plugins: add missing export for qemu_plugin_num_vcpus
>   plugins: detect qemu plugin API symbols from header
>   plugins: eradicate qemu-plugins.symbols static file
>
>  MAINTAINERS                    |  1 +
>  include/qemu/qemu-plugin.h     |  1 +
>  plugins/meson.build            | 12 +++++--

this failed to apply cleanly.=20

>  plugins/qemu-plugins.symbols   | 59 ----------------------------------
>  scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++
>  5 files changed, 56 insertions(+), 62 deletions(-)
>  delete mode 100644 plugins/qemu-plugins.symbols
>  create mode 100755 scripts/qemu-plugin-symbols.py

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

