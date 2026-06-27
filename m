Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDBEC43211
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdQon-0006vv-5I; Sat, 27 Jun 2026 07:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdQol-0006ug-70
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:03:23 -0400
Received: from mail-dy2-x01.google.com ([2607:f8b0:4864:36::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdQoj-0005rb-PA
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:03:22 -0400
Received: by mail-dy2-x01.google.com with SMTP id
 5a478bee46e88-30e7b4bfbc4so21651eec.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782558200; x=1783163000; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pta68F/rRCRvmpphhDWFEoEzbDOHDGkqpRu9ib2/Q64=;
 b=D4WdH2Rb8ddYismxOFlHmOpaQcmkggSu0+zz3z7PkxxQ4/3wbryRNpEhbf2JwVIB0D
 AVIhAuHLv3XLxqtQjyI0j4YW02AmGMpFwHvDBWTY5fMeCRk92BlYOh6mM/a3fgRE5s5i
 G9p/JO7VdX8SIAOLIFSjFpzMqhw4vMi6+gCf2kvIqWpn3UKRFmZi/1QjULf5v/kErk+W
 kkcrlB/9An9KCnQx8aQO4KTYNQktEljimCUB2PD4AJRgAvTxPjL94CpspoBvjO6OFIFF
 Mp55+NoNHkEIuohNkUP1Mefm9xfMjunUYS37zRkrEMkPM5ruBllj4RrS0R9LKtDgagFU
 BszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782558200; x=1783163000;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pta68F/rRCRvmpphhDWFEoEzbDOHDGkqpRu9ib2/Q64=;
 b=ChrH8qAZp/C3p125/D4ArYGTGLBSwTPS1EpTMu4b+LG33yf46QAtXtgHfoz/JQwFN1
 SauCUsizy3hK8htWeMp8mOmsbiqZ1YK7u0PaZxzje3dhMf6gJwbzq8MVYgb5xk6XQhPZ
 XsEB8nUId40FauRuydLl1ph4wTOYH1Ma6W/2ZJgBIth8VsKKe0xCOdknETPSikMjAvYP
 tGo/AbM7ODJD+M0in+e074F2Fp+eMywOtAd6vhVYIFupUn9Jz3OBFBj0izY02Cumfxon
 R5R5b1VmIKWOoqfY8E94RSGvc7LuFqPs4hUo1FqzX3gWzPZgAYuDE4pmfFlzfmdAfAPi
 1x4Q==
X-Gm-Message-State: AOJu0Yz4yWC7AWKE5sHJcNGj3DW3zCuflDKFs3BDOc5jc4lzojUl4PHU
 3LqfF9mQVuQtMY0G70fTZaANgK39vjoGe0+dzuV6QiaoUL+7JKIDDxnf
X-Gm-Gg: AfdE7clO7v0k0MH1dNGBn23qoc+oyTnrb43TORHj6APiHgdfRz7onxV+ONFJ4OIn5Vy
 lnT1TWZmKWkRXE4+ubE9WBe5+dgjBrdsNhHFsGMVw4Fl7odjGw+pX3t1UL5sNNUsqckAZCfyDSN
 fT9Bfw0Xh1tb6SgbrWdsFamjooZzhh5/VSqJajDLmdy+9DyqgwnSj+9cu4dxRT9PqgE+zKHfMT+
 Q3GaycIdJ6w0qU5//TzrwqiOokrHHfpBB3lxeHCgAydSdboCFSa1afJf8t4Ax3XSQv2hBTFrlcu
 kFaMKf1pedspIaAcaQMYZc9L/1Xppb5Iy1YmaK7j1ZFovSPTo17J8/LXVVjXuGYVKdEoLH+PuLp
 RsTJ8MzGB2UH2Q4oGXFLMGTu0TXk2c0n3T9jHrnNUk1/NTrR07vc/QX0PAR5kSGyHXexkjCIBrV
 jBE/e0snrAIXI+/ddz1EFMhoWNGVdWjkt10NuVfGzbdOE0NvKv
X-Received: by 2002:a05:7300:fb87:b0:30c:ab96:7302 with SMTP id
 5a478bee46e88-30cab9676ecmr3367790eec.18.1782558199538; 
 Sat, 27 Jun 2026 04:03:19 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c6c2sm28956475eec.10.2026.06.27.04.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 04:03:19 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:03:16 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 01/24] target/riscv: Remove unused tcg/tcg.h include
Message-ID: <aj-t6PhcnHXl61Sc@ChaodeMacBook-Pro.local>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-2-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622193141.1449724-2-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:36::1;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 22, 2026 at 04:31:17PM +0800, Daniel Henrique Barboza wrote:
> From: Zephyr Li <fritchleybohrer@gmail.com>
> 
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index bff3ed5de1..4e96bbeb60 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -38,7 +38,6 @@
>  #include "system/tcg.h"
>  #include "kvm/kvm_riscv.h"
>  #include "tcg/tcg-cpu.h"
> -#include "tcg/tcg.h"
>  #if !defined(CONFIG_USER_ONLY)
>  #include "target/riscv/debug.h"
>  #endif
> -- 
> 2.43.0
> 

