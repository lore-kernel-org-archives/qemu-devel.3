Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456B1CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5xU-0003Yy-69; Mon, 18 May 2026 17:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wP5xP-0003WU-7s
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:57:04 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wP5xM-00029q-5W
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:57:02 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso10750814eec.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779141418; x=1779746218; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VgCvIgz0Xr5F79lfOM3Nv4ex6/IWDLPZm/q336rWcm4=;
 b=mCbQ0RY+/hn+tazXCaS9q+o4p2AvqUsBM6uvacINhXoItC0XgJyE/ZxTKTEiJ++nQS
 TWhs1JaEkvMU0qChWSXY6NKgSmrj3yFMJXw95s3bbP5YhPWpj/JxzunSqs4ut1wV6MQP
 7f8Ov3/7eNHW+tG1pWFoXPMNklhcwxW5C8WFzgx1zF3Z9J/UU8DGiXv/ocyBKxKw0WcD
 273h4cublvhV3TF7hZf48YCnUrtf/WC3zbzpTRYfnugAOUHPTm1Yklap2dbZ1Z0Cn4mW
 zkLQE9RjBYmmHaxM6fM2oaBofKbbZshBW7OLcUyu1kF4142XEwppjeJI8EcneFi5mSTH
 pUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141418; x=1779746218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgCvIgz0Xr5F79lfOM3Nv4ex6/IWDLPZm/q336rWcm4=;
 b=LPwy067Fmc0c9t7hejIeYc1tqrQ/UtC0a6KTCepnVZW8NzExIDRm2AOuyW3LCEGzGz
 Poh7iEFJK7ByEh9+jhFLSva51XTrD3D//tRNKwacMpkHPtabqsMF+0133dpmWWpYvpfI
 a6GiCs8F5dflYvVwz/G2+pR05xmIzTf/wEGU/+ifDRfJZaqNUP3ooLi1xc/XTE3y4Mhp
 wCN+83nQI9f2nbKf76bxvXjWuFKamCXMUQhQds4v2F04oZ0HFU4iiCPYe/8LqigqenL7
 mO/NtfHiPv1FxhFPwJ2fPiMAlW0m+adZJfUI4EPHj0+k4w8S8pBDgW5MeIHxWORlkBvv
 w5bw==
X-Gm-Message-State: AOJu0Yyy07iiKAzf807SxDxFQ6IMVA8cJ+SYs5EgmHlrBsfzVtYAh6V2
 Q/VN8tblDFRulXE1f5WSdzgcj/jS+DOZUVLF3gososIv5suKjniYympz
X-Gm-Gg: Acq92OFfk1LrKTo7SJP2V+oIzEySoXZGFd9VN9ri1CDowjjRf/UGfU4RSMMbHQ4CWlH
 v2QKoxe6nm8EgyJot5MRjynKu8mddaSH0cilfDsWEnZx7ZI3kHSDW8JMb011kMBtVv98xBNvwQE
 NZyVIEdPkZIJSBL/JLyzuYn2uVDQ+c2Y5O9AAHJXiuC61dOsIH+SK1VIH//QnOGjWv44qoY6o1H
 v33U6tWkgKat/YDCpgnTyFFfJdOTDXJCUM/qoPwsMyHqmO8cIc4ImBuc9OaFRM6FBxgJudiT4ca
 WUtkXO3Ey08W8RuzhlrHwysHokzNwLXgMnjk++hk/eNwYUMLfj541VbqorUoLqPMMVnT/aEn4JU
 XIuMOKGrLA8Q5LnwfzskELYY58g0m6bxmIn67JB2wTIfFsFbHDUHzVmYnM1SVfOhFOIWMD0UbQZ
 D5xmtxHiQ+gl51cZ/6LI7l5cmzFiX/bAO/tnYlBEnrPjOiFGATzrLQgqXFRGM=
X-Received: by 2002:a05:7301:6447:b0:2ed:6f94:9d9d with SMTP id
 5a478bee46e88-3039816bacemr8082134eec.8.1779141418430; 
 Mon, 18 May 2026 14:56:58 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978afdd3sm14960297eec.29.2026.05.18.14.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:56:58 -0700 (PDT)
Date: Tue, 19 May 2026 05:56:55 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/4] hw/intc: riscv_aplic: Fix level trigger IRQ in
 direct delivery mode
Message-ID: <aguLERu7U_cWgVLK@ChaodeMBP.bbrouter>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
 <20260428160103.3551125-2-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428160103.3551125-2-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Wed, Apr 29, 2026 at 12:01:00AM +0800, Jim Shu wrote:
> According to the AIA spec ch4.7 ("Precise effects on interrupt-pending
> bits"), pending bit of APLIC should be set/cleared whenever the
> rectified input value is high/low in the both level-trigger mode
> and direct delivery mode.
> 
> Currently, QEMU APLIC only clears the pending bit when interrupt is
> claimed in APLIC, but not clears it when the rectified input value is
> low. (e.g. IRQ source signal is low in the LEVEL_HIGH/Level1 mode).
> The software may receive an additional IRQ if the peripheral
> triggers one after the software clears the APLIC IRQ but before it
> clears the peripheral's IRQ.
> 
> Thus, we also clear the pending bit via the rectified input value in the
> level-trigger mode.
> 
> This change doesn't affect MSI delivery mode. Calling
> riscv_aplic_msi_irq_update() when IRQ pending is low will do nothing.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  hw/intc/riscv_aplic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8f700431114..791e0b01b96 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -591,14 +591,14 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
>          }
>          break;
>      case APLIC_SOURCECFG_SM_LEVEL_HIGH:
> -        if ((level > 0) && !(state & APLIC_ISTATE_PENDING)) {
> -            riscv_aplic_set_pending_raw(aplic, irq, true);
> +        if ((level > 0) != !!(state & APLIC_ISTATE_PENDING)) {
> +            riscv_aplic_set_pending_raw(aplic, irq, level > 0);
>              update = true;
>          }
>          break;
>      case APLIC_SOURCECFG_SM_LEVEL_LOW:
> -        if ((level <= 0) && !(state & APLIC_ISTATE_PENDING)) {
> -            riscv_aplic_set_pending_raw(aplic, irq, true);
> +        if ((level <= 0) != !!(state & APLIC_ISTATE_PENDING)) {
> +            riscv_aplic_set_pending_raw(aplic, irq, level <= 0);
>              update = true;
>          }
>          break;
> -- 
> 2.43.0
> 

