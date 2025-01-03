Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C54FE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTiho-0006jr-AU; Fri, 03 Jan 2025 09:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTihm-0006fX-Oh
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:31:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTihl-0003Gw-9a
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:31:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163b0c09afso169185575ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914672; x=1736519472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+gr2DgA9RXOdTsv6b8HJZWSSeFnYYWHviw32GDpgWMg=;
 b=Hzh3wg/eFrzpwRd5dNIUT/ZxIG0nHOnfwOD+GPghNYhxmT/AmLqWQbmjWnSaN7nhSe
 IUnngkeWA0w4RkxfChJd0NWaGF4RuZaDUAVfNjrN4/lEDeA3GGFECuxIjjH1o1A4fJVG
 sHQF5my7isDnQOEZCS2+cxbPMdLAizHjXLYfCUp3IyX/KWeuGRuCdcbeKjNPAUjCuWeh
 kvydQinhDuWP/ExBYROMRD50BpJo8A8pgrKMC2vg2Wurqu2E4xId/1lgEUlOHrkKDtaK
 0b4OBLb4MgIv6J4sboL6PLKNXC9YbEf+sx91NnziGhJW6eKozPeh3NMfZDMVKINtSOcC
 Z9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914672; x=1736519472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gr2DgA9RXOdTsv6b8HJZWSSeFnYYWHviw32GDpgWMg=;
 b=m9qqTi5lL7uGnyL1ynslUDJMv/rqVaL0PzWRVvD/2UcoQvv6717S2QRZIdceIt7R4P
 1luRfl066FADUm/FTJkOA7d7oob8sBmhoGcp55COo6O9+xTFgKjf7irpZhp0qUr8ORNq
 SWjN248dFYzRHvhtFTFNqDLXpcuIWi8in8q2g/mIvLpNed3r1odA4aIOdXA5tZ3UnLec
 Rt4iZLJOlgqIi/ekvjDsC1uBBNlSo/yLCAG7hXo13mUYT0JITHvNKM/hpB1k8aRYW85M
 i3ct4KGbsKC+eXDL8IRs0SyzImDB6jkAPuIytKKl5ygrbjsiHLxHUXl0b9WD206Oqioo
 VGYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1MkV8KJAkaDEXKKjDcDpY4y4ZIsm0wueqiubVl1hjkkY0aNPPJnx3gmzECqPllz3t9oPm0Iwrql+w@nongnu.org
X-Gm-Message-State: AOJu0YwTT8LkKSYmopjN/GzKuAlUPf9BhZ7Zp1lpc5//wBQvW6A1YkuC
 dowxIKh6ddZWx3OatkL0MmvJFIV38i0a5DJss2bN724qbYp8ucY7GG8E49SHABcEDJORH/RRras
 K
X-Gm-Gg: ASbGncvfyLvpGeHvlicWINXxJ9zfq3L7eyReP2ZdkBUaklA3DD66OSFDhRA1QgpHJHa
 +qKGdtJY3odRBD3jkHJPISKgICk5RLTruv/673H2Ebvi8Tnw5A1vqC1YYnK8S9dHpGFyKcS5E69
 CXASwJGWqmqzwtSzGmUea2Mb9FggqELV7X/iCG3RDoKvISoFPEmyY5hSJpXagDVA8HQuXS93oun
 l+t3IcApfOomaDKN5Ayc767smm7SzmXKvUX2QaFf6qqlqmuN4eu27rO/Xa64kCKpN13RC4=
X-Google-Smtp-Source: AGHT+IHvDllEI6tI24I//hg/lk9kubKzCo3NhY+hVnljqLCgds/u47IDulj0bYEs6MUL4LCr2YngzA==
X-Received: by 2002:a17:903:2cc:b0:215:6995:1ef3 with SMTP id
 d9443c01a7336-219e6e85928mr610510285ad.3.1735914671756; 
 Fri, 03 Jan 2025 06:31:11 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d94c4sm244386785ad.115.2025.01.03.06.31.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:31:11 -0800 (PST)
Message-ID: <193df9d2-078a-4611-9a1f-dd6bc76869a6@linaro.org>
Date: Fri, 3 Jan 2025 06:31:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] qom: Remove container_get()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
> From: Peter Xu<peterx@redhat.com>
> 
> Now there's no user of container_get(), remove it.
> 
> Signed-off-by: Peter Xu<peterx@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Message-ID:<20241121192202.4155849-14-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qom/object.h | 11 -----------
>   qom/container.c      | 23 -----------------------
>   2 files changed, 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

