Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF9CC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWynG-0007JZ-VY; Wed, 02 Jul 2025 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyn8-0007Do-Np
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:50:30 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWymw-0000eD-Vt
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:50:26 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-735ac221670so3351164a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467816; x=1752072616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RJ7o2Ucx/8E1Pto7OYC3sePhhQYAgyirg11X7mFmGv4=;
 b=DBdbQUaJyZPNcun+5yJdfGRcXxvnWqzZqF3c8L6QAfTmBmyTTHB+u0hDmUwIIG05/3
 y5pAZ9EPADnpxxmRQ/wiucPyhIaVEFIerSL81luysi3xtzUKEWJzaYLg2bR2Eubj5Kq5
 OHYiU28Wn0KzSJ4iBVKLZ81wh0mfpfozUO0Skpzv/UlSbKI1z/KshHuutfmrdPkOk9rd
 XVdz/epwdSzGtHUW1wNoq7jsqb3pMFSHGmnKm4tvEJ254EbqUmpPQ9lihVy1dNHDOckj
 t5wMWJTaujpiQ6bAwYZy5YYN2dQHiua7ZVqA/fg4AikvS6lZVZ3k6AKvK1NPXS6FXn78
 zvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467816; x=1752072616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RJ7o2Ucx/8E1Pto7OYC3sePhhQYAgyirg11X7mFmGv4=;
 b=PmcHcze+yiJgS0qVYsmMYuD0M/2Obln4twppwiUFnYYKcuX5iyKP8WNe/8BQTSX6Tn
 XaDgjbKO23wH5ZQ+1h558SoKzNrk4tPUoUXA1Ej2M7xVb9r+RJOrKbTfQOZL5eErn3vU
 L06D9CS94SpcxL6hlhYcH2lacfa7QUxAMqQy35Q7bxCYDNK+4O8cOC9setYBl66qQn/h
 cWl0Htm7ZQK4YCFW9ocZ/cxKKNkPLotzFUihqqkfEaGpWhuw0/yLG6jJb3OuhqzJw5sz
 Jnc12QNVurXmS2QkKa+HBiibi7Vwo5RcW2tis+TFElR9BfLt0C3K/jho56RApfW4nhiD
 0qPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA+aZnApj0gUFSJT/pdUcHzPXyuchLxtAsI04dvE5nfZdzBK0Wl7++Ac2MrK8rzufuiaDCBEhPHjTh@nongnu.org
X-Gm-Message-State: AOJu0Yw7EazrsrLxknxVU5HQJ8FOuokrSOiHiFZ/OdIUdX9H8j53JjB/
 rpu2ZP9HFvZHtbVjj7aMT38R0DuM/rvtyQg35ePPCoA4pmO5kM1N7jl9ugTyMG1O7lw=
X-Gm-Gg: ASbGncujLgoNP+HfyvMCnaIGGbCmEPFtdKl3e5qPDRpvINxO2q9mgQhRgMv9u/ZyVnt
 FJpT3YRJM8/fY+DMff5Bv779srRVnlhrEX1/jy3lTDYT23jOm7ltMeWqaeXD2tSnFkn4tBu68Pd
 mOMff7o+fbG9tITnVdN6Ys6B3yMmz22PGQNoY/v1zPqn67vMMW1lSAWF2FdxzSMTHXaCQeyULdH
 TfXXfDipTS/1MKHPL05cWBw164h+s32KlknSw3SnSfgjgUYpsHDnbzzenVAnrHaILLEsvDfP9ve
 ENf7GdfS21ea2EknLoITHLTyIHkp4VFvRXBqFSQ6u0z56i/fncBseVrcsI77v7bbHjFikpCoV8Q
 R
X-Google-Smtp-Source: AGHT+IEc1MTLS+2t2ziQIbbsQ0sPe7VvsV1mAl4W3ZusEh9T2HaNnNco+4KT+F+9iY3LCE7gWfo8qQ==
X-Received: by 2002:a05:6830:2692:b0:735:a61d:5764 with SMTP id
 46e09a7af769-73b4f0ee911mr2137293a34.9.1751467815746; 
 Wed, 02 Jul 2025 07:50:15 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73b2ec06ae7sm1174392a34.16.2025.07.02.07.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:50:15 -0700 (PDT)
Message-ID: <6af28392-d754-44c2-8e2f-6cca8a43be99@linaro.org>
Date: Wed, 2 Jul 2025 08:50:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] target/arm: Fix VLD2 helper load alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-10-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-10-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
> This patch adds alignment checks in the load operations in the VLD2
> instruction.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

