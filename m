Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEFCEDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5Yk-00009C-3A; Tue, 10 Sep 2024 14:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so5YS-00006b-R6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:25:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so5YN-000104-1V
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:25:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-205659dc63aso58692175ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725992725; x=1726597525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+apKFwRTq+GS/zaWIu8Jni8n15c/rLBfDrOp5IZGZ8=;
 b=a2Pj45R717J9ybGxyotKQltNKyc4Gyz+TQNfRi8QW/y9ZDMc/hHgM19gjQmfGMyCae
 fM5kW7piDvQQ3kXiOhrKFw0axdrUiNVyhNpKAd3cslt1HiUPzE7av6qufd4daAFPGM0y
 9KfN/vAzIgm+tSJOqnAZfxdr2UM9IEXTibp53oVaFNgfxaK2sycYeOo+NfgsVwR0z7t5
 xvyTig7WYVkdzIDZWZmZC+fAEPcUw438LkeSUQJEKih+Ex04a+DYNk0u2wh+SAITvnGx
 r4nboxaBEy7u3ahh7lytUPmBG9YbqTHv2Ju3AukIBvkz/1SaZzv4HxTl44Er6gT/+Q9S
 Mp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725992725; x=1726597525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+apKFwRTq+GS/zaWIu8Jni8n15c/rLBfDrOp5IZGZ8=;
 b=OYXTBlz8maoZTRtiJbinD69csCIDlrLsOaQCDSlLPI151PY0XW1NzVbh+5Ysipvxgo
 6oGGEcsXZcCTX1PgoydzlAa8Oz5NZRuGhM0cAKgKaqRVLGA0FiZDGhtdUIuatq+AMWYO
 rvp6l1il9TT1acPTAnirNMLzprDsxlqvcnU89irmkDmCZdv6McOmzcd+UvdId4K1H+lD
 lzCsovs3X8E6WOeHmYYqio9jC467Xait08/JhyapzlyeNR6Mqd39mt/FF+XBePYUO6XL
 25QcOBXlHBIT/1y/Oj31QUoAsXRb9Z3JWbRz8+GSXTwP2aUUI6nd1TKX62yMHZd5RzO5
 5GnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc70wm8w4D4QIRpWs7Q0sLNFXqTMHmAa1mj61SJ4YgwjRZCWujtvS6jjoFklEwaKqtTYEqzZZqGQgb@nongnu.org
X-Gm-Message-State: AOJu0YyRZELsF291NH8Re3R4rjxpk9Aj7eb5lA96SItNljCU0W/2Ok3F
 898aB2fx0le6cGx9slyb9kLcCllTzz8qq4zhgisy9aQY+wRfKwsT5gRGN3cUXmw=
X-Google-Smtp-Source: AGHT+IFJv16jHK1VoNBh6Qxh2fKthyUzRfOV5/JspBH0NTA37vv4HmsU+suFsoG6WS7iBCOroI7/DQ==
X-Received: by 2002:a17:903:2a8e:b0:202:3103:c250 with SMTP id
 d9443c01a7336-2074c72280emr21118395ad.38.1725992724664; 
 Tue, 10 Sep 2024 11:25:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710eea9d1sm51593905ad.157.2024.09.10.11.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:25:23 -0700 (PDT)
Message-ID: <bef11607-6743-4822-89ad-e91f79bb57d0@linaro.org>
Date: Tue, 10 Sep 2024 11:25:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] license: Fix typos and update deprecated SPDX tags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-trivial@nongnu.org
References: <20240910115131.28766-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910115131.28766-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 9/10/24 04:51, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (5):
>    NSIS: Simplify license description
>    tests/functional: Correct typo in test_netdev_ethtool.py SPDX tag
>    license: Update deprecated SPDX tag LGPL-2.0+ to LGPL-2.0-or-later
>    license: Update deprecated SPDX tag GPL-2.0+ to GPL-2.0-or-later
>    license: Update deprecated SPDX tag GPL-2.0 to GPL-2.0-only

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

