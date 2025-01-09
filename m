Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36578E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrVK-0000kL-6d; Thu, 09 Jan 2025 07:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrVG-0000jz-4E
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:19:10 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrVE-00080G-Jx
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:19:09 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so1251474a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736425145; x=1737029945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPPHw6XSM9e5L6QnIrZU/FSt0WUGecejGIZKalitM3o=;
 b=ycCVCZTQnfq6xka+DkGigCF2MBEmSHpxWwfr67BAtTClAhqVmX8Yyhe+9UCJ10c2HN
 ACqBVC671OiCEqlVJvZNpGSB5SSoF+lrkz0t8DhJzXFUD5z7fOQrAtLCEH+p+L0xI3Jj
 ErLyhsOYFac/doAB+OmvKlz8glc+KzBghz+/Xl4FLjIa618WhQxREcbrPjaHMW7kD9DQ
 sZwCwrioFMNjPBNiIe+cBlclV18MJUn2/NZBlt05l6zCnXw2z38vokdpFJUaIj8+hmIZ
 G43TaVz8HnF9Q+IaxGPGiEhqBB6P2d0dquOUs+VoKedRgkqLLTduoST9AoN3rX5/mpZ8
 tUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425145; x=1737029945;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HPPHw6XSM9e5L6QnIrZU/FSt0WUGecejGIZKalitM3o=;
 b=hOxAbi+jl9eYfet2JeDGXjNTwZNxa2d4xBSKXe7US0yvw3Z8twB8OrZs/IBCFtLaEk
 Q8Ay5ipSpAVcmazcPC+X0yZFnRpQgK5vUML/cU2rLV+fZaGwjHumM9JYxASXT316tNEt
 YKMJuWHCTS8qJZ08qd7dY82wKI8QNLlepAVL+TC+r1oJiiG7KhDzuAiXcLxnhA81P/Bw
 INDUGUKeno0UqMBQZraqpinXWvRp64htj3bqt7m3mxnQAVg6LR58t6SkOhoeY/GYqdRK
 l3nuuameplUomVE1/kAGYRm+n6CyOamH5CijzFdSImmrVcolnSySP1WIXyUl+s3UFCym
 z9EQ==
X-Gm-Message-State: AOJu0YykXB0vFkbv4I3J/dkSK9Qigi9DYZZFUbMstDXlEgnT0FUNCzpT
 QQRDnpPpETuBSTXxhH4ljAAuSRjGs3y0uAMRzoLLeZhBA0Frr2+3AduBC1a/7PE=
X-Gm-Gg: ASbGnctuDe7ibT14dybxi4pd4SkHB1bu+lyvfX7fwEugmHAE9qn9RspDU5cdH57LV2s
 iIZBSIAcquexu53D3grnioLqHH5yspclVQBp6Nz9DTPK1iz4QrjqZUIuTVa+TirWELGALqAejLp
 C1nCdhlo4HBxkq8mMKPyImy4Np0YIDrPJ0FfKqLuhXGtqO/wQqOFJuUZcHfQt8jMyL9K48BzXwI
 lyGXW5i7m/usy5a+46jrIeYv9cTZ29kQCjOqDACPIOjqFZvR25kOQ4=
X-Google-Smtp-Source: AGHT+IHMVNsiwlclX1rDdGivjHAZ0JuUHPgIB1FlU0OLc9KVb/mfsZyLL7D0RxWtb5nBngXD7EeklA==
X-Received: by 2002:a05:6402:358d:b0:5d1:1024:978c with SMTP id
 4fb4d7f45d1cf-5d972dfbc2cmr5232816a12.2.1736425145376; 
 Thu, 09 Jan 2025 04:19:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c4326sm540374a12.23.2025.01.09.04.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:19:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 408275F87E;
 Thu,  9 Jan 2025 12:19:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: make docker-test-build@debian-loongarch-cross
In-Reply-To: <d14c7896-807c-466b-86ff-a590dea24979@linaro.org> (Richard
 Henderson's message of "Wed, 8 Jan 2025 13:50:22 -0800")
References: <d14c7896-807c-466b-86ff-a590dea24979@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 12:19:01 +0000
Message-ID: <87jzb489je.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Hi Alex,
>
> It turns out that $SUBJECT does not actually cross-compile to loongarch64.
> Within the logged configure,
>
>   Compilation
>     host CPU                        : x86_64
>     host endianness                 : little
>     C compiler                      : cc -m64
>     Host C compiler                 : cc -m64
>     C++ compiler                    : NO
>     Objective-C compiler            : NO
>     Rust support                    : NO
>     CFLAGS                          : -g -O2
>     QEMU_CFLAGS                     : -mcx16 -msse2 -D_GNU_SOURCE
>     -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
>    -fno-common -fwrapv -fstack-protector-strong
>
> Obviously this is less than helpful as a smoke test.  :-O

I think it's just missing the right ENV magic as the other cross
images have, e.g.:

  ENV ABI "aarch64-linux-gnu"
  ENV MESON_OPTS "--cross-file=3Daarch64-linux-gnu"
  ENV RUST_TARGET "aarch64-unknown-linux-gnu"
  ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Daarch64-linux-gnu-

For the normal debian based images these are added automatically by
refresh:

  def cross_build(prefix, targets):
      conf =3D "ENV QEMU_CONFIGURE_OPTS --cross-prefix=3D%s\n" % (prefix)
      targets =3D "ENV DEF_TARGET_LIST %s\n" % (targets)
      return "".join([conf, targets])

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

