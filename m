Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57472E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFHi-0005fz-UK; Mon, 16 Dec 2024 12:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNFHg-0005bD-1J
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:53:32 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNFHd-0005ti-SC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:53:31 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21675fd60feso46395115ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734371606; x=1734976406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MBzqm+6+i/WpgbOCL2Iux3DANRrssM7vUL0Y79rULN8=;
 b=Xi8nuqSjKVNjS5a/lB+rsjA5kAfAXVGh9mEcX4P2xzQ89ItwLaQ5TQjrZlWe4WuTEZ
 56bWxC7+4k1oWewTLfWodqPqDwu0YawsY/gQcJgAczzrl9XTeyhrsHzxWv3TOro3k2Ia
 bozushOJkR0/irJ1KDhXwlIWGDKTZVOLeubNl2lc6OMVpGnB342cxM5pXreVPl0Gyvfn
 Xf2GrBW4toaTossWDNk3koZ1U6ON5Qs1Br4ThpWD/j/D7qLsCqZr6bG370E7qZxjY2Y3
 Ri5+8dOSXThw6grpGkVDNxq9F4iBnmPIufBPAiWz1PWTAjlPhF+ce2Iq+aof1w+nzowx
 9veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734371606; x=1734976406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MBzqm+6+i/WpgbOCL2Iux3DANRrssM7vUL0Y79rULN8=;
 b=iUAG5dzXBdCTM5W4yGGKDjel9H9tklxbpT1Qp1hpNbg4vYJfgmjIZ4vnR/j6gdQ9hA
 vHQSVrhUheR6Q5/bewdZbI7fesKZLfga0ngDuVYC9bcWLQMwz2Hg6kY5+w1kojCh0Xdd
 G6eP2uAyljfkeBaCateO95W7Kctl+mj58vi3EudCkKiiKPo+AHSS4iLkS2GquJKGX2sB
 miRms897Gma5WkzNo1DGWwE8b+Cklkn+HTohHJfgkp6cEHQGQrHRgNj3wPh66OCCYJg3
 1nw+7ubESwdTDHvCdqlRv3KkVPMsdgNszXy+9rLR7M/v8zXOXFNrSYZUSWJcyV+ROMpc
 jlag==
X-Gm-Message-State: AOJu0Yyggk6E26nGLIb15mNyHcljTSyWnnX0Dv0kUjOrH/fFiczE4DvD
 ZcjAXZDyneBX0dJaV56WSNHcRYaxfHY0caERjFnw8op2Igef7274kGk8Hju78M0pJw6UZZbM5T+
 0cnE=
X-Gm-Gg: ASbGncsqgG/kU9oswEzsvYVNzxTuv25QHvjA3ZoMk1IAPiQZfsBz+te80Vgq63AlIZ3
 nm/aXb4+RdP2YmwXk12d/3tbMm+eo8Dm4zXiNpSjyhni3M8Tzne9yz+nQ494JJ4e7TKHLQsbCCE
 sfgRgUbmeJ1KjA9GcRyUWgAoYBHt6vVk7Wgrww8LgtkfUZzVsjJ5NUWFF1TeaXoowI5zPKsLOlQ
 IfaCV1AUAjDfb7DBgGmamwA08t/lkTpu+aEEcXVhDr6TE4NXbEU8YY4MfxGW0++F7rSa0eNToS3
 PwSn3rqLThefymPB0G52K5GN2tQK
X-Google-Smtp-Source: AGHT+IG+5tBIo4tnR2W3OtwzOX5nHv6Z64YhRO7rPfxHEdYGouQ7NQQG37t87dPhNsbDyFgeM5/Vog==
X-Received: by 2002:a17:903:284:b0:216:2e5e:96ff with SMTP id
 d9443c01a7336-218928de5e4mr198675035ad.0.1734371606345; 
 Mon, 16 Dec 2024 09:53:26 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e640desm45746135ad.214.2024.12.16.09.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 09:53:25 -0800 (PST)
Message-ID: <73c89377-d8e8-4018-8448-3c8acedc94aa@linaro.org>
Date: Mon, 16 Dec 2024 09:53:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 alex.bennee@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Hi,

On 12/4/24 13:12, Pierrick Bouvier wrote:
> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
> spent up to 50% of the emulation time running it (when using TCG).
> 
> Switching to pauth-impdef=on is often given as a solution to speed up execution.
> Thus we talked about making it the new default.
> 
> The first patch introduce a new property (pauth-qarma5) to allow to select
> current default algorithm.
> The second one change the default.
> 
> Pierrick Bouvier (2):
>    target/arm: add new property to select pauth-qarma5
>    target/arm: change default pauth algorithm to impdef
> 
>   docs/system/arm/cpu-features.rst |  7 +++++--
>   docs/system/introduction.rst     |  2 +-
>   target/arm/cpu.h                 |  1 +
>   target/arm/arm-qmp-cmds.c        |  2 +-
>   target/arm/cpu64.c               | 30 +++++++++++++++++++-----------
>   tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
>   6 files changed, 38 insertions(+), 19 deletions(-)
> 

gentle ping on this series.

Thanks,
Pierrick

