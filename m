Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8517EC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSTl-00031U-Ad; Thu, 13 Aug 2026 06:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wuSTi-000314-9A
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:16:03 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wuSTg-0003Wc-DN
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:16:02 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81ed2a00f12so27296837b3.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786616159; cv=none;
 d=google.com; s=arc-20260327;
 b=nNf2ZyA1nVJleIqdOBeJ4xE6VRswivzv4OO9Kju1rwyVvRKsuiBot3pjLTasgMvJjZ
 7lPvK9t9Fz//z/t72JZDg0II63l/MpY9rAdcEnORfm71skjpzaPm/eGj95FiG7F+YvOJ
 2ZGTR6m4UAwlQlgYDhW1nJhpY7G6gysljy//Ddt4jaO2XKKG8pylCXVNkeMDM/YUcygH
 h+1Cq3G1yqnp7sR7SBDlMU9z6oJdwrspTGYXSk5VS3RIfhZI3nHEh2fTpk59lbB2Ih1e
 DPz2anDsN+YzPeDnEjgiiXO0wZ2jiDktBWoeWs5K0PmayGg3EfoJdR5Phu9+495Ki7X/
 +m6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=crZ489l831iQsRa0pu9smOPi57JXQ63OLMfU+qAhNjs=;
 fh=32y4SXtUcwQHMjWfz6RwE8N3C069QsW9iLkDzPdoW+o=;
 b=NPKYX5jOSMNp3p0PO18rKZuoNcJn+7HKv8t4bFUw24J3N0tftiFK8Ffx9DbY4ecR5U
 w6Omijn4bt3Kt/NhGH3LUndHImlM1svUF/RpmU5jJ+L9r84KHVLmvn0/Y0RNC0i6MHqL
 wIywLzdztvbznmGb49eTe/uu+o92+Yg111yyJjdpcNT0Ss/t01OHjOgCQxOJVin2mfiT
 Hmgd0J7kSsJHuLmIQYCzuKLgPMc0VXYSsWkEkbt6KLzaCEZv7syvNcLMkusUn9wpV48y
 /eKedeLmY5opVt2ElpRn0MrhXEk3wgVRShA/FTIpbyuooE50TSfM/3ptIZhP7qh09EYk
 vblg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1786616159; x=1787220959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=crZ489l831iQsRa0pu9smOPi57JXQ63OLMfU+qAhNjs=;
 b=BCeZP1o2h5sC0utaDcqddoANWIujsUhXzw66A4XiIr2OrYzo7cFRrNIOvZDg4ERj5y
 ImZfRrD2nbLJVbijGFaIceBMvNSYThTk+eYw9xOVo890pLVu9G7IkF4mw6tr7IvPH1M1
 30bn7s2GZJZB6hZrJl+GRf1a5Gww6Q7GeRuM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786616159; x=1787220959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=crZ489l831iQsRa0pu9smOPi57JXQ63OLMfU+qAhNjs=;
 b=ULfJJhQRk4DiZIz0J1H0CgsTr80V0usMMUWZgASTHMbWVT8np+cNsPG5VSFwAgwnAb
 sl78V5BoILMEtUbSdib4M61hY/fxTpk4iKxLrIqHsi1ToeEfN76C/vkEcBnWftrJbda3
 cwPTSnFkvje5Xi8iWemDQmSbUFED+JviaLw/3dEMzaALf9lUMB3HfVCyKiJchlBvuZi/
 QrSR8N4PIu8Gn/YzxdRs52d4O5e2Y7Gc1Rwuhnrj4NZHMiiKjYKfjly7hheogex29hVd
 9I2J8p1Tqa+32YvC7YhsSv/tZpds33JU0BASlFCkJXgGK1XX99qUjAPLtFTxORwcM45K
 VOSQ==
