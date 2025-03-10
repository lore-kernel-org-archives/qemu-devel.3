Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A421C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 04:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trUd8-00078D-KD; Mon, 10 Mar 2025 00:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trUQL-0005S3-Cu; Mon, 10 Mar 2025 00:07:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trUQJ-00060X-22; Mon, 10 Mar 2025 00:07:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22359001f1aso90391675ad.3; 
 Sun, 09 Mar 2025 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741579645; x=1742184445; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RR+bX10naIO7yZ4f5HhWWxEqcmaLfLZLXJ8Dw/gINU=;
 b=EWG+LJ00IxYb0sI0SMkYBMs6yMb5S98aWkqlKR0jyErM8bpcqzlhPnDqA9fCF1tQrn
 lwwcJE2oSrEdmh2ect1q1SyYXmsIKyQCqBFxun4gv9+UBGHOVVhVHKhF6980tA+d+HyB
 Rah6rnb9vSHuIChKs3VW5dX+VqKI96DSIbdTeGSKtFqlv/MMFl7UcsV2qUphh3eAJWTT
 mmw8OKoEsrXKpzo7Z0qo0M4hjHazFjxEPWZO4pARntDl5e3Cj2BdHdTnzZo2wxz/M33i
 idYg/xSv5jkVs32Mp8HZpPL0cKMwGTlrq6PzZ8zhJd8dCo4oFsuVvuyvDm2v15gbgr08
 jQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741579645; x=1742184445;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7RR+bX10naIO7yZ4f5HhWWxEqcmaLfLZLXJ8Dw/gINU=;
 b=RdRfLDtfoZBdfCtfaecGsmEjjLRmezi2uBL6xp8ePCvkbMpD9wbtNnuRJpcjyjfR6B
 oG/3mVl0p9iNRkc1XI9xKP9alA5XPKJr/pjZTo3CMba3QSRbkjxbL2PBXADfMg6swzQd
 rIJ/y+3Dhnbr6fMGG+cVzWSwPHp+AhhZ/z2GAYAt1YfM1q1sJ2F3qY0D5d/ynNHiE8tq
 wRRW+IElmTrq364S3AdvH7mJTtY6SpQfbVheQUyDs+ESiBpMnXsEnNVU7WsMdbmdQny4
 e7hUrwgucjz9n1xaAH7ZbHV+mH8iP/pe+KC3xKx9GobynTuX1L3YTCpeU+nka5mtN8ur
 07DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh7GBp8i0UTvnGnGjZM/CZgoBwjU03Sn4wFql9W+gCZfz2ykSNCua891V1RqQGOCXSCOpE5owVl3+0@nongnu.org
X-Gm-Message-State: AOJu0YwJYrQUjpDCRFlT447Bd+mQM9yB1LPz3RWEnx20fBeAu2ffB4UJ
 svpiUnLbeGN/QNh4ygVyWGtSbgLywOhgtVWF0TqAWuzAxd8gWE9R
X-Gm-Gg: ASbGncvqx2iiEvk+62LL03E5YWWSsYXQOljDKw9y2ZH27lfurnpACd4Pz8a8Q9viJY/
 wa1qheBgcc4rGC21BufCBLl2owlj2GxkjHw4RG9rrWCq1p5DYffJKvZvCu1T/vBzghrCzXVYgNj
 PQUGFW+U++Op+Tofd3MqNI0sbsQm+Lk1XqgA7IP6zjIBtGPsE5LGOJFpgdwgf2bj0rvpDsIjb1/
 zLJg4bDlFel/DAIyKexEBaXgY1yijecEuL5Ilr5n1/YmbK9ceEJVChfX+HLN0kWf13OW0AH1tB/
 bjRB/50WVKNhv3jmXZRy5kwuK0RPhnaJGsUhPtYs
X-Google-Smtp-Source: AGHT+IEiCBSG4e4G7XgKSzocr8WBmqyjvRYZBoaL4CPzYJuDALr5n3cYLW96Rrgov+OfRmvIcTefog==
X-Received: by 2002:a05:6a00:4b4a:b0:736:a8db:93b8 with SMTP id
 d2e1a72fcca58-736aa9b3970mr20889219b3a.3.1741579644717; 
 Sun, 09 Mar 2025 21:07:24 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736baa37598sm4200081b3a.90.2025.03.09.21.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 21:07:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 14:07:18 +1000
