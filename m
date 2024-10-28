Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5EAD5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRc-0001hi-MC; Tue, 29 Oct 2024 02:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRa-0001gJ-A1
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRY-0007HU-UY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d63a79bb6so3587649f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182263; x=1730787063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tw0DcjFPqeWV6b0ZQwg1a/UUMvz8Gie9VHVdzuTQErg=;
 b=L7UkSaLARoCqZ3xydhY8AZev6d0zmItEuFnqA4QQn0tLU8n+cz2flvmTnEdK1XSSfC
 z17ZUTMw8ipqC1dqRg06Vjvxrr+cjD89nXbgzgkJR3X6fOew9W9zc+E+S3jbCs52Tq4A
 AfR9cuFlI9MiJlvRzlYo1ZXnbB88x1iIHouAbI5d0UWdP+lT7puddccdHLTh1RQDmAvN
 GY9zmMazUrjEc59aYb3Qj4JOPUafT6TzUrUZdutk2w1DPQ3dcevCugtW7U8XHYIRqUeW
 difNOsRRSnFF2vF8IQg/fuNjWjQtkbifAdtqvAlAEiI89DTokJKKfGDACVjdF0CZOlDF
 tEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182263; x=1730787063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tw0DcjFPqeWV6b0ZQwg1a/UUMvz8Gie9VHVdzuTQErg=;
 b=PtanChi5pus09mvxXnQrVPjOODuOC04leStEv6FcdqHew+kczFag5bcvnarArkks8D
 vrIh866oyKK9IdDFmM168nBuNx+OXy4qKy7TA3wZKBwPAknq1RB0ga0DW0ERchZWmOsq
 6eP8xtX7dZaYYIxpb40RhOZCGpCIulZFvQiGf+amYkHbqyYL8luG8tyUEiXPUbtE5NH0
 Vu+p8pd7+7aMIxiqz0gauJYimeluHrEJpmkB51XT0R67nWsppTX6Y3PpTLC3t1H4Bfsq
 Z1k1C3988j3Ews714O7b2PNxf+maojBH4OpiCnHb7SScEwXpIRqgEqVcbKkJAnjPZ/Xq
 kpFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq8XOtJcVSIq9/1I6aqW6qJbUtND7k09ShxQvhVr7/R47I9t3PsBiAPU++pWUptavlb3mj9KmA6KKf@nongnu.org
X-Gm-Message-State: AOJu0YyVnUVFZ8LfqaDxTR12RWkbJPl3Uy/wYVshLyGYckhHl6XfU9yT
 6VnKiNfYWTd+m5eSu9i6wkKbmXLLpE/cJuftcXPm8Z0rE2vX/h8ibcvfHWkn5SA=
X-Google-Smtp-Source: AGHT+IHEIBaUPLujZoLe+2YmxHoZVxCs/XDKvKfCjBQAN/BRxNhY2YNAl35PmlHRF6naiPETtr7nQw==
X-Received: by 2002:adf:f411:0:b0:37d:4e59:549a with SMTP id
 ffacd0b85a97d-380611418abmr7798213f8f.16.1730182263481; 
 Mon, 28 Oct 2024 23:11:03 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431b45aa058sm12150405e9.1.2024.10.28.23.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:11:02 -0700 (PDT)
Message-ID: <55df000a-d9b2-4097-af91-746f4000c21a@linaro.org>
Date: Mon, 28 Oct 2024 12:24:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] target/i386: Set 2-NaN propagation rule explicitly
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
 <20241025141254.2141506-16-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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
> Set the NaN propagation rule explicitly for the float_status words
> used in the x86 target.
> 
> This is a no-behaviour-change commit, so we retain the existing
> behaviour of using the x87-style "prefer QNaN over SNaN, then prefer
> the NaN with the larger significand" for MMX and SSE.  This is
> however not the documented hardware behaviour, so we leave a TODO
> note about what we should be doing instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/i386/cpu.h              |  3 +++
>   target/i386/cpu.c              |  4 ++++
>   target/i386/tcg/fpu_helper.c   | 40 ++++++++++++++++++++++++++++++++++
>   fpu/softfloat-specialize.c.inc |  3 ++-
>   4 files changed, 49 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

