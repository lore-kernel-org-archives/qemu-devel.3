Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E958C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0XZ-0000lO-Ba; Fri, 28 Feb 2025 08:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0XN-0000kF-FO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:36:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0XJ-0003fa-U1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:36:19 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390ddf037ffso1025474f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740749776; x=1741354576; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NiylF7DDBrCqHbXNyp2vlxY3jw6nLEyjJ0OpLQNpyVM=;
 b=nQSJBWFVKjD3YTe1yaB6UnaqGBJV3VELwo1dKvlZNZFsfFCtsW+2aPx4502ltCZ/We
 +ntBhP9Q3TU+uUz+AKrkO9g/jIC2Y+Z67eoAwiz9bkIbIf5kq9AGnYTotGQCiBiaSvM+
 f/ju3iQUs8zHxWIsjzgDm0m7JR4v10sGT/p/8BfS+FVub/BS2QMyZUVlgtzPOUpsJVER
 v9xr+iQkM9L16ZdzqDXjCGjitD5PLHh6C3Yk/stbjyL8F4TR1OD6GfiermCJyCTmHe/I
 z3fj952/o9NnTeezfu3vNpB/asXW0v9YI0mCRfn5ArNeFVvvdzVn7r4a9pq10v4OXU4l
 iX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740749776; x=1741354576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiylF7DDBrCqHbXNyp2vlxY3jw6nLEyjJ0OpLQNpyVM=;
 b=HcOKVDWWQjysA5ipU3qyi3eZiZbUnItnMtoCtYomTpV8YCtBBCs7xh62KYwtnYW4cl
 4B5M6GqRYsw1zORF1LFeudUmsggljupiSXrAaJ6w8b8PJXR0xht7yRSzr28axnLIap/7
 GoRHJKaBEuGx9k6n/E0B5JuCyRIOWtKWsv3AE8AZVj+saKe1p45dzzf0qROUivTT0r84
 uY52Z3TRmDcdwCum4gHt1Bw2upak/cObmAq1PihdjN5o8yZNXydBRb+JRyNPouRbyz9R
 WDurfG6wZK9N789vVlYf8PxrncYwnVc4xF8vho3S610WA4P/jZVyWTtTQux2n1wR8Thc
 b5Rw==
X-Gm-Message-State: AOJu0YwUFJhnsQJ+tc7iWeA5l9Cv4VnqnoIzf1eOJRHve1nud+Wnquvw
 ZZrbmZ/vtx6QBwmZ9RWAv+gbPm9Q2X79SA2+OsNpGqtGK74rHsjOEqftJ69vpR4=
X-Gm-Gg: ASbGncusB83t2R4fsLvPJQDjE1U5ELwghWSLITxveDYAqwZBaaTtEfWIz2pBLd1OPbI
 DvHpy0ED37psuVsGNbwczYOhQ974z+sVS8RxkP/1BqUrJEW2R428zT8dgYGGSiWHVm6XWjO99SX
 gHdqL5F1RrF0ASziLqbEkwZf/YR5nZBUe9+m29c/BxV+i3OrV2fW5j68/m3YsB6dNc0I6bj5Zmb
 ctGqTjIt6VzzWWPZELQnH44F9lqPrRfVyZhJPrbIWTA4GQkU1IZMHQwNNenSQSyXOTffyU+EqO1
 83ogFsbSkUtUqw==
X-Google-Smtp-Source: AGHT+IFfX1v2E4YUyQ4TD1Hh6qZ7Q7v7ZedJsV6bHAPKMzupIF5/s10LpmmqsoIY23MFEsiCw6USbg==
X-Received: by 2002:a05:6000:1a86:b0:390:eaae:b502 with SMTP id
 ffacd0b85a97d-390eca35048mr3729871f8f.39.1740749776259; 
 Fri, 28 Feb 2025 05:36:16 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7cdbsm5381648f8f.54.2025.02.28.05.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:36:15 -0800 (PST)
Date: Fri, 28 Feb 2025 14:36:15 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 8/8] hw/intc/imsic: prevent to use IMSIC when host
 doesn't support AIA extension
Message-ID: <20250228-70b318f083760cd552b3fcf3@orel>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
 <20250224082417.31382-9-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224082417.31382-9-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Feb 24, 2025 at 04:24:15PM +0800, Yong-Xuan Wang wrote:
> Currently QEMU will continue to create the IMSIC devices and enable the
> AIA extension for guest OS when the host kernel doesn't support the AIA
> extension. This will cause an illegal instruction exception when the
> guest OS access the AIA CSRs. Add additional checks to ensure the
> guest OS only uses the IMSIC devices when the host kernel supports
> the AIA extension.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  hw/intc/riscv_imsic.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index dc8162c0a7c9..8c64f2c21274 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -375,12 +375,21 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>  
>      /* Force select AIA feature and setup CSR read-modify-write callback */
>      if (env) {
> -        if (!imsic->mmode) {
> -            rcpu->cfg.ext_ssaia = true;
> -            riscv_cpu_set_geilen(env, imsic->num_pages - 1);
> +        if (kvm_enabled()) {
> +            if (!rcpu->cfg.ext_ssaia) {
> +                error_report("Host machine doesn't support AIA extension. "
> +                             "Do not use IMSIC as interrupt controller.");
> +                exit(1);
> +            }
>          } else {
> -            rcpu->cfg.ext_smaia = true;
> +            if (!imsic->mmode) {
> +                rcpu->cfg.ext_ssaia = true;
> +                riscv_cpu_set_geilen(env, imsic->num_pages - 1);
> +            } else {
> +                rcpu->cfg.ext_smaia = true;
> +            }
>          }
> +
>          riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
>                                        riscv_imsic_rmw, imsic);
>      }
> -- 
> 2.17.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

