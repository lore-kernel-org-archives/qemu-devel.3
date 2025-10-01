Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADD7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3z9u-00009I-O9; Wed, 01 Oct 2025 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z9r-00008K-Oc
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:54:23 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z9k-0001AZ-5n
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:54:23 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-87745ca6cc5so6549186d6.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759334048; x=1759938848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vS06A3mryPYlC/9qJ/hEQBvU10vdqEysXsy7VNacxmw=;
 b=KhWiu+lqo9upLIkBgE/UkT62gVO1r7Y0qMAFnQepyhun5ieZ/TcmLF8qN9U86WVEnn
 H4PEspNq0UHTl06E629jHdAs1x6vn06t06cFAJqGdDA1wTfzpOSHfSULNTy1NU8/o1sH
 MunhXZcEg9Wmhch2cdgyi2beOjsBWC0Xnup+lvzTYb/t13K5V4jWUTkRZdp2VRsDEMQT
 zh0sBaZEO5eqjD0Tg/aSIiEGFw44LyHf8ws4kipZZT16J7vmz5b6o6CM20mW8wNfubXU
 kCuAmny4TWM3+tK0NSSW8svSv5IUz+umVIUaWQWOxyk3cYsoqjGPA8KHEKpita7yoaBK
 2rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759334048; x=1759938848;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vS06A3mryPYlC/9qJ/hEQBvU10vdqEysXsy7VNacxmw=;
 b=rJeiMuwMd/uz9UsFbE7/5UT25ln5mmFhIS4/JZxGPifkwUxR5326q82lNlJVjrR6nl
 LPtZ27GlQ5a8nkjAVX/I5uS3pZbs3xYlS41vHiojPZmz1+UbfBAobJ6bO9Ob33lcrbnK
 RvZBFM0zbdUfydt3qPTJXCtJ3JLZQTifdT+n9mknQ6fmUkX1rrwZOrULMGuIryxToDy7
 Y8Ckq0Pf9UPGC4L4ynloj9LjX9P927aV80khBDXFX8+0ZUUjkw6rmmdaFPSKuDd0pJBI
 O4XCsToE+WsddoVIdoX3KRcuHz6GA6lo0XwRCP4BU5wumjlM4feMQYmV8o0JWlOm2z07
 F5sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM7veo45SFOmvJDD0nLdrOw/0SeICHgJRv8me/gureJcdCF/qbaciiK4Umi8IG7VNu/sVz7LvuXdUK@nongnu.org
X-Gm-Message-State: AOJu0YzXrhVXGswtLtvwa1bin0kFdfjB/el6vlgYo9DNpzeuvSs8l0Cl
 FXhfuIa1eD41PzAFBYVh8fLRkfC4nRu0DHTzduo6PsYFQ+Q0SodEUIDv5ErykW+oL+s=
X-Gm-Gg: ASbGncutQ1jCnlN72XrGmDuBQWZWYazCvbdTyplwOWL+npL13kylbw423eP+5aLswx2
 g9cIaROXYO0Se0z3OI2alxi0sy6pirdd0dSmfHCve41gSOl/0HWlxZb713q1MZndfwGx4NVEf4I
 eytt1iG1G78a+oRypwH0HGOTeUzyrXjgroodveeOWJc3h6cct96xQ6VRTJKAIx+VYheISbw/BPV
 bZIEjZJcO4bMaWYCG0T/62KbtJOSVPgnvFlGxCJpyGSpb8XUW/ZsSJpTVU9rUVJI2gghn2g5bye
 gWRAwGsXp2wsr3Ayw8uSovM/MXVOO67FjSBllZBf0gpVOUygw7aiSNvLVG49VIpN1QqQ/MrDlHi
 6wbM34l3YO0Ofq1uJV1mbwp1GYeZkAWtR36EZ93X5e7DhBrv8lOdIme/SMvrT0Ultx6pVDzu7EG
 HOq+0SE18Kdj2hDyJ7V3PJVbIqz/Hu3JSNMPu/mHUORw==
X-Google-Smtp-Source: AGHT+IGH82h5nduSGDij4dnfcOyHyYQsMXDA6b3dVQcyGC6gBhIoV0k0E+Dm4PRqhvpcS+z6C3PuCw==
X-Received: by 2002:ad4:5bc9:0:b0:77c:7fbc:281d with SMTP id
 6a1803df08f44-878ba0a67admr1130286d6.10.1759334048163; 
 Wed, 01 Oct 2025 08:54:08 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878be61f6bcsm129946d6.65.2025.10.01.08.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:54:07 -0700 (PDT)
Message-ID: <4ce02bb4-3db2-44c2-8aea-de6905119a79@linaro.org>
Date: Wed, 1 Oct 2025 08:54:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] system/physmem: Drop 'cpu_' prefix in Physical
 Memory API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-25-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> The functions related to the Physical Memory API declared
> in "system/ram_addr.h" do not operate on vCPU. Remove the
> 'cpu_' prefix.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/ram_addr.h   | 24 +++++++++----------
>   accel/kvm/kvm-all.c         |  2 +-
>   accel/tcg/cputlb.c          | 12 +++++-----
>   hw/vfio/container-legacy.c  |  8 +++----
>   hw/vfio/container.c         |  4 ++--
>   migration/ram.c             |  4 ++--
>   system/memory.c             |  8 +++----
>   system/physmem.c            | 48 ++++++++++++++++++-------------------
>   target/arm/tcg/mte_helper.c |  2 +-
>   system/memory_ldst.c.inc    |  2 +-
>   tests/tsan/ignore.tsan      |  4 ++--
>   11 files changed, 59 insertions(+), 59 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

