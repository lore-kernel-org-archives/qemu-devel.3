Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1E0EF8FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnov-0001Z6-QJ; Wed, 04 Mar 2026 10:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnor-0001Sl-An
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:07:25 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnon-0001HQ-OM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:07:22 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2be27fa54feso2339772eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636840; x=1773241640; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BXkHLUMB4wpm/5pBeXntmbQSu3l+zR8yn8PB2rCSwXw=;
 b=S7UrUVUgQ9HyCZrfePvMHJvwkyoaSr8isNFU1caDb1uRFJuzNvq3T3HG2WirI3uimV
 vZXT15aVYNXkIw96surcHMAQxVscJijucPIWZoMtIlen8cajCU4tSm9CzzgnNiyqHNVo
 lp13Ct3EvVxI11lFRaLC6PfE5AIZ4XVoSArJShDYQ7NGV3rsmiypICkU0ndH5YF6KdY2
 TuIbOuiL+o7/DfBVG1g3UuYrU/i1yQQhfWoccE1ymMZejpdM03BPP+v+PGFDCq81lZMs
 V41YDodpe7Avez31DGG8V1qxJhqJVoELgZeKQBJBnaXW01J1K4Q/ksEThTz2GrjCvtwV
 Dllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636840; x=1773241640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXkHLUMB4wpm/5pBeXntmbQSu3l+zR8yn8PB2rCSwXw=;
 b=P2W7eSC7k1k049yxzUCJMdhJLJQ/BxM2Tu67l/IYqkU9PuN2zU27F2rGJLvqKtKVgU
 V9OIBx/oHhomiV+JkZgHHUPlnGS0ITNgbfOGTvt5WS+WA5q/KBJGlveIqiztE6+fralI
 iGDG7cuvFlukZFI8SUefI5SGo/to5lscbH9GonHEQD4o/taCN58cyayFMzTdN7IAzUau
 euZnuztQr9P2uBn5c/Pu8Pb3xyPYVaMJyqJe5Vag4h1lp/bTIMUy2QTW2IQzEoF5bliL
 UmSLXnQkmbpjhZhWKPIqLvC/jfhUar8Oa3oHphDXGK1jtCSocxBJU1y2KscW4R1zeNr0
 D1SQ==
X-Gm-Message-State: AOJu0Yxyy5e2gQRb25ZKglJ9rrm/UEQEH79MrzljPIQUjEprI2aYhK2a
 ZTCHf6zy+96Tx/PxsyLeWYmG9gsl7ZYiKLVzLAtaGjyAbV+oQ/PA5Zjt
X-Gm-Gg: ATEYQzzsdsVeinUGwjFTCY6WtkOyZgalP3/cjF4dq21Ycdn3qJ+vH322fVfXxL50uOU
 /a6g/7Nb/XZbR7Ml2OI1mbV65x95NssWL0Wg7YPqpeAZOxYwvxJg+EYZKUfdLZ1AfZtH3P6fU68
 6kcnh6Pfzb9VT4iDqoEOiWHaeXJE8U0p73xTvRUh2Wmv/su15WWQ+jQAR5W0Bq66QfnwLK74L1p
 nEJxJWVC06TQfNGyEDw4BCV9fXbG4W3uRnL88Y/UdhG6wbE8zzGmh0YxfMTW92/MWWK8XVqVfLB
 bEEYScIf7oRAR4/4BBLYv6r9S+Al7cX11xkcNvwjX7kSPGAcmVm8DXhBFupHdVv6rz+M55nucxi
 c8vdDdFqhExoUMuCkaSPN00s2FZdbPW9LMPPFmclBiBRlaWsjaLv3VmJG2+jPjxe4f1vBF+2hNX
 ScrU7mipfJz/5Ic3tDGeCaon5dJTM7BN4mkiXhve00Hk7ugfU9mpfMxpagBQCS49GODLUbjeb5A
 CpBRDBFdfnULsje+XVPB4Zspl8L5nk=
X-Received: by 2002:a05:7301:4097:b0:2ba:6c66:1f0d with SMTP id
 5a478bee46e88-2be30feaecemr742283eec.14.1772636838920; 
 Wed, 04 Mar 2026 07:07:18 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be1ce921dasm4743587eec.10.2026.03.04.07.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:07:18 -0800 (PST)
Date: Wed, 4 Mar 2026 23:06:54 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 08/14] target/riscv: Expose Zvfofp8min properity
Message-ID: <aahKeevfkw0zURrx@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-9-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-9-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

On Wed, Mar 04, 2026 at 09:40:00PM +0800, Max Chou wrote:
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
same "properity" -> "property" typo in subject.

Thanks,
Chao
> ---
>  target/riscv/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1cd74f01b7..9b98e18189 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1382,6 +1382,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>      MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>      MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
>  
> +    /* Zvfofp8min extension for OFP8 conversion */
> +    MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
> +
>      { },
>  };
>  
> -- 
> 2.52.0
> 

