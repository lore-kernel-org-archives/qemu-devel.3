Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DC7C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYmj-0007jw-LP; Tue, 15 Jul 2025 02:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYmK-0007Ul-W8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:04:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYmI-000272-T1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:04:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso13810475e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752559472; x=1753164272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sD8tY4mt9o0gdV5erEmCvkaH7CaaQsXsKHANtQENlR8=;
 b=gvVbAwVExccLb+6E1varlcYvOBJbkTNxiRFsLtGTZ240uPM027JAt9rIlU3gc72jDz
 TUTa0K2VDPSoBpkrv7I6QN0xfdP22pvOsQsOfEjJe4KcrLG7wImfKw1KEtTlxFeZanzR
 INCBQ9pu+7A44ZCZ8cCrCKxqg5CRQhQGM1+SlYmiT2P3CEwk5qvuo5CWLEAatu0ms/Z2
 b5m8mriZhAnKOFf4eFiUdBMvbdM80sAfQrd01asYBBw7C+weKGDJFzTsIYyfRB6FEgg4
 f5fEinYz3PGoM81l2OI8lhHTOhKlrMuDIH3NFXOhfCFwwVGqaqnTmVPdrkAww+J4yZPz
 JmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752559472; x=1753164272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sD8tY4mt9o0gdV5erEmCvkaH7CaaQsXsKHANtQENlR8=;
 b=RCmmqR2xnDPlqQFd5mWkiYV5KVlqi5ixSwB89AbXTnSjJ8qCEHbf0YryRetbxXo5X5
 fPFE3PwC4jIhFznvedRnKuxJJxqvJW+pTre5q3293MHhnHvGu9Ak6aX7y3ku/dgJcgJe
 Gft2USejl7IUx5+K8+v6K5HiYQqNO2yjte1ALKbiKDYE6U/CzVwE87EzZo2e/b4mHdcv
 WDQcWQHoAMTU8P6yZTvF8IcMYN90wu9p1GjU/P9Y6Sv9Q+UKi2AHN4L7ottxFDtCrU3p
 uUp01S1Z7Hl06YZ/ggKdI9mDhjw0IwTDZtBuO89Ghu1cXQWs6kdcHVq3DivujAboRzAm
 rAMA==
X-Gm-Message-State: AOJu0YwHiVqUwqGQhWlGqdPBk7v7hGxi5MKxZwM/Krd/SvsbHo5hJzPF
 g9HhkQvHZjpxD6dV4pWToSaSxS0bUvcYwVFeoouzhzo0HAQ7bs5PKYSN/BF2HbUkTG9n/FYh/j7
 MdCW9
X-Gm-Gg: ASbGncsptgdRAxm/GH+oPcYnxHCrrum0k7QBvJwP/pZzUnSdVrHJABb6mv9ZuS3UHND
 GPwER14388vOSTnknxGX0DMGhRetVeYiOLACREUdRs5tTZ3kQZnqP7EbxFfkj0302mR4yAHYyq5
 Fz+Aubmidj6CeCOuJR82cdepGKvDisLlS0gSkbbA0R5tw8C9vi9PZShYXEAl2LlUpSKAe4KrD6I
 TunZBk5s7EjFP/WD3GjDFDttp5TaqLoquV4Kc72l6kQKaKAjNnpURnNE7EpbnLDFzViMzrpZ2c3
 uAlJwE11/QT6Bry6apFzwvsbeubSF39Frk+X6HFWg1D7rtRheoMXNHtGL472l4TtVG4hjAUdvji
 xlkqVPr5d2BtvYmm+lT8tpAGlRLCRosjWK8apDAV8T1naUu35grik2xwy0OqllaXsAg==
X-Google-Smtp-Source: AGHT+IEfhovyyJoCJTrHFYUVgd/SFM2xzj70GLKeqnPdVM37LmEKmHK+r5rOdpqYTX2LCw2uSq1PiQ==
X-Received: by 2002:a05:600c:1d9d:b0:456:1a69:94fd with SMTP id
 5b1f17b1804b1-4561a69978fmr67091535e9.0.1752559472407; 
 Mon, 14 Jul 2025 23:04:32 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc217esm13807814f8f.28.2025.07.14.23.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:04:31 -0700 (PDT)
Message-ID: <0c5c2f13-99c6-4b86-994b-68ac2c9b25fe@linaro.org>
Date: Tue, 15 Jul 2025 08:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips: Restrict ITU to TCG
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250702164953.18579-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250702164953.18579-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 2/7/25 18:49, Philippe Mathieu-Daudé wrote:
> MIPS Inter-Thread Communication Unit is implemented using
> TCG. Check for TCG both in Kconfig and CPS source.
> 
> Fixes: 2321d971b6f ("hw/mips: Add dependency MIPS_CPS -> MIPS_ITU")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/cps.c   | 4 ++--
>   hw/mips/Kconfig | 2 +-
>   hw/misc/Kconfig | 1 +
>   3 files changed, 4 insertions(+), 3 deletions(-)

Patch queued, thanks.

