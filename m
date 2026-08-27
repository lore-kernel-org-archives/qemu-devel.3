Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1FFC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRmx-0005Hd-DO; Thu, 27 Aug 2026 00:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRmw-0005HM-9K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:32:30 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRmt-0002lU-Ru
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:32:29 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1866451a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787805146; x=1788409946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VKO34dmITIydInhjpUNQQ+4qHnJ1xyey+i3SuLs/zMg=;
 b=HvpfFruPLZg4hkirTkZoDotzLXUg6L4yCeCkfJdRuYGUzv7zlqR/UEUMmyyEIa/+a/
 RR3eXENxfusaux7DbxhkUI0481NAX9rucPMoOx9wKrj5KTycI6gPFHYzDg/pLTT/fsOA
 zL7dUKqW3YON0/c5Wx3aO5pUuk9e+Gxqkcyy8x46L+rFEbFh6REel7sdNkn1cKlS2TyO
 kGFuITWA3oSRdvOXvBPHYwg2cyhiFuzyqFG+bg9t4W96A+abivCLmU/bFQHa8dOXJcoU
 flkLHa1sX4tS1viddEnQTT0BGzkLYcOFhrhgy1ohRmwTHTJBCees1pM49Arf/lTjcyAb
 lBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787805146; x=1788409946;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VKO34dmITIydInhjpUNQQ+4qHnJ1xyey+i3SuLs/zMg=;
 b=AqZUgmSd7LMtGIVFvK2kK5ECp7lsguNvFYwOKpDW0B/zd3a5EG4KxRIUiYASgW9jbd
 in8IW0m7yUGQm4FyBVP/pcS/grxVCpoGPwn2uF9Zj+1mr6e65YQnt1MU1A02b9SNzbZL
 +Oq1LUbbWkx/BTMDTbcq5kZDcGdjnDpS0G4FSjw3xSkXugp6gCxw+AMM5NNVvYW6SEsx
 4OdEbkqLu9I5/DfqDtnIfFKLpDChnS0PxhxToq9IxVXICMYMg7UNKcUw4AfAbk4dp93p
 T62ooS2VxdKLkbhsQ/gC6f3CAmmmrzpARrtO5cRHrCGlDGi3ZW/Eyo48ScwivFc72Yfj
 1lzw==
X-Gm-Message-State: AFuF++kcyZmtt2yARV42YpszYRVcv9HkXK6e+A9VRJy2UI5TF6+5JgBS
 6VtqIWNYTxav8plm4sHbkVv4dicBdJuE58Te4RuTLPSiz7CPM43HpPzFsRSDtZ/7Xds=
X-Gm-Gg: AR+sD12B97rwSB2Cv5s9btdDtaIKK22Pn5LMOmsrWqa2Rp9KHjSo1GCm4snx3fchQ4n
 KIdjBM0redo4tqgAI80BK9qiZIwIRlztUha1TYiCp/X8Z368GRJQmoBd5cpm3c0U2a/xdrznvNh
 qr+TYnq0gjAQc5vixd1dXZoeuzrS23ouJBRJnfRYScNdTVosUkge66gIc1idf6OwU708Tu2OXac
 z+vEflRdVpIdjeQF51IBnTk6XAGb0K5AGn2/PSFR1D8B5Kg2uguDauHcHd+EJeqBKlfLJ63COe4
 /fjm/gbLbsDyaAHliZA8Q4ctpo72akum6Ld6psudObDnq2pQjMho4C4uBFu38/jSIDFzg77+4T0
 IXyJ1wKszN3p4xxsIHqMTQokamKSh4ObIboWacM2aST6dmS4DJft+dXvrzrxCd90r+0sFzJfjyQ
 1SXlQbhw/eHroy3VFuxAZ7JL8tJHPbkECOQxKXTdY1huCo7go1eFH2lFn+qYRiL22/yKnWdWqUE
 atPm8Lg8fLuzhTZrIv+TEaE0X/x
X-Received: by 2002:a17:90b:5543:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-3966d13eb75mr25876574a91.3.1787805145822; 
 Wed, 26 Aug 2026 21:32:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3967059c288sm1915648a91.0.2026.08.26.21.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 21:32:25 -0700 (PDT)
Message-ID: <5e5138ba-2368-4b85-9415-af8f42965c3c@linaro.org>
Date: Wed, 26 Aug 2026 21:32:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo-aarch64: Fix build with older glibc headers
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20260826163753.459661-1-tangtao1634@phytium.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260826163753.459661-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/26/26 09:37, Tao Tang wrote:
> Commit 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
> started using HWCAP2_CSSC unconditionally. This macro was added to
> glibc's AArch64 bits/hwcap.h during the glibc 2.38 development cycle,
> so AArch64 hosts with older headers fail to build.
>
> Follow the existing HWCAP2_BTI handling and define HWCAP2_CSSC to
> zero when it is not provided by system headers. Such environments
> simply do not use FEAT_CSSC host optimizations.
>
> This has been tested on an Ubuntu 22.04 aarch64 host with glibc 2.35.
>
> Fixes: 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   util/cpuinfo-aarch64.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
> index 4ce6deb7c82..e3446762149 100644
> --- a/util/cpuinfo-aarch64.c
> +++ b/util/cpuinfo-aarch64.c
> @@ -16,6 +16,9 @@
>   # ifndef HWCAP2_BTI
>   #  define HWCAP2_BTI 0  /* added in glibc 2.32 */
>   # endif
> +# ifndef HWCAP2_CSSC
> +#  define HWCAP2_CSSC 0  /* added in glibc 2.38 */
> +# endif
>   #endif
>   #ifdef CONFIG_ELF_AUX_INFO
>   #include <sys/auxv.h>

Queued, thanks.

r~


