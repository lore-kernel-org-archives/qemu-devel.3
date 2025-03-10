Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8749C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXc5-0004YQ-B9; Mon, 10 Mar 2025 03:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trXby-0004SF-Fe; Mon, 10 Mar 2025 03:31:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trXbv-0004EF-S4; Mon, 10 Mar 2025 03:31:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224019ad9edso87971535ad.1; 
 Mon, 10 Mar 2025 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741591895; x=1742196695; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVHkih7Cw8M5jtY+T04kwom8k7UPHUdHthQ3gzJnmY8=;
 b=CUg4gPnbFUAW5R7Ocnzaraz/Qd9BnMiRhRGVXVHeyql1newUeuQL5lMvXKcTn4B8/E
 M3sgW8v94indy6cJwPDzUVrsv55cT+6iJuJqLpHCtDsfmSV0cIVuNTVyF5NeiCXKnJap
 lZb/6q7XxfR2GDW2/i/bmgo2+Qld/ys1WAOirXtV+y/V1K3wRY4X3NaMTNeHgr/yTIDj
 tHUrJ2npX2wuIaighw9Aw7kJFkzwp0+U0/gPZvq7/5FgccWnRewvDMS9zkeFr5/KbWiw
 h90mrq8Bo2r+CbzJcECMN9WGzEKVaoQnvUdEZqAjmYQqE9CVNRgI9rAfezbptHJMYKoK
 47og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741591895; x=1742196695;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DVHkih7Cw8M5jtY+T04kwom8k7UPHUdHthQ3gzJnmY8=;
 b=hDBdPg44Uy+tnJvOYQIWREPmJc/3QJ4d1Msw6e1ZK5gZ8NiMFgCO7P25CRWNYOENar
 jQcs3Q/FMFhFSX51AfRMqVUaT30LpXExuEcRhelc+HRO3UnVKNbsEvHnAKHXxIqk/3it
 4AZFMlaTDzNazKZ7diPAVPLL14EVMrA98+Bzfcykh+OgE001aql1g4Wn+NIw9CvcjKCd
 y5nBk1Q+j/7pB+A/WDh7Jxlf/NaAtClm0lo5PmD0UuQwUJC6CdOowquZow2yeflDMUzN
 WRRGq3OSCfSon0d4g5ygs/KN6hyNNEC7iqcRz1In1pV7lvvR1nQzZzt7xIQcK1grmq6L
 yQzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1zaLcIvtlsiZDwOGEWF9eLmWmQHjB2UI4pgI3okPqzKOHMa6MUlAhqUIGWMGTk95VEbGamP85V4cC@nongnu.org
X-Gm-Message-State: AOJu0Yy1TorRvxY0AEfmaM3imapY6SbDp5cmWBmnhK2O2rVO0J0wO7LX
 8Gu0cCTT6kVF8Sm5rKSXIvGCmCP6F4aydL3mINDkSJ35EIvSoRNP
X-Gm-Gg: ASbGnct/mt92PG7LzoRsO4TG9Gb6VgjxDz0FtSHOmJheOLOy+2ASxZANCedQKU4SXby
 u6lP2waWDX4X/Gxoj+OGvRAJD10lM/QLw/yZ0Oh1foCdQ7ewbYlN0GyPalRcB9G5VzeDwIDuMTX
 WUk6CdZh3mkGYZcBXpSPpvcEBY2BrVgBG1MOLyljLI7/lopXp1N9F9K3++boKrZ89ErxxQs6SeR
 6vWCY01ZaBH7oobPZ3DsL3UXDwcblSJe+IjY2VTp4UUZiTw4+3FooHIF8VMQ9XSdKdV1PeV52Oo
 EEudYLHQMFyvmKN6QXFzKu3X8ZfARAjJwCPY3pO+
X-Google-Smtp-Source: AGHT+IE4NaeAdd5wtnoao/1A/9zV61tWd2ROJChDUMdwLCFerxN66nR4VOnDSW/lJHxklbmxEhKHCw==
X-Received: by 2002:a17:903:1ca:b0:21b:d105:26b8 with SMTP id
 d9443c01a7336-2242887b209mr156702975ad.7.1741591895280; 
 Mon, 10 Mar 2025 00:31:35 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e9cfesm70819035ad.87.2025.03.10.00.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 00:31:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 17:31:27 +1000
