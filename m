Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64C8E88D63
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8m4c-00034h-5V; Fri, 03 Apr 2026 17:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m4Z-00034J-AQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:29:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m4W-0004Su-DG
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:28:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b23f90f53aso20896045ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775251734; x=1775856534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AF8jA/lSqOWkyNVDlVGbweulaMzbiMxC8f/mvsGIjBM=;
 b=pUo4D4qOc7ImSmy1XjU7A2MsAx5KlAbJWJZQGXxm3suoRc2TSiq6puDW+y54hdWm6r
 +l35nUOJHG1uAuOnENMRlYyf019mm64I2BB8bCfVre/LEgnkDK6BWEyY9ieBEeFFQou/
 PddHNW+JvESMKdzUhU3LCaMQbqDe5379v16IE3HRs3mQok09bFDJE6/DPpBmXI740rOc
 eaWmdQgu3Ssd1ZpAyziwoGno3osShW/uAY90C09MOHf/J7GtI14Xei0UIDyxXrzoaVKx
 7clJlUdpyT+TVoKRuuLKUpaoSCK3DOY0kLTqha2EZCJX96wqxGYh5CXUvQwjZLBZv5FO
 Scng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775251734; x=1775856534;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AF8jA/lSqOWkyNVDlVGbweulaMzbiMxC8f/mvsGIjBM=;
 b=epEAZ6QcsedggwHkDsQIZDzOwsFOez9nLtwzoyFWcv3m2bh2us7XOfqmixJsYa1cho
 +MNRJ1Dq++IbxVOc3IxjMTZnPSdmcfi7zosuKOwA9voA716bY/vsbpGuJTr7WF9VRMUX
 on9XLkTNIVv6UTs2ETHwgsh7H1xWvQB+6GhbXqkHYFEOPjCTUW8/dR1t/hem6TFiTybA
 5SZCkn6osUp3Hg2EvzJPdCOou2xsj0EiCtU57y5zBVHsrioAnHF2cUj+Q+OJzByHQYwq
 FGWAJUVHR/nR5wU7nSZ/OYi7/eZQ0nUbn/nxbcbTEn285BGS+TMaZpq5FPym/llYCGgs
 Qgeg==
X-Gm-Message-State: AOJu0Yzgy4ZoKdxL+7Oxt7MuN1z8ificrlSkDi6dIFezLGjaKoPfYw4f
 0elx0iUCNBbyfRsAgHI8ozLZzMNiHjYayLKuv/3ZRzI7MwMn6WQRLUQJ23dGdRtIYdc4EvWSiKg
 m+Vw2UhA=
X-Gm-Gg: AeBDieuOUgnM8hDbzoFtU2uEUMVhx6vbsGdVZrenW/S5tOkbQ8qkY6heEng4zVSApe0
 cQ0Wx0zJXDQJWAJxdFw/SIgKMKi55HtIjYImzIF3Qjeb/u9v9HnGPP41Zq3QWVAYTJhBxt5PzQt
 VH9vaMjAe0J7y1kOmamTTR25cdTLkLBMDWdlQ29X+HGVFeGraPi/OMS5vg4wOOZejtGk+lTTyA1
 P/PdStl7II4BowaZ6xlLqQNYAZjhr49TqqFpEfyOaPbhILhTsMAifeBgL8Om/8djyk75lVoQxpy
 TYWkp4i832qFwdsgl9kqUBH4Fm/l/BDVMzaNrrEOYdFWQmiJZvBdDzoaRF2iAR7SAfXHX7VA6bW
 tCXPRFsOTZJPkdsVtRuhj5pBtsXG3NQD9mAla/UJIOnLSTIAS7InhLnpxH5NZ0n21B04wFLrzsc
 JhZK5zx4sGNzE45LiTULqHZW4BYxXcibXoXi3fL3yYulMibqx8A5l+andYvKokj1kYxD8=
X-Received: by 2002:a17:903:38cd:b0:2b0:5cee:c421 with SMTP id
 d9443c01a7336-2b281672acfmr48920345ad.4.1775251734353; 
 Fri, 03 Apr 2026 14:28:54 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2747a7115sm62050885ad.36.2026.04.03.14.28.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:28:54 -0700 (PDT)
Message-ID: <2993b663-5a59-4992-9080-2591b9bc2059@linaro.org>
Date: Sat, 4 Apr 2026 07:28:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 4/8] target/arm: Compile WHPX as common object
To: qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> whpx-all.c doesn't use target-specific code, move it from
> arm_system_ss[] to arm_common_system_ss[] to compile it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/whpx/meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
> index 3df632c9d30..db31e928012 100644
> --- a/target/arm/whpx/meson.build
> +++ b/target/arm/whpx/meson.build
> @@ -1,5 +1,5 @@
> -arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
> +arm_common_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
>     'whpx-all.c',
> +), if_false: files(
> +  'whpx-stub.c'
>   ))
> -
> -arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

