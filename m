Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4886BC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 10:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbHfO-0000oy-Jl; Tue, 06 Aug 2024 06:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbHfD-0000nL-Pc
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 06:43:35 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbHfB-0004LU-KJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 06:43:35 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39b41306b4dso1516105ab.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722941012; x=1723545812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+hxvagFG/QQ3eePI3jVspjOcoUZGns+kscxxcnLkaVs=;
 b=GQH4t+qDO67nmFsziU+F2iZeeq+VOWM9im2IbraC/U2d4b96+btIC+zbRrBBm04med
 P90DCUA7Aj1UoK71bP7XjaLjcWheMYTlmyOy4un3wMS76amADC3VN0pK71kXWV/cVunW
 QmQg77iTRk/pj+kzLV6xxBI3Q/6ljRZvActoztsRyeKWTQHWNn7bxl4VuyLG6KQSS9Xu
 oTqEL/H7S73e0biuIqtMw45f2POamHFjxKYbLbMZjpQPobuaDi9q69tJ5E0nqQvVjoK9
 UXyTdVr3PBig8nr49SHH+oxicBgGtbu7tR+gUmN7oYU7N04QNutKVnnCttPIMEvmlVOz
 ZZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722941012; x=1723545812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+hxvagFG/QQ3eePI3jVspjOcoUZGns+kscxxcnLkaVs=;
 b=jPulIzw8KSYcD160mGGOTqk7yBb0max0IaSzN8IYygwj28T49lP88j+eBw9f29meFE
 Ay2ZYS+fHTBJPRTtcuf1MsGFYYRQM53wZrs4w8nr6t8hl6u8GizlZBdq0O7XA0fOrbAx
 5htZRzHtlwCovxRPbI4ZLofq3HaqAHlE3chI+hk3jt6AeXhQbTdInzWrPRr1VEBqCgDt
 UvJNATAp3bLofZ1yYuFvvKHkmYrTs71YBMZr2WeqnTzSQPiJc9OXZ9nGDu2JbeZtbPil
 +QordbUZJEUlQ6S/nYOcDKKmzlYz5+sHP5wawPuqPfiL6E+a98UO1byUEgCecYqxvQ+O
 8C+A==
X-Gm-Message-State: AOJu0YydZXlCPpj1CaxZXOpIiQHWLUITpmkEPW8I9kyezvC5q4DhSD1w
 LjMOP3tGaECjYufPBcevDSd2J6Qk1UgqCC01h2UD9UaWBfhTJpU7KvPYosp7fi8=
X-Google-Smtp-Source: AGHT+IHua8qWIEeUNzUo/EM4D6eEEcZfVDLHyPyss9GQt8nfrZW9K4BDyLewv8vCJxaibgYKTyj5Yw==
X-Received: by 2002:a05:6e02:1d81:b0:37a:7662:7591 with SMTP id
 e9e14a558f8ab-39b1fb6c01emr205879595ab.6.1722941011867; 
 Tue, 06 Aug 2024 03:43:31 -0700 (PDT)
Received: from [192.168.20.227] ([172.58.160.246])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6987e98sm2175560173.29.2024.08.06.03.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 03:43:31 -0700 (PDT)
Message-ID: <c71e380d-883c-4f30-9629-1baad4641363@linaro.org>
Date: Tue, 6 Aug 2024 20:43:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/13] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240806080217.14941-1-kwolf@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806080217.14941-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/6/24 18:02, Kevin Wolf wrote:
> The following changes since commit e7207a9971dd41618b407030902b0b2256deb664:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-06 08:02:34 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 91f16b6cdccd2942ae09d155cf3f79e6bbb485d5:
> 
>    iotests/024: exclude 'backing file format' field from the output (2024-08-06 09:54:24 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - scsi-block: Fix error handling with r/werror=stop
> - Depend on newer clang for TSA, make WITH_GRAPH_RDLOCK_GUARD() fully
>    checked, fix block-copy to add missing lock
> - vvfat: Fix write bugs for large files and add iotests
> - Clean up blockdev-snapshot-internal-sync doc
> - Fix iotests 024 for qed


Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7515110500

fat16.py:308:44: E1131: unsupported operand type(s) for | (unsupported-binary-operation)
fat16.py:392:23: E1131: unsupported operand type(s) for | (unsupported-binary-operation)
fat16.py:466:42: E1131: unsupported operand type(s) for | (unsupported-binary-operation)
fat16.py:500:31: E1131: unsupported operand type(s) for | (unsupported-binary-operation)
fat16.py:500:60: E1131: unsupported operand type(s) for | (unsupported-binary-operation)


>   qapi/block-core.json               |   7 +-
>   include/block/graph-lock.h         |  21 +-
>   block/block-copy.c                 |   4 +-
>   block/vvfat.c                      |  27 +-
>   hw/scsi/scsi-disk.c                |  73 ++--
>   tests/qemu-iotests/fat16.py        | 690 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/testenv.py      |   2 +-
>   meson.build                        |  14 +-
>   tests/qemu-iotests/024             |   2 +-
>   tests/qemu-iotests/024.out         |   1 -
>   tests/qemu-iotests/check           |   2 +-
>   tests/qemu-iotests/tests/vvfat     | 485 ++++++++++++++++++++++++++
>   tests/qemu-iotests/tests/vvfat.out |   5 +
>   13 files changed, 1280 insertions(+), 53 deletions(-)
>   create mode 100644 tests/qemu-iotests/fat16.py
>   create mode 100755 tests/qemu-iotests/tests/vvfat
>   create mode 100755 tests/qemu-iotests/tests/vvfat.out


r~

