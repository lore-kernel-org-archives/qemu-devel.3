Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935A7C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXd7-0005XQ-Oo; Mon, 10 Mar 2025 03:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trXcv-0005Va-P9; Mon, 10 Mar 2025 03:32:41 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trXct-0004Kq-M9; Mon, 10 Mar 2025 03:32:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2235189adaeso62913045ad.0; 
 Mon, 10 Mar 2025 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741591957; x=1742196757; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsKV8UtxL7EJ/fbkRKsyuDdgXGCSLikNxLLxs6vMc/Y=;
 b=QhTQdz+OEaiFfgMcsRKvhKty1e2qgljYLKkzfmdcQbAa7gKCjF9ztJ8eN4ClNCXRia
 P8Hv3wAkU46JTyXOfGh9khL4U9WTkROQsU+CWCCAFRyX/7u2uNKRYxeC2bq0qvIAA6B+
 msCY+wd1ee3JmXvgX5q/w9DieKCCpyc5+83Gcjpp54y/LFMrIaINO6sVyLxpqrsQTh0w
 C0EVG412FD3leLDBHEkNqAMOMOe4nN1XgfsQrAWIvGEg6W4g9DLqQ0MZhRWt+Xg0NiE9
 0l2imCPUcD00JPRRUBpM0SNcBb8bHYYrcgLcP5S5jIrvwGyIetogujb5cCpMEpW1P+4Z
 hCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741591957; x=1742196757;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vsKV8UtxL7EJ/fbkRKsyuDdgXGCSLikNxLLxs6vMc/Y=;
 b=ucrTWUHyn7ESesKKBiv86ORO70FUVcrwXqbxfSNPdSrRujfqC5F3ApDz5c+HWUhzbh
 rGSF4CI+J4qUcvtGcu8yFXvusu7aclsP7/WRfVF70rM2MuC1oeaIDkkaqrIqqYShYnRt
 oCwED/li2S43MZc3Wg+rkSaDL03PqOUUkg2t/GHLP6sWQNeC1nA5Q4CXXkd0sztPia2W
 9XFgKn+r/r3wrWZ6zt0pZdJBPHtnn1zFVos9UGiyPAhzwig4eKxsTfC8eXkZlT+1tz9K
 o5PWkDpOhC8+j4wzuSVB7M9EBr1VFJiyZvOHO28Z7sdOyC7ZQssEk4LJU8WLB5Mz0mrS
 oGAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW+gLC1xVnc/QnLkJSETH5oVue9xuw0qCv8+gbhlIXT5DxADt0vC247+gm0a/deozpqc4vUpvFgQge@nongnu.org
X-Gm-Message-State: AOJu0YzXLn/cOtR6nSFzxtsRi8fobrpJ5z5C2+UM7x1K9Pmh/VR414FO
 FaWEDM1xUnd6IXm2Y2X4G4V809XZw5W/k1ydl6oNVzVNYrZfsF+B
X-Gm-Gg: ASbGncvGbd473PBKsu3lCeLn7K2BUz1iWhynzvQrEaQ5gQUhU2W9yfhg6XhEvTpk3of
 RC0+2Au+006wsB7QrfGCdPStGG4drltDMRunWRseyqTwJxodsxEKEP+nUlIVWsdryD0qYshBWnQ
 LbOnLeAWybE5xgjivwTXh5ydw78gJ9ZgQyagah5TiD8M7pWnSPUZnAnFJ8DAyyXI62AU0QGHWwk
 mjBDfCEtPLyujeh1FpLK1Htj3hbweAi4uUxUDBuymun8As5RqghQkEIOoRJZtpDBhOoIG3i8XuM
 K6Kb0OFBAm2h+u0OYAXV6ZTrdT81NgH/azrWTQLh
X-Google-Smtp-Source: AGHT+IHL49eMNWIzTRAwy7O+kWJPrJO8zvqfRYEGYQF3SSQPxuN1dJwy0/RFIH/QJcqNeyYfRiGuKQ==
X-Received: by 2002:a17:903:1c5:b0:21f:1348:10e6 with SMTP id
 d9443c01a7336-22463c6b664mr158407635ad.13.1741591957486; 
 Mon, 10 Mar 2025 00:32:37 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddfb1sm70718925ad.9.2025.03.10.00.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 00:32:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 17:32:30 +1000
