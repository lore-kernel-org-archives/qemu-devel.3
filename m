Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6F1CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUXR8-0002KO-Kd; Tue, 02 Jun 2026 18:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUXR6-0002KC-Dl
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:18:12 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUXR4-0001Y6-Hs
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:18:12 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c8585ecdd71so1482679a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780438688; x=1781043488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3QbK5YCpwBt3zRpKXWqCz91pWeZrprhtBzN9cfjs3JU=;
 b=Y1byMoEX78Ailv6zjIycqOSnabIGLk3hw8LmgN8SY+vEzeBprdq+mUp1K02p2gvtwQ
 llldSqboprP+uHLAwDJbcEobsSDgCfHFDyuyYBsiJV2ejiHp6yKiRun5X9T2kk9P218r
 kIFIKgWx9Kx6Dq/vyy9rQliH93rM3booDYVHa/Co6HA0O2OK1S/SvdhmBPfEQu5zfHuh
 5/Jen6bQv4P3kq8LfVkOjOQHKPvD524r7IAe9JNUA7kwXRdr2LO/pd480ZElb1WLHOeW
 r45ddNyuC9BdrXnZIXfUWV8kYh30OHL24UwMU465jjVj4BcwccEk27ClHuTEEnIfa3+O
 KVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780438688; x=1781043488;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QbK5YCpwBt3zRpKXWqCz91pWeZrprhtBzN9cfjs3JU=;
 b=g2A+7JvEKJt/hsU2Q2WsNNyo1UL6z0iO1/RP73Iqjta7cj4wL2w4+XNzKIf8DsCs4f
 kb049sji1c192n6RlokTal9uZ7AmOOR4P3g1QIoIFoQe8cV/TKV1fq3JYJjdT8dTx1Ds
 lz9tUK4Jz4wUe5zb/ntVQlKHcpUE6Ae+8oVoBjdSbWc5dqKXo1py1ZOx/iwkDYCMKEeb
 SN9PHgH2lKNseQnWtSKddR46rsU+4ygd329WJh+kEB5NqJcABkHswLO/2HYm1Y3/ajuZ
 c+dUvmES/R4DWnazCpqkL5vcY3Rud87Ooe3eCNxbmCCGbbU669J9IaECC11ICfGgatW8
 MifA==
X-Gm-Message-State: AOJu0Yyu991brQKIElr7KaiW/tjcamOrKTn6zfGcfOC/P0wiZZLfVkXg
 3DbPkjDmbe/4spnu8sFKp4+r3TqVMruGvj0oYDyJ9kE9VN2H+zwhuJIxOi3Em/K+f0YiFb+ZQDH
 l05G/9AY=
X-Gm-Gg: Acq92OEbbuxboJEVCBi0MO7WzX5UqecRN3qjWkB9bmOoOlSXwP6hWBxBHg0/npK9wn9
 1wrij/McMLkrRg5nLbE8yV6nDEr++OwzpnU6vE0cmUmIsETBJFQXPXs69sM7+QlzFKiRFchCVnD
 EGJ13jf7TkIvefBGI2rZtA+mmEQYoe62rFuCgPKWAAN705Vj2AuG/XAUBu+5bBfUuPXdoTNXJgR
 O3dDjVA0FjZFomvJ4dIEJnQSfpKNyGFzs5gVeTcQbAuj/zZ2FIJbOHA7E8jUoTNqgJjkiciceV4
 b8oVRyKRvZ04u8dbx61DPxoL2cE2edoKaEmjAY65yP6y2L7Eqg8qcc87rHQBJQSXF8+FPcNOK73
 0XAgEXt5xOjzAI9BUrtfEkwtZwI3VTuN4a3N02y6uv28rAiKs7TFS4237G9Hk37YTMSuHPFWvOE
 gq/pHmeF2O2OGiNuiSW0ud4ZTKniO+N75sITU4XdbZhZPBPw8=
