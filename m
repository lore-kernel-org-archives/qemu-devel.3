Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E67C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVBv-0006X5-Kd; Mon, 24 Aug 2026 09:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gsh517025@gmail.com>)
 id 1wyUtX-00075V-Os
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:39:24 -0400
Received: from mail-pj2-x02.google.com ([2607:f8b0:4864:39::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gsh517025@gmail.com>)
 id 1wyUtV-0003d7-6Z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:39:23 -0400
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3896ccc93b5so1086561a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787578759; x=1788183559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iBfWpMK7crx3Ube8UEJKq2oVd1VT5v0FXx0Fr5U2ZIg=;
 b=kFfb+l/8ZbTCBJrKm0P1L/nCD/KPIEVXFu1+HUF6ZdNsfFn5L+NX0+P1Euh3SbrcFq
 YWSArHQgQJGN1aoaahoHOKoBhH/thSeNikfjWXwHD/f6UrBi1wDaUljJn+bUYc6LKrUi
 sR4JXdJh05e1+Ejl8GsvkZLmE2tvGmyZTetIN2cORvCh98UXFPek9Imu565JabXLZZKz
 UhCY1SkR7SQeQ6HukfENb9y3yLJjehzwSG6Kg1FJpGEqn0cwzjeflO/qXReD/FEvVwbk
 nfQzHROYR1EkOWpM90D+2ouWw4Jw7jLy0/OIMwFKBBkczNJrna1QEOkXnnTTdZA6ZwHH
 6EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578759; x=1788183559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iBfWpMK7crx3Ube8UEJKq2oVd1VT5v0FXx0Fr5U2ZIg=;
 b=XQMms33QSvMHg1/zlMr4V/+Fd162+78VFhxY3nyLNpqxrk/JxQpCcodrTXJ+3j13gP
 ZUsHA6TRqAAh90vIZSenK6Tt1r5ADmRC8MAmuszvX/ZfBWnW6aoxVi+z8bCvjYjgWuSr
 q0UyzVx0m1iZptZCYfNFiDT6SCTKaYK2KzPHrW5xtmmO1mICIGdk6ti8M1ajKB5WH1uK
 gn8X6rhrbpe2aw5fLhXjat8ju4aq5dyKWNGZOi/4gCmBeAwpaXfWrd94EWrp8N99ciIQ
 +vSkrbLD/H2wq9tdL0pduomPUU69QHonvrTLQ9Ckf4qPMW4an8b17aV1yxcjWGFnnIs8
 KDQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmUjLCqaxGtsnhk6tC8pGmhX/M9zXCL32HW7sUHLiv0q/3gY5+CamtQmb4QRff2Yb85x/qtrMQJjtb@nongnu.org
X-Gm-Message-State: AFuF++kFdIi7KAbyjNGvZZKDOB8w5NeLU3TKniXyZz4mAHimqgXbu5lw
 r6vu+c7h/A+x8nprNGfqX6e61QrJE5SzMrezD4dsOBongsH6OPgd2Byv
X-Gm-Gg: AR+sD11/OlsCQTMae0soAI8mkP0xNaekD8dUVO0d5+m1w0nbNPP5Ocr9Qb1VH05o/7Y
 XUUsquqDhohz8IrN82+eciutTL5/jFmHD1mOtUE9Dbr2dFXxeW1axtDXKxs5QddLWD/uwmnjPBG
 lBaGDoavKBj8dUbbsgktAWePVKfOyUrL+/I0ZRbL2h+njBKiRaxQCcMBXK1ew6hwt5yfOjGlORf
 q+D+Ht2ZwTKlO/5MGk0oBboP5U0ieEUkC4RwebXT6EK6FplUGdR9D+ChIuYFBCPznfmNphouvd3
 rW9TgKfst2i+ppBJlLBR/HhXcHvXSN5Bp/vmJ/wLYdZKmZMbEeZbNLFY4Sdkr74jKwNW/nNHh1c
 7QJ6boRPKcaD9VKCucZFgn6zeZUC0i6z6W0pouuLHrGw0Bqz/nEiOozCNxsJJhn+LoxG75wqfaj
 M1kJeyLlT09iWYx2caPAaNSr+WMJB6eCHgqBYoAMo+surlac3oH5tKtM3dfugQa7btJS3DEzRVk
 26ksmHnq34=
X-Received: by 2002:a17:90b:1b03:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-395c39cb2damr41595853a91.13.1787578758727; 
 Mon, 24 Aug 2026 06:39:18 -0700 (PDT)
Received: from localhost.localdomain ([111.199.63.164])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4b240e7sm9963126a91.13.2026.08.24.06.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:39:17 -0700 (PDT)
From: Gong Shuai <gsh517025@gmail.com>
To: mayuresh.chitale@oss.qualcomm.com
Cc: alistair.francis@wdc.com, chao.liu@processmission.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 gong.shuai@sanechips.com.cn
Subject: Re: [PATCH] target/riscv: Fix LCOFI masking in sie/sip/mvip
Date: Mon, 24 Aug 2026 21:39:12 +0800
Message-ID: <20260824133912.8475-1-gsh517025@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
References: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2;
 envelope-from=gsh517025@gmail.com; helo=mail-pj2-x02.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Aug 2026 09:58:20 -0400
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

> Commit 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
> dropped bit 13 (MIP_LCOFIP) from the supervisor-visible interrupt masks.
> As a result, with Sscofpmf enabled and LCOFIP delegated to S-mode, the
> overflow interrupt would be raised in mip but never delivered and hence
> perf sampling stopped receiving overflow interrupts.
>
> Re-add MIP_LCOFIP to all_ints, sip_writable_mask, mvip_writable_mask
> to allow it to be writable again.
>
> Fixes: 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>


Hi Mayuresh,

I applied your patch on top of QEMU v11.1.0 and it fixes the perf sampling
regression.

While the read path is still inconsistent with the write path:

In rmw_sip64(), the read-back mask still truncates the result with
(S_MODE_INTERRUPTS | LOCAL_INTERRUPTS), which does not include bit 13.
As a result, sip.LCOFIP always reads 0 even when mideleg.LCOFIP is set
and mip.LCOFIP is pending. This contradicts the rule that sip[i] aliases
mip[i] for bits delegated to S-mode, and it breaks consumers that check
sip.LCOFIP.

Would the following one-line change be suitable as a follow-up?

--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -4378,7 +4378,8 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
  if (ret_val) {
 *ret_val &= (env->mideleg | env->mvien) &
-            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
+            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS | MIP_LCOFIP);
  }

  return ret;
}

