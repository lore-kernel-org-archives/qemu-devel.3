Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E9FC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgKsj-00063Q-Cu; Fri, 07 Feb 2025 04:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKsf-00062s-G5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:42:37 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tgKsd-0002o8-CA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:42:36 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21f2f386cbeso32501005ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 01:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1738921354; x=1739526154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MM/s1cMbtH7JqXR42oFCdhdV3+8FW5gNIVpJPA1Kxe4=;
 b=VquNiUP5F3hk1aF7EigVzZvD5dfDRYHXP61E+tosdeMdmaGZrsZnL7Hh/QeoW3ILxe
 1k83mveJSIzTNbL7Nhm/6LKRbkUgqfmJSJbwWE48c4la+bDYEaFqexgatgsqvSnDj7SF
 CNHuQk/2Ne7PHEA3dP7aaBRyZWDEeGcf+kN85S+EMgiLyftZQWJq6Vgd1udmRFCPCXZp
 VW/8Vf+tTsXGsrY3kR60clAT9Oxdo4A0ZGJO6TVKrsqKK7OW/FiTllm5DN+epIo2Oj/4
 LmNXHKbj7c0fidmUfsLNSUslE+nRBlXNVj6N61XMRCf32GiqKbfWjdJg+HJJ9Wd4wQDL
 EIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921354; x=1739526154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MM/s1cMbtH7JqXR42oFCdhdV3+8FW5gNIVpJPA1Kxe4=;
 b=rqj2T26qho+M+Kup88/N+GOSvombPtDbCS7FcNDPMB2LZze27p0nt9miM89t0XXyp6
 ZMuJ5K6YYwL8Jjbw3TRO3xDiAwIubd2jllAGF8iPtOWu6REmTqMxj+0jiVlpivUqqxVA
 aRONir/1WMT4EJDqH9VAIkVtVRUNgQHjeyNkGmc8/YHlIg37/IvVP8F0JKO1ht8tIINt
 KqSDBPVl/yBOQKpMfWtRQQQMw5ctVISnzdeU6/5BvoyEosZNvbzE98BmYQq6dtXo3Ms+
 XGBvyzsCJYC1JLc+I1w5OdakpCwvOZH9zjv7xbZkjYDiw0EO3ZItoK9Gd+0muCQi8s+A
 auLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLlGS9RDZ1QACf7iNB1GQ5woYLaVs+GnWO8+KgupPasco3AI6iqfEbg697Wiy7DCDp5NAhWQwwo0Y6@nongnu.org
X-Gm-Message-State: AOJu0Yyz6c7V0uy2oUBKbMbhz++9u9zV/+DdYeP4yMK5eoOCNN9Q+m6Q
 3DER9hx91ZPBDhb1/cxlOoKO5hv2OI6DeNx/zQ1Tg+5rwtjBkBIa98q8Xq5qJ7M=
X-Gm-Gg: ASbGncuY2vaq3qRjPhLlAG/1+U3GyZ3Gt0cbeCpL+UIOQQWAlBpapNG060ljNXC7gmf
 uDbKo/QLeZEG+uoUyYSqLOv8Yeap+CMXsRu4CMForEtEx05HvCD12eIy4HGc2bhG42TkjTXWEMO
 UQXgZlXtFyufxBbBqF37Xofzyv0QeObVObTHjFd/jXFyM/6CKwq8pYDIS8FgCZgnP6nk3cHSJ0D
 XacAT5dLKbhc8w5Yj8G2/5hDcTnNiqCfBL7tXL7f3WI2ADLmpWYr6KMWxdQoap8er+KojcnBffE
 64siVEthOecim81xbDqp2JWuCmYpuNz6w8H5hqkgkapNwnPGawN1sk2zEgEh7IZm9AN/
X-Google-Smtp-Source: AGHT+IELkl0ldChZ++QtzhP0PxPwNEgmnqj4SZxPBGmE7Ymi6mEydKPWBUWAW1yvwjNJfx0m7ucUcQ==
X-Received: by 2002:a17:903:19cd:b0:216:73f0:ef63 with SMTP id
 d9443c01a7336-21f4e7ae7cfmr46980425ad.49.1738921353769; 
 Fri, 07 Feb 2025 01:42:33 -0800 (PST)
Received: from [100.64.0.1] (218-166-198-8.dynamic-ip.hinet.net.
 [218.166.198.8]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2c35fcf1sm776334a91.24.2025.02.07.01.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 01:42:33 -0800 (PST)
Message-ID: <70a79709-d14f-49d6-a33c-13589df1ec22@sifive.com>
Date: Fri, 7 Feb 2025 17:42:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target/riscv: handle vwadd.wv form vs1 and vs2
 overlap
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
 <20250126072056.4004912-11-antonb@tenstorrent.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20250126072056.4004912-11-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x644.google.com
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

Hi Anton,

This patch violates some coding style rules of QEMU.
You can verify the coding style by running the checkpatch.pl script in 
the QEMU repository.
(ref: 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-the-qemu-coding-style)
The patch 12 also has the same issue.

Thanks,
Max


On 2025/1/26 3:20 PM, Anton Blanchard wrote:
> for 2*SEW = 2*SEW op SEW instructions vs2 and vs1 cannot overlap
> because it would mean a register is read with two different SEW
> settings.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 2309d9abd0..312d8b1b81 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -549,7 +549,8 @@ static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
>   {
>       return vext_check_ds(s, vd, vs1, vm) &&
>              require_vm(vm, vs2) &&
> -           require_align(vs2, s->lmul + 1);
> +           require_align(vs2, s->lmul + 1) &&
> +           !is_overlapped(vs2, 1 << MAX(s->lmul+1, 0), vs1, 1 << MAX(s->lmul, 0));
>   }
>   
>   static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)


