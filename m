Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95778C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 14:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Q1K-0006DU-79; Thu, 17 Apr 2025 10:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Q14-00068b-U6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 10:15:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Q0z-0000Ax-7m
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 10:14:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c2688619bso552638f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744899291; x=1745504091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yvmyiNTk0u5oNuIpgtas10xXjsPizBsh4ZZXoVLw+xc=;
 b=YcSCnB7e9y6O3fgtLZ0XQebtwKuF+xokDsOi3PvXNTPC4AkgVUm/0Tyl6oDymziaYd
 O7X/FsQyDR1AvOisQyW+aOk+3YHsNp5LJ4Y+muOA+BVoEvyqnXuIiHRQPMqv/dy8gUwE
 bbntSNX/AXwzDb0QL3eaKlJ0r0qT7be/ouN9sO0WZpERW7n9HC6lg8QbTiWBpIgYfe7T
 /BltA5IbXsH6C8IuxxA083NphQD4KzqRx6k2nAt99D5VMi/p/EcZsg+m3u32II0DTb1N
 90flR0Tgm759oZYQTXAq3EReCqR4kg1amqf6gHM2WL6l+lInxF84+a5s68qNI1PEZPER
 ffng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744899291; x=1745504091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yvmyiNTk0u5oNuIpgtas10xXjsPizBsh4ZZXoVLw+xc=;
 b=vNRTZ89KW2cAzI39dSGfXYFgNJIqNCbH7ch/2HaI0IWljjuLfFTsRdKM+qTT7wy0iw
 /0/V5d4ZCVcFNj8BwnGPSvGKsFp9Xw6jjoiD9uU1dtcUtKvEJ6JSe7KCcV2BY2/NqU3K
 O7+6q8x7fL0rC3RvzA7o/rC8uZmsvV/A8Z237RkRChAaJaWMBGKTaF/Jo70dEAxtUaFo
 fWnN+bYeSosHzTkq9zjfksNQZGr+lnJ017WATTY/lxdqs2RMiiPzmKLOG0c6FAOpegrh
 A6M/UgKIZR/H3k1MUSK1IWMbikcB6/LxsLwzMt4lf30Rxv73BxlRbidX+S0gSsh32deV
 BTJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJDRZMeLM02NNl55uWuQJ6ghJtFRSAt9iGBFQU15z0B0Vop9+aVpfhKHOLYtPe40DZFyvaE6PUpkZV@nongnu.org
X-Gm-Message-State: AOJu0Yw+r58z+cjl5DWW/tHrMbnQc5jcuEP4wT8R6d3VoTHB5gWrXJCX
 D0KWPm9trTJwelYU1m1CF1Ng7lIgWvYaHUYsQ16NoczxzTwNjCwbrL0/iTFlx44=
X-Gm-Gg: ASbGncs9IMINr7C3rZdNHxEgADQfaajid+eUHOmsd0PgtaUPf7twHYkNVcMw/JMdiLn
 ELliLt/MDxc7iUzxe8RH7XG/I0gbh5shOUlIkvWgSDLMgI3wkG+MO0Id724+B4xNLjEHDVuRO5W
 xbNxRC/OWejnCd+vQet+V0gsXOXsvvpiSJ6JwisPc5+uySoqvbTIxrsgZ96jWGKnD1grqmtrg33
 g3KeOoKO56czZ21N4WCYSZHzFf/SohvaY4repskLw0T3fUUDtoj9yl/7lAnFwvpip9iSYrAyKz2
 +BwTCUtA44aPxqunHOZlvMwxmc2w/v+UB1gfqIBO79JxrgLeyNYyig024pAC2mGjN4SuCPOymvP
 NLCM5JHXYrMn9d9PjTLw=
X-Google-Smtp-Source: AGHT+IEQhdqHMztoPb4BKBCf45aJ1jSou1PwZmArvBGyPRRvF1o+l0C362oIWisk6/QDISbYbIp/nw==
X-Received: by 2002:a05:6000:2203:b0:39c:30d8:3290 with SMTP id
 ffacd0b85a97d-39ee5b13096mr5182061f8f.7.1744899291293; 
 Thu, 17 Apr 2025 07:14:51 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4d105bsm54931595e9.11.2025.04.17.07.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 07:14:50 -0700 (PDT)
Message-ID: <a99dbff0-99c1-48b3-ba8e-341d5bd4d6e1@linaro.org>
Date: Thu, 17 Apr 2025 16:14:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] QEMU 10.0.0-rc4 is now available
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <174489857530.3753920.12348493900787935207@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <174489857530.3753920.12348493900787935207@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi,

On 17/4/25 16:02, Michael Roth wrote:
> Hello,
> 
> On behalf of the QEMU Team, I'd like to announce the availability of the
> fifth release candidate for the QEMU 10.0 release. This release is meant
> for testing purposes and should not be used in a production environment.

As Stefan mentioned on IRC, there are no open issues for 10.0.
So except if critical blockers are found over the next few days,
this is the last RC before the final release.

Regards,

Phil.

> 
>    http://download.qemu.org/qemu-10.0.0-rc4.tar.xz
>    http://download.qemu.org/qemu-10.0.0-rc4.tar.xz.sig
> 
> You can help improve the quality of the QEMU 10.0 release by testing this
> release and reporting bugs using our GitLab issue tracker:
> 
>    https://gitlab.com/qemu-project/qemu/-/milestones/15
> 
> The release plan, as well a documented known issues for release
> candidates, are available at:
> 
>    http://wiki.qemu.org/Planning/10.0
> 
> Please add entries to the ChangeLog for the 10.0 release below:
> 
>    http://wiki.qemu.org/ChangeLog/10.0
> 
> Thank you to everyone involved!
> 
> Changes since rc3:
> 
> a9cd5bc639: Update version for v10.0.0-rc4 release (Stefan Hajnoczi)
> e28fbd1c52: Revert "virtio-net: Copy received header to buffer" (Antoine Damhet)
> 8bdd3a0308: tests/functional/test_aarch64_replay: reenable on macos (Pierrick Bouvier)
> fa3f3a33f3: system/main: transfer replay mutex ownership from main thread to main loop thread (Pierrick Bouvier)
> f3ca7ca222: docs: Document removal of 64-bit on 32-bit emulation (Richard Henderson)
> b0b5af62ef: Fix objdump output parser in "nsis.py" (Arthur Sengileyev)
> 22e6d70294: docs: Fix some typos (found by codespell and typos) (Stefan Weil via)
> d832ff9d02: tests/tcg/plugins: add plugin to test reset and uninstall (Pierrick Bouvier)
> c07cd110a1: plugins/loader: fix deadlock when resetting/uninstalling a plugin (Pierrick Bouvier)
> 9edb9c2a6a: tests/tcg: fix semihosting SYS_EXIT for aarch64 in boot.S (Alex Bennée)
> 


