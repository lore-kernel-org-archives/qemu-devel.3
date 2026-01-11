Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9F7D2502A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej0q-0001qJ-Ow; Sat, 10 Jan 2026 19:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej0m-0001mi-3b
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:08:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej0k-0007FB-93
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:08:51 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so30950275ad.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090129; x=1768694929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AEwB3YUx8wiaZZS0VFG7hE8tSHMWsYd5USnulMuxZos=;
 b=sQs3ZHH9l3/eOI958+YD0dNZZkIA5pcCT+cFU1FN9/bvujxxQcUka0ixv3IXNj+8e0
 q/Af9oAN/KyG+1uQbFLYlKursZw+v86OTQdNQPL31mPyQ+/t3Ihs84lHXMENS7dmaKOJ
 +lV/iwfhPSh8ru/hItgds2fOfY3445yxbJIDaedyLJ2ubJp2Skrg1WBI+XpSFJWA8Auq
 x/T/6nPlnjZp3WlXV0moDvPBJQ66LGLz/q6wz8+tAfbDXNvqlr0KSXwl0vEZUkrf8fs5
 EowyN7cAm9nOrdWLiZJKLzv1lh/I7OM1gO0ruCH/KLE/VvKqTTZTGmDboYT6X8kb64ER
 zMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090129; x=1768694929;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AEwB3YUx8wiaZZS0VFG7hE8tSHMWsYd5USnulMuxZos=;
 b=tKq27ZbcABkDALko67CPD4BXCOQpv4llBLnvdEmge0duQDL1YRR4iJmVLqh00HVCfG
 Vzz+Yb4+kyU8yRnVEYD9H/dA7RIJX3e6kx4F13o/YiM062GhXPso2k/5rDBpoFzqDU/d
 clRVb/egJ9653JDMa7A94tqhLOF4ESGOagRCBmItyLDJSOLD8RBC5Sgf50A5vhYIn6OZ
 YYbf09y7YxG7cB/LrgBIMlOcD8hTGDkwxBrcTGpyp21YzWj0EqGFClZ47Yvkf4OCsLZ/
 CzOnSAsGevnL/6jzX3lNLqahRlSOqtqTrkBdvCjWdyOjyBDZSWHQcRSu3Fcd3ovqPP9d
 9kwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGn2r9dzjWSm5/4SqS8AUJF/KtvtNhJXABDPYIf+5w+UUsV3ntDZv9WmmDL+V3GD+jGySV4FKqa8HU@nongnu.org
X-Gm-Message-State: AOJu0YxcFAnd7t8ed/VKady7xey2Q8jp9Kjq+nXnSnT9bH6TpkdFeErR
 aZvUjWhFGBD8YAdOjL2SdUbXsQh6lRrBI3J8+RvTB5E4VPHRMN7pam6Xzvc5V5mQ2po=
X-Gm-Gg: AY/fxX5GR2+yA/QKkrhsWYEDwepTs/YYx0a82xzjo+ivVJlTJLmWDiZTPUG6wgAIGeD
 Uz6KPd2kiukbCfxAhZZFiaEOLwQG1KpKJ1JAxOYEhbcH5D4KhnSyaNx7e2lpd7HSOHGWTx7e0pp
 LsP7nCb1SQthII33JER55VehpRPR1w2DWlv4TwAxGijwGqh5ARHzu2pu4GM9MHw54tgX40U+AuG
 krcpDygH50IqgUNs/KX+xeJS7zHTpgKwSkEwkI/8hiXCjC5IOpULf0PT9c+jnh8ag6vyINBIliy
 i/CCEsaIhkOgEd5l1itVU4OShZBrgJC6hLXAHxJKupXCj89jZ6hIvLbkoPbITUgVLEGf7s8A3ew
 m2WGtxd7gz8EqC0B9essFQx6rHJO8bWvxn7kl+E9ac4NTOluJl4U/lLcQ7GL1q/yJQBaidfmqef
 BeEhOCZht9uZeubEk8UJxh6iowjA==
X-Google-Smtp-Source: AGHT+IE1DyjyD3vK8+dUWHDTSllD+NPpckhs07c5iRuupjAUuXpx1omNfFDyvcsWbEOK956OO5sROg==
X-Received: by 2002:a17:902:db11:b0:2a3:bf5f:926b with SMTP id
 d9443c01a7336-2a3ee4c2efbmr150477935ad.47.1768090128561; 
 Sat, 10 Jan 2026 16:08:48 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2c5bsm138816335ad.58.2026.01.10.16.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:08:48 -0800 (PST)
Message-ID: <baa6c176-a95d-434d-b9c6-4beeb87c63bc@linaro.org>
Date: Sun, 11 Jan 2026 11:08:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/rx: Build system units in common source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/8/26 07:06, Philippe Mathieu-Daudé wrote:
> Since commit range 2982b948a9f..86114e43ffd we remove all
> uses of the target_ulong type in target/rx/. Use the meson
> target_common_system_arch[] source set to prevent further
> uses of target-specific types.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

