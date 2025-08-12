Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA63CA0ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 00:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulcqQ-0002cT-2b; Mon, 11 Aug 2025 20:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulcqM-0002bm-Ox
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:26:23 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulcqF-0007I9-G4
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:26:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so6200996b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754958370; x=1755563170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2BdKIhvTA4Hr9vuXIugVUybVY5ZoW4bxMqD4nd/2S3c=;
 b=qMYgDUAyQM1kjei7K12PUe6kPZzKxJUG1ZKB5pA22KrU3+EQnzctoh8KQpInlTjigz
 zr9luJUkbUcTDOLIpKJCZ9+3yqZ6nH4aZvxesjvttY+nPt/zO5px4d2k3EGSJZNy1wzr
 Q4Sno8Dq8dCOUieM4hxExr1GEyFh7iNWCVCq0aly/1d5imoOMNaMEhCfrMvYoG7IBzfI
 B2bowfIPgs7TPvUNbfRrNHEqW4uouBfQQzsk2H9kbvKrKWbTsiqDMWgzHYfXZ7NU0iSn
 rWda3y5jMUxtw6w/0/PZ6YkH8d+zkgd1TNkLzWuROwjZePj6EQuGO9EEP7y/QQ2Ce4+1
 F99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754958370; x=1755563170;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2BdKIhvTA4Hr9vuXIugVUybVY5ZoW4bxMqD4nd/2S3c=;
 b=KnNJ5azN6nOJhh3AH8Io1qIjUBYdO1MTZtpP73V+K2DpUwm4hlvMelOpLwjxLwQevR
 Ia7b9niOILXombIe5jI+KIQP+vvDzHuco8IiOHL7XS8b6Wq47+OjVpnNLhYzObXF/J1J
 396y+tTgFyKN42GBb+2y6ls7jjmERSpYiFGJ2QmVvpnW1PSpu8AIXHzLkslgkGUGkE27
 3voi6srx6CksoHsoqZcnhjFFuYkoMai/S7NcC6D50nQy5mDFgv0L3SlX6vLzr/YR2zc6
 fkCdUXF/UJDAvtaGbJDaPrG3iSScPrDg6VdftPR3udGN47aP10eRqxzTTOo+MlrAyzv8
 G6pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7v+XIZlI4+e8UM7/gUjQZ/DnEafOtG4xF6TqWi9U+buPx8w8VvOYVEqCOclaH6M03WcE20eHc1gQd@nongnu.org
X-Gm-Message-State: AOJu0YxAfeqSl1a9NAI7hLoi+Hi1vUWSd5JRIRXfokFS5p9yqpBRM2mz
 FzfI6mljrx+qf91wU48uppKWuJTCJG6vN3VjG5noj4UAtkrnJn6Nr42f9BSZXEMu2WE=
X-Gm-Gg: ASbGnctczDmuUB2eM8NF8QBdc9VCeRvg7YACMIBgMtIM7HxLfRU4So8YPQiNSUyLEbj
 JFevER0G3AEFlqfxI6a+NGPke4cATFLZdwqCyaZck6P+HWoO0FyEnjtp1b+F965k73FrCMHnyyd
 4iVZA4t1V91J2EfLWBoDdGZvIM6xA6jkmNCvAgzR9OAcccU6O9wugEi82yz1aS0gcfBZbP9ry6x
 2qUUOKXA+o2IVI1L4AlbqryigWGN+2kE+0ANyRBe1c+F1+eoPIGcAlQZiCouXQABkS0d7fEzruL
 v+JH4fCBdBCC6RiQzL/LzHX+9StRm+7Ufv5kdoD7UQlUrpl3D/1ESpdhvZApIwv1lSNTd1GpUYI
 xyQbJUq0WiNlwIDEkR/d4fht8YKU7vvNNqAir7RnU1Q==
X-Google-Smtp-Source: AGHT+IE5/g0E50CVJgxCVA7GYjeANlD0gG1N7ePgGHpTJILxeNCzeppvs5dFFLVNW/Ax4M37FfgbxQ==
X-Received: by 2002:a05:6a00:2daa:b0:736:a8db:93b4 with SMTP id
 d2e1a72fcca58-76c46090459mr18861992b3a.2.1754958370043; 
 Mon, 11 Aug 2025 17:26:10 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccead450sm27943078b3a.54.2025.08.11.17.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 17:26:09 -0700 (PDT)
Message-ID: <ef06bbe2-e891-4901-9b8a-31a8cf4ee3a7@linaro.org>
Date: Tue, 12 Aug 2025 10:26:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/11] target/arm: Factor hvf_psci_get_target_el() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811170611.37482-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Factor hvf_psci_get_target_el() out so it will be easier
> to allow switching to other EL later.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

