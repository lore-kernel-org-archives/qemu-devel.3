Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B6C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyhg-0002il-Ql; Wed, 02 Jul 2025 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyhP-0002hW-8Y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:44:35 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyhK-00071L-Nu
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:44:34 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c14138668so2178810a34.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467468; x=1752072268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XTZ0xPNJY/jAje7Veg9SPz21a83Bco6ia5hyedQFDiE=;
 b=M2zK1HAT7M7HCEcXa2EwkpnTo/6EODMHcpGdYVgYP+yVPKi6bmUngc2rNlrkRN27ZT
 dkDn4E7cn2LxX3QF8RJPPZtPnOU53aS8bPyD5KccVl4U6pUisvnZFMmSEcpSyl9Q3lOt
 R5KBzCc5yS/s1cIMvjAnfUlnAc8laawjna0fIBzfkvX6W0XpSN50IiW1rPAFMGM0BxSX
 RRWNe91mbV2Tqh9BJmSsrxdpgnixuGugpKiGFgwgKIrPzSk624INhN8I2WM0GSzBozwG
 Ng6fslcgvwmjXN4LV5SQw8JxisT1Rldx4RY1DbtBraXokKOY+hjiAWd8mU3t0o24mAVl
 TTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467468; x=1752072268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XTZ0xPNJY/jAje7Veg9SPz21a83Bco6ia5hyedQFDiE=;
 b=thiPUMY7Is3pDCg/k0OhrYtCULeSir85YWoSeaxZ0+bXV1eNVwwFu94309WfPDju0f
 HNQ3cUq98UCN4ehGYsPI5TnHlz3yxjm8rawnpWGvpdBUYOS6HFmduD2pEeWUvEMyCNSq
 diXdaKLGG3adkwkXjS1C/TEoLsfE++G7M0O8wqbUovAA7Priaddkk1YY+kLZvGXCwGZ/
 anyo7TmHs55MvOABtVD7bJjuNI/2TYoVbF7t/ytJmgnz0yiyWQXdf63bWNUiM7sUgvkj
 icml4SuREYc3LHoH0Qyc5bnBCW+7aVOkcuWYlEeVlMXj6gesXkjIQFvnA9pYWf96sWO5
 4kTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYeDLxabZOkONFl60z/QEYT8EOKwsjlA8G5i9lnjFHFKBUQqamR2Vg0TJikBQovPpIpVSMHPQY0+Rr@nongnu.org
X-Gm-Message-State: AOJu0Ywm8Gt7fBb3LqY0k9kOnRRl60k9ican0baXsPRmlI7EtvOQv2Ga
 yYtSmudNApFkWPZiVvmBrpA0slJwK9g5D6O9qejdH2ScGOYau4V1Tu+WlDtMnfreyCijsVjpHrk
 snlJ0LhM=
X-Gm-Gg: ASbGncvXh/6eqlUIta592fqrMaZM/rUxY7fc2H+5c3wk+YW8doEq9mQnIVsbxvTYHUC
 K/AFU3dQBmHXOqk2Z0fN76xogrr6+b+Se55no4yPkbU4+X2hWT4XU9NQg5o4Xo2zkkWV4fLeubG
 RZkOea48lq7AnHSAdmgTZuGAABEKYpXRhUMu1KiAx6KLEdCVOGnlqJXhCcuV5YTxovX+FVGdujE
 M3IbTtAEitRFNybFsuKBvwRef/4fthpsjsJB6rCccDDBSXuONXeUhzkeBteX/ZCsxNImSCAGb9r
 IejzEeAdW/2OyoMVgh80Wo4oRDawuNy8aa+Qq90acpI6FtFGfG83d++8kC+H2E6D9EqPg+bt3x1
 m8f0s1mVg7hs=
X-Google-Smtp-Source: AGHT+IEC+04jetamDhnZs7rXj44pC+lS6vowzlV5pGYIqL1askvQt19acvccCz7TSd3Eix6x3rQalA==
X-Received: by 2002:a05:6830:2d83:b0:73b:2682:5b2b with SMTP id
 46e09a7af769-73b4cded16cmr2609604a34.8.1751467468023; 
 Wed, 02 Jul 2025 07:44:28 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73b2c5a1a64sm1242467a34.15.2025.07.02.07.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:44:27 -0700 (PDT)
Message-ID: <bfdc5e5d-40fa-49e6-88d4-b70dcbdfd71d@linaro.org>
Date: Wed, 2 Jul 2025 08:44:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] target/arm: Fix VLDR helper load alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-5-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-5-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> +DO_VLDR(vldrb_sh, MO_UB, 1, int8_t, ldb, 2, int16_t)
> +DO_VLDR(vldrb_sw, MO_UB, 1, int8_t, ldb, 4, int32_t)
...
> +DO_VLDR(vldrh_sw, MO_TEUW, 2, int16_t, ldw, 4, int32_t)

Use MO_SB, MO_TESW here.

It won't matter for normal operation, but the sign of the operation is exposed to plugins.


r~

