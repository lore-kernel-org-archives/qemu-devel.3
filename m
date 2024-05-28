Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828BAC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzLe-0006Hd-1W; Tue, 28 May 2024 12:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBzLb-00063F-7o
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:06:47 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBzLZ-0008L9-Ig
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:06:46 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e6f51f9de4so14568061fa.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912403; x=1717517203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YHYecngcfP+cnuiFNHNnKYtAES45L/aLzBrihqhhMvg=;
 b=f/fz4gfoFv+KSYJTk6e29CDroxq9Nyt9ojjRnarAkoZeXLyTC0NkkheVCULeCgNxAO
 jU51cz4yIUrVo5lOoxTfyHrHlSEcUgrKmulUZyj3FhMtHLzcSl8D4jvErFR0xLj+L4lC
 EjXjJNXEdUm5oCenFaRj6fS/o4bmUcysZmE0WsTg9dI9VG/q+U1F1bH13ksMdcBfWW01
 SFVQhadhcyBBpGsbJWrxRPNfs8QVrc5H/PP+/Rs8MgNuJMy7/hRqBYDLDZGCkO+kh2z0
 LX0m/0ZZgQPKCG/cJeFtLeso9TLWFnrhOqTaB5rJhZtpu52mBUqgfsa1H/6A1k/OGDyb
 4fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912403; x=1717517203;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHYecngcfP+cnuiFNHNnKYtAES45L/aLzBrihqhhMvg=;
 b=iKWSx1n0m44ZxKbuWdsvqIlGG8BkyrbMLU9bTfSWHkndOb/FG27FCT4gmmmKS9MVsD
 vV6m4JCaKOzXF5EGwUdWXIxgEvaZHmW1BgeMJqp7JyJn5PVO3xRdvmwQy92NtwyFcHgK
 ZE5kqQ9TL7fX58Gxpa1NRWmTrl9260swz9BY0kRPLJSWyckaiRM8Wrilc/Nk2dpTkSLE
 zb4F3NtbZC4pCwLRKW0yoP08hH+NOEhXafaGGM2Z3ypWxLEZpPz7jk+uLlyrRO+Gmcqt
 CVVI2xTvnhNTLtUVeQ2PP9Qz0zkCZsOYS2D/ud0TcwtQSizNMxae9B0RxBsaS2mwIYlc
 R3tg==
X-Gm-Message-State: AOJu0YwNR31aqo/o5Zw51Cz2R/EHr8bgT+ich0AwWwBTkzgtkCKynw9a
 Ruj8L1WH9sDEZQM/lEp7Q8Uzh9gEEitx3doZE7le1rA55DXmTGkURRoVyn3BlNc=
X-Google-Smtp-Source: AGHT+IFkXziUae3ftWMSSBe5U2TVtnNnVVXC0Uh20iZw8dKF8TAfYwSM7wykY2WO1bMSVn1rLlKZUw==
X-Received: by 2002:ac2:5442:0:b0:51f:3b4d:b087 with SMTP id
 2adb3069b0e04-52967932297mr8605676e87.63.1716912402906; 
 Tue, 28 May 2024 09:06:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c81819dsm625659366b.26.2024.05.28.09.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 09:06:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE0B65F88D;
 Tue, 28 May 2024 17:06:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH 0/4] Add MTE stubs for aarch64 user mode
In-Reply-To: <20240515173132.2462201-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Wed, 15 May 2024 17:31:28 +0000")
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
Date: Tue, 28 May 2024 17:06:41 +0100
Message-ID: <87le3tgbu6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This patchset adds the stubs necessary to support GDB memory tagging
> commands on QEMU aarch64 user mode.

On application I'm getting the following failure on configure which
makes me think something is missing:

  Program scripts/undefsym.py found: YES (/home/alex/lsrc/qemu.git/builds/a=
ll/pyvenv/bin/python3 /home/alex/lsrc/qemu.git/scripts/undefsym.py)
  Program scripts/feature_to_c.py found: YES (/home/alex/lsrc/qemu.git/buil=
ds/all/pyvenv/bin/python3 /home/alex/lsrc/qemu.git/scripts/feature_to_c.py)

  ../../meson.build:3851:4: ERROR: File gdb-xml/aarch64-mte.xml does not ex=
ist.

  A full log can be found at /home/alex/lsrc/qemu.git/builds/all/meson-logs=
/meson-log.txt
  ninja: error: rebuilding 'build.ninja': subcommand failed
  FAILED: build.ninja=20
  /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson --internal regenerat=
e /home/alex/lsrc/qemu.git /home/alex/lsrc/qemu.git/builds/all
  make: *** [Makefile:167: run-ninja] Error 1

  Compilation exited abnormally with code 2 at Tue May 28 16:59:05

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