X-Gm-Message-State: AOJu0YzS1Bnzx4ezJF29etBUD9MBdD5b9iP9g4fXU2zvjMZpL5m0mYtK
 5GjJeRoi7fojn0lNrXDw31ENfxL5Z9gd6h5oYOvLchiV7WX5lQsnn/f8ISist1jGBboy+h+YTSn
 x5yKmyzHhRiwjtfWg3WIQlyQ2wzQwNHA=
X-Gm-Gg: AR+sD11YbyZjBwH42bPReeokEdpbsVCxyZ69j5V5FR5WZ/pBfUnyZbszSTEl5FPHmoI
 Hu1Naj95ms5fpUMMNDm8CxJVhw5HLyNiedrX1snoALsHNw+MlDmP4TQiBp/nAeQnF94aWPt24GM
 8Yt7lkAi2k3NPWt/tZ5RHf0TvaTRGQ7XMj2cdHuQ2MK02gxFYqDAKtjhgfByyWWhtXZKQ5bPIxB
 0uvot2xXEBDbEk+ZLDquyk/WVm4hZDuI5ioHimjMk17f1qfRI9oYt99byoG8QcVb5DU2hAZpNim
 /nlBgjgtL9zYQB9SP08ef5r5oTwj2xT8y4XkRErbCy1FH6mWAbPN1JiYu4rmnqICaxP3o554o9X
 uuq1WtrORPxozS+ZeY6jg091bOzVkh5zyfGJXD57VyE9OM1OfF/gFfpvajNpf25Z+XPYONvmZDc
 j1ZC/Yefgyx0uiZ1qA81W4s1IRP+QYhVQ+
X-Received: by 2002:a53:a711:0:b0:667:e51a:118e with SMTP id
 956f58d0204a3-66c514c173cmr1692022d50.15.1786616158879; Thu, 13 Aug 2026
 03:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260806133755.45924-1-vvisaev@gmail.com>
In-Reply-To: <20260806133755.45924-1-vvisaev@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Aug 2026 19:45:47 +0930
X-Gm-Features: AUfX_mwk8znExUaJ2xzgyzCycVESvJcluR7oNvx-lMhgsJKoumwEX03KpPImQlQ
Message-ID: <CACPK8Xf9H6aJK8Xj-s_UgusJk+dduMGz1M6tS2z8wGbTqOWmZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: csr: do not drop C bit on misa write
To: Vladimir Isaev <vvisaev@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 6 Aug 2026 at 23:07, Vladimir Isaev <vvisaev@gmail.com> wrote:
>
> According to spec:
> > Writing misa may increase IALIGN, e.g., by disabling the "C" extension.
> > If an instruction that would write misa increases IALIGN, and the
> > subsequent instruction=E2=80=99s address is not IALIGN-bit aligned, the
> > write to misa is suppressed, leaving misa unchanged.
>
> So attempt to disable C extension if next instruction is not aligned shou=
ld not
> change the misa.
>
> Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
> ---
>  target/riscv/tcg/csr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..58c206c1fa 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2182,9 +2182,10 @@ static RISCVException write_misa(CPURISCVState *en=
v, int csrno,
>      /* Mask extensions that are not supported by this hart */
>      val &=3D env->misa_ext_mask;
>
> -    /* Suppress 'C' if next instruction is not aligned. */
> -    if ((val & RVC) && (get_next_pc(env, ra) & 3) !=3D 0) {
> -        val &=3D ~RVC;
> +    /* drop write if RVC is cleared and next instruction is not aligned =
*/
> +    if ((env->misa_ext & RVC) && !(val & RVC) &&
> +         (get_next_pc(env, ra) & 3) !=3D 0) {
> +        return RISCV_EXCP_NONE;
>      }

I thought we'd already fixed this so I went hunting. This is similar
to Nick's patch:

https://lore.kernel.org/qemu-devel/acTSDKzeEb3bbv08@lima-default/

I think the conclusion there was to additionally check ra, and do
a qemu_log_mask(LOG_GUEST_ERROR, ...)

I don't think he got around to sending the next version of that series.

Cheers,

Joel

