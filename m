Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5C1CFD376
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 16:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPkaM-0000ea-2f; Sun, 30 Nov 2025 11:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vPka6-0000cc-JQ
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 11:47:29 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vPka4-0004wD-7y
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 11:47:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so38499415e9.3
 for <qemu-devel@nongnu.org>; Sun, 30 Nov 2025 08:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764521242; x=1765126042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqhFbis3FMhEsmUAR68oX6EzGRXZV3SFexLqrnUI3Mg=;
 b=g7N6Ce9ZlHVRffL6bcO5xtjp4b/6GAeelNUg9mZXFAp0423quokNwVVoGBONC2abTB
 jkdxEIpHG28xjy7OzobIWl4Bv+TT0TokXrq0kHSmIDfFiOPBgFhSVkQQlmdxH8jKSbi+
 Z2OwCBWM1pqa7Tc+z/T+uXHRs7P8CCsCDnLet2zgEczy/FSMAFBze+DASnp4PIMcseXI
 p2hQp+cVZf/tgt/H597g/uRC6jgSRA6Fns8RYXYckoM+HoD6ir9SLTNOG7x7Cm9HBdIw
 Y8FkgLiYErJpqwI0vDd7gk/3oyaMBM4y0HumAIk6WVkxzMAbXdKXRS3b8wiRsq85fpM9
 sL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764521242; x=1765126042;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FqhFbis3FMhEsmUAR68oX6EzGRXZV3SFexLqrnUI3Mg=;
 b=YQpWSkY56e3YvLtQr54gMmYvyk5Ti8eqRLzaZpBumMjDpnrhNRpD44zQOAR5NRrqbN
 mGYl2pz6mg2OBbyuNPdGYIDUkDz7hB9t42j/JEpzm7NziOe6Fmb0nNA+wR6/vqqONL+L
 8R8ITgdT5jLHRAJJ6r1TnFiOqK6BXMMHHkPyJJVB5Hcd9p5G0axQbPteBtDpoMm2TB3H
 SrjHQFTGTfa+9SC77KfFIoorfEmolQdP50AEjYde4oJcv5tV148x3mEMTE2ARL1uwtM9
 aQQpHs9R2jkTtwafijbu5Us2/+8dJ15vSwiRAoVU7FW1jsD0k+qZYVultsgIlU1rbebR
 9VZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi3NkY3H8phA4aDqP8Icvj64ABqy6+tVpK6IZTpaomVygkV0q72S89YbC/thh9gJLkSG5Xz0agatyV@nongnu.org
X-Gm-Message-State: AOJu0YzXF37Utwwye8WpXcrREo0XZaQdatXis7Pefo6L5AQfoXb4vq1F
 lMklUjaGrFdMPWB/DZ4x65QxuoYvWODMRDeYrcgNGbbDsIAjvfGkYGyqbeFcuJ/vymg=
X-Gm-Gg: ASbGnctZWCRz/OFroXRzmtAAAqUWRTKh6H+0fUQLhs7MT5W8QPV8QYMWvqxkBXuddvl
 ssiAA2+x7NdTeldbgBqlc4TAkhtDMwPLKDlsX3W4EwzTAHzCgpSIpDJDrUGvSbu7ZurHKYcrLEa
 oIOCNifOpfz8u+6+VEvF70FhXbXoQrh/4f3kmLUVdDodLdNkCkbUnqsMOOueUD9GO24s9RZAHqQ
 b7Qyx6gOvBNGc35dl978Qg7nrdb8DA1JMy+HN+fNA/8cyiN55kFg1TE+GQRRvskxC9CrPitLbEh
 UBpBxVevOY2QwUFkk7NOBd9hxuyHF7k2/AIKYZ3K8J/oRHn7+xKaXpUlKn1hsWpbHMuOf0cGVbl
 DEghUm7srnM+LmPT32ZMbMwcMabtyhs1gTpZgjLwQcckMg2slVezwRV4E/xvS+7tFhSW8uKYo+Z
 OYBe93uXwExTs=
X-Google-Smtp-Source: AGHT+IGiSGbJhgCUu35gbx72MzSvKNTXAaN3Y/dIcgVFpbq9bkROgHZHe2ehkQ1FgMbwaSdiPcLq5Q==
X-Received: by 2002:a05:600c:3b96:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-47904ad907amr250251635e9.10.1764521242030; 
 Sun, 30 Nov 2025 08:47:22 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca9aea3sm20525545f8f.35.2025.11.30.08.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Nov 2025 08:47:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B58125F82A;
 Sun, 30 Nov 2025 16:47:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
In-Reply-To: <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Sat, 29 Nov 2025 22:33:39 +0100")
References: <20251128133949.181828-1-thuth@redhat.com>
 <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
 <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Sun, 30 Nov 2025 16:47:19 +0000
Message-ID: <87zf838o2w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

> On Fri, 2025-11-28 at 18:25 +0100, Ilya Leoshkevich wrote:
>> On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
>> > From: Thomas Huth <thuth@redhat.com>
>> >=20
>> > We just have to make sure that we can set the endianness to big
>> > endian,
>> > then we can also run this test on s390x.
>> >=20
>> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>> > ---
>> > =C2=A0Marked as RFC since it depends on the fix for this bug (so it
>> > cannot
>> > =C2=A0be merged yet):
>> > =C2=A0
>> > https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-21821281889=
1@redhat.com
>> > /
>> >=20
>> > =C2=A0tests/functional/reverse_debugging.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
>> > =C2=A0tests/functional/s390x/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> > =C2=A0tests/functional/s390x/test_reverse_debug.py | 21
>> > ++++++++++++++++++++
>> > =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
>> > =C2=A0create mode 100755 tests/functional/s390x/test_reverse_debug.py
>>=20
>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>=20
>>=20
>> I have a simple fix which helps with your original report, but not
>> with this test. I'm still investigating.
>>=20
>> --- a/target/s390x/machine.c
>> +++ b/target/s390x/machine.c
>> @@ -52,6 +52,14 @@ static int cpu_pre_save(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_vcpu_interrupt=
_pre_save(cpu);
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0
>> +=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure symmetry with=
 cpu_post_load() with respect to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * CHECKPOINT_CLOCK_VIR=
TUAL.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_s390_tod_updated(CPU(cpu=
), RUN_ON_CPU_NULL);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0}
>
> Interestingly enough, this patch fails only under load, e.g., if I run
> make check -j"$(nproc)" or if I run your test in isolation, but with
> stress-ng cpu in background. The culprit appears to be:
>
> s390_tod_load()
>   qemu_s390_tod_set()
>     async_run_on_cpu(tcg_s390_tod_updated)
>
> Depending on the system load, this additional tcg_s390_tod_updated()
> may or may not end up being called during handle_backward(). If it
> does, we get an infinite loop again, because now we need two
> checkpoints.
>
> I have a feeling that this code may be violating some record-replay
> requirement, but I can't quite put my finger on it. For example,
> async_run_on_cpu() does not sound like something deterministic, but
> then again it just queues work for rr_cpu_thread_fn(), which is
> supposed to be deterministic.

The the async_run_on_cpu is called from the vcpu thread in response to a
deterministic event at a known point in time it should be fine. If it
came from another thread that is not synchronised via replay_lock then
things will go wrong.

But this is a VM load save helper?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

