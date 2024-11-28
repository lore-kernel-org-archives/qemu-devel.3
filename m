Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161E7D70DEA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGimW-0005PK-Cd; Thu, 28 Nov 2024 12:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGimU-0005N3-1W
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:58:22 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGimS-0007IL-1l
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:58:21 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46684744070so7964891cf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816699; x=1733421499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ElvaGOTYdqh8TD7RLPQDLXuGC4v9ulR9RbFYsDxRwEU=;
 b=uFiwtLOPpjmYAbJ3gRnzhR/kCCC1eHGOGuvuIUiuHc61fj4XbTApFLjkLpY+y382Je
 XnDqYsYQrNZ0THZDiuXXe3oNcNa8jrUar+DEvVoG/RO21aLSOU5LaVDXc2R8FjJcUNl8
 ocvmDUI+CNIzUg4zY7kbEUyDofspS28sYzdN2yZyTMdMaVdbhIxrMg4T6ORwk3XuUah4
 iPeMM0HsPrNdjHX7sdP56NQCYQfSvdWVfmhHff8/kp6YJH8ruLvIc0lJCAx49Qbqsj7H
 LYp21XN1TxxZw0T9yMhbaAeEuMx2r3Sel49IQc/Ps7vUY8LK8NV8nGsaQEXH02G8bHc3
 JqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816699; x=1733421499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ElvaGOTYdqh8TD7RLPQDLXuGC4v9ulR9RbFYsDxRwEU=;
 b=Q/9/xCzBsykiGE1onABXvM2Pae5lnU+vWfea//wK43E6JYSf2Ms37pd7zrUNW+TrDk
 AxhRIgxNzAVWmGhTz/2zycTTmajJJ6DoD7bnooFsUXfzuJeglNi4+bFjIIqlHEowIhFh
 eqvNEewHmLvNG0oKp0UPfS1y+d+PUuWBdZl6lj61wHT7oNj64p7DJo31RIo4irUWTkLZ
 OPzYQpZdrRB9WhI2CCOBqv6fLGl88I0+k56cREF8GROCO6uFhR0KbsffCgcE0t1grj0k
 f0VxoD2JKPNt/62Zw1K0Z6lpGS7EiWx3fbwI6jXKLgjMa6jLDACnwoxoH4UyQsE0XcT6
 U4dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuLdp2dBrrKm5GBbGyjRavXutJKfyT6+KUFcFa3wmSIQH0cxvtdGxQMYHgwAq9hcUduFM9kT7a5QMw@nongnu.org
X-Gm-Message-State: AOJu0YyeqxURHyK7q2j5u5b1MMJ7cG/SyNCt+WSeKUYt55qEE9J/RCfR
 1wDzxDaL8dB0z3/0yVFV9wKFxHf1eso8m4waHBKZWF31EpdlHWxMkrCeMkZCoY/lxHRYxb6obGN
 6s84=
X-Gm-Gg: ASbGncswIcHqNguK4/o9uscRkLUQX3D8tZINvdDz8WJKho6UrjGswrnOvUQ05t/PZRn
 xZHzeM/OpQL1S642+/Z2IDeIjFEFNVEXLE9871hlcijDyd/OYbyNEHsshi7qw3q9m8D9bTCxptY
 8cDrW7bwpkVKmv40mgBqc401KfvEEyrubUOjSHwkvZgokAwn6qFtEA+DplgZRxQmWHO8dHmg5oE
 rxJKsATxrB+KgMHoar8y6ELTJoDr5lQcbChFxIS0aPYVCxc62d0WBIaNk4Pb1NkJ5c=
X-Google-Smtp-Source: AGHT+IGAOZJCVNAOjt6/L/Fw7Ycg0FZFKNWc8jqwnN99K5ZPf+4xEcdbwRi5HhyO+aZi5v2RECFgAQ==
X-Received: by 2002:a05:622a:1ccf:b0:466:aa32:78fa with SMTP id
 d75a77b69052e-466b36751d6mr120476111cf.46.1732816699102; 
 Thu, 28 Nov 2024 09:58:19 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c42536aesm8684451cf.83.2024.11.28.09.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:58:18 -0800 (PST)
Message-ID: <66962da8-b8a8-4565-a3b5-23973422cbfb@linaro.org>
Date: Thu, 28 Nov 2024 11:58:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 25/25] fpu: Remove use_first_nan field from
 float_status
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-26-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 11/28/24 04:43, Peter Maydell wrote:
> The use_first_nan field in float_status was an xtensa-specific way to
> select at runtime from two different NaN propagation rules.  Now that
> xtensa is using the target-agnostic NaN propagation rule selection
> that we've just added, we can remove use_first_nan, because there is
> no longer any code that reads it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 5 -----
>   include/fpu/softfloat-types.h   | 1 -
>   target/xtensa/fpu_helper.c      | 1 -
>   3 files changed, 7 deletions(-)

Yay!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

