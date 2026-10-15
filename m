Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB91CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 02:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHB5V-0003nW-UP; Wed, 14 Oct 2026 22:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHB5M-0003n7-Ev
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 22:20:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHB5K-0001ys-OK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 22:20:48 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso2021495a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792030845; cv=none;
 d=google.com; s=arc-20260327;
 b=Y8rtSBNUkLzH4ZhoMSI9H5KpfFnmXU3OU0f0tfTHCjt9sAQXcqZfsDrz241U7nfvMp
 HDF9jUTvYYW+vaJcVknvAVuX5Qfx/cvqC0cKEFaYNRSSoql6APFRBQVCo19lmBQi0ROg
 0qeMexIXIBY7Eirl3PTUn9lYFJexnya5qY38NKmda7F2kghKYEZjgqvPtQn0cRVtGc7u
 rTyKwE97L4riZknR2iev5doksWa3RS3Y1fHCiH4fe+FUB6j8b8UDSQTny6b6mb7lNksr
 84nQiOPwkVd8O/I6emOkQ3BGoPs8atDHfjmEll19XZZ+4g2CxWP1eQHKfx/tyUjGznzX
 ueyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=deS2aYk9oIq5uLGjkT/iXQ1Eu1YpVc4ifoWy5WyS89g=;
 fh=R/FkOxLQcYAWNx7fV9TtCSKHvRZPrTqcMG2XCDizEek=;
 b=Tmo84/ocBJPYeCxo7dMiyTcEfJbM5wrtXY7qeGn8ynEH2+IrVwFEYHwQbNm28n4mJX
 ZM/0HDSTG7LJCaME7FNBD3vJ7/EFuEVG37NkBKXooeneCln5O/QI3GvjOeQ6X4biFpcN
 PRmFDoLvZiQTuYtlxJ/u9/85e0MsDzSnr7Aby68zlTIPVFBugY/SjCqRpEw+zWzA4KCA
 X6VfjWlZgL4f2pGB8KSToSUQcKC1M0jN9ZwCHKJo9JmN6qw1TWMBG0ImITNC6JqiDly0
 vrYrvac6jxOrJXrmUHQQdsz1WdFFHOEDYVhDAVgIPYfighQ5d13VnPBQgQ+8djGwJ4hu
 NWTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792030845; x=1792635645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=deS2aYk9oIq5uLGjkT/iXQ1Eu1YpVc4ifoWy5WyS89g=;
 b=MkHDX+YxddhS44wL+NPon/SdahdWbHX4F22CY2qTEgVQg4y5qU6bThmq0+0vd6yoov
 BAEk66JmEU7Odwuc5ABDCvTwApgtP81A5eDjD46G6MbLA5SnrzRESnr8DlhxUJ+sRPC2
 nQFyvNVy4K45FcUxeaa878zAUPe4Ojp3TQvK1QwERJvsHsYNwIQ0ZtklZa4h7KNLCDyB
 kwC07tI9psg6F3zRrrlELRx9ztOwq/Bk/1RYmWZokXeYP1YafPqwoUcXRpQZOkEu1OIg
 uwfIjUhJ3oiSlyn21s4SP+TaGC8Qxa/xlHppkw1h8K7owoihVTJ8PuA8qaBc4f1rgznE
 s3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792030845; x=1792635645;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=deS2aYk9oIq5uLGjkT/iXQ1Eu1YpVc4ifoWy5WyS89g=;
 b=CwzYsYjVYmmBEnw4lHGu5WNaHs37mMjpswe6wilZrXohfTk3YLFXEBVyTwrOyI+aOV
 9K4MyYWRPfZH/QZxHy6UEWhf4KgRYMzC+tB0hN7sj5KgR4NgsUyCxNyt8E5UZ2tE99Wn
 N+099kxMnq0EQKChKE6hsWzlbbn4/nYH3gMcx0LFYrsb3Vfp6erQTkQne5ZX+GzpgwlC
 CdAiLdJiAELObmx11aQIXJcDvAEvy129Glkz/GWxagJato0nAfIF/79B9E09d8C3eSos
 v92Ua5UZU4d9g+L8b+n2XCWVfVJYJikbwUclXwldgC8/kRCw9otWiGrEaXNDPYk4n8yy
 Akfw==
X-Gm-Message-State: AFq9FYLkrfyr6C48Ug/+MEW7NQBXMcBNsrYvui0w4Hhc0pzyNCsxFv/Z
 0JRXV9jf7VIbWJdZm/sX3776x562BAq85GUs/kI5ARY5axIH6S/YNipvE5eLoPACuCvX1DKNzdF
 ETY+yf1HFiwoAOQ/vT7uPfTiZ8QO0zwo=
