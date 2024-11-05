Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD61D2B92B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jrh-0003gW-5u; Tue, 05 Nov 2024 08:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jre-0003gB-Cj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:44:59 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jrb-0000bG-Sx
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:44:57 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53b13ea6b78so8601953e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730814294; x=1731419094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c3aoQgldD43PHs/6k8QsXfJTzVW7Rpwn6Nrt8InQfuk=;
 b=UYGr3PDx/B5kixCH3ZV3NfCjKMemMdbS1NBGoFlzUinNHEgnUN/F7TutYl5KcjlSGO
 krXW3gSpsEwdO7b2XjxKRejzPplFBkNeFbdDBUXHoY4wTZBUxZPHZsVRULAtgcgPQU1h
 +CMJVp2uLGRQtyqMP6AYN0ZNQ3Gm2axs8uuDxlrqCyQmimToW8YkQVJ/K7NgdPDwqRKY
 oFmOYpSI/KxGe08yXjmsPU2HcJK1gq6CCRHMHNW+ECepJO2c4oN0E+R479crPx3U0APJ
 TS0Fu2BEBzAJqbW6BkwmcBBwWlaxiYUyJI8s9HNDv3RuZJbWmpVXE+B1n0mxKyYtHi4+
 H9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730814294; x=1731419094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c3aoQgldD43PHs/6k8QsXfJTzVW7Rpwn6Nrt8InQfuk=;
 b=PsrpbDQr337FuYdJyaGzYAD5vuAiWkYDP+v3mnJlOd24EOPFV/FsOdMaGv5U+migx7
 fwth3op8trDZh3f4bO/Ab0k4eLl25swCjGRYFY5JcNfJnL42dC1eQjEgHommcVvqyzbT
 tLP9deSkuj9pt+wWUo0LBL2xtfU2RprnyNMAZS82VIElziXmW5cecMH+uS3DmoJ6Nuvw
 /6Ngi4SCtKl+M4ugWI5leL535O/t1lUwEL3nl2TffDM1gORRKZ8lRfsbagwnIJTziweA
 0zSLrKDDrSn1qBH9l4fHm8a/D7LeSev3xldh9yskubjF0+78FsnxL8NS5EmwtUbcSQqc
 3swA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6cqJho8YsnEuno/XBQ2wOcWrLR98Jsj2Zf0xFPdzAvw9GD5uQNq1kmGB2pRRd+yX4cNRpZSLRKOGn@nongnu.org
X-Gm-Message-State: AOJu0YxvueIkJ1fcJOLggYVkMPfphy/FBXbpHbqplB2J5ePRNQ7Gc9Hf
 HDn5WE6nEfoJeAnWuCwmhTkOdotnjsTNPM8psviIOndRzK18ulUaOJk28XX/SS8=
X-Google-Smtp-Source: AGHT+IHM4NWWfqfY43HQzkXjeVqtv3CyaFbOYDLg4SiX5ycF9OaOGwmw7VM1LveanVsmqZwQahspfw==
X-Received: by 2002:a05:6512:398c:b0:533:4785:82ab with SMTP id
 2adb3069b0e04-53d65dca853mr10449603e87.1.1730814293733; 
 Tue, 05 Nov 2024 05:44:53 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb1813841sm133549966b.178.2024.11.05.05.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:44:53 -0800 (PST)
Message-ID: <c27c6a0e-5f26-45b9-bdda-28e384809f9b@linaro.org>
Date: Tue, 5 Nov 2024 13:44:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] tests/functional: Explicit endianness of microblaze
 assets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x136.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> The archive used in test_microblaze_s3adsp1800.py (testing a
> big-endian target) contains a big-endian kernel. Rename using
> the _BE suffix.
> 
> Similarly, the archive in test_microblazeel_s3adsp1800 (testing
> a little-endian target) contains a little-endian kernel. Rename
> using _LE suffix.
> 
> These changes will help when adding cross-endian kernel tests.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/functional/test_microblaze_s3adsp1800.py   | 6 +++---
>   tests/functional/test_microblazeel_s3adsp1800.py | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

