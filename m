Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C48CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0zp-0005jd-Fg; Fri, 29 May 2026 13:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT0zl-0005eK-Ku
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:27:41 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT0zi-0003wt-Pl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:27:40 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c858014845aso161290a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780075657; x=1780680457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GAWccsJkx68H38nFzgCXTzlNqiVsQnVapIdV4XjbSLc=;
 b=n2WiD0MPO792mt6lHhBdlhhAiZaOGrxiOEcZ8YPICwH3lxGYyy2wG4Rzez12hKndd8
 rnDjKJ4u67Wgm/BzqEtLaO6TQPkR/Qm1L/gLVdHQh/Jdwz4hQAofC/XdPMXk0DUT+TOC
 okHlAhmeRIae/Tn2n0+GCvffaXHcAPVGKrD81yMbUWqK7yZPRtXcw+lNypkkp7Gg3MMW
 fdfC4K2//IQI4E7n/gLoE3ZcDsJUyNgr7MZ3A2bVICHvESpVtl2IIXqRra24tTuuqc6V
 JZOfEEygX0QmWXWP83HKeK6ncqUXOmzfJ9YOxEmUXEgXRyHhEloVo2mnyMAXN38rtH1S
 1s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780075657; x=1780680457;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GAWccsJkx68H38nFzgCXTzlNqiVsQnVapIdV4XjbSLc=;
 b=kB5j7C6Nb/9Bh/hdSSmcDCKjq7aFVqds4EaJvVI8cINLz4JVIryDiyVkVVb4mt0/wZ
 9xqFNAu0G5JtpwfKZWamYA3AUHQEMiO+p+6yCUpR4vPbrUc4HDXg5nHhS/9vL0RT/efh
 gbJ30LmjgtUkZRotPr9FAP4PkAjXBSIUSv+XH+iGY95dMaoW5iNHuHWdOzkznsHl1Xo2
 a0ryo357ONQxkz2JVOWxTEd73ooSH/rTUSFK4Wx6RmXWpJz3PrckNe8qT+fCZDsdJ+nY
 OjhN1CXrWcPb6SbZh7TED9ie8V8WKRb/0WyKZ6+X5oN0PmTw+RN3Xlia3ltIHuGqPD4P
 FSrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EUj0aA2A4+tIBKxiuh7JfzFlVscd/YhDOfgQdr3f+MFksMDXBCag/ntoCd7UiyQCjG06FXMpMeI05@nongnu.org
X-Gm-Message-State: AOJu0Yx+jw55/NlWSHcuqHSUP6DtEt6vjMSXRkLxPmvQ5lw9fUHnkFnK
 MTM4dj/jQe5EGJ5l/OUVOEfwhvtsu7jx3SG0y2EJ1RumwR4pgdN8sRHL0aDXB+mQxYc=
X-Gm-Gg: Acq92OFYEHivTVHWxe6xdFHgFIHltrKTUAwDEGWGXxx7/hTDmRiFuJKcXLWQzK9gQBn
 tUZr7GNTLsOvPHV1/SHEo580LA7SH3kj2DQUwqvwAkjvd+DycXH20Qce+T2ixyjdNCW8yDfNdRa
 dFatBQhR0uvxkYPa1dO9IfknE2OX91szsups+msd9B8dpqzFMNbo6MrgDt2FvOQoNmM1GvrllTg
 Ca/veI0gsZriIzgT+S8GcUjEUB/JDCsVtRMew0+SvZJy8FnTQFvJbR7cwSWX9KN6cI8MiDJzwMN
 7Pjfn+b1Xh1R2cdQWS0YGMeixSCElNZ1A9A5IaiRj07QJlyae33GbM+uK1q59o2Pk/5gVe2BwXG
 FTCwbPcwgDBtMdHa801BJaR5LFs0y22K6/QE851W4Bhe9Q++6b4ru7kZ8gbC28z7FWkbnqdSOsq
 hXivcPNMjD4VTt94f0gc/u3OxgdTw0WdaAAMY1yyUnFMukd2s=
X-Received: by 2002:a05:6300:670d:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3b40fbb0aafmr4246269637.13.1780075656943; 
 Fri, 29 May 2026 10:27:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8583333e80sm294077a12.18.2026.05.29.10.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 10:27:36 -0700 (PDT)
Message-ID: <78b42dbe-1261-46e8-9aa4-cb6b38443fc3@linaro.org>
Date: Fri, 29 May 2026 10:27:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw: arm: use logging rather than hw_error
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260529143624.158935-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529143624.158935-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/29/26 07:36, Peter Maydell wrote:
> These patches switch a couple of older devices away from hw_error()
> for "guest can do something wrong" or "guest uses some feature
> QEMU doesn't implement" cases, replacing it with qemu_log_mask().
> 
> These aren't really very important, but I was at a loose end this
> afternoon and they do let us close out a couple of gitlab issues.
> 
> -- PMM
> 
> 
> Peter Maydell (2):
>    hw/intc/exynos4210_combiner: Avoid hw_error for guest errors
>    hw/dma/pl080: Don't use hw_error() for unimplemented features
> 
>   hw/dma/pl080.c                |  6 +++---
>   hw/intc/exynos4210_combiner.c | 29 ++++++++++++++++++-----------
>   2 files changed, 21 insertions(+), 14 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

