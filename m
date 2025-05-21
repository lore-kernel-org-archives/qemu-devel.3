Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FB3C54ED0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjne-0004YX-BQ; Wed, 21 May 2025 09:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHjnO-0004Rh-Ea
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:47:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHjnL-0005ui-Sk
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:47:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-443a787bd14so33210725e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747835261; x=1748440061; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BBOiVfgZas08fl3qn+nnTypLVgYnx3GqcZbE6zRX5oM=;
 b=ZsD3EJLlm6hwmQkZMRumwZJwFHAvu4VTIqxJjPozYCJ7IHboCXB+/SaLEoy9+iW83a
 ZtOSAVcpTHsagmz7fEGRw12cxWugBDoIZZaQWO3pW2SiYenZ9mVoyDLLVQXUCCtz/qpj
 WfJPFh9wMAL05tNE8nQezil9iH70LSHRZ/xmnAgTsVIedlXlkVauYGsLQYeIXA4wAAUy
 UVysTW+UA3n2WAISPRSz6NnIWizEaOFz2+mukYhC6oaeWkKhF19cPLPogFjXOo7Cpcko
 392xMugbExv2PlBz5QmSb3dTUtZJNhgP6ew0y1XxFDuIj5NVc+fVqZGyxAei1hoxTn0Q
 fU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747835261; x=1748440061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBOiVfgZas08fl3qn+nnTypLVgYnx3GqcZbE6zRX5oM=;
 b=XA3Dk5mdDydN9EL6i21DQlAMLuQVtaIQrlaK7eX1By6JK7AOBmwbZM84WwDDd2RUrh
 feH+j+HakFRuoefhJ6unGkFNn7fh52bVLhb79Or+0Q+EJYUj25HtmrWATeUvdfPcyZAS
 MlSKlZfAZ2LyoBvL9jyrxn8YhVddJG3vPtGbSfQiJajpwiXw1zOZYDWbkr0JwFjLt4pQ
 wfyhozfTg3wedoBo8arvYSvWT4/3yrmxM0A7pakfGUGxCgSSGgq++KN8px4jZTdzfHBn
 cSi6Sdu4+TqPjrJ9QI+dyYV7oexCOIhfHHXj+D3j/pC76qo98JcZlws0VpOS0eJAuS/G
 KUvQ==
X-Gm-Message-State: AOJu0YyUfS8bAmnedKN/RBuTRtz/i6u2A4uU0G5eJ7lb4lz1wNnTefSn
 c+/a4wSnzUXkceeqGmRdfm+eBe4JyEXfhPshmhYJjYg4Wy5QDQs73yRG0tBv92uoL9U=
X-Gm-Gg: ASbGncut8Y/2Gv7xAklFGIUd9tf5DAvjo2u5xQP7+jCDk87HTZcvdGRlG51ghv0kqq1
 LBkzqVABz9hQY+PlofZqivoOKeb89V+qNijqPGIEwAuOqKZHpaZfDIGXGvoSPaV9D/JVzU5y2SP
 CZJ4E4KWI662x/nIM9sGIIkDCIbYsn8j5nbcPtrTjOGhfMomrQQotCwmwdv6I86vTKqRxD590BW
 6L0eiTqVqRDwHxDGCn1ZTz+Db8o6sxetBQpkXc89o4+ddmqAiId8qgnMrD3/TKU5REFn9Lw/BVd
 Gh4g2HwItm09oHazz+B6Jugea1zjkaUrPxdBbwQ=
X-Google-Smtp-Source: AGHT+IE98AEcHT0KoEjy6WHPBoFwVw90DWokR+aTY2+ifwxa3b4Pdqbc3We3Ws+35hCmkbioxxXNmw==
X-Received: by 2002:a5d:5f4f:0:b0:3a3:6d25:b8e2 with SMTP id
 ffacd0b85a97d-3a36d25babemr11010286f8f.6.1747835261133; 
 Wed, 21 May 2025 06:47:41 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3dd99edsm69361615e9.36.2025.05.21.06.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 06:47:40 -0700 (PDT)
Date: Wed, 21 May 2025 15:47:40 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 bjorn@kernel.org
Subject: Re: [PATCH 1/3] target/riscv/tcg: restrict satp_mode changes in
 cpu_set_profile
Message-ID: <20250521-c4e831bfd3149e88193f391b@orel>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520172336.759708-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x329.google.com
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

On Tue, May 20, 2025 at 02:23:34PM -0300, Daniel Henrique Barboza wrote:
> We're changing 'mmu' to true regardless of whether the profile is
> being enabled or not, and at the same time we're changing satp_mode to
> profile->enabled.
> 
> This will promote a situation where we'll set mmu=on without a virtual
> memory mode, which is a mistake.
> 
> Only touch 'mmu' and satp_mode if the profile is being enabled.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Fixes: 55398025e7 ("target/riscv: add satp_mode profile support")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 55e00972b7..7f93414a76 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1338,16 +1338,16 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>  
>      if (profile->enabled) {
>          cpu->env.priv_ver = profile->priv_spec;
> -    }
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
> -        object_property_set_bool(obj, "mmu", true, NULL);
> -        const char *satp_prop = satp_mode_str(profile->satp_mode,
> -                                              riscv_cpu_is_32bit(cpu));
> -        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
> -    }
> +        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
> +            object_property_set_bool(obj, "mmu", true, NULL);
> +            const char *satp_prop = satp_mode_str(profile->satp_mode,
> +                                                  riscv_cpu_is_32bit(cpu));
> +            object_property_set_bool(obj, satp_prop, true, NULL);
> +        }
>  #endif
> +    }
>  
>      for (i = 0; misa_bits[i] != 0; i++) {
>          uint32_t bit = misa_bits[i];
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

