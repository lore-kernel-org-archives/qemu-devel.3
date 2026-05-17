Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8587CCD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOf8Q-00085W-3L; Sun, 17 May 2026 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf8K-00083M-RE
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:18:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf8J-0000k9-D1
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:18:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso11237325ad.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038310; x=1779643110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dTdYWoNbYTebKkpxuutWdzy+3Mer7uVGN/BkklGUBW0=;
 b=shQFVIx/1nHlkAyNjgO3bm/Rss4P40TqIZcJTA/0YzeJtcP3OZSBVLtumWmcoV2Wzz
 ue8rUiOwUokvqVhr4GH3csSqswl2OEfCmGED4DXduPRGDKikJIA5zBZnn8OPmHRBBhRX
 sbHXFTqZuP9bSVWsWjfMXI8a3BEmUyYCMORfTkWcYDR9Wq74iAUvc2MYweYBv4i5DYCd
 3Bvzmffk6hMJwbK6oO6837CqHKOA4AjRQcRmsO0C7vjlb0guwnBhXADivbW0JN6Bt4AK
 aue/KWFVCwPK0I3nDL+pS83ZVFkA3IL50tj1X1Rtk28vDmvzivchLciM8TQKkFjOH+vg
 1GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038310; x=1779643110;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dTdYWoNbYTebKkpxuutWdzy+3Mer7uVGN/BkklGUBW0=;
 b=JcslRODvFVqC8cz/UOC3o2ekc+YNiEqyLpPzIo3Scp5KZEBxXwxSd5MZQzbjMxoDDA
 NsU3W8N1zq7isla1FCJHV4prsC+iZ562NSb9L9ZbHcbwM4k5BnSkqZG7a54musazsffL
 2RwBr6+LOjFTbF8MmNHWW2tGkO9znua+DRcrse867SR1kNbgJ5FpQAWQBnPX3evfySaj
 esnOmizGQeHihkt2iuiMFQDocShXFLLoJQRU26XnPWkBS0pFdo8IUPs/nLTE7FYGnyMs
 LBOvsHqEzosy3av3gaAVUsqVkTMD0ydcLDK6M0UIgI1zJCNGWGf0STqKmpAUMAoVjX3E
 thrA==
X-Gm-Message-State: AOJu0Ywpm8yvzNmNruobOjZMJmfu/pGE8OE9ni+r4TeSB9eyv7M9qRml
 VjhwW97PK7stLNayB/zXIChreCkjvREG1Lpz2WngwofCljuxyzw8gUF83G0q6Y5b+e1F97Jvifj
 R/pG2
X-Gm-Gg: Acq92OFSNbCkOafp08GCmqZ5IaKbGrRIa0lo7tZjFekUrIDgbNoKuAXSGQqr24ae9b0
 hg3q8Dgq7sFlZa44134jhn6mNoH69nFCzHIf7ZgFA7PAELj4LztVbS/vtxCotIjTC3dkkeb1PJ6
 e95d9bUhfce2UjpdBTDIKuKugrCZNKDUDtDR6l8fIFjLCYMfchTHnrmSaeZG5NGT5ghFITz9EQA
 ZnQhkEor58uyoghmY5d/aMTJXeYtrGHoNc6FONNNIEmzFY1G8PLheMuDVURzaN80mjhlBgqVRs3
 cOxKGwC0dV5wq0mfu50/oO3SLbslgCOx6AzKfKcrw3cDqSlJcO6v9oddBvHo4I8jM7mSk8cHDL7
 TCpdtl68t1Wq/no8C5nw/JqBRG+UY/k7DOSXK3bmvJaV59VtDpxmI7RmFpEdVbIYPk5bM0yY8ob
 CCbNg9WHtEsS2kP+IXijx86I9Dq9KQM2cjEc15
X-Received: by 2002:a17:903:b10:b0:2ba:4ad9:70f6 with SMTP id
 d9443c01a7336-2bd7e93871emr128788985ad.31.1779038309648; 
 Sun, 17 May 2026 10:18:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d235e04sm125904255ad.80.2026.05.17.10.18.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:18:29 -0700 (PDT)
Message-ID: <c9300c93-b20e-45ad-9b93-d23e19e58a80@linaro.org>
Date: Sun, 17 May 2026 10:18:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] hw/dma/omap_dma: Remove unused ifdeffed out code
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> The OMAP DMA device includes a lot of code which has been disabled
> via ifdefs for over a decade. Whatever this unfinished development
> work was, all knowledge of it is long gone, and we're unlikely to
> be doing any serious work on this device model in future. If we
> did, we'd likely have to start from scratch.
> 
> Remove all the ifdeffed out code.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c | 94 -----------------------------------------------
>   1 file changed, 94 deletions(-)

There's a bunch of code that's mis-indented after removing some ifdef'd if blocks.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