Message-Id: <D8CESS2HNORM.1B2HHIPE39WD1@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 10/14] ppc/xive2: Support crowd-matching when looking
 for target
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-20-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-20-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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
> XIVE crowd sizes are encoded into a 2-bit field as follows:
>   0: 0b00
>   2: 0b01
>   4: 0b10
>  16: 0b11
>
> A crowd size of 8 is not supported.
>
> If an END is defined with the 'crowd' bit set, then a target can be
> running on different blocks. It means that some bits from the block
> VP are masked when looking for a match. It is similar to groups, but
> on the block instead of the VP index.
>
> Most of the changes are due to passing the extra argument 'crowd' all
> the way to the function checking for matches.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  include/hw/ppc/xive.h  | 10 +++---
>  include/hw/ppc/xive2.h |  3 +-
>  hw/intc/pnv_xive.c     | 10 +++---
>  hw/intc/pnv_xive2.c    | 12 +++----
>  hw/intc/spapr_xive.c   |  8 ++---
>  hw/intc/xive.c         | 40 ++++++++++++++++++----
>  hw/intc/xive2.c        | 78 +++++++++++++++++++++++++++++++++---------
>  hw/ppc/pnv.c           | 15 ++++----
>  hw/ppc/spapr.c         |  7 ++--
>  9 files changed, 131 insertions(+), 52 deletions(-)
>
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index f443a39cf1..8317fde0db 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -438,13 +438,13 @@ struct XivePresenterClass {
>      InterfaceClass parent;
>      int (*match_nvt)(XivePresenter *xptr, uint8_t format,
>                       uint8_t nvt_blk, uint32_t nvt_idx,
> -                     bool cam_ignore, uint8_t priority,
> +                     bool crowd, bool cam_ignore, uint8_t priority,
>                       uint32_t logic_serv, XiveTCTXMatch *match);
>      bool (*in_kernel)(const XivePresenter *xptr);
>      uint32_t (*get_config)(XivePresenter *xptr);
>      int (*broadcast)(XivePresenter *xptr,
>                       uint8_t nvt_blk, uint32_t nvt_idx,
> -                     uint8_t priority);
> +                     bool crowd, bool cam_ignore, uint8_t priority);
>  };
> =20
>  int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> @@ -453,7 +453,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, Xi=
veTCTX *tctx,
>                                bool cam_ignore, uint32_t logic_serv);
>  bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>                             uint8_t nvt_blk, uint32_t nvt_idx,
> -                           bool cam_ignore, uint8_t priority,
> +                           bool crowd, bool cam_ignore, uint8_t priority=
,
>                             uint32_t logic_serv, bool *precluded);
> =20
>  uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
> @@ -473,10 +473,10 @@ struct XiveFabricClass {
>      InterfaceClass parent;
>      int (*match_nvt)(XiveFabric *xfb, uint8_t format,
>                       uint8_t nvt_blk, uint32_t nvt_idx,
> -                     bool cam_ignore, uint8_t priority,
> +                     bool crowd, bool cam_ignore, uint8_t priority,
>                       uint32_t logic_serv, XiveTCTXMatch *match);
>      int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
> -                     uint8_t priority);
> +                     bool crowd, bool cam_ignore, uint8_t priority);
>  };
> =20
>  /*
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index c07e23e1d3..8cdf819174 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -88,7 +88,8 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lis=
n, bool pq_checked);
>  int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>                                 uint8_t format,
>                                 uint8_t nvt_blk, uint32_t nvt_idx,
> -                               bool cam_ignore, uint32_t logic_serv);
> +                               bool crowd, bool cam_ignore,
> +                               uint32_t logic_serv);
> =20
>  uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
>                                          uint8_t blk, uint32_t idx,
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 5bacbce6a4..d4796ab5a6 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1,10 +1,9 @@
>  /*
>   * QEMU PowerPC XIVE interrupt controller model
>   *
> - * Copyright (c) 2017-2019, IBM Corporation.
> + * Copyright (c) 2017-2024, IBM Corporation.
>   *
> - * This code is licensed under the GPL version 2 or later. See the
> - * COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> =20
>  #include "qemu/osdep.h"
> @@ -473,7 +472,7 @@ static bool pnv_xive_is_cpu_enabled(PnvXive *xive, Po=
werPCCPU *cpu)
> =20
>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>                                uint8_t nvt_blk, uint32_t nvt_idx,
> -                              bool cam_ignore, uint8_t priority,
> +                              bool crowd, bool cam_ignore, uint8_t prior=
ity,
>                                uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      PnvXive *xive =3D PNV_XIVE(xptr);
> @@ -500,7 +499,8 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, ui=
nt8_t format,
>               * Check the thread context CAM lines and record matches.
>               */
>              ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_b=
lk,
> -                                             nvt_idx, cam_ignore, logic_=
serv);
> +                                             nvt_idx, cam_ignore,
> +                                             logic_serv);
>              /*
>               * Save the context and follow on to catch duplicates, that =
we
>               * don't support yet.
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 54abfe3947..91f3514f93 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -624,7 +624,7 @@ static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, =
PowerPCCPU *cpu)
> =20
>  static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>                                 uint8_t nvt_blk, uint32_t nvt_idx,
> -                               bool cam_ignore, uint8_t priority,
> +                               bool crowd, bool cam_ignore, uint8_t prio=
rity,
>                                 uint32_t logic_serv, XiveTCTXMatch *match=
)
>  {
>      PnvXive2 *xive =3D PNV_XIVE2(xptr);
> @@ -655,8 +655,8 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, u=
int8_t format,
>                                                   logic_serv);
>              } else {
>                  ring =3D xive2_presenter_tctx_match(xptr, tctx, format, =
nvt_blk,
> -                                                   nvt_idx, cam_ignore,
> -                                                   logic_serv);
> +                                                  nvt_idx, crowd, cam_ig=
nore,
> +                                                  logic_serv);
>              }
> =20
>              if (ring !=3D -1) {
> @@ -707,7 +707,7 @@ static uint32_t pnv_xive2_presenter_get_config(XivePr=
esenter *xptr)
> =20
>  static int pnv_xive2_broadcast(XivePresenter *xptr,
>                                 uint8_t nvt_blk, uint32_t nvt_idx,
> -                               uint8_t priority)
> +                               bool crowd, bool ignore, uint8_t priority=
)
>  {
>      PnvXive2 *xive =3D PNV_XIVE2(xptr);
>      PnvChip *chip =3D xive->chip;
> @@ -732,10 +732,10 @@ static int pnv_xive2_broadcast(XivePresenter *xptr,
> =20
>              if (gen1_tima_os) {
>                  ring =3D xive_presenter_tctx_match(xptr, tctx, 0, nvt_bl=
k,
> -                                                 nvt_idx, true, 0);
> +                                                 nvt_idx, ignore, 0);
>              } else {
>                  ring =3D xive2_presenter_tctx_match(xptr, tctx, 0, nvt_b=
lk,
> -                                                  nvt_idx, true, 0);
> +                                                  nvt_idx, crowd, ignore=
, 0);
>              }
> =20
>              if (ring !=3D -1) {
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 283a6b8fd2..0477fdd594 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1,10 +1,9 @@
>  /*
>   * QEMU PowerPC sPAPR XIVE interrupt controller model
>   *
> - * Copyright (c) 2017-2018, IBM Corporation.
> + * Copyright (c) 2017-2024, IBM Corporation.
>   *
> - * This code is licensed under the GPL version 2 or later. See the
> - * COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> =20
>  #include "qemu/osdep.h"
> @@ -431,7 +430,8 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uin=
t8_t nvt_blk,
> =20
>  static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>                                  uint8_t nvt_blk, uint32_t nvt_idx,
> -                                bool cam_ignore, uint8_t priority,
> +                                bool crowd, bool cam_ignore,
> +                                uint8_t priority,
>                                  uint32_t logic_serv, XiveTCTXMatch *matc=
h)
>  {
>      CPUState *cs;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 308de5aefc..97d1c42bb2 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1667,10 +1667,37 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index=
)
>      return 1 << (ctz32(~nvp_index) + 1);
>  }
> =20
> -static uint8_t xive_get_group_level(uint32_t nvp_index)
> +static uint8_t xive_get_group_level(bool crowd, bool ignore,
> +                                    uint32_t nvp_blk, uint32_t nvp_index=
)
>  {
> -    /* FIXME add crowd encoding */
> -    return ctz32(~nvp_index) + 1;
> +    uint8_t level =3D 0;
> +
> +    if (crowd) {
> +        /* crowd level is bit position of first 0 from the right in nvp_=
blk */
> +        level =3D ctz32(~nvp_blk) + 1;
> +
> +        /*
> +         * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not suppo=
rted.
> +         * HW will encode level 4 as the value 3.  See xive2_pgofnext().
> +         */
> +        switch (level) {
> +        case 1:
> +        case 2:
> +            break;
> +        case 4:
> +            level =3D 3;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        /* Crowd level bits reside in upper 2 bits of the 6 bit group le=
vel */
> +        level <<=3D 4;
> +    }
> +    if (ignore) {
> +        level |=3D (ctz32(~nvp_index) + 1) & 0b1111;
> +    }
> +    return level;
>  }
> =20
>  /*

Crowd implies ignore I think? So it might read better if if (ignore) {
branch was at the top level with the bottom bits calculated first, then
if (crowd) { inside that branch.

> @@ -1742,7 +1769,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, =
XiveTCTX *tctx,
>   */
>  bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>                             uint8_t nvt_blk, uint32_t nvt_idx,
> -                           bool cam_ignore, uint8_t priority,
> +                           bool crowd, bool cam_ignore, uint8_t priority=
,
>                             uint32_t logic_serv, bool *precluded)
>  {
>      XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
> @@ -1773,7 +1800,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t=
 format,
>       * a new command to the presenters (the equivalent of the "assign"
>       * power bus command in the documented full notify sequence.
>       */
> -    count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
> +    count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_i=
gnore,
>                             priority, logic_serv, &match);
>      if (count < 0) {
>          return false;
> @@ -1781,7 +1808,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t=
 format,
> =20
>      /* handle CPU exception delivery */
>      if (count) {
> -        group_level =3D cam_ignore ? xive_get_group_level(nvt_idx) : 0;
> +        group_level =3D xive_get_group_level(crowd, cam_ignore, nvt_blk,=
 nvt_idx);
>          trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_=
level);
>          xive_tctx_pipr_update(match.tctx, match.ring, priority, group_le=
vel);
>      } else {
> @@ -1906,6 +1933,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveE=
AS *eas)
>      }
> =20
>      found =3D xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
> +                          false /* crowd */,
>                            xive_get_field32(END_W7_F0_IGNORE, end.w7),
>                            priority,
>                            xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7),
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index f4621bdd02..20d63e8f6e 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1120,13 +1120,42 @@ static bool xive2_vp_match_mask(uint32_t cam1, ui=
nt32_t cam2,
>      return (cam1 & vp_mask) =3D=3D (cam2 & vp_mask);
>  }
> =20
> +static uint8_t xive2_get_vp_block_mask(uint32_t nvt_blk, bool crowd)
> +{
> +    uint8_t size, block_mask =3D 0b1111;
> +
> +    /* 3 supported crowd sizes: 2, 4, 16 */
> +    if (crowd) {
> +        size =3D xive_get_vpgroup_size(nvt_blk);
> +        if (size =3D=3D 8) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of =
8n");
> +            return block_mask;
> +        }
> +        block_mask =3D ~(size - 1);
> +        block_mask &=3D 0b1111;

This could just be block_mask &=3D ~(size - 1) ?

> +    }
> +    return block_mask;
> +}
> +
> +static uint32_t xive2_get_vp_index_mask(uint32_t nvt_index, bool cam_ign=
ore)
> +{
> +    uint32_t index_mask =3D 0xFFFFFF; /* 24 bits */
> +
> +    if (cam_ignore) {
> +        index_mask =3D ~(xive_get_vpgroup_size(nvt_index) - 1);
> +        index_mask &=3D 0xFFFFFF;

Similar here.

> +    }
> +    return index_mask;
> +}
> +
>  /*
>   * The thread context register words are in big-endian format.
>   */
>  int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
>                                 uint8_t format,
>                                 uint8_t nvt_blk, uint32_t nvt_idx,
> -                               bool cam_ignore, uint32_t logic_serv)
> +                               bool crowd, bool cam_ignore,
> +                               uint32_t logic_serv)
>  {
>      uint32_t cam =3D   xive2_nvp_cam_line(nvt_blk, nvt_idx);
>      uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
> @@ -1134,7 +1163,8 @@ int xive2_presenter_tctx_match(XivePresenter *xptr,=
 XiveTCTX *tctx,
>      uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>      uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
> =20
> -    uint32_t vp_mask =3D 0xFFFFFFFF;
> +    uint32_t index_mask, vp_mask;
> +    uint8_t block_mask;
> =20
>      if (format =3D=3D 0) {
>          /*
> @@ -1142,9 +1172,9 @@ int xive2_presenter_tctx_match(XivePresenter *xptr,=
 XiveTCTX *tctx,
>           * i=3D1: VP-group notification (bits ignored at the end of the
>           *      NVT identifier)
>           */
> -        if (cam_ignore) {
> -            vp_mask =3D ~(xive_get_vpgroup_size(nvt_idx) - 1);
> -        }
> +        block_mask =3D xive2_get_vp_block_mask(nvt_blk, crowd);
> +        index_mask =3D xive2_get_vp_index_mask(nvt_idx, cam_ignore);
> +        vp_mask =3D xive2_nvp_cam_line(block_mask, index_mask);

Just a small thing but you could have all these be a single function,

 vp_mask =3D xive2_get_vp_mask(nvt_blk, nvt_idx, crowd, cam_ignore);

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


