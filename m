Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA01CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4eNb-0000wh-PL; Fri, 03 Oct 2025 07:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4eNX-0000vc-Ak
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:55:16 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4eNL-0001rW-Ia
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:55:13 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-33292adb180so2177943a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759492495; x=1760097295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PC3vMrEn9ra0FaP1MgsqXVHF/2ZYLER0nMOLpKC4h3k=;
 b=fscMFTUH3yf4GhGw51RHgNy12j1SUrRUoEE+p/+fRT9RmH9rP2HSruI7Rsqp25iiih
 ykylmB/uM3qR5mg04a10GbI2cPa+y3LVVl3gnHk++6OkhqbDTxFV8C/k/rH6fccKgqVx
 K0uVdZ8CLYiOMxHkq2LTZsT1r1dZ6w1gw59O6KayqWbz0pBHxJ13Nxewl36zVHnrH10B
 G8tmid9PjyWNh431mgvI18avZlugwx7/fVqBF6H4Okczmov7mE6aRi5aE03x924oKdvI
 1BQIvX12oPjl3gCOXTkNdbMkklWqUymlT7uzgVv6xA4u0NSEyw86SR4fQZC1A+L3WTdC
 xpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759492495; x=1760097295;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PC3vMrEn9ra0FaP1MgsqXVHF/2ZYLER0nMOLpKC4h3k=;
 b=RO6iYIgQUs7fzyIKa7iRwmsHCWJCLn9iThglF1bztJDWqWn16OYWcFccO87SruKG6I
 l5Z0Sv3iyDpw6oWdYjkYW+oGDxuwV/eEWg4g3Ey44XeiHAKoF+GYaOR2AJxqbWIgmvqA
 vcYqS212Bd5Z1r9RDDKrmw8gB4KAly3jkfP3dN5Bg1ee30ncqyO6M1Zvqt3Yh8dC0CR+
 bgCL6xsyZWZlCpBdpKBOUlOxGoj55x9EuEKTeIMDzbIzo0N2O/850dJIex1P09Ze2aAm
 zJhwdLm8f7t6jbhHYI6ZYJxUOM2ozjQoNsOtdbO7mPk6+hhcSDZA8cficSHBBBzfcQxq
 i6fw==
X-Gm-Message-State: AOJu0YzBE1efukQocj+IG3CQCCkOircdjC4jv+9MCK7ZUhqn+HT8xi17
 tgFx5uCoscduaggU2dxN2VnjvMnEjUA1qFNIhA+qjmdTxlbuGs3i0KOB0jJezJ/pDS8mOuyxN5D
 R17TOjAU=
X-Gm-Gg: ASbGncsngYci1rrEvq6u3KFrHq43TOCI3/Z89s5LMMMv05oAlWFO4RL0rPbLtoXW6GV
 3gHUdkRCsJhfEufXCPLUPScwyym/3tkZModEgbM98R6JoWZTMskVBTPBtYucBikU+d53HvbsVvq
 u1M9VyZ9W+YSKB+51vopf1zcnHuGUEXrodkL6haqdiPfR8rZ4jxQaRTOOvCAmc8gU1D3RT+io25
 F563cxtQIegYXwKExbcA1PGo7RpmfWQq/tyhyEWeXGONzBx3IvRdzruH5VotVifzhJBvJNfyXEy
 dH4rTvkRd5gudw9XQVJUywQOczHapp4lnsSJCa3yVNyP3JsF6E+FF3UbuUxmmq/iM+XIaDByK9H
 CVx8gtTa5B7RSTRVWI0ALFAZi9DzfLGkHzihtey6LIWJsILjwK001pixqm1W1GJwY
X-Google-Smtp-Source: AGHT+IFPTqmDcTMS/gSv5ciJIp36QcXF0dh/k1CfYhICA8GuDwNKzzaEOYQtwtHQ2ZikYkqvde548w==
X-Received: by 2002:a17:90b:1a91:b0:338:3d3c:3e03 with SMTP id
 98e67ed59e1d1-339c27b3d46mr3480521a91.35.1759492495108; 
 Fri, 03 Oct 2025 04:54:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339c4a1aa03sm2046931a91.12.2025.10.03.04.54.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 04:54:54 -0700 (PDT)
Message-ID: <cd24fd64-897f-4bc4-8762-47254de1729c@linaro.org>
Date: Fri, 3 Oct 2025 04:54:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] Tracing patches
To: qemu-devel@nongnu.org
References: <20251001153059.194991-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001153059.194991-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 10/1/25 08:30, Stefan Hajnoczi wrote:
> The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:
> 
>    Merge tag 'rust-ci-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> 
> for you to fetch changes up to 1461752f0fa4bcd7e60d51fe47e3430f8a81cdd8:
> 
>    tracetool/syslog: add Rust support (2025-10-01 11:22:07 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Tanish Desai and Paolo Bonzini's tracing Rust support.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

