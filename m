Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537E1C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyX7-0002tY-PW; Wed, 02 Jul 2025 10:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyWu-0002ky-Cs
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:33:45 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyWp-0003co-23
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:33:44 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-735b2699d5dso2245117a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751466815; x=1752071615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ScdsNivRgUJVL8aETXlbY7gbdCYxjqOKnFqplopzhGo=;
 b=SlOOb3U/hiw9IsxzvQrSa7OtAXHXmOzYvHh3M7UDiSYaCtB+V48UlPLNWqfRSGKsPt
 03/ePtyLX5M6Emrtd3kUIWUKJ+mpZEXc5bluYy6dml6/s64NsEkatsq5XM4Nf+BI0y4v
 plCiuoMcJE00vEF2nmXzjGcjBY1l84o93WQyO7CQXm3XlAeekVwR8ac44jCq1KzUK2oK
 1TL3ilAsk58VRZLtaM9WoSMmT/Dv8fU4r6f1yHpqAEQ3GvZTN3qQ7rXBEjuTq4A1OZfY
 rm4A7bPt+kOGzOWpPbGefCTQT4QCT+B3SpIVIP589uOZL0/UqoDI6lqH1eaJdtMaEgdt
 ql9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751466815; x=1752071615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ScdsNivRgUJVL8aETXlbY7gbdCYxjqOKnFqplopzhGo=;
 b=D+9RjLVFgYUvG8ZIzoqxvBB8lf6JVjjplL7SdERgTZ+CW1k72YQxkTSO1/G9w708uK
 T+5Mv3LfeyahWkSNwy0XIkecVMmOnT+LRxYVljHB1HJR/m8E0170RAFHGvslkBfcp7Xx
 Ae1bJf5N0RkJU9LNvGA0m2OYnG+GFFNTfuwy5MhcJrARVwP1CtmtXY/OS8tKHPzcyAKR
 RT3tdoXkj1LOhPLTqfiZlvEpwb34D2pH9a0YnULyE4+c6eOLHFIaWAUIZ/tbgcMzvpvr
 1LtH8vCc10p9XMb8PabPrQuTy/4C0axYMmU9Tv7bj9AZVYaMyCJTOxiShQCS/xMjki//
 YK2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDDCXjH0SAnS/2ukdbc6yp+zibbLodt1RKo9OBOX8LsRiKbSATFoaAh+M7xY7IJOapNzATvuZ9dap3@nongnu.org
X-Gm-Message-State: AOJu0Yy1A7HRfcfrFWrGi8FUqpRYNSaK6IIkvP46yquuo+HQSieRQsqU
 Bh3EiV5RGUdAnDjSvC1o/lmqiPmJBsyMlDQk9OqYXyV9hnFFSSs/EUXW+sGrpzZ/zqc=
X-Gm-Gg: ASbGncvTPahFqc4YAuy4hNU3WqGyZ2MwR8uJqJAAX+e9RV7LNk+hIqO6oOH4F43Xx+x
 hqnYCqTlvnL/EDoQsNJTqqdVrqQ9FoVihI0qtOepQf0w8ltR2qKCzQtMBVh4pZLxxRdDKIK/W8I
 mod0Ks3p2Qwk04mQxebPHTcXBPXjEUgtRFcOAq0FqILKO9CiI/ubp9s4KvT29ujxg8l7OikgJPx
 4k/5aIwUxkSHA0Y7rzYNb3DipUlRMt3BRHdtDGGHuZHus3d13HlgfpvcGJ2BhKdRSRaIg7bjdm1
 Pwm7qJ7DM3n9RY9cqonCY3FFYhw+a7ZG69T105p/4kwcmpdtpvE58ZYA/eKXgibkUmfBHzgXLLK
 V
X-Google-Smtp-Source: AGHT+IGN/T0Av+6QpUiNuyAkzcWr9+EFwJIKcZzGRzMgAPJVQo/4CO3aR8bv6/pffLIju/sxXi6VtQ==
X-Received: by 2002:a05:6830:61c6:b0:72a:1494:481e with SMTP id
 46e09a7af769-73b4c610910mr2160238a34.0.1751466815441; 
 Wed, 02 Jul 2025 07:33:35 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff24a6sm2481405a34.5.2025.07.02.07.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:33:35 -0700 (PDT)
Message-ID: <da40584a-990e-4965-8d22-9a9489571a30@linaro.org>
Date: Wed, 2 Jul 2025 08:33:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] target/arm: Bring VLSTM/VLLDM helper store/load
 closer to the ARM pseudocode
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-2-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-2-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch brings the VLSTM and VLLDM helper functions closer to the ARM
> pseudocode by adding MO_ALIGN to the MemOpIdx of the associated store
> (`cpu_stl_mmu`) operations and load (`cpu_ldl_mmu`) operations.
> 
> Note that this is not a bug fix: an 8-byte alignment check already exists
> and remains in place, enforcing stricter alignment than the 4 bytes
> requirement in the individual loads and stores. This change merely makes the
> helper implementations closer to the ARM pseudocode.
> 
> That said, as a side effect, the MMU index is now resolved once instead of
> on every `cpu_*_data_ra` call, reducing redundant lookups
> 
> Signed-off-by: William Kosasih<kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/m_helper.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

