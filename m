Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33C5E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2NY-00052O-Gc; Mon, 16 Feb 2026 12:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs2NW-00051F-1T
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:27:22 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs2NU-0002Fo-Mz
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:27:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4362d4050c1so3950431f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 09:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771262839; x=1771867639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3rcyPrs+aV9M5Xoa68if9h3UwuyV+iTY5WKkC8mTYRs=;
 b=G1dUQbbyYxmKMll7piZk8HeR8v+plVng038rU87wwpN73Ukb4OWSyhtrLuACbG8X3J
 IFgcroTWVpWF7REjjqomJZarpvnpXZguNmj0A3RS40dpG8ceQFROPtSuhkvIgpAa+iOu
 v+TgKsuwBictPwL3CL5Cd8gQe9sNwjCOCgvP7tf1nm1lkwRWoEDB1vOtHvsiKuzhejQk
 O2tw0T4uk8F6dAUjT4NhZYy5zlpwLbObnIm+QngyBgzBKRXgtwjfbW1yIKIAmA3H2G5M
 wS0/dudfo/oJV9iVy7inQJ6N+foyTk/CcFbk9uspWoGEA8KgT/6Wg2AKEr/jCEbgmmzB
 wmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262839; x=1771867639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3rcyPrs+aV9M5Xoa68if9h3UwuyV+iTY5WKkC8mTYRs=;
 b=K6vC2zh9SGGyvi2ABw2tPFdKedDlUm6lSLTw4fypzZztpE0ZJfpyqLQAd4+gHb9LDu
 meNCb0prQkiJjUApYLl6p3VxIIlI4kjJlu3Ec6ujlBrBmfg7ZY1g4hrfZhNJr7kTR1uw
 FFOFloL5MBy+Oy2Yud7Z0r7PNXZbX+FCSHU6S5JFC8MxiTRzKiyFN/otXwF93sAuYAaj
 tKuYGWO0660/+eSA3k3UQkrvhVBgDou9D4eh6PwG+Yuox6Drp3veRBkvkKL1u1Q0juU1
 VaJpWpHz2A72ceuwXsihdrqTQT+zg8IEq43kK+p1kz7/v5Y86yqjw2gy/d6/X9piUSnx
 eRZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsNjQRY6nVmOTzIy8zaPSwC4YLlz8eJ2YeUTqH53CzTxhAFZFv5EMaRZ9Jt+SjCqgpkDAsxddltJTe@nongnu.org
X-Gm-Message-State: AOJu0YzTOpP9ddX5nkUk+4CjmrHBna0e0i5WEtMxK6kLkuhvoQE7G6SC
 PrchqJD2d8D1XHtum70WIKbPTkv+M46lEDJ7fyTscceRQ1nGKVRP3qnoDhZzsmMIzOo=
X-Gm-Gg: AZuq6aJJ0FO3eRhcIaVZH2V7NpwvEYx3wzR/Kl43R96HVsQ2wdZHa735e1rkfKP0eek
 rQbPd7wAPitz4txjUnl/RnuFnxgsoC2irdmPlMCm8wD6TX6WYkJGhoaDZax/10FJsDz71slyHHR
 r0A78dqHJ1y9rkRHcgV9g6o2aWTCjo3C+d3UpKRpZi2z8FV6WIeqi8Z9IRweWkfe+UnHqPxKciq
 QxNoU69QZLmN8N6sLOioL9CbIwpuUY9+QFqbdiYHrK1Tr5NV4HSKiMRPWmlZ7M5rn8BP1X9AE+q
 E0xfKrXsxByAzuTuA67+kZmdrIazO5dRiImsdU3wAyHwZRCUQ5seIFHsIbeBsJiq6Kl8Ip7A8li
 5/ea01rGUOntt1Ww3OZCg3XlAfh9D3RSzqDc3y46u4N/8PhZb65lBokBi75kAg/M5GnwZJ71Zb2
 GOED8Rt3DwdfVOuC+oYdtDMXVHIq1sbLGcVeIkltlCQg/+7U72fy3bf/Sz8h2LcuXjaw==
X-Received: by 2002:a05:6000:2c10:b0:436:3267:3ed8 with SMTP id
 ffacd0b85a97d-437978dc524mr22410284f8f.24.1771262838705; 
 Mon, 16 Feb 2026 09:27:18 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6ba57sm22954330f8f.15.2026.02.16.09.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 09:27:17 -0800 (PST)
Message-ID: <0a13bd58-b078-4e1d-a4d3-c199bac1e2b0@linaro.org>
Date: Mon, 16 Feb 2026 18:27:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] whpx: common, i386, arm: rework state levels
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20260215052225.22513-1-mohamed@unpredictable.fr>
 <20260215052225.22513-14-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260215052225.22513-14-mohamed@unpredictable.fr>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/2/26 06:22, Mohamed Mediouni wrote:
> Change state levels from a set of ifdefs to an enum.
> Make register state loads use state levels too.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c        |  8 ++++----
>   include/system/whpx-accel-ops.h | 16 ++++++++++------
>   include/system/whpx-all.h       |  6 ++++--
>   target/arm/whpx/whpx-all.c      |  8 ++++----
>   target/i386/whpx/whpx-all.c     | 16 ++++++++--------
>   5 files changed, 30 insertions(+), 24 deletions(-)

Thank you :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

