Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B4AE88D6E
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 01:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8pOS-0002lh-SP; Fri, 03 Apr 2026 21:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8pOR-0002lS-FK
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 21:01:43 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8pOP-0004TL-63
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 21:01:42 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so1418991a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775264500; x=1775869300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wgf9366UHbIBzJJ6UfeLJRUiuBgwR1WTaaZGYTx+aXQ=;
 b=N3Gb3k4yTLc14BBfKAaF2igA/QGsyPTPjrN4j3Zd/nXB8tM1FVWuBX2i+G3vYgOhi/
 98/BDboRDV5fuLordFADu5IwJvZ97QsS4v9Cpe/KyHP3xS9Gj7bjQNCnC/y1+Wf3SlUF
 2X204CxiEvjyuhy6mrYMlYjqdGQPV90mf8AytoDxA+JLV3nfBRiR6raGw5tfURj/ISUs
 PeYDwhdj340d6qbntAhfTu52YVtb6UGSIhZE85p0H3xD0X++tUydL4WK+CElbckmF4IZ
 fJGOHVHlkBl/U9cm7VWzJ4tZSszxhHGl17lW7Hp74Ma20ddmY3b13vLHyQ6uNhhtwibm
 gdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775264500; x=1775869300;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgf9366UHbIBzJJ6UfeLJRUiuBgwR1WTaaZGYTx+aXQ=;
 b=M4mn5RS8qki3uoLphSyZhUm4yYPoYK8nqeMf2CE7MN2knX8MllOC+8M55GA4m+Qxjh
 v7CPEqiNzyC6KXJUbC86u7HNn8jg3NGE/zxs8GRGPczqGprtOEFW5e8wZySad+JLzaAh
 R8wz/ZXt/Nxnu62Mv+yc1gdMq/Wvu0pQ9MBBt4dRBrUcrHwcTn+mgWgh02PFX9UA3jga
 N6Ab6CtPBnd9DnOPXdMLnhkwlkcmkIfKNGaZ+Y+KN2Zs2V4muQkpzoI89R0y23I21zAu
 iSs3JPsDnf4VrmE7ikTGOXpX0OI1EZP0m/f1GRFjn2Pm2flDw7Yka1ZW+Eq1dD5QvHUk
 HDQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc2p3s40NgwHa1Wjv73cVGaIYZeQcSy80sfv9JqIqxl49o3aGket/3VWyhp3SLcxfrbrZ4II8l/jIF@nongnu.org
X-Gm-Message-State: AOJu0YznmpTi+ZWtJ9NOqwmCx/u+vzBgNcemz6PkPR+MjofZJ4/a+caM
 zl9He/gb1g/9w3SbqLueWXzj8H4SztXpookCFGgl2qiooo5QhOzBfeQafCVG081hNmzPhop9v9/
 JhmpH32w=
X-Gm-Gg: AeBDieuSodUEsTP6eyNMv0p9mCtOE37DxfL/iCf4BR2GAXPRfqjxkhOypnnTmlxrAtv
 CSnmjQ9a9RvIJbR8XYP246FS/qXEUn1Uv90dqEZtXUCm4R/jgyXttGrw+vcFdy0gVc6Mk5hnZ5V
 j7QhG4E1TU17OPUjQimbbySZlvbT4h77DbYfVZh6hQWNEL54P1B7bTCv1MzvhiTgKlKVv0oUKtg
 TCkMB7ve+MxiF7A8O3Mpr2UBfcUk1x5VXWoULLjbix9lOGdRpyO1jo2tLWlcLUumbpxUaBtl936
 ov7roz8s7F7tsa8X1O+RFHtJW7GygAEeg97FeGJZWLgzIK0y86yvz/aJbvXsevdjyNKASkbCVmM
 xuY5Z3rUmZIv9HxajP6Qt48CSyLbaLGx94a1nb1K2OK5/CpMxUXGw1mDXnUhJyYq2b1hGhnPovY
 VQJG0wS6ksYsiECTvMYf5T4wwF0WjNjs//6A2mk3Vc2L2RD/NF/4tAMK5p4GFjjhZypJs=
X-Received: by 2002:a17:902:c950:b0:2b0:afbe:4e1a with SMTP id
 d9443c01a7336-2b2818fd42dmr51094465ad.41.1775264499476; 
 Fri, 03 Apr 2026 18:01:39 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472ddd0sm71177605ad.4.2026.04.03.18.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 18:01:38 -0700 (PDT)
Message-ID: <1c6d7e6f-eb16-4820-a4c2-35767c8db919@linaro.org>
Date: Sat, 4 Apr 2026 11:01:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] alpha: Replace helper_set_alarm with Typhoon
 Cchip MMIO register
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
 <20260401170454.32045-4-yodel.eldar@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401170454.32045-4-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/2/26 03:04, Yodel Eldar wrote:
> From: Yodel Eldar <yodel.eldar@yodel.dev>
> 
> This commit creates a QEMU-specific (non-standard) MMIO register
> in Typhoon's Cchip to replace helper_set_alarm() and to move
> the QEMUTimer pointer, alarm_timer, out of the Alpha CPU and into
> the chipset code.
> 
> Currently, PALcode writes to the QEMU-specific, synthetic
> Processor Register (index 251) and triggers the invocation of
> helper_set_alarm() as a side effect in QEMU, thereby setting
> the timer alarm expiration value.
> 
> This works, because the AlphaCPU contains the QEMUTimer and
> CPUAlphaState stores the alarm expiration value; however, the timer
> alarm callback resides in and is specific to the Typhoon chipset,
> thus the CPU and the chipset are entangled.
> 
> By designating the currently unused offset (0x7c0) of Cchip as the
> location of the timer alarm expiration, we can disentangle and
> better encapsulate both.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
> 
> Notes:
>      The patch to the palcode-clipper binary that follows this
>      one is necessary for this patch to work; I've left the
>      diff to the source in the notes of it for reproduction.
>      
>      Philippe:
>      Thanks, again, for the suggestion of decoupling the CPU from
>      the Typhoon using IRQ lines. In my response, I guessed that
>      getting the CPU index would be trickier than moving the timer
>      into TyphoonState; perhaps you'll find it amusing (as I do)
>      that it appears I had that backwards (due to the PALcode
>      peculiarity)!
>      
>      The remaining CPU interrupts will be refactored in v2 of that
>      series.

I'm not keen on this.  I would much rather keep the synthetic processor register than add 
a synthetic CChip mmio.

In any case, this is also doing more than one thing at a time. For instance, Connecting 
the irq on typhoon to the irq on the cpu does not depend on anything else.


r~