X-Received: by 2002:a17:903:19ef:b0:2c0:ca99:3d73 with SMTP id
 d9443c01a7336-2c163a28aa4mr6056915ad.8.1780438688025; 
 Tue, 02 Jun 2026 15:18:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664a67b0sm2526725ad.80.2026.06.02.15.18.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 15:18:07 -0700 (PDT)
Message-ID: <fff37ec8-1242-4c45-b2bb-d17c672757db@linaro.org>
Date: Tue, 2 Jun 2026 15:18:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: replace cp_regs hashtable lookup with direct
 array index
To: qemu-devel@nongnu.org
References: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
 <CAN1cRoPWtbqKgxKPT54=qF6p4Au1y2Hd8-9xEQ+CBSHffEMMVg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAN1cRoPWtbqKgxKPT54=qF6p4Au1y2Hd8-9xEQ+CBSHffEMMVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 6/2/26 08:19, abdelrahman elbehery wrote:
> Ping
> 
> On Mon, 18 May 2026, 12:58 pm Abdelrahman Elbehery, <elbeheri95@gmail.com 
> <mailto:elbeheri95@gmail.com>> wrote:
> 
>     Profiling showed g_hash_table_lookup as a hot spot when running TCG
>     plugins that log all CPU registers (e.g. execlog with reg=*).
>     Replace it with a direct array index to avoid lookup overhead.
> 
>     Signed-off-by: Abdelrahman Elbehery <elbeheri95@gmail.com <mailto:elbeheri95@gmail.com>>
>     ---
>     While profiling (via callgrind) a TCG plugin that logs all the CPU registers
>     (very identical to execlog with reg=*) i noticed that arm_gdb_get_sysreg is a hot spot,
>     mostly while calling g_hash_table_lookup. Probably this is due to some hashtable collision
>     that is handleded by glib internally.
> 
>     Currently each DynamicGDBFeatureInfo item holds keys for cp_regs, and the keys are always
>     used to retrieve the ARMCPRegInfo pointer.
> 
>     By replacing the keys array with a GPtrArray, we now just access reg info directly from
>     the given index.
> 
>     The benchmarking was done on c2d-highcpu-16 (16 vCPUs, 32 GB memory) GCP
> 
>     Setup was to run qemu-system-aarch64 against a buildroot kernel and rootfs
>     with and without the patch mostly using:
>          --plugin contrib/plugins/libstoptrigger.so,icount=2000000
>          --plugin contrib/plugins/libexeclog.so,reg=*
>          -M virt -cpu cortex-a710 -smp 1
> 
>     Benchmark showed ~15% performance gain when hashtable is not used.
>     For benchmarking, i used hyperfine with 3 warmup rounds and 10 iterations each.
>     ---
>       target/arm/cpu.h     |  6 +++---
>       target/arm/gdbstub.c | 28 ++++++++++++++++------------
>       2 files changed, 19 insertions(+), 15 deletions(-)
> 
>     diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>     index
>     15a13b929276dad161032b61ba51ebbce7eeebc6..8816e94e3f8271ad403e77f6182fdb8cee31c527 100644
>     --- a/target/arm/cpu.h
>     +++ b/target/arm/cpu.h
>     @@ -121,15 +121,15 @@
>        * DynamicGDBFeatureInfo:
>        * @desc: Contains the feature descriptions.
>        * @data: A union with data specific to the set of registers
>     - *    @cpregs_keys: Array that contains the corresponding Key of
>     - *                  a given cpreg with the same order of the cpreg
>     + *    @cpregs_regs: Array that contains the corresponding Register info pointer
>     + *                  of a given cpreg with the same order of the cpreg
>        *                  in the XML description.

This will not work, because each ARMCPU has separate cpreg info structures, and these 
structures only have the lifetime of the ARMCPU struct.  We create and destroy these at 
runtime, so at some point you may end up with pointers to freed memory.


r~

