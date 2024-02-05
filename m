Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68378C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 06:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWsJA-0001Xy-2f; Mon, 05 Feb 2024 01:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWsJ8-0001XV-SY; Mon, 05 Feb 2024 01:18:18 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWsJ5-00069s-Ti; Mon, 05 Feb 2024 01:18:18 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4b7fc7642fcso1579425e0c.0; 
 Sun, 04 Feb 2024 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707113893; x=1707718693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6NwFlfX0gCQcX8gf5Q9RoH9n8s+ep1NhbitaQ9h5Ho=;
 b=C3cogm49MJJE0BYPI0ZQAXzDOsHnY0CNeO5XfeDhvslkNaCpBrqsKGidw15iUBWXuS
 rgyymR9xi5rwIJJpkc0rSTjjDVeg1pJuZIuK9pJ32SNevSPtpcUGxaUrv7zkF0p3nKmG
 kSHd2A6QyYcLzNJdz5hrb4pGawLiTcUoJ3TGtpvDSbZDW+V9V5iLrWTEW0xxvWfHmjuh
 NXHqlp+z1stMKEBR/5Q2kZxDjEHjqLr4q4sTZatluaY6PchrwoXf3n53esmnJy+zU+F2
 xRMt4DEBCizfq+pfSEg64ty9nRaMnzvugX4X7aXnGLa8QCJ0BHzkVaxGpxzFIODLn0aX
 ykdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707113893; x=1707718693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6NwFlfX0gCQcX8gf5Q9RoH9n8s+ep1NhbitaQ9h5Ho=;
 b=MjeYHWkAHWG7/lKT8ySMY08XLE5XDY6xYm7fZd7j3TzeV5cDuYbsEKrK3u48iFRbx7
 eVRJsUzcpOuNJ/x4eNNGDRQ6M+kMjx1cfvaBdFRgcLvN4pN6/DTrFMKKtT4uYLrDAFpa
 i8hjsmQvYA5aCUeai5dnMFdXFnlrlWIeYlWiOu+ViH5O8Uf5LcBMbarLD0bC5ab+N/PB
 PfG0tcEd83tiA2HHR8KpnNONt58DTkMHCopyMLvrE66qk9UPzqK+vd7ko/g1jbDdAV4A
 WnT0PUJ3ySVsZ/ZGLtsnLahS+dtWgzIJYOjl6/45BIOkEPVFnQWk2wyyujB1tuGXRRy9
 dWzA==
X-Gm-Message-State: AOJu0YxDVqB/mM/fWf9RfmX8E2JRBnjFuqePhkUU9cPL34G0/wXf+hYE
 83gv8aCLf2m2yLwm57chhky0OcGA3Jjn3jE5ZrpAZNEG4gsIFtYkYnxVsTxtaB9AnYQzyF7Zde4
 dEJRh6InCiQXtzTS1M6jCv8vTG6w=
X-Google-Smtp-Source: AGHT+IEB11/wuwFnIDJjSsHND56/PEX1szPvq9VTResvdCusdEvvINZKpgr8QEEpuQYAgfljbyeQk//iXcqj8gioR9g=
X-Received: by 2002:a05:6122:201a:b0:4bd:b44c:24c1 with SMTP id
 l26-20020a056122201a00b004bdb44c24c1mr6153992vkd.11.1707113893394; Sun, 04
 Feb 2024 22:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20240204055228.900-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240204055228.900-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 16:17:47 +1000
Message-ID: <CAKmqyKMAWSTwbqNrLxH+jfWcxLUXM1XA_Verg+=uRpCdQxzPnA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Enable xtheadsync under user mode
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 qemu-riscv@nongnu.org, christoph.muellner@vrull.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Feb 4, 2024 at 3:53=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> According to xtheadsync[1][2] documentation, it can be used in user mode =
and
> the behavior is same with other priviledges.
>
> [1]:https://github.com/T-head-Semi/thead-extension-spec/blob/master/xthea=
dsync/sync.adoc
> [2]:https://github.com/T-head-Semi/thead-extension-spec/blob/master/xthea=
dsync/sync_i.adoc
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_xthead.c.inc | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/in=
sn_trans/trans_xthead.c.inc
> index dbb6411239..22488412d4 100644
> --- a/target/riscv/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/insn_trans/trans_xthead.c.inc
> @@ -992,7 +992,6 @@ static bool trans_th_sfence_vmas(DisasContext *ctx, a=
rg_th_sfence_vmas *a)
>  #endif
>  }
>
> -#ifndef CONFIG_USER_ONLY
>  static void gen_th_sync_local(DisasContext *ctx)
>  {
>      /*
> @@ -1003,14 +1002,12 @@ static void gen_th_sync_local(DisasContext *ctx)
>      tcg_gen_exit_tb(NULL, 0);
>      ctx->base.is_jmp =3D DISAS_NORETURN;
>  }
> -#endif
>
>  static bool trans_th_sync(DisasContext *ctx, arg_th_sync *a)
>  {
>      (void) a;
>      REQUIRE_XTHEADSYNC(ctx);
>
> -#ifndef CONFIG_USER_ONLY
>      REQUIRE_PRIV_MSU(ctx);
>
>      /*
> @@ -1019,9 +1016,6 @@ static bool trans_th_sync(DisasContext *ctx, arg_th=
_sync *a)
>      gen_th_sync_local(ctx);
>
>      return true;
> -#else
> -    return false;
> -#endif
>  }
>
>  static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
> @@ -1029,7 +1023,6 @@ static bool trans_th_sync_i(DisasContext *ctx, arg_=
th_sync_i *a)
>      (void) a;
>      REQUIRE_XTHEADSYNC(ctx);
>
> -#ifndef CONFIG_USER_ONLY
>      REQUIRE_PRIV_MSU(ctx);
>
>      /*
> @@ -1038,9 +1031,6 @@ static bool trans_th_sync_i(DisasContext *ctx, arg_=
th_sync_i *a)
>      gen_th_sync_local(ctx);
>
>      return true;
> -#else
> -    return false;
> -#endif
>  }
>
>  static bool trans_th_sync_is(DisasContext *ctx, arg_th_sync_is *a)
> --
> 2.25.1
>
>

