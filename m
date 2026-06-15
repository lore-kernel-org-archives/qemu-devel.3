Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CAFCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZAUs-0001dJ-4q; Mon, 15 Jun 2026 12:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZAUr-0001d5-AR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:49:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZAUp-0006AF-VS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:49:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c0c35980fdso37269535ad.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781542150; x=1782146950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pQJk4wOKZKhR3Q4aiKFWd7btZM4Qvq4ib2JXf0pnZUQ=;
 b=QyIboV9TB192qUPCClN39zrlGUjgoW4WBgtzpmz3PyX1j98b+pKMKJWIxdlfUD+BUd
 iQRxGlofbBBj3QIUr5y6pNzWXR6kIUOPqiloFO9na3nbVdxoo9HZapnzZlVSsLRi06Dr
 Dx1V+kBWi6p+7VBM9r0h462OyOA6oXxszUUqC5GaPXAKYybwTK4pn4V5KPaNmsqIWM/x
 4AmtywpFr+Leci7gEu2AVv00FP/zyFI37nrrmea2luvOPSFoJtZx4+R8Qc14oPGfJKfo
 GF1Jim5oJkK17vCbXiHsX2LhLPttT5qV8O5xWbu3+y3AUXGpytx4LnsNK7RB58wic8qZ
 F3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781542150; x=1782146950;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pQJk4wOKZKhR3Q4aiKFWd7btZM4Qvq4ib2JXf0pnZUQ=;
 b=Eg84EIta/bgVX+xvZSTjmpL/UtifSRZnfxYM+6dYVX0iEFA5u+u5GJOPDqUKogjnts
 T0W4F1Bi/GMyacRtNM8QVtdv3aq/wEpgN6xJecAl75sklTs9f9c+rTI7K1v6Uh1Fr0ng
 OZ00iAyiw+sRXw7dxnxv/orNYGlNG6nJlIE6dNfbRiW+IGDkjKWYuUxe3Sq3TP5IcnMM
 E/wi4Zub8Dr3gD2LxdTm6kFcjApuoC3a2/8ISHI+LbJwG0zAqJHhkXwLEZkpHdRztsv/
 I4AuVg//hGSdXArnAC9yKPLTNVYuZ96tRsQdULz29uMPTezv5fMBwpoZDlarrrrjDPF/
 sHwg==
X-Gm-Message-State: AOJu0Yy/AlNB+xnL4s/CUKsOFwnszLp3vq9fjbjTe437gYymcqqLG9QB
 xSO+FcYZrDeOvjeY7Gjx6TjKgCYEXhxYogpg6FnOkPotOna9qyPXiur+j4yoZ2SaYghXBaqBUQx
 zBuZ1
X-Gm-Gg: Acq92OFgERWZFUbD2cqSCVi9nsL181JlQstO6W6R8WCbolli5HyU/9NeuRI8lhj1//x
 qF8evekWZ+kFLvKUuaISrxEGImFqZoT636QBLX8QviCSOnb0Cb9dvd3J8eVLTQsAAUtobiw4IoV
 C2KuCKtCfEJ78whNosxYpgLnFxC5zOxN0//BocYjeZ7oUZksaapr7OHOIkZ30HDIARTBBUmU0Lx
 JsdapVW0KIhhDkhiZ21hmICLoWyXYg216nMfuc5wAsqTJ2E1tmNkAn18BFsngHNUimRjkV9E74I
 hZ4mMEW+LVl34mzfkzJ9g+L1kU+KBhFdS//KY84c2euo1pMFi31ycHxIx6R5yt9IWtmZRDuNTB7
 DwF2oSBWTTM4UhnWRAopETGlr7WHPnPjv07OxbwQL4eOkgqrwHK+rnFl6wv94sfMsdy9Lbzm6hh
 VzOWSztLxqSxgf4xzOlHSZthNOPj4XP3q+1kS/CfpOogdwyCQ=
X-Received: by 2002:a17:903:2b0f:b0:2c2:d910:db05 with SMTP id
 d9443c01a7336-2c69a1b06d7mr219215ad.29.1781542149849; 
 Mon, 15 Jun 2026 09:49:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c91b2sm108463795ad.28.2026.06.15.09.49.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 09:49:09 -0700 (PDT)
Message-ID: <bc7ca271-9a50-44a3-a40d-ea48377c4809@linaro.org>
Date: Mon, 15 Jun 2026 09:49:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] arm: GICv5: minor fixes
To: qemu-devel@nongnu.org
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260615105029.2898872-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/15/26 03:50, Peter Maydell wrote:
> Peter Maydell (5):
>    arm/gicv5: Add URL to GICv5 specification
>    target/arm: GICv5 cpuif: Recalculate IRQ/FIQ on ICC_PCR_EL1 write
>    target/arm: GICv5 cpuif: Tag ICC_PPI_PRIORITYR<n> regs as
>      ARM_CP_NO_RAW
>    target/arm: GICv5 cpuif: Remove ICC_HAPR_EL1
>    hw/intc/gicv5: Define and use GICV5_PENDING_IRQ_NONE



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

