Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5564EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZCL-0002OS-If; Fri, 23 Feb 2024 12:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYuM-0006To-Fq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:00:22 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYuK-0004uH-Ow
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:00:22 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d2533089f6so11302561fa.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708707619; x=1709312419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjjoirrMxnh4yMzTkZ/szcOQkV/WVwXLs4TG8QKAN28=;
 b=jsNbsrGZTJsy038DncK+qLK3OIAAXlwcemofk01R5S6b938vot1CR5kTMK4K1w3ZmE
 Lu3E5q4rMQwd1EBSlylr365tq87ES7wew/FNTVtLvvneZsJc+LCgRORCaLRK8noBukhF
 6OuEFNjitRLXjhLBJqw1CvODCjNpyADJJFAXXq3LCzYMS7hkdElNPZkY9WVITrKzvhzi
 4iH70uq+W/e0TDJXdiNNwSBw4zNfPNexqBCxvb8Si3L0FRSqOMNE2OWLwPY6BNpGmTzB
 NMky/P54n2TzSmMSyXzw9VcDckaENKTSDU0t198SJ0WOgBkmtJQxrAd/7bVU0LFSNLMn
 qgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707619; x=1709312419;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mjjoirrMxnh4yMzTkZ/szcOQkV/WVwXLs4TG8QKAN28=;
 b=U4UYV5VNyQtcbPxXVmKnWffWjH48/nTR4U3Tlef/wRklm/znjFS3WWU7N00yj0o/3L
 i1FvHu3f6H/KQq8+gHph0wYHk0R7B0ax9yQ6e7YujfZk4ogyDWzFCHDqT9stMO/KmjvF
 lYfYUp7jfeyDP/+HPnWJLvKxARjA5+h6gPV8eQUUzXO/NqAkd3deIAJGiFOuk+vXxkn3
 r0rsGZtRmRAk1p1LTXV9WgllpXmdO6HD+q8a0Tr2Mc8fxuaTA44bv7J87KdabdV9g+O/
 1HwW/3uH6KE2jryiI1ngpjg92czTxtwv7TXVB4i9tVEuNN89XRiaJJyvByHVHMfMFZqB
 QlGg==
X-Gm-Message-State: AOJu0YxDT7ZSfPIob+Kz4KycfO7m7nv/5P2ORU819OD3vdosUGQtTr9w
 TMslj8g1F7tQnrse4bo3nQxEiOtA5jED2BqXxmZnVwLDgflSQ/MdV2sSUxO3CDI=
X-Google-Smtp-Source: AGHT+IG7NjkbcQxQ+9Xw72lAeuS5MYHUaszKOUOdKc539mXnA51zjHsHb5djxyQNrWHpX39Upn9fAQ==
X-Received: by 2002:a2e:99d5:0:b0:2d2:2948:afb with SMTP id
 l21-20020a2e99d5000000b002d229480afbmr258588ljj.24.1708707618767; 
 Fri, 23 Feb 2024 09:00:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hi17-20020a05600c535100b0041290251dc2sm2844000wmb.14.2024.02.23.09.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 09:00:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B5ADE5F79A;
 Fri, 23 Feb 2024 17:00:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Artyom Tarasenko <atar4qemu@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Markus
 Armbruster
 <armbru@redhat.com>,  Eduardo Habkost <ehabkost@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
In-Reply-To: <8734tj87js.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Fri, 23 Feb 2024 16:33:11 +0000")
References: <20240223161300.938542-1-peter.maydell@linaro.org>
 <8734tj87js.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 23 Feb 2024 17:00:17 +0000
Message-ID: <87wmqv6rq6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
>> was unfortunately added with a license of GPL-v3-or-later, which is
>> not compatible with other QEMU code which has a GPL-v2-only license.
>>
>> Relicense the code in the .c and the .h file to GPL-v2-or-later,
>> to make it compatible with the rest of QEMU.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Or a

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

if you prefer.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

