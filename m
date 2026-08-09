Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C2EC5AD2C
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wt39C-0008IN-ST; Sun, 09 Aug 2026 09:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wt39B-0008I1-PN
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 09:01:01 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wt399-0007MM-SG
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 09:01:01 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so1405829a12.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 06:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786280458; cv=none;
 d=google.com; s=arc-20260327;
 b=FIxsEy3v06fCffYEEHhhjT6k7GJKjxdydjfgupl8VraD2MDv/SvfOOLPd/EElA6/Cr
 zlTvVu6V8cx7kdKD1GWGbOJDQH60XOVHHXnrxuEoeIfjybdp7KD5AjjuwTuBNrN5rHKf
 GvyFWR+3t76Ig4T0lNSmO/8RK/xz/diAdEJ8Zxv8+OmAE0yqw9c0VFFG/HDqLPNPUzXE
 L5N0AWTfCOT8FB93odCHJnNkfHedlGFQ6hS4k0WCXRAP8kQoSRr3yw6A2VTU3Vp6vP9R
 ZOV+hGksKX1rLEQInvXwU3hogwTeOL1fFbm3ZGu3jMM3aDU3KxkgeqLxK+I1oa5rRELn
 B9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=45mew2HuUdncZmNfXTFUicxGBTSLJoQH5g+NlDDJY3k=;
 fh=MRZUNMWuv1kFuqQ9+hXt1nBjxFVEdkK9q0n91tRksII=;
 b=gzouyeP2ZGypcZ3SJeMdX8K3HyvV+BQa2VV3tyo+Y2XhwI+TowRXfuoSWX9OY2mjgL
 U52FiYgDqbwdrw4JoAxG6YlcSsaCuszTr30Ssk/51haKJI8DJ5VMwSXEj0sXbHzDhdQW
 d7BTHloNY88grOu10DAuV8CItmTEPae8aN9giGWjcf9PYmJ2Q/QkX0/3sd+wuw9C+pNo
 gf07vaaKzfPWoyb4q2tV2On10hWQ2ycoTGe3zxrRbSIBhg9nHBTTPRaoBcX0O7537qF4
 7CcKxG6PdqbI7Yobloe9RIlGVDdtceeOXPsqzp7aVVgLaZ6ZALFBpSDXKl7M/z8DI5Zz
 7mkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786280458; x=1786885258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=45mew2HuUdncZmNfXTFUicxGBTSLJoQH5g+NlDDJY3k=;
 b=fO//B1gjcKwMlCP1iK0WFWCb0eLLq4BIrsX6MmmRxVIH/IG+3cDXBUiODNXCxAibmo
 Y1bFToBrH+4WOouiznsDoSmRtHE+2ymhI4aKm4l0H3m4h6iUmGbtnB3/PLYp9/0ay7no
 pUICZHdmIMWIJcQbRId47ZsPu3dmmjRngvW9kWUXVAqcAQJ4BeJeKkOsjz5wecnkg4Qn
 CXpLVfdYx1M8sEDUk2usa8osFERknk+lU4T6mPPzySTlxonXjjMKDi+Neq+PT2ZmBQ7D
 VIKKhq+YzCO9g8uSXnbXmwFy0V6Im8enb9U5tJor8RRaMNn3wzUNHZ4S3IXZarBRmseK
 SxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786280458; x=1786885258;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=45mew2HuUdncZmNfXTFUicxGBTSLJoQH5g+NlDDJY3k=;
 b=MuQS8f7G3JKA6ddMqtCz4EBX2hQccGCWRmimyWF3Y6ms7LMATloWBS8qHVConfwBEH
 kpMzrJba7FbOPfkFG1isUcQbvu0Ryb5s65oRZzt+LLkT2fzCse3HIEa1U7MJ0mvjHv+k
 hGiAUR+UzpMFe1I1Ha3SbP7e0HDLQjwjP5PwLejRy3vKcqcAW6lFvz3aHmJi0sqIqqG9
 DpVU6IgECh16J0YgYLIm8pjkBJ4otZ9P5SWVnZSGJV0elYbTgFOTGBZyE4+A/nMT+HKv
 WdsWu8HzHArIdXcJ5QOrcVR7gsSVK34NWngkzgYfz7+yHFoXjHd8vYD8XBoogZDW5soj
 Cdew==
