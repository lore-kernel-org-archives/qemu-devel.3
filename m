Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C08C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 21:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCPXp-00009I-5r; Tue, 06 May 2025 17:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCPXn-00008z-OX
 for qemu-devel@nongnu.org; Tue, 06 May 2025 17:09:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCPXl-0002Ty-H8
 for qemu-devel@nongnu.org; Tue, 06 May 2025 17:09:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22401f4d35aso74056275ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746565775; x=1747170575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sjbg7I52z0npdmEfxhkf0Fiw9IZ+X9uZHh3o80HirmQ=;
 b=uGwGRe1yv8W4bycYyP1pl9wxJfDrsXWBk5wgvV5qeudWNNWTnFSdarRZpkRZxQM3/f
 z7rJbk11N3U7QLns+DP2+ob/XForTZtCL3DVhU0FWuGuzrIBA3hK/HAtjrxFhJSCsqN+
 8ATL0RiDn+QoQY6qYBbpA+59ktf4/QtRDpczUMZBtyXxPBV8bIeoPsJ10su+iLIdBWCx
 4eyLgNp1mA6lj8kJQnoL5mUhzjpMnWYass1yPTQXjvyYeW8I9PdHlcp7OwAx1wQ0rZqw
 GljyKsp1OpKa57lMgh6vOb203o9vaj0WiQG02EaHmGy5Ul2IWyoHxJzxQXkMsSmpEPzz
 k0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746565775; x=1747170575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sjbg7I52z0npdmEfxhkf0Fiw9IZ+X9uZHh3o80HirmQ=;
 b=ortMWitVNI2X0eQdWuSJ4AeDaG7D5y8VJ49Kqk2PBeSJbcoEcs4WHJDnyKmdOl6fdb
 AfANH8JrFO0Mj3m/lQjKX0Tn0ZNMp7fJ6FAZIYgsgCks5Gz+gNgNQ9d7oSfIVH2cGwgN
 Aex6wsmCm/76MpaO8l9JMv6HYUrRllVpmO3J7Q8aNX9+hLiVBpjjqWiPEvmpmN0c3sph
 LqXzb1U2FEC7LQwojx/j3Iu2ESwLEJMzobTG01eHozV2783x8v1zCRJAVQWyR9F4trn1
 sHE+kKBqWWOvZM9N0TsM9bGuBAI5pBh9jI0Iv7jawGDkBmAcY0p3qkvyHh655vkdkIyf
 iizw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkm9MWR47hRtcsyhwpBxV3HwByXWGFXvk2RLpdQmAEjizw7/ojEexmnGbHrah+5X113dyiEbmOWVED@nongnu.org
X-Gm-Message-State: AOJu0YyyQK+fJ0Rp/uUTaImYckZYmaX2Mm4lNZ6Ci9dNP/zyl5d6Hi2K
 u/K/W1IKnCcobEMa9Owjhtl+GvliKFurq3hQFuMGZU/x6IYYS4KifUlvkgsmWME=
X-Gm-Gg: ASbGncui3PGNRdqZUOXS4NoIJ5RYQRvujqiUvtLdNy8DU/7LTImBsVU5SGfm3NGwSR4
 rDWAh8Rq0KJyG4Ix7kmSMk51dZK8okHQYRocrXgzMnwtRL/e8zLdlDgguE37S7XtJQXI+2ymYxs
 E4uLF/azrfUakembN9fKhcZyS5GX70Jm3rvAjSE4wpfq7SbU3acjN63LJYpwzawyJI1swrZuSaU
 F31XV+6TQAgdz8sfu6I2kAMGEXNHeh5/DlMWlqNAex8WjSa+66BTOwgnUUXZXbUBT44kcl30ncp
 rURrQwmkP/wILj1KZWQp7hq24puhMmOQmbISnZqLO4HYnm+u5bK6Yg==
X-Google-Smtp-Source: AGHT+IGNfK4lq7ryE+uq/oIb5xMOaw+XLLq0VUp0krJV6G0nOxUdfB1o0Z3oy2B2P7Pyh7lhkxd+7g==
X-Received: by 2002:a17:902:e888:b0:224:1eaa:5de1 with SMTP id
 d9443c01a7336-22e5ea3afe6mr8654455ad.18.1746565775449; 
 Tue, 06 May 2025 14:09:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eb01dsm79039715ad.17.2025.05.06.14.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 14:09:34 -0700 (PDT)
Message-ID: <312fe25c-4331-4346-ae04-722e82b511e2@linaro.org>
Date: Tue, 6 May 2025 14:09:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/23] tests/function/aspeed: Add functional test for
 ast2700fc
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250505090635.778785-1-clg@redhat.com>
 <20250505090635.778785-23-clg@redhat.com>
 <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8wmqAtcgfPvyMY8nujTWNCSC0DYO64aA5up-sTWCr_jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 5/6/25 7:22 AM, Peter Maydell wrote:
> On Mon, 5 May 2025 at 10:12, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> From: Steven Lee <steven_lee@aspeedtech.com>
>>
>> Introduce a new test suite for ast2700fc machine.
>> Rename the original test_aarch64_aspeed.py to
>> test_aarch64_aspeed_ast2700.py.
>>
>> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
>> Change-Id: I3855f55c9f6e5cca1270c179445f549f8d81f36c
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Link: https://lore.kernel.org/qemu-devel/20250505030618.3612042-1-steven_lee@aspeedtech.com
>> [ clg: Added new tests in meson.build ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Hi; this new test seems to trigger an error in a clang-sanitizer
> build; would you mind having a look?
> 
>   Output: qemu-system-aarch64: warning: hub port hub0port0 has no peer
> qemu-system-aarch64: warning: hub 0 with no nics
> qemu-system-aarch64: warning: netdev hub0port0 has no peer
> qemu-system-aarch64: warning: nic ftgmac100.0 has no peer
> qemu-system-aarch64: warning: nic ftgmac100.1 has no peer
> qemu-system-aarch64: warning: nic ftgmac100.2 has no peer
> qemu-system-aarch64: warning: requested NIC (#net038, model
> unspecified) was not created (not supported by this machine?)
> ../../system/memory.c:2798:27: runtime error: null pointer passed as
> argument 2, which is declared to never be null
> /usr/include/stdlib.h:962:6: note: nonnull attribute specified here
>      #0 0x617e4121b113 in flatview_lookup
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/memory.c:2798:12
>      #1 0x617e4121b113 in memory_region_find_rcu
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/memory.c:2833:10
>      #2 0x617e4121a5a9 in memory_region_find
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/memory.c:2860:11
>      #3 0x617e411c21ea in rom_check_and_register_reset
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/core/loader.c:1317:19
>      #4 0x617e411d5ec7 in qdev_machine_creation_done
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../hw/core/machine.c:1756:9
>      #5 0x617e403d4877 in qemu_machine_creation_done
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.c:2782:5
>      #6 0x617e403d4877 in qmp_x_exit_preconfig
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.c:2810:10
>      #7 0x617e403d9a3c in qemu_init
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/vl.c:3844:9
>      #8 0x617e41301126 in main
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/main.c:71:5
>      #9 0x7faf8202a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>      #10 0x7faf8202a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>      #11 0x617e3f920654 in _start
> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-aarch64+0x161d654)
> (BuildId: f3f8c2ca821e695937a615bee293c4a5a336a6bd)
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../system/memory.c:2798:27
>

Ran into this as well.
It would be nice to run sanitizers build in the upstream CI, so it's 
fixed before hitting master...

> 
> thanks
> -- PMM
> 


