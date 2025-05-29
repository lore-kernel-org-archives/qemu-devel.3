Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9AFC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiF2-0001ZI-5h; Thu, 29 May 2025 14:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiF0-0001Yn-QF
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:44:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiEz-0004Pc-7e
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:44:34 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso999225b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 11:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748544272; x=1749149072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ny0Eqsz9X20q/yHOO7DwLMVK76Hs1Oy73iUrSJEWTVY=;
 b=NDg4C45xI8K4xko5f1lBE0DSHjys8MfpXT2KAhmcsvbzWBdHknLkJ86w8RNbOdezii
 G5F90KgGIeTtmCdk90k90E8V9Y7nKmj6pUvpHaPPeh1jL+lVMNSSXxbn7kdNliDgZD5f
 WHcX7OjsnE5bOReL2r4K5R4Ay8sHVrL6OT1U0zvwxHRArcvOns3zIeaf4biGnWu/ilf8
 HkbyWdyGbOKqyTCStxgqviOTIWSi8eCag/8m4fovIlP2MvsXfOckVv68jRvwlOjjSAKF
 da0C14cIbTR8C46rb6BaACUeS/KETgNJa9OvgMdFfDcm1j7qBzBgbibcKzfzeDyn3oTC
 P06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748544272; x=1749149072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ny0Eqsz9X20q/yHOO7DwLMVK76Hs1Oy73iUrSJEWTVY=;
 b=a/kf7nprkBZ/Oqc5NIHYUxfX7dgWc3xZc98jZmH/bxDGgJlu6eOgmwFalxMTnTWJrd
 R2+dBORF+m/ikfixJ6oN03NSQb59Lvma6vPghXCDzE5pJDJVmt7d06Lo8Bg92MGo5ZAQ
 l4qE0YoowzSKjo8HEPPmv2eQBIZ7ItdXvsMDN1fEf0pN2SMAubfKs4i7F66izsoqLFQ+
 WPzq31/Z/L+p/TYm/qZNySIup1uG8PCCRC3/bx9t9ATDNI02/vZF8B1yYa+9DX2sEvNW
 DUSAYz7ztTZSZn7rvCVi4GH+LeD0IcQaZZTRBj0TvOpEGjxWbR8yXON1nMR5277ST8eC
 P25w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2ibTvbSbbJ4ZIATXZ4pBmF/hR+/Sio1hazahlQwFNns7EdONAC5OxBuXXDoRvCniPBc4I+naHBuXm@nongnu.org
X-Gm-Message-State: AOJu0YytDZOyHcMvyspJArYWOuqbaarle/WTGC1bdeUSWN/FyzX54hUE
 GNHnAqqySQwfPf5Af+MjvZFGthLxhDH84QKsKVmAiADzg2gfZLblVG9CBrULpnPDRpU=
X-Gm-Gg: ASbGncuRqGdZxluF4D4b8EZxw+xJJiXd1eP3PVaKe1bhz7SRyVqR6XW8uhKjQfYlb22
 CMOhM6611isjNdh+sdfitkEcJ/R48fkSdaABfxORj13J4Z1ppG1PduYsELyXXlKxsqgWNLI4BMd
 oqGi6oYLhhQNn1nMkCHfTTBNM36vInnRamkgk4On6RBWaxQFyGMkVrwXe7nzQrUcX2vX6mDu2Lh
 KOsSb//0wm1rg5XlTSmDcXQB0rmEeE25rShaXOybzj07EowIo357CE255jt1Of9rmIsXQK/SPOd
 qtFaTsXr7cgR4w45RTt70rc+vb0NSd5+1YV19ca8+E/h2WE0RMiQ2Nd1sgJ4ywGxjCPoGm9m2hk
 =
X-Google-Smtp-Source: AGHT+IFN37k6ag9ymJQUCYin7ndUVjkxnwEw7uLdFKFutIQ56itDk5bfGLtQHVgQ69T2DBnQWs/ryg==
X-Received: by 2002:a05:6a00:2389:b0:736:51ab:7aed with SMTP id
 d2e1a72fcca58-747bda13a11mr630910b3a.16.1748544271718; 
 Thu, 29 May 2025 11:44:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affcfa19sm1694742b3a.132.2025.05.29.11.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:44:31 -0700 (PDT)
Message-ID: <8a2b2f2e-cbf6-4146-9efe-2470acae9ffa@linaro.org>
Date: Thu, 29 May 2025 11:44:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] plugins: Add memory virtual address write API
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
 <20250523020344.1341179-5-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250523020344.1341179-5-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/22/25 7:03 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch adds functions to the plugins API to allow reading and
> writing memory via virtual addresses. These functions only permit doing
> so on the current CPU, because there is no way to ensure consistency if
> plugins are allowed to read or write to other CPUs that aren't currently
> in the context of the plugin.
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
>   plugins/api.c              | 18 ++++++++++++++++++
>   2 files changed, 39 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


