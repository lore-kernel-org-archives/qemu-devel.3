Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F68FC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ORU-0004pY-F6; Thu, 03 Apr 2025 13:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0ORT-0004ok-4L
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:33:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0ORR-0007Rl-Af
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:33:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7359aca7ef2so1436616b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701604; x=1744306404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=muBPTjYt3KMh4Cr3cxDcAhIlTFkT5C3V+LLPY/a3I8w=;
 b=sRq3jsL3TtF2d6MGpyNPsVrf8W0g5ZbpDNLONHGHRBIULc+H12HGe9MkAOryfEDWgK
 BssWNRg7IKlQ3jIabOuRF5Q9vgdkGDrBW666GXfV4BM8bf8dd5204pprBEh0UB1HEUKp
 r5p7PBFb/KiW6CRt64yfyJVjaVLuDOs+EGAvdYteo+gloNrLuLoL92yUEJBiK59jXwcv
 yMwq+9C3asuR6vy/pzPGIBeqCeXZEKkMpfogO2fcGlVes8e0WCMnw5ImukbkcagdMOOr
 F8W4YVEm/yOO2SOrJnZxU2tsx8lfLSAEVnLSKCDatTFFngzPCg9CLxR1OoVNuICTnlMo
 TuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701604; x=1744306404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=muBPTjYt3KMh4Cr3cxDcAhIlTFkT5C3V+LLPY/a3I8w=;
 b=C8Q0ZmryDXSAZDS2GWet1zgF7r0HXsYhj2R3WX8GfeOusxQ9nN2Aeh8ppsrLVyXDTF
 /8xmt1Zdh2qPmy0c2C4kHWX4eB9s0TuxRYLOAWe8aXeMksVNjejM8EfHnmsb01K0GeQO
 k0M20Zkz7xc4hmY16HXK8MktBywC0/erseBuGIcorxKR4yprTZDtK3jBwRBo8ra7S0Zs
 CzwJt716hyMkiHhi8MJCWX6RhWREBJUs2IX+DGZhU5WvT3HyysDHJ/qRFQJH6OhJqWh6
 MkqnWqOZ/lpvQRBedl2gXRtEFIPQZbZ62rKaCMXAMi3V8K2OE/qD1ipy4ZvEEUYFZIwD
 x7kg==
X-Gm-Message-State: AOJu0YyZqXfCT+etRZZjDY49krqDn3Bn6zTXzF86l2udzcKupVjkzWer
 YUUIzoeD4KNyslPQwN6Gf0foXmn81eWLEFql7rkc9LeoVat5TmW0hGOROr3JAnNsGk76N01MrW6
 p
X-Gm-Gg: ASbGnctDy/Q4D7Xa0R2lYqBPxAbJeIhZx5nz7ZOr0DKY7GDnusrX0r6l3eR/o5MTTUM
 d4QCyYMrjksOUR6WGAJHMidMwYlQWO01e9D6bL1Wq661obQLCprNmIYx1YK5vvD18FRZTGspoO2
 qQXmV1caCZLvuW0qfG2V/5MjYRuFFmFIHBpMKFI+ZLcY3W9kI3uTXKKuxjJ6pp2MbZpOfScB/Pt
 xiNV6Sb9AxnCw+6DpejidUH5yx5oBtuk1k0e7s1hkGgK9Xt6vMO4tcqMWTlnb93afMD95q/jxgi
 Dle9kqyNsuwHp2gJPaJkxSF9Lx+T1xd8eyh5lBYjMaw4dJ3I7j1G4KAQygR24GI3Mw06avCS0aZ
 p//uklQTgwJoHJHRXCNk=
X-Google-Smtp-Source: AGHT+IGZ8hyhv07dR7aSplnTY6CLIYTLP4g5vyZdhZKME4bcp5IQWQbygkxngicLWHL1uLDQolO5vQ==
X-Received: by 2002:a05:6a00:3317:b0:736:5dc6:a14f with SMTP id
 d2e1a72fcca58-739e4c26381mr516362b3a.23.1743701603273; 
 Thu, 03 Apr 2025 10:33:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc10dea2sm1507271a12.0.2025.04.03.10.33.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:33:22 -0700 (PDT)
Message-ID: <c5865e7f-67ab-4b63-90b3-b96083a9c661@linaro.org>
Date: Thu, 3 Apr 2025 10:33:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 04/14] tests/qtest: Skip Aarch64 VMapple
 machine
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> First, the VMapple machine only works with the ARM 'host' CPU
> type, which isn't accepted for QTest:
> 
>    $ qemu-system-aarch64 -M vmapple -accel qtest
>    qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
> 
> Second, the QTest framework expects machines to be createable
> without specifying optional arguments, however the VMapple
> machine requires few of them:
> 
>    $ qemu-system-aarch64 -M vmapple -accel qtest
>    qemu-system-aarch64: No firmware specified
> 
>    $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
>    qemu-system-aarch64: No AUX device. Please specify one as pflash drive.
> 
> Restrict this machine with QTest so we can at least run check-qtest,
> otherwise we get:
> 
>    $ make check-qtest-aarch64
>    qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
>    Broken pipe
>    ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>    ...
>     7/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp     ERROR      24.71s   killed by signal 6 SIGABRT
>     2/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test     ERROR      71.23s   killed by signal 6 SIGABRT
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/libqtest.c | 1 +
>   1 file changed, 1 insertion(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 2750067861e..fad307d125a 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1788,6 +1788,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
>           if (!strncmp("xenfv", machines[i].name, 5) ||
>               g_str_equal("xenpv", machines[i].name) ||
>               g_str_equal("xenpvh", machines[i].name) ||
> +            g_str_equal("vmapple", machines[i].name) ||
>               g_str_equal("nitro-enclave", machines[i].name)) {
>               continue;
>           }


