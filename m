Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413E6C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibRV-0004KT-01; Thu, 13 Feb 2025 10:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibRT-0004K0-Jp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:47:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibRS-0003JN-3V
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:47:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso370412f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739461672; x=1740066472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsFN0XWhhDRFShavM79csHQDHHWyDTlp2ZujoP5PcqY=;
 b=sy03tW+sMT35pz2rDoMyeCtGnAt1ZXnPvxjBe6GVgSvugphi2f3C/rd+hpwgU23NGS
 EWisMdcykZ1cmfIEgSbZT8wlBgqoCFVTcmSkN6XlLzt7VB6AJydvAvWZNOOxbyV9h4Lx
 naPuwpkIiKk5dUcYw64RpKexrsaFCq1SWZPDj1nnKTvr5Jg+S66osxAcIjfF8JpCJBOJ
 XQxQbaqhT0ywIFEUj1Ac2V/BlkgCba66uVdy8fShUUAVjPTmO3VBPhUGWRvpyEuN/+1d
 eCbe3Wu+m8FuJKQ7SPc4+gDmwjYwQa9YWOIqlnZL37nj9OoXw0T4glQ32kzXfVzezm9B
 lTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739461672; x=1740066472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vsFN0XWhhDRFShavM79csHQDHHWyDTlp2ZujoP5PcqY=;
 b=arNW6u8ey/mZoKlu2jg6SxzdZmRy0FfVet/ADGDYf1Ze3Qa/9s8TCryBth6s5iRb/r
 NHuvYY6PM+8/sMjhqtchSANsUhOuJSIZXVzA0+3EnR2Ol0p2wjoQw7JF37+k/m5/UAup
 YrN3lk6W94wel7C5pyMtLQoAkSUHsanp7J2ZZk6X36FG2FvLLmKrbNntsDlCi12tPzmh
 6yEt8lnP09u8A2h5y2csMrkIl9PWLvdPAC7/f56PK5hTTFH4Ko5oirNNvfcfzCC1CNrj
 4xNbwwtKocrkqW/QBmNb1c2Yfws2+Spa1FXy8bc63TbhvT8NlbPUwPHm0dadwmgYekFV
 kNOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMxJDbhav+69sAWORTZnqYTnHlaqHq4YezV+kGXEQKFmN6U65ELCYbWT7fXMuH0UsqqCfTMfA6Ggtj@nongnu.org
X-Gm-Message-State: AOJu0YwSSI6IT5su4lAK94sPEfno+2NXAQmbjps+P8tsCviiqWrl5Rib
 CL7kOAVRHeOGHhpcnNZCYDHEH9himwLckSltCIr9zVyLfgVaSUPLUoUF/zUMOe0=
X-Gm-Gg: ASbGnctSIyflXegSKR+WwL4Fb6rCez4OQv01BFmSn438xtIx1/lcLjMDempVvjs0ZuM
 d2zuSVyTd+airEm7ruCQuTBAZc1dFWxZEwjeqngoRJAwCp1PgYh+xHJUwK2fz9xA5W+SJAbUEIE
 Bk5cxKtH/Gr21IiRb8HDw/MjpLK0XoPt0JwgbUkRJQWx3c8TMYUjj+ZIBAjqKy0ygdmYmKXqWr7
 ZN7dp10ZPltHWWXyZxoehSkmu6eAjf3cOSuLpuBNaP39DTA8jMgLlfQ4ZwWpuHbnBzfg/Y3OssH
 FTr6ub+Lboi+dvuvItXnC9IBJWYhX/EYcI6M2AWPsKE6yXMmUggBiTqqJ5JV8x5CeFVxiknMtw=
 =
X-Google-Smtp-Source: AGHT+IESkeZSFZxtAUOL5FeIupSxSjUxc8K1Q5vlzLWlBKKi7mk3EuZ1HvEt5pRdWwnBjRdqJYkpyg==
X-Received: by 2002:a5d:6611:0:b0:38d:e430:8ed4 with SMTP id
 ffacd0b85a97d-38dea28fc31mr6732896f8f.28.1739461672444; 
 Thu, 13 Feb 2025 07:47:52 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b410dsm2223696f8f.5.2025.02.13.07.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:47:51 -0800 (PST)
Message-ID: <cc2e1d20-707d-45fb-8734-913d580f4015@linaro.org>
Date: Thu, 13 Feb 2025 16:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tcg/mips: Use 'z' constraint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212034617.1079324-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 12/2/25 04:46, Richard Henderson wrote:
> Replace target-specific 'Z' with generic 'z'.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target-con-set.h | 26 ++++++++++-----------
>   tcg/mips/tcg-target-con-str.h |  1 -
>   tcg/mips/tcg-target.c.inc     | 44 ++++++++++++++---------------------
>   3 files changed, 31 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


