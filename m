Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DEAD6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBh9u-00029r-4O; Thu, 14 Nov 2024 16:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBh9s-00029K-8Q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:13:44 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBh9q-0002R2-Nq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:13:44 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d447de11dso24290f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618820; x=1732223620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+YRhF2T9O6zv+6HYmMwaQTIoCvewNJOCAaL701S1Dk=;
 b=sFj1VEw//PwbCRH4icynZDNXC/Gejw3seKj3wcR8zz7ASUb7lpstGO3bYgCNhaObWP
 EC1prS9EBqAnyQYOjdqPe2Aduyh0efWjsbPRiwIfC4mENHpRJEAnjElxSxSu/Wy+QwzO
 eyTJHaxoAUZKT2s5hE7bQ/KEzlpm/Tav/yPkxVQCe1uxX3vK+JSMEqnOhLNv8hDoT6ov
 aAWeKeIx1pDYsKmoFqMlWrzzdKHi3v9WHN1kNglOVb1Q06+Bg31/K52iJjrFerUffJXr
 Y1cDEoK/8VYhGf7l45pXj0pL+BmhRTBi9FQfTMBEK7EY+xFOg+f1ElV+zo0nG9ph3YpM
 BiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618820; x=1732223620;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y+YRhF2T9O6zv+6HYmMwaQTIoCvewNJOCAaL701S1Dk=;
 b=wOupD5Up+bxaeRjfiQ++J3Bw8PiHlYvxsF/Fxewt9K7NaBnEsb7Bm4R9/phq5jYj7d
 P8MTyhpagEWirV8DGRZZRN7i1b+FGz9+bm2cnS6Rty4ijnaEtEIwxH+azWP+lVPdvIRB
 EnCPsRLT17z6nzeot8z2V0Ff8RJPuC4KdfZ+JUhUc2PDTNGSQy91mIY7ThfDsNJ6v1EE
 hUPgU/z5aFhQgDS8oO2gyGOG+Lo++ZgBkqegR35Upjf4qQWgErZRMHN3K1LLeJinkmDQ
 K75dfdOT1jcgsxb+SInKxxLDLoBs7vemsDMGbSXQ60pmFLEns6m8PY+anpg5GLqfMZKW
 yRsA==
X-Gm-Message-State: AOJu0Yy+jI9TR3tO5U6VblhXy3KwBDOnKZJly1Jk4d2sB6WTzB/+TV0M
 CacFtu4PPU0toryMl6bqk8rZuPBd9ktRnGfXncMOKvWWtL+McVvCY9qlKBO+MYc=
X-Google-Smtp-Source: AGHT+IGAsWiSxf/m/LQHcnB5vjkgeKe2bHmnaUVxeIoNz16LvpRIhlLZof78wOcoa9VF84l64TvGRA==
X-Received: by 2002:a05:6000:2108:b0:382:25c2:b0c9 with SMTP id
 ffacd0b85a97d-38225c2b224mr94968f8f.6.1731618820461; 
 Thu, 14 Nov 2024 13:13:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae3128bsm2416231f8f.102.2024.11.14.13.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 13:13:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1FCC15F867;
 Thu, 14 Nov 2024 21:13:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  manos.pitsidianakis@linaro.org,
 kwolf@redhat.com,  junjie.mao@hotmail.com,  zhao1.liu@intel.com,
 qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 00/11] rust: improved integration with cargo
In-Reply-To: <b0fee459-fb9d-4f41-b5ea-82d553f67578@redhat.com> (Paolo
 Bonzini's message of "Thu, 14 Nov 2024 19:18:07 +0100")
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <87plmyrmjh.fsf@draig.linaro.org>
 <CABgObfZT_jYJqKDnTAdrVjr9KdQXjNVEt2eQfDpoqrh6xEnVsQ@mail.gmail.com>
 <87jzd5suw4.fsf@draig.linaro.org>
 <d2813ee7-6500-4145-b767-37d227747944@redhat.com>
 <87ed3dsp2a.fsf@draig.linaro.org>
 <b0fee459-fb9d-4f41-b5ea-82d553f67578@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 14 Nov 2024 21:13:38 +0000
Message-ID: <878qtlsem5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/14/24 18:27, Alex Benn=C3=A9e wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 11/14/24 16:22, Alex Benn=C3=A9e wrote:
>>>> ERROR: Build data file './meson-private/build.dat' references
>>>> functions or classes that don't exist. This probably means that it
>>>> was generated with an old version of meson. Try running from the
>>>> source directory meson setup . --wipe
>>>> I also tried a wipe and re-configure but the same thing.
>>>
>>> Ah, nevermind - you must have an older meson installation in /usr.
>>> You have to do pyvenv/bin/meson to pick the right one.  I'll adjust
>>> the docs.
>> Hmm,
>> =E2=9C=97  ./pyvenv/bin/meson devenv ../../rust
>> PermissionError: [Errno 13] Permission denied: '../../rust'
>
> You're confusing two things:
>
> 1) to start a shell
>
> pyvenv/bin/meson devenv
>
> 2) to run clippy
>
> pyvenv/bin/meson devenv -w ../../rust cargo clippy --tests
>
> Note the -w.  Since the latter is typically covered by make, the
> common one will be the former.


Ahh right - I misunderstood, got it now.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

