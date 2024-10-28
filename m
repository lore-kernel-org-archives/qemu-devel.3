Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC1AD5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRP-0001UK-DA; Tue, 29 Oct 2024 02:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR7-0001NJ-4k
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR4-00077v-9O
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d5aedd177so3407615f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182233; x=1730787033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bf5ZJ3Rp+VOlHHfOfTZRYW4Yd6YXxuqv3Ec4k+/mD8E=;
 b=Z118vFso4k0aTNUIb+8UdMhmVasI7avmj26Qy8WV+hb5P+KBeRZXyhLchD9Kz7cVuR
 h9FJRVsmKVgTBnVSKzNBdLvopRmTobaXBZr0XE20hv9aN5lL4LMwNQ1zXQX27O4HNxuB
 fflcByqyrmF2zXOvQwfFJTssyHGbE297CAWWH64Oxa8lGcD+dndpKndVOb5na4nrCuqK
 3wg9s7NI+w6OQbcIGamjO4SK2lI6SNXasBRny9xDJ/VtejbIdT+/MreC6ES4qTILxPEU
 PRDsLAA2MZrAXdOo3+4m4xypMnu+3qS32NcBuvd34CeGk3jwTzFLhoDQ+tBaDFDHPQZu
 TfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182233; x=1730787033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf5ZJ3Rp+VOlHHfOfTZRYW4Yd6YXxuqv3Ec4k+/mD8E=;
 b=mX7YtB6eJDzFN/DuU+nXb76o3PMyfC4pYk7k1iKesJTHSoKIiQ3AVX7MMt6wGy4HI7
 w5ITUaTgtwvQ5IV3BS/bf6f2tSflIzc1c+an5zQbIpYzAZo/Z0TtnuTbIVRDjmV3Rgg2
 TbnzcuukIbvSjTM605Gqxz1UNWncl9IjRB5m3cmHOwGGld18Dmj6zc+HVVXYoRM2QbqT
 njsNbkc9PpexXdi7Kxwa2iZJpH9oSSSzTFVl68IQkRDGG2JhzmoE2FFR26nKA1h7nwx4
 z31hZgCUi3xdHyfdcUKKnWVD+xlp8xZrnqPo+EauzbTRQmlHDdtrQB1lFg+NCfIPzRkP
 Ddxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZUnUXD0oK0Hn5uMUZ1w1a1STmypkzuheq6JZmaNZGemvhv9APpR57jlNe2pkmGFLrmrIGnMN6eHCW@nongnu.org
X-Gm-Message-State: AOJu0YyrahW/4LK1m4Ujy7J2ManQfQZEk5MVy5wsWGTbp212pdmtAQsu
 AHWVnTkUKm8SN1gctDzQ8A49cQuBw+SBtKUrtr753kYzaidRmAkruNRnD1eUrjk3wT2pRyOTg0N
 8W6A=
X-Google-Smtp-Source: AGHT+IE6EMsJxEdWnnfT7Idx5LZBPzeC4kC3+wlPdecDqtFP2Y8d3f6Y5zcXCquHa5T+I9f0jiPsiA==
X-Received: by 2002:a5d:43c7:0:b0:377:683f:617c with SMTP id
 ffacd0b85a97d-38061158bffmr8279413f8f.23.1730182232865; 
 Mon, 28 Oct 2024 23:10:32 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70bc1sm11560253f8f.70.2024.10.28.23.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:32 -0700 (PDT)
Message-ID: <5b757e15-a92b-424f-96fe-c90900839592@linaro.org>
Date: Mon, 28 Oct 2024 12:13:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] target/loongarch: Explicitly set 2-NaN propagation
 rule
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
 <20241025141254.2141506-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-6-peter.maydell@linaro.org>
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
> Set the 2-NaN propagation rule explicitly in the float_status word we
> use.
> 
> (There are a couple of places in fpu_helper.c where we create a
> dummy float_status word with "float_status *s = { };", but these
> are only used for calling float*_is_quiet_nan() so it doesn't
> matter that we don't set a 2-NaN propagation rule there.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/loongarch/tcg/fpu_helper.c | 1 +
>   fpu/softfloat-specialize.c.inc    | 6 +++---
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

