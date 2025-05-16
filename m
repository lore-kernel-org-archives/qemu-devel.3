Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A95C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFioN-0002QG-R7; Thu, 15 May 2025 20:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFioM-0002Pn-Au; Thu, 15 May 2025 20:20:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFioK-000426-Ex; Thu, 15 May 2025 20:20:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso1349801b3a.1; 
 Thu, 15 May 2025 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354822; x=1747959622; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RAf7eCvWf0GtgDQWPhO5bG7sYJpY+MadAyJEWGasC8=;
 b=mUiB7wLcE1nQbWFAukzJeidP24jvDexMJLs5F0UuN9nWtDOI4AJ6KVHkoj8agIP3ew
 GDwRCCGZeG11HVXjpddNoqrX+B/cGrXgrdDzUPMUDXsn0dS0HkQ7ywnZuaWmuSoY5Yah
 Mx6Fc07esgVJONRCMaJftDY1zRyj6+uDT8UZxX0O/v/oojKl2D/R8g9thkrXQNetH5ha
 q3buGdcJVh9nc1xXfy69DdYEGmgWA2Byg0rhGh9ZuzsJDU7ajPhw5FVMCEXQGzTcc7/1
 2nfMLdle1L4XppzTyLYRaB9QxAiRZstHC+uzxN+pEwsT1FcNax99ZMfq+EqLmMqPnoEe
 xnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354822; x=1747959622;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1RAf7eCvWf0GtgDQWPhO5bG7sYJpY+MadAyJEWGasC8=;
 b=u9EI3LQHUgJXw8N+reZ7cqCa4wZ7LQlolxtFV+YOuh/r+s3k+RHtDypWDiyEVLdtyI
 /vR00en6sXw1BEAoqh2WHBbKLWLlAgM38DW70OG2vyZ5C3/10h4X2qqfOhHI37XmzF3l
 0Pn7enV8pdPw2iSAXyBViWAipvPCHyENhsV8NX3KMNBRB32iMQjwWC3qsS4FWBRebwLA
 viFrFqKhub8aX7cN049ryOxDMnAZZO67dVAbom5jY5i4PYvygixLAEDWSZo1Ad4DTLWd
 Q+k7x+6AEiPHyZb7/psm79HUfM/IdDkj11F2xzTxHgWzeie1o1Dg4NGQ7AmiahQdVV7F
 z8ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjZuJ+ue26btC281RcXfzCwZnmD+WR018McMaeHjHo/oUk1EbI4xS9X624LcCn3cqaVL8st1ehYQ==@nongnu.org
X-Gm-Message-State: AOJu0YypHauVE+s2ilp9xqOPNYhvhv5pO93N1nRfQeSEXeynOL0S7yfW
 kcmSjruHEP/JmDoFfQlvqriqFcmSTzIAsLhAtNMa62YNiMcci7qeCQJJ
X-Gm-Gg: ASbGncvt9VIrYjNDqDg3yPFFIX2BocRDaStg4NHcUTYNAUUgEJ9/OKBxEJpalrMQuS2
 vx4j4dIw/aGcgB+CWGDAXBW5FIg9czGwWFb77zJL4vme3GFp3EuNq5KfNTkf3PFjlm2NbDPTKL0
 iB6sJ6w2nr0qFPPNIX44CkLeWQRKqwE14RwwDpc/azEjijsHANCgutc6z0D4P3m/qaNPtvXtGFA
 yiGtBfYx+Pt7CCwAIJHqrwf1CAgruQCcfatMdSHSbbjs0ki262K7MHk/W1Fh4yAxIrFr1ULNJBC
 M1cwfgAJzj7EvbnwfDboS+Vb0vu1O08BSdP/qP7m6koOX9U=
X-Google-Smtp-Source: AGHT+IHX1Ad7CXPB8AvDoIO4UPjSAwaVeCpt6rWRJILS0a+Ua4Ay3Ev9WtTjTiX2hIE/Nu09VKyEAw==
X-Received: by 2002:a05:6a00:10cb:b0:73c:3f2e:5df5 with SMTP id
 d2e1a72fcca58-742a9afe772mr1184428b3a.9.1747354822088; 
 Thu, 15 May 2025 17:20:22 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970d5f0sm412348b3a.56.2025.05.15.17.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:20:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:20:16 +1000
