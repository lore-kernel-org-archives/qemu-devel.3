Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED6C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANU5-0001uW-GM; Thu, 01 May 2025 02:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANTy-0001YG-50
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:33:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANTv-0000mc-UK
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:33:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227d6b530d8so6545385ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746081194; x=1746685994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jrm4bXaNm9+X7EGJrXl7Sdv045tZFqhI/HT/v3ayuKI=;
 b=pmeVisioN04dWO0Ebb34kQ4dN+uUNpxNxKMtbfGU7FtEolGncrjMKacvr4s5fsyBIi
 jNT20uFNg6yKFz+M3Ry4UfjXy46LMDAfvLuzTuZetgOBXBTOvMmHJLS80myhjh+dsXX+
 dyh5xMGyuHlKbEsyhM6FT8CBdYcdG1b6LPrZvuGLMBxkEl+RlcpwvYQrx8Aopr1HbJan
 OmODXZSg5XJMU18HS3wRv9ttHYkye4+ipAvduFRomk9sHPxseCyoCnnbsPa5rn/2Sdf5
 EC+nc2Y7G0sAx3ysLXvXnvAYxS0RQVhN/XGz+A+wVApWleWxlo8mO0tw2KcMbqfqr4UO
 YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746081194; x=1746685994;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jrm4bXaNm9+X7EGJrXl7Sdv045tZFqhI/HT/v3ayuKI=;
 b=pNIO88dKe8KJCW6p2MnjpX1/35JZC99rzK8SOMdVrZhUeqvJ3FBzWSrz5HcrXx0JqD
 boQ+pREs/e+55JmSClbeqNZ3cA25xfhHKWjscfuCcr6YLegJP7RLHZYDXW9yhjn3Lfjx
 r5nMugsPI0ooyqnVmNBGdzrofFt89J/Sjqw6IHzyM9P87adqeeEUcQuDdsCEYYyzOcAF
 xIfPitSOrpSS+e1a4w5sSJoAKhVBFGvdKf+xS2gyv0n/N9VqPsVe5WbjHOGi0MEsMW2L
 MaYJ0s3pKD+dK+YcAsz0TG5ybeb+E6g/yeI5u2iA5vyB9c0wqEASFjgcGWVX8doO3x5y
 IO9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBjXs3243efkOxNSwg2tiDhVjsP5NcMk3cmx7mrOCm60kKYNG6E5mSgu1eTctNKlzom5P5Xqo3mWei@nongnu.org
X-Gm-Message-State: AOJu0Ywt8BpX+ZB5slEgmA48kFbG0sfAZIBoF8AC8lFsxuWXodveMvYE
 oY3xFnxys3VU0DsoJfXSMEy5IoxjQxJb1T0Ya0A0hWKKWGwdWHgIo8GtspKf8vA=
X-Gm-Gg: ASbGncu8XDCtJx2C1R3Jc7kTRhunkz0ybcNUAf0A3yo/kGeuSc3Lrm1Xb1b3s4zHuvn
 53z8HTZSMsRwbT8vx0HRmAu1PH3VFX60sPradCB701BUzOf7x8aq6Rc1eKTaHPWtCARXtlSjxpy
 EkrazJpi+70nb79SkjRJj6ZqVe2V5UpSZnThX28kJEYePSsC1oLHQA4mmG01/vJiT8tRRbyDetv
 /swxtE5H6jCWNvb+A4Yvb1sogsg3OLduPGdojOroEP3E1/nFQuYXLKe3fVzSeDpZDS9XmmwpPru
 MfBzELb4Fjk6C9/DoUZWro5crJoYHdZidydC0FnoP0qVSvIN6h1yow==
X-Google-Smtp-Source: AGHT+IGg18BZZsDZ3amiVqOIpgWvI5EnyUt2A/63oT+ImcfkPaCte95RWDZkO0694LQ37aOfCSt4sA==
X-Received: by 2002:a17:902:d2d2:b0:221:7eae:163b with SMTP id
 d9443c01a7336-22e0864a4e9mr21579385ad.46.1746081193964; 
 Wed, 30 Apr 2025 23:33:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1f9d66e230sm69940a12.66.2025.04.30.23.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 23:33:13 -0700 (PDT)
Message-ID: <0c9e7cae-7fd3-4a44-ba97-8a0f65c10a1a@linaro.org>
Date: Wed, 30 Apr 2025 23:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] accel/tcg: Build tcg-all.c twice
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
 <20250430230631.2571291-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430230631.2571291-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/30/25 4:06 PM, Richard Henderson wrote:
> Remove some unused headers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-all.c   | 6 +-----
>   accel/tcg/meson.build | 4 +---
>   2 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


