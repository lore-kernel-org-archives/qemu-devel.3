Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F10BC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 06:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWsTi-0004Az-Ft; Mon, 05 Feb 2024 01:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWsTg-0004Ah-7P; Mon, 05 Feb 2024 01:29:12 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWsTd-0007s3-B5; Mon, 05 Feb 2024 01:29:10 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7d2e19120b5so2129811241.2; 
 Sun, 04 Feb 2024 22:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707114548; x=1707719348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9cURzhditccpij/QfM5l6c4qJ6F08oB5hQg0XnwkOQ=;
 b=PoirbDEE0A8Pa8ihGFkhrdBDwwZJ9b004RC3zy/iIo0fpb5pvHmZvN8b3fYZ9ITtog
 4a21mjXzjca9t9L2kmvqyYWJOBxYOoWq/n5xl2lfmLu4JKreqnIMbaSrZxvLYP+B+6e0
 YcCiBrOap8e85zBNgxDbbNSWiTxmI+DpeaJaJ5DYi//x9dFpDvQzzbgrWaheBUrtK8EQ
 f2vs5uCRAUwpvwqu2TN1cQb2oO6LkglOzs2hVoVL/l/54Iu0BwrG9I25c+UmHRZaDYQo
 4EUD4Li1Y7pmD1lNvqavhIO1LzkGSqQMW/D/cngCvUbsp1EQrQVltZ+JN3DrDCbxj8x9
 UdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707114548; x=1707719348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9cURzhditccpij/QfM5l6c4qJ6F08oB5hQg0XnwkOQ=;
 b=foAiWFZeRteUNMmjq1XyQC0tsQ209TsHOKAybd4LBD0KmQ6fXzg4KanpBuZtH3XMMv
 85FE34MnYSv3XDBDbRtFNO2DuvkYVoTFSnxvAp1ZzE+DtJ5cijJNbe5j4rVyf6wEDjJk
 UjKvvChxIIl9oJHEJkBR5Xl+kOSHJTRZYUBvuTpL7KHE3Hu0YLp4kHAiEjcNYktpFLBi
 llvsEjm48M2v/W9W4KjCYIMI4cNidgesSr5/7IzkgcpNMB6ti9/1Vf1AQPyR5gS2scsi
 a3+W0B+DCJY046hOcI1m8RKz67VMZT7VmcxcIJ1dI2U9IBrLdcNZXUKakUNLi8mY5Kk3
 Gwww==
X-Gm-Message-State: AOJu0YygvButkDzv29FXJGZOloz17bGHuHPYQrEi/vxSK4bPxkBUSF1B
 zfnFaRAmE8UUjRsYfRZ4fjhuruqveCzmjjIO+foFW2dXYJjXIIZgjo6Go7OuKQGA3pIx3ZmOtHR
 zDkCFhcS1yPndhmKyVOgO8/zR8cY=
X-Google-Smtp-Source: AGHT+IGWchKcMpBoQ/gw+HEvWfe2jDHy273JDgoPmrQ3nrLIkf2DrXTguiMpeS/ovYa6asvNdO06jWH3s1cy6VXIMEs=
X-Received: by 2002:a05:6102:212d:b0:46d:36a8:af30 with SMTP id
 f13-20020a056102212d00b0046d36a8af30mr110763vsg.4.1707114547830; Sun, 04 Feb
 2024 22:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20240204055228.900-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240204055228.900-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 16:28:41 +1000
Message-ID: <CAKmqyKNA5jpddM7Htbm8aeskreh5WWN15orC7RGwEwZLd2m+tA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Enable xtheadsync under user mode
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 qemu-riscv@nongnu.org, christoph.muellner@vrull.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

