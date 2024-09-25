Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F70CF9C69
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 00:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stFU9-0003z6-Um; Tue, 24 Sep 2024 20:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1stFTr-0003nI-SN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 20:02:08 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1stFTq-000426-Eq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 20:02:07 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-49bd7809c84so1992619137.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727222524; x=1727827324; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFPUEkbvjR28TlN73Trl/d8UvcnnBW+povKSboVP7Cg=;
 b=L1TwRUx1vc0oQmNi7rUMWapHkszboUHdFMpNsNeLdP0cjApiWiiygzSRjJPxTdn9bl
 e9UpjfEfZKMgAJG1DelMBTLVRNbEzXBaKAcG82dLvJcBeOyZaowZCwcAJGSBMBJMSrLp
 Ij4pF4HddWV44yz/4gjUSaLnLxsUq19NzDNdt0PitQkl5R0Km/IDtAYFuD17U92cfWGU
 2w3HeapbjXzs2kiQME1p4aFpaPtVqqAWxWNGA0wLX3Lfih/JN3RV31llc6WiWZLsF0v0
 RZlltcpCkR2J6Vo18NCtb+Aiecr0AnvAyXMBRQzAwT9XQCBEwtpHtml4aam/QXu+/Kd6
 j5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727222524; x=1727827324;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFPUEkbvjR28TlN73Trl/d8UvcnnBW+povKSboVP7Cg=;
 b=HjKFAruaJKXxtuCK+cwnb5M+qHjMLweGxb1Cl3H/btRKN6PHyKfxboOJ8Tlh2vNBjs
 a7rg1d19veNcsEFhPGqoozjNhYkegQk9SGEOWZ6tXfdVRDctXxPR1ADotTCIAgSvQJTj
 806VwiFpd/dGGSZ9IhIM9CWCZY1aC4G6RKfaokdh9OPFxukjXfDpvQdG5fXRGgyFgEr+
 v44/AKSWFVZ204qlNo0QuQIdzqhlS8RRDBkrlw8TMUVTICrWYUzMzKOD5IHoMLXayRMe
 R8c5rVdUTzNP2+E7rOJNLfw/4ZSeM8nSXU1ijN08i748NjqCbH14oAsJnrpAHEbzKbEU
 fAJw==
X-Gm-Message-State: AOJu0YwKTYfZhafS+VP9HVOSELiEVPOQlq8gtpvUHN5WS44bOIzJSJE5
 KKvTWWsckLuXYqRtisiPP+HiAPiY3B3/t7orVJ5SfpctwvAI/OiX
X-Google-Smtp-Source: AGHT+IFbAEDrrmp8yqwrJUdACyCvwUiIzrpuYxe84Y8eGByUxuYpEt8gNw1f7UzviQnDdvpA84BT9A==
X-Received: by 2002:a05:6102:f13:b0:49d:433b:a601 with SMTP id
 ada2fe7eead31-4a15dc7ad2amr1341382137.10.1727222524519; 
 Tue, 24 Sep 2024 17:02:04 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4a151763d29sm1496263137.2.2024.09.24.17.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 17:02:03 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:02:02 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, bin.meng@windriver.com,
 alistair@alistair23.me
Subject: Re: [PATCH v1 2/2] xilink-zynq-devcfg: Fix up for memory address
 range size not set correctly
Message-ID: <ZvNS-mQAt1QVIW0E@zapote>
References: <cover.1727008203.git.chao.liu@yeah.net>
 <6b113649cdde1e8938393b859601dfeaba79d9af.1727008203.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b113649cdde1e8938393b859601dfeaba79d9af.1727008203.git.chao.liu@yeah.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Sun, Sep 22, 2024 at 09:24:33PM +0800, Chao Liu wrote:
> Signed-off-by: Chao Liu <chao.liu@yeah.net>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/dma/xlnx-zynq-devcfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index b8544d0731..7170353a62 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -372,7 +372,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
>                                s->regs_info, s->regs,
>                                &xlnx_zynq_devcfg_reg_ops,
>                                XLNX_ZYNQ_DEVCFG_ERR_DEBUG,
> -                              XLNX_ZYNQ_DEVCFG_R_MAX);
> +                              XLNX_ZYNQ_DEVCFG_R_MAX * 4);
>      memory_region_add_subregion(&s->iomem,
>                                  A_CTRL,
>                                  &reg_array->mem);
> -- 
> 2.46.1
> 

