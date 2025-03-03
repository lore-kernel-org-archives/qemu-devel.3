Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE189C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9hT-0002Jk-2c; Mon, 03 Mar 2025 12:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9hJ-0002Dx-S9
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:35:25 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9hE-0005Sc-Td
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:35:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so32716265e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741023308; x=1741628108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oEPAsW1PFr3MI+fTmNAdX+E+dPgfW8g0eYhucqZQ6RY=;
 b=slyeD1iAr9yFcuJ66oaWndhOCZo7uOwUViFJC8zCG1cCpMpg/TsejKVhcEpG2Xy14H
 HMEXw/XVomBV4eni3tAV3uF3qEROv5dzlJQ53U0+GmuDi8kIyqP6eJAVZ97H7QBzPE53
 gPshX5DKOM33Zrz8a94BrT2oVw1kZNtEbh1wFIPNARuOXZv0rpAMzH0C/JrBDZoCXnWi
 M6sb9S7TaeiUO4oYXrwP9ZxpJilTUOimyiwlFVDG8NWe6nkCBk7tHB/Vucu0d4WSfyX/
 iVRRXqSW0wI5fHmOQaHLHWBxLipXbFTFwWkLgk8vMFhWPRPHQTaMLf+BJyS8flUmchJq
 w3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741023308; x=1741628108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEPAsW1PFr3MI+fTmNAdX+E+dPgfW8g0eYhucqZQ6RY=;
 b=YPxMZU8nD8AUY8uWKxGgKuO1+zc16i3vGknoCWsA3GVPZiedveLLD4j2SvWQN1Lvwe
 fCrFIb7vTydivRtTQnYpUOJU85xrpp+UFapChshYIKCI7dlj9MSJxaOEXTjBVbOVo6V3
 j6EY3me8p8BZ/k9IInxzocxPtShbWWsED9HXW5BTZazAgxzPZ4RH/3+90z3Hf0u0Ipg1
 /fOErmk6nuBUDNaeJJRggGdMcCmpW6Op8qxBFXStHtJReJLRP2m4FU2uQ5SaKT0+K2x6
 HnHb528QbFo/8+9JWoMqYjVhqxhwLzGWnRbmuLuXt3AKaKlHMcgIvK6KFZibkVKcCBcA
 XGeA==
X-Gm-Message-State: AOJu0Yykt/Mb7vsi9lSwt2Q1yy5rSZmtpsbUe7ZfWa7b0JHDKb6xHlkJ
 b3FTbpO2ETUmUCHCCTRzrhyg6J1XiGS2jIgOBkMVSgFwozRy37Es/mWq16o51J9bu9fzoB7NPcC
 iuw0=
X-Gm-Gg: ASbGncu/+F/ftZbgA48aNgdgDVYfBHiIed6qHYGtHA90DWwKQNo1IWOx1TxfflCW/aV
 rKmYe+pjHk2xfogcX2izHK/9IqkVro19XEzwc8Nx9YwKf8B3f0lKxVxqaS5V+ALp89nN71H0pJo
 uoKqcR+18FjE9q9Zubn6WlHc8YWrepLX6mJa83daQBWfHYC/AlIIhzxtMDn+zl3y9YSUY6NA2eV
 NwmjIUfEoG515Ozbqfl5APKpGomepZIBON0VOw1u1zMeE+wu0BjHciNfKLnVtSPZIlzeUqtdvja
 DyKbv5p1LjZF3dqikHqjJ2wjNLvtnqFJptWfaBYuW6BoQXWA3qHHdkPCU1no9ohwRd7kY9Piheh
 ZHq+xFtTdrNgh
X-Google-Smtp-Source: AGHT+IGED7TnyR1TDblneE+jgzBFU4beifRpUL3bUNPTK5i+aGnKpm5gaWdokT/3TuC4W9Pgh9KFNA==
X-Received: by 2002:a05:600c:5493:b0:43b:c3af:3304 with SMTP id
 5b1f17b1804b1-43bc3af34c2mr25856205e9.28.1741023307993; 
 Mon, 03 Mar 2025 09:35:07 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbcd83914sm58021865e9.29.2025.03.03.09.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 09:35:07 -0800 (PST)
Message-ID: <114e31e0-2085-4843-9ef2-3539d53eefd5@linaro.org>
Date: Mon, 3 Mar 2025 18:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch: Fix a typo
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250303172508.93234-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250303172508.93234-1-philmd@linaro.org>
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

On 3/3/25 18:25, Philippe Mathieu-Daudé wrote:
> When running checkpatch.pl on a commit adding a file without
> SPDX tag we get:
> 
>    Undefined subroutine &main::WARNING called at ./scripts/checkpatch.pl line 1694.
> 
> The WARNING level is reported by the WARN() method. Fix the typo.
> 
> Fixes: fa4d79c64da ("scripts: mandate that new files have SPDX-License-Identifier")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Possible candidate to apply on /master as buildfix

buildfix: because otherwise everybody running checkpatch and adding
new file without SPDX tag will have to debug checkpatch.pl.

> ---
>   scripts/checkpatch.pl | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 83b59fb4436..6ae9d7febee 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1691,8 +1691,8 @@ sub process {
>   				  "'SPDX-License-Identifer'");
>   			} else {
>   			    # Other files MAY have SPDX license if appropriate
> -			    WARNING("Does new file '$expect_spdx_file' need " .
> -				    "'SPDX-License-Identifer'?");
> +			    WARN("Does new file '$expect_spdx_file' need " .
> +				 "'SPDX-License-Identifer'?");
>   			}
>   		    }
>   		    $expect_spdx = 1;