Message-Id: <D8CETKZTWQ3Z.1AEDW3H8JCGT9@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/14] ppc/xive2: Check crowd backlog when scanning
 group backlog
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-22-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-22-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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
> When processing a backlog scan for group interrupts, also take
> into account crowd interrupts.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/xive2_regs.h |  4 ++
>  hw/intc/xive2.c             | 82 +++++++++++++++++++++++++------------
>  2 files changed, 60 insertions(+), 26 deletions(-)
>
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 9bcf7a8a6f..b11395c563 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -236,4 +236,8 @@ void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint3=
2_t nvgc_idx,
>  #define NVx_BACKLOG_OP            PPC_BITMASK(52, 53)
>  #define NVx_BACKLOG_PRIO          PPC_BITMASK(57, 59)
> =20
> +/* split the 6-bit crowd/group level */
> +#define NVx_CROWD_LVL(level)      ((level >> 4) & 0b11)
> +#define NVx_GROUP_LVL(level)      (level & 0b1111)
> +
>  #endif /* PPC_XIVE2_REGS_H */
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 20d63e8f6e..c29d8e4831 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -366,6 +366,35 @@ static void xive2_end_enqueue(Xive2End *end, uint32_=
t data)
>      end->w1 =3D xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
>  }
> =20
> +static void xive2_pgofnext(uint8_t *nvgc_blk, uint32_t *nvgc_idx,
> +                           uint8_t next_level)
> +{
> +    uint32_t mask, next_idx;
> +    uint8_t next_blk;
> +
> +    /*
> +     * Adjust the block and index of a VP for the next group/crowd
> +     * size (PGofFirst/PGofNext field in the NVP and NVGC structures).
> +     *
> +     * The 6-bit group level is split into a 2-bit crowd and 4-bit
> +     * group levels. Encoding is similar. However, we don't support
> +     * crowd size of 8. So a crowd level of 0b11 is bumped to a crowd
> +     * size of 16.
> +     */
> +    next_blk =3D NVx_CROWD_LVL(next_level);
> +    if (next_blk =3D=3D 3) {
> +        next_blk =3D 4;
> +    }
> +    mask =3D (1 << next_blk) - 1;
> +    *nvgc_blk &=3D ~mask;
> +    *nvgc_blk |=3D mask >> 1;
> +
> +    next_idx =3D NVx_GROUP_LVL(next_level);
> +    mask =3D (1 << next_idx) - 1;
> +    *nvgc_idx &=3D ~mask;
> +    *nvgc_idx |=3D mask >> 1;
> +}
> +
>  /*
>   * Scan the group chain and return the highest priority and group
>   * level of pending group interrupts.
> @@ -376,29 +405,28 @@ static uint8_t xive2_presenter_backlog_scan(XivePre=
senter *xptr,
>                                              uint8_t *out_level)
>  {
>      Xive2Router *xrtr =3D XIVE2_ROUTER(xptr);
> -    uint32_t nvgc_idx, mask;
> +    uint32_t nvgc_idx;
>      uint32_t current_level, count;
> -    uint8_t prio;
> +    uint8_t nvgc_blk, prio;
>      Xive2Nvgc nvgc;
> =20
>      for (prio =3D 0; prio <=3D XIVE_PRIORITY_MAX; prio++) {
> -        current_level =3D first_group & 0xF;
> +        current_level =3D first_group & 0x3F;
> +        nvgc_blk =3D nvp_blk;
> +        nvgc_idx =3D nvp_idx;
> =20
>          while (current_level) {
> -            mask =3D (1 << current_level) - 1;
> -            nvgc_idx =3D nvp_idx & ~mask;
> -            nvgc_idx |=3D mask >> 1;
> -            qemu_log("fxb %s checking backlog for prio %d group idx %x\n=
",
> -                     __func__, prio, nvgc_idx);
> -
> -            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &n=
vgc)) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
> -                              nvp_blk, nvgc_idx);
> +            xive2_pgofnext(&nvgc_blk, &nvgc_idx, current_level);
> +
> +            if (xive2_router_get_nvgc(xrtr, NVx_CROWD_LVL(current_level)=
,
> +                                      nvgc_blk, nvgc_idx, &nvgc)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVGC %x/%x\n",
> +                              nvgc_blk, nvgc_idx);
>                  return 0xFF;
>              }
>              if (!xive2_nvgc_is_valid(&nvgc)) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\=
n",
> -                              nvp_blk, nvgc_idx);
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVGC %x/%x=
\n",
> +                              nvgc_blk, nvgc_idx);
>                  return 0xFF;
>              }
> =20
> @@ -407,7 +435,7 @@ static uint8_t xive2_presenter_backlog_scan(XivePrese=
nter *xptr,
>                  *out_level =3D current_level;
>                  return prio;
>              }
> -            current_level =3D xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0=
) & 0xF;
> +            current_level =3D xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0=
) & 0x3F;
>          }
>      }
>      return 0xFF;
> @@ -419,22 +447,23 @@ static void xive2_presenter_backlog_decr(XivePresen=
ter *xptr,
>                                           uint8_t group_level)
>  {
>      Xive2Router *xrtr =3D XIVE2_ROUTER(xptr);
> -    uint32_t nvgc_idx, mask, count;
> +    uint32_t nvgc_idx, count;
> +    uint8_t nvgc_blk;
>      Xive2Nvgc nvgc;
> =20
> -    group_level &=3D 0xF;
> -    mask =3D (1 << group_level) - 1;
> -    nvgc_idx =3D nvp_idx & ~mask;
> -    nvgc_idx |=3D mask >> 1;
> +    nvgc_blk =3D nvp_blk;
> +    nvgc_idx =3D nvp_idx;
> +    xive2_pgofnext(&nvgc_blk, &nvgc_idx, group_level);
> =20
> -    if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
> -                      nvp_blk, nvgc_idx);
> +    if (xive2_router_get_nvgc(xrtr, NVx_CROWD_LVL(group_level),
> +                              nvgc_blk, nvgc_idx, &nvgc)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVGC %x/%x\n",
> +                      nvgc_blk, nvgc_idx);
>          return;
>      }
>      if (!xive2_nvgc_is_valid(&nvgc)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
> -                      nvp_blk, nvgc_idx);
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVGC %x/%x\n",
> +                      nvgc_blk, nvgc_idx);
>          return;
>      }
>      count =3D xive2_nvgc_get_backlog(&nvgc, group_prio);
> @@ -442,7 +471,8 @@ static void xive2_presenter_backlog_decr(XivePresente=
r *xptr,
>          return;
>      }
>      xive2_nvgc_set_backlog(&nvgc, group_prio, count - 1);
> -    xive2_router_write_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc);
> +    xive2_router_write_nvgc(xrtr, NVx_CROWD_LVL(group_level),
> +                            nvgc_blk, nvgc_idx, &nvgc);
>  }
> =20
>  /*


