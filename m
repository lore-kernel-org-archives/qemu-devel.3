Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEABEC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0Ky-00082C-0r; Fri, 28 Feb 2025 08:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0Ku-00080z-K3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:23:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0Kt-00027j-0k
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:23:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso21932875e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740749005; x=1741353805; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uF28SmLvpKTiy/3tp5O3rNCD+UYk3IysiMDNvDKQH+8=;
 b=PvsRTwj83l1OEYtBNv1mToHI6Skl72SvS5A2bhbVfqp2Vxai1SBkkd1rt30zcb5ysG
 GPO25GDVUcVCnxPFuvT30S6vg36Gu6IsuB/bNY0nTlFsDV/2qoaQyJXPW8ftzeKHHlCX
 lNDWndxNBKOfGlGxxbUEeOxybZSwDi3k2Uxsr6GLIfSXgeAoUePM4Q6FBkQPjW2SVl0s
 n6mG4NJYCq37Yi0P7pEQazhnB8J1PxL/e9hR7yvusN/P4jPISRYYUohIn439rXBBnQOF
 uKja1QP2MydZIz5Jdf6sK144ZIE66A4YsjNiGIQbx21KGPaPIalLHFhIkY/FrY8Bjamn
 F5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740749005; x=1741353805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uF28SmLvpKTiy/3tp5O3rNCD+UYk3IysiMDNvDKQH+8=;
 b=ToS9ntT5sMyR4cZdnhJYONqN0iqGIbAXAy9NcLvQw9s4tutnkKoIThnk8bqYlH+pih
 ccOpGUCANjMQS7UNnf4dyv5fVy8sl4lLnB3L4yeuksSuB6ktS2LavnJtqqZEBaUAPStM
 TwAE8A82l+ZrwmqRwaoC34Pv1CBzGATt0Yz8G2S3DgOsk0HSNXTN+R9XzqbYtD0tkaw0
 ykdVIzlipopSIM52ij807EyQt8kPLRI8bMyzUXZvO4rMXipHjDA4dUfQLIXNYDoqkSll
 cF1SvbzED4FCj2DBEkg7JmUMfvY1rIOGEzO6FcT+wVaiYm54l5yjLIZ+l/5sGmORfRad
 o5zA==
X-Gm-Message-State: AOJu0Yyy1elY5E6LeX3InT8GMeHWvAfZyYMe1vhvWBHggeKrpvlD0ffm
 3DNwEzZUMWwKZfmfjv64os1LLNlRau9hCLi4RYXHoB+E6F3E/vB0p8NwydXdYm/m+4evhlDUXpJ
 a
X-Gm-Gg: ASbGncsSMXrtXITQL79Tz/Y1tqT7Fp8a4m6m0X168pKSP1Lx5qVPY27Q4hVsb4cAM0C
 6elSxiZmpi9QfLEtprOQxhxuEeRyyz4fOSZL5YljHZPfJaLv0/IpASMjwwM2RKGvbEZiwsK9i5x
 hrM+NXZnjmkDmI+ILNSUsTB8+qjHs0kHjtGykqCxy/SYzbaiRfeSFWUOcjXs4OclZaxy9NPpfgD
 uGo9WZ9u0tO8hs6J3/c+/C3ymsmJP5b7US04yV0s8WZgeKoF48H7n6CaxO71iMZOZV2ggjhzdkl
 WZrqD04LM88sVA==
X-Google-Smtp-Source: AGHT+IFKFcOGD6WdRuG3rbltcnd8AQCdtKslYX7qnuN2EGn9aSIZZsCRi8LvR44ZfdgGVMUZh/EuwA==
X-Received: by 2002:a05:600c:4e92:b0:439:94f8:fc79 with SMTP id
 5b1f17b1804b1-43ba665be43mr37995565e9.0.1740749004339; 
 Fri, 28 Feb 2025 05:23:24 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a28bcfdsm56400305e9.40.2025.02.28.05.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:23:23 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:23 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 4/8] target/riscv: add helper to get CSR name
Message-ID: <20250228-91bf13b18026d1640fd75255@orel>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
 <20250224082417.31382-5-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224082417.31382-5-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 24, 2025 at 04:24:11PM +0800, Yong-Xuan Wang wrote:
> Add a helper function to get CSR name from CSR number.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  target/riscv/cpu.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 616c3bdc1c24..df10ff63474b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -920,8 +920,14 @@ extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
>  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
>  void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
>  
> -void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> +static inline const char *riscv_get_csr_name(int csr_no)
> +{
> +    g_assert(csr_no > 0 && csr_no < CSR_TABLE_SIZE);
>  
> +    return csr_ops[csr_no].name;
> +}
> +
> +void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>  target_ulong riscv_new_csr_seed(target_ulong new_value,
>                                  target_ulong write_mask);
>  
> -- 
> 2.17.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

