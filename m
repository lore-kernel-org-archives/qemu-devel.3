Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD0FEF8FEE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnwN-0004FI-O4; Wed, 04 Mar 2026 10:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnwF-0004ED-TP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:15:05 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnwE-0003Zc-9P
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:15:03 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1271195d2a7so5800887c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772637301; x=1773242101; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Go1jjTB+N38oyhoxQ7J7NAsBvVyA8R0+bPgdSu3JAqw=;
 b=QuQnLJwDgC4pVa6LjggPks6hYda9Bm9+OiONSLqm1cFhBETGvZj+PTN5oul53gByeD
 6EsG8hiT8NEn6+exNAxrj2isf52lDXIlyzQRqJ2bNLP8PIx/50usMliXBgMfBHiw97cl
 PG/JKyhxQOKQKhZqL0otBx01QrEB1vG8UHVEpLFZ37wf5mhIQLJ2Tq6B/pZvTrDnR4fr
 4e2RfTcp/yUgoMTslz0tjPTRC7h9gWS9Ev/EPlWZen4myD3XiffQhJaFKnoSO5gd9QLo
 VSi0KKq+ygHQlGC8JXLYvzhMQrvm1MoGxG2G7GYJq+fTOp5XOJTr1JWtBm78L1rqrf1X
 eX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772637301; x=1773242101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Go1jjTB+N38oyhoxQ7J7NAsBvVyA8R0+bPgdSu3JAqw=;
 b=PHLSUEwgZQSHy9QIw5FYDEKAQ6l1toRj3Q9fJ0Cc1sHZ63+yiIzzgwc0zbSQMuoS50
 zNPs8gKKQJJGEaaru8Dch8Coc/suVbWQwnpFVI7BQFDTFgV0/8NpJHnCCazTa0Qflg2L
 zHFbUN63+vhxn60M/7q8InEKiyrWNFcXaVItwwonpJL7VMwnmCin/YyoeG6LFAVxhR4y
 yGzSfYCc7ngjAX/KIC0MCuBbFMEzWmu2d7nyJsRBCwAmCg7zKURtXrua185yMXEqr8wu
 hTEfx8n1LaUUDVXnMVeg5v4yMd3JyR26DsaUChJJOEipzurme9Q2h3zFvcM8mljW3Un4
 nAWQ==
X-Gm-Message-State: AOJu0Yz7OqONn2h9Iw7K+wJ6+7VMG9NBmZKBJp8rPCMuB9OoPWJhJ/55
 9RVXYUorLAxcZpze6m38tosFS4eWnT/GlZidND4f4W9w003tMRdGZ+fu
X-Gm-Gg: ATEYQzyPOrqBP+TqH6CYvlfJ9eSjKZmhOW4BIYYBX474HmYrZRwk49eTSB197JSdsDC
 NugumtrRMbyDuDyj4vzBXK/RRpFEBano8rBfAveWrulfUMxKvAzd7+kyGlfIHBVOVQnJRoFV7kg
 dAzdue8tTkQ9CErn7OiXra8DD8gQ+1v3omZvRS42TZpe6kVOUtkuovPwaiY4yLkyYV9Wg6KMsNt
 y8gj5EsmuTU7zmuJNLh79pybpXuiLVKFb6u10EARx/o/LWg14lATX0hkS4jH2qoadYx+tY/dSro
 YRagdjcmw1fUhF/9qvSO5uJyx/bZxHogalPuWQ8HXIlPJAlovMflQ9c+dMUX93k/JElC4R7PT0X
 CnoikMlmNo17MpWoJk+iE0d+qfSjdBEl6/Sdrb4ZQRGENie15iVpzEPBBNcBKZCNZg/45cihtix
 tXc+rabmVlf6OC5k765xUZKuygWWWrqhub5FmHCiG65HUejtG4vnsWei/jeLBxqwFUKRR9Uiq6u
 F17bl3J0MqkTI/pg4CWJsmF9CAQwK8=
X-Received: by 2002:a05:7022:628c:b0:124:9acd:328d with SMTP id
 a92af1059eb24-128b70c13camr1019047c88.22.1772637300697; 
 Wed, 04 Mar 2026 07:15:00 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899dfc47sm22512856c88.6.2026.03.04.07.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:15:00 -0800 (PST)
Date: Wed, 4 Mar 2026 23:14:35 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 13/14] target/riscv: Expose Zvfofp4min properity
Message-ID: <aahMSZixKtDwuwbJ@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-14-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-14-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Wed, Mar 04, 2026 at 09:40:05PM +0800, Max Chou wrote:
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
same "properity" -> "property" typo in subject.

Thanks,
Chao
> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3e655ab43d..8966beed38 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1385,6 +1385,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>  
>      /* Zvfofp8min extension for OFP8 conversion */
>      MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
> +    /* Zvfofp4min extension for OFP4 conversion */
> +    MULTI_EXT_CFG_BOOL("x-zvfofp4min", ext_zvfofp4min, false),
>  
>      { },
>  };
> -- 
> 2.52.0
> 

