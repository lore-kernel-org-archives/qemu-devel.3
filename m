Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E33C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 17:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thBJc-00036L-9o; Sun, 09 Feb 2025 12:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBJS-00035j-IC
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 12:41:47 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thBJN-0007oF-Ku
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 12:41:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so36387925e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739122897; x=1739727697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+YRkLbBScq3OWZsTCYxQl6VA6RluAOAZ5euu/Z5wTTY=;
 b=JV3G126KFJAfGVlNca4F59ppXU7OXvqWmZUcMdMEGYXuMNho5GZIA2i04ewXfkVPJv
 wB9bVfKB6tUI0kpbrab2e6HMyuCEQ5kzmB26VwviopePM3+A0lbJ+QP5/1bRDlXSCZVs
 ek9iBcq1ds50ozCJzO+Dc718+f+zafMI9fyz9wrLD8dCgWNTDRV1kRJ83xPf6xmUaAfQ
 YYNpAhU8ae1LzjMIlccOAbegHCuCP+YOuStmkTV1kheOkvEUefS7K/RH7nf1zKv9oMtn
 C9lXYpIlPt1loNWXzNR68uFt0nOCoOUBVHjOuoby7G1FcvKHM0g3jNMlUWlGGceBgoBO
 DBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739122897; x=1739727697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+YRkLbBScq3OWZsTCYxQl6VA6RluAOAZ5euu/Z5wTTY=;
 b=foECXGpPjYLgrxESJJcbxqte3GnmvG+boxLHkL1iZnU0MIbwGG1mgCqHtvp0R2TRos
 Pb7mrLzgYj5ywV6Gk1pz0vr/vJD+jtlH4uNnPKkIAcFy123vf5RpfS52e8xw96FMdwMx
 uzzocU63PxaYk6lz54PJBCt/+i7LZXOzdh62iPeVfVGD9BKrnTkizwTIoed6/H9fNF96
 HAe5if9SdmJot0utnuhj0ir1tRHokPzxA6uL4yz5CNRYyiBljLpBjtFw1e8SEdbNemHK
 W7FM6ADR1OeuiRmdH7Z+kI/c9zI8j/b8v3eUOUp4OB/IFDtFnW65zq/QuuUjH0JF6Skb
 gg1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4XH6lgZCTW3eCQe3//BZpY4RUMGBpKXI7Y4t2MWu9oHSpVMyfkQFkwk+6yDquy2xLBcKLGlt21O/r@nongnu.org
X-Gm-Message-State: AOJu0YwRM9gOZl95jEqMlILMwviEfKuhZMnto+U+cGXfvZhd4tArfbN5
 nEWCOeGt9yh1Zw+XvHMBMunH/Q0TeU6gtIE5TcUqNVhZDdE79JKNg9lS7fqvC38=
X-Gm-Gg: ASbGnctYP13+7KaFVQac6M707tyyUZ1zBd3Q8r8bZiaEw0eiUXgYYzsiDfvTGJK6UiC
 dj6Sl2ke3DDP3lGSt/+oK7B1AtBO6/ua8npDDhfegYot9+g7edeDxcqR5amTCdWmymwNd5/UjSf
 uiEd4E7kkt/JTFYqnW2XzwWr47T5B8kQ2CBF9JpK+vGO/mgkhwvdp0u4h4ynVNV76f2c9z5OmRV
 Sjdf6ZRkZvXnoRSK8hfp7hh+XtACMXg1mNK0aSrZPlSWUrv5fGTmNqHQvsUldEL8Hym8D5YZEFV
 +PkaneDu2PCYx/7ikn2/28IgI6dqSyEpS44DzGAr9axvhdaR10O4z9/YQz0=
X-Google-Smtp-Source: AGHT+IGXllxJRqBNpefMTuWI5XxsQ78VMUXhlRDLSi0cc9Fuevx/BfB2nE5Hnrw7xBymOy7glGd00Q==
X-Received: by 2002:a05:600c:3b89:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-439249af2f0mr82773045e9.24.1739122897333; 
 Sun, 09 Feb 2025 09:41:37 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc5e6f027sm8354985f8f.4.2025.02.09.09.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 09:41:36 -0800 (PST)
Message-ID: <b9b0c5c1-1d1b-4c58-8540-4093356e2a4d@linaro.org>
Date: Sun, 9 Feb 2025 18:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu/timer: Sanity check timer_list in
 timer_init_full()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250125182425.59708-1-philmd@linaro.org>
 <20250125182425.59708-3-philmd@linaro.org>
 <cc04420e-efdb-4551-9dc1-b0dff1c1df9b@tls.msk.ru>
 <6b159be8-01e7-4dc7-9260-849432f1f4bf@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6b159be8-01e7-4dc7-9260-849432f1f4bf@tls.msk.ru>
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

On 9/2/25 10:41, Michael Tokarev wrote:
> 09.02.2025 12:37, Michael Tokarev wrote:
>> 25.01.2025 21:24, Philippe Mathieu-Daudé wrote:
>>
>>> - * You need not call an explicit deinit call. Simply make
>>> + * You need not call an explicit timer_deinit() call. Simply make
>>>    * sure it is not on a list with timer_del.
>>
>> Reworded this as "You need not call timer_deinit() explicitly. Simply 
>> make..."
> 
> "You don't need to call timer_deinit() explicitly.", actually.
> 
> This breaks quite a lot of CI tests: https://gitlab.com/mjt0k/qemu/-/ 
> pipelines/1662551717

Do sorry, I only tested on a specific config and missed all the
other errors :/

