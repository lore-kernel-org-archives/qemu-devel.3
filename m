Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA9E64ABB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIV1T-0007pf-PA; Tue, 03 Dec 2024 10:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV1S-0007pW-Q0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:41:10 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV1R-0001Lv-6g
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:41:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a45f05feso70221645e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733240467; x=1733845267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bDSUW474SdnuQtMJmEqC/3X7zs3mhxM+2xIzR0qbT6M=;
 b=qGriy1wYv9DOXTq6QADmubLu1No/tEZJrWlVTQGSJY9VGMbJ7MVRxKGxapzr1PPs0y
 JimSaaOM4xvAsQZd/80qgqEyndLS3F62hioNYFAa4IzKex7zv756JgCqBOwgunPc72mp
 RYFl+y0rNLtav4gR0gdtNG8KAgLHI1+2tocWWJ3tIMrAb1EIXy1yh2xj22vIHaYKl+H1
 aMWrMTT79Ip/fciG+JBe+7jrE5G70Ib64Z38MOrRJ7LG94gUWzTLOMqEmmbn4B2uCiOQ
 VhUEtTLOz+CYYvjWTp03Z2XJ/OxfudjFNcfxt7q/y9n28m8wjSNlwujRgPTtnt+xYuCl
 6pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733240467; x=1733845267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDSUW474SdnuQtMJmEqC/3X7zs3mhxM+2xIzR0qbT6M=;
 b=MrL6vQLhLcHHg21JJqimW6nTg/NLAEa+AoXZKX4ctry+f7yfCvgJ1SYkBaIuuX1t1N
 XgMev7lsVQ7iU3SuhNKYCswKXv6/g5Z8Gg74R+AyReLfh87Shtkg9sOd9xLFObkhzjYz
 Sl40z4HPhNsFCSq8qKOqLKCeDY10yowCUmqP3Lf/YjaS2KC8PiU6vRB4Bd0jQYVy2a9P
 sscqsSnwoKnZHKLqHaWVLyRfrATt9vzK8eBwriCdT/R6gnln0fRFyPVo1L38uO4Rpptf
 H6np/pVMapkmZg2VvojMZhc2SgAK3iJqSVc8Dr0495eP/+i12XTbc2C+Ce9tZxwLAG4T
 csIA==
X-Gm-Message-State: AOJu0YzOz37Q7jEH/geHzMRbWSuHzQMmIqorS+YDXTCnB5T1CE9MBC0w
 tFJi7bLfHuq9NYIbGkcgECQbx5E17RRm4M9JtSx8nV2kzW1965Kcxw9YsTLlfRlVJoD5mb6s3iK
 6ttw=
X-Gm-Gg: ASbGncsnO/8VPl3GkkVvsAjve7YWDF64NDj97HEQxJyCBEAUr6yFWXXzZJpEYK0XqiS
 xKvob1FW8uJ208ksSLkoVKyYCEI79s9hA0/Fh/3zi9za5QoF8FgT8v9hsqwtkbSFvI+vPm3bAj/
 gIescnOQmKCLPE3cYv2DykO6X0+y8KOcAsxmZ5SHPzITrTZzKTK4fjutmUTRbRBX/+qBwLP/gRC
 tgrb7Faxb0aHun5EljmGc+8THyDs+lenK9YyvM9iaIJaZJ/E7eC1mP2tWYPJt9yOQ==
X-Google-Smtp-Source: AGHT+IFiuesmIZDclYq9mK2l9fTnmEXONmwpwprDRAFvJmhhfk2AQhn3GyOmlKj2KFA6h1/Ola4sWg==
X-Received: by 2002:a05:600c:4f8f:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-434d0a23f90mr27541745e9.27.1733240467181; 
 Tue, 03 Dec 2024 07:41:07 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f7dccasm192640975e9.43.2024.12.03.07.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:41:06 -0800 (PST)
Message-ID: <677503ca-017e-45c9-b278-cbd6bc765f5b@linaro.org>
Date: Tue, 3 Dec 2024 16:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Add missing SDL dependency to system/main.c
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20241120114943.85080-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120114943.85080-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 20/11/24 12:49, Philippe Mathieu-Daudé wrote:
> When building QEMU configure with --disable-gtk --disable-cocoa
> on macOS we get:
> 
>    ../system/main.c:30:10: fatal error: 'SDL.h' file not found
>       30 | #include <SDL.h>
>          |          ^~~~~~~
>    1 error generated.
> 
> Fix by adding the SDL dependency to main.c it's CFLAGS contains
> the SDL include directory.
> 
> Fixes: 64ed6f92ff ("meson: link emulators without Makefile.target")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Looking at commit 88c39c8693 ("Simplify softmmu/main.c") I wonder
> if this header is still required.
> ---
>   meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued.

