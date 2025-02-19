Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF4CC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkkK7-0004e7-Eq; Wed, 19 Feb 2025 08:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkK5-0004dl-Db
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:41:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkkK2-0003x9-Vf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:41:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so22416725e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 05:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739972465; x=1740577265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHZeQfwCuwfvf8VjEKurcKIlj5FB9BlW3sG5BywGtj8=;
 b=vjgFFKi1WOyDTw+UbmKO9Ok3/c1xZYRatQJTrNfDv0PuD1qbzhI/an/Q5EDIkZCeF9
 i3uwZYkO7y7U3tBnLnnM9Ci9kMNZ6iHLR7VF16j9ygt0INeEWVSHKg3AzYyr8JQtMPVw
 5zj2Y55I8Ly2/EoeIEKBWQIrUJOVgIf2OM1XLAocv3lR7Mz5SVh3L++OA9dlM2ADgPSm
 doiUyeSNVqh784u0VbqOr3B1Ohzn5fjVChPp2862Lhn7c+5rdfaxZVIoZfT+hjBhJ+BQ
 C5ZehPOEZ7KQttIngUkvZivKGBhamoHfanEZrZyn8sWE2YvC3X08Ye1FqZOkuCRQEddd
 6QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739972465; x=1740577265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHZeQfwCuwfvf8VjEKurcKIlj5FB9BlW3sG5BywGtj8=;
 b=WPg1oK88l/ZXW6m6EasJ/VGfXGvgDiyeBJH3yFkmRfgmRsYRdt0LzE0edn61v4PY6X
 vzEtyzv33rPOtrDirbTYq3+/HAmtpRuoYSDBBDCKxxFf0pkt+MBwI4VeMMKa/ch4O677
 u9v2qn8KhvxxBS+PwKwumID0dtTQvUcCrhNV4J5exNEcLLDWwVekKfaqpEX/mb8dHmrG
 jJnw68uAn/isu93hllS5m/qAmJwGMabMPuPYMpM8ptqUcmfUmek5IZJL4fp+eZ5Gd/ar
 UwoS8bsfVXI612ZX/vvRJMVBk2DJdgig6AHme4i67plT7qoT2weq3bNapix+rnWNkA/x
 B/rA==
X-Gm-Message-State: AOJu0YwY819D0KmiyIpUUbtTyK/UCtevU1cq/TisSwhKmKcOpF5Afv2F
 7KkUSEuUuumFhLMOS1adzyhCT8EKAJKnX5tXdZQRzo8FcnSSulIv10+hKHSdJfw=
X-Gm-Gg: ASbGnctkyyoHH5kdMvC8JT7iyWVwzCM4thFa8VmlxLuOMB8l+h9Kk+FpAg7LVX+ZukR
 Qn9LM5L547Gu6Du25xkoa+CBVNzbclx50toRs9PbNWCx1egX3vQ05C4MdiUYjk1oagile9k553K
 385uB6tsDfgOG/6XR4PUoJ9WtMfpCDiV5imvJbDqrdb9YAvewXJ9e8yHHthS1wkkVf1NbYLT5q4
 mOZyryEaCT+CPSB6OG2VsbUitbuQE1pTyuviWbzqqH7QSrh22zDS0JaOfTAqEV0zOl8ej8Zccj/
 b5UnJHPkTdBXWSmo+uktVfzf2odBp252a6hLedbH4THBoC3CIki0YPUWJIs=
X-Google-Smtp-Source: AGHT+IGu5LVirtQZyv5EBKK36R2c8eSKmmIZbR93dYk4omzPEdDn1KRJn9mUNUiQjYRHz9Y5myjFpQ==
X-Received: by 2002:a05:600c:3ca3:b0:434:eb73:b0c0 with SMTP id
 5b1f17b1804b1-4396e6d4b6bmr185234105e9.5.1739972464987; 
 Wed, 19 Feb 2025 05:41:04 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7979sm17647983f8f.83.2025.02.19.05.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:41:04 -0800 (PST)
Message-ID: <b31b7131-7e19-4c51-bf89-a5876e655fa4@linaro.org>
Date: Wed, 19 Feb 2025 14:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Display summary of Darwin libraries detected
To: Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>
References: <20250212112958.38023-1-philmd@linaro.org>
 <c33817a1-74d4-47b0-93d3-000cfd6200be@redhat.com>
 <CAAibmn2Ohd_-k5LGqo5m1xzLrrs2UYxCT6U_XEKsJYScfCpx6g@mail.gmail.com>
 <CABgObfaq2m42tBUAmskSXm-fR6zKDtApAsR4rYYqg8dnMq+Bog@mail.gmail.com>
 <CAAibmn3MvZtng=4vAGx6yNfMkM+u_HRbT0CAA6WhdbTtLDE5xQ@mail.gmail.com>
 <CABgObfZzLs+yByD=736PFw8ZtH-OcJkxZiScaTWktdrY1+5e5g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZzLs+yByD=736PFw8ZtH-OcJkxZiScaTWktdrY1+5e5g@mail.gmail.com>
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

On 19/2/25 11:38, Paolo Bonzini wrote:
> On Wed, Feb 19, 2025 at 11:36 AM Phil Dennis-Jordan <phil@philjordan.eu> wrote:
>>> ... which boards should enable MAC_PVG_MMIO? Is it only VIRT, or something
>>> else?
>>
>> I doubt anyone will be able to use it productively with virt, but I am regularly surprised by people's creativity.
> 
> Ah okay, so for now it's effectively dead code.

Correct (still tested before merging). I have Phil's vmapple series
queued but it fails the '--disable-hvf' build config so I had to drop
it before sending the PR. I kept the PVG device to save Phil from
respining again and again the same patches, hoping for a quick fix
to merge the rest, waiting for an update on whether Phil's suggestion
to fix the GIC dependency was OK or not, but no update so far, see:

https://lore.kernel.org/qemu-devel/CAAibmn0puNwDvHcU8xYi1EJ=dnAEhasoTKCk0kmF4DiQfR7dHQ@mail.gmail.com/

and my proposal:

https://lore.kernel.org/qemu-devel/20241227202435.48055-1-philmd@linaro.org/

And now I see Phil's reply which I missed ...:
https://lore.kernel.org/qemu-devel/CAAibmn1g6+btdRX99ZUvbaBm7hP_AnAGNfDHz4Wgi3fPn=waOw@mail.gmail.com/

> 
>> The intended target machine is vmapple, which is the only known way
>> to run aarch64 macOS guests. [...]
>> I'll try to rebase that series and re-post it in the next few days
> 
> Thanks, I'll keep an eye on that.
> 
> Paolo
> 


