Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F79CD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMXy-00052g-0n; Thu, 30 Apr 2026 04:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIMXw-000521-7x
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:14:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIMXu-000584-Qu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:14:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ad135063so5104765e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777536893; x=1778141693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FyqKssiYVYgco7mPDSjtbNkf1qh0ZvzsNlxrcp9d+ko=;
 b=NjdpQWh5YAMlB6lk7i4QEqGWyfLy2SO40Rr+PGyKSi1TVlE/cRDGTgwHjhAqszVC8L
 f827rQN7LIYUfA3qFgIZivw5zp/rVY2L8GnWGtnp7WfVl0wXU1DCzowsMT0uwkxTKzwr
 jb73WErkgkCwZmUKoZlYOs8EpcEdQXrltv6icIXdE92r4XS+F88SLIe9ZW27tfcUf4HU
 +JbTKcWtonme06btp/j85TGL2l+D1M0TdP1j26+paPMF5+MhhfJLFdvX2YD81EV99Bci
 4WPxZVmwG9HRXln3nx59jpdsQsH9mTR1tR90AU9cgr6XSuG37ree74rtU2sXI66RP4Rk
 cTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536893; x=1778141693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FyqKssiYVYgco7mPDSjtbNkf1qh0ZvzsNlxrcp9d+ko=;
 b=tRgGQujQFM2a7zJ4O/HYiPwFzvEn3aeVZZuSJrhw8WhMzkB5GteeLFfo3GIhhuWwzg
 GyBQrXFJJrpIR1GZzO9VuzM75TLA51EcFrDfNxgJQAvhDc8MTH4cL//8Oz28djJUYd/V
 trUJkBYdRQJJl4jpubAazE6JgFH+ticK3wPfwgCfNfwM0ZQjM3NYO8tnwBMbyoh3rojZ
 4H7Uqw2IaeWEdAmFDJW5iOHv3GodQ5Jawg6sPHS/Yc070Jc5yIjhZlfQWQvfwa47fLx/
 G6GkPLBgNrC1DTZxlLJRTLDNffY95Dqg6xMUjAioK7Lh6CPT+CdeYDS1HY+8+Jce40on
 ANBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dcrNffQEVGiT1xo64mhLTteT0IdUO0/F3lIQoyA6E/RveK+xlkmiv4dC4XLSJGIDPC6QXwX86wKuN@nongnu.org
X-Gm-Message-State: AOJu0Yx0noZy0zKms+5AIext2STkXGzSsqXDaNCXspJLz/m6uC48DMYD
 hfvOohJ11A8dBW35odbKXPZDIaFFsTFsU1+DPOQ7VgMwK2pWzsEpGeea3Td0IMLqB3M=
X-Gm-Gg: AeBDies2lCOuVzNByHPQ6l152BJ0VoHX3WVuDppkajHhvvqJJ7uiUSqt3S9KB3jbXH2
 f7AwJRVGO9UOo+CK40Mk6NWAVOin/78Cj8Y82K6GWwunaHktwFwusUNp1xSTedjUbijZLim1meX
 jWGyUeM2vFJxUODSzIs1NeRLYDrY3wFfdDhcVcxInleQCVtUH1L39pzaoTuHzQ8lgIbae2Bcl4I
 D/sTQIdpv5zTIruEyStmNzknpXgYh9X/3jvfF7iFjVNdz3y0rUpw+TqTSWVpIKfT+hPZb28YfhZ
 x1UjyiPBhyH4QEMI0BnJcuHwrbtUyReC+G6PcN3Y2TbA5nWCXrR2UHXBJYe0G+hVs5J45OvyTZV
 HPOBRgOR1dD4rsXqys4qE2aGzAUhU3t50z+7yl5GPIjI7Fw3042d72q8KZYwpqNRomt3gY1H0L6
 JGWjImShD451FVAGq9mnzY2zfYH+N1J80uWEvdUm8l2bE/R9GcUwqlCHfca0VMXEppMzN49UzmD
 cx0
X-Received: by 2002:a05:600c:3d97:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-48a84467813mr29087245e9.28.1777536893109; 
 Thu, 30 Apr 2026 01:14:53 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b900af7sm38501545e9.1.2026.04.30.01.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 01:14:52 -0700 (PDT)
Message-ID: <9cf5f63c-4bf9-4927-b2a6-1d0109eb1349@linaro.org>
Date: Thu, 30 Apr 2026 10:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] qom: shorten name of object_set_properties_from_keyval
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260429210830.594724-1-berrange@redhat.com>
 <20260429210830.594724-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260429210830.594724-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 29/4/26 23:08, Daniel P. Berrangé wrote:
> This matches the convention established by the object_set_props and
> object_set_propv methods.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h    |  6 +++---
>   qom/object_interfaces.c | 12 ++++++------
>   system/qdev-monitor.c   |  4 ++--
>   system/vl.c             |  7 ++++---
>   4 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

