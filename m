Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65174C88E75
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 02:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6f4R-0005wA-4O; Tue, 15 Sep 2026 22:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6f4P-0005vi-Dj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:08:21 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6f4N-0001GY-Fw
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:08:21 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4d04d740cso341274a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789524497; x=1790129297; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q85uqIs4u8wzJt+UxzJlRpdwAkEQEAAanbvABUjv6BQ=;
 b=LtFwbO+DHYqYW5b8Vz47C4qVu2K4fCk71nYV2NvnNq/UYNoNvdhcCzEMGdeZLFeobI
 fOEDlWPIsScLYIdsL8Urs9fNvaEmECgwTc/aJHwB380nwPMerawQXU0PNl93oUOrPaVm
 20QWBBgkRg0jAy7fEOZvgopGI4lt2VRvxoTPr5rJOrZSwHQHRB2hQYRJDR98SMoP0A27
 BcfcVheD3bSzU/Ysbn795cc9lvLdZcQOzZdNJOZDBbpCZrjKr7lm+jWkGrBjwZUXFRDH
 i+q9f1AuKiEIqtaWTQsRMRoNXNgW/A45VEklPJhKOU2W/SGtCoGaFg6IO3Dyh8ppDx6g
 j5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789524497; x=1790129297;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q85uqIs4u8wzJt+UxzJlRpdwAkEQEAAanbvABUjv6BQ=;
 b=ZGbKcfW9kcijeyIb3FuR2RpADoB6Gim0hs2RGX3IdIc8Va/n2F4nzwh8oU38tMOkj8
 D+FAkAcK8WYWuS1sNZHMIDQs31ubCk7bxFBlfU+2/G5lyqBLNRQ2DlNDlSPafZbT8fqn
 qctcH3xYHateRQYCTDqx3HaalmThxfToAQlaDUQYg8kX2iXynOqoo2LQXuVVgHwDrRNU
 xLV2Cjtk+7DnqUZF5Hf2wYUHrZB37PBfugG7hzI4Aw7FGaXemtZRDQ6wk/6D6sGbkyA0
 houIvXjy/wNLM2vQRVvCmOxnqImSn/ClKC4e15d6MUtfy5yXtMXxEJnck0DPQAj2lLW4
 55UA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8t5jPyqrUSEsGtx2gpjYuXw+dvpqrPWdYQsWWD6nIpL4QmfVTVMBh52keHb1jDhJB+M72NzgkhHNp@nongnu.org
X-Gm-Message-State: AFuF++l9uobZv4La2wx4Km30z/w8BTg/2wv4M2fg5NIFE0coTjbxu51Y
 L+6DONwQS34IVTHmijA4SckSAicQtZ8EHede3vJ4H5Bg+hpHP+mtdRH8SRG1K0a+Bno=
X-Gm-Gg: AYBFou1i61WftJLgNbM9SwF88y1ueKXoanEdwzyOqMicA9WukDugHVoBJsLBYC3Zsdy
 Gn87Jj14hh6NnRE1PYr9SZKlS1fieXlxDSK1IoFA/bfj6cg2oV1Ijt0iow462QuCSFjYjvAo1eA
 iR31lqVjT9+JdwNN4Q81/vySClIf7J6ghzfmX/keODsbfWZX6hROQpKUesLV2wHKC8Jp2/g5OqX
 1CP352bsKUaEdryyRJo4XRKuMzfwHpammHc/GxvaD5mkrkTDFgH/dTVjtQydTosAozM/gA6qm7B
 k3mVHBm/V4iiROE2/mxU6js4gHmSYUCOUg07/ibJXEAUG7Ded9tj/b82wnjTfooHKh2dXmQ3VH6
 07wBJsUz9cIJ1HWNzdFNPmz6TOHXSFDgHsow1ob04XRiJ+cpaoRukKfXhtKud7G0X8ik5qjLovi
 nGCX524w5jXuHfHjQ9b5TBbAOuVFuyjSV/NyYAEJKa+u+SCv24fYB4C5IGiAUXlR4HTQPlDXPvr
 ZbXiKzqMTWlLnvtI2AnngGyWdMNj5ohGAjUu8tVPMcYKjRmOgJ53FYINlvqbhjvuT8MEztV
X-Received: by 2002:a17:90a:c09:b0:39e:2036:8243 with SMTP id
 98e67ed59e1d1-39e20368cf3mr1060510a91.25.1789524497280; 
 Tue, 15 Sep 2026 19:08:17 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a182sm3037316eec.8.2026.09.15.19.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 19:08:16 -0700 (PDT)
Message-ID: <eee80e9b-241b-414d-a5e9-624ea517db9c@linaro.org>
Date: Tue, 15 Sep 2026 16:08:14 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260915170735.425445-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/15/26 07:07, Peter Maydell wrote:
> Hi; here's an arm pullreq; pretty much all bugfixes this time.
> 
> thanks
> -- PMM
> 
> The following changes since commit 5f664cd37aec17e8145aa117d8da68f507edc8f1:
> 
>    Merge tag 'ui-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-13 15:54:17 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260915
> 
> for you to fetch changes up to 157f6c69edd0627f5f78f1f14ea0d831b0948c69:
> 
>    target/arm: extend PMSAv7 support to v6-M CPUs (2026-09-15 14:27:23 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * target/arm/whpx: fix whpx-arm post-reset CPU state
>   * target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
>   * target/arm/whpx: Don't try to sync ARM_CP_CONST registers
>   * hw/intc/bcm2835_ic: reject out-of-range FIQ source values
>   * sbsa-gwdt: reschedule timer on direct WCV load
>   * target/arm/hvf: implement MDCCSR_EL0 as RAZ
>   * hw/char/stm32l4x5_usart: Accept character input upon RDR read
>   * MAINTAINERS: Update email address for Vikram Garhwal
>   * hw/misc/bcm2835_powermgt: free wdog timer on finalize
>   * target/arm: initialize SCTLR reset value for arm11mpcore
>   * target/arm: Fix various v6M corner-case bugs

Applied, thanks.

r~

