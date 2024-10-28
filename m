Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40574D5B84C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRT-0001ZR-Va; Tue, 29 Oct 2024 02:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRQ-0001W1-PB
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRO-0007Br-CI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so4409701f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182245; x=1730787045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTbswlSQFh+U2AURAZypMjlWl7wz00C7z2XO17y4wQI=;
 b=ESSJDhJi9S4tnBuddhdzUjvM0ttp00ifFmGQF2ys/ifHGV64Lyvl21UNdiBF6xxzZo
 TPVq9e0q1zGyZ9u/qkmF3qORamee8O0B5lKuXF6Ko38L7B6fWP5wPkqADgX76BpxiNBv
 l7BGLLxshENqdlg/L/EhOOZiXDmOxOgi3BKFCMHUiTAy/7vP43ZUo4aq9Y1vv1BtAV2i
 ElYiy+tv6z3qmJIIdKeRLZGr/UJ76GihPekuHGso5shxyJgDC+jxrWAzyMdybTMhZBJt
 1QFpDFcCCyKEq33KCe7JqSNwhScxnsmX64nIAcfXpegkrxB8hLZovDb/HiqsukoTnrMK
 gRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182245; x=1730787045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pTbswlSQFh+U2AURAZypMjlWl7wz00C7z2XO17y4wQI=;
 b=kMJG+w7pgVW++QqYRIQmbiS7Vgl/yZ64mRonXXx2bffmm277UVsBD8Wu3a1SIKEA22
 2QFSk51KZyRkb4OSyVZw11guuydZpvGGnBM4UslKSmSLbQCZpLq31jT4EGoMel1hGFob
 qR/ku1lbwqI8VGSE1AsoCwbm1qpZ0vaTSbCTcdWpN9awla8rtuptp2MYvVgTpB+Cys6T
 JH8S+n4bjLA0UOUzbeD/bHfcRcLVpx/4whVeoI6/wFyqzeyiENx8jj0TY538GiWqU010
 r6TWtkM832HqwLa4SJhGlBiaNlIELbP6TnPllTYgZRCcBkfkAHHg1IYzu86te0gOFkxj
 uoFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFACNQ+KAU6zFZfKkNd7xytOC55cK34A49epU7v5l0hGZFaL6N+g4Uw4Hq7pi0Rou2b/01CThSfWuY@nongnu.org
X-Gm-Message-State: AOJu0YyrVSNLtmqdZb0GhM6mIEiqdGWs4s52LjJgfcx/5kLqZ6iwbym2
 zAaIK+cPWDmUy/z53HU4UBcudrg5T5DYVzgf6kGeLevwbyd4HjLg56ClxX1RKfQ=
X-Google-Smtp-Source: AGHT+IH9e9XRp6y+3x71gAkSy8Jn7oqtD9EJ4sg+Lxm+8+GQfFl/L8u2D5umxmh3JQRYkVlpOrtwPQ==
X-Received: by 2002:adf:ed88:0:b0:37d:460d:2d07 with SMTP id
 ffacd0b85a97d-38159d75937mr607201f8f.10.1730182244958; 
 Mon, 28 Oct 2024 23:10:44 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f5e1sm165298915e9.14.2024.10.28.23.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:44 -0700 (PDT)
Message-ID: <631ea605-f89e-428b-aba0-93e3895f2ddb@linaro.org>
Date: Mon, 28 Oct 2024 12:18:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] target/m68k: Explicitly set 2-NaN propagation rule
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
 <20241025141254.2141506-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
> Explicitly set the 2-NaN propagation rule on env->fp_status
> and on the temporary fp_status that we use in frem (since
> we pass that to a division operation function).
> ---
>   target/m68k/cpu.c              | 16 ++++++++++++++++
>   target/m68k/fpu_helper.c       |  1 +
>   fpu/softfloat-specialize.c.inc | 19 +------------------
>   3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

