Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6D3D70DE3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 16:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGhCo-0002Q7-O3; Thu, 28 Nov 2024 11:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGhCn-0002Py-9d
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:17:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGhCl-000827-Ih
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:17:25 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434aafd68e9so9051725e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 08:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732810640; x=1733415440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OS5nm/jAafb+KMAIkozylQFNHKvQ2k+drLRuUyyqxR4=;
 b=oIKwoWEGtylf2m8yvMx2TQ/HNoja8juRgmufxeqVpdbrruSoxrs+RUfvkbwc9/nKJa
 8N/5GIYT8K5em4UlHPNQf94cN28jX7Ozg34ITPjrkLXCMI1WwTcWU4JyIcaxeyyLQbvb
 UeZgbYKNllhHzwibQkYk2nvGSYpg6XESrLhv0CatlAJSBRZaDbDY6ca9csSmk9EMEluB
 qaOvbhN9BTW4la2tfcUAdrKhA4502geBiyOu0DdTnv7ExXneYTZBr+6uQ45UjS6eXQnd
 GsFW8LkJgS2vgCThoBOzbITniomh1tJWMRFvwwVPnuIuSUcRv+xMDD4UuyRhaavwTzTP
 c6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732810640; x=1733415440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OS5nm/jAafb+KMAIkozylQFNHKvQ2k+drLRuUyyqxR4=;
 b=GQf7IFNDIdcJscB3/eITQNjtHcV4C0i9XOrcVqxyrjxieB9J8fAK6ba2pV9MdMkhHM
 diOfh7cVnaYK7xzlFoJ/JsVllp7p+FVx1G6MiIM2AIn/QrpEiOb49wss2zXdMdviTWj1
 40HzRfjrOUCvUHGp7rJ/1W5f5UYImKH07bN0Bs6Zo9KFRkaF29r4kR7Fw/Ml2uLjqvat
 WEnrMFnstU6PC5QvAnyqiPmXy8/mXESeWHJIx80lE+DUzCJT/4zO7uKXfvOzhv92AdpL
 DeIbImQZ3A11x/7UDDlFI+XWAh4qQu2JxiM/LqGHWSwZlDppqanQV0lnkkYR4mlrE0jG
 zD1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWFY6AlDwdsJRMNdWIBhPE7o0P8gBREL2XkLkU9HB7qeT+H1kAifxsfRa62AgIeYB0h3b3zco0d+Or@nongnu.org
X-Gm-Message-State: AOJu0YwMeN178HA4ybRSscsGlPOFajiHpSh0Onf1Zwpr4wKNavWS/JNk
 SSqJqzo8hBzcCDemHWrMe2FgOqhOWDiUAhHRCbfGJOrwCfRXO+d+kcTmoO7v88U=
X-Gm-Gg: ASbGncuOy23Y+zXeoXAiht9kj1D1LCd4RlyypF2dXIiDV3rmeS9N1nmQL36rz93sOpa
 3PBU/ya4kYgnv6ALmYj80q7d8dwa6ORErqGLjfdUdh1tIC45yzPXzyVjLjaOO7c3nWGY1uXGka1
 48Yc0/CV4SDwBheO0NeVRV3qz+2wCXquxzZtKWdPTRHapw5MDUaVJMI5UYIYzqWTZ3MLFvGFQWx
 ufcS8bGbPXsBr4l6RwRFDcf63uy4YxyArG1vbngUpayOMkEotESNqMtfRQjSvdnSMJ44SPUsKUP
 mba/4FhqlqhRJTc=
X-Google-Smtp-Source: AGHT+IGAPZK1jdEYEh+YOkOP6kStavRr4DoWHCbtbImVjFeSO6OvySjPOIF+K+ISVfR7UacArB4iMw==
X-Received: by 2002:a05:600c:458b:b0:431:5ce4:bcf0 with SMTP id
 5b1f17b1804b1-434a9dc6753mr75355065e9.15.1732810640171; 
 Thu, 28 Nov 2024 08:17:20 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f70ea8sm26974635e9.40.2024.11.28.08.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 08:17:19 -0800 (PST)
Message-ID: <e4bd8e93-6ea0-4bf1-b0b5-4d0a3d1c3ed4@linaro.org>
Date: Thu, 28 Nov 2024 17:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_acpi_bits: Turn the test into a
 QemuSystemTest
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20241128115019.591362-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241128115019.591362-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/11/24 12:50, Thomas Huth wrote:
> By using QemuSystemTest as a base class, we can use the set_machine()
> command to check whether the required machine is available in the
> binary (otherwise this test is failing when QEMU has been compiled
> without the default 'pc' machine type).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_acpi_bits.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


