Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B76C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpry-00065r-OA; Thu, 27 Mar 2025 12:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txprw-00065D-Oh
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:14:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txprs-0002b9-Vr
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:14:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso8086675e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743092046; x=1743696846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+/EiiRtTQ98nzrMZeveSdGX5GAOpytSfxIUd6T2+Aw=;
 b=wK288buuCQsDyTHtcB2Owz9YOGINzYdWeNySKdUwEGQtMDn8rEtBv9T6X2UF1s0KVn
 ZPT5UulvdscM78lK9qJODtQunZDH94cv8hAb3GAUXHkdmEadySWIqxyoZhxunbRF5f+H
 BuV/gsMkdk45IqBjQ7XanRqx1lintnLE/S0RM7Ephh+Gn9c7ZJBc8MTnJTLXy+e4mva6
 DCPrl1bIX+rCYEansROQPt34b0/Pr8JhPaff9CIM3WicYCaW4rWQmzXX5D7PQDMqgS/P
 jz2qfdQUtWva6HySNxe13n1pLYAQ/zCdh1W0+gWs0aV4YZoZDNj8Et0QtjrDBq7AynAD
 3WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743092046; x=1743696846;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+/EiiRtTQ98nzrMZeveSdGX5GAOpytSfxIUd6T2+Aw=;
 b=UVoWiYne+HuCSNA7H2PLhYhgWmseuVQD8wS9iITqIrtZ7NUCuYapdNq8OzWx++zDjN
 IlKzyDr4GABqOWyCK2SsfzWAVKNm1C/jlr8FCCztF8eccK/sq6hSTO7PB7W2PHVjJZrR
 /dgd7gQUSu1uId8RCKDGd+gVQvKilwutDb+slF5WsQx8oHSqSzRi6rkfYnGI2Q2m/rS2
 PfuckVwSGIm3wDBWOGZWLuBuSEVP8UU53+uD4LeSsgcZ52XJ/vqRhhMQQYkgVypXKGtH
 Up28EXd8wVrLM/W2Q7nLyy8E/b3F4vHZX0LbMVrhX3ZfGtir/+An04llPMaSPTKj/Y8w
 ay9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwlOjGyobQKJmk+qnHavIkg1PSwNzY0eB4+XZrG9cUQcXnaiuCFrCF7zxFxAYNVjU2Hj5W6aB6kP9o@nongnu.org
X-Gm-Message-State: AOJu0Yx/jQ9FTaqHvehKVr1fkTM7rUPWF7j0LGpH3BKks5hgzYZozONk
 DnWsIVy8MExTlKyjSN9uHkP7XkGJQmedbKOfBRALe4h3aKQddhEYfrx2bwWjLq0=
X-Gm-Gg: ASbGncv7iHHZWUOpIL3UDvX5eCjM/GcqVweogTCudtI68vRlUZGFmZad3r8/cQfIr1F
 X9IO9uM0GUqdV4rw5UzzMLYaGXOvFkq57iN8pWxlhOw9yuMjW6cgS1QQEFawQh4XcmG+qCzbwFp
 iNGTzi6HxxZeYucgkFzXq4hOOAs8hkyJ1McDALiZY2v5x1UT2dynIgO1Qv3G89/X67D5alVeQsT
 HH5ZqXeuD8sWtXWUoCm4fJ9cEwaHk7p8ATJAVYLgYmbfsRYiHtvGKpUDOOgp3dxy0TAK/6xWV0X
 pPr11Q4rENhoYY2ljga37fBqjfMsI0Zl+EeRj7vvbULf/mtVe9q1ATnaPG4fP+e7BsFQpWmiOCb
 W23iEgSVYzhQy
X-Google-Smtp-Source: AGHT+IHD1HpbcTKIJApkycBtduE0DxAuFH5g2QIpr1fPx3Bp3QDnvxgfaRWR11DeBXZgdEUQ3jWUcA==
X-Received: by 2002:a05:600c:4693:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-43d850662f5mr39972535e9.20.1743092046227; 
 Thu, 27 Mar 2025 09:14:06 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f99561dsm20632764f8f.12.2025.03.27.09.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:14:05 -0700 (PDT)
Message-ID: <19d7409d-35a0-486f-a626-9d382fb8a6bf@linaro.org>
Date: Thu, 27 Mar 2025 17:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] hw/riscv: do not mark any machine as default
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250327130256.653357-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250327130256.653357-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 27/3/25 14:02, Daniel Henrique Barboza wrote:
> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> made it default for qemu-system-riscv32/64. It was the first RISC-V
> machine added in QEMU so setting it as default was sensible.
> 
> Today we have 7 risc64 and 6 riscv32 machines and having 'spike' as
> default machine is not intuitive. For example, [1] is a bug that was
> opened with the 'virt' board in mind, but given that the user didn't
> pass a '-machine' option, the user was using 'spike' without knowing.
> 
> The QEMU archs that defines a default machine usually defines it as the
> most used machine, e.g. PowerPC uses 'pseries' as default. So in theory
> we could change the default to the 'virt' machine, but that would make
> existing command lines that don't specify a machine option to act
> weird: they would silently use 'virt' instead of 'spike'.
> 
> Being explicit in the command line is desirable when we have a handful
> of boards available, so remove the default machine setting from RISC-V
> and make it obligatory to specify the board.
> 
> After this patch we'll throw an error if no machine is specified:
> 
> $ ./build/qemu-system-riscv64 --nographic qemu-system-riscv64: No
> machine specified, and there is no default Use -machine help to list
> supported machines
> 
> 'spike' users that aren't specifying their machines in the command line
> will be impacted and will need to add '-M spike' in their scripts.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/spike.c | 1 -
>   1 file changed, 1 deletion(-)

I'm in favor of this change, which I believe is the correct way to
go, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
but I'd rather we follow the deprecation process. Up to the maintainer.



