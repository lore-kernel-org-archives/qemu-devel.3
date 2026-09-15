Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FBDC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QpA-0005v6-L4; Tue, 15 Sep 2026 06:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6Qp5-0005uo-2B
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:55:36 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6Qp1-0004NA-QT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:55:33 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso2659190a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789469730; cv=none;
 d=google.com; s=arc-20260327;
 b=JtnCBr55tnc9+SPoOIfdbuW5wQOtYAvhEUS50ChktrHxPkMKER4Xfua+BrLNb8jWmb
 PTluyLCFPHYnrx/tKcFVDAeMYwvi3MeXbu0RPqMj12viIAnONWScIYP85FDhKEd+X/sU
 rcMjWApzm1G8MRIFIjD8YRSucjLubViPcrHoBPj36B+awgIXrOGAXZ6n4PSf19ULs/TZ
 /x90F5plU3ehMLsKpL1qZPWJ2MWIajYmqb68m5oIYNSg8YyuQop6T1kVyNj7nkxFqZ46
 CxmeCvmCunPpI3XjwP3F7PxeeX0g3zHlp5WQuh+MJoKxhfpfajasGujcCtGu/8DVb9TA
 uHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K/+ofP68hKgI1p8y+3HOL6VCvVT95ucYUi317lCml1k=;
 fh=Z+ySmzxwjnXFPtiFDbQykDMx5FAFDleKIHYxt/VkwaY=;
 b=NeWOy2QJtbfhUAi5SnG1x6P5sd0CXlBravkmdhi3mdNakJZFW0VS6VT4z3MVXkFW87
 sFsnCN9LaqWGvJ8zvj4iMbdf7D2c1HC11HAysQhTT3DqKZRxfmQL/F442Gm2MTq5rCzB
 1fve+BOIsBk8Rvwj0MW0bdqNOwFL79p+u6VFboFISjn+RlqpYR7eR2OM8iDauHQ3wtDA
 Q+pqpI3hf0mFOkZtDumdX4Z/hO898kUSU0Q0oQ3lI/gEBFLkRJKOuhFRt0M7qcMzdhlx
 4un1OiYQdK6PsB2Vmoro2q55f2V0zECEL4YdjSD8slZK7uW31u3UZnSgzwE80z9V8RnR
 2Ojg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789469730; x=1790074530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K/+ofP68hKgI1p8y+3HOL6VCvVT95ucYUi317lCml1k=;
 b=nLux1gYZ+MeqqxxjHh6aeF3GAfyxMAEN1ebeILgMeD2YISq1wmpJkXy27lA8uvR7hv
 emYSus6N2fmb7HrO997AslaK2xKhja+5GNVH2a8wSUq4tiZJv41dYS8zR9oQDMpVv+lJ
 kpB6xaNJ4RML7zufONQhmtD1itPRfg3Aa4xXHnq7YsTDCtdGUJEtx9gN6RKuL0grMiMd
 a31EtoGpQyl6AkNrnhSeHBFC7JBblTp3g46C/6d9GBVAsy5Rhvl2YOqZ4jf3NNQIqsJt
 XL4LE4CsqBKzHVkHRT+xJeNESt2x2LIrDNWYnYc5YFaaz2Svo0Imo8+dQQ84MIREEO35
 SBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789469730; x=1790074530;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K/+ofP68hKgI1p8y+3HOL6VCvVT95ucYUi317lCml1k=;
 b=VLI/xF6zjs5X1RlF9O1L8h1Ii071kPm4qNleIGITYBjUp0ZBuYGmR2HHVnIJ2BG4gw
 FfuKsQtLieMK6ZnxmuR1xbr+4jLpZSyAxKMW8kQRbsiCp82RRfvZuG8LEl39/UFpP5Rf
 CWlT3oRjkOgkgWml6hbgXIm+YEFxu5CRgYHaIJDdIBYsDhsLnijfBWskqrcyXKYj8ZlT
 aN5yV8t8H5sSxnIB7JOAa9Qxt/NlNIfo6yTr+hS2/PHS5EJNvgp2zazsMZIv2PEfu0aH
 qsKFzgXkYm7C6VbnhnGeIdu7cPoaX7ML+eFh/OlaV4KUyOD7I3SM6O+48ZhhcyPCxb4C
 itPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSa9EU8BFclbfJlXLXucb+93YWdEmqfN7xbz96keQT33zyQfczQd5D8O2j9MFHCVhZmlyOS2fT6fDU@nongnu.org
X-Gm-Message-State: AFuF++lksO/dRdxBIr7LqP0omP1XuPKB0AXmh0gkqLsHnB1Yc+u9Ordm
 PTSJ0uRLu5GcNCxRrMMTSeL7aAHe0nTc0rMh5pbzg8LVpW7vlfOuvq0JtglOIptEUnOEVq+fBW+
 xNUdtE4Fb69SbqjzcO01S+2NVai+pLPk=
