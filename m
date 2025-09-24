Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4981CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 04:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Gl5-0005ko-DK; Wed, 24 Sep 2025 00:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Gl4-0005kL-B5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:05:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Gkv-0001s2-So
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:05:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so2371999f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 21:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758686718; x=1759291518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h4zS7oifCFvlyUs1tvRmphy/sUcSZy9ynMvWmlsHyug=;
 b=BZxXE+GwtFF6523TpWB5g9cftZd8hltZLOTvhdVeZ0RtYEp1ow2FKVU6NjrPwqyBGz
 XNpidiVoVWNHJEbYyTSGWe8qEMPOlDjIyi1sQ/rpmNbDDG3OYoqY01hN35XYL9PPOcRY
 /oUYy+fqOCvLQU5lvE8sEkdRDfWvbiwY6qvxIpwxFuP1kiBW6pFl6FgIAX7YnjZiag6X
 ZolTHnRkkn28Sybx9kTB1YKSspPdIdIi307EFgYaBqOOLVVJo7B4qeJnc6VAACGSyh3t
 KS5GxqdNeE3uajJ38T4cVrbrGGg+MmcyvuzLULvApkalHCMIxPLodod5LRQzSzVU9rdj
 BN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758686718; x=1759291518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4zS7oifCFvlyUs1tvRmphy/sUcSZy9ynMvWmlsHyug=;
 b=avKcO+uQwHo9PjjVVBrZCNXpKeq/frMkZRDOa+LKKFbqWD2oTJvo8S9hM694YBDNJF
 Dy+01oggbQ5vjMJ8CiwUCiC1NYrF2F69szfJ7B2g+b0+7BBih91pzWJl8M1g/007waQm
 JmZGIFKEaVXBMEZFr8bGyA0DjGL39fAflbP3h0kzVTykEbUR1k1XwJj4ur5Ju46GESMK
 0PoWFTtuEiPQylsfhYT8Lps+3L3KvPDDLffKE5Q1Tz3CFk2cyRZoTXKI++mR4LuzXMNf
 mtCG2D2c4l+vkbSzZIX76ln9ob/O6eMTUmaUDkwBKTqc1sG+Dsj4p8fhBPckBNuAYaKi
 RtLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRUukQMaMbRztzYsL3LVok+gMY8/zCnPHlFpEOmR2fSLi0L9coSULIpiO2NWTXkGWGtD6F7YVomFZR@nongnu.org
X-Gm-Message-State: AOJu0Yyf0sZ60UYGEacSW0DiK4OtPv9S3lewTFQBGuPCUawJitxDNLAW
 OGVFNrNdjlB7htjUi942Vmvr4NNrViLI6aoDjO5GMVRqa6vSlEaX+g6fSAaS3kQfXEmUBAIeeON
 qlP86oPNFJw==
X-Gm-Gg: ASbGncsdF+Zkq87zbE6sA4FF7MAIKC1/D5LyR5ad3rkY3dNrUJZiIACrKaCRSxLstxT
 8ny7oCMaNTNEii2DDRgHonVYnfd+PJN4pqez1D4cLYKOutld67+GIIf8xN7ES86pm6HQ07ibqjU
 Z18fYk0B3k/2+dOvbgnPkpI2V/Z8MREmbA5fxAOMyyCeEbhNoEfrPFcH+zBFrEKr2aG7Ko/R3NF
 E4kG9HBrnIOfTRG2VBBjSolhFaCX5CzvuLkCgDeiVvnw1inTpX7eIDjv4BXu16i0A+Zy1wUUR/K
 X6akWYZAtyTfl+xgJdYtA8x14vCu+OAYyMvufdMRhz+MaI5o5mee+rZAQFH2PFMVvLhuY1/WK0/
 BIlfFjs9hgfwNNI3J1neufmy8w3mVeNB4OWRREstt93ZxDIGQYZ6FAmx1s8Ry8lt2YA==
X-Google-Smtp-Source: AGHT+IGWE/XjyQozgv+wQxz+otjx+/rcJ086sYNAiPBm+3EV8qZPZKSYwtIDkYJM3EgXxI8tHScDlw==
X-Received: by 2002:a05:6000:1789:b0:3fe:34ec:2fab with SMTP id
 ffacd0b85a97d-405cb3e61a9mr3996306f8f.63.1758686717909; 
 Tue, 23 Sep 2025 21:05:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fcdbc4374csm11816889f8f.13.2025.09.23.21.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 21:05:16 -0700 (PDT)
Message-ID: <6691efc6-d79e-46c6-8b83-924a9a5940a3@linaro.org>
Date: Wed, 24 Sep 2025 06:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/arm: Move ID register field defs to
 cpu-features.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250923175751.966795-1-peter.maydell@linaro.org>
 <20250923175751.966795-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923175751.966795-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 23/9/25 19:57, Peter Maydell wrote:
> Currently we define constants for the ID register fields in cpu.h.
> This means they're defined for a lot more code in QEMU than actually
> needs them.  Move them to cpu-features.h, which is where we define
> the feature functions that test fields in these registers.
> 
> There's only one place where we need to use some of these macro
> definitions that we weren't already including cpu-features.h:
> linux-user/arm/target_proc.h.  Otherwise this patch is a pure
> movement of code from one file to the other.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/arm/target_proc.h |   2 +
>   target/arm/cpu-features.h    | 410 +++++++++++++++++++++++++++++++++++
>   target/arm/cpu.h             | 410 -----------------------------------
>   3 files changed, 412 insertions(+), 410 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


