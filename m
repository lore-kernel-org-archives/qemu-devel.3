Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E117FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFioZ-0002SO-Ci; Thu, 15 May 2025 20:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFioX-0002RT-HQ; Thu, 15 May 2025 20:20:37 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFioV-00042Z-LR; Thu, 15 May 2025 20:20:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-231bf5851b7so10064825ad.0; 
 Thu, 15 May 2025 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354834; x=1747959634; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+B4kvYEHKGoXnQ1AvYMeQiIP3Hp/KcW/zrkCvGU+3bI=;
 b=FRWJXeai7M0ordIavzCl8GUrEpSj+AXPdZbScCA2Swt1KBNTvFvg/IYPzo0djlOAgF
 88tYGvWQX+hJ3z79TQtq34/4roV1rfG7RweRdNwP3E4KTUTqI4Kqwytr6DHaBZxcntkJ
 yTFeQTWtt3TYUm+fHU9n5KendLM3hZ63pKJamA6dFqyW03cDR+aw/U2t9hlzBEUgS3Tz
 PFrVG3ALpaevJq7Lwrm4mbGbk7R63rldIshgWduv19F88lJRzmStnUYxE0KKp8osgObx
 tLx5W/K+xEaEdHMZDQ52Vgf8Ub+yGoZo4Lh2CEMmWj9IjGIZ+wDxQIJmWl1r7PZaTONu
 1S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354834; x=1747959634;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+B4kvYEHKGoXnQ1AvYMeQiIP3Hp/KcW/zrkCvGU+3bI=;
 b=PiZ1xcrHd1tFvSxrXvLFco4QkQnq3WPPR0JFOcVDY4aOi5pzXaknsGMnFwBpvIV7eF
 //Xd2JbWBlob+wuF/hltln61Nr6ElSWj7WAUcUQqzfUUYlYte0oQexaBG0yMxc+jbbUF
 EL4GPgWj1zR+je9VXwjDL/xK8DhIVWCaRAsEqzwstxnvtH+IR5L8iu7HMzX1eQnFJMXK
 7Z0x1IUFVEi6hsqUVoS/kRr9MJjRlszH9Uuomu059ojPiMU+zU4Z0PSpsHlM8D6EBEKg
 fTFRkHWQ5NdqHgjJ6r7ge3M0H6J1CRB74SvycJTkyxwDBDvkZ/hH+zEcrnDHA5D9dMlz
 beVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqWzAzu6Jv2hGgaRqIQsg9IF8nBgU5XWyfcEbrmGzsijvfJ9ZTMUDOba3bDYyPmLAfuvrfGoTRYw==@nongnu.org
X-Gm-Message-State: AOJu0YzPQbu1xAL+T+hBr0orj3PDnzpQT3opgEndVbMQR6fuTFGfYei6
 +6YfpjAlT5XXo7zvSuYTOgukZAzns1rhrGFfEn6cgoUgJD2hU4h0XSv/eXL4Xg==
X-Gm-Gg: ASbGncsGwGg9qz36jJqkRPdGALjLtJuNV9nBdGlGsJ23ccDz1sEwiCbOAERX+bj3dp7
 Fohx6mtQad9+6y4sOir8qPqb4gIuq/bcKHZOhysj0kyQikQWuhGfr1d2dBIWBQcvm8Z80eLMfJg
 bQph8I9sseuoHdDSvXZtZmT8Dzl0VD+4z5sfBwiI2RHL3nS0NuV+alXBzz1ZGXrIo6DgnPqNsSz
 Xd/4XT+BoNZWBKJA6nGCAtlAXUVmgOBOwyTknNQ/6brEGdWm9jbjszSpBO5DeS2Pw1pplBIePUH
 NrozkNTvMoV0EVqJ5MgjPwTqUReWb627u18HoUVJHKRbrkQ=
X-Google-Smtp-Source: AGHT+IGDpFpJuL7IQlrfuPfvRhbreLwObG+lEhXEtAQ8rz2JesQNwoI75sM4peAEHYmNSHPXtce8kA==
X-Received: by 2002:a17:902:ccc5:b0:22e:4d64:821f with SMTP id
 d9443c01a7336-231d4519057mr13371405ad.20.1747354833998; 
 Thu, 15 May 2025 17:20:33 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e98025sm3489405ad.140.2025.05.15.17.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:20:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:20:28 +1000
