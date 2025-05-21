Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C04AC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 06:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHcrB-0002en-D2; Wed, 21 May 2025 02:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHcqx-0002a3-2F
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:23:00 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHcqt-00080g-0U
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:22:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso5190462a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747808571; x=1748413371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmjMaExr94xpqZ6RskD0B1uI5hCJx3jJ3vRdFWdXEik=;
 b=yUKTrdO0QnFg1yPYMCxl1w6YQIqUcMn5tNn/BvcLl2husW4iHoaVka3S/ElOJ8MZDx
 ZCOLDChsugDwrRGvPsZ464ONtHRXbneu6v4JgbhdcIcZbO1su9p6mqP8/3tsODwngrc/
 8AEY0rxVEiojhdB+PnIBduvZnFmq8TV3gbybWg1Cgge9dS+Vv6LcXinBBIpTXsWikAZt
 itoINjKV3h0H+FZC6ub00lZL97GFHAJPfTB8Qa3MZlabmw9HIFR1APHEmr5wC2wTCWAa
 vlvS10twM4Tnw1HTDqccGkIJg7cEQ5EDlBmUVoA+SLF6Lj5bcHwWN/N4BVyEBpMO16k1
 snlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747808571; x=1748413371;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PmjMaExr94xpqZ6RskD0B1uI5hCJx3jJ3vRdFWdXEik=;
 b=oSrTpGRRPuCZObLkBo8r8D6WYAbpLN9ozRIudZKsFJa7S43wWzYRZjx/bjgRK1sBvY
 F6blbsKKACPSUU0PfA6GmOkfVwLIoYz/WqZmBckz+mF6+LUskoCgPnEG3s45u2UNrMb3
 fO8ra38ra8VdXM3n4kszTwUf21wPdPc9R+ng/C+vvPWZpU5nLaIszgE9iBC4gLerM+ru
 ZHCQG/ka//tOZJvb3m0y64h+jnpNoFXBfP63Th2IzKpREHaXNMh8F2cqTgJRVHNbJJ3K
 c589pI7R/gi1IoimyyP/P4B9t26oCkAG/dp7nTqdLqVyqtGDLJ7tGsiTtO+EtXnXErfF
 vZlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmuqPREL6ms9UO4f3n4QW1cKjvhQoZ1R+cAwNsCETRcWMSxnYKngNUidobJ+7cvFzTh/OnjLea4Mgf@nongnu.org
X-Gm-Message-State: AOJu0YwvLeDMZKOds3wthX+BEW/FNg6E2QDx12qHorKI4XyVSPBku4c4
 9qpMM8PGknTK6gN5VLzlPVvuuv4tR/9yh5sfPFowvKDTrxJbD2VKXSXc0BiUUKEubH4=
X-Gm-Gg: ASbGncv2Alf+7hMbJ4+UR07bV0yguQPQlOwl2YKNKxNmBsNXmHMkzZpy5Jvm0YjYMj/
 8r7ostZa+h/MmzXWSAq7nzul/oqrP7QVNTsD6A+Bp4vooXiYI9VEty089AXzTE5DzW0PKjFnBkx
 Y4XqXK/+zTCQBk6ogIOdtmcuB+E42NyzHuVUXsH2asHKljnDHxLwLOjmdOw5F/gxWMaPUlEKZhX
 zisHJAqsKgm7ExBENy2edg+wvZtlMBABUWq4oYubjOWBM9IJNLGX+NJZ2U3vJLsN8kTKmg9Tz2K
 VKjmpGZgpe5AaMm06ysETzAla4PKlcj+0RCx2jp20xg5+6wzwVyZ
X-Google-Smtp-Source: AGHT+IH1/gQhfVRuvcL1z1r0r1JLSqn5JrfMp3cb4sB+s0qyXM84NTy8sluQLk3OJDJpqAP1+dqV4Q==
X-Received: by 2002:a17:907:7f08:b0:ac7:3817:d8da with SMTP id
 a640c23a62f3a-ad52d609170mr1523651866b.52.1747808570802; 
 Tue, 20 May 2025 23:22:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad5572f6436sm598125566b.182.2025.05.20.23.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 23:22:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62DD65F9CB;
 Wed, 21 May 2025 07:22:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Weiwei Li
 <liwei1518@gmail.com>,  qemu-arm@nongnu.org,  Nicholas Piggin
 <npiggin@gmail.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Bin Meng
 <bmeng.cn@gmail.com>,  Tyrone Ting <kfting@nuvoton.com>,  Hao Wu
 <wuhaotsh@google.com>,  Kyle Evans <kevans@freebsd.org>,  Alistair Francis
 <alistair.francis@wdc.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,  Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  Fabiano Rosas
 <farosas@suse.de>,  Alexandre Iooss <erdnaxe@crans.org>,  Laurent Vivier
 <lvivier@redhat.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  qemu-ppc@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  qemu-rust@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 11/17] gdbstub: Try unlinking the unix socket before
 binding
