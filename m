Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E14CE8D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 19:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJzOI-0005FV-4a; Fri, 14 Nov 2025 14:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJzAF-0005wJ-Om
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 14:08:56 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJzAD-0003zL-UI
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 14:08:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so13586715e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 11:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763147332; x=1763752132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=grC4bnSGbBPY7VQJMpAUPZhA8iWfNhAwQLNkM6hSOtk=;
 b=nBou3awXIbDfmVyDajU3cTR4e3hIXrtbtIIMjxgtu+lus2soup63FnZNlI2oJS3bw6
 xJHTII4S+s8/tWfAcWGBGIALvkrzI6EfAUJFRiu+VuK1B8OvgJdqC0y/joUwzIs2CxrZ
 7W8BY5TOyIcPJBrySsG4GCLEDPZxxuWJLB9XljTGaxXfG8N/ryNtcwfMVuocIPEJbE9H
 t76L9ZHgwnCcNa2SrxUoM7J6RlUt+sMZ3c4EbtUQnM8PXrndnAGx9XMkKBrff7VdzBiv
 68SbXx8d81CfX6J1GTobW3L5m0HlTNUjA6lTZkENzpr4FmCmWoLaRDpNTQHOIGCQzVEj
 hmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763147332; x=1763752132;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=grC4bnSGbBPY7VQJMpAUPZhA8iWfNhAwQLNkM6hSOtk=;
 b=BJVQo3J2erDla6/aBG2i92ouJRS2WSM3qwZoOSp8aBh5RdQX+WxGCbrpq9SDcIKp96
 bAiWL+tSWf4asrzHYeEaMHWu7EZ1zjooyr6EmNGTHCc7034E6iB15Z+OWCcpbAseI9jg
 3z0358Yae953qWIZSowSA9S/K2PD9kRSRtZAvwpLySO6xTl9VPiC1tROhYoMiwRjNDsU
 quWgxaJmmuYKtmcneRh8qAGzGtGdLgsvwmDnMpS19Hn7hPtTB2tIQcrSkuNizZi5bSNp
 IG4O6iKibBy5XgVwOtcP8VGBr/OeYvC6JoZB1lajH4CQjN7gLs+mjYDQh1fxmeimU9ZG
 CNiw==
X-Gm-Message-State: AOJu0Yw0EhOffvyaIcJ9p3rDy9bjWsfbq2WNYjyJoj3LBNwYpC4NzXTQ
 huChU3tcfNadbWNHKCWPAvhhxeLO7NFuKKyi/HZscaeiQE4FAIQaDSMnp7ZuGfFMGCcX6H9iUIM
 g+wBQa9w=
X-Gm-Gg: ASbGncudatpvDo/QavpeZDowTHaBmT3mffyfEBWz3WZ7laZA1gD2bNZ/8z4L2/j/dle
 bIRA9GxKQ83l5LlWa9YTYucBeHsVafth3YwDGysCr11stzsQqFh4eU2aQKMW3ACEC7L1OeyuQ0f
 ZakLvUyK0KCHnm6YcRHrKxg16c/6CFSJo8uaKSCWipGYbxBJwt2sPqXZoabVoRQmQhu/2Jsqqhu
 ThiyTDrocpOHZc3/7f6rJyeHWjWGbhX6oHioluRcBQy78HXat+BNGnXWDm2a7xUOTDYfia+4Z+2
 y8H8f5v6UjLJ05DrmaYoVSG3E5yM78AmCNQAXn90qAb52TXwrkABaEvnnK7jOiEBOL7UonzC6F2
 m84/4kwHUFHe8RtACZVfe6/1xaIFkwnQrvZNxlmUZiiMoDDSlBwbO1+bRXvLqGj1/U15VC81Lxy
 DIOWtxWGs+lE4pk/7eSn5Y09c3QLmJ4yuQyh8vof2a5BJcG+9vqPVmsUbi8A==
X-Google-Smtp-Source: AGHT+IGLyWK+XJeK4/5XY29tpmIah0R6ZwVRLlCyE9ne6x91pMVRPqlDsyEP8vYytWu5+is5Lees9g==
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4778fe4f06dmr43811045e9.3.1763147331869; 
 Fri, 14 Nov 2025 11:08:51 -0800 (PST)
Received: from [192.168.8.105] (86.red-80-27-231.dynamicip.rima-tde.net.
 [80.27.231.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e2ad4csm167168305e9.1.2025.11.14.11.08.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 11:08:51 -0800 (PST)
Message-ID: <4b6521a2-8399-40ef-ba64-af58096b56b9@linaro.org>
Date: Fri, 14 Nov 2025 20:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] target-arm queue
To: qemu-devel@nongnu.org
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/14/25 16:21, Peter Maydell wrote:
> Hi; here are some arm patches for the freeze; mostly these are
> fairly unexciting minor bug fixes.
> 
> I did find in my CI run for this that the check-python-minreqs
> job failed with:
> "ERROR: /builds/pm215/qemu/scripts/qapi/commands.py Imports are incorrectly sorted and/or formatted."
> https://gitlab.com/pm215/qemu/-/jobs/12092087877
> 
> but since this pullreq doesn't touch that file or anything
> else python-related I assume that's a pre-existing CI failure.
> 
> thanks
> -- PMM
> 
> The following changes since commit 9febfa94b69b7146582c48a868bd2330ac45037f:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2025-11-12 11:47:42 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251114
> 
> for you to fetch changes up to 522444744eb79dd01e377ad2ed15544f10bcc70c:
> 
>    hw/audio/lm4549: Don't try to open a zero-frequency audio voice (2025-11-14 13:20:10 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * MAINTAINERS file update for whpx
>   * target/arm: Fix accidental write to TCG constant
>   * target/arm/cpu64: remove duplicate include
>   * hw/display/xlnx_dp: don't abort() on guest errors
>   * cxl, vfio, tests: clean up includes
>   * hw/misc/npcm_clk: Don't divide by zero when calculating frequency
>   * hw/audio/lm4549: Don't try to open a zero-frequency audio voice

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

