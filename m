Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2239A1091917
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 20:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Jzy-00068M-LD; Thu, 19 Mar 2026 16:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3Jzq-000688-8d
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:29:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3Jzo-0002XK-RP
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:29:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so6112515ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773952171; x=1774556971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JMJCoqjgswD4/ZZYsHdwsK6JhLRhvyg3P00Z0hwms+c=;
 b=JtzCmZV0gZLxd18KA/Ko4BzZeDZ92VovHnmTBsHgwaGVe0Fm0f2m4kqGdtH7Z3rtc9
 cyuESzP9cc9kh5eaUWJeGmgnM/5rrpQ7mjixTglu5LgLNNnlobM5ZmhIOOwdmnwONxeY
 wm/hei0GjEYXvjjP3psla6FZrGU0wtKZsPnk7P1YG6m1A3XpkvO4VpuVYC3yVN9E7iww
 86Uxqs7I5m8vZjjytvxCaZHf3DuIXpL2dvSm7grhUsyLQF1gtumCBDlqctkzfynE3nUr
 ox0jCt97MsxIDBnqX6nGPWzBzC28yOWqPA1YbU980/1akyiqvEUALkHXM2F4YooUaOsA
 D43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773952171; x=1774556971;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JMJCoqjgswD4/ZZYsHdwsK6JhLRhvyg3P00Z0hwms+c=;
 b=apkzlogyTRt///f0kgaGuS9A+YBi2K2detvk3xTKEPNl5WlDkIf+zaApU419eHnXT9
 KnnEkYDTn7fjRos8KCMfmxStPWhP78n8DGn3AsbTWKW8XpL5dfl04yQ/F4VEyc52f1BX
 rQpwEJ1BmcPqRYDkmIgCWblfuBjhOysDTcyjiqFCq5Kp3XI6MQo1Kl3Ls72+fQdojsWH
 Ao/U5Id8Meq5cdqvm3bzDRGtOlKj3SxnLQ2LYEYWgqDpo3GHnYcr3mndNJg5BXBLBn3T
 +C/ay2++i36qKky+GNTDeRSUMt0y58c3+k9pdH44ezccH4Gwtbc8yr3ILuYmYWIX71f/
 l05w==
X-Gm-Message-State: AOJu0YxWUNNeuBnPRJ8bRuosEMFrxuydX5XYPIMuVjzhZhEQBswX9R6K
 0XX91vNba3N0nlGxlO4AinwmUqKJTXK7V9s2nWMrcqF9jpigGdjstBhyYPnUtHXl3zf1oREuXhY
 jJ7FVWCc=
X-Gm-Gg: ATEYQzwL31Go3ivRv45unqoQ1SgtC+AWk55SqV8OG5sEqZO97P6L9VJ7ZQ3AbuuYO7k
 v8dy96yxMzFURtDL6z4DpGF28VKWPsYocvdWIngvnLu6VshndAmFISA1slBf4q9TQT2b5uYz53z
 gqoX/YxmiQvVwL+bwQKxNhyWTGhpvRPOe/uEhzmbshzdcGMJbpCdgNJTNQJGLh8JuF7WdeK1s+Z
 gb17eBVFqN/wr1/d9ftlxLka/m4RoxRMXHESyRLUXfgEycVEUsHkw2ixZuSSPxcl0daW4DUw+Wz
 xc7+2NwINlmtVIiBXkI7TOucMmDq96VHmKaWzEPWiyyI8dH4ZZyn6nw8k7TtStLhQQBtHdJ36vQ
 ce/cADzYZ6AyEficRK2RlnYSQnP+Brz57MLamv0cvuZz83zutY1pmTKISKvPti8sNB8Gwitk9hM
 PGnYGEvC03Av70L+s16lrPZp0it0DHq2nKWZg=
X-Received: by 2002:a17:902:c950:b0:2b0:7509:1b25 with SMTP id
 d9443c01a7336-2b0827d0540mr5167295ad.37.1773952170742; 
 Thu, 19 Mar 2026 13:29:30 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516aa6sm1057575ad.9.2026.03.19.13.29.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 13:29:30 -0700 (PDT)
Message-ID: <573f0917-57fc-4dda-bf40-5d5aaa70a43e@linaro.org>
Date: Fri, 20 Mar 2026 09:29:25 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/fmopl: Convert malloc/free to g_malloc/g_free
To: qemu-devel@nongnu.org
References: <CABHAK8Nuabpy412TgdEqtNJ0tucrqqVupwnZCYrZGmfHFtH5tw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABHAK8Nuabpy412TgdEqtNJ0tucrqqVupwnZCYrZGmfHFtH5tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/15/26 08:29, AADHYA R wrote:
> +    TL_TABLE = g_malloc(TL_MAX * 2 * sizeof(int32_t));
> +    SIN_TABLE = g_malloc(SIN_ENT * 4 * sizeof(int32_t *));
> +    AMS_TABLE = g_malloc(AMS_ENT * 2 * sizeof(int32_t));
> +    VIB_TABLE = g_malloc(VIB_ENT * 2 * sizeof(int32_t));

Better as

	g_new(int32_t, TL_MAX * 2);

etc.


r~

