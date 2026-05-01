Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12CCFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkiQ-0007u4-Cn; Fri, 01 May 2026 06:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkiD-0007qo-5U
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:03:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkiB-0002je-Q8
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:03:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso1062762b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629786; x=1778234586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nm91eU6FBIHaKwo9Y4zZBKzCO0Cr8Voo+KM8xeGG9qs=;
 b=ORek9dnyMLWGvOaXJs62Hs+hORpDZ0v9gumcspFSaxgr6PCM+7GwdY/dpwsyzYLdBy
 Oo+YuwzW7CXwLgADTHoVD6gSoyL5R5nRFciGQ/+pSme2HBpxZ9EYGnhJLH1KT/YEQRWt
 Bj/w1hnlefV1ZYIyHRW1hI3/NiUbc1N5GdTH3tGm46qDFk5KogYvpXmGRRaWm2vPF475
 8hDe8naOciwjqt1B+50IkyLgd17WoVpRJh5R1YLsQM0AFka/yIGyUzkrk5+TPC5hiX69
 /+oHjux327BWLi2cqtmqJxEOY/lf7yTu8qQYQt5G+xQV1tfq6Br21oQHCisPZgUHKpaI
 947g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629786; x=1778234586;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nm91eU6FBIHaKwo9Y4zZBKzCO0Cr8Voo+KM8xeGG9qs=;
 b=STppnsEBBpSwSYfXzDlfLZA36fRRm9cLsKJiRf/5SAgP8h7K7VapBfMX4PzwtHuNMZ
 dgBtmQDHENO1T3s4onRf4QOHEfVVmsGssWfGlO1EDqvpThPyhHc/5CpfE8klJJZoVivn
 ai2Um4Cz15wqPFfghyg2nmy/v8VeJFWWRdwn+XTsT9ftCh1XSWBztj5f8YgUFjy4Wt0b
 9H4L35w8PccrwdofOyYX+3pvqKt5CWGzHSUTkIpQX6j+nWohOusR78O2zIa6yj4BNKCv
 +KhmRiCZy0URzjN5bjbt45CJSJ9uO/XGAYfe7N0UEb7hHAvPRTD8CMBsn5EwTYqBVkdR
 fWZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/k4UvnYbo849BgP2yeByOwDhhjo/1GEfh9u/7Imz4IF2mJHdd9QHLTm1WbbU6SOPcUdAZIasmNK53A@nongnu.org
X-Gm-Message-State: AOJu0Yw8qKJagLSS8nMjyq2uQCpMAEnJ3fixsveEKzcjbUthSiIC7V0p
 X96WzIM+RCs/dJhYVynbUHx0e0++NmzgEDZXwQg3paJSRrw6UPMEqgy5rSkU6Bcpzp4f76SlAII
 CbcYk7AM=
X-Gm-Gg: AeBDietkXHJON9qg9qtqU6DT5Ug8vOXZpOA+5oGi2vguHSKalLCI/RmVRF+kcy4cFu9
 CC34xFmuB6cMLPkDb9HMFlOG4vBJ2zchzKctm03udXkhDlvm5HuzQdyt483fLFpBhznsK/64t0m
 6DO/OyAFo6q1Bhw/+pruAvwXqyJ9pLAYwJDBYhcMZdJHh14I2C5pe+vgRfDEr3Clr+htXTyiMit
 cNNYe4Pqc3+C577WxMZdV2jRUg61ZAElf34uCu/+l8SpRMMB5wjk96kKbUGI+3UJ8drQStNNN2i
 eKb4NGLmQtkA/kakx5dMQN5dYDbXfn1B/IFIdieeZ67dZTsDVXGPhtqq44J/0RBLkbVEE/boboV
 /sFrXb59PLYazt+t1/uMKnDxPSD6GwWxlk9cNK35SuMkWe7qAO1uF1En+k3nUn+/mCvn6OIbFq+
 zcFsLK0jFvVwF5Wz9rwN/MN966mhblqLs5VckFHeZ5lgaj9jYwnzUg
X-Received: by 2002:a05:6a00:895:b0:82f:2985:2094 with SMTP id
 d2e1a72fcca58-8350019070bmr5641912b3a.30.1777629786161; 
 Fri, 01 May 2026 03:03:06 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-835158aa1ffsm2044911b3a.22.2026.05.01.03.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 03:03:05 -0700 (PDT)
Message-ID: <af42b55b-ee8f-4996-973b-da3e2ce08bd0@linaro.org>
Date: Fri, 1 May 2026 20:03:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/25] Remove cpu_get_phys_addr_debug() and
 cpu_get_phys_addr_attrs_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-26-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/30/26 19:38, Peter Maydell wrote:
> All the callers of cpu_get_phys_addr_debug() and
> cpu_get_phys_addr_attrs_debug() have now been updated to use
> cpu_translate_for_debug(), so we can remove them.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c  | 20 --------------------
>   include/hw/core/cpu.h | 34 ----------------------------------
>   2 files changed, 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

