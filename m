Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7320DC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvrQ-0004yR-0k; Mon, 17 Feb 2025 02:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvrF-0004xf-Fz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:48:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvrD-0006cP-Qf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:48:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4395f66a639so23450735e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778477; x=1740383277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90rCP/Zf4wKUPXv5YLoNFigBmM6mlHhYWGNztE8m/RY=;
 b=YPMz+E0Hr74lxBZMNYoTB5nI5d3Ej6bvCk1LCI81BihUUm51VYBD1FxQ9UJ0Axlsan
 zVEvQo8Hly8tGJzVRnNGWmtRDXEIrBDhN1Qz3cVhOC4v7Ldik+BPh5kpaRsoPkI4HX/y
 Z0oG9yrmLNb0LfI1JDlMndJjJjks+TvMY+BtpGHlZK2QNvRbx2ZqG0Ii3LFFqr5RhV8y
 HoQwuA3Pc7LT+szhlRfNUn+DYMsH7VMOqoYtrGsrXwOrLxRSwyFvDQcnZk9pxUfZKZ2D
 n+EQdGPnmrc79/QOU75tm3sMBG0kRHJFcAi0pkW7vOvfSO6oXqvXdAGdNxObYafQnuID
 Q/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778477; x=1740383277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90rCP/Zf4wKUPXv5YLoNFigBmM6mlHhYWGNztE8m/RY=;
 b=hX5Dwrt/qVAXLslYIlCuqUtCX347uFqYJXh1eL9w6QB6CYgbZDZk7hh9SO7VenRxDi
 3VQnpL63cdK6c8NFDT+Gfq7euCtKq7WB/oTIhM++ByWviT6PWIW1kes6RC646X1IqU3q
 KXVsH3JC3Ls01yng3qS+iZlCjlsAp4Dn29heldE9WUmGZdc721cMTMAj+xolcSxQlt8h
 Lq9AlKk2X+wS3pu6BqkqHJ398Z8vs0Q1eg4tM16FWNOLt7cBi25uHcgZPKO1fPV/d9CP
 gFIbvIztgVacd4ZZYZNdWGPTlPLeyggKn0L3gdrrVj/0uBZtt2YXwpwmSKedRi3WR01g
 q7+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKfViv+g5aXjBuUyHrGIaSLmg/+NyF7CoDIyqw5qkuqvbjrN+VFv3a0ABvrS9wNTM0xbdpMWpZacXO@nongnu.org
X-Gm-Message-State: AOJu0YxnTkz6Hkj9U1iar12c5WOM/4iZMtge4pxZC9FgoeWDrecNtYVh
 HGDNOzO7yZAH9D67OmlKLyIk50I0Le83TOZPcgh5ynnHoeSTrZz1k7B5pNkEknZ01w7mhPGERS3
 y
X-Gm-Gg: ASbGncuRXvAaRdw63wmb59tZwBsGm0cT5c8TDJ4mMdXqh4tg0lwlO2tVKnnTMME5ZyJ
 duOVWZCfQ+kbNzBn5ZhW1jG4FXhXyIZAtZDNgBL00VeQep/hPwDHGmiruVLU6R9PXC7PiiAI39n
 MaWGgqZm1Om6mmwITK4bNWwumvxcD8mfoop7xT3shiXm/eIfLLb3X/HLg0tV8ckNdhiB4UoItoQ
 HMJGX//J455VEeByjJxRIngGiM+Tts9XfX/gcVAPtggIOKyPgnRmk3FUKzWQB99O+k4dbdOLy8Z
 2LI/Y0dXKXMqxsQeiaASJ4de0y3/kKeJ754=
X-Google-Smtp-Source: AGHT+IENY3jzMMjkXZewr4fvdB99hFwArZQCoep7wHLlM1/WGwopUJ00ulywowmwZIiH4KjGQomXDA==
X-Received: by 2002:a05:600c:1c28:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-4396e6b405cmr80409585e9.7.1739778477170; 
 Sun, 16 Feb 2025 23:47:57 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395cf084d5sm99685005e9.1.2025.02.16.23.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:47:56 -0800 (PST)
Message-ID: <9219322a-d580-40ab-9364-d7f177d4f440@linaro.org>
Date: Mon, 17 Feb 2025 08:47:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 043/162] tcg: Merge INDEX_op_divu_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-44-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           |  9 +++++----
>   tcg/tcg-op.c             | 16 ++++++++--------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  5 ++---
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 20 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