Thanks for the fix and best regards,
Shuai


> ---
>  target/riscv/tcg/csr.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index c05c8ee076..ca68c1f5f1 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1890,7 +1890,8 @@ static const uint64_t delegable_ints =
>  static const uint64_t vs_delegable_ints =
>      (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
>  static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
> -                                     HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
> +                                     HS_MODE_INTERRUPTS | MIP_LCOFIP |
> +                                     LOCAL_INTERRUPTS;
>  #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
>                           (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) | \
>                           (1ULL << (RISCV_EXCP_ILLEGAL_INST)) | \
> @@ -1936,11 +1937,12 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>  
>  /* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip. */
>  static const uint64_t mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
> -                                    LOCAL_INTERRUPTS;
> +                                    MIP_LCOFIP | LOCAL_INTERRUPTS;
>  static const uint64_t mvien_writable_mask = MIP_SSIP | MIP_SEIP |
>                                      LOCAL_INTERRUPTS;
>  
> -static const uint64_t sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
> +static const uint64_t sip_writable_mask = SIP_SSIP | SIP_LCOFIP |
> +                                          LOCAL_INTERRUPTS;
>  static const uint64_t hip_writable_mask = MIP_VSSIP;
>  static const uint64_t hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
>                                      MIP_VSEIP | LOCAL_INTERRUPTS;
> @@ -3953,9 +3955,9 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
>       *  alias_mask denotes the bits that come from mip nalias_mask denotes bits
>       *  that come from hvip.
>       */
> -    uint64_t alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +    uint64_t alias_mask = ((S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
>          (env->mideleg | ~env->mvien)) | MIP_STIP;
> -    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +    uint64_t nalias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
>          (~env->mideleg & env->mvien);
>      uint64_t wr_mask_mvip;
>      uint64_t wr_mask_mip;
> @@ -4188,9 +4190,10 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
>                                  uint64_t *ret_val,
>                                  uint64_t new_val, uint64_t wr_mask)
>  {
> -    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +    uint64_t nalias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
>          (~env->mideleg & env->mvien);
> -    uint64_t alias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & env->mideleg;
> +    uint64_t alias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
> +        env->mideleg;
>      uint64_t sie_mask = wr_mask & nalias_mask;
>      RISCVException ret;
>  
> --
> 2.43.0