In-Reply-To: <56e0a35b5c53b416db130c414cd0f3d6@linux.ibm.com> (Ilya
 Leoshkevich's message of "Tue, 20 May 2025 23:21:37 +0100")
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
 <20250207153112.3939799-12-alex.bennee@linaro.org>
 <ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru>
 <56e0a35b5c53b416db130c414cd0f3d6@linux.ibm.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 21 May 2025 07:22:49 +0100
Message-ID: <877c2aa3eu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On 2025-05-20 15:50, Michael Tokarev wrote:
>> 07.02.2025 18:31, Alex Benn=C3=A9e wrote:
>>> From: Ilya Leoshkevich <iii@linux.ibm.com>
>>> In case an emulated process execve()s another emulated process,
>>> bind()
>>> will fail, because the socket already exists. So try deleting it. Use
>>> the existing unix_listen() function which does this. Link qemu-user
>>> with qemu-sockets.c and add the monitor_get_fd() stub.
>>> Note that it is not possible to handle this in do_execv(): deleting
>>> gdbserver_user_state.socket_path before safe_execve() is not correct,
>>> because the latter may fail, and afterwards we may lose control.
>> Please note: this is linux-user stuff, which is usually linked
>> statically.
>> By linking it with qemu-sockets, we basically broke static linking,
>> because
>> qemu-sockets uses getaddrinfo() &Co.  The previous code, I think,
>> was there
>> for a reason, - to avoid this linkage.
>> How do you think about reverting this one and addressing the
>> original
>> problem without using qemu-sockets?
>> Alternatively, it might be possible to split qemu-sockets.c into
>> unix-related
>> stuff and generic stuff.
>> Thanks,
>> /mjt
>
> I can split it.
>
> However, wasn't it already broken in this regard?
> With fccb744f41c69fec6fd92225fe907c6e69de5d44^ I get:
>
> [2/2] Linking target qemu-s390x
> /usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function
> `g_get_user_database_entry':
> (.text+0xeb): warning: Using 'getpwnam_r' in statically linked
> applications requires at runtime the shared libraries from the glibc
> version used for linking
> /usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically
> linked applications requires at runtime the shared libraries from the
> glibc version used for linking
> /usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically
> linked applications requires at runtime the shared libraries from the
> glibc version used for linking
>
> This comes from glib, but the ultimate result is still the same.
>
> Also, what are the symptoms of the breakage? IIUC as long as execution
> does not reach getaddrinfo(), which it in this case should not, because
> it is used only on inet paths, there should not be any issues, right?
>
> In any case, the new warning is annoying and I better fix it for this
> reason alone.

I sent:

  Message-Id: <20250520165706.3976971-1-alex.bennee@linaro.org>
  Date: Tue, 20 May 2025 17:57:06 +0100
  Subject: [RFC PATCH] util: split unix socket functions out of qemu-sockets
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

Although I'm still seeing some warnings on my build:

  # QEMU configure log Tue 20 May 18:14:18 BST 2025
  # Configured with: '../../configure' '--disable-docs' '--disable-tools' '=
--disable-system' '--disable-vhost-kernel' '--disable-vhost-user' '--disabl=
e-vhost-net' '--static'

Gives:

  [142/142] Linking target qemu-xtensaeb
  /usr/bin/ld: /usr/lib/x86_64-linux-gnu/libglib-2.0.a(gutils.c.o): in func=
tion `g_get_user_database_entry':
  (.text+0x287): warning: Using 'getpwuid' in statically linked application=
s requires at runtime the shared libraries from the glibc version used for =
linking
  /usr/bin/ld: (.text+0xe0): warning: Using 'getpwnam_r' in statically link=
ed applications requires at runtime the shared libraries from the glibc ver=
sion used for linking
  /usr/bin/ld: (.text+0x11e): warning: Using 'getpwuid_r' in statically lin=
ked applications requires at runtime the shared libraries from the glibc ve=
rsion used for linking

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

