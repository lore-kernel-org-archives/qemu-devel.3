Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E94C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq2v-0007Is-VE; Fri, 17 Jan 2025 12:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYq2s-0007Ih-6E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:22:11 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYq2p-0005rg-OL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:22:08 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so4302491a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737134525; x=1737739325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C7SyZ/6QyF+naxfL4HQBnLidax8MUd2EZKRZ1b6MNqQ=;
 b=D9RZmYnToCWXdj7Oxa54hz6CsvK8My39n07w35aYEtCCdUNzEJRqY3eM9p7lXWmkN0
 EFMzf8g3WKAOnVCkTpQ8h90kMgrc2qiSLqdJqV/8DK2wohDJFQ2y4e2CEC0XmLaDrtPK
 htUz7VdAiZqnI4kjLuDWCqLO6VOxeIPSz+WwQccL0g/pJ4dw8bp5ecK/vw+rNZKP25Be
 sBchmTN+zeg7vsKju4cE5vsb4Pve8shYZj4u7B2hrE5COMW1+x8C2CPGwDwTgwOdDnnF
 Yy217nVuex9XMBPBtqZ/VJ8T91rx9d9mLTCn/GEa8jUs10969AO2fKBwNA1CtYoHr6db
 u8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134525; x=1737739325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C7SyZ/6QyF+naxfL4HQBnLidax8MUd2EZKRZ1b6MNqQ=;
 b=RQKIEG2Q6DqVNuxszkGKJm5cz61MyuDhDhJjmJ2A1VdYFXq5IGGEAjAnwDcNW5bNWr
 WnssiNYcYs6U5KONixB0Bjm3xQ7+vzWO62rIcoUjekOfBZc/nBMiPP/sGG7skze5xRzS
 Uw56yTXzQuAqD0lEwuriJlV5OsRG2FvofqIBV0a2vmpUNb9VLtpeHFcCd4LH7zI7roCT
 KgVjiJYIiPoBTcvTGkrqGaFFxCyjNvQGyo6z8jVJ5jDAzdNY9WJQPYdmBvf8UR8+IEjH
 +3aF5yRs2a0C4xciAhc0tAvgcd2I/+1x8jD41VNqQfNNXVuRvsyTSb/c+Pfal7GRjtmK
 UgPQ==
X-Gm-Message-State: AOJu0YxtnCM2qaEmmapqRIwO8y/INoMDsAhX6srTo64/Vaabpwpu/ers
 iJfw7JVXRZAAZKwCZKTjVwPxGBINYVrUjRRDv+ysAIbNsjPyCYCyNoPyl9BqY4QKe+smRqXG/u0
 A
X-Gm-Gg: ASbGncuv+IP+N2fLbNyuV1g2Bl0lZ5nAbLDAl4eD0n1CgUazJgNDgezBcmZUQz9MscX
 5HshR4u8gO7sWhxxn1l1UATEi5QIiSQiF3bs2cPX7V3mj79awZx6SVZQ9eN+Od6Va+RP1oFPYjJ
 1aHVduSpafdQsL5YB8VOsE8a9vjSOMuOXx89h+wq9q2ASUiX8QEfn59ayAIeSAZjqKw4ny2jdhB
 DSGh2rdIDkfBoFMNGI2RvlaiJHS5qd3238ubgpfKehBO+sGQxDPIz3Y8zXqHSHblTGPS//fvylh
 hNlrn+NGt07vnDHFlrWKXlI=
X-Google-Smtp-Source: AGHT+IHTWuoa/QTmtxfEpEG+W3FBQaekRFhabquLEN3vPu2s4gKgcLse8EpL4xlOXMETgm8cU+vLBQ==
X-Received: by 2002:a17:90a:c88c:b0:2ee:c059:7de3 with SMTP id
 98e67ed59e1d1-2f782cc01f5mr5511672a91.18.1737134525361; 
 Fri, 17 Jan 2025 09:22:05 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629acfcsm2323467a91.35.2025.01.17.09.22.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 09:22:05 -0800 (PST)
Message-ID: <8885e7df-c3b5-42e1-9fd1-819f3aa2ad21@linaro.org>
Date: Fri, 17 Jan 2025 09:22:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softfloat: Constify helpers returning float_status field
To: qemu-devel@nongnu.org
References: <20250116214359.67295-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116214359.67295-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 1/16/25 13:43, Philippe Mathieu-Daudé wrote:
> These helpers don't alter float_status. Make it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

Thanks, queued.


r~

