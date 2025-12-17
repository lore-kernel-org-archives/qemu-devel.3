Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7135AD65C40
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwoF-0001UQ-5n; Wed, 17 Dec 2025 14:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwo3-0001Qb-Fa
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:03:30 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwnw-0007Wc-VT
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:03:25 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7e2762ad850so6467715b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765998198; x=1766602998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UWzPKBCSNbPIqw5vrlcj/BwPaO/htNHgS+VUq1+3R5s=;
 b=BEZIGHp7XqhLUtDN923PSJ8cNCG+8z0gZGcUnQ2IV/JvOLCR68HkbcfXkvYyPLdejN
 0wqyomvNFzjLVkEKODIxkvee4LjargadMqoMYQGHxriw/MIH8rhFIree4ui2IcALUgP4
 zOgUUB9lLHu5mCAoF2eW/rIkKUcghh+REPNiX5Y8MJzN1bISdbaHQcXlWhkv0ElfLB/F
 8PX41dn9/kwpq/zZnDDSAYs2xPDIeM4hhzpP/OW9LJ1EAbFsdH5JG0k2mIBM47Kgqqwo
 iR3VJdmBqa2Y2RsN+bfvckxw/hsef+y/mFpRftQ+XP+pT4XiosioJxJJulwZV3FV7C0D
 Rgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765998198; x=1766602998;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UWzPKBCSNbPIqw5vrlcj/BwPaO/htNHgS+VUq1+3R5s=;
 b=XRq6f2gncGSxIv33AzAWaARBNHGH7b3OasQ+5baYW6cvX7dCpXgNskBghREgUsasj6
 +5TCxXW4GGKI9qsCn0LUJXB9cfjzGaNlEY+sbTHzS/ZxzTheHhTM1j5+9PSm7wZANIT0
 ZI7fJmYmVat0uJQkjOKgDttO8sZrjv7dog603XXCgz0xPkA01YiF7trrM/LUC3D0Vslx
 CJS7EQNiPXdPv37bifzqAMZ4ltCMZYDlw8RFhsncPJ7NHRihLYEw+sIDWqjK39U/M/s8
 0noX3Ltq/Oi8/CJ5bz5pfqyqrS3Q0JDcf4LgzX5zvcC/XoPDQM2q6YrWyNsncicM/ymE
 3rGA==
X-Gm-Message-State: AOJu0YyZreVQy4v9eNigPtRv6aZUPNPbSPxD8ADb51xRtGlfAkntO/5J
 B3V1gcS/hpXPt56RkopgBBa0GECdunMkn7eUfoGNmyIgTOm+iJT5ig75mKhMtyibLeM0x0f5KfG
 6RM61T10=
X-Gm-Gg: AY/fxX5anojHrPyqhgXyiBneeIEz/i2I6gYRRZbF6YvPQBJEGy5uDjdjDXcTG9z4J2c
 Y+2h+UDw6TcCO299Fg8cPCR/lJ69HjQzRDNrmQ3aXe6BEyMUOrlp81VgdyTBJWCNsdcJ1Xaz0lV
 72CB7/AGEm1iM+3dqoA5QFt6jDLskDRp7gB0vOXYWzgG72CtiO0RBbscCz8DpiBnfDj81LmwbMf
 gzlvyep/tkT1+DBTBUnZk4VcMORd8yFvyyQ4RkcUubdHA1QouWB+GxI7P3hAtALBmuAHrDpt/yZ
 lVS0eBQxKn+C9llvsqZv+7GEZL0GCeSPSXC7kFfJR0luPsfkxxs8b2g8vIDP3zecxdZy+G6brVz
 gg0oEcK4xLLk1fWgxOlWHWibBGtP4oyr+1lyF6/fugz7trevugt68GWUNK95qFbP7NswgqR8cgF
 TUdbXuItwvL0g3XSaxuQMGsOC3jxSEpg==
X-Google-Smtp-Source: AGHT+IEyBW4CNOXau5FknMqFr7R+mQ36g4bUuLE5Gq8xsfxpyI2hDwmozu4oEUB2ve7uMK3qjs4bcw==
X-Received: by 2002:a05:6a00:f89:b0:7e8:4433:8fbd with SMTP id
 d2e1a72fcca58-7f66a46cb37mr16734761b3a.69.1765998198261; 
 Wed, 17 Dec 2025 11:03:18 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe14270cc1sm188920b3a.48.2025.12.17.11.03.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 11:03:17 -0800 (PST)
Message-ID: <292a56f8-5078-4d39-bb5c-33e48c8dd05c@linaro.org>
Date: Thu, 18 Dec 2025 06:03:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/sparc: Update MMU page table using stl_phys()
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> stl_phys_notdirty() is supposed to do an optimized CODE
> path store. Here we update the page table via the DATA
> path, so can use the normal stl_phys() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/mmu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 217580a4d8c..46bf500ea83 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -189,7 +189,7 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
>           if (is_dirty) {
>               pde |= PG_MODIFIED_MASK;
>           }
> -        stl_phys_notdirty(cs->as, pde_ptr, pde);
> +        stl_phys(cs->as, pde_ptr, pde);
>       }
>   
>       /* the page can be put in the TLB */

I didn't recall that we had this in Sparc.
I suspect that this needs to be reorganized to use atomic operations, like arm.

That said, there's nothing we need from notdirty.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

