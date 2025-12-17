Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C87D65C5B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVssU-0004kG-JU; Wed, 17 Dec 2025 09:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVssH-0004ir-UV
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:51:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVssB-00029a-Cw
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:51:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so4768357f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765983085; x=1766587885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fLgKokTmSpzcrNUtqGn7U5acj1VJSR7TA93sJ3Xo1H4=;
 b=slRUwBIj5VZF/+vTgnSBJ4Sr23NVJrSQC5AtyNcqxPvs1LvUiL2u39CwBwFfadYka8
 013QVZVTReGw1XXhPPt7m/32euOzgVhM0D2xKz1PYWK/5013qOxm2+winLe6BMi0hPrC
 H7W4M1bnelb7MyS9UE0cs6rMe4IBRfvHaJKmSpGr8vJbsZoOOvEDO6M/JweRpgyMNjdU
 6IyPrEWJRxwIV8dy3rflmPWqQemtlYx6/WiggcUb/eKPGckVYCAwo47TzM/1dCuLKqq7
 68tLPUr+aMvxPWY3lswUhUy/8UmaOrd5c1zNenHMDqH7dgJhZ1ChJEpYqRSXf6ognxV8
 M93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765983085; x=1766587885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLgKokTmSpzcrNUtqGn7U5acj1VJSR7TA93sJ3Xo1H4=;
 b=GyiU7lEAf3EGkdTRmkjK/LonHuRAa406fSn/lagMy2LlUw/Xz/0tAirHBEF6BGRSdO
 kAFUi7mkYCCPCxRbRQ6NNrHqTWFAz3TXF8ZySwTmdD6vp95D3GX9aG5snujv3lSb1LW0
 E77eZHXjbTuobxEI3uQFg3y4cBayvVE9yjmJ4xrU5PYwjzRbVkc83sLDcy0bHkHLzVWE
 uyXsfvg6yyUbwEvuqeAYgtBKBWa1keelszqLnWWP+KP2Y90bw+SdBEJjQGKPJqdgV9yL
 r/TRG1pcAb5LjQZ0cczmqcCW6EX7mkKLUwTTRCAlKDmRDwcYeLmZEhiG/GG0w4o4FlxT
 u7TQ==
X-Gm-Message-State: AOJu0YztXOeGvi14ey2fCV2VKok9KPLXon0StwTxr4BGMGRKwf6Gubh8
 +zxHoxiJQaRCCaT7ULIp+4YFl5+tFF0D3WejVqN9muFndQF1PAATQWn5LBA7PEJh4+k=
X-Gm-Gg: AY/fxX7RDaWHxlJw83HwjncPHLOhALw5qRt+lWBvwRfhG5oyde0RNL/hd+cGMNFEBS0
 bQ1SM8a2DmxTOQL4ZxWc3dTU9MRBsUQw1zX1YamLTmMGF7YMCBkwO9WTAAVbwx6yf/X9BuK4pl6
 /+EZyKdWxjkblpkDkQbuXgcQ2C+1pO6RwGBpPlWnGnaY4RfPFMpcYg4ztFlxYCEzmQidSQU1yxS
 CKalX/226JFxIlgnAPrqOrHBs0edzcE1OcbyaHi3vUHDCCLXwbFEakpqNv8xYHs10ZimE+oUv6E
 tJl+UYoDoKgz+rcJN+JxFuyLvtZM0DJXdEFayfss/5SNHZvHYzBQrPBv9T6/U6AomQiYyoEl1pm
 Q0gIwig3TdCH3Z+nfwvAoRPOuqSci1MKDExgQR+qbKd6Y6e0j+AhZLHTM3hpjGOnK16H8xVmzHK
 H6sY52FpTb8YVSFgN1f3Q4hNwQeBGvBf6tDsdUM9Zg2NCUUlZ/6WHZXQ==
X-Google-Smtp-Source: AGHT+IFR2QdtAHvIJehWGd+nicUnJjb31SBr2w1ksKNHRBIz4mNxUbbL1WCoDDaZeJIVhZMpTQhXRg==
X-Received: by 2002:a5d:5f54:0:b0:42b:2ee0:569f with SMTP id
 ffacd0b85a97d-42fb48ffb94mr19400992f8f.33.1765983085073; 
 Wed, 17 Dec 2025 06:51:25 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade81absm5080097f8f.21.2025.12.17.06.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 06:51:24 -0800 (PST)
Message-ID: <baad71ea-20ce-45d1-a51a-b74a7f6f49d9@linaro.org>
Date: Wed, 17 Dec 2025 15:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Un-inline the s390_do_cpu_*() functions
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20251217144238.37610-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217144238.37610-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/12/25 15:42, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These functions are only called via their function pointer by using
> the run_on_cpu() function, so it does not make sense to declare these
> as "inline" functions. Move the functions from cpu.h to either cpu.c
> (when they are still used in multiple places), or to s390-virtio-ccw.c
> (when they are only called from that file).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/cpu.h         | 24 +-----------------------
>   hw/s390x/s390-virtio-ccw.c | 19 ++++++++++++++++++-
>   target/s390x/cpu.c         |  5 +++++
>   3 files changed, 24 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


