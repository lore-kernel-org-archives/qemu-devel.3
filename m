Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC279C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0tN-0001cX-Kn; Mon, 05 May 2025 14:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0t9-0001PY-VM
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:50:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0t7-0006vw-CU
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:50:02 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-225477548e1so50673905ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470998; x=1747075798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ta9jvo3AKEZuDVgunvRvdzr3ATvRL4CLel6LqcL2wrI=;
 b=nnjjfFlz3zjIy/tOLP6UAg4gIPhBU00mJWitpEHzLeEITQQyxgx8oyTiONBwyNhB5o
 DJbFVIihfcnsltjlAbBKaME6EGTfjeu40pRJyocTEFQnlMo879CxSMM+ieVC3lMN4QEk
 oHVMQcxgzvgcL6LGDhdHUSUW7xIfsziQ+pSxH9ZnRX2v6ImMibkrgJX9cVdp3zfqSmKf
 TObLRVkaHmWPzTUEy1w+Dl2uZlzv141jNqY/bO3AeOzvIM03DOBNubMMk7MT8K5NmgV2
 v8/0XgrLZbRBzngdTjZXBBkaBQMrPJzPiIbL3nJ4s6LXGqptgXb5ORm4dALzFIPiI0LG
 +iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470998; x=1747075798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ta9jvo3AKEZuDVgunvRvdzr3ATvRL4CLel6LqcL2wrI=;
 b=NJ6CjO3P4tqNgC5yVnueLYfWdCQN/xCRgVF+XuVMrwHIN7lyBuzM8RSJBfP4qKqUcg
 SVyWj9NX3NmQcn1kp9gach1QRf0G2BAVZt3IFaXj5kRbPCDwYChU0mtsWaDF2wE2l2pP
 1zCibNsxbpg8r7QtqQtroUfqNywpXJRTrjZtjpxJf7syaWFYapflrsibikD2dYT3xVoJ
 BuOjxHFjkhU1odpR0AIdwpINsJe2xG60KXbuj/6F9sXGWBzpCAeCssbeu4xB/pdIEVsg
 6RC43SMmR0DbqH1BRyNkzB64SmFwmZmbMct/MtBn9S/rKx8R2oOIaZ2nfzNBc4pSDo0x
 7ynA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHKWep4k6Q8bAOOFo1fAs6VwFAdXI5RadgKCPHoaCH6Bx9S/ll8AUbxH0mlB1iniBJSVxrUa4/r5fk@nongnu.org
X-Gm-Message-State: AOJu0Yzsu6BojI+d2rvEVqkiv51JfwyJGm4g5sXwgM+6Z/3gcFr2tb8B
 XGT6DNeF4XaVbU+CBkxEQpTTk76KjYZZ2UEaIU5q0M8cGuODt58xvuvgOt3jPig=
X-Gm-Gg: ASbGncsZaaZGpT8I+hpSEghR3Y0rzJRrCzDWzbBQ+4pP8QL20kogqn6gmKKOV8eIxa7
 K++9dPP7BhcFNMmRwrAhRBDL0KvhE/jthIDCGM07q10Ku1VUFxekwnkmIl2rE3zEVqEDD/B58Xf
 FTg7MiwvIDWVfnPJak+rBmlVmWC4FgcL1LIrHCo9lpikGCEHa2MFCG39IjsDKTscFut3sJwYsbi
 srspQdBlqK/P/FJy3UKHsZnvJqIPWAay8P8FtJGG+DidVGat1rKC5YCHHIbtvK8kuFGp20mqYrH
 0pz56UAj7JZ4fC+zIGTmJgRNMUZjG86SA7bHGiMTgGrTS0qPgXQ+u/MffFcVNSZ/bYwxOzNjCvQ
 953JI620=
X-Google-Smtp-Source: AGHT+IGwaWwoaIh0UAcV4KiVMS3oBhW2UNucgbSD7FkDN5CheSLqg7kcicpiYhK/ibBbWx3Qh9MTeA==
X-Received: by 2002:a17:902:f543:b0:224:2a6d:55ae with SMTP id
 d9443c01a7336-22e1eac1872mr152998795ad.48.1746470998678; 
 Mon, 05 May 2025 11:49:58 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15228bbesm58347355ad.164.2025.05.05.11.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:49:58 -0700 (PDT)
Message-ID: <b381f802-9eb9-40ee-a7de-f3b5c49abfff@linaro.org>
Date: Mon, 5 May 2025 11:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 46/48] target/arm/tcg/tlb-insns: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-47-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-47-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> aarch64 specific code is guarded by cpu_isar_feature(aa64*), so it's
> safe to expose it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/tlb-insns.c | 7 -------
>   target/arm/tcg/meson.build | 3 ++-
>   2 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

In an ideal world, this would only be included within the system build, since all tlb 
flushing insns are privileged.  However, it would appear helper.c needs more cleanup 
before that could happen.


r~

