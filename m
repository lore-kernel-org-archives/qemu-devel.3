Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06790109E542
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5b6o-0006d3-UQ; Wed, 25 Mar 2026 23:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5b6n-0006ch-TJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:10:09 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5b6m-0003sZ-A2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:10:09 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so376381a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774494606; x=1775099406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t63ojoLzPgy6q+W81WYCyNGVhtHJcOvKnEZM7ipKw6M=;
 b=LvIDMuYGabcI5Nb6xVOGnNxFDfqC5+fxJ1UUpzd9VCy4H6CfdV566gkTfogcSpdIz6
 A+5mLw7AIuq/blT4O1HhEsoI2EPXOM7bVN1gPNVIivx4gBrYHm84zT+HqafqhEO7EWAt
 EG2DD5HbESzNhExhMbmsGqtRvtj7EAbH+qJmgDm873ohC4KudwExJUKPK7AW+ktaAnyD
 cuOflR/bWvy6p+kac2LNAA/Rr5Q2rCvlXzHahKZenaF6iUXF0Be5+8jmnpFo2zA1QWf6
 7iKDLLx/GwmQ8o5ZeaGPkLaR6kIVdpGdC6MMKjr3hPuME9w7psCTOyXBT+EZZtGZ1fSh
 NL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774494606; x=1775099406;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t63ojoLzPgy6q+W81WYCyNGVhtHJcOvKnEZM7ipKw6M=;
 b=jaI0al7MIPH4KMARJpTsxSSEQslYs7vGggFLXqfAJFrMVT2TsyIvOlZu71vlua45xi
 bIOi0LxCxzbcr46oST2kCwMKFgVyngjBAnDEthKmCPPD5tboaTG5nidM7O2cOE3GqF1q
 gZZy3vR7O0ydacOFToO/98UYGC6zlu49yPzBT1Za6GIY7xCJ2fDYXGa4BhzGgdYx1q52
 UQx76Ra29nZ6Lu0R9yKtsHpsbrzvgA9CEqkao0mQe/NCTXWlAPTSt6F/aO/v7ipghn4Y
 TrW2egyTWzYdrYRxnyt6JlCAlHumeH8y/y8+cloB3ZOehwWZOhjhcs4EpLtI4HWoinuc
 yKPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX31U+aF6rCQTz2RgjP+oQos8iuiJMh7UzVvZFklEmakgtRqa943eBn598Bule7uPsuIJ0vRKFUxCHZ@nongnu.org
X-Gm-Message-State: AOJu0YwPmVDiWGNib3wibF78luPDVjrXXtbKzxCEDE0r9Qnwsa3PrzsU
 IybWOEgXA43cR7k6b29Pr4luOtgOul6QANr+YHYax9rkN+tsJfHmFALekxq6Oj7YsXk=
X-Gm-Gg: ATEYQzzJsHtrSWYTM5hE15Lx82imLBa6qJ7VWfaUrMAFLpMVjhsDllUynEBAPU6EgkU
 QAgPMmTJ1lS7mX+tkM7qXRMPAMBD0KSfaR6hihTOXXdZrDzNuapJvJ8WMpO7fdf/Ek2DI3jsoIN
 tXzD6S+YFh761lrHBXfxAwC2zqwSYynUftT1IVrjbh4hprCyWgimc6PzYx6jUao5VgR/Q4CvVfN
 1cJknAmdCvecZoHLzBnOYwUHVpqd1X37/XlAL4f9XuIkTSe3c8gX23KWBmad0A5VmpVnYe+uf+4
 9tIWaMoXkaFY1ZlKKU8qHwk8rpNrOpsfUZIE+quuWSiuuieKppwZ2Rapj9Hl+NegnCuswFHTVJ5
 vnJUP8lsAY8+FIPXkai6t9MwW/iZv8mMWUI378iJtiQseUyohvdvNE7NyjK3z8DWVphN/8tGVwL
 IedsGbpL15NbrEZgvZd3H4vGJ7Ddf1fcBhPZBKJSM+3w==
X-Received: by 2002:a05:6a20:6a2c:b0:39c:2da3:8d7e with SMTP id
 adf61e73a8af0-39c4ad535eemr6589600637.36.1774494606458; 
 Wed, 25 Mar 2026 20:10:06 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76739345b2sm681525a12.17.2026.03.25.20.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 20:10:06 -0700 (PDT)
Message-ID: <c830f550-0c93-4c0f-b18f-eb6a08dc0ea8@linaro.org>
Date: Thu, 26 Mar 2026 13:10:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/tcg: Remove non-explicit endian cpu_ld*_code()
 wrappers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260320074555.33974-1-philmd@linaro.org>
 <20260320074555.33974-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320074555.33974-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/20/26 17:45, Philippe Mathieu-Daudé wrote:
> All uses were converted to the cpu_ld*_code_mmu() helpers:
> remove them. Update the documentation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/loads-stores.rst  | 21 +++++++++------------
>   include/accel/tcg/cpu-ldst.h | 33 ++-------------------------------
>   2 files changed, 11 insertions(+), 43 deletions(-)



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

