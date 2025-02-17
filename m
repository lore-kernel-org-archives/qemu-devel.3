Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A81C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwHH-0000cx-Fv; Mon, 17 Feb 2025 03:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwH0-0000SC-DE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:14:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwGy-0000ar-Md
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:14:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4395f81db4dso23547115e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739780074; x=1740384874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZhlGsYuMgjD905PSy+ffzVMYWr2+16240UeI40EuBfc=;
 b=WqWimk1JQ9h57q8LZwwtPp5T1W2LvRqDgFrZ41utG8qaPKU4yIAIT2/5vlOQ50fi8L
 oWVFGGP++vVJ6Wx6lwg2/1zDiJRZL197ZNonk7sFnnsBdiTHteqR4Hottal/RtD/XJnZ
 Y3PIxyJ8jLa7GZRfa9mpc/tWkFaC4vOyszUaJO7tXsGzL3R+K3jKqHTOvU/E4hzE5byx
 UzNQrtWF4iFT791sizR6aetsu2RIF/enu4q62wnYfJREq6gJsWFpUsXIfNcf0r2vKqcX
 DQFZFKUEyS+6c43Mh4D2mSeKGoShIOG9zHtL6ZbPHBO99PuqEzH9OX2sOu6w2/+IaRVi
 AWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780074; x=1740384874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhlGsYuMgjD905PSy+ffzVMYWr2+16240UeI40EuBfc=;
 b=kUX6PBsrIDUzXwMDDRiUYEcYGSCVUlRhZ5Z1b0iOtZ8HWPbxzaRq9yRqVql1GqcofP
 fXhhrA69rztqMwc+H3qGccPlo/Y9MZnJfe0NDPg07y6jONSykqsBgk5HtCwmr3FE8MPd
 BEY7CvibOutp8+iJIqOmajrd6tqHJMiI4hHeR4/gaJi+XUHFRWfRrlNhw2rAyuBFYu2f
 Gciqav1MUdlG8xumgX6eBc/v6huX+AqpCcX949S8X+Ubv8Ou4JBz01t4us8zevER7LrX
 PmllxqOkHVKw+hNZPBfz+eiJvVQTOy3e7JxWwqyO2S6Cla3Tnq6Y1nJBxoJ9Z9PeogfC
 AsYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVpVt1t1g0H9z4WpWvyC+oOXhBraiUAODpLfXvnHOfBs9NpzVG4ghv/5fchoRNlFv0ltloW0fBVA0n@nongnu.org
X-Gm-Message-State: AOJu0YxddBJ6ec5SX+Zd7tCulYQUG6ELH6ReMdIqbQjLiVlzKw4EnBCr
 2KuaKE50qKrEajh11mjDXtXcrn6VoGme3/TokbPKoCZySp+cH/Z3jq35/G3bI68=
X-Gm-Gg: ASbGnctUz9jfx14xnPSAfDXJdnvmsLI6t5JfpwCLbadmaZPPRY4pQ9mcWL3fhz4JGCR
 fFwMns6ANtb0MI2FAZzvZZgEML9mFDmEeXNOMWC4iP2qrNgGEE4YvwT+brFPoRs/zai7MALWCib
 d+42GWMYWnADZx8au5ldviGLXRkM0/R5mJvsdlBx4/IYwZjlMRyKwlJg6wF4im/qqZZFBkQwxaO
 CBD60UNOy+uN4e4s97JvWTATIONeABamhhRfGLssUZl5Cbv9vbED0TTPpaHJTJjAudvVCy85hb+
 SCYqn2mxtZNheCY8veVwpWP+eZ4fGw==
X-Google-Smtp-Source: AGHT+IHpAzqS2KSKQVcyP+qTxeg399kwrGiJOCPczNdEJ14pw0jLpVbBsMRjdDxCzevX2pIKhjWvAg==
X-Received: by 2002:a05:600c:1c07:b0:438:e2ce:92d2 with SMTP id
 5b1f17b1804b1-4396ec26e2cmr73898565e9.4.1739780074376; 
 Mon, 17 Feb 2025 00:14:34 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b8397sm145007155e9.36.2025.02.17.00.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:14:33 -0800 (PST)
Message-ID: <ee46f1cc-e3a9-486c-9fcb-6d6d66c8cefd@linaro.org>
Date: Mon, 17 Feb 2025 09:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 102/162] tcg: Merge INDEX_op_deposit_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-103-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-103-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/2/25 00:09, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 3 +--
>   tcg/optimize.c           | 2 +-
>   tcg/tcg-op.c             | 8 ++++----
>   tcg/tcg.c                | 9 +++------
>   tcg/tci.c                | 6 ++----
>   docs/devel/tcg-ops.rst   | 6 ++++--
>   tcg/tci/tcg-target.c.inc | 2 +-
>   7 files changed, 16 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


