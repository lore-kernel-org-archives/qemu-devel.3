Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD6AE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx14-0002Wb-N4; Wed, 18 Dec 2024 11:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx10-0002UW-F2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:35:15 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx0v-0002xg-PC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:35:14 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-303548a933aso27897891fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734539706; x=1735144506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zPU6RgKUjg8sNiUSiDqlsB2bKmDIe4cw4T0+xzwT/LM=;
 b=fZqSNieSJXQIowD38nigFrrKhPU7kk/j8ja2y00bSaCbssMCupofCIpj3ev2rdgBUx
 YqlxzBv0cVpqaOB6sC/7D3SErwKOhx/9K86diDGF0sinGTjfJ6BkwxZpZjE0kkt3zGtS
 qPg5P8wbBKl4c0OItVf3AdxiYjqLVA5uCCvu6CHFyh73aEGLKKsQLMMgee7duhV/slgQ
 Y16obv+NDJo+JLZgzGLXj0ODH7f6aD/b1od/eA/+xQ9nstCXPxDSggrBHbyDLfxyLnT4
 tzOVzMXoTZo4bP80Nc9ivQryYl1/v6N0kT/qGfN0p8Vj7L4w/0ztemWQymPl6cvDqPzF
 sH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734539706; x=1735144506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zPU6RgKUjg8sNiUSiDqlsB2bKmDIe4cw4T0+xzwT/LM=;
 b=OAjOxOv+ux9hA95sVZ5t0GRril0Bx7xTFwkwce9XHGbPPiy8S7qU4YFsym2Tu6l+pC
 8pDAo/LtYPPx6BO4cWi96gqAd3c6HbovTT1TTHTdBA+Gtwz2d8NzrTI1tt6xKIkYFkJB
 mz5flOLMLSi28V9+MyM59vw17+9GZ1tB5Ghrydvw5Xio+FPZEqh6lGGdosx8H6zByfyV
 /wvoAsa7qe8tQ8fD4RlJTAE9vfDnzk1AuA6D/IFj+qLQHpCdR1XeN9eu0hqYpfsXvWm+
 Z5Miwuc8eSgApa/bNyRXI9EHwJjHsba+7oM82sMvPj4teu7/CIeh1eDJfOOwlYFVBVgn
 BfhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY0Q/Lt8jqYgkEcgLiTodt6zHzkG4iva6XlsOv0vsuROH5ls2CnV1/6nogzFfbs3+dHGyl4SFwIAaA@nongnu.org
X-Gm-Message-State: AOJu0Yzj/Tp/HGzxnfsxFHVyieKUdao0BA4KqiEZSOZmwCKJKXP3ZzLv
 DlmEj+JJU56tLtkvS25slLBGmJv0Mxx2izDhqTSDnp4H/FMzGtYnL4IWBA7MMk4=
X-Gm-Gg: ASbGncsxtbgEmUkupfLu4GSEXgbfOEhR5WagiOnTP8HJdvE44RgADboNesOSvL1M7do
 Yl/079ciPsGUpxP9uh61d9ypmA9MXVk3AcZOptfLw0vu45XZ9zTmBB0tixCjQeXDoxQkW6eF8z9
 jUDfsT0BBOgiteXHD+VWw9QVFyk2Qzavhb4F9nvODgxmSPCdaLLdz5HOh2Wm9IX0GPMxtuGFFRh
 mSBLJS+bCjNwgD66Tlp+lsytBSwdrbDvsK1PbOoWY0EQFPL2/wrToweTDRcGL6YIxp8T0yv3Fs=
X-Google-Smtp-Source: AGHT+IGVQfXBq/kTsX5njceAZHEdWTby88+NHaZSaczdDeylNPjSIZYUAwOz0rDKoATKhwcfnThuFA==
X-Received: by 2002:a2e:b88b:0:b0:300:33b1:f0cc with SMTP id
 38308e7fff4ca-3044db691camr15260541fa.34.1734539706439; 
 Wed, 18 Dec 2024 08:35:06 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3034401cd9fsm16196461fa.19.2024.12.18.08.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:35:05 -0800 (PST)
Message-ID: <81752fe9-7805-484c-9c9d-feb6b572db71@linaro.org>
Date: Wed, 18 Dec 2024 10:34:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] target/riscv: rvv: speed up small unit-stride
 loads and stores
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
References: <14dfb7b7-98bb-4e8c-a223-c568512180b7@embecosm.com>
 <20241218142353.1027938-3-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218142353.1027938-3-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x231.google.com
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

On 12/18/24 08:23, Craig Blackmore wrote:
> Calling `vext_continuous_ldst_tlb` for load/stores up to 6 bytes
> significantly improves performance.
> 
> Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
> Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
> Co-authored-by: Craig Blackmore <craig.blackmore@embecosm.com>
> 
> Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Thanks for the graphs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

