Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE8ED0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvBC-0003zs-LM; Tue, 25 Nov 2025 10:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNvAv-0003vm-TR
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:41:58 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNvAu-00089L-EM
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:41:53 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-429c5e0f94eso678446f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764085311; x=1764690111; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thHGVS1dOYmPbft65fNyCv35oJsHz7Nljul/aFRaC70=;
 b=LhvYtXx6QTQqMZmegtv8cGalMHwR4HjMB91byLHEjpmw8mNCkWcc11Kedpo/PhLNZd
 ct/7fr4sMr11NXG5cUraRImQswH3juzXMPzPXpSwzxGRMEN+JFQHC98ODoNuCFwSXAU7
 b3teE7jyL1nLcM3AgoReyPgsaWaMlW7peJbKqGQHJjqDlwuEhuXTL3IZege4sSaHle8U
 tORGDmrCi30Czb+cKMaIAVEsTd0btGFAuJwpEp55l7jFq8Zl1QNJDWfmH2wrp9EvbhFQ
 YhbMzWFHrsu3fdlaFy+GUxycYRmU55oOFKfTNeVmTaWyhtc2+b3IypvunccCWO9Jvy8b
 j59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764085311; x=1764690111;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=thHGVS1dOYmPbft65fNyCv35oJsHz7Nljul/aFRaC70=;
 b=a69zHEEdPhn1pbEtgaJDyalAUX3vkoXFDQMp8Y+32hGembljkEvQL1gvq20Aqg1w2S
 yhi91WuThYOzC55OqrIlIeHKLpMbS157ql9rMD88uVZIcQk6yZxBRJUdZ3Li1KQD4nI6
 V7niwDZDckRpRLiOCkW20p1XHn3DxdoSa8pnyABLQLk8ODr4hZQmWDWSGtTyJS0U+3B2
 qr9OzX+1JS9AfekTzl4LA69L9BpbgdMX9qv26vpxD719vTcFIqUX75grl/tYm8aqysJk
 R2ff5fOF+LYfheKxbznhsKK+dg+/B6sKIBA2rRWNyzOTE+BGVmBafudO1H9cG5YeGq14
 ul9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoxgDwDAfHiN6FhLajwfRYytRthcBvO02A61x+Zc0xsVuP9nN6/q2vh2OK+RQKVYZQLoAvg3x8LFYC@nongnu.org
X-Gm-Message-State: AOJu0YxTH0hUHSVCegOUYDyCW3TKBw76gX3BVrvGJjKE6YrWUU2LzvFm
 i4z4mE/MJi3SA7ISupem8S3/q6wz1g3ExJgsXOI1bOms1ftg7Syz0wyGkyoUj2+NTq4gVz8GQay
 BGaMuiGc=
X-Gm-Gg: ASbGnct8ELZhUI8jlds4k98dYm6JeQZ7e0GJngAL18AjPth0fdn5YruJJhleFvktAKX
 DF76XoIEV7iwNMgWXs02MNvtKwC2E8EIorBSrIJiH2hbhU2YJz+SEwoUUhJymDkPY5RtmwVf9Ez
 UK5nOJbgdgajS1mozgey0wZN2nwSniSYbYlLxvFU1bPcTM0PRPYm+RGDMRl4SRiwTVgx664WK0m
 UNpCWs0li0WsbWnGpm6Gc1EiLdr7GLABLTlkd7tUFcqUOlTNN4opemSvN8FWTrf3h0DVg5mUPB4
 Yuu14BpRI6sq2zwdqywYin5hXsa72Ohi7VYVGwbUpqfWEYZoC6yfZHHIB6xD5X/SSUhUuvWMpTX
 3z5ObE67h/69JhFGzFZ/BJxG7n4nBltm0TdARr48GWBhGYrGWW0S+710Tzr6q
X-Google-Smtp-Source: AGHT+IHKJ1VeTxCi3ox7jLJaMQuJH5ch/WE3EqXNPzeKpqUuywYs8foD5toXmuMI3wanWIAMepK+Tw==
X-Received: by 2002:a05:6000:18a3:b0:429:8db2:a3eb with SMTP id
 ffacd0b85a97d-42cc3f5f86fmr8981525f8f.4.1764085310637; 
 Tue, 25 Nov 2025 07:41:50 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7fb9190sm34926895f8f.33.2025.11.25.07.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:41:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 16:41:14 +0100
Message-Id: <DEHW1F7RHFOK.D3Q27MSWY4OI@ventanamicro.com>
Subject: Re: [PATCH v2 6/6] target/riscv: Fix pointer masking translation
 mode check bug
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "open list:RISC-V TCG CPUs"
 <qemu-riscv@nongnu.org>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: <frank.chang@sifive.com>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
 <20251121050413.3718427-7-frank.chang@sifive.com>
In-Reply-To: <20251121050413.3718427-7-frank.chang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-21T13:04:13+08:00, <frank.chang@sifive.com>:
> From: Frank Chang <frank.chang@sifive.com>
>
> When running with virtualization in VS/VU mode, or when executing the
> virtual-machine load/store instructions (HLV.* and HSV.*), the type of
> address that determines which pointer masking rules apply should be
> checked against vsatp rather than satp.
>
> As a result, sign extension also applies to the virtual-machine
> load/store instructions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> @@ -286,16 +286,27 @@ RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *=
env)
>  #endif
>  }
> =20
> -bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst)
>  {
>  #ifndef CONFIG_USER_ONLY
>      int satp_mode =3D 0;
> -    int priv_mode =3D cpu_address_mode(env);
> +    uint64_t satp;
> +    int priv_mode;
> +    bool virt =3D false;
> +
> +    if (!is_vm_ldst) {
> +        riscv_cpu_eff_priv(env, &priv_mode, &virt);
> +    } else {
> +        priv_mode =3D get_field(env->hstatus, HSTATUS_SPVP);
> +        virt =3D true;
> +    }
> +
> +    satp =3D virt ? env->vsatp : env->satp;
> =20
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -        satp_mode =3D get_field(env->satp, SATP32_MODE);
> +        satp_mode =3D get_field(satp, SATP32_MODE);
>      } else {
> -        satp_mode =3D get_field(env->satp, SATP64_MODE);
> +        satp_mode =3D get_field(satp, SATP64_MODE);
>      }
> =20
>      return ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=3D PRV_M));

riscv_cpu_virt_mem_enabled looked generic, so I got scared at the
beginning, but it's luckily only used for pointer masking.

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

