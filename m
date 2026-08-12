Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944F4C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuEUC-0002LJ-TB; Wed, 12 Aug 2026 15:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuEUC-0002LB-2M
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:19:36 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuEUA-0005Zv-Er
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:19:35 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2332568a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786562372; x=1787167172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aLH8zsGDhbjMC9URduZxHcCBZ3FzwEHnyLt5tXuOrGg=;
 b=v3mLlDJYIHyRyWVbj9Bcy/qAzSi7Tm8WXCLsvPVW/9rArQ5cysbpgVF0BZezgLgFJU
 hTpe/h6rp+CpOdXycCTfZEBNoASHhl+JPGzQt0LPmG1H5YJBb+BsuMtUJhE9nZ3NpNyl
 Tafgc0mBTRNoZr00wXMtqSk0F7qnxfeMu8PrVvOFLIBzBsu0bOscTHYR89YE3KR1lodl
 lLotpjREE3widbQskFK2gVho6PAFOiJWdvyMDNg6qumWDCylbayfrdKzr1L+a5gNTtDx
 PmbMYGrAi0uHVyA4jfJGm94aekKjGsr9+Yk/BVtMV+BdDO8AWarCGzNt8XXbRPx6r0nI
 3VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786562372; x=1787167172;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aLH8zsGDhbjMC9URduZxHcCBZ3FzwEHnyLt5tXuOrGg=;
 b=Yr9I1AfF9HGmfGFvKYMJnWpsEOE3hgB3UIOjorVQWOGyF1WitRDaHl4FL9H50QkliD
 atVWtMKUGOzG0FI6Xdrbg6W7Y+ToHWB0YYoZ6UnIag6f0IX0rWxldWCY/NptEqAwKEuy
 xytCnJPNcjvWtKaldQAqHipA8iqOPJ/BZISo1Sz+NUA+qQ4jGcvf2W3t4+LbyR9xsbax
 D+P/VnJoT+Jyu+DYBPlZ6mvjVKgm+pDZaYAz90iuKF3QyVxmwW7XYc8ZKymSrS5AWCGp
 KllJ81uHRge+0GN+TXISfj5CDDQKYtf9RFjBlYJ6tzvVNL1K3EX0mmmVLXUGwNK0IBtr
 kxXA==
X-Gm-Message-State: AOJu0YwaDaEUifihd/KHzWfXP7DA6gaBiDt8u4H549omQ+/1YOvvB7vp
 /KlrTwY8vXVbBiJB+cS6wCnJzvF3tw70Hem2ViEVJuoA23/YFHn8kBk1WjOyNGKmZXMibyMOc9l
 +Jkzo
X-Gm-Gg: AR+sD13bZXXTtepkSLo/GciIQBcJCcEW+LddKYUJ4a7u5Mhj2euDNCnLK/qwo1E6W/c
 bXD8c9NQo0dvrTQGxl3Rw5VI4+hwFZsrl2Bzm4XD6zl6LBuUcJ+xQWi+mbHn5gnoyitk2+riBhV
 nuNmP5vVy99S8ZVgdzleELRYEfgkNdpgYhdeKGt4L8SKlW2IGVhI8VgabeBNUxIn1DECeByugNW
 iK7hBuTzXTTwjAhmmX0Fks/wAE/C9m/pJ9wxeC/tbB0KevgDZpuUxK6OK3shLKZW3TdDOklpEFr
 A1I5tlxsxCekB7Jun7ZCwwqFfqnfrfYURoBWM8FVI9H1TPep9fH9l4r1t4NJwZBB97cDTyGRPq+
 Z6o1tMq2A6GrteseafArXjFSXG8rmUE8erAhekG9NpbUQlZYQKhDGEbwutvE7Q69CaV5ZUH9keM
 XfiXpJjgrhgKj1kC0B2RXhStRYwQXLUvMqaLZhMaAjGAT0G6i+mAdPyEF1VAU4qGfQ4MeLIHWOr
 flQkaNE7GYmAwPtvFPiE03JRgsX
X-Received: by 2002:a17:90b:46:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-3931dfdd5bdmr604497a91.1.1786562371704; 
 Wed, 12 Aug 2026 12:19:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931ed14197sm114472a91.2.2026.08.12.12.19.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 12:19:31 -0700 (PDT)
Message-ID: <513c5510-660d-48ff-b90d-8640af14dec2@linaro.org>
Date: Wed, 12 Aug 2026 12:19:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/26] target-arm queue
To: qemu-devel@nongnu.org
References: <20260812121622.649730-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/12/26 05:15, Peter Maydell wrote:
> Hi; here's the first arm pullreq for 11.2; contains one new
> board model, emulation of another SME feature, and various
> bugfixes.
> 
> thanks
> -- PMM
> 
> The following changes since commit e8d693e12af9cbb89d724baadfcc08559669e279:
> 
>    tests/qtest: Do not use versioned pc-q35-5.2 machine anymore (2026-08-11 16:12:34 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260812
> 
> for you to fetch changes up to 49aecf39008ebeb86127b5055cefa17d68370b20:
> 
>    tests/functional/aarch64: add raspi4b full-RAM regression test (2026-08-12 11:41:56 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Implement emulation of FEAT_SME_TMOP
>   * New board model: Axiado EVK SCM3003
>   * Fix various minor bugs in mps3-an547 model
>   * hw/i2c/bcm2835_i2c: Correct iomem size
>   * hw/misc/bcm2835_powermgt: implement a real watchdog timer
>   * hw/arm/raspi4b: fix guest never seeing more than ~1 GiB of RAM


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

