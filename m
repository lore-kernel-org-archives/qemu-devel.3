Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C42C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgKq1-0004Ec-MU; Fri, 07 Feb 2025 04:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKq0-0004EK-E8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:39:52 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKpy-0000Yw-PW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:39:52 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21634338cfdso45207545ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 01:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1738921189; x=1739525989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DmbhIeP/hDHZRGV5hhOJVj18xkK3R97algwM7loxZkk=;
 b=F5/Aux6dHhN0kxLfqOcNJ5MiYrd0sfb0wf/rQALvWp715d4asSzRh+ltHdmgwppMZb
 aaF52NDGB4qsoKXtsqxD2C9x3HDAFRXV0mPkHDnFBrgJeajZ50+DoIBYm0hn7ZgupQkL
 NK7b/p5kSdCeqvPIERgk4jqjAXmDQoo65Mlya3ThNPAz45pD5miHr6NpDtstt0NYgi+a
 5y++5J3MjkW0BAA+DFI67spzNFgOYR3Llmz/eRCYgBJIUCLJBoC2+Dcl7/6Mvw7ZZQtU
 xDBu8cqVQ9Z36lMZJh6EXFJbjs9WcquqUk00+vXdSmmAwkt7SJVElaHtloPOydwJvln/
 ie5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921189; x=1739525989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DmbhIeP/hDHZRGV5hhOJVj18xkK3R97algwM7loxZkk=;
 b=kltiQUha2SPMZCKofS1S3arE/IjLczai5+PwFO7Y/KJoQRz2btT5YmLv/SudlbxLct
 qF3RGrabnWcUgbRa87BlK69TEfJb/hxbvMJA5e5utNYnMNVLFfegccBpkR6uQQusOQ2B
 57mU1GGtNY3ges5PLNjXSkXz6Zw6EFSfrnYFfgSeyeE3Iw1NmfO13lfva8nzfOyPqy7x
 KRidJk1wX7mRAtd4+1tRELIVyb8Tu6GSdq7PSkEea1RSjrAF4K263ygI9lAh/Ktk8106
 JYJ00DFnl5a5udVoueIYCqoaXzIiJkD2OaDTAGEkWgSEnp8XNBTi6FxZWd4uQvw3Ufr5
 gGeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0BRjoXA9n7JSzDwbbIX4Jb5ztTKas7U6aryl1TaLueyzQ9twWNHsQdi6zr44WCZzBQx8iR/Qkzp3b@nongnu.org
X-Gm-Message-State: AOJu0YwDSIc/WMfOsGYBlIVIdGF4zu3kk+s3UHlUx0UKLJlUmzNNEnY6
 7wfSs+THMGyugpBLPOCAVFUfypycfxMQT7kMRZ2ipVQIwRgOvzOhiBB4XO47qmU=
X-Gm-Gg: ASbGnctAQ3nBiSNiNDj6D2sUjVSCHirTsv89ccSIj7sbdmlNQODS+Z/qGziJqCHjiId
 tqNpmswL5C30PR0Io3KhpPmjoraEkECkijbr2peHRaK6jWlYyxNPCYhMzkWInTHXywSfdIbey2F
 hj4ZripkM5Dg/NuqYp4Hq0Hp8JhMVU3X8zxYyloDcb+rHbeHp15YGo0C/E+4xIzQCslWGWBRj1q
 ZWgj/SneGTSmXJNT7wY27mAgVNGjWdiqgnESmtqCCixTejDnQD2a9S+gKJQHS6PnJfAwtTiLJbW
 9orCPWEL59CEjAWKABGaL11Kk7dgFNM2k3cex03fzMvhvDyJ9B7dhCiCVJBcztRS3ho5
X-Google-Smtp-Source: AGHT+IFK1KoP5CW6Ml9zNTDseosHv8HKm6SD2IXLbR26cctBVS/Kgz1ZS42d//6cHTKXMhAEE6aiJg==
X-Received: by 2002:a17:902:d512:b0:21a:8d8c:450d with SMTP id
 d9443c01a7336-21f4e7810e0mr37169035ad.53.1738921189330; 
 Fri, 07 Feb 2025 01:39:49 -0800 (PST)
Received: from [100.64.0.1] (218-166-198-8.dynamic-ip.hinet.net.
 [218.166.198.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653baa8sm26472175ad.73.2025.02.07.01.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 01:39:49 -0800 (PST)
Message-ID: <066a65dd-1dff-4b32-b2e2-89141ca0c0d7@sifive.com>
Date: Fri, 7 Feb 2025 17:39:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] target/riscv: handle vslide1down.vx form mask and
 source overlap
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
 <20250126072056.4004912-6-antonb@tenstorrent.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20250126072056.4004912-6-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
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

Hi Anton,

The vext_check_slide function affects the 
vslide[up|down].v[x|i]/vfslide1[up|down].vf/vslide1[up|down].vx
instructions than the vslide1down.vx instruction alone.
Therefore, it would be more appropriate to update the commit message to 
provide a clearer information.
(PS:perhaps, using the “vector slide instructions” to replace the 
specified vslide1down.vx instruction would be better.)
The patch 06 also has the same issue.

Thanks,
Max


On 2025/1/26 3:20 PM, Anton Blanchard wrote:
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index f5ba1c4280..a873536eea 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -609,6 +609,7 @@ static bool vext_check_slide(DisasContext *s, int vd, int vs2,
>   {
>       bool ret = require_align(vs2, s->lmul) &&
>                  require_align(vd, s->lmul) &&
> +               require_vm(vm, vs2) &&
>                  require_vm(vm, vd);
>       if (is_over) {
>           ret &= (vd != vs2);


