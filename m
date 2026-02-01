Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9EFE6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 21:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfBs-0003E1-Eh; Sun, 01 Feb 2026 16:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfBq-0003Bo-Cz
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 16:41:06 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmfBo-0007aj-Qt
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 16:41:06 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so41773465e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 13:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769982063; x=1770586863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=muz13GnzKJs5vaQhqJrLdT6tgHb7U5J6KiUyMqA9aRI=;
 b=IcP0f9cphDPFmrBLaasRPGIvXN2QHKTbr/yCongEbqVEm/QZHIbwy6NHFy0Exzq22y
 /i4FjMNeMDmCdoO9pt7ItRr6rG7XzGSgP373b2H3y1B6+p3lMz7WnKEdst+GeqFEbB84
 mJKmwlafCgArmA/SvpE1cHnrx+XbM1T+Em5jrU2KnbPPiamc2Zx3ojnmpWh9UHV7grQP
 LM4FSLf1WGAnDap9PfYi/Q4WVHSQWgxUVT9rGly4VCwQ/KimI4wI1IvQZnU5FFwMQ15i
 qIqTUGoOcF4Z85J4RK45IFKpL/OuuetFpV5EbpmB12ZBlr6bH9k+A6b83uHdOlYIc6KK
 yMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769982063; x=1770586863;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=muz13GnzKJs5vaQhqJrLdT6tgHb7U5J6KiUyMqA9aRI=;
 b=ETVIUnNctoSPzMwx319VEkAzc3T5WkJe1rm7lLR6BzW9PZZl+K0tlvwftAQDcijXUP
 Lxqf3QdJ3WptSiqqGRHEl95dbjqBW4qe5hvNbxTrzMRwtlOqarUT3kVDJYBKRWgwUFTx
 OyJQCIokCxca9wynYsCchdYby9nHnOJW3e+LZJrw5YfsuckSUB4bVwyrf1rx973Pyruy
 APl8jwqv1Z7YghIYX+CWfObGosMlyp73nlcejF1tr/DjaLsMOE3lxglb0OCZqb12y/VD
 KCxKZpbTbx0pgJlj12F6SzLCxJEjYlIN2h5CyrJZ5xEfn6MWQOaGDCE+MKOlTSSi26Um
 NjHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1juUHcoxVnMxrF/E7gpKTLVfiDZHx4Hw9DLsaD6T2AzZGxWztqQefiUs7eVfgJccVAfYYLE9V07QS@nongnu.org
X-Gm-Message-State: AOJu0YxFrhDxzD5OqPPRN6bZzKwl3Xbto93SCoGDW3V3/xrfZuh34sgi
 Bz3AJxtorITYMIL6fPzRSFCTBhBWHgRzmMnPkHgDNTm/Kereoldiep053utj1B4dWN8=
X-Gm-Gg: AZuq6aKFv8cqKuRO+ZIQVz/f+m8D8R6d7qo7g/en9QaG7JIswe89O/us5UFdPRPR7GW
 FtNJsIqY+fa8+3pZF5s3i57IEJQNlL/wBTKUwuZ4VqoM28n3yrqATNs1vD1eelnUQpDWC71klv2
 o8pPHwGXzWTOfyTM411Dccu/2+3H7c6lrsya+8QBwU6vSbar4tQDiHEksz4X6/nRu2f56DgAbn5
 95j25Xx0VB0Xi30H4DriiiNHmuGFg7fdtYhon02wqo8SizyfVO07VqoMAHTxN4FECYpeJlAguLu
 t9Uf4xJGVhUgGB2390dyu7MEmMTtduUEiiO43I3NjQ8ytbi+eB8pKU7/5EJlk60uC3S+q5Mz0vs
 W6Eb7zYfC/5mhPcyJQfWUvLQ4IavtFO23mlrzlI41VBmtOIjdn1faHTABXAfxhWZFyd60zJInef
 2izDiw8JnHqCvtFZ/eF+aEb68P9nNYilqQqBiBDacqIUmf2RXQXQMFnsKCi1WGmIuH
X-Received: by 2002:a05:600c:4443:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-482db4a0fb8mr137973365e9.30.1769982063057; 
 Sun, 01 Feb 2026 13:41:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbc7f580sm95142685e9.2.2026.02.01.13.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 13:41:02 -0800 (PST)
Message-ID: <019fcc6a-6129-4c0e-8a7a-8728eb50aa8b@linaro.org>
Date: Sun, 1 Feb 2026 22:41:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hw/sd: Improve performance of read/write/erase
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20251202-sdcard-performance-b4-v2-0-d42490b11322@avm.de>
 <ht36imgqpzddppbmkhsb5uuauqtwdozqg4eexjfyno74cnop5s@ta5c4wtovyp6>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <ht36imgqpzddppbmkhsb5uuauqtwdozqg4eexjfyno74cnop5s@ta5c4wtovyp6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Christian,

On 19/1/26 08:46, Christian Speich wrote:
> ping?
> 
> I'll rebase it soon as it won't apply cleanly anymore, but I'd like to know if this
> patch is generally going in an right direction?

Sorry for the delay. I'm happy with your series. The only issue I
have is patch #1 is too big, making it hard to review withing missing
something. If you can split it, better, otherwise just send rebased
v3 and I'll try to split myself during review, and post as v4 for
you do double check before merging.

Thanks for this speedup improvement!

Phil.

> 
> Greetings,
> Christian