X-Gm-Gg: AYBFou0fqu6l64HLjQfkZGFJQjIv+RLrUKduCs9uS6WdTlIY0SBu0lO4e2cGFjQqQWv
 tuUiRUEXedDbFQZ9iGQwSPu8ck0CzeV1UY0z/tAKyFXKiL+IdsoI2FNuZXt9U/32cLnzljjXnYQ
 mpFGrKWqV3MD0dlTE8V5+pO09dvjWQrXF4SPrh2iHfBeWYlXB1c7fpmX6EstUJXUMUyRbjN4Ck0
 KuPitfC/ox2bBadqLToFdSVjQ8HNiyG4agvUqj6HmPRSzPwrvudmABHDQiLUBYGSuDPIorYg4Sk
 BvlYJB1uU4K3KsrB3ZE3T5uKWWckrySXM4vBcdLVBq4T4d1sTOsHkVdu7jd1cPdQV7L0zg1eTPs
 /FAVYpa8oTp8u9pdhdaI3tg==
X-Received: by 2002:a17:90a:1189:b0:39d:f064:3a76 with SMTP id
 98e67ed59e1d1-39df06469efmr6888621a91.15.1789469730301; Tue, 15 Sep 2026
 03:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260915075312.50612-1-guobin@linux.alibaba.com>
In-Reply-To: <20260915075312.50612-1-guobin@linux.alibaba.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Sep 2026 14:55:18 +0400
X-Gm-Features: AcwNN1XlMceQWJae-0Ifco1rt8AEYr0hotA7Ua80X9SOSNjtXJajSQ2c-G4M7Zo
Message-ID: <CAJ+F1CLAMXxCtjpb-bLXKDGUUe=RZ0DK2XFwu0xibpKkhockPQ@mail.gmail.com>
Subject: Re: [PATCH] monitor/hmp: detect signed integer overflow in expression
 evaluator
To: Bin Guo <guobin@linux.alibaba.com>
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj2-x10.google.com
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

Hi

On Tue, Sep 15, 2026 at 11:54=E2=80=AFAM Bin Guo <guobin@linux.alibaba.com>=
 wrote:
