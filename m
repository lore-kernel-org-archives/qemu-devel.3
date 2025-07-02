Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BFAC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 20:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX43f-00036j-Ck; Wed, 02 Jul 2025 16:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX43b-000351-E0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:27:51 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX43T-00086p-Rv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 16:27:50 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b31e0ead80eso6138894a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751488062; x=1752092862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GvyLcMF2pdpLcoiU+/fJUoWq97drUNIku5nRq1GSBec=;
 b=xm9gFrZx/cRocykeOD9Frh7bxTXe1pMrGo+BGVDDhktKMDTtNdLfzptvENbJskEgdn
 TPSoQkL7sIODefT97+sOC5t8TzCdBgIj7t+ypacIDsPwvLg7swK0Sy4Ir8vrkU4UWDKV
 l5RpFTDWT1gSvqFEwzY0R9HfeiAhviQZlmI2MAH4qCsauY+ODzWVQvpI6sG57w1AUKC6
 m22lHR6oo/otPV0w0sLz0PhUC5R9CMHLWS3NromPm/JWpI02u5Wyp71KFL+7YpZ4gu2G
 ISBvTxZRPb0b18ESah8tY/fUmkwjILzycFXBhju6HbTTsUtwcGI4672gs2hjObLvzFL+
 A0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751488062; x=1752092862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GvyLcMF2pdpLcoiU+/fJUoWq97drUNIku5nRq1GSBec=;
 b=pVad028f28LD528nSi5e/DOeU4vETE7cg0Qk8CLLndA8yrM3FflwX7IM942UIr8A1W
 2WP4ilAGSxEemGS7rp/ZzTiMGmfF2BLNqTx9xOCY8rOAnMJDyMMU0hyKIWBEu+ykmcGC
 1OW6to6na4WdnPhd4BYbjrS++TjSfyAEwV3BmsTMby8HtU3gv3j/HBHWXYvHa+n9xttV
 T9LTSFjB9Zx7aAzJBPbNHWjt4DnI5vMR21U66ok6saKfVrpsiG9IExv7M1brumx2uQlQ
 juEgfgaffV3O2SigZ3XZyXnuGUS7KiPoPh4Z04E6uGP7z3OsUtmbx86IgtGfqPD6wKYq
 yjqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHuPJHaBH5i28Y7Q8zhyukAMV6NSbtG2WgkcE6jic4CQzcASXLu6+tritTq/PVYBqjIlCyUSENHdXQ@nongnu.org
X-Gm-Message-State: AOJu0YyVmbY/sfZJyS5fFHKsFq3E9y4umbaiZM8LslkC1D+BXkKqdp2p
 mwvJkqeEJfm+9AZ4o7de06AksIM8No1EYH2lOKDmrGQet7fuqs/1QXhRzTLHbuB3sv4=
X-Gm-Gg: ASbGncuucXWfTUVA8yt9czv1S6M6woEbWTGhr8+76n125CEuSVNDWA4fyZp6Hce8VCN
 mA0xTpbgWp1d258g0wTUVu0c+MmiyIHnHb7VsrawdNsDirrz2sMMe/Pg9dqQpnJVWiul33Wy5NT
 byvC/sAZzePDgPey+1E59lioN3rIietStDTubpmZIUemuujf51Wubgxyz125aBoA5kQ/WQ31HBz
 G4swMeqiOHxdsVTTR94Pd5L3e28PSdYXOU1dBjVDtL/AHSd0/jEM0Je4q72ypMVk5d4xnJqqMix
 /RAHCxYFw7y11HSII7OZ+GkADlIXjm+EJ5OgppxEnR2uDmGzJhHQ8A00gc2uK4jU401N3cJDTwQ
 =
X-Google-Smtp-Source: AGHT+IESBtPS5cRvfhL3UNNXGksdFRmLP4L9rBckVv5QFQ+CkHuKAHV58nmuvlWgxUVq2Avum1PjIw==
X-Received: by 2002:a05:6a21:32a4:b0:21f:50d9:dde with SMTP id
 adf61e73a8af0-222d7dcf414mr6035641637.5.1751488062039; 
 Wed, 02 Jul 2025 13:27:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af54099besm15055778b3a.9.2025.07.02.13.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 13:27:41 -0700 (PDT)
Message-ID: <0a6c0d23-7224-46ca-96aa-8f90f3047d41@linaro.org>
Date: Wed, 2 Jul 2025 13:27:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/65] accel/system: Add 'info accel' on human monitor
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-25-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/2/25 11:52 AM, Philippe Mathieu-Daudé wrote:
> 'info accel' dispatches to the AccelOpsClass::get_stats()
> and get_vcpu_stats() handlers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/accel-system.c |  8 ++++++++
>   hmp-commands-info.hx | 12 ++++++++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


