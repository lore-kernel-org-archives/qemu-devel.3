Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7EDC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmCA-0007Et-JE; Wed, 19 Aug 2026 15:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmC4-0007DI-Bk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:43:24 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmC2-000888-SS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:43:24 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38101f85591so188034a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168601; x=1787773401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oOxA5buIwN+EbIUS5vUHhjzB6Gt+ps13eguXqMnYUZY=;
 b=cna2FdPAVwhY2uL+1rL6QSOAn9ZExeixP+oI2kPqJHWouZmJvPLCV8xH+OY9DwVho5
 /LRxiqe3LfEJkkOgyubyFYkU3SxB0+fOf4WiAGOnR+UITV+muJQeYUGh/tDaoB1DlKp4
 X1iIieluhDQL5mcknMO65hsnahela3tyFbB54Y1m0bZJykeC8bVeXu5zRGRRMAN/t/l3
 ips6vtCCOCFFNt2b80+WWP9opDUhBfne8OKyGFHfubZbNuuV1q0iC4PEF8771Fo9ZxjZ
 ioWNmc9rp/Ho1P5XrqVsIn2aAmaZnfw1qRlkEh5Ik6ppE66BmzrFUva3aUy/AFk7uf2m
 IGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168601; x=1787773401;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oOxA5buIwN+EbIUS5vUHhjzB6Gt+ps13eguXqMnYUZY=;
 b=ixJ/wfUZMSYc53MMvoUkljcsicij/CEaXsA3f4KL6ID72eC9TsQ5KC/uh/wQeK5X9/
 uLUlWsELBoQYKeew5KHt7QZC0rUYaEz6Koy/VguOgi9BN1T0qmf4brcefGSxpmBtCe8j
 wFXI3ZCpRRTxz6uRkFdakGbOYarhJkWLGxrnjiTwfEr609oFU82qjmsF2cf0yM/u6XBl
 5JMOu28WUYyA2DXwzqE3EIpqBy1hK0bTYG7LUM2Fp9+1Gn2Bj6ToBKoiSYdEMfTfbu7M
 YOSs/pQlVjSMV68+51KM7H0n6aQapiHEh9pmvdw4X/9bd3u8ezpfJHxV6HqBpm1MBJMu
 KWIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV3qjybqWPLSeZ8fd4QAb+YhARSp7ZsYkXux8f6lhwGdQHYIXRvhC4OtvpmwyluoHTTl4NutSlBLHh@nongnu.org
X-Gm-Message-State: AFuF++kQNG8p3qfjl/sesDwPZ/NrwutNKVvDtQLfmnJnZL58fbgV0uhJ
 4UWuxi6vV5JRa1dAGMJQXLYhhtP5qsXB+vBZ/STWOXrMjigKcIDjtJIcOM/bL4g7NjQ=
X-Gm-Gg: AR+sD10B3s2WoPnOf+nbVqfPHppUlwaP6LFWrVWalIvV7VjYEuF4Szh347ALanjSmgs
 raxydPLJ6JNFupJE6Urm+PRwMu6GLPi3884py12Oz6KAgmKv0w8+H3+1dQmabjTCNuyF7Nb4v8u
 9VtsjwkDDIBmKVsCzEdrQhqb9FMNF78zDrY3bITwgAuS/GPSK+b0brQQXyT41VgRuju+YpqVx1X
 MeAwdmEIOHqjZu60GHvWSGN7rPq4F00ISia2mo9m4XcDIPXsb9KQpgiALwMlBH2QHVnp0ULBcWR
 T3zwiueiRM5yTxxE31BY73eJNSzoyMbLYNXIfkrYMhBCBByNV9ih6GESgATwlnctQkHhvVePo2S
 zY7XPGoIqpylU3AI8PeZbffOoeTIEMBTH902AYBHwP8bK+95oUmvgPhqlOZvfQO5qgWI2mSw4yb
 k8xclUjW26+ty3F4sHGxX7cP9HUWDm7DqQbZ3/vw2YPr7o6zVQVL11kRdHDweA0IAvWZ8f6CV5S
 qMS/8CbfBOkHto8a7E=
X-Received: by 2002:a17:90b:5242:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-395a056b7cbmr1288748a91.3.1787168601098; 
 Wed, 19 Aug 2026 12:43:21 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fbf3dc2sm3829539a91.17.2026.08.19.12.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:43:20 -0700 (PDT)
Message-ID: <3529f1af-b70c-41e1-8023-13e9ea833e71@linaro.org>
Date: Wed, 19 Aug 2026 12:43:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/vexpress.c: Remove forced cast to u64
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-3-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818172012.3052821-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 8/18/26 10:20, Peter Xu wrote:
> Now since ram_addr_t has switched to u64, remove the forced cast as not
> needed.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/arm/vexpress.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index f26d8c6f8d..a6ce426356 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -363,16 +363,9 @@ static void a15_daughterboard_init(VexpressMachineState *vms,
>       MachineState *machine = MACHINE(vms);
>       MemoryRegion *sysmem = get_system_memory();
>   
> -    {
> -        /* We have to use a separate 64 bit variable here to avoid the gcc
> -         * "comparison is always false due to limited range of data type"
> -         * warning if we are on a host where ram_addr_t is 32 bits.
> -         */
> -        uint64_t rsz = ram_size;
> -        if (rsz > (30ULL * 1024 * 1024 * 1024)) {
> -            error_report("vexpress-a15: cannot model more than 30GB RAM");
> -            exit(1);
> -        }
> +    if (ram_size > (30ULL * 1024 * 1024 * 1024)) {
> +        error_report("vexpress-a15: cannot model more than 30GB RAM");
> +        exit(1);
>       }
>   
>       /* RAM is from 0x80000000 upwards; there is no low-memory alias for it. */


