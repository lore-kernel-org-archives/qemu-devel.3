Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B685FA1FD7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFaqk-0000bC-CU; Wed, 22 Apr 2026 12:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFaqS-0000Si-Ex
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:54:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFaqP-0001Qb-TQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:54:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so35012975e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776876869; x=1777481669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/R4JUxI0x5y7vpWyLyEyIuZWveMbmO6xl4uXL6GDrQI=;
 b=wgnsCJsWa1daneXefXVheV5SiNd78lgsN3PVGHJvO1hNvBPicYcG2J2tUllV8XPIQI
 XIG21eFZZekBz8Mtw0eILLg0HKiw5P3bsPsR8ZwO4pWBB/j8dZT3dOLmf0bYGVBBU5SL
 uLLYzfpi9D0GZqGqQv7Y7Pm2oXGm6lPhKm6dihKnd0/rV1W4syFVXDronUqXlStoyc7O
 BkwhnkFX1hnq10Yb1xdRJZ0wAC5LQdBNRAeOZ5yAyQIKPrW5bl+N/Jiv3PGSeH0U7hzb
 NiBw4DU2947/Q01++WPoBWEgzfKNAFAMBFoBI1hJT3eB3nVUHmi8FsfXPslZ2HB4b0VB
 IyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776876869; x=1777481669;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/R4JUxI0x5y7vpWyLyEyIuZWveMbmO6xl4uXL6GDrQI=;
 b=gb9BfpwKmWKE0dEy+rH94dJlDLC5O6JAgM/1uE3DrJ7R9b87SwpFJDyFeIgAkKZMEz
 un0NgVkXIl789nEjhVZFTfwl4R6oUEXqZ7KnMH4Ixbb+cHkhgG6IUR88vA76m7VhxIYA
 XF3RmfPgnXzWk9yZ60pgPR+Po2OM8NIBkK3M9o1HEUa1eoRTkXx7eBclNxPVvTad8gHj
 MU7X7fyk3cto48nzKCUfj0VNTVIu6vNrSrJnXDik2HPmZJt98dgU4JmD/xi46GN+mnSF
 FNPXJbWIZyNxzb1ulBMLjBghMmgrMTO2ZeCEKpo51S10XuAqpgwbgNxQ2AvBCW68fNnR
 FMfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dbj5lTE81GC8Q7mZGbHm6hicdk1jycto2+Y7lPcymwXkMqRFFiVEFpKMN8t5/TaGOSEIfGvwljd/Z@nongnu.org
X-Gm-Message-State: AOJu0YyZYl4z5hkJVYgdAgiGf9K2MZthMrLAPmOn6a/rrNzkzyTzIyLY
 d9/EQF5w7PNmyxxw8Ao6I7oEdoNEIhTlBkU7l0UZeG/Q3I7VI0Hq65VPWRRDCHrmcIc=
X-Gm-Gg: AeBDievGNdQymUi052kZhl1qYkIksVW5x0Fr105JE6j0ijCYuO3jldOuDllnP3WNDFt
 EkS6NxSkBDGcXJcatzpOmBv329KEg8C08cCEZc+Ol4lhxzZamI/QaZJIPloQp7mixmarF+4ZAQQ
 P8+ppMQeVqXbJ75ceuGZfBFC3BEXBFvl2ZsHj5jZIAioM7vrCNOQCZu1Xgcym+E7L9e3ZdFCwPi
 w0KcwebA3obu94tVj9jVDwmsSmZWPCwVryXHFyem1bgySEOOjnzDNNOE8+8ZnyiPBewlq7PXqaa
 9tQsa24pRdgxmJU6Weojgu5UQzch6bkNaBv/FzeKpmqg6e9ZAz78WggPqOfBZQXyEe27YFqGH2J
 MN+gtuZNLEEJKUHeLkFzeNwVnTFAU8jjNmI9pZtxWQZnp2Stkv7Np3g8nes4OXn6vO/KARYtv17
 E2wBYZ0Fd8kQNlshotyBH0VWXtK0OOlH7M+OJ9gjKe2LKgJgp/VY5UTuAcZ7nhc/W8xzNCnu63z
 jlNuk1QEXUCsnM=
X-Received: by 2002:a05:600c:3546:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-48a554663d4mr123234745e9.15.1776876869171; 
 Wed, 22 Apr 2026 09:54:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a0c13sm145632745e9.21.2026.04.22.09.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 09:54:28 -0700 (PDT)
Message-ID: <c7d5c311-d010-400d-a2d5-3fb355cc5326@linaro.org>
Date: Wed, 22 Apr 2026 18:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/32] target/arm: migrate fault syndromes to
 registerfields
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260422125250.1303100-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/4/26 14:52, Alex Bennée wrote:
> Migrate syn_insn_abort and syn_data_abort_* to the registerfields API.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - use !is_16bit directly
> ---
>   target/arm/syndrome.h | 87 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 74 insertions(+), 13 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