Message-Id: <D8CAGGO59SN8.F7LMIJ3I6930@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/14] ppc/xive2: Add undelivered group interrupt to
 backlog
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-9-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-9-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> When a group interrupt cannot be delivered, we need to:
> - increment the backlog counter for the group in the NVG table
>   (if the END is configured to keep a backlog).
> - start a broadcast operation to set the LSMFB field on matching CPUs
>   which can't take the interrupt now because they're running at too
>   high a priority.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  include/hw/ppc/xive.h  |   5 ++
>  include/hw/ppc/xive2.h |   1 +
>  hw/intc/pnv_xive2.c    |  42 +++++++++++++++++
>  hw/intc/xive2.c        | 105 +++++++++++++++++++++++++++++++++++------
>  hw/ppc/pnv.c           |  22 ++++++++-
>  5 files changed, 159 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index ce4eb9726b..f443a39cf1 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -442,6 +442,9 @@ struct XivePresenterClass {
>                       uint32_t logic_serv, XiveTCTXMatch *match);
>      bool (*in_kernel)(const XivePresenter *xptr);
>      uint32_t (*get_config)(XivePresenter *xptr);
> +    int (*broadcast)(XivePresenter *xptr,
> +                     uint8_t nvt_blk, uint32_t nvt_idx,
> +                     uint8_t priority);
>  };
> =20
>  int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> @@ -472,6 +475,8 @@ struct XiveFabricClass {
>                       uint8_t nvt_blk, uint32_t nvt_idx,
>                       bool cam_ignore, uint8_t priority,
>                       uint32_t logic_serv, XiveTCTXMatch *match);
> +    int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
> +                     uint8_t priority);
>  };
> =20
>  /*
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 65154f78d8..ebf301bb5b 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -120,6 +120,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, Xi=
veTCTX *tctx,
>  void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>                               hwaddr offset, uint64_t value, unsigned siz=
e);
>  bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
> +void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
>  void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>                              hwaddr offset, uint64_t value, unsigned size=
);
>  void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 5cdd4fdcc9..41b727d1fb 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -705,6 +705,47 @@ static uint32_t pnv_xive2_presenter_get_config(XiveP=
resenter *xptr)
>      return cfg;
>  }
> =20
> +static int pnv_xive2_broadcast(XivePresenter *xptr,
> +                               uint8_t nvt_blk, uint32_t nvt_idx,
> +                               uint8_t priority)
> +{
> +    PnvXive2 *xive =3D PNV_XIVE2(xptr);
> +    PnvChip *chip =3D xive->chip;
> +    int i, j;
> +    bool gen1_tima_os =3D
> +        xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
> +
> +    for (i =3D 0; i < chip->nr_cores; i++) {
> +        PnvCore *pc =3D chip->cores[i];
> +        CPUCore *cc =3D CPU_CORE(pc);
> +
> +        for (j =3D 0; j < cc->nr_threads; j++) {
> +            PowerPCCPU *cpu =3D pc->threads[j];
> +            XiveTCTX *tctx;
> +            int ring;
> +
> +            if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
> +                continue;
> +            }
> +
> +            tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> +
> +            if (gen1_tima_os) {
> +                ring =3D xive_presenter_tctx_match(xptr, tctx, 0, nvt_bl=
k,
> +                                                 nvt_idx, true, 0);
> +            } else {
> +                ring =3D xive2_presenter_tctx_match(xptr, tctx, 0, nvt_b=
lk,
> +                                                  nvt_idx, true, 0);
> +            }
> +
> +            if (ring !=3D -1) {
> +                xive2_tm_set_lsmfb(tctx, ring, priority);
> +            }
> +        }
> +    }
> +    return 0;
> +}
> +
>  static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
>  {
>      return pnv_xive2_block_id(PNV_XIVE2(xrtr));
> @@ -2445,6 +2486,7 @@ static void pnv_xive2_class_init(ObjectClass *klass=
, void *data)
> =20
>      xpc->match_nvt  =3D pnv_xive2_match_nvt;
>      xpc->get_config =3D pnv_xive2_presenter_get_config;
> +    xpc->broadcast  =3D pnv_xive2_broadcast;
>  };
> =20
>  static const TypeInfo pnv_xive2_info =3D {
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index cffcf3ff05..05cb17518d 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -62,6 +62,30 @@ static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc=
, uint8_t priority)
>      return val;
>  }
> =20
> +static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
> +                                   uint32_t val)
> +{
> +    uint8_t *ptr, i;
> +    uint32_t shift;
> +
> +    if (priority > 7) {
> +        return;
> +    }
> +
> +    if (val > 0xFFFFFF) {
> +        val =3D 0xFFFFFF;
> +    }

Could these conditions have asserts or warnings? Seems like we
saturate a counter or silently drop an interrupt if these things
can happen. Can add something later.

> +    /*
> +     * The per-priority backlog counters are 24-bit and the structure
> +     * is stored in big endian
> +     */
> +    ptr =3D (uint8_t *)&nvgc->w2 + priority * 3;

