Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC19CC6B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 04:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHDMX-0001Ib-Ql; Thu, 15 Oct 2026 00:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHDMR-0001IC-Pa
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 00:46:36 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHDMP-0006Ky-Td
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 00:46:35 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so6383544a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792039591; cv=none;
 d=google.com; s=arc-20260327;
 b=VSPhOAAJJ5BmzxFC6Rrge8gsc1SyerY+nfa11tIhE63TMooUEPW5yOkC4Fx7Myl88w
 TolylehNUuv/daCb3VA00gw7wy6398fBZPAk/OBXXmXKuY9jaJ6rD0lZ8TRc4PbHz0ed
 Dvk+npokREvIR9nvrEZhWOmZH2LDedgqaUGSIoqLvPFUIGXJAwzorJKEfXy6vqxS0MgJ
 SxFOrmPp5vpC1z5ptQua8EmS26LHcHqTOf92uAKkXepvWe8Ko2zxib2R9ymJB1zz8C11
 Wh9hotfcJS/mnbdZItR85DfDDvc0M6uIToJ/BsgsTfHtNK7cLke77g6xRvG+w5QYmN2G
 5VDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=DBwK/+5VPtWCsMbvR7PTtrdh3x6CtSU19LZlGHB9m0M=;
 fh=R/FkOxLQcYAWNx7fV9TtCSKHvRZPrTqcMG2XCDizEek=;
 b=hV4tcs+PnKhXth/qdacfdl7lcpzj846MwTPadbkQPV0W2Qo0uPeMgdBBxcGvIYEojd
 z6Fvho+ytLTA2vZrebzO8eEFnoWSELI++sn16ppzQtociQiK3/BcgsXX7RbG+T+ts8Nq
 c4j77YH+/LtQif6CH7JIsgbYgXpexFm/dpC4KNNOCRVb6juYvF74qWEXiXR4cTRoA1YH
 p9fr7ut1SSWWF7W2SLcO2/+43KZ4q9bB2TT1P+JULnPVwOnludaGd2odUHYEMk6SK8lJ
 hiLLlJGhf4zE6U6Pga8Xf82/bZJ8sMN9BFRsgwnoQyThk2B+bc+FJLmLFFGKVO/G4n6H
 fWiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792039591; x=1792644391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DBwK/+5VPtWCsMbvR7PTtrdh3x6CtSU19LZlGHB9m0M=;
 b=BcgbY+VTKnBxYnxdMkSQn2WnqxVwnKVjnFuZb1BuLp5/ZDhI0PLHCV9FYRObo0dnD5
 TNxjWbFHNzeON8BXRXV/+Oc2sOvjlsJ8cTD8Jnne0S8gNeE57gVZK0F4Co7cxdDjHaOA
 1IxzBfv58V7Rm4al+56ovw9Awv6GHXKmgsqVroS9ax4fzLsQLDOoneYIMNV8LleR/+2D
 zJSkAvecZ0bwaIPJqRcCGtesrYmN+z4jYkhsSQ/FX4PnKPYLxrBldZPWBfheOaL4k2J9
 ASgQ7lcLBAMVxSEIUKvoT0WBIlaRSjwdn1ffgZkynCwZCFxz/Z4rWcL+GnKi0GT/8+3D
 +3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792039591; x=1792644391;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DBwK/+5VPtWCsMbvR7PTtrdh3x6CtSU19LZlGHB9m0M=;
 b=YyjHXzUGCRw0bGd8O/3NqR3a/fPA5dvm6CMsE5ufTcwWChdCvwlLVEMsFHpC5UgEws
 99xUfDISarkiaW+hQw9/UC0OoP6AYmEyq/lGNm09RhyryazcRjFADYY032bmqDsHeics
 So3/lnBOYNJxI4CnDowybHG31qnIiddRYtJe8BQ0++wWKZvEYM7NAVRwnx3yU54o9oOS
 uEbHe9AcHpU9pi+PgJPLW78/XB2bQquZOYIrtQe+yyW8g+Ts59e8DlqEe8cc9q1Xh7Nc
 ehru/cDS7nNW8RwqEl1z6pVGV7zMo4kp2FZyPW/djUzq9qyktE2W3UfwTlJhf8nwGDlw
 LUag==
X-Gm-Message-State: AFq9FYKEog7O+x7PK3pp5XZYzB1N2x5nU5H9DY7DPRh+icjA1VmNPhSR
 NkqaXFq6PufoXDX3UxwEoa95Ic9l31zRIFW4fQK8qkWWI72jFIwwII3JzjBqANgEn91JCWPwFHo
 Swf1ZTvMZ4Cw3fD5otqcaM98Dv7GSYP8=
X-Gm-Gg: AYBFou1Gw0eU/jSR2V1Z09nJ6nMhDSuaR6yXhmDs973G3Qn/kknUQ8GkIDj755maB/v
 LjdeiR+si/KhZyiGsdaF9P/BNJud5awUwlP+VTEB5Ke/SxAYCPCyG+TksYjURJeNi3xVVKtjjCs
 UifDI6XrRHa4yk3z7PO7JPWiNn17kW3u9ngdRAVET8nLqK7s0GNc9b0Cai+gdhPrJBhTvzNHMKk
 HJauV95Np1ApzNX3gmn5k/Iy20RFEYuN9zef93+JMaKoHrGLrC4ARVA7rXnA+DRDvjrhrTccFqU
 AEWO8o64xLyBEpapqOo8wjF0RbtWmB+0ue3t4FkBUl7M2FBvWlndVJxX+yLJ855K0w==
X-Received: by 2002:a05:6402:3241:b0:6b1:c355:c7aa with SMTP id
 4fb4d7f45d1cf-6b1c355ce43mr6092484a12.0.1792039591321; Wed, 14 Oct 2026
 21:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 15 Oct 2026 12:46:19 +0800
X-Gm-Features: AclHuK9U7w7x1lf-lHJgpb2Aiz-UfN0VmyX3_0f5RF76tZ9_9K_tlT0nOZ-IWaA
Message-ID: <CAE2XoE-4FbrD4FW1YboD3RHZ5NF_X1R9+ProZ21n9RwXXV2Guw@mail.gmail.com>
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
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
Here is my DRAFT patch, you can take a look about this direction, and
change far less code.

https://lore.kernel.org/qemu-devel/20261015044104.879-1-luoyonggang@gmail.c=
om/


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

