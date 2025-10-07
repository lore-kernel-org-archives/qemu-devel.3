Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76950CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 03:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5y18-0001a7-Ew; Mon, 06 Oct 2025 23:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5y17-0001Zy-L6
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 23:05:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5y15-0004dJ-Pf
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 23:05:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so53290885e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759806328; x=1760411128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kZDF7P5mJQzKSYbEAkHE4HXCa/ZEVxlJJCYyLg88A1g=;
 b=w6TIYx/yHldsQK+CGgXlDR77oHPR87BhZT4cz/DE5x1dbLajNEyZJ3sSZGHoDQv35T
 J6TNGEu/UtmEy9FKAKoJUxJW65WBvFzyJ8G3rlZK/hjsgaoK/3enFKugwFTqX6dDyfNs
 BqAs6lF/1sBWom4Tg8AUrFxz7VOYo34CdzqiND93tUkvVXWBXcOoYVBNBuUi/pP6i/oO
 Pufj24CqIKXRbw/BEqrOPK2mvFzaYovkPw15LSp2/eZqcxCs1hl2J+yLtYrOGMd6lA2q
 7/CG6QvKeQsrc0rKc8rF2i5ERcni4lH7vRcHKpJ4mKO9EuEC92FCpFDVaua+y6w8uEzR
 llPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759806328; x=1760411128;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZDF7P5mJQzKSYbEAkHE4HXCa/ZEVxlJJCYyLg88A1g=;
 b=iUzdUq5eLd838cEZL4E1tOEEltSrGju07aOMohb98L1tzkK4enHb8Rvqpj1lAdS65J
 yDCBcVGU+zVKDWqFbKNLYa0TOWx5clBizM+d2laz6bbyCTOsKkhhh4yu7yiwCnxx1UWo
 SzLRoxrjUw3j2F/cL5526U/E+Khyfgiu6U2+ATuNhxeIbnyeiDvnzSO7O5JKBm4ZCDBU
 uUF7lfN3QYVTlfosgxJ+dBjLeZQ/wJ0YkQVwQcwySAfrdtly9mQYjbXUy55fS5Ljpad4
 kF/bSyROVdK4nUOi6UyfYU/SnOjcA8ZWSrS9M5oTYnAAhATYlPrAN2ARO+/jIz8nketK
 glfg==
X-Gm-Message-State: AOJu0YxGSFl+Iiiuyv+p4rgjQRdJiiDAqjAFxuINp4zFqc4blj82Yxmu
 3+SUfrnMoTyA2qpLB5AN9qPV47AFeKjU4z43pt2lzZ3IDlsJLnBA88BEvalQOX5VrHxZg0YIs7x
 AWqUnHlJn6cvr
X-Gm-Gg: ASbGncuJrzYeDOPcI22Pa78W6ysGdSoWcL3rs/Qm6TwwL1JT6UfbMgszZR068R+PRa0
 njZa0F7TbEz8HZIkclow4WucvXd9vEmf+Mh8dzZvwhr78IaGpkQxHx4mEqTTozT2iJDZnBECl2m
 eMugXSRZswIrWnXCuFvjDrO/dmKb8B/sC5YGlnYSiHB6R+n0bA3cTwvFyOmPYiIh4QCP+Lf7AiM
 GPEfpJt67jGLMrIKpoYZoagEgPRI9WExtk3XWek0WlN9/eItZlpPD2Nt37C6P7Itzy7SyR+qUB4
 Dvqizc5Ffe7Eco8+FwX/tL69FGKdStn9rGRmSr6slUWfnT108aZIA4GaZNAebiJ4Del5aMOd+yS
 RCuHpyQPiV4udbrbbOXzgjDC9iF+epW2ouZmF4tENHKPhglpD7DohGgpItr5PLk0wHntvOQXxwz
 3FWFZaluGuImkyzUqWh5FYlChT/hWR
X-Google-Smtp-Source: AGHT+IEXCvoTT6lhJUEN+cimA/qOGRCBjyqxqyW8paJmJ6YSmBuz9a8Z5kpwkfASOotoFSP3ocdtKA==
X-Received: by 2002:a05:600c:1f8d:b0:46e:436c:2191 with SMTP id
 5b1f17b1804b1-46e71145d77mr95006035e9.25.1759806327934; 
 Mon, 06 Oct 2025 20:05:27 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6daasm23662740f8f.7.2025.10.06.20.05.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 20:05:27 -0700 (PDT)
Message-ID: <43255d92-5a31-4eca-8e70-2fa04b7a1d2a@linaro.org>
Date: Tue, 7 Oct 2025 05:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] Memory patches for 2025-10-07
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
References: <20251007014958.19086-1-philmd@linaro.org>
In-Reply-To: <20251007014958.19086-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 7/10/25 03:49, Philippe Mathieu-Daudé wrote:
> The following changes since commit eb7abb4a719f93ddd56571bf91681044b4159399:
> 
>    hw/intc/loongarch_dintc: Set class_size for LoongArchDINTCClass (2025-10-06 13:54:50 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/physmem-20251007
> 
> for you to fetch changes up to 9ccfde942d8b4e66eb012cf975dac16913875a2c:

(update as 4db362f68c7cd28a6b1aa2f9ada68aa3556f9613)

> 
>    system/physmem: Extract API out of 'system/ram_addr.h' header (2025-10-07 03:37:40 +0200)
> 
> ----------------------------------------------------------------
> Memory patches
> 
> - Cleanups on RAMBlock API
> - Cleanups on Physical Memory API
> - Remove cpu_physical_memory_is_io()
> - Remove cpu_physical_memory_rw()
> - Legacy conversion [cpu_physical_memory -> address_space]_[un]map()
> 
> ----------------------------------------------------------------


