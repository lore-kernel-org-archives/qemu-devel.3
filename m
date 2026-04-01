Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4801AD35164
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7s3u-0005Fd-AL; Wed, 01 Apr 2026 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s3r-0005FC-Ft
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:40:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s3p-0007cJ-Rp
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:40:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so52412075e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036428; x=1775641228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kX4aBh3ZNutmzCXEGUcvM0doLUpfEGBDP4upOWLMzoo=;
 b=FiX+CQAEihONhF6Idl9GMNgeBLvwit7oNP1AU728zt0xHEzn6jkzRPEQHkLE6fmb8e
 01kqsBL5WEXETYSoV8+0mkhLAqoUxXVELy7GeIU7QsoAwNp1dwqOdNFLj9mseYivAFbQ
 aiLOsGKt+itiU61qh7KbIcJG3ruByL3Adh5qtt9zzccHFz9ktWUu0kjQtfCycia+B2G3
 5A2tC1jfFe9n1ng6ryOCYhOjxXUjvuvZrODaekAyZJLt9K0chTRGQFkPU4BdHPgptEdi
 dvlyuQ6+Qz5XY1Sqs/4ia5NI/hR8eQhvu9XFvlsvcEYp8748CMjjZslbEmlXvM+ZljMn
 2lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036428; x=1775641228;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kX4aBh3ZNutmzCXEGUcvM0doLUpfEGBDP4upOWLMzoo=;
 b=pSKKYunkv9VwFQ1OLQD7JB7YAHynKIo98iw9zjw0h1sihGw0Sf2kvw4zKE/fLh4Zjp
 n859qMgeacEtvBqYIe3gDB6hSh5WejFp7vqRXf197O8PbqD/4bewtQgHio6icESyDopi
 KV4OAMnuNduba2WW3vKLHNuvu5TJQMrWwbLA5wIb12bT8guJi4QVDOJ7PqDW0bQM4jeq
 G1F8GjmaIOwRZcyF2Jo8btq/eCVhJ0sO5HhJJtIOS83TgIbkDg6Hr02SJTAShavPwLlb
 ZkFytxSq+VBMF8BttgR8OCxbahMiFy/gE/GykNutLSqDlcBN8KOGg/jLZFDkD7jNqFnT
 XyeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqLGAGiMO6be2i6VH1X2YyQU6FQXEG8VntQYplZfa818mm4sXbdNTrLCcqT4yfVaYAKET80CnMy3q9@nongnu.org
X-Gm-Message-State: AOJu0Ywsd++viksJf0c2MT2cb0RsixGALZi5GcINgYOFYf0V3pphP/BH
 B81v9htR1BZw3AmwVDFUhVbv4QOUtwPPhOUBSpG/Mlv0vLuN6/qwclZR8VHEgGHp2l95qKzkEvw
 zOTO64UQ=
X-Gm-Gg: ATEYQzxfezg2dlWiSXeFcTWtP6Gw0Dg724ycGi+0iM102ntfN1QSCxjff8fY+7P+PX6
 q6Ut5TEDZ/hmrfeydhuesM1EjUungndba2V4ER1jKiNKT2tiUSnSNlgk4WwK2hk6utsxWDrz9qQ
 6gHZ8l/G4MARDZJauStNlUo/Jv1sREZJRi41KJRS1gTZkkXQ3M8n8XIJQp9BMYHuB209lXiYH8F
 mRrosZqzVpQfChW21cvE+gDqkBpup0AzBkkQS41WQCDRZIv2uHPjp9MjeZW2k7TVrleHr60O+Y2
 rtNXNli4rRqKyBkFNDpB5ES7mqREkDYh2hZPjA5FgrxdEkWJPCMOPd5AE3XKGNKj6AJt7T/fUUn
 opia+q5V/B50NzM69P3MLx1zyAwlgmt5DOWgLiLkm5tpuaqolfJ237E8BWXcH8FhWDtABS97pVG
 dT/r+ofYagY4ReX5Q9oqbyB3SQti5LmZA5W5DX5mTYHdk1494DbrQyuJh1pCGY+CecAQ==
X-Received: by 2002:a05:600c:a16:b0:485:a4de:f4f9 with SMTP id
 5b1f17b1804b1-48883599b21mr47987095e9.27.1775036428247; 
 Wed, 01 Apr 2026 02:40:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48880946cc5sm86141895e9.13.2026.04.01.02.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:40:27 -0700 (PDT)
Message-ID: <e5f69050-1431-427b-ac79-7b26f6130dcc@linaro.org>
Date: Wed, 1 Apr 2026 11:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 57/60] tests: rename the dbus-daemon helper script
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-57-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-57-48eb1dcf7b76@redhat.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/3/26 09:51, Marc-André Lureau wrote:
> The following patches are going to use it for qemu-vnc.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/{dbus-vmstate-daemon.sh => dbus-daemon.sh} | 0
>   tests/qtest/meson.build                          | 2 +-
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

