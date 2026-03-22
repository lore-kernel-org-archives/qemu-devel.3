Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A676FC72AC
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 06:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4CY2-0004zA-L7; Sun, 22 Mar 2026 02:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4CY1-0004yl-5X
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 02:44:29 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4CXz-0005Px-Ni
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 02:44:28 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-126ea4e9694so4751320c88.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774161866; x=1774766666; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1bnhlTsB5UucnK03Ih70PNZltznio/11H4/q6j/e0e0=;
 b=aJ3auvPn3t5462aFNIW7ukfOhSsnXIyLHW73J+i0l/r4YqbPZb1rb+mbqgqqUYaSuP
 dPl9Ee4ON6w/c7IZq3QAE9pKrhbSRfUueshVNkY+kcCOFl3GeuryfHjnlOWx6oU0W5y3
 5crjYxapZ8/I+sY+49KYECHFRuJkf1oMPJS/6cHiFf2EYt2K9JhHEB+YX5jJmkfR9/Sa
 pYvfdXyPMWXCI+m4Aq/RKoi1bHxqTjOaz2Dpu2c4ejvXjfMSUTzCtAYzrwTmo/MZCZs7
 vUiSQW90PrIQB1tTEntQwYjU+eSR0iZ3dh7GdiFOKfmooTc+aL9iugnJ1+ot5a9DTaZW
 q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774161866; x=1774766666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1bnhlTsB5UucnK03Ih70PNZltznio/11H4/q6j/e0e0=;
 b=osQ61/hFWBDDjSz+WLArXm2SECdkQWuLuhHU76JR8/EXrFM45d1I2Cfh8DjDY3RrEF
 1y0X3dQ3ubknh6A3oNRYZZpCU5zqrUc5cFFxBXWF2RGCOlzFB70K29Eov00j8as7G5U2
 LcgVkGlcAbeaAKa/e9cxgDSJ6qwqxAUT4uuuFGXEsb9QHeu/ZcTMoXK7mbpObwwqNIb8
 lPVq3BSBn9OfRnMyz7AJ3nxkEN7JwauxSB+UclJifdJQj0dNQepwfoMTWoz5JY2YaBli
 oUc2puCjLj0gt6WbjhBX29rQtYJpFRusw3fmRiB6SGhzWYT25oyTN7Gmy0baxOQ41Jkm
 zaHA==
X-Gm-Message-State: AOJu0YwaCqAd+kbNUodWA7sPOzoG5pJ+jeg7CWW5pdlhrECsHHoTAZTA
 xG2mU2BOnf+JZyePFqAJoy09s9AEVLEmMARugXER+nZVamGv+oKz9Eve
X-Gm-Gg: ATEYQzwTPmUYjhegh4UfJ6gGb4+bKoQF9MOixnbxVthACFDXSecRSF7pwAtGvCQA/6L
 7afUSJskw6LedJ34JUr/JGPjO/ZIhhpfebw3yWvZeUV8ZQU0hnx6Ux30CuF/740m+x9k3+dtOi6
 IXGCpAStNNmOa4PbnXa+8jhWiNOdWJkb2j2W1SFtNH7hZANso6OWI+p/qAlC3eChFRI8MqfyujJ
 YKFLEsUCf4zX2wwQK3hjWmBOpJ6F3a8b9Bd5PEG4+eTLGn48FReAuUrrQS59tPzvYc7PcrfcNp1
 nyIjF/pOEjKeXukAmyiaDQRiMuyJ000CLr/TDJHJ6sJBKDmoDM4fGDJWwpKsd/QC+X9WcPVcpC3
 UTCmZYN8kY7Z2lsgqZV0cZPVh9V4SgNR4zF/DQJx5uCTV+m+R0QZrwmCTTp3itqfw8kFfGiHO7a
 ETcs7bpEVpjJQASFkSbl7WHio1DO9M8pOR8z58oWhQChRWtCT2zW7Cb0nk7AB5ld3/WLvc8nmgT
 AGYtbQERFS9MMFJFOKh5sXX94TL4qx4/TmMlrGsDw==
X-Received: by 2002:a05:7022:6713:b0:128:d6c3:9b23 with SMTP id
 a92af1059eb24-12a7265fd74mr4711262c88.14.1774161865547; 
 Sat, 21 Mar 2026 23:44:25 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a734bbb57sm6838365c88.10.2026.03.21.23.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 23:44:25 -0700 (PDT)
Date: Sun, 22 Mar 2026 14:44:14 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 3/3] linux-user: riscv: Fix signal frame user mapping
Message-ID: <ab-PsVKa48NWJCTO@ZEVORN-PC.localdomain>
References: <20260321004836.500390-1-npiggin@gmail.com>
 <20260321004836.500390-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321004836.500390-4-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Mar 21, 2026 at 10:48:36AM +1000, Nicholas Piggin wrote:
> riscv signal frame setup is missing unlock_user_struct().
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  linux-user/riscv/signal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 358fa1d82d..22b1b8149f 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -126,6 +126,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>  
>      setup_ucontext(&frame->uc, env, set);
>      frame->info = *info;
> +    unlock_user_struct(frame, frame_addr, 1);
>  
>      env->pc = ka->_sa_handler;
>      env->gpr[xSP] = frame_addr;
> -- 
> 2.51.0
> 
> 

