Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB78BC3ABAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAkB-0002S9-AN; Wed, 30 Apr 2025 12:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAjz-0002Ec-H8
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:57:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAjw-0002u0-Hy
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:56:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736a72220edso141248b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032215; x=1746637015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uu/qh+ynkdI9y+IEzJij5COZBwagv4SCbmvFFM65a7I=;
 b=Q5NF4UbHa+an00kqmBa5shnYmjrDmnwdby49JNv0KZ8RVJh8VxIyTrQmm4k2hluBDt
 75Q2pFYmpb8G99M7R//fQzfqFIQzggtQQV8mKFKnKdIaI3l22E9yLaQ60IQxpvl5gNFW
 Y9wB6R5uER82r58Ly0Gvb1FT0e4LmDtH8BuTUc4OuX0bloBnNMeyxW0mJCq37G4Qo6nF
 Djg51HcqhRujMvIJeG3nSFW8bMs+LWPhvlj1q2ltNeEXhfHGNWaHcxFpC34yeip+4Xwo
 3LXk0O4HIJtdKs3WIypGVay8LMU3tNITvOe7ROt5c1XZ8OIUbZmTqb36E/f8+KS06dHn
 v0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032215; x=1746637015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uu/qh+ynkdI9y+IEzJij5COZBwagv4SCbmvFFM65a7I=;
 b=S5NnOldO7vgyRo6fHXZ5Ywgibnhv7xcYa1xeVA3YwlLeCEI4tahhjNOrYrppPON2DH
 jGiK6FU1XzIooNnS0ugaIFhRSmVEKBmwabGQGKPhGk3UzQOzxgH1niqh34NtL9KYw7gs
 7ypJ3b820Nf6VBwp/l5iDS6u/0NtpSfa2o9JXjgkibW8Nalmq79bVqQDS51GOvonFEzA
 xs/2vMLYarz/nb/tJ7hxftimgwfhatNUyLHv5j+Lt1rmoEoXNfXunlRWsdJ4Zh4xxLCa
 LRGsxXC7Va4Tpcm63HVf4C1G3fxxtLAcS75SEXMcYq3W/kSExvXZR0rp8PdLJvN1yTOT
 ylrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIA12B70AmvdDMwaDk4C8uFIV7haVa4yJS8DIPsHswR8G3LDIF7aVtAR6NVskixMhaMPQH1ge4n1Jz@nongnu.org
X-Gm-Message-State: AOJu0Ywy4YYdDbqMiBRjCD+qXrF2PNtd/Wewnxp3Q5x8NzIqHM00MsxS
 KWwvWB3PDATVGL9NxTE4JHIoYQIyOjEgYCqynnpMpFb3vI+UZycZri6RkOhPmZA=
X-Gm-Gg: ASbGncuG3z+P53S++9yqQaB+imP3RthASsgC+sNeqJO2BvkZ++utnIS14TsdAIErTQC
 wV53SkjQMhpnW3xP8GwgOpGmK1uYcJpLHdDI/IlZM7xi+LnMhOpTJKxqMApaNrwiVT5ivxoj8Pf
 AkHNHuGKzq4Cr4OrdrZ65VTU5JpML71wuDJ7pYc0pBqDxkl43y0josnND22+RqHctj2PK6vR6od
 qHFuxTxRZVPZU3gFCA7oZPbOi9HOI0bJ9sw1dXf2F4F/QHA9jmSctCci1E4XEOje4FQ56HXhy90
 Z9NI6SBD32T/p+TwHFbrJFGIHrqekAk2Qbrgii5cQqxlxcY2z8x+rw==
X-Google-Smtp-Source: AGHT+IGGmpbMUSqX1RoSA47pzTYd5yTX4q1Xatn69GQdUU/W5PuX3s0WdtIBPxWQbsw23c7xQbrT6Q==
X-Received: by 2002:a05:6a00:ccf:b0:73e:1e21:b653 with SMTP id
 d2e1a72fcca58-740389593bamr5112132b3a.5.1746032215160; 
 Wed, 30 Apr 2025 09:56:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a94d4dsm1955026b3a.173.2025.04.30.09.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:56:54 -0700 (PDT)
Message-ID: <a3a35843-0a7e-4dce-a107-c7da4ed1b1d0@linaro.org>
Date: Wed, 30 Apr 2025 09:56:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] accel/tcg: Pass TCGTBCPUState to tb_gen_code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
 <20250430164854.2233995-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430164854.2233995-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/30/25 9:48 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h |  5 ++---
>   accel/tcg/cpu-exec.c        |  4 ++--
>   accel/tcg/translate-all.c   | 28 +++++++++++++---------------
>   3 files changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


