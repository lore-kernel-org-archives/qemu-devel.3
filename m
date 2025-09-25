Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFDDCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kO2-0005ow-IA; Thu, 25 Sep 2025 07:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kNx-0005bz-Pj
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:43:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kNs-0001gX-4H
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:43:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso2777865e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758800610; x=1759405410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDAiVucDnTwiiHSxzVHmrYEGy/lbcg0azc/QRJqtC/I=;
 b=Yioey535JckLaICMepqPwH30v/3vdyHfQdBcawqQRwBD3Uzi4+tE+ccTPjfi9jWb06
 NJ4GrGx0qqmGmbVhB5A1Wv2fEZdWJhlI46A3eQPuLUYol8ryGMcoNxfEJS28NjpERmtU
 Mwhd4zSyMt0z+hvIHBTuyoLeyvKWfHzMFyrf7A+A5lsOKY8Q0NZ7HC4vZtv1euUk/hqx
 KbPoCHKqqnl3oxSSwUoYRgLFaQch8eYAt2t2rVjt7j71IDheRBKZMaGIgIYe5uDFZQFP
 lIjFZQcjqJoDbG8v+UYZkO8dwcPqKYVOrh6i+X2WQhZNgoFHrgTzRlr0GhHB4YiRfrpj
 4nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758800610; x=1759405410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDAiVucDnTwiiHSxzVHmrYEGy/lbcg0azc/QRJqtC/I=;
 b=A8lGqLE5INDfet3+QFeBUpmw5N2PeyHQD9FoHWmB3b6kJgxEQNfco0ocBcRQ6rQxfJ
 2KfrGNEQID9Ls4f1IkymqriRNiu+XRi2H8adxrQdM2NouojiiOsoef0gHULCPvWN/UT0
 VcojitZirlt2uTvEJdljim0rAHlaecEZPi9GEM+RbvP6+QBaGbgfBMS/jzKS/Ky4nCvb
 iDWLae9WpAyeoJCzHDJ0FoboS6qW+EmmqM38hiuXQ4l2QKjGW1FBTgmtK+Rjo6hXdGv2
 37tAXZW/1/mUfZiRbli2999d5vxkxT61sGhOAFpad4Srj8gDTrDfhIGAvYsoHWoukhuT
 wIiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz6p4P3NRNs147Vo7ioearJEbG31GqJFxl4oCPZ/zX2+b4sE/RZivipFHJ9UkjZVouMdgwNr+38pK5@nongnu.org
X-Gm-Message-State: AOJu0YwQSUWBMwsM7s1kvxoLatzyVts1EGwBneDazeHK0HUwRZDVf5s1
 FSmm+/eC3S925DwIh8hH9byhtJX8pW/ISWpoCGcy5mHIvSaYfSNCu3RB5eW6fYZvIwE=
X-Gm-Gg: ASbGncsz7plXb2rdXzg37o2c4taTZ9jLAAcrPj9W558dgxSElMzM+ad56TFkCZtr6Af
 k6SlHyfKqTDTLlc2mOHPJZFCvGnc4eb0vtwZ/viYLqdOCsYUWN2IP+VWeRgfB248OdIn4L0152H
 xC/5J0HFQNRu6Mh+fNvVn14F6n9qHRcxvfh7Mw1qBcnUFyp1glkjfZUzuQIBmR2yHtzACN6JQQf
 NCsHdUrNZEIrDDo6ON+a21yrjCRioZMGya6go4uRtn+ci5PCjFyxBD1L/bhfBcKIMvPXtMWnuOy
 Qu+kne7QOOj2BG+ReqwbmGdGwO+DI+gTJrqXlmM7+7nc+bPr7vXAwOyPvaFZtX9TS3oufyk9D8b
 9wxfJ2VRz1UWf0EBnC9GJxAVwOTA11OU5BKTX6nQDHUuNVbXBeKYpNvwK+kwHSBDa9efGcskSxS
 i7
X-Google-Smtp-Source: AGHT+IGXQj3czMKRZvVqAWn8ddQww0WzBhnnwCBzpJ+lAIsIiGqLFpbeX4pJRILyvR6x7IAI87pT2g==
X-Received: by 2002:a05:6000:1846:b0:3ee:15b4:846c with SMTP id
 ffacd0b85a97d-40e44682b8dmr3123236f8f.28.1758800610017; 
 Thu, 25 Sep 2025 04:43:30 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm2737147f8f.8.2025.09.25.04.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:43:29 -0700 (PDT)
Message-ID: <becd0683-f2e2-4795-bc90-e63d5a58fe5b@linaro.org>
Date: Thu, 25 Sep 2025 13:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/36] target/arm: Move writeback of CP_ANY fields
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-30-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Move the writeback of cp, crm, opc1, opc2 to define_one_arm_cp_reg,
> which means we don't have to pass all those parameters down
> to subroutines.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 52 ++++++++++++++++++++++-----------------------
>   1 file changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

