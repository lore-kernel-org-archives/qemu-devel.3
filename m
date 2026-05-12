Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E162CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrXe-0005Sj-JK; Tue, 12 May 2026 14:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMrXc-0005SE-S6
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:09:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMrXZ-0008KW-5C
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:09:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso63678055e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778609347; x=1779214147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7kSJKvdDedYaA/WxmqjYn0+9CJjwXSAlO2Gh4DJJEU4=;
 b=dXP3maB7qyHWpBwEHjytYyeyyAYB9Ksfs+4z9hFN3OOlQ38O2yE6m9Q2cQk/WDtAWW
 hSQbLi8/GkojiFmugMhL7tR2wQjEO7/aoC6jQ6EOLMSLGlKUC51aGj1rNkVr5mHy2BdV
 MjQdjBFEPK9tAzunTIKGZcj7Cc/Q3mAIbhiJmK/dbdMQU1COkZnsvGN6J1RL/+t7nCDc
 veB4E9N4Q7kxy2f7KbsjB0EwxYGdVxA9tY9WgAhnprXZKtqs0KDSsL+OGONhf5o7Dw4t
 454DgWtKDqyzXegul5u14NSmVIJujuXZmCPAYAgZyT9uXKdUjlm/Eo/cx1PgqtyDDwuk
 vKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778609347; x=1779214147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kSJKvdDedYaA/WxmqjYn0+9CJjwXSAlO2Gh4DJJEU4=;
 b=tX4HbcGLPfCelfKrJNh4RAMQAAHaOCb3xpPdJgDFqqAvbWwzGxfanzlQSRanGeuPmi
 lanKpQuQl4A4WvW0/ngJIxV2Aypoqc8UeRybzRsfh58ac41caO6F6iVAj5Y3CJtLytqh
 5EQdv1MD0Cv3MhWAO9Ao75GKj+dMmdIfAbdVObNO0CtpTouiQ8D6mtCN4bEL4AuHrAqy
 38q1mqbemwA83N/lOIGq5RaMBRCY0scTAk6KVEnRcoCkr9Uvk8woNLjdHmKOzj05go38
 ZxhE4cl+YCmL5uW2d+St7RXJCNIvkjKCjholbp03Npb8oEy/wrkeatZWTTSOukSASqpU
 l/uA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KJk+uumQy9HT1BW4npDgiSJ22BJU8x+HpkN9yBov7cO6syj5tsDPo1GugKhmXQlpatPQIUP7vD8yW@nongnu.org
X-Gm-Message-State: AOJu0Yx/ICc0jr2iP+vgmdDXnlZH++/GNgnJpBFNI85PLZyvRs38ODIM
 ttRE/C6WgApUILgqAeaf0cjqp9cL4xp0PfLyOk27kT/Npdo2fuCoEdotEeSbuHStCyc=
X-Gm-Gg: Acq92OGUWBW/mvvynpiCmuly6GTp0OZdt3xGFWpKf+Ifmu83Yxup6if16ar2Yq9qxnC
 OrT/LsuuAlvRSVunuKaVxjfwx2WD+ZvnfkBXS0EZ+j0K5kcAQ7AWvJuEr142SVo1Eii5yBNefXP
 /2NXQ4Wc9m1geFvEXVSfxg2mV5WMOuLECiXJio7w2J7OChmHjvIIv8X+iPYriF3cZYBRpmPXHdE
 VF8QyO4aZiPQb3thq1b+yNef9glM6P2+dFZp+SxyN5aFYIVLuYVouHy1C7CsWeGAr8kzf0RTtH2
 ipj5YMnsY84e4GJ4mt9TU+gGLlFAI/C5PYYYgOvgZH+4TC6HlTmbfQCSumZoMzqD3KXcND1+Wn9
 twrPrr9KWLh8MbQodvtTNPGwYJvAu7jd6Az7t+p3LVZtU0Z1Vikl2er6LjgkkZw1jRN10V9pyxC
 8LN1XruYSBpgEwBWJMfi95Npbzxib0iLcBE95X0AUwRIUS5mnZwQjvtkjY7BCW/6pCrQ==
X-Received: by 2002:a05:600c:3513:b0:48a:72ab:f88c with SMTP id
 5b1f17b1804b1-48fc9a3327cmr36975e9.17.1778609347273; 
 Tue, 12 May 2026 11:09:07 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8cccf90sm14259295e9.0.2026.05.12.11.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 11:09:06 -0700 (PDT)
Message-ID: <1a35c23a-0d95-4513-8b05-b0876bc9db92@linaro.org>
Date: Tue, 12 May 2026 20:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] target-info: replace target_info() in system-mode
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
 <20260512150208.1167711-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512150208.1167711-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/5/26 17:02, Pierrick Bouvier wrote:
> We now can use TargetInfo information available from QOM, and remove
> duplicated target_info() symbol.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-init.h | 5 -----
>   target-info-qom.c               | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

:>

