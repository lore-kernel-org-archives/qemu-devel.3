Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC785D172CC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmXW-00011o-PS; Mon, 02 Feb 2026 00:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmXV-00011Z-Vh
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:31:58 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmXT-00021O-GC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:31:57 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a79998d35aso26333195ad.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770010314; x=1770615114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CqKoG0fr4WfEnP2W5Lj3XJSEkPExh+sgkX2Y2O03PJc=;
 b=sYVmNbA4y/8jcpqWGVWnkA/DOEggNrHg8UZkVSvmRO8egRccQQELm1D65J9mX223RI
 DLFk2rw7FpajI5XDEtYorFiBIAjL4lbE8LF1s2uOCHjqzd1w07P5YOOhOibVByftSkUa
 kKDEe1BbIfYP2VLQ6pgEEsfDh/Zoc5vfnt9rJ0yvFpzccH7EViTcUDxc3rqaORN32nZu
 PV2aaoPEYPvEcs83MI3x5SQYEPhRYQzKJBHLXBNowbFMkssSzprp5W1Ihah1TZ4ox9BC
 ctnwB9xhAqXe5E1LNtLVxPlZtZgBNaCkgBz/VeDL5ZBCuNtIqn6KqRENm8CmUk0neLto
 NAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010314; x=1770615114;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CqKoG0fr4WfEnP2W5Lj3XJSEkPExh+sgkX2Y2O03PJc=;
 b=pdHCqdT5TDVQ83YKLwRRguxs05m0Y2/UXrAb12A+FtQeFC3ThdW2e539RqR5+SJij+
 RinLZrh0WAnJ3OxcuRuhmxkVnl46wgjWS8Mx48/BooHCbOuabBow7HNo9pE1ukdmo5YO
 BRj6jxc8J7l6nib+LdzI8Ht2W3+27I5P4Q2Uwtx9ZgRXmb4QethWZMQwS8Hhzgi1t5wY
 NmKTnEW2L1J+UAggE3/dpI7cfn/fNwO3S+d484oqyCUtsVeQ8wjegj74PY2xLxzJFMpQ
 GBfOX8cgQuxmwqJSKAetJi+tM+QJAzYTiQJNOgMjId1yPCsmWXl+oaP7y1kzlbaaBQFh
 wi8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxk8gJ1DBhxAsywEe7lkxKZPr/xvOu5xT0YEUozN0xLh33/PK1l6PCLn2wBhXodIEfbsFSUheVo6w5@nongnu.org
X-Gm-Message-State: AOJu0Ywx5mtm9rB5V4q/2x4cNCnrMrX0LdmMQjOZVYoA6LtQvtreQOcP
 xTp8yXbsND0LO5DNp7j+V2mxp0xcAEtG28ick6OzL8hug6QcFBDNTxNZ+O8n+V4E28o=
X-Gm-Gg: AZuq6aKl6twsOH2bx66Melf0UmhALjK/r0YxlOzWrBSzgxNyNC8HvjPfLa/1bwfdtg2
 KM875hFZa2YhN6AfXmg3NB5LMfznOXTF71G+y3p1MaA0nvEmLQFmekGCKd/cuOkzFOf0Wm+mrkI
 rEeWNRjT6PzauDm5MW8UFslfNdUmmb5NVtEQiuMhLcuw4DEvO/TM1AK/pjuwKG8lKKX3rUBnYEd
 SGKMjfoynXItUFrfYSAGGy4PnqX8wy2Ln47Kdi69HXXhzrfwaKyz9k/amgseCe+V4+87Oh9OsrQ
 pnN7Dn2zqK0XGx/sobNbKuYFLF2X0AIvx8CmmpqmwvN+AOj+69DI2tEjSwKnQcPOlxz1WHiTtLC
 n3VzgK4fPaMyU9WpD1zfeZa9Mp+Z/R4yL0P5dcCSjgtTOYU/U5bcrOQ06oZEOhwNYlqpODxTu6K
 tIKvg2sNDZEWNpCpN8xUt0H+6A6pPzI4L2F+h4NmnKyjhitn4l2NfWPhpKwmAbYkqN36u7YVsxy
 x1HQ2d6WX8UzjfHErjWdGD+m+/g1P+eXJTNAyhA8A==
X-Received: by 2002:a17:902:d54e:b0:2a7:561e:690d with SMTP id
 d9443c01a7336-2a8d9943d4bmr93549805ad.46.1770010314017; 
 Sun, 01 Feb 2026 21:31:54 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 (bg30dj08q4s9ql12qb2z.ip6.superloop.au.
 [2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a8c3a23e40sm106004955ad.90.2026.02.01.21.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 21:31:53 -0800 (PST)
Message-ID: <d4488d15-6c94-4296-84f6-2d8de2464f6f@linaro.org>
Date: Mon, 2 Feb 2026 15:31:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm: Handle SME-only CPUs in
 sve_vqm1_for_el_sm()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
 <20260129113455.1283266-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260129113455.1283266-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/29/26 21:34, Peter Maydell wrote:
> In sve_vqm1_for_el_sm(), we implicitly assume that the CPU has SVE:
> if called with sm == false for non-streaming mode, we try to return a
> vector length from svq_vq.  This hits the "assert(sm)" at the bettom
> of the function in an SME-only CPU where sve_vq.map is zero.
> 
> Add code to handle the "SME-only CPU not in streaming mode" case: we
> report an effective VL of 128 bits, which is what the architecture
> rule R_KXKNK says should be used when SVE instructions are disabled
> or trapped but floating point instructions are enabled.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

