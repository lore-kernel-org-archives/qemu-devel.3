Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B126E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYYv-0000Oo-PR; Tue, 17 Dec 2024 09:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYYa-0000E2-Ea
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:28:19 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYYZ-0004qe-4L
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:28:16 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eba7784112so2034052b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734445693; x=1735050493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mwr6j7WKsoUaJKNoDlicQzwu9oyBrseSjkpYJ2Ah9K8=;
 b=fm50J3QW5qUTiaEd0RsTPPqgSGEjwW6EgjT4GV22YFbsJr86hYfAuK5m2U86LXqV/A
 d1f2lN6X4W0l+f39toxnCIw12ExSwLf4gCArRAeUmW1Y41XQj7EIeAmmHakggkrWggMN
 RDz8N7PEFOLEUYsdqNUhIacUSbyoYhbJMRZa47fYTM1ENSoyMrBXfAcNrYE5Yi8VmJ2O
 2FGj5/0xbFsfV2Z28Ov5BIIsj5MUTStbXZ+wvXA4ETSdqTAMf5ijD/ujTcK9CmQ5nxLK
 dwTsFbCdhak1zpzTL3UzCUAn8L4tlLo9oE4ULcPSjieaBDrlsDbZ57K+MNIFM6UUYfWb
 3pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734445693; x=1735050493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwr6j7WKsoUaJKNoDlicQzwu9oyBrseSjkpYJ2Ah9K8=;
 b=L77/35XetKWSpz1Uqz2V1DrQWH+aclstAoGFJMGGNIla3aFag+Q/D5xTlDktptITao
 IulxZvMFSqP7J6mgara653n/KBA7T1GhwShrM7J6uYTwEBwxyWAA1dSVbFWV3DylgJ6L
 ML3Sm/8WWOH3EEnNYEtugL7LTqqs3BUZWMNykQTAXllkS2NT0rWZ1x2tGXWn/9CC6oxm
 1uiJe/WGsb+SI6kKyJ3RuqnjOVzcv7mrDh0P0Sj23FT6U+f6TatGcqeueuYWrZvLLpG1
 gicVa9V5pR4nRkFocZeAOh64D5C8fEFT5PbjspXZ47koHJU17AE8BGWfjiybrFl8RhoX
 UK5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDEvzHTHgiTqx2rnO+D5wza3MuaALAB+QngTz8w/WXafALAZB7shhoh2gpOA+USBjynQTxJgq/Xw/b@nongnu.org
X-Gm-Message-State: AOJu0Yzdik6Js63xYE5OxTZjpmQG+VMvF8auqZrgEo+EbdMXaVa+cHZk
 3oNNPv7MVUoO9erU1Y983IK5hb6+7MVGExh3WLZk4wfM+ZWRZT9d/J1sl7LkGJg=
X-Gm-Gg: ASbGnctYeXqJJPAugE3uzUTVSaxJrwrHw3wxQruVQPoD3SAZDOdIwibBf5gZ9zWXIIR
 oNuI/KdMiIKwRDRkS14JgTEdwvVPFzW6+1wsl+iB4R7oIKlOzO0ifVNM5DZK2FQuYqAFkkM+FAK
 +2uTJPDJsj5QlcunWVvN3lrn715h4pjjXoCkOCSlg9xxPw/YvUujmZVzU3ey9XesILbXokQi8jW
 nxniWrTCyqEWEJ4E4Znb4EZ4x9UFPGYBHWwaxLBaD5YeMo4dLi7QJNF2fMkBrQ/6aFI+yHCzk/0
 BQuD/T3h1vqGBlTwqI8Ug7/fe4MIERZyvGI=
X-Google-Smtp-Source: AGHT+IGq/QVziB8GatTC0StKVjZMJ3sXs+pj5j/6rLC1W2D+Q6CLwXhrN1Q6vR13uXaIW9ogLBMPZQ==
X-Received: by 2002:a05:6808:2219:b0:3e6:14a6:4288 with SMTP id
 5614622812f47-3ebcb276778mr2017297b6e.11.1734445692743; 
 Tue, 17 Dec 2024 06:28:12 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a33dsm2238980b6e.8.2024.12.17.06.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 06:28:12 -0800 (PST)
Message-ID: <6c6eecff-8d6c-4cf1-bc61-652fc3cc8668@linaro.org>
Date: Tue, 17 Dec 2024 08:28:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] include: Two cleanups around missing 'qemu/atomic.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20241217141326.98947-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217141326.98947-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

On 12/17/24 08:13, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>    exec/translation-block: Include missing 'qemu/atomic.h' header
>    qemu/coroutine: Include missing 'qemu/atomic.h' header

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

