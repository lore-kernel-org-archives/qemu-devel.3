Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D4CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNnI0-0004Sy-6O; Tue, 25 Nov 2025 02:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNnHf-0004JX-0J
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:16:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNnHc-0002vp-2i
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:16:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so29164075e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 23:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764054973; x=1764659773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VTS5C1whKDNoJXM70eFvD8TkIkr/Zu3Efqoz5ROp7E=;
 b=WbnJVhg//Cx/v1eOErcBkvH39BOAfTW2y25PMlY0ObhkLaClBS0dNU3t/HAisxbqR5
 wJvga756vQHaYKEKHf0KTGs7K6iwxKIwQZEPZtJtF6X/td5R5bHKx+Pr+WlC5sNMg8oB
 XQI5S6kayGMYKGiELrjVUC4l5gRszwCg4UHdOWYLDA3Xe4cd6aJHyCv93fgx+XrDV3KG
 UDdR/o5ji6O76KeFRcr7SVPIRWE8l0lz1eSK4uHig3PEovS3ewzdyzRGPIqJgnFIYayY
 D4EctEpXVC2ohWddmfgjTSaZpK/tetlVGbOUQ7GpsqDHi1GeOZPprgl2zbHdD3mEufcS
 05hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764054973; x=1764659773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5VTS5C1whKDNoJXM70eFvD8TkIkr/Zu3Efqoz5ROp7E=;
 b=syEquG75kotjkGgBa/Ic3nvpaM6sJFaWXrmzxq19vipT0++YIPNCZzP8PCvUj1t7Gb
 6BUkU85gio8NNKt9EYs+dfKPWZuaPPSI0dNjT9WCYIkJLmqvrk+16nULMz3PT8FIDV55
 o5QMrfhLgKU9nkIn/GOB73UxyOHL17hnnpU8TtC8cJrpWa1wPwULF48gQc2llBqyef4a
 EPahkf0t8KU4FSnqvwd3Nvmn04MrBVFO6ZC2r5n4aeewe9qMBB5rAy4kAdLhbDe5Z1Sr
 hre5tMoR9uz2shEPvU1jWGj5qbHvcqLj3x97bXXaShZOQ3Ega6EwX2KekEtSeNunX31f
 YXIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6i9fui6yMHLYpruXjSwcz747ZT29OR24ftwlXb6hmb8Oc8N5UVd1W2xqXUHqyB9D/gy0ElLpI1tG8@nongnu.org
X-Gm-Message-State: AOJu0YyH5wtaE853RwWJYZi5+Ay2/dTD/vx0h+bMzb1Bfo02M+9Nodkf
 /WGePLyvRMuSf6tUpqMVGlic7SOI5VHPUlTWSSfNFqRdpgiAI8LxjCBA0P03d5rJV7c=
X-Gm-Gg: ASbGnculkpmhjjLXuu9g8phdEVzQp2JW972UYRDsW6cUAQgwffLtxu+38NNzKGoE5C0
 QZtvXsaPQbVN7RvTeSHdlAXdQpFjNGsx0WFZTsCwm8VVwXsRt8NKIHLRmGe5B4beSn2RXWlTKNR
 cMJi1jPXkY0i+Xc4Lq5i7hhGiU8Qh5UFTe2Odd7YNjdd3xxheBxkvEX5OorXN72ZixFh9euvlsd
 ug1PMcDuFzZ3XBgvrUlMWsFpidvBPSEIsPb1uVY602MYpebcAlDYaxfUiKP7Ec3uyI8uJjInZv7
 PQZbacQp8O8x+4tXA4aprMT1itmljkcfWxxJLEhQlW7ftVwH6XfzF5fJtY5lDmZwk8tuJk25dFb
 XTZDmdriIHdxUdk1doBaQPruR3dH5a1bBaK3bQcsVwLVm6TiG2s3Uhk/nI/OiLuTTACYJ6tcpkb
 Qke8aguNzkGm4KpnmeHQoiglzVSLMaiZPtEZV1dbYtKnC4DgJ1Gmud9Q==
X-Google-Smtp-Source: AGHT+IF7Z/tlE4jPJpWwJk+zPS6NDP0CXr20BwIy46ATpDFvJJvXkmX83xrNXwH9MLQTApz/4ukwLw==
X-Received: by 2002:a05:600c:3152:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47904b24282mr13088055e9.29.1764054973429; 
 Mon, 24 Nov 2025 23:16:13 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040a9cf4sm12498545e9.1.2025.11.24.23.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 23:16:12 -0800 (PST)
Message-ID: <9101ea59-f9d8-437f-a8bd-872d017b0d71@linaro.org>
Date: Tue, 25 Nov 2025 08:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Fix double-free on error path
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, peter.maydell@linaro.org
References: <20251125070554.2256181-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251125070554.2256181-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/11/25 08:05, Markus Armbruster wrote:
> Fixes: ffaa1b50a879 (migration: Use warn_reportf_err() where appropriate)
> Resolves: Coverity CID 1643463

That was fast :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   migration/multifd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

