Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEADC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0mv-0004F1-92; Mon, 05 May 2025 14:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0mt-0004EK-JG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:43:35 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0mq-0006FB-TX
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:43:35 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b1f7f239b31so4960228a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470611; x=1747075411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+V/yckTEt3Of60Tx9qYZWVyVlI2Maq0VpPJSJte1eI8=;
 b=HuTcpxPs0F7kXm3ER+GEXA4kh32vR79XVUBfaemA1pUwRc7O1U7mwfddyhUcdHQ37e
 WCmVQFH/Bov+bHF67C9y6iG8QB4ipMx/wvDSaSjsMXDId7792AqDfQhhv/TXl+d/77ib
 9xED/bABtwLHfxj3m1FF8i19rEXsaUDtfigO0pZ+F0o8FgZqCRs4kbec9SPSMbhnJoRX
 j+P+rr+N34H5GC2LsHs8/jxUwKkLWU9/3Q21Ad3A3b9KHVpLJ+8XKoXzKROyK9LLmawK
 F2J09csYaJSSwp9doWooUam/hV26gvcAgwJzu7Hy3A/5uaKCEwloqrZL5AHMNddJxGLC
 /OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470611; x=1747075411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+V/yckTEt3Of60Tx9qYZWVyVlI2Maq0VpPJSJte1eI8=;
 b=PAYScQkUOkihPWC7rMffbJTMbhnjgby0YlRvA3IcxozZLdGQvPVYIU44NEyPGGqItw
 eL0J0vSR2rqrKRzCI3NeU12eqdLhMrRd5YpDkDuubf9kycVmD4aJ0M4T006uDLRel85v
 qifOk+0wMGzGz34j1lS6KaSqii4WLV5v57BNPNTQ6FTD5H60vNYv+AcNrkdhguHOOkh9
 ymsVYE0mhW79fTZskL9aSyFgA9/vfJ++8RLXL8GLop4t9Cw5+zo93kqkv48c16mcE/gN
 Fv4AOqm51JZdx4HhpoU4DvM+kA/QOSlN1yRh1xC7Rd4I308mrBwPArOsmEWSn+5jM1oX
 1WEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSDywpQuHMEqIvWF+J78eFTRHUWJQRxyMASqthIYXOjHUOGMRemnE8AMDxREuo943DbJZqwZ2bkW7w@nongnu.org
X-Gm-Message-State: AOJu0YyhRxXnuOokZFXKh8A1aenKLlERdYDdCtIftzNuz+6xbzTaVQuq
 X+LgN/0XOlbpHgGfbtv2u8R1QyfbVQHOQugLGGz0NWpqtkmZMTYPtJc+zYp86NE=
X-Gm-Gg: ASbGncsOsYdvbyhLevngU9Isi8pedWFrIB5oGYO/mDWRkA7geUGiVu18HhhGe3ylk58
 Y80y5YqfT1TsSBMYt0tCtiS6nF7dB1w2oHZUOPW2EoY4HxlT9EkvAfakBmxeu9cEJaPy2VcIcg/
 CyLpzYui7THFAxIMHsKBZesKi/PEid/U+9LSi4E0K/1sIiUdJ7YhC688MvgaDEaTSxtCXs9fo+U
 gubsJyWT6xruF+4wwem9YegGXg9a5eADiujT07jjxvkzFDWUAVBfGSKM3HmCzp01XUMVRiTR8MG
 mGlLNTLtJOLC49Hd2t1J7AbtywN9sWJ/uop285WuMQsbklTQYhlJ/G1D7/8R6SHfwadlNN8mGJs
 EjZzBXtA=
X-Google-Smtp-Source: AGHT+IF2+Z8KaYO4OS/kgD6+IOcvIP8nAKXcU3gY90DE6aQn/DUfu/Od7V5lrZ6DteiM9KOSigti3A==
X-Received: by 2002:a17:90b:2f45:b0:2fa:1d9f:c80 with SMTP id
 98e67ed59e1d1-30a7bb49ab9mr788615a91.17.1746470611247; 
 Mon, 05 May 2025 11:43:31 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3480f0aasm13392418a91.35.2025.05.05.11.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:43:30 -0700 (PDT)
Message-ID: <2c005b5f-1308-4c7e-9b0c-9640aef294e9@linaro.org>
Date: Mon, 5 May 2025 11:43:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 43/48] target/arm/tcg/iwmmxt_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-44-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-44-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/iwmmxt_helper.c | 4 +++-
>   target/arm/tcg/meson.build     | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)

It appears iwmmxt_helper.c could be built once, like crypto_helper.c.


r~


