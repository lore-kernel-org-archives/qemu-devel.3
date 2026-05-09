Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC597CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 11:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfwa-0005Ky-48; Sat, 09 May 2026 07:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wLfwZ-0005Ko-28
 for qemu-devel@nongnu.org; Sat, 09 May 2026 07:34:03 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wLfwX-0003y8-Bp
 for qemu-devel@nongnu.org; Sat, 09 May 2026 07:34:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso4455946a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 04:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778326439; cv=none;
 d=google.com; s=arc-20240605;
 b=NqQF27C1rFTO0pblk0jLUFjhZgMfe0kH03/QL1EAlJ/7bBoopzebpOB/FcVjo0OaN7
 /ke0/o3ILhu8uJetivLh8ddGp28nj9AZFogG7Rw+zK2OaFpdTy2S722OXYQsy48ySzup
 Nlj9wIo2e86IAitBV/ELG77wzD/IxtGVk0j9hXPjh4XmxRA6EpeOtpJtPUlvzyz3dvEt
 YTcVNLX0GuYtyhdTSIzbKF6Zkv85O3XKi5feAvIU4znj9MXrI+B7uESU22+iwAb6DH5g
 zmJmJ3wEyB62BvcUH98CXVrDG5IeUj3HsHjVLXWiq9zhr8f5QqRbsh6azC5MKDiOSGAt
 C7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TspkOTMLVcjexYJI7Si0yzTfVtbJRfCnW8JYVQROySE=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=AdgazRY3gygmGpEwdbXzHmYIR/9fJn9bhKOrYkOsaHPnH8Cb6cHQTDzYgIUQO+8A/i
 FO+O5P1x/ejYqk+vm6kgtVzyPeOJa7UJ50D+pF2ym5SakDnOJcpO7r+iHUORqKjQzexJ
 R0BhG2W5Brj8UxvhcbJeztNvIKoVAQXZiHd0g2U/Ve7dgRNA9vVxKlwAv+cfDWYk2m8J
 bPhmVbBqPFsQWXCFVziWA8VmUtUW2XodVCkZY4F82kUnvBOrfzQbpHJF8TVM+QcMDRnm
 xy7bItuW6ZG1zQ5Ej9PUW4l6DXWP8RgsX3cfdsuBLd7pdCyYcegDr8/pZPN33J8lev2/
 yonA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778326439; x=1778931239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TspkOTMLVcjexYJI7Si0yzTfVtbJRfCnW8JYVQROySE=;
 b=Ffpugw2phMW3LNQSLRfqPU/TZd3uWT1R9xs4TcTe4eRP3oB72BfxyhzsYFAwEx7LCi
 C4L7W82BoSflOtgdgyPMFT1d2Qx2sEfsewd+X00rLM2Phiivc+W96ItSaMBzOBn1Geue
 txKnSNrc4RC8eOxwJb3jc124nGKV9JRa+ZAKtryyTwN6ldn8TR+90XS9tFIWXBjauyJz
 1nT1Tsc54OElR+l7tm1KgMd9kKICnBcpVgkg+EZ9H6fpKdysmQsQHqvqgCDRKMoJ/vwi
 HVoag9fP6WsB+RcXa1GQuCq1K48oVh2hpm63HDYzQbEKy7DxDgcvP1U57/kAGpoZP4dP
 VreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778326439; x=1778931239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TspkOTMLVcjexYJI7Si0yzTfVtbJRfCnW8JYVQROySE=;
 b=MU0L4Slc622K7MITBqd+Ng+wPLRY3aXPvjgN66vtt/TtLCLExektrYBkjgmAsNQoZ/
 kdwsxSXPtjHiGfCuzDiqN7SGmRHgTBt5kNwRkkY3N9WdcikZgtqWpr1z5MO7vgwKdQdJ
 ZA8QWF54FotGx3cHnoZcxuL7qv2lsv8wTFU83iMGK3n4gp1bucq4jeXM5gGAvtn6HMTW
 PiUwEjXRglCKKyQVtSOuqPfUWgRofX+edNApAYf78OdZhfhG+pMrKIBWm9GQT/6VROuU
 l043D0bm9//808MKzqFn3cZ/ffzvmnzdkDQ86UuvUEUIiG5pJYqM+ER32jNoY5nDWRCY
 ly8g==
X-Gm-Message-State: AOJu0Yy5wPaS/71d1vnGA8VuTQWwChAw7XBEv3NxLJIGznOmyKVTq9uq
 Q8/yIJZp9t4CKQS5wCwJd0d/ZoBw1qElVld64TQz/vxYa6j8NF9aMkN/W/KUAKjOqWrp8xV22Ke
 XVml0oyE7E0LyL69wWo5+waoVN2OAVL4=
