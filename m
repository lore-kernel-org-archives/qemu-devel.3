Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D2D5B84C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRQ-0001W0-RR; Tue, 29 Oct 2024 02:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRF-0001Q9-90
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRB-0007AG-21
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so4488840f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182239; x=1730787039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VwVAuBf8U+gHdAUZVPEbAcLW9jc18uU0VthPzBGJ82k=;
 b=iGimA/hX6MCsdRN9RM1kAK1dnIOAA7ztZehAAu2tXi0O0Kwpf3fWj0eyuu2lfkqHmf
 twE9CqPM8JnFlbg7teJwQeECLiGkxK8rYeLDgy3PwbhlOutacURZtwvcohkLaqm4iu8c
 A8ji3tekItJK5pnBzLqXW4FzVtjMI6qq/OIXVlOAQV8EoPp07/48xSO9mhwBI4G9SQHD
 iA+GFdwNMNG/YGABuSq9++Uhx6d26ko/vGj2LH5P8UXpv88fyr+7f4mrsF1E+cM+lpsZ
 DqlSOHmzYWf0d/PVo/QOSTCfOoLNMFmLoXlNjl2mCa3PyAu+f0vllPYGfxTaXebFDVlN
 qzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182239; x=1730787039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VwVAuBf8U+gHdAUZVPEbAcLW9jc18uU0VthPzBGJ82k=;
 b=cT0XchPFAaMW/FfcdTyAMaRWfdoBEuGA3xWqLiDhWAMTKt0mbi+ifykdHZ/DjRRQkj
 0ti0t4NS+S4BDDe5vhsnGUO8deVuqAplTSYwMmfPovoBy3xQCaNKxc3qlGxWIB4JhrW9
 AY2G7tNxWZkdKJXHxQV0aFNwtBUUlZANdJtYoxyl4ZwNt5wBbaGBsSb1KNzAZqZj2ya7
 K5CkFOpFqa/7hPvEENzZYFyOIO/8U13K5SJaZN5goRkT9GHwS4cCl1FxGUVYFJRBVsKf
 tnhX9MAN7cbwaGmp3OotyLN5IlH3yejep4p/i/3D2z9SBskTVTAIK3UzZ0fVXZbtdaO1
 6dsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW934taFc3TdJQKbX/CO4mKfrCT9W/kK7wEvRW9sI9AUke+QDaIjmQWqSeLDb2S+Gne59t/HRgqPJ6P@nongnu.org
X-Gm-Message-State: AOJu0YwLgXG3RxLJlNn46M56SMVyv/529Zz5jo5RiRbq2BUsMyQLmq6I
 PlK2p82ym5/chCnY6pMUUOihx6/E/3CpudJCRVn/mfO2dX3mRHPxOr1QVRiJzPk=
X-Google-Smtp-Source: AGHT+IHyoNMpwWyaBAd5buO+1ZpTcIcOE1Ut2ytCRwDQwzvns7/Up3tAdU+mu5lbCC5HdOlahNc/CA==
X-Received: by 2002:a5d:4a43:0:b0:37d:5318:bf0a with SMTP id
 ffacd0b85a97d-380611416e1mr9671606f8f.1.1730182239347; 
 Mon, 28 Oct 2024 23:10:39 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70bc1sm11560253f8f.70.2024.10.28.23.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:38 -0700 (PDT)
Message-ID: <dc7c4578-aa3d-49ac-b9e9-16922e3def97@linaro.org>
Date: Mon, 28 Oct 2024 12:15:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] target/s390x: Explicitly set 2-NaN propagation rule
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
 <20241025141254.2141506-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
> Set the 2-NaN propagation rule explicitly in env->fpu_status.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/s390x/cpu.c             | 1 +
>   fpu/softfloat-specialize.c.inc | 5 ++---
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

