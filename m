Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A631ECD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjAw-00024y-TQ; Thu, 28 May 2026 18:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSjAu-00024L-Q9
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:26:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSjAs-00066J-20
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:26:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2bf1f074a12so1546885ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780007156; x=1780611956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dmFYsMCqZh7ftK9E47vfa/Td1kXRDKvR8tOLKhJ3MBs=;
 b=zOXQIP9q0r9BfH1308wQjb4bMR+nVmsH6O2DtN49EyWxREzAHNhJrHblEUPvmMSDHW
 7wMXFITlRYAgQUdBkOTPWPikuv6HofLnhQ7GNJO1UFrXwQvbYSDLMSgoyoeyeasqDx2d
 UKPyFmRr0KadYJ6BoaFdX9oWZqVJlJyCo8K4r6MBfCMrcEkjH6igv8E0izshlBAcmIiD
 pfhRMpTU6a9C0hjqVbIlhmaoRZc6fN5AaMg/N8jRtEwvx8Kp/7bdiFvmyZG/L9mR9edO
 NhNVJI5fJr9zAcgLu1Z6JlQMeUB+XUX0E+UTuaSnR1vVYjdhqU0FyunygfynYxQicMHo
 zmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780007156; x=1780611956;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dmFYsMCqZh7ftK9E47vfa/Td1kXRDKvR8tOLKhJ3MBs=;
 b=js/5+7sW47JvRyf7IiDzg41n+npskc2Lg+p6kYBPiMCN1kBHeQBep8q50fUYFci4pl
 U7r43pmQf+7yITVVrNabA9cDk393oTGCXZ7lBkcOB7cuK0CvVe31rxlagRr/sb6xLZZK
 6QuaxguNh73hRFMY26xvV1kAlqFKrBjLvwlKYMfY2nKqztEW0VTTy+oc8kbTxwMjN0t4
 g+MlM2q+dicSWlW7YJyP7+nHnT5b+luglD4eHXwpZQsQrHiklySmfj3+6375QtbeGxdR
 1wkLdhowS3Fet/IfZrcQKQWf2aXjaQH7IZbolyBiEyYx1NfflnIyzEfcRcIoSG7PYtZJ
 v6qw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XMOS2LZACuEeXPSZMoOQzEQhnxC5+qH8qPZ+q94oKqllcbMQkC9uIoaYDEpLRzMevxG+In8BpyEyb@nongnu.org
X-Gm-Message-State: AOJu0Yz2405zJJPZB6oQSeCu3d0zRaVwX3ql0T3tCslWJVG/SU/WUKAV
 5AVMdpkvme4D1VpiuSYnxXfWTehQ35Bq9Z5xKv6DUiBto/W3xyOPpJzCwvsloDe8fTU=
X-Gm-Gg: Acq92OHCNzS7/i3l/b1gp9afxPm/hUJACIAs8b3cZx1Kw4m1y58s3kd68mYpFO6ZgSI
 h79coyl4ll430dvztXPMRENZQc7k5b9zJyJbhJuLjOybrb1HwnFnmJCJYd3T+6Jb/K1RnVkTSW0
 C0TBwzfF9raP8Ano9WtJnwI1M/O8B7wGi2REY4gcr/FNxCAbjH1cuBJ8p9FTbf5ceHcqBY5Mykt
 UOLO/2+8VFWlFxWV6N8/U2eXT+83xW4+tyzd7zut3mXrYI60OIds9MmntTP+GIdFubAZ/TgDAme
 BQISgZgnvwszuXukZpPyX0vyon62sqz694XMwaPiwuF9IDRH6pOwNVc3L8K2bBkHZwhmdTsm0Jj
 QUUfL2D3oxn9stubkjjO93qjI6zTbYJmy+dr8wD30F+hCBvcfMTxzHeod2TR7tcVs2mlxuif8vX
 VZ859fRutWij4FogJQcXh40+533U4/aUVr28L71NGeOmdGq5Y=
X-Received: by 2002:a17:902:e744:b0:2ba:4e84:966 with SMTP id
 d9443c01a7336-2bf20bd7939mr3107225ad.36.1780007156227; 
 Thu, 28 May 2026 15:25:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf21d28ce6sm438535ad.61.2026.05.28.15.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 15:25:55 -0700 (PDT)
Message-ID: <8d57e90b-e5b8-4c5c-b0ef-91c7ef01e287@linaro.org>
Date: Thu, 28 May 2026 15:25:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/15] target/arm: load on canonical tag loads ext bits
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
 <20260511-feat-mte4-v6-9-8557cc1313b9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511-feat-mte4-v6-9-8557cc1313b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/11/26 07:01, Gabriel Brookman wrote:
> Loading tags from canonically tagged regions should use the canonical
> tags (extension bits), not allocation tags. See AArch64_MemTagRead().
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/helper-a64-defs.h |  4 ++--
>   target/arm/tcg/mte_helper.c      | 14 ++++++++++++--
>   target/arm/tcg/translate-a64.c   |  4 ++--
>   3 files changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

