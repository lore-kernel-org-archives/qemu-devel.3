Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE08D711CA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 04:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWS5c-0001HZ-6c; Thu, 18 Dec 2025 23:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWS5a-0001HP-DW
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:27:38 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWS5Y-000516-Kp
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:27:38 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42e2d02a3c9so805684f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 20:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766118455; x=1766723255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d14Lax8GkosexNo0sIOZcjFS/hwiEOZRBdz7Y6DBADA=;
 b=btTc5I0CVr/VnCxPA2uTLfNWPtDLoJIA4tQLQKHGpwGvFRJ6jFPJn57b7mBhbKoXLv
 ODBJbeSCU/re3bbEsR8i6/C8BvvQS45Xj8jHHr1SCa8+/+xcGjJ3Aw+wk8Gsk/LnA7Gw
 5j/Zc4fTWslDTD6ZzZZbj4F44qP0YrDlOqVifCXkGZ04mhFvZ9xcftD8Uvp4SCfkyRJU
 TborwueWyMx4wka1HhloVX5r+CzKdgvrzkT7cY/bnP2L+i0BJ1juXoA2BmZV3pec/lhK
 SpAfCLP9uCZSPqRz2LiXctUA9DfSK7lxnBjtJWHQ72PNdQoqzN+fzHx60OGzWll1VJQN
 x/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766118455; x=1766723255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d14Lax8GkosexNo0sIOZcjFS/hwiEOZRBdz7Y6DBADA=;
 b=B9lRXICqQZE/OkFy8iulhlTYngpxtVbsTh+M3Sja5VQQprfToVbPSweX6ydq025wub
 cQcO4U7y7Er/s+9286JYGp4f4mirNfo5Qs+ok7mFKmgbxvVEQLa8Td5TjR9fewvRFMPB
 opOzEGLSZN3XDaoeLAdz0CHhG+Ctgw8sLhiLbwq6DkNjFQy4VG3NnIPtn+4H90I9Wu7/
 cMgBxTTQgoXxAK5R565zjms9wN70KN8v6rCSBiD/Nq7t7O9ybHni+8UIoBx/HyN01/HI
 jYULWZIb6K0VA0RVNNK3YWtFRq1MMJE2Hm9s6suH/Bt5eF1pqWvAMU0GXsiI39VOD8BX
 OX4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCXZSlRgoRsODXPQlMlA/jmpcARy4pSRgZa6YS8XtoJt2LYzN+A9y9lTbVLdPd5UwmZaKCQKP+XqJR@nongnu.org
X-Gm-Message-State: AOJu0Ywy7ORf8ngh4J678JdCFPvS3Ok5lHO6jHhlci6zewLn8OfBZd3Q
 U2eXngggSk6k6UlBmbxNu2zQzHAcYw6rMHV01XCK/yh6vbKEnHb4vyx3xkQJB0FZ354=
X-Gm-Gg: AY/fxX5J6EUdMsY6CpHHIn6pQQddUmMQdrvbfuEf08f2Fz7++1zOfH5oC+/ppdnfB8o
 jprpq3ocO71kKqJ634fCR7HMrmobVUoEUSU45zaxn2DzzdyEnAXIQ+amvfAFdv7Ra5WaNwGOzqw
 RQrzR8CvNZLSjAGCwbquzEq8DV/JNKF6Y//XGt5BqT2jnlY7r/50KQC42SWV9xx35aBQok1gfqG
 lPJgJMzwR2vjdR+0DhZZ/xCnY80gRWob6AaQX8zGlF23TVrmCmRaTaHVLslb/yDSzmhUASrDqjj
 TYgptZV7F+a2j6/rMkChLhcMDJo+t2jdV8ZL6k/tBzkX+awRkKqXxreHYOgslZ2PY/607ZEaVt/
 0ON7EFgRCHN3RcLJ33dlLaGdK5rshMzcru16944sceoYs917UvaFxtPb+aj37/YDQ2xyYbaw6m8
 FgeiTK9reBEqk5Ln6E32jFH4Jdq7U8xGxgGaI1d46iRHzyOGFHeskP9D/99AHjywu/
X-Google-Smtp-Source: AGHT+IHyztpf9NEZ68T6w0z1T7M/0W37Y+eB/3wqm2R/KAdWW/IZwcE4CuZJ8WSYaSlr/s9tL4p8cQ==
X-Received: by 2002:a05:6000:1868:b0:431:5ac:1fc with SMTP id
 ffacd0b85a97d-4324e4c9bb8mr1674906f8f.14.1766118454645; 
 Thu, 18 Dec 2025 20:27:34 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm2662363f8f.31.2025.12.18.20.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 20:27:32 -0800 (PST)
Message-ID: <0ea4dd38-bf94-4ccc-a30d-5a0c8e53891e@linaro.org>
Date: Fri, 19 Dec 2025 05:27:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20251219040943.1570449-1-frank.chang@sifive.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251219040943.1570449-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 19/12/25 05:09, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Use designated initializers to initialize riscv_excp_names[] and
> riscv_intr_names[] so that we don't have to explicitly add "reserved"
> items. Also, add the missing trap names: sw_check, hw_error,
> virt_illegal_instruction, semihost, s_guest_external, and
> counter_overflow.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
>   1 file changed, 45 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