X-Gm-Gg: Acq92OFCAFOECtXtwXnmEvtv+ivnSETRGasa4uEvOWwOYG2mVq8R/7i/YHMu8S8XWQo
 VzcxQX46WoKH0hStZlzRK87Ifz13GfBYp6IF2g0kkPXG2dYMLxiMihHx7QGsPibr75uQUSFbobY
 ISWjghN31tRWxyTb0nMVSLK03bAraWKZt+semWNyRjYE1QYNhE/fBh8pTuItKZhDsjZUMWI6QzR
 lzT5EXpQ2s/BKLyRQM/AoJNm3t3zgJP4vnxtg2YkNDN76J+NMQWInnNObTWVF77mWmWkDuMJK8S
 E4Aj0IgjMWQZeezhjix8zp+KDlqcOLUewXv81g==
X-Received: by 2002:a05:6402:29a:b0:674:b355:555e with SMTP id
 4fb4d7f45d1cf-67d643bfa26mr5923679a12.17.1778326438985; Sat, 09 May 2026
 04:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260507160518.444797-1-richard.henderson@linaro.org>
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 9 May 2026 07:33:46 -0400
X-Gm-Features: AVHnY4JsQRUITEIjtXgbcrzvdu7zgFaG1XJF1L3fn0i2whPXXK3-o9HpbZnDJos
Message-ID: <CAJSP0QXZuyd873QuCTp1gK2Xr+rmjgW-P80XuHE=eCascA88-A@mail.gmail.com>
Subject: Re: [PULL 00/29] fpu patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 7, 2026 at 12:10=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f=
83:
>
>   Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu in=
to staging (2026-05-06 10:45:02 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-fpu-20260507
>
> for you to fetch changes up to 901650041334aa9764ee65b300601d0bfad752a2:
>
>   host-utils: Introduce signed saturation primitives (2026-05-07 10:22:25=
 -0500)
>
> ----------------------------------------------------------------
> fpu: Cleanups and export FloatParts{64,128} internals,
>      so far with a limited number of primitives.
> host-utils: Introduce signed saturation primitives

Hi Richard,
This pull request breaks hexagon-linux-user:
https://gitlab.com/qemu-project/qemu/-/jobs/14285779514#L2556

Please resend this pull request once there is a fix. Thanks!

Stefan

>
> ----------------------------------------------------------------
> Richard Henderson (29):
>       fpu: Inline float8_e4m3_pack_raw to single caller
>       fpu: Inline float8_e5m2_pack_raw into single caller
>       fpu: Inline float16_pack_raw into callers
>       fpu: Inline bfloat16_pack_raw into callers
>       fpu: Inline float32_pack_raw into callers
>       fpu: Inline float64_pack_raw into callers
>       fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
>       fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
>       fpu: Split FloatParts{64,128} to softfloat-parts.h
>       fpu: Export FloatFmt structures
>       fpu: Export unpack_canonical and round_pack_canonical routines
>       fpu: Return struct from parts{64,128}_default_nan
>       fpu: Return struct from parts{64,128}_silence_nan
>       fpu: Return struct from parts{64,128}_return_nan
>       fpu: Sink exp_bias adjustment in float64r32_pack_raw
>       fpu: Return struct from parts{64,128}_pick_nan
>       fpu: Return struct from parts{64,128}_div
>       fpu: Return struct from parts{64,128}_round_to_int
>       fpu: Export default_nan, pick_nan, return_nan routines
>       fpu: Introduce parts64_round_to_fmt
>       fpu: Return struct from parts{64,128}_pick_nan_muladd
>       fpu: Introduce record_denormals_used
>       fpu: Split scalbn from partsN(muladd_scalbn)
>       fpu: Export parts{64,128}_compare
>       fpu: Return struct from parts{64,128}_mul
>       fpu: Return struct from parts{64,128}_addsub
>       fpu: Return struct from parts{64,128}_scalbn
>       fpu: Drop QEMU_FLATTEN from muladd routines
>       host-utils: Introduce signed saturation primitives
>
>  include/fpu/softfloat-parts.h  | 220 ++++++++++++++++++
>  include/qemu/host-utils.h      |  60 +++++
>  accel/tcg/tcg-runtime-gvec.c   |  20 +-
>  fpu/softfloat.c                | 507 ++++++++++++++++-------------------=
------
>  fpu/softfloat-parts.c.inc      | 282 +++++++++++------------
>  fpu/softfloat-specialize.c.inc |  42 ++--
>  6 files changed, 640 insertions(+), 491 deletions(-)
>  create mode 100644 include/fpu/softfloat-parts.h
>

