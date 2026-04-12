Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D4AE937F2
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wByXL-0004LF-4n; Sun, 12 Apr 2026 13:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wByXI-0004KN-56
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:23:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wByXG-0007mE-Af
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:23:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso44506275e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776014628; x=1776619428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2JK7Kl0RfvaSXVCwqzI9oBx4v80TMOjf8l0TSwPpeXg=;
 b=KDFvbv/USSI8fTTlW7F89t0jJKDwX6oAdHEUPLeLtB5RmBotyar/POPVFh3xHgCeW2
 VBhpkKQHxtc143t17NASEzTVIqmPcTn0IvsLIGxyovuItjqcuicmbJKOd/LRd/kI4Gbk
 p0sLbL04uyBOFwODlJaPIm4lujXostYWmZEfSSjZoFgQU8wOdQ1PsXZ+qdFvvWZVASqv
 8wtL63HB6XCtH70IGbt8iWUScixhwxxNP9Vi1y1Bk0ZYHfZzDyf8xITdevSNJXNxTHPp
 X/A0qFkZu98YBVVZvjAky6nS38Mj2JeMgROaHMV0J5B07OBvWh2WIrOo/jl83CinOYq7
 equA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776014628; x=1776619428;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2JK7Kl0RfvaSXVCwqzI9oBx4v80TMOjf8l0TSwPpeXg=;
 b=p/T5IaZ8f91CyxIGU1/NI0yh+S6v2En6KCYiJTovnJRg8n9UzkN300UjUSR9PT+xFe
 IIFC9C9FsZHXTPchTwZst4R0/lhS+TNEjvZo7x5JT9ZjPm6ElOrYBKxCTt3FStTC0W8o
 DU9s9TmvTVkSTIaJkXXDWrWshkKPcBQibn+j/F5dn6n2yjBppIcCbkx0T/B4IdzLYdBE
 Eg64k7ypHrWpOSyi5SKruMDi6VKUuhR7y9NogOFppXw+A0ZZYcrem1BkwOlLRgpW8tCt
 h8OMSW+AA1ysQsfOtXnZDJ/H41XITZnnndLtGUwirp9XtAxVr+kbkeUYQ+BsOIi5aw8S
 8HHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl1LWucy3mQ2LLDSWftw1lIv9uHpD3ZDGRv12bUqLyQNb1CK0+o2zh3L9retjIrj0NmW6Eaol8FbXV@nongnu.org
X-Gm-Message-State: AOJu0YzeztlVF7ohCXLadr7lpMAnnAOUvaqbDc+3sgPsnB2yvAwsYaDO
 bHIa7eI9GEQBkXJi+AyJyHa7suJiYrap8BjZgC3t7toHkHKq61RwHZqjGFefFssdAOU=
X-Gm-Gg: AeBDieu688E/7Ch9UGdAioNtgwWc7kgvA12fltt05A8whyo/IxgMkaAoDMYNiHW8OQf
 qXfpQcwmnFgE/rt9eZsNkyhzRlSacThxTsumDgSbRsWBQL9BtZeW7nQIpBfdpvleK3GqOwUclzC
 lV9sH1PkrGXZzuAsISoz60dDgSsv9uEuzrXtDvJ9pvjc8cofTjpCg5pLsu2nTgNt/G8FOTy8vP0
 LHY74GU3oXlJ8/eR1ALGdMYSf2Z4LukeM0SRjlU/R63ICluOdWCrSpFBvuDN7KMwnpR93jaN1Up
 qtK7FDaDHEZWZCKfatJp5zMC05UcQ9Ov+Xqd5l0IpbNk1bP5TEzcw0oZUANgyDGn8wKCJPY5Rc1
 aGUFTw20swGJM/dWMVKqrMopKAkJHpGIipGcLkiqJdvMHQnXNt+54QhYeOZjS8WMlmZ5p5dfabD
 ZDJGqPfU9zf9QHDaaWxBs9n9JaPRPhT5/kTYuy/cxsTNck1OSe34A40pSCRyvH7ted9A==
X-Received: by 2002:a05:600d:1c:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-488d67bf6ebmr112303285e9.6.1776014628107; 
 Sun, 12 Apr 2026 10:23:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6864121sm74511425e9.28.2026.04.12.10.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 10:23:47 -0700 (PDT)
Message-ID: <1686f699-ea06-4489-9cf5-d940131fb319@linaro.org>
Date: Sun, 12 Apr 2026 19:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-keymap: fix altgr modifier lookup for newer
 xkeyboard-config
To: Michael Tokarev <mjt@tls.msk.ru>, Dietmar Maurer <dietmar@proxmox.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260408091459.4001711-1-dietmar@proxmox.com>
 <d0e6f8b4-200b-4ba8-adb2-5c29cc668d15@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <d0e6f8b4-200b-4ba8-adb2-5c29cc668d15@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 12/4/26 09:10, Michael Tokarev wrote:
> On 08.04.2026 12:14, Dietmar Maurer wrote:
>> xkeyboard-config 2.37 removed the "AltGr" virtual modifier in favor
>> of mapping upper groups directly to Mod5. Since then,
>> xkb_keymap_mod_get_index(map, "AltGr") returns XKB_MOD_INVALID, so
>> AltGr-based keysyms were never generated.
>>
>> See: https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard- 
>> config/-/commit/473f9bc32f9ba869829cc0d06a75cd1f2560aa60
>>
>> Try "AltGr" first, and fall back to "Mod5" for compatibility with
>> both old and new xkeyboard-config versions.
> 
> Maybe we can go the other way 'round, namely, first try Mod5,
> and if that's not available, try AltGr?  This way, "current"
> way will be tried first, and "compat" way will be a last resort?

Hmm clever. Dietmar, do you mind posting a follow-up cleanup patch?

> 
> But anyway,
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Thanks,
> 
> /mjt


