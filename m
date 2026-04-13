Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7767E9381A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8mq-0007oc-Eq; Mon, 13 Apr 2026 00:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8mp-0007oR-9D
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:20:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8mn-0006Lr-LO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:20:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82f2385724aso960844b3a.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776054032; x=1776658832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jot5pHSNVJ8fOgl3QWe0Lp4bvZr4fMZF9j1OHgOFWtE=;
 b=cIjrwiuHKWTCa25hPxmaF9Ub4MIYz/aGEddFDXEU1lHjkQPvujq3scntSPjYCmeEfF
 VCbinoTgkd29jKSIJRaascHFKgx7/8Z2TiRX7VsghI/gDRzuy1oepxY7N37GvGDlKWWs
 /PEabyXn+ZCNDIkeZKDdd6asIShNMMbeUBoYKzSkq7h4QwTPKZxbr17IGqpz+0LgNBzz
 17A5Iftfb01kiTTAr4nRIucH1fZVfL3mHMHEDu0HUKhowdhe+jNiozv05Js/MWPz0MBT
 OqaNXu8LHKDHid7MyvaQ39sMexCKOc2CWVAFKZYDPe4IGntohc2P2abv+WfBNXUvLxgG
 qcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776054032; x=1776658832;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jot5pHSNVJ8fOgl3QWe0Lp4bvZr4fMZF9j1OHgOFWtE=;
 b=dwcBVKszjO3N8fWZk4zDU0dfkLJCu+8h2igevTjcqmB1iP5UpLqSacwOFYg4cLhtg/
 1L1fdArU2kGnOwb5tKA7bP9DTe5JQYMyw3WoFex1b+qCB5ceTIA2RJpozFRd+z3NtBVZ
 SLT3kCOq7MgojqVetFCtyJzg1feEhbrr6e/ty3NFo2wp+wu40dXYiPbdRa+f/yLnTvck
 Rd30oKzC2CmoYu/nby3/PCUjMeRYiH9AMSS2WaUqgoxCs13XgY8zKiiEjaKPfiAoYFBy
 A2hXX5VS8tuWNXzeWc7W5GnXMJ/6LZpwuyUCLoUAnY/biBj9q6ggs/2Mwxgjr6tsq3sT
 K9bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sVnrvjVDNZoaVWJYyzhIMpEp/KFIXwmB1Q+Y5cZVXjGe/p0J4JTip+jXwIjIMC38PmINZLCNHeguX@nongnu.org
X-Gm-Message-State: AOJu0YypcwBhmVqAm9jHK6pk1gnRP14/dTO0FLMmeTsf0APtqE/byTp+
 8WWRyV78OUaaqgzKIUpuRU2uafRbZmZcuo/e72Nb5Uyf53jZoI8nFJKOHXumsLG/bhqIHykZMz2
 xRpPtUYg=
X-Gm-Gg: AeBDiesJOoM+qXrAa4CVvSZxiISqKQjIVwjggsrVQ/H3T3RKVpP34oW4Qb/6JreWIHB
 HYbLaEo4l9c+qWdT4JUcDLzcAzjOb1SlW5EEXu+OgOo0+x2DSdqOCxIxHKoU2i4fxxyR0NpIMDq
 6NU+tN+7PF+cpaAqYo3KOrm2y+ZOxSZfhYO9d5Otv7ssHLMSqV1MC4K4qd/cp3XHIt3ibknL6t5
 4vFzY98ezu/bC6Twd8M3JLzJxrZBLlna3X5yFCBmkfz4mVbAEStoSW4hSsGSNF5HQnRl5DZBBdw
 F6MiWxST+mLpUNxHZqHV50vI58tA0qYyNdZBCSbnhfy3/4gLma9802Ni0MIJWWMifHWGELoK4vl
 +KkaLI0wSpYhC29i5s918cnqcb2EDBx3g85xkdXneSUv2EQC86Cv0j8tjQPL8x/B77QakFuEl7g
 CQekKaZfoWIeHpIuTozw+rX1U6Eskgfa2B0Sq0Jb9QTp/63//X53WI5KLvWecr9Lb7FquYi4a6B
 AUeWCiZ8Bhl8JezgDewX2ZmrXsgso3n8GjUqvVdHwDcuedSQRFcjNc=
X-Received: by 2002:a05:6a00:3e10:b0:7f1:4:66b with SMTP id
 d2e1a72fcca58-82f0c2cca1amr11924141b3a.44.1776054032088; 
 Sun, 12 Apr 2026 21:20:32 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c3145acsm10850343b3a.6.2026.04.12.21.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:20:31 -0700 (PDT)
Message-ID: <42f94999-1d77-48c1-bf17-40e81b8d24e6@linaro.org>
Date: Mon, 13 Apr 2026 14:20:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/27] monitor: Make 'info via' a generic command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> In order to build hmp-commands-info.hx once we need to stop
> using device target-specific check. Use the generic pattern
> to make the command available on all targets, providing a
> stub with kind error message when the device is not available.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS            |  2 +-
>   hw/misc/mos6522-stub.c | 16 ++++++++++++++++
>   hmp-commands-info.hx   |  2 --
>   hw/misc/meson.build    |  1 +
>   4 files changed, 18 insertions(+), 3 deletions(-)
>   create mode 100644 hw/misc/mos6522-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

