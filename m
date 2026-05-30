Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759CCCD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTTBY-0001ej-OS; Sat, 30 May 2026 19:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTTBX-0001eM-F1
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:33:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTTBW-0006f2-3X
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:33:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso1098345ad.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780184020; x=1780788820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzmL/McHVUR5TkKZQUY13YldTHU56GErlfrApQt18Ck=;
 b=ZzV4FlTdAulyVW3Z5evwSazIBTU1BM/texFDGuAeXuH7QtHNbcMdk6+cPA6NzhF59J
 1+HbxVdl+IEI3lzmkw1+L3YuDKAlCHA1v5RRt5dlXMCkBbU11VLtUwkS/5cfT1qV82A0
 4v04ivyxQ8o9enls+VMdbXAvG7VQFjnf1ei65RODO3f6DeJxXv1OtfjKHJUKixG2QAmS
 ispOZkwciV0Joj1wVd5q1EhjzfPph/jtGE8G53oMbEzGQ/ZXLAHEdB4PArQaRB6dAKHB
 7dsxveiJ4znSr/qfHv94dZtZCrBCfHb+j9atW5U3UHOdxtiTRmUzWnfUfKvjSCo/erIL
 /mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780184020; x=1780788820;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzmL/McHVUR5TkKZQUY13YldTHU56GErlfrApQt18Ck=;
 b=hXsKPxnTpf/JVy8xkoO46eeLyoVY5sXl6GfVGphlOhxMoQ25cE/zE1wsZ5A3Ykf5DT
 QGL54DyJEquiFhTWch8RtI9k9QSO01Wak6t77qy8ckgJ1ELqe2obxZe++e8D/jM0mNFA
 bsCGzUiEypyG0fRUF6F2CxPDc/dobfVb7HDW2Gox/e96XKNs4ZaBYufqFHjgqv+Ztphq
 bCXvrNpeDEwGEOH4dcJexUPN4uqKS6LY7CHdLO+qyLavDo9s1tgb/n65bxXa2DurFACT
 7McncpV1Wqd4GeB9sZSoxv6jdw2K7DdHcZ8wgMjpzJMquZkx43HiL+8FPNNBORmOdaLV
 FQkg==
X-Gm-Message-State: AOJu0Yw5H9lj4e3s/jEL+bmfO4gHCz7uELJRg3Dc2xpdJrVgAh5SKQ0K
 1mTi38b9ICTlu86l3UOLSEb3bfxUjgCyYwmQO+viqjyGO6coRB5OQFEe3iQTDkRDiw8rllnKRvM
 kZvOAEKQ=
X-Gm-Gg: Acq92OGHhtTFeJjGZtNv6Q8AxNSyiyhaH9VoA3a99ytpzDpvvon+TO9GSPAScYY6D59
 mDJkqNaL4n0p21dOKDYk6kSZRC8ydsKoPvFtQOwfhwb2QCvWviXEhjx4xlD/vKTEI5E8+nEroIh
 KkqyrNrRW52HbpDfYz9384AlY2YZcJbGdzhB5TzjCgnByQT2NzbHdk3ECmbLh4Ye6z6bweWSNYw
 8mol++B8tHByLQRXT/6aAnRWuaUAI1fpq7VNnuasBeNoOqITrqgBg9omX39por+pyrKFNimgER+
 G8CopGmVwNAmkgSItywxHO/gB0yw26Z4835F+BrWg+BtmZBaG7Y8kMOmpspfCCUjpgQBkPSmONr
 gI+0x5977mMEW4L1lRxvlTqwi0qVWqkfqJNvzjif+DWWYx4trD0980MwJLZDcxphn79kqZzg5xS
 42j1XHehSMi7Prn+xjU2IcwA1EU5EDkibc+96DnbUy3tuX17E=
X-Received: by 2002:a17:903:986:b0:2bd:2de3:519a with SMTP id
 d9443c01a7336-2bf367939b7mr56385945ad.7.1780184019456; 
 Sat, 30 May 2026 16:33:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e5d78sm58579825ad.12.2026.05.30.16.33.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2026 16:33:39 -0700 (PDT)
Message-ID: <729008a3-9d7c-42f8-b212-f44f6cc564bd@linaro.org>
Date: Sat, 30 May 2026 16:33:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/38] target/hexagon: Add vmstate representation
To: qemu-devel@nongnu.org
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-20-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529215554.606133-20-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/29/26 14:55, Brian Cain wrote:
> +const VMStateDescription vmstate_hexagon_cpu = {
> +    .name = "cpu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {

(const VMStateField[])


r~

