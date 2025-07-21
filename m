Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608DDC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlmb-0006A1-Ow; Mon, 21 Jul 2025 04:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udlmS-0005zT-DD
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:21:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udlmO-0008Ow-Tj
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:21:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so2091334f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753086106; x=1753690906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XhhH/TzG/troxEq8IYIlg1IkMOI5clr0JWF/dc4Mp2M=;
 b=TRZSZ1Xj92mT3PX7SaLohzofjFqdAkxSwPoJfwym+AgYER+OpuQ7ZJ/ednDU4AgGXL
 YZxN9h0DXkYfoj/U8XWjpa+n8J3u9cT5tMExbq/k9IxBKjkj3X7Rzi04anm07b1b1FWm
 2GhRZKWO69631ijlU8KoHxU08fVSJQYv1KP2FSMtFKI7YZ93F3ZNVbPWxJhoXcbs31cK
 +H10lInnJzkIUFZ317W1UozboqAmlRNmq+zRMzIjh33rVHqtN23Nx2NHxprLT1hVB2Dt
 CXOkV7cVeYsK+1gf4h9RZT0oAvl7oDPVXu0Z3ob3LMzrxeVfwCllIeTx5DmzcAy/248R
 13sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753086106; x=1753690906;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XhhH/TzG/troxEq8IYIlg1IkMOI5clr0JWF/dc4Mp2M=;
 b=uGLqWG0ddx7D0x8eqTCVgFGsRQBElC3Yy2JDSA1CFRjELkjqRxw2P31OiTT/rmk2u6
 vCPYY24XMKmRoAPQ4O/6DMkpGDaJLmc2HrK03pZ2l84FqBbkGFh8HAQ+DJ6r9ISN0tNy
 zk9O/b2rpPQie/xu1J38r9f0C48fHACdCmEfKAZSj++D9hT/AkHr2z+lmazc7kIONQs2
 OrXLz7tqa2t0I25HkVso8lEIAxX9Gny2ZW0WPpp+qeb7W/iohg1r1er9beeir1OdGr8z
 gAV6t0MDmyDXSYVPDKTm/Ry0DnQ4XQIpjn7XsFpcibwReviou98Z2NqbDXXtTE68Z6JP
 nGcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5hbCLNKdwSPDNrTCUchwhyc2rh+2rncPA78Uas4914WciU55Upuws4FYW4gLU1ODR9MWoFxaC7WlT@nongnu.org
X-Gm-Message-State: AOJu0YyBL/Iu6PNmpEBRg7lsFaADK+yaJRjm9FFkV/AyCVsJesFIWhns
 6SHB3ERLSHCSVscAojQQDiZCQCp3D9kS+t1pgyGpXNO1cPvM2p835dhLHXo2153C8MA=
X-Gm-Gg: ASbGncsfYyKL06J9PX6hVWGK0JDaBxfmNLZTz8NI3kBHtC4bw43zDM6Bq00rHL2/4Ep
 isLI335qF0L4R4ku/I6zlp/lESsozYpt479MrUtnin1idHgeC9wxTl5/suBl84xOJl4bOfA21gE
 /7V7oHXCtjb76jf+vcz/S+SZAl7jfQ2nk3wa9rilpq0USjlxwrGK2Ko5wzr+4O4SGJk8RS8jFBx
 TdqZ1frjRKn71I3JbrJbFceZthuxDPeTcGgjkoCIUSyifZFZCITmb0ATCFsK85S0V4a/0BpNiV2
 FF+atf6HV494TL5LRAwRUG8DpXLRQIe73epA7n9FKW7OpgP2K8De+M7Bwjso4T2TOnOgfXDm9qt
 3fZgOEv0xGToexMD22Bu8Lo2sPz9dtwu0d8AAYEM/MHGD8Zu+vOk9cBCRGwwTiVlaQA==
X-Google-Smtp-Source: AGHT+IGgEFYIv41LqdabyFeNifJaSJroT+y2NZTTF6S7XFwc6+OXV6t1yM6YAQRcxsNxBL7227504A==
X-Received: by 2002:a05:6000:2285:b0:3a3:7ba5:960e with SMTP id
 ffacd0b85a97d-3b60e5532b1mr16223901f8f.59.1753086106202; 
 Mon, 21 Jul 2025 01:21:46 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b5c84absm94699585e9.16.2025.07.21.01.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:21:45 -0700 (PDT)
Message-ID: <a3ea9869-dac7-4c20-9c07-5623e137a7f8@linaro.org>
Date: Mon, 21 Jul 2025 10:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 07/10] target/arm: Correct sense of FPCR.AH test
 for FMAXQV and FMINQV
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-8-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250718173032.2498900-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 18/7/25 19:30, Peter Maydell wrote:
> When we implemented the FMAXQV and FMINQV insns we accidentally
> inverted the sense of the FPCR.AH test, so we gave the AH=1 behaviour
> when FPCR.AH was zero, and vice-versa.  (The difference is limited to
> hadling of negative zero and NaN inputs.)

Typo "handling"

> 
> Fixes: 1de7ecfc12d05 ("target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


