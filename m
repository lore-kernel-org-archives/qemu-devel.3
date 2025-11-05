Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 12:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGccu-0008AF-Cd; Wed, 05 Nov 2025 07:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGccr-00089O-Rb
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:28:34 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGccq-0000Ud-03
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:28:33 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b713c7096f9so490366266b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 04:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762345710; x=1762950510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I5IFJSjcP2PIBnX3Hmyr7f47ed8b0kaOA+DQtf3T8+I=;
 b=NYBQuVs4JmQ+EWVfW5PEkCLVwOg8TsB9H+C7N5IPdx8PBoZy+AbxhfTHQAPPc0MEb6
 gbvPQIfT4b7S/eDIhnbfc6vMFULRA8OW3mgbTZbxSoH8YXEoYIZxyQVvNig04b5G2PWc
 5QEF+nubUWUpiYJrYNCFxI5vyY9graE6OopRb8zaUROqA4cquCrjFJSEjsHzTmRx6vZq
 LWNpiwuxO+BUPuRCJCf4AOxISF3MB9j3yFm2nF3jzG2R0fouQTRElnBdfmBnryTfH7Ql
 PS1/jUXwnwz6FZpk+SBpfo4YNwzDb8qfGfbyv61vVyTz5/coMMsVHBlUyo1xYAmhWlVu
 Bw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762345710; x=1762950510;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I5IFJSjcP2PIBnX3Hmyr7f47ed8b0kaOA+DQtf3T8+I=;
 b=RZ/roA3aO6ac8EfmGTi3AKi3Tfmp8+UFz1FHG8u/n0OXvnKHIpFF1jKIzwqww158hT
 ZiUGYf8wq4yrHmiAOErK9PxYzpo4k+cW/hpsMxl/Vi9AztRBfqgdxg/dNaOiEVRkEaih
 5FBiUexk8SKXQQ6A9kMOtgQuz3u7sh4uSt+sR8H6wNU0XV69Lg3snbpAEDJf889pw6AQ
 GeTEFfUnR/tx5HUCgM2HpLHfoOSjtfKRNqU1f/cNqpB+BLV1CpCXnB63bbSwVfuBtZ/g
 qf1eNcONJyvDjCXTHkmQrk1lgLByBnBMMsRRB9eWDv+PNwt81tOficTHFRu4WNgfnGIH
 YVkQ==
X-Gm-Message-State: AOJu0YzoO0XdzDfkGEW/1nnVYiKLrTqAnKovuSUApE57FESJRcN8aFvf
 X2AeT+dcM/Pw99FH+W5Hq/REn6fEhKJ+8+rUD1NvGORV9ZZZnJgieITMVZI99zUn6VQaH7j63eN
 pcMn6cX0=
X-Gm-Gg: ASbGncszyd8CNa1OFQdDN6wj1EnWiyQet0Yu9iR8BxiXBccapF1j3qypXL/LOEUz2JB
 A/K7YlpxTBtdZlRnXbIBWJ7uU0+640QeFUz5mkpOf/p9KWYolExk1rA6bdXOGQkkFpR5Ag4lT9G
 PwyRtoLBlnQFPf5oVh91D63gFBGXPbC8OuW3mrXZ7MW3dsYsvLhJacUHGxWN/bvBm8qIRmFcPT7
 H08Y2qgIwBHjEms4xzjOHLr6PVX9se/Gq3hnGsp7mrFr3xGQ6WHkAllyv4OX6QU0l4mJsAzjD3O
 nfq1QBQC7hC45Vs66Y+WTK9hXx6b9en8E4uRb0h05B3DOMm/RESmW8YeckRGJISXbC3UZBH5tXQ
 3GcI7VsecGB4PmUcPbV0tI6c4BDlPpKLJ6cNRZn56ZNOOgCgwfQPvqxuVYAGco8DNHfjfRssf51
 obQVTKHsW0pkOggto30RtSU5JEXqM=
X-Google-Smtp-Source: AGHT+IF8sd3Khk/oc0LSL6XEg9v6jwjP9jRQkSSg+cktXZoTCI5olQPUjz9tMhMEeX0XhzxosrBgkw==
X-Received: by 2002:a17:907:3d4f:b0:b70:df0d:e2e9 with SMTP id
 a640c23a62f3a-b726552ff76mr302737266b.44.1762345710391; 
 Wed, 05 Nov 2025 04:28:30 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a2fe7sm501702066b.4.2025.11.05.04.28.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 04:28:30 -0800 (PST)
Message-ID: <72efd084-a2c9-44da-9bbb-966414923748@linaro.org>
Date: Wed, 5 Nov 2025 13:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] aspeed queue
To: qemu-devel@nongnu.org
References: <20251104083144.187806-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 11/4/25 09:31, Cédric Le Goater wrote:
> The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:
> 
>    Merge tag 'igvm-20251103--pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20251104
> 
> for you to fetch changes up to 1d2a5f8f5d6478504e80be0fcee5ca88adac5921:
> 
>    hw/arm/aspeed: Split AST1030 EVB machine into a separate source file for maintainability (2025-11-04 09:27:59 +0100)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Move Aspeed machine models in separate source files to ease maintenance


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

