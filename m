Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A8EC3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ziY-0006E8-Lw; Sat, 05 Apr 2025 05:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0ziV-00062N-Tl
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:21:31 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0ziS-0000TQ-Ix
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:21:30 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so2063278a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743844885; x=1744449685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j0Up7UPdKuhOzg6fS9fJPPPMNPyVnrY+sWKD9q1DERg=;
 b=WtLE8VttckxUIYGlxQ1MgqaMRMo6D5nFv+/Jfz+vcEab8Bq03TdcZsPMtra4aKyU8V
 GgpZT/l7IMyzqy9vI1PDUda/OVlSEWY58l5bm/IJfZPQzKFNw8iQgGIbI6YebMQiVR+B
 6VXGj4o8FdI8Y7GUoGN38iBYO/I1SPd/Kw+ubKdk7mF5n0XJNFZZYc69rOxm1baNjdIK
 scADF8hR7+k5qXPMTmRLbELIwHaiUcaNDpJM8Wyncccp0WEnMZmH58e4SBJ7cs+pFo32
 YDVv74vCWKi3z1wGYWcvULUs2c+MkzT4UTZSUisOcRMUo0Z6kWs+Rc9AVcssublxVztI
 1jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743844885; x=1744449685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0Up7UPdKuhOzg6fS9fJPPPMNPyVnrY+sWKD9q1DERg=;
 b=gfn7CtGoqykhjg2VB3eOFFSo7+WDYbnMjsKAoDw9tcGH7b7c6T+mRxmsz1RukZ56A7
 OhwdhQl03mdZXz9CHmnN0S32dF5RpzxROkEC9yHVqriGySK57ZmNYKzOFoZWI6EQCmnZ
 VpciSDYm9KuBF3Xn5feD2032CuERhF9lXCCEY/apYjsFqCakmNL0PS20I2t2d8aBoLbb
 EgYXBH1f7dI6V5w3de773gzGBNp1ArxguhkyjGyni9fPrYb7x9vKZUk2WmECi+cnWjjn
 jsHAKt6t/mIZF+vcsgOnzs7NQwWKc6yXgitj9Nnjy1YFsAecj90fUirBnZ0P1q5ZANe6
 ydwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHWZNdZFQg+moEmgcKVr77T2oyIWzE6uATdQ4z6pBPcM7y6KzNF1Nb7QM7WWF7VIbUCue26M66dVNr@nongnu.org
X-Gm-Message-State: AOJu0YwFVGT9X0KU1IxcTaNOvwm+wLzMG4JwUosRqoRugKCjKKdzUpHf
 a8wQw4+/kYx9ym4DrdQpB6wl6S8XXQEpZveXCSHtfeuM2PeKyYmwRhmc0WbZF5E=
X-Gm-Gg: ASbGncsQCBn+XNfsYFL0NLUa/i7Yn3s0JZOC6BWxi7oz52viZ76/KSgTDeNcam6udgU
 o+14rEL9xljCjGNmX19zlFZG8Jnj1VJS7Z0PpfJjYpX4f00nBvW0ThoPPnj7QSygsG/KsORbizz
 g/cf/bPacuh2Dg3IX9k3UX1UYo0G0lLT+w++qZ4o9I3y6LppuBqhpLMIN+Ixwnlgoa1yqfrbDmg
 mlrJHE0zghhT9Kvot1jvsKn7nWIvTQXYNCw1L6R1uyl8ESX+fF5ZdoP7cEl1lxPVpIBkEkYS6Jn
 oeY754aprFU3feHYwjwcwZ8bPBZEGOZs4+s4rTG2jThSPnybaU3L26n0tnuu
X-Google-Smtp-Source: AGHT+IH/kGOPpuJNO2uKxTjIpPuc0YbYxIzW83KOV7zzuE5Anb/9c6CYav+mvN8tsApOzJeh3hbjZw==
X-Received: by 2002:a17:90b:2dc3:b0:305:5f25:fcf8 with SMTP id
 98e67ed59e1d1-306a4822fb3mr8386373a91.5.1743844885708; 
 Sat, 05 Apr 2025 02:21:25 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305983da812sm4960991a91.46.2025.04.05.02.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 02:21:25 -0700 (PDT)
Message-ID: <6c3b3613-00a2-4d94-9502-5f87b61d2bd6@ventanamicro.com>
Date: Sat, 5 Apr 2025 06:21:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] target/riscv: Fix the rvv reserved encoding of
 unmasked instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-13-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-13-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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



On 3/29/25 11:44 AM, Max Chou wrote:
> According to the v spec, the encodings of vcomoress.vm and vector
> mask-register logical instructions with vm=0 are reserved.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn32.decode | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6d1a13c8260..cd23b1f3a9b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -703,14 +703,14 @@ vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
>   # Vector widening ordered and unordered float reduction sum
>   vfwredusum_vs   110001 . ..... ..... 001 ..... 1010111 @r_vm
>   vfwredosum_vs   110011 . ..... ..... 001 ..... 1010111 @r_vm
> -vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
> -vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
> -vmandn_mm       011000 - ..... ..... 010 ..... 1010111 @r
> -vmxor_mm        011011 - ..... ..... 010 ..... 1010111 @r
> -vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
> -vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
> -vmorn_mm        011100 - ..... ..... 010 ..... 1010111 @r
> -vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
> +vmand_mm        011001 1 ..... ..... 010 ..... 1010111 @r
> +vmnand_mm       011101 1 ..... ..... 010 ..... 1010111 @r
> +vmandn_mm       011000 1 ..... ..... 010 ..... 1010111 @r
> +vmxor_mm        011011 1 ..... ..... 010 ..... 1010111 @r
> +vmor_mm         011010 1 ..... ..... 010 ..... 1010111 @r
> +vmnor_mm        011110 1 ..... ..... 010 ..... 1010111 @r
> +vmorn_mm        011100 1 ..... ..... 010 ..... 1010111 @r
> +vmxnor_mm       011111 1 ..... ..... 010 ..... 1010111 @r
>   vcpop_m         010000 . ..... 10000 010 ..... 1010111 @r2_vm
>   vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
>   vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
> @@ -732,7 +732,7 @@ vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
>   vrgatherei16_vv 001110 . ..... ..... 000 ..... 1010111 @r_vm
>   vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
>   vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
> -vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
> +vcompress_vm    010111 1 ..... ..... 010 ..... 1010111 @r
>   vmv1r_v         100111 1 ..... 00000 011 ..... 1010111 @r2rd
>   vmv2r_v         100111 1 ..... 00001 011 ..... 1010111 @r2rd
>   vmv4r_v         100111 1 ..... 00011 011 ..... 1010111 @r2rd