X-Gm-Gg: AYBFou11pj4XG7kkLiw51YaXsKn8FNK9ulZGXMUYCjeFWI5ttPjfKCGNkxRuzt9V07S
 EvIBMhun6S/6RT8LXcZgGs2R7JomMrY63hHTWQsRJE4Fwvn1cppmUPsGqpCAzfsDD8dOGIKE1tK
 NONHlqN3PCLtB+iaPXKf76GDPtZNL0LQWbiV/bOXGrX0ocVH7PkVybDAbcNp8lUYYXs0b7P/Ju3
 Js9L75YnqtJCB8Yb8/Jq04h/ASZR9y6oDPriWuqrNILMNFXc63vwKLUHFh1t7l0L0r/0qpzgqlV
 htrW6gAn23uQroE0uDXKGlZgwCFE8B5ziUEWLhQNZ4pE1kOg75G/Ar0=
X-Received: by 2002:a05:6402:1ed1:b0:6b1:ef9d:9d72 with SMTP id
 4fb4d7f45d1cf-6b1ef9d9fe1mr5215262a12.30.1792030844432; Wed, 14 Oct 2026
 19:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 15 Oct 2026 10:20:30 +0800
X-Gm-Features: AclHuK8mgRFMJA30B4xmLDwnX0TG40wvkAoeNOBIXhD1alqUPD2jZfF3YHIae1Q
Message-ID: <CAE2XoE8b1rLGwtprL_qgqNPjMJruEg28hkauvthpaD2sLDAYBQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x532.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 15, 2026 at 8:55=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> This series allows to link multiple targets that define
> qmp_query_cpu_definitions. It simply replaces the duplicated definitions =
with
> target-specific ones and a single dispatcher. We didn't use yet the dispa=
tcher
> pattern, and it's the first situation where it appears to be a good fit.
>
> A possible alternative would be to introduce this callback directly at
> target-info level, which I think is a less desirable solution, since it w=
ould
> ties this API to monitor.
I tried this way and it is much better I think.

>
> If the approach here is accepted, I'll extend this series with
> qmp_query_cpu_model_expansion which follows the same pattern.
> With this, we'll be free to link together almost all the base architectur=
es.
>
> Pierrick Bouvier (8):
>   target/arm: rename qmp_query_cpu_definitions to
>     qmp_query_arm_cpu_definitions
>   target/i386: rename qmp_query_cpu_definitions to
>     qmp_query_i386_cpu_definitions
>   target/loongarch: rename to qmp_query_loongarch_cpu_definitions
>   target/mips: rename qmp_query_cpu_definitions to
>     qmp_query_mips_cpu_definitions
>   target/ppc: rename qmp_query_cpu_definitions to
>     qmp_query_ppc_cpu_definitions
>   target/riscv: rename to qmp_query_cpu_definitions to
>     qmp_query_riscv_cpu_definitions
>   target/s390x: rename qmp_query_cpu_definitions to
>     qmp_query_s390x_cpu_definitions
>   qmp: reimplement qmp_query_cpu_definitions as a dispatcher function
>
>  hw/core/machine-qmp-cmds.c            | 32 +++++++++++++++++++++++++++
>  include/system/qmp-cpu.h              | 20 +++++++++++++++++
>  stubs/meson.build                     |  6 +++++
>  stubs/qmp-cpu-arm.c                   |  9 ++++++++
>  stubs/qmp-cpu-i386.c                  |  9 ++++++++
>  stubs/qmp-cpu-loongarch.c             |  9 ++++++++
>  stubs/qmp-cpu-mips.c                  |  9 ++++++++
>  stubs/qmp-cpu-ppc.c                   |  9 ++++++++
>  stubs/qmp-cpu-riscv.c                 |  9 ++++++++
>  stubs/qmp-cpu-s390x.c                 |  6 +++++
>  stubs/qmp-cpu.c                       |  7 ------
Introduce this callback directly at target-info level wil avoid these
stubs/qmp-*, basically we indeed can remove more stubs. maybe
qmp-cpu.c be removed.

>  target/arm/arm-qmp-cmds.c             |  3 ++-
>  target/i386/cpu.c                     |  3 ++-
>  target/loongarch/loongarch-qmp-cmds.c |  3 ++-
>  target/mips/system/mips-qmp-cmds.c    |  3 ++-
>  target/ppc/ppc-qmp-cmds.c             |  3 ++-
>  target/riscv/riscv-qmp-cmds.c         |  3 ++-
>  target/s390x/cpu_models_system.c      |  3 ++-
>  18 files changed, 132 insertions(+), 14 deletions(-)
>  create mode 100644 include/system/qmp-cpu.h
>  create mode 100644 stubs/qmp-cpu-arm.c
>  create mode 100644 stubs/qmp-cpu-i386.c
>  create mode 100644 stubs/qmp-cpu-loongarch.c
>  create mode 100644 stubs/qmp-cpu-mips.c
>  create mode 100644 stubs/qmp-cpu-ppc.c
>  create mode 100644 stubs/qmp-cpu-riscv.c
>
> --
> 2.43.0
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

