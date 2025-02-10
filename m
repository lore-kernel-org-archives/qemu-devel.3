Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1437CC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tha5s-0003RG-BS; Mon, 10 Feb 2025 15:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tha5g-0003QV-WC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:09:13 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tha5d-0005cq-5x
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:09:11 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso78795065ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739218147; x=1739822947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvtE9e4pTriWj/Hzw4UsY9LISHfN6byGEISwxPa5dww=;
 b=A/Urnrh/xamKLAPyapgnCAi4Y5J+UuI1coPxwCSvjonjmndIQTMrn5jftRzJM4w5HY
 Dsdr+EI2zNHAkxOBnk1YntApToJlnSAGNYWbi2YVz5badDeNCgBLHM4pub8hnUFzOIJ1
 Y0GXmgaTxb/gCSpo0MLEQHjtGnJOTclG7EAd2I0cb0NhsXS+mtsUasfZLA5HeQB7/oNq
 3KLdsj5M+o5DG4u9JmHKUT8BrtwAwyQstTo4Gy8i3EZBOf/1WJK2q0NuiynaKQ6IpHwc
 Qu0sG8Zjq/SpLzA2vbKuJZBHmsk+R2U283mkNxCu+vMfcq7ANPVqzlAHsH4fmH3ez3fP
 i8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739218147; x=1739822947;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RvtE9e4pTriWj/Hzw4UsY9LISHfN6byGEISwxPa5dww=;
 b=XG7FbEMZNbOdBHt/LGuiXkphSgiGaJXyFDrNRcUCm9YcvfytlAMZmgLTLpeZizyeqE
 tIU4zslTw/ULVG7phsaY3oRCT/BJwUAbaB5F0paYyh/ILop4wAqgIQPyv/GUjzj5ppCP
 sMXF/wovXabAyn0hi2m6tlCIe8ftFddi/nu/v5qrITp4R+muGLB7oTEQ/p1uDOqlEBo6
 SddVVVuQWkYFt7deWcYFHoLOjHxJQm3g09XO51boP6tDvpsiqCWlyKt4wrBS4Yzv6wRy
 wcQS4NrobJb7ulh8NfvsUTi6dS8JjrzzgHv9wYmCtI+jti/1kcTIBN3SzRSZE3E1vTwt
 ozbg==
X-Gm-Message-State: AOJu0Yzs3sGbdJ8iWM1pJEBsjMNXbyHhIMvxRo3jwoU7mGCMlsRGxGif
 5+BvUHSKLj7ghZLxFnfdm4T1C6FsZ+a51cOdWObaIEH820rgUiBMBLN6TXT5kYOV8cUBsfWo9gj
 Q
X-Gm-Gg: ASbGncukQlffjLxnDbNq8gtBo0WulmcscjDP9vfzxJ1srWBdbwet/HEIfyYN7W1Bwgq
 V7wUoalQRHF4rqu44QkbLqRXwbtyAJrJcW8/OUGEKVUCXhnVbvsWFWR6rOC6fXp1GMM/57i+2W7
 Viv9TE61DOT5fOfs/VEeYVJIfMozRYtN8EnLhTJWw3X5rlHmh69gjHhJ8N+zesLF3IOw9X5hSGq
 cs8ivk70Ctn3owkDeXq2DEsVy798yDyZBZbh0g1nW6Nzzvoa9rnTfpm6FwWprGKCc44Fz7u5Ynh
 NUc0vE1hHD/ncQsM5HYS+9rVrfWqp1Z0Nh6T7HN+cF+xbeyT5kSocCM=
X-Google-Smtp-Source: AGHT+IHZ6ZzHXW1o4eYWnI9orF0j9d/5oCBIeIU9WnelHohz5ZF3w9dvpejrrCF4mfj+mSyl62YliQ==
X-Received: by 2002:a05:6a00:6ca3:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-7309801e1c2mr5484935b3a.8.1739218147262; 
 Mon, 10 Feb 2025 12:09:07 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730796baa42sm4491152b3a.107.2025.02.10.12.09.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 12:09:06 -0800 (PST)
Message-ID: <3549328f-6363-44d4-8361-f89b68a59a44@linaro.org>
Date: Mon, 10 Feb 2025 12:09:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Move TARGET_SA_RESTORER out of
 generic/signal.h
To: qemu-devel@nongnu.org
References: <mvmed060xc9.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmed060xc9.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/10/25 04:59, Andreas Schwab wrote:
> SA_RESTORER and the associated sa_restorer field of struct sigaction are
> an obsolete feature, not expected to be used by future architectures.
> They are also absent on RISC-V, LoongArch, Hexagon and OpenRISC, but
> defined due to their use of generic/signal.h.  This leads to corrupted
> data and out-of-bounds accesses.
> 
> Move the definition of TARGET_SA_RESTORER out of generic/signal.h into the
> target_signal.h files that need it.  Note that m68k has the sa_restorer
> field, but does not use it and does not define SA_RESTORER.
> 
> Reported-by: Thomas Weißschuh<thomas@t-8ch.de>
> Signed-off-by: Andreas Schwab<schwab@suse.de>
> ---
>   linux-user/aarch64/target_signal.h    | 2 ++
>   linux-user/arm/target_signal.h        | 2 ++
>   linux-user/generic/signal.h           | 1 -
>   linux-user/i386/target_signal.h       | 2 ++
>   linux-user/m68k/target_signal.h       | 1 +
>   linux-user/microblaze/target_signal.h | 2 ++
>   linux-user/ppc/target_signal.h        | 2 ++
>   linux-user/s390x/target_signal.h      | 2 ++
>   linux-user/sh4/target_signal.h        | 2 ++
>   linux-user/x86_64/target_signal.h     | 2 ++
>   linux-user/xtensa/target_signal.h     | 2 ++
>   11 files changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

