Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F32AC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OtO-0007zS-24; Fri, 25 Apr 2025 15:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OtL-0007yt-8R
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:39:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OtJ-00073l-GG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:39:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224191d92e4so30976145ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745609956; x=1746214756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OokO/tq2qB9Y2Ist1qGong/s5fissaI+PRCjOOAgPcg=;
 b=LRcuWhiCUcyr676kj0+vc9nhOhqGlk6MFlR2mvhV+OR4dSCma+AOhd/ldt1uufKpHf
 kfw0F5Jt15lTH5eOEC1afCjkzZUkPeCfREGJFZkgGoEs8u5MwGDSbi6L0G941XwbJI2K
 mbaDi60157MsTC9+uL3gAOB8lJtfGUh/il4kXVc9+KhJ79Arfg5yjYuGj7YwwUtYb+Xw
 A6xifkFE39lY5x1Mo2uvS3aUOFoBkzle8XWEFI2l3OWHGXyYlU37k4Ka176sQrzWkh+1
 MeI3wA6AJug6cOXefzpXTNrGKDRbZ54C3fhZekmrKkTi/wCAZ1dTDx0xT5/c3Z0yEQpS
 lEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745609956; x=1746214756;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OokO/tq2qB9Y2Ist1qGong/s5fissaI+PRCjOOAgPcg=;
 b=Y+yVGiFM8t6oMa6H4l2r3uUptBknB14kJex0M3l6VKEkqZxkkgDJHpX/uu1Ja2perC
 bmRVWI80058skUTbUekcyG7a3igr3bapLJ+5aM4ikBLvCbRg7VMhpHN5H68mxYcNvOZH
 vFdgkh5wLzGOEvM8lnqd2LotlKzkcF/utKFADVZ7qCkNJzoIPaY7PbGpi6uqjhmRNGQN
 R2bXzNi7ACXZWOrZVY0PpDoByUXK5yex1PYc9HaJHV59UrhAIk0To8ofbcdDRgTKJ4uO
 57Z5y5SbMXmFvGgEHYRmdKYJXq7+vtmZKBg3VWvRX00MPBHKcmrKZjmSd38xYnco+/Ld
 Wdxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVMf8e3Xt3mAoUtbNPTmjvls1K5uLF2OGe+sCGFcPzTJZNWGlSWZZBeE/rihcsWupB9PK0m8irVWs8@nongnu.org
X-Gm-Message-State: AOJu0YyhUIPHp5XksdJ3DDfn9NRmmRooirT6M+2gtnvI6J0Onbqzk/RN
 TEoBYU4kp9CxO8sK/XpR6HVMBETiAiaMwL1wzZ+3XpeD5VEn7l7fdyUfsCFxsSM=
X-Gm-Gg: ASbGncu6SmeDnAAm02O04ykByMKvwvRU5XpofMTwO5he/Hvgpl9UIE53tNDCANIy/zU
 VtA6wfw1PnTNqh4fu77UxXf5yY0dR4oghl5Lb06DYT5XdVHZfOsFG2v4MEvdQWLiC2mhZwabdfn
 DflzEtRtUPODAKb5IdWg9iUBq9RStZEaMFZxj631kCxJisFIk34hsF2f65RNe88XpL1BANNRdoA
 5lFpekBKlminYuHVs9g6uQPGkAeJG8xCyR6YqSa3X7UH2M9Ktk9WvnsEJzmUW3WWZCgb2aHDpPr
 RPl/93Wj0gi9dChqQhJoJ2J2L6n95d8UC1zdB2MgiVfNpH9B+i5Vjg==
X-Google-Smtp-Source: AGHT+IHPkXih3Fvfy+ypbcUEoEVR5LTgTWGYFr7AojS3mVbNM3BjrLomZPq8ylB1q9rWViuGyZ8Ttg==
X-Received: by 2002:a17:902:d48f:b0:21f:6546:9af0 with SMTP id
 d9443c01a7336-22dc6a80f67mr11474235ad.44.1745609955955; 
 Fri, 25 Apr 2025 12:39:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5100c70sm36522575ad.166.2025.04.25.12.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:39:15 -0700 (PDT)
Message-ID: <67465e05-a5a3-4c94-bdd9-4f0e2c4c4705@linaro.org>
Date: Fri, 25 Apr 2025 12:39:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_range_fast
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-7-richard.henderson@linaro.org>
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

On 4/23/25 18:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h | 5 ++---
>   accel/tcg/cputlb.c      | 2 +-
>   accel/tcg/tb-maint.c    | 4 ++--
>   3 files changed, 5 insertions(+), 6 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


