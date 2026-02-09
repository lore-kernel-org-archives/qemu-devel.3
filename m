Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38287EF06FA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 01:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpFiY-0006Et-5D; Sun, 08 Feb 2026 20:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpFiW-0006D9-Kk
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:05:32 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpFiT-0002fc-QC
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:05:31 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81f4e36512aso2308157b3a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 17:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770599128; x=1771203928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fUC+5GmrZecKNz6CVRroE+JL/IlLD7fgE1PuyqwKFfs=;
 b=BvyPkj97UlG3xq1qVbO/ag9h25FJfZEzrPQUxxazkmnaHav+w+LuwKUbWKiP4WtqgI
 F6U9eAF/fnbKsURd59qrOd8SwW+E0l4LzAsd21YzRjqIHUNetF0NLGtRqbAJ19lfb3CX
 06XpcOD4ZBQJli0T6WtfnubiPa1bCvV/E7iR8IFRjGHFsrnfHNfWjHsTFeIaL/vF+mp1
 9rz1Qbl5wbVkvSN0VKPBrVWHlHXfgEqp+zKm4weL3/4SS8szlcYoxQVWP38XCnmsBcE/
 REc+YQnL3tO5IqNJMUrHQYZxtcKopHrsE8tM72o4r/Ng/pMKVMQwOf1c2xUEDLPm84BT
 3nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770599128; x=1771203928;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fUC+5GmrZecKNz6CVRroE+JL/IlLD7fgE1PuyqwKFfs=;
 b=kydTXqhA2+ImEWEPQub5X6+b49hob+XvC2B7MJvHoeVOAkJ3yMn2eI4qXeBr631BLy
 4sCFZ9S82/RZmOJuXAFE9AcoJjCF62ztDKuqwmBfA1ZKjzNThxDeE9j49cLIcndeRAm+
 nGYOGx+Hn6NbMAFdps3h3C5wkzamHkOL4qFGFTs2EkBXserPx03poeKwemt3l/9V5MXv
 RVx5iPHet1lHwVKNZwhJDnqvJbJNdQtlSXK6ep9z24os9rpDH3LbAAgo3AeqW7Iz2Wgv
 kYaD3oRG6VH6Evfhq9r8UijwoECFXkvVou6HEwrKmZQhbfI2DoL+yD2Bsx81UyQhCMDQ
 PNpQ==
X-Gm-Message-State: AOJu0YzqGXwGfG49OLQsZlgbHNsXszrt9dqYlkHMqZUWi7exfVuknL+R
 4Isw2RKTzAjZ/u2ZH0lQH7kCVQcSxAo21LA5VO52SqXxkPLDnvYwlAeMNWFxtEaQJiWckhjD7y+
 IqOARyXs=
X-Gm-Gg: AZuq6aLQrzRoE5q4whhb20z0iL77YmF3S2D2P1RVkvlpxlc3j/l3+IjrE5CGpz9vZ7E
 wn1kzSzKpXJCNCYId37B3Pp6M3vLy5OKmNIOYzMYdbbw3Jrcj+xWdeO0e9Gf1O9l3d4c174TmZA
 zGm4ZRiczDoH61Wm3T/CJhZkfy4cKaHvPp2lfK6s6IZJIRAz9z/99izNARvdHvHiREbvNpsfDWw
 /UbqmsIOslcWKyVKKsn4CyPtSOxYKerZ/iJWbg6hLtWFuSvUUErUc8U0vtcOHoEEKCQD/b5DN/K
 xBlq/N7rRZie3r1UkmGXsZutElm+Ofd12IzSIWkdsXADmOeYdXbKU1dvuW2wL2koTHGoul43zbc
 xS4iZ6KLkNxkLgMQMPzNgzZ5/eNtOYiZOq3dofMhw+xCwUkkEUZ8TIWGjz07f7CCW2+IhG9B/FZ
 tJz28J41iMX24v+sv7WLsq1/VBOLt2jqqBDkLu1ExiG3zcoh7ZTxIiCVS3weuLzu4=
X-Received: by 2002:a05:6a00:a244:b0:823:108c:5bae with SMTP id
 d2e1a72fcca58-8244160c7a1mr8768955b3a.8.1770599127595; 
 Sun, 08 Feb 2026 17:05:27 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824418b60easm8491470b3a.55.2026.02.08.17.05.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 17:05:27 -0800 (PST)
Message-ID: <3ab063e5-b7ea-41cd-8bb1-0a13ef8a2e53@linaro.org>
Date: Mon, 9 Feb 2026 11:05:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/24] bsd-user: Add target_to_host_semarray for
 semaphore operations
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-7-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-7-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/9/26 05:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add target_to_host_semarray() to convert target semaphore array to host
> format for semctl(2) SETALL operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

