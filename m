Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC86C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYtoZ-0005Fa-K7; Fri, 17 Jan 2025 16:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtoU-00056P-5j
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:23:36 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtoS-0000i1-Fs
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:23:33 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaec111762bso492590266b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 13:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737149010; x=1737753810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQVliGBj/xNYeqnWgpiK/29YYP2+ghiH9j2yQp5FAQc=;
 b=L7iyncCOwCW8L3iA8N4HET/apu4+c1m8QXdMLFxkVl93SfguHhSuqnVQHVbFrdY7xz
 Q/tgkn6EHwg85I5hUGtFFneDYSd42Icx370acQwT3gjs9TUz6M2qs34rM42K0a6uiBBq
 IqNsX92L/lAgJwVIRmMa/ESKpdAWpMX0GcUcptDydshuVbPoA7um2mkQdqx0MnO2cbNZ
 hZBdWt9UrgpwvQsxsMz1Fx5R+rhL3tI1Lc2KIkgJIPtEdig7dGWkd6XKUBw4sypNQWTU
 4M92Cl35a5O2NhlWXhmVU9O22HQUz95TkJNjCtuLGZPaMJLVJSpmXm6cKeNsPl798OIQ
 dmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737149010; x=1737753810;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AQVliGBj/xNYeqnWgpiK/29YYP2+ghiH9j2yQp5FAQc=;
 b=w25qnwqUfAx0jl437tzYNIQqW2/XeZ4R8O54wsP2cYdtWQCQVZc2Gym/uaNTlpgkj1
 LHA2ZyXK7xnZ1lU1zvO7VXkQnQMPaiqXz6cJWtY+N6iSSoN505nZs1Ff2ftJFwyNCdks
 NLnPiBRrH7XNSvRj9UkIUm08UnHipdekgdHHkyKByh1BJFHCY0MpkIvKXv+SHlIVzSOz
 1P/hrhVd9EkopazMbJ7U0Ut/C4S9mk5BGGExHly6HwemzH4c9UWa+6lMHmSTquSJhSN8
 9A342hzUSjApNHL3PyftLdTlXJ5p7LP59r1NbGGg1G1KEsm4HqgCBkLnyp4vdZqGNXA/
 UmXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEXtaXWLrQh2mT37nUswqgGIX5JT+ysRGILqb5l5MOQgpPU7jhFYOhC5RB+rVHpkJVldwKSerPAiEi@nongnu.org
X-Gm-Message-State: AOJu0Ywo1aJavSbR3uow0icKDk75KYx7qd9wn5pcHkYBLPYZ593B4GdU
 SPcpRLYVk4ybxOfK0EfgKiZZkzieQJGQpxVChTbRBE8WX1sIBU4R9/VX7c0BA3s=
X-Gm-Gg: ASbGncuy5lIWfCPh7lHKgii57tzOrMu7HdQHQGCEvyF0/MW7S829zzMCREf9G1L2nKb
 YpkPgJbw//W0N7Gu/sPULXVR+c85SCao+4ZTHeI0YNOcc/RypZo6jD0+V/45FyOo3SRq52eU4N4
 D4U45/WbvSAsMb20Vilq7la12NST0FpU77Ie1hpnoYUFvad8NWWfuHSOxmXMZdtKQsbUea+SmlL
 8HjxYxgHuC/loDfGAZS1l/SQJAWbmXMclYyi9jCBRowvZE9efsq9cc=
X-Google-Smtp-Source: AGHT+IFiinzWu9R/X0uAD+klYND2y47IPeQoGELCFrjfyMBfzDGsXCg26wcUDY3nnB+JwBWbfBsk9w==
X-Received: by 2002:a17:907:d0f:b0:aae:bd4c:2683 with SMTP id
 a640c23a62f3a-ab38b3c63f5mr416087166b.49.1737149010067; 
 Fri, 17 Jan 2025 13:23:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f1e57bsm232133766b.104.2025.01.17.13.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 13:23:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A87B6083E;
 Fri, 17 Jan 2025 21:23:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v6 0/8] gdbstub: Allow late attachment
In-Reply-To: <20250117001542.8290-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 17 Jan 2025 01:11:25 +0100")
References: <20250117001542.8290-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 21:23:28 +0000
Message-ID: <87plklm8xb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

<snip>
>
> Hi,
>
> This series adds the ability to attach GDB to a running qemu-user
> instance. This is useful for debugging multi-process apps.
>
> Patches 1 and 2 implement a small related feature: the ability to
> create individual UNIX sockets for each child process.
>
> Patches 3-5 add the required infrastructure. In particular, we need
> to reserve a host signal for waking up threads, as discussed in [1].
> By the way, the problem with atomicity of checking for pending signals
> and invoking syscalls that I'm describing in that thread seems to
> have already been solved by the safe_syscall infrastructure, so the
> changes are fairly simple.
>
> Patch 6 is the implementation, patch 7 is a documentation update,
> patch 8 is a test. I tested this series on Linux and only
> compile-tested on the BSDs.
>
> If this series is accepted, I will rebase the all-stop series on top
> of it.

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