This fits because nvgc is 32 bytes so 24 bytes from w2, and
8 priorities * 3 bytes each is 24. I just added a bit more comment.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +    for (i =3D 0; i < 3; i++, ptr++) {
> +        shift =3D 8 * (2 - i);
> +        *ptr =3D (val >> shift) & 0xFF;
> +    }
> +}
> +
>  void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf=
)
>  {
>      if (!xive2_eas_is_valid(eas)) {
> @@ -830,6 +854,19 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring=
, uint8_t priority)
>      return true;
>  }
> =20
> +void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority)
> +{
> +    uint8_t *regs =3D &tctx->regs[ring];
> +
> +    /*
> +     * Called by the router during a VP-group notification when the
> +     * thread matches but can't take the interrupt because it's
> +     * already running at a more favored priority. It then stores the
> +     * new interrupt priority in the LSMFB field.
> +     */
> +    regs[TM_LSMFB] =3D priority;
> +}
> +
>  static void xive2_router_realize(DeviceState *dev, Error **errp)
>  {
>      Xive2Router *xrtr =3D XIVE2_ROUTER(dev);
> @@ -962,10 +999,9 @@ static void xive2_router_end_notify(Xive2Router *xrt=
r, uint8_t end_blk,
>      /*
>       * If no matching NVP is dispatched on a HW thread :
>       * - specific VP: update the NVP structure if backlog is activated
> -     * - logical server : forward request to IVPE (not supported)
> +     * - VP-group: update the backlog counter for that priority in the N=
VG
>       */
>      if (xive2_end_is_backlog(&end)) {
> -        uint8_t ipb;
> =20
>          if (format =3D=3D 1) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> @@ -974,19 +1010,58 @@ static void xive2_router_end_notify(Xive2Router *x=
rtr, uint8_t end_blk,
>              return;
>          }
> =20
> -        /*
> -         * Record the IPB in the associated NVP structure for later
> -         * use. The presenter will resend the interrupt when the vCPU
> -         * is dispatched again on a HW thread.
> -         */
> -        ipb =3D xive_get_field32(NVP2_W2_IPB, nvp.w2) |
> -            xive_priority_to_ipb(priority);
> -        nvp.w2 =3D xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
> -        xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
> -
> -        /*
> -         * On HW, follows a "Broadcast Backlog" to IVPEs
> -         */
> +        if (!xive2_end_is_ignore(&end)) {
> +            uint8_t ipb;
> +            /*
> +             * Record the IPB in the associated NVP structure for later
> +             * use. The presenter will resend the interrupt when the vCP=
U
> +             * is dispatched again on a HW thread.
> +             */
> +            ipb =3D xive_get_field32(NVP2_W2_IPB, nvp.w2) |
> +                xive_priority_to_ipb(priority);
> +            nvp.w2 =3D xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
> +            xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
> +        } else {
> +            Xive2Nvgc nvg;
> +            uint32_t backlog;
> +
> +            /* For groups, the per-priority backlog counters are in the =
NVG */
> +            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvp_idx, &nv=
g)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVG %x/%x\n",
> +                              nvp_blk, nvp_idx);
> +                return;
> +            }
> +
> +            if (!xive2_nvgc_is_valid(&nvg)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVG %x/%x is inval=
id\n",
> +                              nvp_blk, nvp_idx);
> +                return;
> +            }
> +
> +            /*
> +             * Increment the backlog counter for that priority.
> +             * For the precluded case, we only call broadcast the
> +             * first time the counter is incremented. broadcast will
> +             * set the LSMFB field of the TIMA of relevant threads so
> +             * that they know an interrupt is pending.
> +             */
> +            backlog =3D xive2_nvgc_get_backlog(&nvg, priority) + 1;
> +            xive2_nvgc_set_backlog(&nvg, priority, backlog);
> +            xive2_router_write_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg)=
;
> +
> +            if (precluded && backlog =3D=3D 1) {
> +                XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xrtr->xfb=
);
> +                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx, priority);
> +
> +                if (!xive2_end_is_precluded_escalation(&end)) {
> +                    /*
> +                     * The interrupt will be picked up when the
> +                     * matching thread lowers its priority level
> +                     */
> +                    return;
> +                }
> +            }
> +        }
>      }
> =20
>  do_escalation:
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index f0f0d7567d..7c11143749 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1,7 +1,9 @@
>  /*
>   * QEMU PowerPC PowerNV machine model
>   *
> - * Copyright (c) 2016, IBM Corporation.
> + * Copyright (c) 2016-2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
> @@ -2639,6 +2641,23 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, u=
int8_t format,
>      return total_count;
>  }
> =20
> +static int pnv10_xive_broadcast(XiveFabric *xfb,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                uint8_t priority)
> +{
> +    PnvMachineState *pnv =3D PNV_MACHINE(xfb);
> +    int i;
> +
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        Pnv10Chip *chip10 =3D PNV10_CHIP(pnv->chips[i]);
> +        XivePresenter *xptr =3D XIVE_PRESENTER(&chip10->xive);
> +        XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> +
> +        xpc->broadcast(xptr, nvt_blk, nvt_idx, priority);
> +    }
> +    return 0;
> +}
> +
>  static bool pnv_machine_get_big_core(Object *obj, Error **errp)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(obj);
> @@ -2772,6 +2791,7 @@ static void pnv_machine_p10_common_class_init(Objec=
tClass *oc, void *data)
>      pmc->dt_power_mgt =3D pnv_dt_power_mgt;
> =20
>      xfc->match_nvt =3D pnv10_xive_match_nvt;
> +    xfc->broadcast =3D pnv10_xive_broadcast;
> =20
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>  }


