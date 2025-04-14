Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3CAC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MOy-0001u6-6y; Mon, 14 Apr 2025 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4MOb-0001oo-JJ
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:10:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4MOZ-0000N5-Aw
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:10:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so38857475e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744647041; x=1745251841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vsVZki9aVUMPgj1KDUr3cVqk2wTkPTQG2dt6tX3SEEo=;
 b=I//HKoAjYLFk81SM7gjklgMVnwpHM98mKB4JYUUNWzy22LuWhprZ1wRms8+0/5UHhy
 +n3vLYthS08Vm+XjiLgAI5nMJYhwqwhJE6mr0kH+Ixr93AFtznt4exYh/JCAzdl//c6a
 0EKqMtu3D1ZfoeBOauHjnG7/KJJrRM8BJyp6KHqBb9DYd5FI9JcaJziMIGIyruAXw7Ob
 DRgiT9UfeI0saLQHfG6RnbM0uQ5ZzkLDzpIuVFuYNDzvQG+LWYzCFmHHZB2fXgbtwsqZ
 CeJwBmpIiv73w/0sWpBfZicOOsz12WzuEy5T2Dp1F3JknbSlMQ+ESDOI3oJwWOWin48X
 eP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744647041; x=1745251841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vsVZki9aVUMPgj1KDUr3cVqk2wTkPTQG2dt6tX3SEEo=;
 b=TUicC3bPExMejRtb5cZ5Jh051+b1DM+p/QpF1T6AcwLvMO8A+B31SzVttbQa7ZPmho
 sGUo4+3Ck7AHZTnIqv34FlVu2HUS5pNnGDrKKOOFAP2zz625sqBX7P4n8QU2/daVumBc
 ayJCK0NaRjeSN5mc2GWeIo0hkd+9uZzerNCGRFTPlwl4kWuRWll23iTN+HBwBjRumT7C
 viSjKkBPOIQxPBqFmG3on4cAM8MOFH+IKTGvYjwOueOs+6rsXsm0zXU5hX4HoV3lseu7
 B48oD9Q5D63UNGWHw8Kp+4LrQ5vQBTzYdVM8EfGX3SD2Yf+j66wrhhTZ2JTHfIpgN6Xf
 qsnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdjz+CNQJ1lbGc/GFgVGUu7Ao8wP7kHJLnQnuz0DwyBBu5s6idJXwvaNvw2wwuspXRLDucVCqYAxT1@nongnu.org
X-Gm-Message-State: AOJu0YwtqcPyb9U8JAYWh4a0A97cGXoyBm2Q9xlrOJRMeK4eSvLQZKLl
 xQY/AGmwwT0rX/4i6KVtuIf6kaX6N261gQjmrMuLNmjYaS+FjtK5lH4z3sinFj0=
X-Gm-Gg: ASbGncvWTBp4UUh3gnNgwNGSiHpDi8sn0/uY7Grt9K7SVjoq+vqxeZNou05T4w4GPlh
 pH1TgQ8ErHa28OrvSMlLxGj9LfsMGzcDRHmk9nZiwe51lFRxWpTBlKMQuBAC5gzgfI3rsW+aevz
 enbKIoR+O3BpXrFg+KWd5ibYycTNMxqmT/VUe4bewSt5Gc+ETNlpmTlb90H0fxJojQ8B0CqDqNp
 HSjKf5IqbEff1fkV9wvu4etoBrqsBj2nEapkQWqzZvVseRa+SKNP+zfdfYuaRVClp6h/XjInTJv
 lgfg5O3XYL9Uw6BAwq8IdhNoPv3CP7YeY1w2T/sgz0hxklRDGulvfvN4FQGpvpPmx3pYsqakTqI
 2nYTIPnwFir2HqZ+wCgo=
X-Google-Smtp-Source: AGHT+IE9VZ17Z4CfjmAQjzRzKPc3XxSPBYcoA27Le+7/5Z4BKyGdthYmKNZDBqtqdaxPBMpOhqB9Hw==
X-Received: by 2002:a05:600c:1c2a:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-43f3a9258e5mr92977615e9.5.1744647041529; 
 Mon, 14 Apr 2025 09:10:41 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a2a13sm179125425e9.10.2025.04.14.09.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 09:10:40 -0700 (PDT)
Message-ID: <e941c299-e822-48f6-a3e1-f47f177684ac@linaro.org>
Date: Mon, 14 Apr 2025 18:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Remove unnecessary import statements
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250414145457.261734-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250414145457.261734-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 14/4/25 16:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> pylint complains about these unnecessary import statements,
> so let's remove them.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/ports.py              | 3 +--
>   tests/functional/qemu_test/tuxruntest.py         | 2 --
>   tests/functional/qemu_test/uncompress.py         | 2 +-
>   tests/functional/test_aarch64_rme_sbsaref.py     | 6 ++----
>   tests/functional/test_aarch64_rme_virt.py        | 2 --
>   tests/functional/test_aarch64_sbsaref_alpine.py  | 3 ---
>   tests/functional/test_aarch64_sbsaref_freebsd.py | 2 --
>   tests/functional/test_aarch64_tcg_plugins.py     | 1 -
>   tests/functional/test_aarch64_virt.py            | 8 ++------
>   tests/functional/test_arm_aspeed_ast2500.py      | 3 +--
>   tests/functional/test_arm_cubieboard.py          | 2 --
>   tests/functional/test_arm_quanta_gsj.py          | 2 --
>   tests/functional/test_arm_smdkc210.py            | 2 --
>   tests/functional/test_migration.py               | 3 +--
>   tests/functional/test_mips64el_replay.py         | 6 +-----
>   tests/functional/test_mips_replay.py             | 2 +-
>   tests/functional/test_mipsel_replay.py           | 2 +-
>   tests/functional/test_ppc64_hv.py                | 8 ++++----
>   tests/functional/test_vnc.py                     | 4 ++--
>   tests/functional/test_x86_64_kvm_xen.py          | 2 --
>   20 files changed, 17 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