X-Gm-Message-State: AOJu0Yzllu4f/18v2m+fsZQLHgFXyF4qpQP1Sz90+4+2VhJhtWnGjpsJ
 onbh1FP95cJ1qMKlX2Vzrpe2tJ8EfhKb5rUqVv50+oNl1V9O36w+hhkM9IT2AQNsbxmPA4V3JZp
 vxJ/oUxIydGB5JNv+EhQuX4Qs2e2ZrcY=
X-Gm-Gg: AR+sD13ekdFZyFrcgppSAjGfWKP3ZEik7KIB04tfEDjY7hF3BYS8WwVyWuCgI8OD8y/
 Y/WnI49NnmjxKwEOd/IslBhLVF1/HEql0RYSP0Q1zCKs6wuDxab8UGBNPjEDfhVUxeqFPZnbn5o
 jmzNVdzGr/yBImTMJnxiE9i2JDwxk3dYW0ZsZtVT/iYEurr04WwhQQP0h2bu9u6KIZQlkv367vc
 dyYuzgx/1mepr7erFWDpMq30zpgW8UJhTBrtfPo6At3UkTxNjzRT/fmIBVy4zBZqTXKUQH+J1BX
 fTSQgG+/JJ4sqJdfgVOtmOBQxn3TPfBdEUi035EZJp9BM0SUqzTizvjWFnLY2n5GuwwEoFuvq+t
 vpw==
X-Received: by 2002:a05:6402:42c5:b0:699:12e8:1c54 with SMTP id
 4fb4d7f45d1cf-6a1e5ab69c7mr8186157a12.5.1786280457944; Sun, 09 Aug 2026
 06:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 9 Aug 2026 09:00:44 -0400
X-Gm-Features: AUfX_mxAo0UNkWjhLNOD6cao5Lw6YZ5EYQbS9RMJ2bvnW2uWIJKjs0_uRtoiqWo
Message-ID: <CAJSP0QWud9jnr8vYLwoUYeQnpxK_YSy4K7+RQUgtisMcBq_G7g@mail.gmail.com>
Subject: Re: [PULL 0/3] Hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Thu, Aug 6, 2026 at 5:38=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> The following changes since commit 3e3ccab106f879b1512f8e0d51a827dd4de30e=
22:
>
>   Update version for v11.1.0-rc3 release (2026-08-04 15:36:08 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/qualcomm/qemu tags/hex-20260806-pull-request
>
> for you to fetch changes up to 8f5bf4fa0aa2f5648f016b8265d86d4b05b42307:
>
>   target/hexagon: don't let an idef-parser dest clobber its own source (2=
026-08-06 08:18:51 -0700)
>
> ----------------------------------------------------------------
> hexagon: fix cmpy*(), same-slot packets
>
> Fixes for these two bugs:
> * short-circuited packets with `cmpy(Rs,Rt)` would get the wrong result
> when Rs is the same register as Rt.
> * some packets with slot constraints were incorrectly rejected as having
> an invalid encoding/shuffle.

Hi Brian,
Are these fixes critical for QEMU v11.1.0?

Once -rc3 is reached, only critical fixes are merged so that the
release converges. Critical fixes include regressions since the
previous release, high severity security fixes, and build fixes.

If they are not critical, I will merge them once QEMU v11.1.0 has been
released (it should happen within the next week or two) and the
-stable tree can pick them up.

Thanks,
Stefan

>
> ----------------------------------------------------------------
>
> Brian Cain (3):
>   target/hexagon: accept valid packets rejected by check
>   tests/tcg/hexagon: add slot-assignment tests
>   target/hexagon: don't let an idef-parser dest clobber its own source
>
>  target/hexagon/genptr.h                |  1 +
>  target/hexagon/decode.c                | 30 ++++++++---
>  target/hexagon/genptr.c                | 11 ++++
>  tests/tcg/hexagon/invalid-slots.c      | 72 ++++++++++++++++++++++++++
>  tests/tcg/hexagon/read_write_overlap.c | 47 +++++++++++++++++
>  tests/tcg/hexagon/valid-slots.c        | 62 ++++++++++++++++++++++
>  target/hexagon/gen_tcg_funcs.py        | 15 ++++++
>  target/hexagon/hex_common.py           | 12 +++++
>  tests/tcg/hexagon/Makefile.target      |  1 +
>  9 files changed, 243 insertions(+), 8 deletions(-)
>  create mode 100644 tests/tcg/hexagon/valid-slots.c
>
> --
> 2.34.1
>

