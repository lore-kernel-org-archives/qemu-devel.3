Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAC3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 21:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usTa4-0007XF-L4; Sat, 30 Aug 2025 17:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTa2-0007Oo-OD
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:57:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTa0-0007Y8-Nc
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:57:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-248e3ef1641so20218165ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756591067; x=1757195867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Te+h0xr04/upjt9E9xsQaw5KmodeYahKGykVskhkZ+o=;
 b=p8z18BbK43QVAjZaQJI5L+AR1PHdYqxPZ7uJqbH1xJymVygK66EzrdraqigAgv+dDz
 17Z7Ucv0ImXXE76SsxZmNNjeJYRzS74qpwKzrQxqjDpWd1X4bAgcwqSLyNHtZ0qAa5bZ
 17UoZiLPpjNcyzy/xi5RdkSdka63WcE3ud1MtqhS2xrar8GrlHrEMyjeHkq6TxJyogJJ
 wMcYAOPkL3rRt/hO1tWbNFsN5r70WZJoCmlazxV16JOs7PdDv7gXUqkXaSlBx+eye+ki
 wt/9wV1E/R+xQtLSmPCuIkwCZuQKEv+0leiVgs+8QcSg583iTuZMzrQlYRMMEjHlTw35
 I9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756591067; x=1757195867;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Te+h0xr04/upjt9E9xsQaw5KmodeYahKGykVskhkZ+o=;
 b=QPfMfC+4QoWvFacQsNMcCs7OWTMSjQOOIBIWtLiPXK4tQAl2t7qFUbEl+heLcmbDhH
 owLOuiNTYnQa7/Gja8t7Tvli5/oEwbGXeewHuzFKanOFoFDLyYGSmoDJ5Ouwpn6CelWv
 ZFmG2IISrs1v+u2s4F7XoO3t7QntP8s6ZGKjC/mqDHaBxcZB3OmNwTm0R11apXiRETO4
 nZzhQTAjSNkZJ9aWPmSDX4ru0veIZVs5iHGO8UzLtSqMAU4+RO3GZ8iLPTxuskQ5cFWL
 fMdTCjXrFawIHSs6xFjz5PJW/VHpl6atTHyF4ARbHXGK/RQ6V84mULEQNIh0zA2MLkOe
 GY4g==
X-Gm-Message-State: AOJu0YyuCDFI/acPwhctZpY9IITPjTYe4gBbXz7tI6Gq3nEqamH2rl/k
 pAMOVVSrg1OIwiTxZyYd1lol5zNdQD2y0IXpVG/fSB2az5VgUsV0SICHZJFsSJD5/Z9r+htnVSP
 5/g0DvM8=
X-Gm-Gg: ASbGncvEsyPyej29g9djSn2T+QWx1O5Q2vRiu8PtQH9JjBI9fqGqGJ5uXbvi/9GZu3Y
 Irj8CjfdARoWaXnToIHUB9M3/yNsgfUdZG8D6YMU81XEecKtpUQ7OQuo1LOyx/xHWbHk4i82gTc
 ZBAKVZ9Wb2VtPYQ4crE4kSHTS9vyAexJwwl2UWPfMo/sDUsoctOKYeFDv2VxG3JWDI28LZLkSQ/
 Ef1GROJYypN8OjT+7B6ALBjaxuMZn/EjFtCHUCGK4XglD+/AjZaZ8UdoT+uua5T4EiX++9TbUG3
 VYvmtFdUdsaHPBe03KECnns4BBzFiDCcCqu8GHhQWdij8G0mvH8e9vUrnaaw2zzuj2JWLJ65HkM
 9MlRNodKRW8mscQh0sUpMSr0DWv5beZnUnLqFcdkG+rP+lwCxgU6cJ/KIsEW5jD7pfw8c/gNavz
 FbqSil
X-Google-Smtp-Source: AGHT+IGsbYfzItQV04TTYV3SvBFxUyk8tasMFl4SIbgVAxvujXm/J3F7VseylwPu0g9+TPD5S5gCXA==
X-Received: by 2002:a17:903:38c7:b0:249:2d84:f416 with SMTP id
 d9443c01a7336-24944b766eamr42048795ad.58.1756591066614; 
 Sat, 30 Aug 2025 14:57:46 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327af91f6ffsm4730132a91.4.2025.08.30.14.57.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 14:57:46 -0700 (PDT)
Message-ID: <9a317ea2-64ca-4b87-a50f-92204fb542a8@linaro.org>
Date: Sun, 31 Aug 2025 07:57:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] monitor: initialize global data from a
 constructor
To: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-3-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/30/25 04:03, Daniel P. Berrangé wrote:
> Some monitor functions, most notably, monitor_cur() rely on global
> data being initialized by 'monitor_init_globals()'. The latter is
> called relatively late in startup. If code triggers error_report()
> before monitor_init_globals() is called, QEMU will abort when
> accessing the uninitialized monitor mutex.
> 
> The critical monitor global data must be initialized from a
> constructor function, to improve the guarantee that it is done
> before any possible calls to monitor_cur(). Not only that, but
> the constructor must be marked to run before the default
> constructor in case any of them trigger error reporting.
> 
> Note in particular that the RCU constructor will spawn a background
> thread so we might even have non-constructor QEMU code running
> concurrently with other constructors.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   monitor/monitor.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

