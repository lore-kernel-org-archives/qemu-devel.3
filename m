Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84340F433FE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDG1v-0003M7-GZ; Thu, 16 Apr 2026 02:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDG1s-0003Kn-Ol
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:16:45 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDG1p-0004l9-QH
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:16:44 -0400
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50de80b9567so36757241cf.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 23:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776320200; x=1776925000; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZJQDMWH5ur3qM09o1p0Grix2QSj4F54IGu1BMz5buBU=;
 b=hXGJaiSpZoXOzGZYbWEPADoUunEBEZB7oBIrP+EMZH+UwPf2Z3h9TNFba0dfkCVuOh
 g3uenAGOJV5RDo7jZ0J7hyl+prxRfnD2Fs3rbHfTp7sr5CO0ruNCQqd6cvDlkKN2i+Si
 xUJrIjstEyfVHKlnrt+F7wl3dF7ot1YxFQ3qoKiXioezo+hLFEuvVKxxs+S5R+Qg7g8A
 YQRmwZI3BM53ZujVb4mg5wQZ4pKCADmPZwViZnySqE/T0iOK1dfiKfrKURx4Pvip0mnM
 2mkK71PihbdSEuXXaAvs4YolfNZKETFj24TY+WagtzDixdK30cjfQQIAyoQFM6cfUDzc
 mVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776320200; x=1776925000;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJQDMWH5ur3qM09o1p0Grix2QSj4F54IGu1BMz5buBU=;
 b=IL3pUStAb0kD1jLzwwZwcPWgv6foaiSajbLZ0xFPLn/Y8HlmOzAuAQAqvuRlScRffY
 Ywg6qMZ+G5Ie9N6JtJfr2xbe3pln1yySOi08IRbQ+1+GzyJmtfm/DWvIDWywbeVp9MNj
 AYlzqrMTX72v06easdjNam6M4OGIiZv61lg3pV0LOlBy4k9bttV38noTw9iNy9zddMRR
 bneWgZGSLv2FJSUVP2Y92AoFlPjOziUuy3WSh/a25uupbeFzlPf15pilucyWfB6D43JD
 04sXrvDoM40bbfnEtNJVu2WQ3dN77xm/v3nCRxAgt2pIhm12AGrPts4w5v+3xQLyKbL8
 3a7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UvvdalMWIOO3ekEXEVtRDsyo6mFQHNI3tkvf6kr4RFVu/pFoqysc6o96HbYj90xj+vPixxIbTxuQL@nongnu.org
X-Gm-Message-State: AOJu0YxjJ//bJlh7JWNeQoTQ3WIGu04vvTlgQrRGlYRw9eu/bBTcwUl4
 OJpNoN6f5jfphZbf6WPboBS9ZGtilHaJQc8iKu6u0R0cXQEOaeMFnwKV
X-Gm-Gg: AeBDietdZBYaL0XzuyeIbKhXrILsaqJkEECQWW129f5V5oRpb5z35nExs3JBqbB2lZ5
 nFVQDpQoquspZpkb0Sv7t/6rv9vUrgtEIIiHGzWTYePyhAlLoCipMUHQVJGHlcT/qXEzfVjjYd/
 b2FG+++Qj84mqdMov4Lemjk9vwjUxSrPQm0OyGdo/r4WjZa2bOjxKwiuNlqxC54woxqrZF+SCm1
 Cy80BSoWK0pUSVxloL+4XUYIt1KyQT+U1RtRd6Py186iOV6cHM3lqYgXwwMSd9dI4pFBLtIZ/Ps
 6u+vro0rB1GzWq70T8bKBuifVm0j6n8Y13IqfXkh8JiEVXQODfIS8Rbc4lNIkWhrMKWkeO/6VLq
 AeFK/H+xnvkjGOudw6NCLycXrOyH4hwUDPPX6GAgBhAE3HI1c9jyEruW9IC9TQEB7iI1gCo4XyP
 Bqm9AHJ7ZbtoixMHin+BkZS72XNyYJ/Te174UMRAgjY8rIffEd/dj5azYFZnDCZaId3e3RFtiI
X-Received: by 2002:ac8:5a88:0:b0:50d:84a7:72d0 with SMTP id
 d75a77b69052e-50dd5c3d7a9mr360254601cf.36.1776320200280; 
 Wed, 15 Apr 2026 23:16:40 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e1b016a2asm38379871cf.31.2026.04.15.23.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 23:16:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:15:47 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2 3/4] target/riscv: Don't OR mip.SEIP when mvien is one
Message-ID: <aeB-WjzO_-bpQZ4p@ZEVORN-PC.localdomain>
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
 <20260415233740.3027321-4-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260415233740.3027321-4-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x841.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 16, 2026 at 09:37:39AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states that
> 
> """
> But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
> not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
> is simply the supervisor external interrupt signal from the hart’s
> external interrupt controller (APLIC or IMSIC).
> """
> 
> As such let's mark the mip.SEIP in rmw_mip64().
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
> v2:
>  - Move the changes to rmw_mip64() instead
> 
>  target/riscv/csr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a75281539b..29dd596ae4 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3671,6 +3671,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
>      uint64_t old_mip, mask = wr_mask & delegable_ints;
>      uint32_t gin;
>  
> +    /*
> +     * When mvien[9]=1, mip.SEIP is read-only and reflects only
> +     * the external interrupt signal from the interrupt controller.
> +     */
> +    if (env->mvien & MIP_SEIP) {
> +        mask &= ~MIP_SEIP;
> +    }
> +
>      if (mask & MIP_SEIP) {
>          env->software_seip = new_val & MIP_SEIP;
>          new_val |= env->external_seip * MIP_SEIP;
> -- 
> 2.53.0
> 

