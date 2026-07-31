Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E83C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 19:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsy0-00010s-Tv; Fri, 31 Jul 2026 15:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsxy-0000zm-GP
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:32:22 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsxx-0006nm-3e
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:32:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso1430987a91.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785526339; x=1786131139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o5EbyKYBFv412MPhpUpHb/MqTXkFZ5i0fM584DXnLCg=;
 b=xItjF8Qu7TMkDA3tEokcVpJh1dbtP+o3MoX1c1OmVtEcW/36vDs8UfWjiVCt7LZxlt
 jjBwWEPhmyZWhJP6hsg0Fk3Dj8lSA3bC9U+xY8e9L7FJTHD77xpJmCMdDGK7XNISJxyJ
 eGB6jfBmNQq0TPyVs5GAB/bi7F5ERaKKALGVorhhSE1EiFR3Cttpx/bfflGp/JdWW8nw
 y1LkEMAG3d7kAN9GhqvufuaITKMQe+0x22H/wzH6/hTUtg66jBUZ2uydyHqvumHMgMfZ
 ePCCXe98obYQuv4NF0iasL2GLwbV1qLpPbogUfzDbKszu4sflK+G1OCW+I94NelaIqLk
 WdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526339; x=1786131139;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o5EbyKYBFv412MPhpUpHb/MqTXkFZ5i0fM584DXnLCg=;
 b=ffq4/U1hR8ZQFywfjG3fJnpKWjaxzeXyUNm12damAo9esZr3Ag8VyuhPXo12eTEL0h
 XlqWGdBIZk04m82pEikJFC4Xqes3F2z//61cXfkF9sxkym+hCDAdew4lD4FQhZnIJF6a
 lYrNr15P/YZCqDyysNimdpbi/y3vgt8fS5co6Tw9sd+ZInQBxMqGVjrfpF3ZUG2QAMmU
 ZrDhPqAOog18Jg5JOvLEu8HoNeEkmyOuA5ey/S8FxdXLODqggUgBL53+TOkMXmi3eOOb
 LgXwdWm7fO7RbKQCIc5ABTZgjhivsoS4DxWxEdSN3NSyOz7MofQ1Anv0liWoavmxzIsC
 L9sA==
X-Gm-Message-State: AOJu0YyMJDLm3LZiFpBpbw2QlL829EWBm2UA4UjkI1ByrwUVORL58LVK
 uxK3z6M/NkcbE+EPnsqatB32yVJgQyamPWIXz1llscjSolwxBdEC3cSy7ABjFF5XTGQ=
X-Gm-Gg: AR+sD12TNTHsMP39mdfV1X+fRc0JvrVlCLhP+QsYlpzQ/emkP6lor8IdUPRJSfncOyn
 bw8i3KoAQNTbgUOmBSGDfrT+4L4Ecc0pSo+JWTUhRTpSUwFwG2g/HmsTSvqORApLGRmS9/3l42m
 55xvsK5BAAXYqhL24TtAyZ0+bCQwydg9bRNYqkSpDjCImX7Xpz2RGT+wTp5WcNKCbgn+0ocGLYS
 WnJmi3JrOXQjRGkHSic8OlLu7A9hhuYvmgmtkekTuOMFxwSd842Q1B5/69y7cj/vPqu5ZF68JST
 E1+hTeTCxjES8P14DHeUHuGFHqlvxWXNHMdMdu0E/t/bvLx30KJ9s9qBuJ+td3ow9gGU3HdPSn/
 Ky2slYkXAkligI6ru1at0AMHBnf/N9db68hibjEtjgy03jNHaD+HGGc8R8unMKMvwsCeUWZL3Sl
 zTJxWGVgReW7/OkEk4ZGZWcgIxEqFcURkffThhDSz/W+2BdFX4GlM9GO9g+ghYfF4avYIiBSAX/
 8UC3d93lmAxHK2Nx0nae/FtmHUa
X-Received: by 2002:a17:90b:1cc6:b0:387:df8f:1406 with SMTP id
 98e67ed59e1d1-38fbc5ab01dmr832696a91.39.1785526338614; 
 Fri, 31 Jul 2026 12:32:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2962928sm1114762a91.3.2026.07.31.12.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 12:32:18 -0700 (PDT)
Message-ID: <e4e5bdc5-8135-46a0-8176-a10f148064bc@linaro.org>
Date: Fri, 31 Jul 2026 12:32:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/arm: Set fgt in cpregs for FGWTE3
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-6-richard.henderson@linaro.org>
 <CAFEAcA9BLUaK9p-MbBP+6qm2vAtd70hdkfXcAovPyw8m5bg6Kw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9BLUaK9p-MbBP+6qm2vAtd70hdkfXcAovPyw8m5bg6Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 7/31/26 10:26, Peter Maydell wrote:
> On Fri, 24 Jul 2026 at 04:06, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpregs-gcs.c |  5 +++--
>>   target/arm/helper.c     | 47 ++++++++++++++++++++++-------------------
>>   2 files changed, 28 insertions(+), 24 deletions(-)
> 
> You missed setting fgt for MECID_RL_A_EL3.

How odd.  I searched for it, missed it, and thought it might be coming in Gustavo's next 
patch set.  Perhaps just a typo on the search...

Anyway, thanks.


r~

