Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C435F99378
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsWY-0000NR-10; Thu, 23 Apr 2026 07:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsWV-00008K-8P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:47:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsWT-0007wC-4z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:47:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so38415275ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944827; x=1777549627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/seBp/n19dVrQgsXs0kuSBPEGUNE0FnEiWfhOM2X2Ow=;
 b=uN4u9OcXMgqbppjZDN4LecteTBGBqV/0u80P7oaW9nMB0UoR/v6m1nJoB9T6CnsF20
 jolKbrT3fBYng/UP1hMDiWZF17wglyq4Wl9mvY/9rw/K37afZuktBkLKnJPFx5oC8EOF
 GEKuY/W6G3TdfIpuGr0PZBTmIBlFNSpQnKZ1BUWTP/eBFSJvt+bMYbtH+k6A6KoUtOVo
 T/+zw+E/ScBldsYk2VpqW9QSmIx7rpMnrJQEI2jVPE0xRy7O4IxZQsY5J5volhQMd2uG
 wkrX3THSa+e39FfKyHcNvmw0D9B3Zpv0R3DvWmZbb8h7Ku0lAFFeHstfdCJRmVpc/+AP
 AgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944827; x=1777549627;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/seBp/n19dVrQgsXs0kuSBPEGUNE0FnEiWfhOM2X2Ow=;
 b=MCJhr0haj60cLQXlAVSEKd5gtPNvvIV4YzOllhMG3tnZfbj/Q1rHgUGZPSDTuHUDFT
 kvc+7lTAxGgILTXezPLY7f0oOaZxN18pANvMWgje0tof8GnYZIodNiDC8iDUYbXxGOSB
 obNrg5Etfm3Y4hE9ykFSkeN44EPjZ/T030cGD9nYOYZDRq/p9ZQgjW4nLMeHjovdGnNV
 Z52Bj22+7Iie2yIUbIllhZ9IJZnZ7KZ28zW1YH3DVx4wZWW9yiGx/OIOR3bafezbPvT7
 T8A/ZibZetbIP4IxSwArBYQzWFAkv4/gzCUsn9L3jdDYik0dvPUa7dFreuKQfnAegJL6
 roPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ETTsV9nByb686tLRe2g/xrwjk2I3b94DnFI77Ny5bVDqxb0Ej/t+G5s4fpV2mil45/rNe2dkIPt+k@nongnu.org
X-Gm-Message-State: AOJu0YyAj6YF4LjP7Q5TW5Z1+yXalxGInqNawMFuochf/WKlqq3pBogW
 KgUvTDQbBVi9WmIgHoLqfL76ATokCpgFNTfsGjZ9iRWW+CxLNe/sPRtP39cEbRjXqEs=
X-Gm-Gg: AeBDietDc9CyKdKZaKg0+pPgvpa4k1Wog9PHR8brYymb4llJ82fbQueYBynLAWvxRHX
 pVugy5Lxp1bW+yGWmK7NUr+znXy4YXzGBkd8XPxJxXNYoU/aFT84YfyRE56b8LjLq0dzk9GklMw
 tYB/shpBCu21PBwBVQYzByaSlcSjR9nr7z5u3OBlhIKL8dG0aYqqCD2TLVAe+kJgHsWYe9h6KVB
 tKVRx92iTF4teXuFebslnei09JSGrg9lw3xWv2kuZeqQAfppKZulsQfmwhw+AZZwvaazgjXLXjO
 9jVpwZ5wyqN0hk4IxLSTPU23sTSefNl7FAGXjHc654fBfVEGZ2V9bjKGikrPGudgRqWS3np54QG
 EhNqAo1ycjaOaugdK38ziD2u/YgLdug4cKpD7cfo7HgABWAVrW08NxrYXTiZWFlxg+0bWLc/QC8
 vdquKH5nfgoR60bK1066ULMB1B0F3/zq3ebGC5wqW39CX6I9gLaA==
X-Received: by 2002:a17:902:c9c4:b0:2b2:712c:61be with SMTP id
 d9443c01a7336-2b5f9ed0b48mr191005175ad.18.1776944826902; 
 Thu, 23 Apr 2026 04:47:06 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caa9sm191041895ad.40.2026.04.23.04.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:47:06 -0700 (PDT)
Message-ID: <43331955-d55d-41b6-8460-930067596503@linaro.org>
Date: Thu, 23 Apr 2026 21:46:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/microblaze: Compile helper.c as common unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> Nothing in helper.c prevents it to be built as common unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

