Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEDDCA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 05:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF2nZ-000605-DX; Fri, 09 Oct 2026 01:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF2nK-0005zS-FV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 01:05:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF2nI-0003Ll-Ua
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 01:05:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so33543305e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 22:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791522318; x=1792127118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgn3rIQ/UgL3wuGhAg1jpPsos+fR3FomTzHCiwO6Ipk=;
 b=B1z9/sdwFx0dnCl7TrREckSQ/vABhr40rJXiaHnKI4pFmtdiRZhXMINBT/GAZ6Bg5Y
 gpdbcmCHBiupEMLXdXq4+XVvwmfmD3zSCowkZpOqlqCZZfCm3JyThXTJ4UYZgjhtda2l
 hRshiKgWSWV6UuoaazkoP798S0rF0xSc2WxWIqX8lVHJnTTm7smI55R8UJGzEyvDWcnm
 UyYOihxmP80GdASU0b7PNwTf0oSh/bXoUdA2WDboVLveUJmVyvGJvc25EH5ztpbuX3VF
 L/stS8qC8+sIK9Sb/uvxR5dSTrqBhzwZ54ESYLGCG2KR3XBEpFUfp25lOuVEi2o6RmgJ
 lm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791522318; x=1792127118;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bgn3rIQ/UgL3wuGhAg1jpPsos+fR3FomTzHCiwO6Ipk=;
 b=RuGrITtS2T3rFrkemreR+7isxqvdjXveEixAX6VuONWoXQyS/PO0I/dcqZLeRi4BXY
 A3mnaEsQpF7xraWDg1I4oM0d7p0HabIV6hIpJrHZQKWrcCFdDbw4vRGcfcn3s3edUrMz
 5E2AkfKdS32g9odnGZraMR174IWjeCQ/5RpSn1l6+Cbe+TnSsKvJg4SAozIx4+1DJGfo
 J5TRLoAYt3jPvdXtGVLJrs4dGc/BEey9MbnZbt+V8TpRNUBnxUUKxfqLSYBOffD5LYT/
 N0x6EMNaIj/vm5bP12wcsTzE04kxRii34nRa/Jny7gQWCdL3pqFvDZAWD2c48W3ZMlY1
 AL7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAOWZs7NeSp4YMyqxCIKMNv8bsZgWB/du5rW7Uwc/mKa+DVGj5Y3CzRhUYoCHLIifHNnW8dFHiNc5t@nongnu.org
X-Gm-Message-State: AFuF++kf4N9dXu6Ki19e2g0tq2DPX5Txt4bTIWxvZutf0qAdkEbAaXLY
 Ye1m5dERtVVKtcpxXKUtnH5xrVMhDq3ZhNF1KwJjY5MpX9fgR4LQ4owab2JfhlGokOU=
X-Gm-Gg: AYBFou1fwtYFjzciZzGpATQ+uEiNO5XKKr9N//Cwm2lN3yeshQCKEK2WFVB0mqHKR/F
 CytkIEb/l9chhmk2BSIqA553yxRb+yTrXC14kjB8MjPBrRMfYyaQoRKYI2AHwQLQFKS39tJhEl5
 ErDQfdbJW+f4BAp24voq3+8ZgBmmmamJs9kUj2rMygbw74Q1/vQkBQazj0yRY/r+Dj+EOtGpXwL
 2aEe02h6lzWwNG9ZJA0MrnTt1bFWoJg45UZjeLQ57Nuihst1EogK/ReMgvUT4FZSUODjH+dIptM
 2AEawIMQlA10V43uvCAgWlPatKvAd5/4hwnXPGIh/rUzr1O72yn/jollUeS9GYzGiDkPKa98/iV
 QUnh3+ugCoq3xmOHImYTZvYk3HHzZEqIvsXQTKGF5C7zrlHUifrZx5aJzX5vlQQeiErj4KZvj64
 HXh/k9wk5ot6iyTEaSA4mROKFgTT8t78gyrdZZkhwLjwPU2gq7nW1hGBJgWEyeW0pe1JmNunILp
 0NsPW9R/bOdw0XtyAhvUN/GArLU3MylWUoMq5QwDhOWX06Hf5P+p9QD4s9KiiYBZv99TvRtwHx+
 dw==
X-Received: by 2002:a05:600c:1e24:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4a18e49310amr10096675e9.5.1791522316298; 
 Thu, 08 Oct 2026 22:05:16 -0700 (PDT)
Received: from [10.86.151.227]
 (ipservice-092-208-245-012.092.208.pools.vodafone-ip.de. [92.208.245.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9463499sm1744110f8f.3.2026.10.08.22.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 22:05:15 -0700 (PDT)
Message-ID: <118805f8-bc4c-4600-b156-5b494a840ef5@linaro.org>
Date: Fri, 9 Oct 2026 07:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv64: Fix vector constant matching for logical ops
To: Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20261008181647.3015949-1-aurelien@aurel32.net>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261008181647.3015949-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/8/26 20:16, Aurelien Jarno wrote:
> +        if ((vece != MO_8) || (val == (uint8_t)val * 0x0101010101010101ull)) {

Do you really want

     val = dup_const(vece, val)

?

r~