Message-Id: <D9X5LADSFQ0C.28RZBXB8O55LL@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 26/50] ppc/xive2: Redistribute group interrupt precluded
 by CPPR update
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-27-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-27-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Add support for redistributing a presented group interrupt if it
> is precluded as a result of changing the CPPR value. Without this,
> group interrupts can be lost.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c | 82 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 68be138335..92dbbad8d4 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -601,20 +601,37 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresente=
r *xptr, XiveTCTX *tctx)
>      return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
>  }
> =20
> -static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
> -                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_=
t ring)
> +static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_=
t ring)
>  {
> -    uint8_t nsr =3D tctx->regs[ring + TM_NSR];
> +    uint8_t *regs =3D &tctx->regs[ring];
> +    uint8_t nsr =3D regs[TM_NSR];
> +    uint8_t pipr =3D regs[TM_PIPR];
>      uint8_t crowd =3D NVx_CROWD_LVL(nsr);
>      uint8_t group =3D NVx_GROUP_LVL(nsr);
> -    uint8_t nvgc_blk;
> -    uint8_t nvgc_idx;
> -    uint8_t end_blk;
> -    uint32_t end_idx;
> -    uint8_t pipr =3D tctx->regs[ring + TM_PIPR];
> +    uint8_t nvgc_blk, end_blk, nvp_blk;
> +    uint32_t nvgc_idx, end_idx, nvp_idx;
>      Xive2Nvgc nvgc;
>      uint8_t prio_limit;
>      uint32_t cfg;
> +    uint8_t alt_ring;
> +    uint32_t target_ringw2;
> +    uint32_t cam;
> +    bool valid;
> +    bool hw;
> +
> +    /* redistribution is only for group/crowd interrupts */
> +    if (!xive_nsr_indicates_group_exception(ring, nsr)) {
> +        return;
> +    }
> +
> +    alt_ring =3D xive_nsr_exception_ring(ring, nsr);
> +    target_ringw2 =3D xive_tctx_word2(&tctx->regs[alt_ring]);
> +    cam =3D be32_to_cpu(target_ringw2);
> +
> +    /* extract nvp block and index from targeted ring's cam */
> +    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &hw);
> +
> +    trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_=
idx);
> =20
>      trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx)=
;
>      /* convert crowd/group to blk/idx */
> @@ -659,8 +676,8 @@ static void xive2_redistribute(Xive2Router *xrtr, Xiv=
eTCTX *tctx,
>      xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
> =20
>      /* clear interrupt indication for the context */
> -    tctx->regs[ring + TM_NSR] =3D 0;
> -    tctx->regs[ring + TM_PIPR] =3D tctx->regs[ring + TM_CPPR];
> +    regs[TM_NSR] =3D 0;
> +    regs[TM_PIPR] =3D regs[TM_CPPR];
>      xive_tctx_reset_signal(tctx, ring);
>  }
> =20
> @@ -695,7 +712,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr=
, XiveTCTX *tctx,
>      /* Active group/crowd interrupts need to be redistributed */
>      nsr =3D tctx->regs[ring + TM_NSR];
>      if (xive_nsr_indicates_group_exception(ring, nsr)) {
> -        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
> +        xive2_redistribute(xrtr, tctx, ring);
>      }
> =20
>      if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save=
) {
> @@ -1059,6 +1076,7 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTC=
TX *tctx,
>      xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
>  }
> =20
> +/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
>  static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cp=
pr)
>  {
>      uint8_t *regs =3D &tctx->regs[ring];
> @@ -1069,10 +1087,11 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, u=
int8_t ring, uint8_t cppr)
>      uint32_t nvp_blk, nvp_idx;
>      Xive2Nvp nvp;
>      int rc;
> +    uint8_t nsr =3D regs[TM_NSR];
> =20
>      trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
>                               regs[TM_IPB], regs[TM_PIPR],
> -                             cppr, regs[TM_NSR]);
> +                             cppr, nsr);
> =20
>      if (cppr > XIVE_PRIORITY_MAX) {
>          cppr =3D 0xff;
> @@ -1081,6 +1100,35 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, ui=
nt8_t ring, uint8_t cppr)
>      old_cppr =3D regs[TM_CPPR];
>      regs[TM_CPPR] =3D cppr;
> =20
> +    /* Handle increased CPPR priority (lower value) */
> +    if (cppr < old_cppr) {
> +        if (cppr <=3D regs[TM_PIPR]) {
> +            /* CPPR lowered below PIPR, must un-present interrupt */
> +            if (xive_nsr_indicates_exception(ring, nsr)) {
> +                if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +                    /* redistribute precluded active grp interrupt */
> +                    xive2_redistribute(xrtr, tctx, ring);
> +                    return;
> +                }
> +            }
> +
> +            /* interrupt is VP directed, pending in IPB */
> +            regs[TM_PIPR] =3D cppr;
> +            xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is clea=
red */
> +            return;
> +        } else {
> +            /* CPPR was lowered, but still above PIPR. No action needed.=
 */
> +            return;
> +        }
> +    }
> +
> +    /* CPPR didn't change, nothing needs to be done */
> +    if (cppr =3D=3D old_cppr) {
> +        return;
> +    }
> +
> +    /* CPPR priority decreased (higher value) */
> +
>      /*
>       * Recompute the PIPR based on local pending interrupts. It will
>       * be adjusted below if needed in case of pending group interrupts.
> @@ -1129,16 +1177,6 @@ again:
>          return;
>      }
> =20
> -    if (cppr < old_cppr) {
> -        /*
> -         * FIXME: check if there's a group interrupt being presented
> -         * and if the new cppr prevents it. If so, then the group
> -         * interrupt needs to be re-added to the backlog and
> -         * re-triggered (see re-trigger END info in the NVGC
> -         * structure)
> -         */
> -    }
> -
>      if (group_enabled &&
>          lsmfb_min < cppr &&
>          lsmfb_min < pipr_min) {