>
> The HMP expression evaluator performed *, +, - and unary - on int64_t
> values without checking for overflow.  A malformed expression such as
> "0x7fffffffffffffff + 1" would silently wrap around to INT64_MIN and
> could then be passed as a physical address to the "xp" command.
>
> Use the checked-arithmetic helpers from host-utils.h:
> - smul64_overflow() for "*"
> - sadd64_overflow()/ssub64_overflow() for "+"/"-"
> - ssub64_overflow(0, n) for unary "-"
> - an explicit check for INT64_MIN / -1 and INT64_MIN % -1
>
> Also check the "M" (MiB) suffix multiplier used by commands such as
> "balloon".
>
> Overflow now raises an "integer overflow" error via expr_error() or
> monitor_hmp_printf()/goto fail instead of propagating a wrapped value.
>
> Add a qtest that verifies the evaluator reports "integer overflow" for
> the classic overflow cases and still accepts non-overflowing values.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4463
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  monitor/hmp.c                        | 26 +++++++--
>  tests/qtest/hmp-expr-overflow-test.c | 81 ++++++++++++++++++++++++++++
>  tests/qtest/meson.build              |  1 +
>  3 files changed, 103 insertions(+), 5 deletions(-)
>  create mode 100644 tests/qtest/hmp-expr-overflow-test.c
>
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 488ec23937..e6be921770 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -35,6 +35,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/ctype.h"
>  #include "qemu/cutils.h"
> +#include "qemu/host-utils.h"
>  #include "qemu/log.h"
>  #include "qemu/option.h"
>  #include "qemu/base-arch-defs.h"
> @@ -480,7 +481,10 @@ static int64_t expr_unary(MonitorHMP *mon)
>          break;
>      case '-':
>          next();
> -        n =3D -expr_unary(mon);
> +        n =3D expr_unary(mon);
> +        if (ssub64_overflow(0, n, &n)) {
> +            expr_error(mon, "integer overflow");
> +        }
>          break;
>      case '~':
>          next();
> @@ -571,13 +575,18 @@ static int64_t expr_prod(MonitorHMP *mon)
>          switch (op) {
>          default:
>          case '*':
> -            val *=3D val2;
> +            if (smul64_overflow(val, val2, &val)) {
> +                expr_error(mon, "integer overflow");
> +            }
>              break;
>          case '/':
>          case '%':
>              if (val2 =3D=3D 0) {
>                  expr_error(mon, "division by zero");
>              }
> +            if (val =3D=3D INT64_MIN && val2 =3D=3D -1) {
> +                expr_error(mon, "integer overflow");
> +            }
>              if (op =3D=3D '/') {
>                  val /=3D val2;
>              } else {
> @@ -632,9 +641,13 @@ static int64_t expr_sum(MonitorHMP *mon)
>          next();
>          val2 =3D expr_logic(mon);
>          if (op =3D=3D '+') {
> -            val +=3D val2;
> +            if (sadd64_overflow(val, val2, &val)) {
> +                expr_error(mon, "integer overflow");
> +            }
>          } else {
> -            val -=3D val2;
> +            if (ssub64_overflow(val, val2, &val)) {
> +                expr_error(mon, "integer overflow");
> +            }
>          }
>      }
>      return val;
> @@ -1028,7 +1041,10 @@ static QDict *monitor_parse_arguments(MonitorHMP *=
mon,
>                          monitor_hmp_printf(mon, "enter a positive value\=
n");
>                          goto fail;
>                      }
> -                    val *=3D MiB;
> +                    if (smul64_overflow(val, MiB, &val)) {
> +                        monitor_hmp_printf(mon, "integer overflow\n");
> +                        goto fail;
> +                    }
>                  }
>                  qdict_put_int(qdict, key, val);
>              }
> diff --git a/tests/qtest/hmp-expr-overflow-test.c b/tests/qtest/hmp-expr-=
overflow-test.c
> new file mode 100644
> index 0000000000..29ef880993
> --- /dev/null
> +++ b/tests/qtest/hmp-expr-overflow-test.c
> @@ -0,0 +1,81 @@
> +/*
> + * QTest regression test for HMP expression evaluator overflow.
> + *
> + * Copyright (c) 2026 Bin Guo
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +static void assert_overflow_response(QTestState *qts, const char *cmd)
> +{
> +    g_autofree char *resp =3D qtest_hmp(qts, "%s", cmd);
> +
> +    g_assert(strstr(resp, "integer overflow") !=3D NULL);
> +}
> +
> +static void assert_ok_response(QTestState *qts, const char *cmd)
> +{
> +    g_autofree char *resp =3D qtest_hmp(qts, "%s", cmd);
> +
> +    g_assert(strstr(resp, "integer overflow") =3D=3D NULL);
> +    g_assert(strstr(resp, "error") =3D=3D NULL);
> +}
> +
> +static void test_expr_overflow(void)
> +{
> +    QTestState *qts =3D qtest_init("-M none -m 2");
> +
> +    /* Addition overflow */
> +    assert_overflow_response(qts, "print 0x7fffffffffffffff + 1");
> +
> +    /* Subtraction overflow */
> +    assert_overflow_response(qts, "print -0x8000000000000000 - 1");

That's actually testing unary overflow of -0x8000000000000000

Bypass it with ~0x7fffffffffffffff (INT64_MIN) ?

> +
> +    /* Multiplication overflow */
> +    assert_overflow_response(qts, "print 0x4000000000000000 * 2");
> +
> +    /* Unary negation of INT64_MIN */
> +    assert_overflow_response(qts, "print -0x8000000000000000");
> +
> +    /* Division overflow */
> +    assert_overflow_response(qts, "print -0x8000000000000000 / -1");
> +    assert_overflow_response(qts, "print -0x8000000000000000 % -1");
> +
> +    /* Sanity: non-overflowing expressions still work */
> +    assert_ok_response(qts, "print 1 + 1");
> +    assert_ok_response(qts, "print 0x7fffffffffffffff");
> +    assert_ok_response(qts, "print -0x7fffffffffffffff");
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_balloon_m_overflow(void)
> +{
> +    QTestState *qts;
> +
> +    /* q35 is x86-only; skip this test on other architectures. */
> +    if (!qtest_has_machine("q35")) {

        g_test_skip("Machine 'q35' is not available");

> +        return;
> +    }
> +
> +    /* Balloon command takes an 'M' suffix size argument in MB. */
> +    qts =3D qtest_init("-M q35 -m 128 -device virtio-balloon-pci");
> +
> +    /* 0x7fffffffffffffff is positive as int64_t, but * MiB overflows. *=
/
> +    assert_overflow_response(qts, "balloon 0x7fffffffffffffff");
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("hmp/expr-overflow", test_expr_overflow);
> +    qtest_add_func("hmp/balloon-m-overflow", test_balloon_m_overflow);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c3593f7530..89172ac45b 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -30,6 +30,7 @@ qtests_generic =3D [
>  if have_hmp
>    qtests_generic +=3D [
>      'test-hmp',
> +    'hmp-expr-overflow-test',
>    ]
>  endif
>  qtests_generic +=3D [
> --
> 2.50.1 (Apple Git-155)
>
>

otherwise, lgtm

--=20
Marc-Andr=C3=A9 Lureau

