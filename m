Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3998EEB28C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voEaz-0000yV-7z; Fri, 06 Feb 2026 00:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voEax-0000y9-U0
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 00:41:31 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voEaw-0000Im-70
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 00:41:31 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-354a5da7910so694529a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 21:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770356488; x=1770961288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cKwUnyPyAsKTZtyMZ/uEK4MQhmtsMUq129ri3lVB8JQ=;
 b=HkvQtrx34fM/YC6JefEaDgJq9e/rq39Y5essk/tIuTHs5cDgxqXK8sXApvq+VnKEGK
 HdtWPe2fbRRWsE61map9vP9nwNAcz6XwnAYUUNbxw5mOc9R7sNtWX6pN/r/13nFIQsNv
 xqyDEGNRiFuczHMd8YUZNhdGBtzc486zoJl8vMCI6MeDDsOO7LBfR7pAIwI0/KBdBliu
 e3SBiNlzwazW0hpZfA82svcxA1aljn1YCTaBW4w0Rl2cr3hcQL1I8Ai4EvHivFtc+JDI
 gnnycJ3FI4d+7+VGYsRIDMnbhAfsLuoeY0I0cAGQDET77G+5rf/OAR81gMzPhnqqZQWh
 bQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770356488; x=1770961288;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKwUnyPyAsKTZtyMZ/uEK4MQhmtsMUq129ri3lVB8JQ=;
 b=hv+QwXwUe2rpYH7gFiu3qN0zrePMlceglDP2t2CAVYcGIMo3hgkPePkYBSdqOP3EfM
 gD+eKuaIJXRdw/SllwGJ/G2PD+fniU29Ru9eF0CJ9SMDZKowDRYjDQ9dNDtnNOM4DHM6
 a0KKOvRJixrkkTKP33dRFeJ5tsrj4JQ1t+x7KJ+YsOfEY+6MzJ3r8Auzcv6X2+fhUvaJ
 GdRwKNf0lKV02D/jRFcFcDs29fpEiAHtpBvbohcytuSmQ8QS5um6zh3UpGQQEM1WnoEm
 u1f+a1Z13vKQLGKNaLt+y94jv2ADgoTFFw+2FhQCnJd1fLIVd8sqD9RX7ZwAZps0Tzts
 gBMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ARKiVbJuftpkoyxdS3cZWr+5BlGEoQman/2s042FKJlvUqJbpa6Y0C0N5ajBarUB06KP/wiH9Fkk@nongnu.org
X-Gm-Message-State: AOJu0YwNCHBWexgwXrmcWBJ34OuUsqSaTH01eQ6J/WSQ+pOa3Qk9mrNk
 pkbu3C41aKbmw1YEOtGqQQ2IsXiWMqwhxi24vjuc+iAGUmLC3ichBuHzXeGDRq1AZ0s=
X-Gm-Gg: AZuq6aIwsBUrTABXLpXYY/3/YjVxvt6tZXCiGC/01y7GnTOEiFDvvWwV2M1lqZxQKjH
 ZOLDerwySM/nmd326ukmqNIvRXwmd8TL1okWxzOJFOylJNeIgrDG/m7NSgoqg77tW0IAyKko1bQ
 tBB7UIv/pWe4Yy0JZScyfEH7AAycEnUdXJ5c9CPvjov1zaEKzoCloGJPvXoG2ETVlS14osoLM8p
 b+889h4WWm0DNKvxRolEnpKNG0qR2h8PEIgGvChogmSJJfJVTXd7pwbU7qkfcuwK1h7KdhyzOx4
 y5ou4wGy7MfPYIaXK9KE1f7uayGgzABxoMjuTx+9b0RQw/KfSOig2f6wQ4mopYpYWdGPGmJB4tY
 8hASe5AtS2duXRMxI9dnwPbrCubCBdMYwmgW4hvf/RS8houcFGKAxg/CyKMdkrpgs5jdz6/5vU1
 2I1+6tyaiTMsS6o3cgBovXKbQOE8PfeCUh6LBzwSIfgeG4EMfwpLW5vpcKuyTkaq/PIkSufkmwG
 Q==
X-Received: by 2002:a17:90b:3902:b0:330:7ff5:2c58 with SMTP id
 98e67ed59e1d1-354b3ba343amr1238563a91.7.1770356487775; 
 Thu, 05 Feb 2026 21:41:27 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 ([2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b2ebecd6sm549427a91.0.2026.02.05.21.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 21:41:27 -0800 (PST)
Message-ID: <28f8521d-47c6-43a7-ab9f-24de3f0aaa9f@linaro.org>
Date: Fri, 6 Feb 2026 15:41:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] target/arm/tcg: Use "or SME" feature checks
 where needed
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202133353.2231685-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/2/26 23:33, Peter Maydell wrote:
> Many SVE instructions should be provided where the CPU implements
> either SVE or SME. Currently we largely check only for features
> aa64_sve or aa64_sve2. This happens to work because we forbid
> creation of a CPU with SME but not SVE. To allow users to create
> SME-only CPUs we need to update the conditions to use the "or SME"
> versions of the feature tests instead.
> 
> This commit was created by going through translate-sve.c from
> top to bottom looking for aa64_sve feature tests and cross
> checking those against the instruction descriptions in the Arm ARM,
> which will say "(FEAT_SVE || FEAT_SME)" for instructions that
> are provided for both features, and "(FEAT_SME)" for the rarer
> instructions that are SME only.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> This is a large commit, but pretty mechanical. My suggestion
> for review is to look at translate-sve.c after it: the only
> remaining uses of the plain aa64_sve and aa64_sve2 feature
> checks should be in "nonstreaming" instructions, which are
> mostly handled via the TRANS_FEAT_NONSTREAMING macro and
> in some cases with open-coding of setting is_nonstreaming.
> ---
>   target/arm/tcg/translate-sve.c | 854 ++++++++++++++++-----------------
>   1 file changed, 427 insertions(+), 427 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

