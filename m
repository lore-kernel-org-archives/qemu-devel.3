Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92CFCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqan-0002bi-WE; Wed, 17 Sep 2025 07:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyqXu-0007hD-Lw
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:42:00 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyqXo-0000f4-I6
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:41:54 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71d60150590so40751207b3.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758109311; x=1758714111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x47I4/cgEWbO39z5R47gOt18AsZbWJU19CPhN/G1x5I=;
 b=h9PZOpJoym52thmW4EktJea+L3Y6WT9Hd9CP+Bhw10Wh6wR92bjlCosJBTGvMhJi9W
 AoXGlDSqjc6D/W9EWPocJfHlVcyQamyPy6tpQvMeZSYT+v+DYrXAn8Ownz7+NggbyBQZ
 j3nsN+9ucB8uK8i03zjChNIiJc3e9NCcf2yYfnOQPPyxyfQESsVXTFOf13Sa2qUAQ5Wb
 dkrWfb04MJvNUpU5W9WwLJ0iO1Nbl2NCdwqUcChNiG936c48gyli524s34G0IYVX87wt
 QWxA6QyWlUhgR/OKNykGJZsAfu6Zy1/tRmVCpR9esHSVwwz4qUCeTWPTQJCYpZ1lXn9h
 44hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758109311; x=1758714111;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x47I4/cgEWbO39z5R47gOt18AsZbWJU19CPhN/G1x5I=;
 b=ZJF63AS/QgSwqjEbLfS61ia6I+OHTtkFMzj0pEPQRMpXXrcbZf+BnvcTKXzRw3PAgB
 Nm7BUANv1quoPe14VCCnRviLuIovRJpTbRTLLGMCVjjYFNBxzPXPSKU/jAOqywb9DSGl
 HnP0BHzO77mIRbhBUlzHIChurVgg21cnG8Yo16k8YVf+OzYo6bCNNW/olYgdbZoXyK4Z
 D2SVjqtb22DFhk8Gp9Ex2/4LKTtIIdSLqnFiABwWC/BtFyOj/PistfHPT4XnUU3gBB67
 whfNCshEr8rkvR7XQ8yqljs+SVzu8A4h4EiADEqOY24iuAh3s7G4hzVMt2DnFaSdCDKN
 aXwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4RS8H1XUpgMwLSWEZ5bx5GKBc3wNdDdTFnkE+31jWho/qBZmI3/fIocAFJ3Fbss+tRK3l+pdXXx54@nongnu.org
X-Gm-Message-State: AOJu0YxpuUZdsNZ4k4W0cEASW7vFDuwn4YE+/cyDRjrwbZP2x61tQ7kf
 y1GtTkKQU8Jvgg1CoYdDC3FU7a04hCpGR9b0SjJf3W3NTyQnlOPcETX72TO9n9ZD6p4=
X-Gm-Gg: ASbGnct/UVRaiXRIwJBciG0nEAnaz2qLhx4w8gxPiUxrjWhsCoFHrRtgUOzWXnGLcnt
 24okEKSpZI8rRGr93K/QbxJPrNHDnVpIrLCZvRoWnhnv50IzIP9PpLPN2A+ZDmKBpTUR6LeU0Nj
 UGF4VE3U12qLJv9sWVxy0V/3iYgRtqr59SI2ISzStAQ4MWFexwt5kQuB0x7V+8Fi9B74PlAtNS2
 BLO7gix0OawJqGn4XHvPLAptAlii3hFzxzXtbxnXHY+gnRBjOiIPWC4TPph6t46WhC6yFxY8sh6
 n6n/w789FsP5IIEc7bGHpZKcn8IRuB7amwbHP4BdcG5jpgwH3AgqH7cTBSEt2OuWHwe96Ar3ybL
 WJsrTWFLuMmU7DzGR0k8daHLu2T7gOxEBv1P6hCf/jHRUqVJJEC0R7lSirApaJ4Nty/jZy5WKY2
 5a
X-Google-Smtp-Source: AGHT+IEAfGiJF/lHTGxMYp+1G4eOYxdLdSPpGPCI3j7dktsOmm2k37kgvP+7kIg9wGEmi6secq5EGA==
X-Received: by 2002:a05:690c:380e:b0:723:bf47:96f8 with SMTP id
 00721157ae682-73892a555bfmr14712207b3.53.1758109311143; 
 Wed, 17 Sep 2025 04:41:51 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea?
 ([2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-72f796974f9sm46518067b3.53.2025.09.17.04.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:41:50 -0700 (PDT)
Message-ID: <c8c84363-2430-4e07-9bb0-b5e7ea2c51cf@ventanamicro.com>
Date: Wed, 17 Sep 2025 08:41:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] target/riscv: Enable SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <20250909132533.32205-6-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250909132533.32205-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112e.google.com
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



On 9/9/25 10:25 AM, LIU Zhiwei wrote:
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..eea0942cf5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -204,7 +204,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),

smmpt should be before smsdid. The ordering of Z extensions has that weird priority
ordering, but S extensions should be ordered alphabetically.

Yes, there are some extensions that are already out of order (smmpm, smnpm ...). We'll
have to patch them back to order in a separated patch, but for now let's not add to the
problem hehe


Thanks,

Daniel

>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> @@ -1279,6 +1281,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
>       MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
>       MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> +    MULTI_EXT_CFG_BOOL("smsdid", ext_smsdid, false),
> +    MULTI_EXT_CFG_BOOL("smmpt", ext_smmpt, false),
>       MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
>       MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
>       MULTI_EXT_CFG_BOOL("svade", ext_svade, false),


