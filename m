Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F06E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPMk-0002iZ-M2; Thu, 02 Jan 2025 12:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPMa-0002fk-9N
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:52:08 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPMW-0002bc-4x
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:52:01 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216634dd574so105760575ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735840317; x=1736445117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M6F9XHz1TCozPcoxwzBmQP2ceXd5Ia3yE+8tpJycV8E=;
 b=EiT5WEozB2iEknirxwvqtnfmjnM7R2W3kCfeybE7yeO4oERYY0DSRypKqMTw/Be9cB
 BMlYE8S7NrTee6nLL3QXJjPtZL4Vc5eU0FcpiRemBy2aRw6OpkSdXymzZ3EIxJRMqCR3
 GG03hlDWrAVs+yLNvoJmmtB4+xjdxSSxycY0qTl/iZ5mOREIdWN9g3W0HjcpT9yuYw3A
 i0gUdXrlOqjEyPf9IWy4hR2Lf9dBeSxH2HUoe39hiZXSRaJAmCgXUTDjirGDu6y5sroJ
 OOuzZNAgiS9es4K/tzYnkIuK/dXSNCaO7RLSQy8eIjw5ow4NL8XUrjyfDeX0Fx6Rs4Js
 kJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735840317; x=1736445117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M6F9XHz1TCozPcoxwzBmQP2ceXd5Ia3yE+8tpJycV8E=;
 b=rkrvXXu1gsNP2bc253qRfrBaSxNvwkeD+AdqPzvsiEDY8fSE2WFf4EMoOkBMDWP7Ih
 0TSEMrPS5+0VyKzD0RB4Vui+HE7qR0zPWZGp3TZI/K3Bn+l7RlPtkBb+u8HOJO+lp1kh
 rxrXZ/rbiXK9B8VP1XA3FF3PHfllxwxgGfP0CUCOnjpe+PTCRgQD83Bmm0AAPa07Q9rP
 Bx79GaBMzvlk8bHYhpppNeBIRXgYLSkB80EJJakEFE3qcltUaHNJTTJY444MnTbt68JF
 iY/dqknoUkjXCE47bbQQM/dRXeFYZ2TMqUOn69c3Ue8xgJAFb9HbwIGwv8D19a6CeINt
 0p3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7jYwhCKM6pJZm+H3wzx3BYTI/Z3/9sxWUmrPAI8zUkAX+ci5NN0RrlA50DtUz3/4VDvUF27vwQnuk@nongnu.org
X-Gm-Message-State: AOJu0Yx50TdBky4MX8L3/pO/I/7xlJUjxrcTBR7hbw//3wvQ4L/+Uja2
 hB4Aqb1gOP7uXAb1B+8ltq3ysBOgAHlkKBpkHn+9e3NkmUv7mQjC3wPF2o3MM7g=
X-Gm-Gg: ASbGnctI8EuLZU+0OC/f8IsvqwJivCjFzlIK+zFEfLeNmGBYY3MwH9fxF1nduldMbTI
 Z0HFL3MvZyfA2cZ7GGrAYWY7j3unqNsoTnXQoFHtpjO61DopypfkoM3/luc4HgjyYnPEUBpp7+x
 noW4ftkPl4jdrK1B9Yv2V+mEJ7FSOQ3rkjMud3LpO/lUJKetnwBRdzMD4hrDQP1ljOKAtYOnu4e
 DU8MNmc0/51qtEIaBX8P6ygan1YnvDwC6eYkESP6LhKKMPD9GZJxeQfJIoFWCgB8PvWpog=
X-Google-Smtp-Source: AGHT+IHaQRrgX+pwc81KxHR9aIevyTkj9TGnO7pa2Cvq0yFex21vZk++Tw08UUaTxd5WPuTEzATBMg==
X-Received: by 2002:a17:903:22c5:b0:215:7faa:ece2 with SMTP id
 d9443c01a7336-219e6f145a8mr622564595ad.35.1735840317506; 
 Thu, 02 Jan 2025 09:51:57 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc964b54sm231695655ad.1.2025.01.02.09.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 09:51:57 -0800 (PST)
Message-ID: <92e1a47c-1327-463f-af00-1b3708bd987a@linaro.org>
Date: Thu, 2 Jan 2025 09:51:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] licenses: Remove SPDX tags not being license identifier
 for Linaro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102160510.61894-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102160510.61894-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/2/25 08:05, Philippe Mathieu-Daudé wrote:
> Per [*]:
> 
>    "we're only interested in adopting SPDX for recording the
>    licensing info, [not] any other SPDX metadata."
> 
> Replace the 'SPDX-FileCopyrightText' and 'SPDX-FileContributor'
> tags added by Linaro by 'Copyright (c)' and 'Authors' words
> respectively.
> 
> [*]https://lore.kernel.org/qemu-devel/20241007154548.1144961-4-berrange@redhat.com/
> 
> Inspired-by: Daniel P. Berrangé<berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h                           | 9 +++++++--
>   include/hw/misc/ivshmem-flat.h                   | 5 +++--
>   hw/misc/ivshmem-flat.c                           | 5 +++--
>   target/m68k/semihosting-stub.c                   | 7 +++++--
>   target/mips/tcg/system/semihosting-stub.c        | 5 +++--
>   tests/qtest/libqos/virtio-scmi.c                 | 2 +-
>   scripts/qom-cast-macro-clean-cocci-gen.py        | 7 +++++--
>   tests/functional/test_aarch64_sbsaref.py         | 8 +++++---
>   tests/functional/test_aarch64_sbsaref_alpine.py  | 8 +++++---
>   tests/functional/test_aarch64_sbsaref_freebsd.py | 8 +++++---
>   10 files changed, 42 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

