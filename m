Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED2FCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoli-0004QM-2r; Tue, 12 May 2026 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMolY-0004Pr-S5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:11:26 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMolW-0005Z1-Lr
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:11:24 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so2163737fac.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778598681; x=1779203481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uci1EHVHpr6OFezu1pO3ep8iHAU4yJl7hcVoi+5g+k=;
 b=NDveyU5yB7UMTbXU/2o+70/rotyt/WgxbiB+yTO22E0Qut2Pl9IEX+1CrHwfG8CY5L
 Zv36lUBNg1nWDERmSLl5fJ56Ir84Mkat7mEkCEnDIPZ3z/QnuJ7joUMeAtMVOc41jHp2
 +B710dqp8+UbCYixmkQgaNjIcDSmJLT3wLHXAy1C5fqoLvn0fALRWjhwLHfbmtiDRQT4
 YwT1ZfaSdpYoxSW3mVieR5Ygh0gXvb9up3r7DJ2hqztJFeBmXhv+VuppT8f8NsVvQrBa
 LhN81+8UowLYS69jkmbBPYAZf1zgyNty/HdkNjHgXbqqo5ZpGzb4RhDQCc1z96ehrGrp
 ROcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598681; x=1779203481;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9uci1EHVHpr6OFezu1pO3ep8iHAU4yJl7hcVoi+5g+k=;
 b=pB/20usJXXPtm9Y/yogV4UZdBFClVRFDIYzgNeGtkOZ9Q8d3ZLPI4L/JWl+GsGDgki
 caeUa62IdhC0Roj0wl1Bz6O37T/FoxkbtQyAzDs4aHl9NEuu+5arUHmxhP93QoWvOlk9
 Ws7cg0J8h3TT1qFbownkAWcEwV6BWLpyEfbRAu0u2HvQ4xzlZZobE7znpdDX71vn5QIh
 5hS7lp2cyXep+vKvNgdNzcTe9dpIdn1GKCRGhZkX75HdfKs55E89JyAU+RIJZAgqpoh1
 H35XhKeAqboX7UZfG7nquPWfyrGsBUP+ZxF30GW4X3Lj+e8SGiyABFcE/N4fM5W+hLI7
 yrbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JLlaaKqQ9PD8W77xscixVDBdFy/+fOWsQhpEVscWz5D/jnMZVd0FNXnlzux3X+UA39/9XYU37ktlm@nongnu.org
X-Gm-Message-State: AOJu0YxnEXjyRtg3wa3NeMZZ/a3N5eS+98+4ExdwE0DMklw55StfxxVY
 SwmhV3v+JM8nlfUd1w32oWQ0vZO0wOBFYqcoR7qD/gwWZNPI/4gf30w4jR7xtmjyDfvMt62Ba6O
 QfE/r
X-Gm-Gg: Acq92OFijS/aT6dpNU41TVY9IyRI6JShZWe7cz56sRyKlQY9PGurDNW9eNcgxtdZ+AK
 QYgUn8yq0STqRbdtOEevvKSrARF8Ij5Gf2++fp0uG9Ln8w+mDLURnMA6bG+I0R5OmN4jOxUbN1y
 Pw4JHRgR/FbMosrgy/8XdXWKrG6L/bf7N4BA7pr1txApxWln6LNJ/Bf6kHdEUTzP83KzvX+wya6
 04ei7OCSTnTGTBFlNX+OWuYdBLOHSNjxGAVsWJ2mFTTMK1EX1FFVwH4m8CbHjU1CGeCLiv5DjB+
 uY5kCCikN/2g+KrGo6CxMb3f1/ayBnxropoLgk83tlPeSSeHu+HKjWy8+3ljj4TCHV/0qnC20g2
 /zqLw5BSVks4iwUJhN8tl6tJ3T33vhncxA42CSg/c7Qtw2jxXb3JBStebW5YoqAmT/iCUqPIO4p
 m2OUix+qt09mRkCZH3a87U+rA2ZAgnh0Yy2kapRK85kkru0r468h/HATsDaKkYGSV3vMmaMb3K6
 tFb0npX+w==
X-Received: by 2002:a05:6820:208e:b0:694:a3d8:e532 with SMTP id
 006d021491bc7-69b69deacd3mr1648134eaf.37.1778598681286; 
 Tue, 12 May 2026 08:11:21 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:63de:4fd4:c660:2749?
 ([2600:381:c938:6375:63de:4fd4:c660:2749])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c1ba56sm7831090eaf.3.2026.05.12.08.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:11:20 -0700 (PDT)
Message-ID: <e653be1b-7b8f-4ede-9668-91f59681f270@linaro.org>
Date: Tue, 12 May 2026 10:11:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] target-info: replace target_info() in system-mode
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
 <20260512150208.1167711-6-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512150208.1167711-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 5/12/26 10:02, Pierrick Bouvier wrote:
> We now can use TargetInfo information available from QOM, and remove
> duplicated target_info() symbol.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-init.h | 5 -----
>   target-info-qom.c               | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)

  Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

