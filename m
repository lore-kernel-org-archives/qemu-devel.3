Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582E4CDD0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 19:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3KIu-0004hf-Mo; Tue, 22 Oct 2024 15:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3KIg-0004fX-UN
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:12:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3KIf-0006wQ-HI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:12:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20ceb8bd22fso51430855ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729624329; x=1730229129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=quLyhwwo6E+Bjcz8IHh3usljCZF4Cq6Ar1RLd4c5guc=;
 b=eNfihbbzYdB0xI30boCblVvXId6zbbmhtsWID9EDXA7pwKuz7Dmh+E6YXs2mjmszYt
 b2f816rEniiA1s0ijdObYOBPePgGiLRSctYdgLTEunrVGi6gfS0lFbDhILL/4DweMjso
 RhRLYa2l9YRFma3/PLYMjC1+nhkSlElfWeztiCMQ06njVQ2rUEqkZRloGfBycHsGTZ8k
 jv4DCLhvWqbxDyFvlXCHY2B8qDB+eHxUQZVf4dog+f0srtfEvjmTxJsHHnGEwVXsMsWK
 x9IgIZzwMq80XuaFQr/inHYuBXPp5kq6BQNLfR0x8qmydwSPDIPV0AfaWFPKW59i8q5h
 kW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729624329; x=1730229129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=quLyhwwo6E+Bjcz8IHh3usljCZF4Cq6Ar1RLd4c5guc=;
 b=uKAmMSI7r2dLGWRhTTDmvVcKYI2QY2HM8I2xfXzFRR8ScPWXG0QWyJTPzG5Tj/a8Mw
 +OIi6665WHH35tE/RTQzcd2MhQaNKrNTWzyTNuPMtJCB+S71wRFz1Vxc3GDrzEnzoyZ9
 On7q5tGHu9iAS65n2rWyv5Yv1kH3SnFSj7IBY2hVs/larzNPrKBzTduv8Jdoo9xhMdOj
 hqLPvmF63s5tz6cVK88leORC9w5iYxlfw9fE8Q0CdtDawKr/8zLKejC9J2Mz+tmJxUQK
 eQhDBhoAuFE8wu6oXlkCC30tOZCX4JFM7Y/oR5xdPb3sP2kjmlT/RT2jq7HfheT8rlCK
 OV+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6l75FoHUAVPqVqVCszwhGyaMoyK189ByghwvVdKOyGWIeW1u/13KvT4KBlXEWrGa3dBeP5QK6nhRu@nongnu.org
X-Gm-Message-State: AOJu0YyrzgTL6b7XCppXTD+KDZ6qRMOTmGL11P9maW+KXCsMpCHOumU2
 xQhPGlr0whhLlQaeOyX5soZ19gSez0JCAogm9rg6K5ZobhsaxLd/UJaA+A8IgJY=
X-Google-Smtp-Source: AGHT+IEc6suyUsmVQTbgo41KMiH78zINdLFMlN/I1oG4E1zwFfr9pNDqIWGHUyNmuTesyD7q67grTw==
X-Received: by 2002:a17:902:e5ce:b0:20c:6392:1a7b with SMTP id
 d9443c01a7336-20fa9e46837mr2393585ad.2.1729624329452; 
 Tue, 22 Oct 2024 12:12:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef0c42esm46155525ad.100.2024.10.22.12.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 12:12:09 -0700 (PDT)
Message-ID: <8d8b1da2-fd21-419d-8ffa-f9be29076d1b@linaro.org>
Date: Tue, 22 Oct 2024 12:12:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] tests/tcg: enable basic testing for
 aarch64_be-linux-user
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-14-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241022105614.839199-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/22/24 03:56, Alex Bennée wrote:
> We didn't notice breakage of aarch64_be because we don't have any TCG
> tests for it. However while the existing aarch64 compiler can target
> big-endian builds no one packages a BE libc. Instead we bang some
> rocks together to do the most basic of hello world with a nostdlib
> syscall test.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - fix checkpatch complaints
> ---
>   configure                            |  5 ++++
>   tests/tcg/aarch64_be/hello.c         | 35 ++++++++++++++++++++++++++++
>   tests/tcg/Makefile.target            |  7 +++++-
>   tests/tcg/aarch64_be/Makefile.target | 17 ++++++++++++++
>   4 files changed, 63 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64_be/hello.c
>   create mode 100644 tests/tcg/aarch64_be/Makefile.target

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

