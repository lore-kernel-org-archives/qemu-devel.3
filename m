Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F9CC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiHF4-00063V-I8; Wed, 12 Feb 2025 13:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHF0-0005wU-5o
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:13:44 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHEx-0003Yp-4o
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:13:40 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so102282a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739384017; x=1739988817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZPKopdvza2VT9Y8grw887YcnJBeY3KUR/JqqskRF/E=;
 b=v13HOa3FhQt0uGpG5SD9dAIUb9GOqjrvEHLS8UXxV/AL8ap8U+41Rq6K9cwvEHMgHl
 nGc9hDOmrK14xkdUqiN6WnWCXJMqPXchgZCumbhOP3Bte4ctEyWzQaVoGxpeW7WgjFAd
 qEAoXKujcYiBNFcMx3eic6WbUNYw7bPEKU2MJeug9bbAB0L0xOEjpPrc1BIhwtGI5973
 81w14rL713bH7c5j41MxQ7cjHfZY0/we0Lq1eLvEIR/bKr0xAb9N5QCQb4OboJRDjnlm
 3U/ikz8EDbKdfnw0kCqiHx1vpuoGpjIL/PhiGCgzfOMH82TICh2XhSQ3b8QfkUl6FkOr
 Yepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739384017; x=1739988817;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pZPKopdvza2VT9Y8grw887YcnJBeY3KUR/JqqskRF/E=;
 b=LglW/sbsA51tE8mMppOvg/wF9x6n2hQgiG1Fca/q8I5egU307raLP2cJIxth6U8mXv
 bMPf/PObSRyM8fyyjljFTL40zx+NcEDHDWlnGG7b3aca2nwkvakzHnoWWgjQQfBGItp3
 CD9SkZjZ0QxSvwbSjG7o/M/tn0GvTBu96kSVxYUEQsHCoG+C1TuXfqypF0lWxS5KBSO+
 o8/RoDWtCY+XB1RuvubCzfOKieqp7ODjMvqxmKETLGHtK/EEoE6ehOhjgWf9gxlIbFdX
 ckRZt7KNWmxg+mFztbMl3YJSj5p145Y36KsU1wPJ2BYa++AoSTDhJzie4p7yUBd+A3yM
 tuSA==
X-Gm-Message-State: AOJu0YwJk74KpSl9lCCLNMI1aYOPW4zqLBKTjqbOKDz4zGJekCCz0Zdv
 eBe2MW7P0jy+97YGE7OPklE/HbHpbfU62y8XMW7td/Gisdr2ZouPvI7hYqZxRbH8lbmeWo2Rbe2
 1
X-Gm-Gg: ASbGncuZjKOjt96ruje7qhKSjVhKkGaqXCQyL80Bt1JxoF3I71K0TCdc8hbTJbqUhIp
 WyDg9CB6dkRs6YPuOLNKJm+9oJPDTUdXoaMHtcVXoAzIqOL1b9AuOc0KMxVL2+1tQ3ANjTuTNUh
 /9RUD8dklNa9HmvExE6aTplYRpuSVTfZEiXv8+vbjgyYhGKmAz9sKOHVOfE1xrSpKe8XCAAJ2zO
 Qt1Wsd/LlbU5NFp9mFXjxmFe6GXU3XXF+k9YKG7cEUuFoB+uOL1ClXSMihyVhpCDVG/uociyeeU
 Fsq7eWDKoqtXn7Tw03SkRjrtz26FpIk+X5RGee1lGleTW+zeDus5TlA=
X-Google-Smtp-Source: AGHT+IFmoEtyKkr4HKrM0RcnaJWR+3AQ8ZksdKvBg/W4sLXExPakMKdaYLPL0bhbX0I65K7MlKEblw==
X-Received: by 2002:a17:90b:1982:b0:2fa:13e9:8cb0 with SMTP id
 98e67ed59e1d1-2fbf91339c6mr4794906a91.31.1739384017507; 
 Wed, 12 Feb 2025 10:13:37 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab01e1sm1797883a91.43.2025.02.12.10.13.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:13:37 -0800 (PST)
Message-ID: <21ec0167-b002-4a40-b272-718f0717946c@linaro.org>
Date: Wed, 12 Feb 2025 10:13:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] hw/cpu/arm_mpcore: Remove default values for GIC
 external IRQs
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> Implicit default values are often hard to figure out, better
> be explicit. Now that all boards explicitly set the number of
> GIC external IRQs, remove the default values (displaying an
> error message if it is out of range).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/cpu/a15mpcore.c | 18 ++++++++++++------
>   hw/cpu/a9mpcore.c  | 18 ++++++++++++------
>   2 files changed, 24 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

