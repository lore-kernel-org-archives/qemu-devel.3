Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED862E6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 09:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXcGP-00031i-DD; Mon, 22 Dec 2025 04:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXcFz-0002x5-5m
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 04:31:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXcFw-0004bc-V8
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 04:31:10 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so24550055e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766395867; x=1767000667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=joo+lCyn7z8eFSxkbQscDIxQrRGLnsPfpFsMZ3Gb0vM=;
 b=IJESDfiX5HKKwKLvCfbXIRIO1sv7SkHftyt49MSRY7DgPAUSYHSx5lBrXLO8GJci9G
 gcGx9VgsZm4iy6q/Vx0HgOpUj8qwtcy57XYGhZ0Mmx6Wl06enIhyiAyc0YmXtSpLZALq
 asSau26f4MSOShB1+dno+FgSQ57RJg/mUtZytPw9HaTAa4eZxYPFTCIbTTCg9HHfy2Z2
 zPD6GsQyw3OyMKSmdZht7O+c5kGmQ4U+dbh4Ey6e3Sod8JrbqxwXCe4T8ZjeNxMojEqv
 n+UWrgP04QS3OHJs5LQFcpGFgmj6yHJdtX6xEQ6HZhqr9iMAvKUmHR5sRMLpRK4pO/q8
 Gn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766395867; x=1767000667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joo+lCyn7z8eFSxkbQscDIxQrRGLnsPfpFsMZ3Gb0vM=;
 b=tVC+9dugqt2K20IB5lLn0qB5KjsaS9cO+HbDACV6YRfn11X+MltdI6gUBaImQtxOZr
 JUcX3tL9QkXzPu5wwEOIwymJzyqNQrFACM+iEC878ONAwX0obzZuJOwDzrmIc7mDZ1hr
 AvdK5d/mvI+BisvxR5JQHeBDK6NQvgdPJwubCr+leEHNo5x31LnuTEKrKVVR0RZM5tgK
 w019a6J1bYn4hOPt+0Zxf0iVn3FNa1+Ng1kQCRyvmfg6WsLCmelV+vm+r4cW+mjZRE9l
 +z5BVVLaFowuhqQy0qOaGm0yWFBGwGLB6gV0ykIQxwqr3pe2y8vL/uCnUFG7pEeVTx2g
 yQPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxEMmiggPPo8SAzwBMNJYjJ9VOlJVPosA7HwpjhqfxAKKo/Ehjokxk1FzGELlYRqAkB5u9drIP9WAM@nongnu.org
X-Gm-Message-State: AOJu0Yz072AuEvZ+Hv8DgvuAonjmBrxRFHriiQ8M0DhA8qDwPE6xDzHQ
 968RBSKRpLd8Hj02D2ax5r67FP+Cjc1tzLUlhaPZh0EMK00ZjYi+QTIDShwEqjdNP0c=
X-Gm-Gg: AY/fxX4asqXEuj7qtVVxq25kVQciTJOhR7Rf2ecnpO27XrZ7tO0sKx6pIOz/j+/j06I
 4nit1L/pjcoIRGoV5HjmdTN1te/sCaQiDsdg47wkRd5GHacQ/K0/w63XEaIbcLAq9NRXfR6BBq6
 lN1jPh2sqcsQjBUTDYC+kPtV/5v9uN3WH2Gs8NqYGUYMe5TBOJkMJGnP7Y8sfBv+yIwr9AIfHkt
 Dku6P6ZQqhXwBkppiSrcqJrvcCX5rtBBU9k4TrhwVCy6qjx8kKjCp5hDY9JQIJQ/qOW8I/N8HH8
 6UbzmEP/mqgHZhcNEptO1bNN9UIRDF32mctGhzqVF3Ey7g71IgLfkMJLYMI3cIaNwZNQeTCYQcX
 jrto7+s7nQ77K3kTdotJM17btBTpHA7uFc2sPk+68AyyF1/701ewigNDKHnzLrlK4WZaCRScjKu
 idANSvmyi4X7tPSvyFLvjR0nl01M9mJ6wpbT8U6QRNm/HLCbR53ZTYHA==
X-Google-Smtp-Source: AGHT+IHZ42x9bu45ZcPbrD/UU8nLB5LCCvyvuZiAdapNQzuTmSweS4qP1uXl629Ru38hRmpYKvRWUA==
X-Received: by 2002:a05:600c:4e42:b0:477:7d94:5d0e with SMTP id
 5b1f17b1804b1-47d1958fcbcmr92946815e9.27.1766395866522; 
 Mon, 22 Dec 2025 01:31:06 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm20993382f8f.37.2025.12.22.01.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 01:31:06 -0800 (PST)
Message-ID: <e5df28a1-f9ca-45a7-a708-f4360c097f6b@linaro.org>
Date: Mon, 22 Dec 2025 10:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix URL of gb200nvl-bmc image
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ed Tanous <etanous@nvidia.com>,
 Patrick Williams <patrick@stwcx.xyz>
References: <20251222073351.166720-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251222073351.166720-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 22/12/25 08:33, Cédric Le Goater wrote:
> Commit [1] moved the FW image of the gb200nvl-bmc machine and broke
> the associated functional test. Fix that.
> 
> [1] https://github.com/legoater/qemu-aspeed-boot/commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a
> 
> Cc: Ed Tanous <etanous@nvidia.com>
> Cc: Patrick Williams <patrick@stwcx.xyz>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/arm/test_aspeed_gb200nvl_bmc.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


