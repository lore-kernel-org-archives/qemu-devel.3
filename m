Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699D2D5B84C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRZ-0001fd-Ko; Tue, 29 Oct 2024 02:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRV-0001a4-13
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRS-0007F3-Dl
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso51213185e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182257; x=1730787057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vs7nasybbX7ls6pt1vDzRGbzY5szh6TT52y5XwKAnFk=;
 b=qFEwmeC3ES0ej9rQ1K6U1nf8lnxb+XYjlraeBx23238VrkUcqy/Rnyr3bED1N7aeXS
 4PUv+l0TtjWv6/Z8485vXJk9+y17bUgYfXqekLWZ0OCv1pohBzuvbug+gZosAUi97ZWB
 FENtvCfpm7lc3/QPK+4MNuQ58PLRuJKbEoc19C79f1rGoKKJjcK8NGpJz9l+P9fWjJHv
 vnZ3IVvp96rhiZ6RmYufyfuUMnxmuraFf8gE3f+Ow0GanqkM39besllf4SPvwjbSJC1n
 P3fnj6QYdKMXwOdWMqCaFGXDhQYfa2KzNod+taBUqkcqQNg003o7/9gK6gdKad72r3u0
 ex+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182257; x=1730787057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vs7nasybbX7ls6pt1vDzRGbzY5szh6TT52y5XwKAnFk=;
 b=U5Lly7P5JLlEKgdWpXKEWnx98B/qQHRF3pM9pYt4vWYHZBZdLQcvhd1FnhYDkhCCTN
 1W+i5Z27u7af2vEPcQQJMFLwLgYyC1SeX8TcpGrhGjWfxxrgpPb+kgbEdrqbem3D4P59
 AivF4+9Hp7OzsREDmK0LGRGTZ1dydy4qXT+G3g2+Pe3AoS42XsSyxB3F2LLvd/+TN4+i
 Ws03eh8iyNOz3J4+DRfMJMNc9fU8qGhEeSssgTDHTuepERIXdCJ7Xzomrn+Ihku0wmy1
 Zj2YASygFjqB4ONVHfzJkPIIX8EjJbRCiDtj8brS7RAyg/MXi47BHctVZfPHTPi4/xJg
 hIIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUomIaS+Qzqqn41PRbzZGP3BugBHYiPw75cVzpvaOYTL2jxtehV7qP6+ec0CRRi9Rq+VvDpZYxu3i06@nongnu.org
X-Gm-Message-State: AOJu0YwGquWD+DIh8lwPHAg5ucOyWu2Qy5Fmi1hCTybyMCpCjxZ0RI/V
 45qcEAkQz/5nqdJvZc31LM3ufQOGHxj8z7r3Emv31QQ5ZXGLezpFEc424kpb2/I=
X-Google-Smtp-Source: AGHT+IF//bT0LVXj2kSSkPbfeR4r1Hvob0c7rviyW7x51yDzFgNZrfk2lCsSnPc3y2bKfJaP94qSBA==
X-Received: by 2002:a05:600c:458f:b0:42b:a7c7:5667 with SMTP id
 5b1f17b1804b1-4319ad02659mr89169725e9.25.1730182256877; 
 Mon, 28 Oct 2024 23:10:56 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431b45aa058sm12150405e9.1.2024.10.28.23.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:56 -0700 (PDT)
Message-ID: <e38214df-2ef9-4bc7-8f23-a29c0b01913f@linaro.org>
Date: Mon, 28 Oct 2024 12:21:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] target/xtensa: Factor out calls to
 set_use_first_nan()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-14-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> In xtensa we currently call set_use_first_nan() in a lot of
> places where we want to switch the NaN-propagation handling.
> We're about to change the softfloat API we use to do that,
> so start by factoring all the calls out into a single
> xtensa_use_first_nan() function.
> 
> The bulk of this change was done with
>   sed -i -e 's/set_use_first_nan(\([^,]*\),[^)]*)/xtensa_use_first_nan(env, \1)/'  target/xtensa/fpu_helper.c
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/xtensa/cpu.h        |  6 ++++++
>   target/xtensa/cpu.c        |  2 +-
>   target/xtensa/fpu_helper.c | 33 +++++++++++++++++++--------------
>   3 files changed, 26 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