Message-Id: <D9X5L4VEQ3GN.3F2B6O25UK4RK@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 25/50] ppc/xive2: Implement "Ack OS IRQ to even report
 line" TIMA op
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-26-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-26-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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
> Booting AIX in a PowerVM partition requires the use of the "Acknowledge
> O/S Interrupt to even O/S reporting line" special operation provided by
> the IBM XIVE interrupt controller. This operation is invoked by writing
> a byte (data is irrelevant) to offset 0xC10 of the Thread Interrupt
> Management Area (TIMA). It can be used by software to notify the XIVE
> logic that the interrupt was received.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive.c         |  8 ++++---
>  hw/intc/xive2.c        | 50 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/xive.h  |  1 +
>  include/hw/ppc/xive2.h |  3 ++-
>  4 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 7461dbecb8..9ec1193dfc 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -80,7 +80,7 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_=
t ring)
>          }
>  }
> =20
> -static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
> +uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>  {
>      uint8_t *regs =3D &tctx->regs[ring];
>      uint8_t nsr =3D regs[TM_NSR];
> @@ -340,14 +340,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter *xptr=
, XiveTCTX *tctx,
> =20
>  static const uint8_t xive_tm_hw_view[] =3D {
>      3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User *=
/
> -    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   *=
/
> +    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   *=
/
>      0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL *=
/
>      3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS *=
/
>  };
> =20
>  static const uint8_t xive_tm_hv_view[] =3D {
>      3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User *=
/
> -    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   *=
/
> +    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   *=
/
>      0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL *=
/
>      3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS *=
/
>  };
> @@ -718,6 +718,8 @@ static const XiveTmOp xive2_tm_operations[] =3D {
>                                                       xive_tm_pull_phys_c=
tx },
>      { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_=
ctx_ol,
>                                                       NULL },
> +    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
> +                                                     NULL },
>  };
> =20
>  static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offse=
t,
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index ec4b9320b4..68be138335 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1009,6 +1009,56 @@ static int xive2_tctx_get_nvp_indexes(XiveTCTX *tc=
tx, uint8_t ring,
>      return 0;
>  }
> =20
> +static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
> +                                 uint8_t ring, uint8_t cl_ring)
> +{
> +    uint64_t rd;
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(xptr);
> +    uint32_t nvp_blk, nvp_idx, xive2_cfg;
> +    Xive2Nvp nvp;
> +    uint64_t phys_addr;
> +    uint8_t OGen =3D 0;
> +
> +    xive2_tctx_get_nvp_indexes(tctx, cl_ring, &nvp_blk, &nvp_idx);
> +
> +    if (xive2_router_get_nvp(xrtr, (uint8_t)nvp_blk, nvp_idx, &nvp)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
> +                      nvp_blk, nvp_idx);
> +        return;
> +    }
> +
> +    if (!xive2_nvp_is_valid(&nvp)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
> +                      nvp_blk, nvp_idx);
> +        return;
> +    }
> +
> +
> +    rd =3D xive_tctx_accept(tctx, ring);
> +
> +    if (ring =3D=3D TM_QW1_OS) {
> +        OGen =3D tctx->regs[ring + TM_OGEN];
> +    }
> +    xive2_cfg =3D xive2_router_get_config(xrtr);
> +    phys_addr =3D xive2_nvp_reporting_addr(&nvp);
> +    uint8_t report_data[REPORT_LINE_GEN1_SIZE];
> +    memset(report_data, 0xff, sizeof(report_data));
> +    if ((OGen =3D=3D 1) || (xive2_cfg & XIVE2_GEN1_TIMA_OS)) {
> +        report_data[8] =3D (rd >> 8) & 0xff;
> +        report_data[9] =3D rd & 0xff;
> +    } else {
> +        report_data[0] =3D (rd >> 8) & 0xff;
> +        report_data[1] =3D rd & 0xff;
> +    }
> +    cpu_physical_memory_write(phys_addr, report_data, REPORT_LINE_GEN1_S=
IZE);
> +}
> +
> +void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
> +                        hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
> +}
> +
>  static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cp=
pr)
>  {
>      uint8_t *regs =3D &tctx->regs[ring];
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 28f0f1b79a..46d05d74fb 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -561,6 +561,7 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ri=
ng, uint8_t priority,
>                             uint8_t group_level);
>  void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>  void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)=
;
> +uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
> =20
>  /*
>   * KVM XIVE device helpers
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 760b94a962..ff02ce2549 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -142,5 +142,6 @@ void xive2_tm_set_hv_target(XivePresenter *xptr, Xive=
TCTX *tctx,
>                              hwaddr offset, uint64_t value, unsigned size=
);
>  void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>                                 hwaddr offset, uint64_t value, unsigned s=
ize);
> -
> +void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
> +                        hwaddr offset, uint64_t value, unsigned size);
>  #endif /* PPC_XIVE2_H */


