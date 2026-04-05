Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0943DE9D827
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9X8g-0005u3-Up; Sun, 05 Apr 2026 19:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X8f-0005tc-7i
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:44:21 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9X8d-0005Uu-Px
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:44:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c76b994f7a8so1376417a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775432658; x=1776037458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGvfOibEP2BZRENQOBx9S6oa5K2E1gjq06e62ku/q+c=;
 b=iKXQ2dUoWtAk/fpyJQsami73TwkG+BbK58HFdoGYWmLZBaEC2IfD8rDfiuK7ebz9j/
 3oH8tVEFSHvaj+yp0nhn/8v5IBeljtBGefbvSzN2z2NlQxGsL02nsPxl1tcpIG3SCAw+
 TgnY1sHGNTEkFM31imIQ1jq1ZeDwWTPT9d/nxL7ylYsQ8QiWtmk7JhrRMV1RsrBEjXZr
 LHR/ktULXlLuTU6THaX+23IAmY9fYnSoCL/EfdCHWqv1uX9yOBeO5CIuf5ZkbLUv+pJP
 A5Tq+YNmw/T4Uv+RUMwgSEsQcoXIeIAuVGpk1HxilZ/DRNC7cxdgvlyQNwYh2aycafcO
 ZeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775432658; x=1776037458;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XGvfOibEP2BZRENQOBx9S6oa5K2E1gjq06e62ku/q+c=;
 b=lUrBKHvKP3OVy3zcpRzNZX7oBaF7+wn7mwTN91EV6LDROImwTqdqUNJEFE0cHhawTm
 Dv57omhbJp9i75WoIoz9L3FTD7kEEhF/U9PlPbXEob7G643Zlbtc5028LtfxQJlOBxYZ
 Vrlo6MextrmMu1cjVftAUcaxSxZcZsBWrghKHpMwoT2islj7KxIZIcH+CMxIKanMBHSI
 ac0TBOa1jP3n9m2ixmzwlWfUy8etM5mpgz9ksfqzs2lZplXLrD+hY1zFk22dCzsajsX7
 ZaXsiP/v6XeK+GMZr3oSa+xhwHU6dCWquwnSwdyy1ReXchot4UZ7py2WOhHfhIDIU2EP
 pRWA==
X-Gm-Message-State: AOJu0YyROZfO6iFUqJDM8sqAMZxZzspgnQiz/1cHraCMAJez4kSeVn0H
 tCexcHwTguFXpwvqED6eAzbaQf1GQwGowQBtP4PKrkZxh2LWhthczG9Tjm52H970FUZjDSY4n5Y
 IbOXn
X-Gm-Gg: AeBDieu+/KnHJDe8mw2SS7XDak9aznJoSEpJv1WejmH6/PZYCgHgLy2Oaw/Oa6/ige3
 ljX13mLa/w7VZJmA1tUJiIl1S1brt9wPNefyXbRSpFv5R2DPGWHNnhjuBRvcw3T3KCPGY+e1ih1
 4fTAJgkLKsGPRP9pb0+O9gpi95MS1zMGpsySnx/t2tCUmjAZq87AbG1j2mwSdlagbEBicvkCRwJ
 WANYCsspLgcf4Xg0bUzIOtwbOMh4F25C8j981I/d60BQNkjLpH2+gqt5Ow3SR77dICf22zgJAcG
 mTwvbo0T739yIpqom+VuLqux9jcXbL3A1ac4GzUDMds7Sav46gbrwbB5Qyv9b7KV6UwhKH1/FYo
 gCTSM31cdYghwdaTeR0qftiKb21/SrHDXBx3sI31v1+XFWPo428ULfxt9h0a8aBLDF43I8faeqi
 z3f/jZr56h15F3TAL8VUDaG0BzzMS09afsWtoAAPov3Q3J10dyebE0AHqz8r8AeziqITY=
X-Received: by 2002:a05:6a20:a108:b0:398:7ca0:5d32 with SMTP id
 adf61e73a8af0-39f2f0981abmr10637661637.43.1775432658297; 
 Sun, 05 Apr 2026 16:44:18 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c647792bsm11352630a12.6.2026.04.05.16.44.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:44:17 -0700 (PDT)
Message-ID: <9f2d9500-66a4-4bc1-957c-6ae3a2bc4a0d@linaro.org>
Date: Mon, 6 Apr 2026 09:44:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/35] target/arm: migrate memory op syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 33 +++++++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


