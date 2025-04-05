Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF1EC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zho-0005DO-W1; Sat, 05 Apr 2025 05:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zhh-0005Ai-Ez
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:20:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zhd-0000L9-8a
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:20:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2295d78b45cso36285605ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743844835; x=1744449635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KVqM6nielI2GOLNdw6Wc0c3+PuK7jiZUlUoI29HsZ5I=;
 b=mDX/AnXfZR0V2/pBmnkvLX4bAkcrng72bp1ohPLkEhEZaCFAgO1boUWTBiWOHD8kS8
 CTI9IRxeHCOl6zXkMDUeaLzq8gSMyAkmX/KL7zHaadQ23ugfaeSiudwEdkpJusn/3Bq+
 7GCzEZFQr8V1ub7ruUgMW4ZJWFJHuG4Sxpa78bQsz9QbwuQ1jNh5w7XOm4VpNkxuSkgZ
 ONVwnyuC99z3V/B9qNnLaRRd47IVDFJOXhYbfkpuTPQcMoFKXGkEFFnAOBQiqicoEhm7
 qrdBsKHotPndng8LxGudPxGDuGKjWOnwExEJaGJ6vFnJUlKpYIQU5ZLTG3SD7K2JGCau
 3mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743844835; x=1744449635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KVqM6nielI2GOLNdw6Wc0c3+PuK7jiZUlUoI29HsZ5I=;
 b=rPAkQlbGw6B/8VgS8SoKwyCDf5YzHtcPOsS9NdjPkql4QFU8WXhSJfP/2JgngL2/lT
 n09YmJB0icD1M7clm91GtyavgN6OgtdDC8wjJNrDVt3HplYjyjhKzpV7r4laoPinHh++
 reyzOfMGFhFXlSyKYULKPcDYASObMod5DUVhBqE7R9quIpuq3STV43es+BzEYosHNKOj
 K0VvDn4dYvlrlGZgf8WKs1sqAO+0LY+rhYQVOMxriKlIiappimsVHofXw9QL7ngrkQci
 6fcd5iAvw89nYqkN8g2waR775aVMyFyWbAhmcQIBGlzsO3W8uaMDrGbNbffEA4S/NEWl
 n66g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURBT1lNHUxI6jf9Nev1eC4ulgCQicYh09Nmfj5E70KA+nvU35+n4cCLT0j0JlX/ThE9cmspbCMp5GL@nongnu.org
X-Gm-Message-State: AOJu0Yzok5xyL1JuaoDNd5uyOD95pXiuS+yx4p+hYUGnKrM3KtpF9s8X
 RxLnDHyx49o8jRrqUP0xef/KnI1MwWbUDh2r65r/hFDyOeR0PIai16dWlblkmc4=
X-Gm-Gg: ASbGncsySg75RYnCMrSVl2gF1HZNpRIc/7pvVbjS9EDOlysqZ9sKj0HIQkESgg733r6
 G9MRbAS0Vp5AHQKWLF7e52pn9eu4FHsw/ZuMaV568jYZrY4dEZVmYyRsWB4/3Uz+uAUnAQN0KsT
 vdG3sgy2wXgJPdY2G1YrBbfGfWkCfKAqid0yCijGZrOnyoiBkaxK6NtclKgapou+7XZGlEwyuFX
 FZ00FbLJnYJ4EG6IZescOf3GzlT3PigzQWSJj85TTH6W3Q7aXoLTdhTXH4cU3IViIgBO6Ylja5i
 8v18PJkMnZGlVaGeoh4uyvWbpTGXODkaQgI/YV2R9glLuqQ9RrlOMrpTgFVd9W3qMU/VJxk=
X-Google-Smtp-Source: AGHT+IExx0waKFCaGltdOfo3m/UD+V18gmH0erMwXhpwGHq0by+QwQbZCUftkqppNSeJ5hFpxVWUMg==
X-Received: by 2002:a17:902:c94e:b0:224:5a8:ba29 with SMTP id
 d9443c01a7336-22a8a0b38bdmr68945145ad.43.1743844835281; 
 Sat, 05 Apr 2025 02:20:35 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0218sm45874645ad.89.2025.04.05.02.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 02:20:34 -0700 (PDT)
Message-ID: <af6aceaa-b985-4282-b43b-65e6052b28bd@ventanamicro.com>
Date: Sat, 5 Apr 2025 06:20:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector narrow instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-11-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-11-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 3/29/25 11:44 AM, Max Chou wrote:
> Handle the overlap of source registers with different EEWs.
> 
> Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
> Co-authored-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


With your co-authored-by tag removed:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index f30157939b8..d4d1ad055fa 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -585,7 +585,8 @@ static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
>   
>   static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
>   {
> -    bool ret = vext_narrow_check_common(s, vd, vs, vm);
> +    bool ret = vext_narrow_check_common(s, vd, vs, vm) &&
> +               vext_check_input_eew(s, vs, s->sew + 1, -1, 0, vm);
>       if (vd != vs) {
>           ret &= require_noover(vd, s->lmul, vs, s->lmul + 1);
>       }
> @@ -608,6 +609,7 @@ static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
>   static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
>   {
>       return vext_check_sd(s, vd, vs2, vm) &&
> +           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew + 1, vm) &&
>              require_align(vs1, s->lmul);
>   }
>   


