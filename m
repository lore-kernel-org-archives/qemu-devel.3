Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B83C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqba-0001a1-Ld; Mon, 04 Aug 2025 04:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqbH-0001Tq-7K
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:31:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqbB-0008Gg-UZ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:31:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b7848df30cso3157152f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296271; x=1754901071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/PWum1oevvrXjHRPaCv4D/s3UudJKfjV3pTHU6mTbs=;
 b=x5kvfyPN/sg4/qNtH7nZcDeWW3UAxi9Ut4I2yT3QrvvYpPjMKpBUYbA0XjW2rX5Enq
 j6BZ5Z3YO/PlaCZafanwi9VrWuTGYstg7Gtm5UZiOxTRey+j4ivhPr+D0+kP94sUFQY8
 CPK3v5ME8pFEBIJi9uyf0EeCFV+BCjgnJ3/XI02vYzDfI5mUoshd0qpOJUsELnBbJszJ
 /KNfyOvHBaOMZlEddyCWz3a4t7p7L3EBFlr8Z49+7M9duFWPhh0S/SSm9RsHo5AyqfF6
 0DDXuYp/t51P2OTFIeszSVh1zoR4QCgxAS/7j6m3S9EFAuXosV9401hc9PSqt1D/rDQx
 5YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296271; x=1754901071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/PWum1oevvrXjHRPaCv4D/s3UudJKfjV3pTHU6mTbs=;
 b=Pg6IqiPLVgT4AfkzU24YXN0qAEt7vLOAaewvWras2OI5/z4oYgdMnnLHEcMCm/Y/ON
 9/ZQqaYfWwFTGOHYGL66p7G8x+eTW29ZL/FxU8dvVyZ/VhkRfViJ/uzIMeKdJ8lMm+mq
 lcpQYNx0xkDiFbHtJGDmaNz0BecOamyoNfjz73qiWeVnuJTcejk7+jRNhjhWw+mnIBdI
 yZyCm1eBWSoWOS9lCIIJMfD6YJ02mTcuvR8GCL0bNs7hUv2TdK+GN8DR4d5fUlh0pAt0
 3boKXaf18pfpiX7W1UgoZsZ9kkissHRYVPRQcQLRlvtY9e4EQTgmFVoVv99pwQKaUEBE
 12bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjDksrAlI6bsm4AZlefBAjAZYJcWDLR7Wq83tUCiozPX9PRskOsYh6Bp8LBAwUICcI3DZQSXMvMIXP@nongnu.org
X-Gm-Message-State: AOJu0YzBfcdAeZF27epF/RKA6wFxyOMP0kPfc/GgXfUTIXxg5y/WxpI8
 dCSM2RQvqmnNpNWA0f66ABwLI828XN9nFy3Z+lJVRVywxcDW3hI/5qaccE3RV1UNWvo=
X-Gm-Gg: ASbGncu/XBMw9lOwKMsGWbUa4Wiieo/Z+79g2yCI3eOmYyJFnWo2n6sH3I1H6VlJ2Nw
 /+g2I7JMNfgOL+2PwdCYk8ANg9AF3/LR4rjt4laZrimZPrhG0afD33YoJfmklaHQqNH86teN9Vb
 EbNVU9I7eGLOe1K4KrJyIW5mwB26sUc1pkI6ZjZn4hm2QBaxECCzfzFyWEDsI1lNDnRppLGVU21
 Nz3QSD80ihyExehWgarTMOi7gSBniVVTOvK9oaFaY1enYC6pwR7MknCGTowen1iDUwmyEME8E9w
 CMd6O5QKGo4VUUaxz+6/qe45cjWTzlcsCy1OmDTmnMk+A3SnKMox3DUQ0ZsIn07gDAyMHF+bUZZ
 W1itOdq2FKH3rVuQAOytDuwnGWwhubkJhUDZ9N+9ODcCcF+qL0jZSbDLhs8mEIfYVAMfwIOA=
X-Google-Smtp-Source: AGHT+IE6wvVfyGNblgO+t+512feofEPZOqwWpBASk/f5s9vQkQ1GVZbzucEiRAZdgHIy9MynHu9jgQ==
X-Received: by 2002:a05:6000:3111:b0:3b7:915c:5fa3 with SMTP id
 ffacd0b85a97d-3b8d95a520fmr3905959f8f.24.1754296270704; 
 Mon, 04 Aug 2025 01:31:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469319sm14511968f8f.54.2025.08.04.01.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:31:10 -0700 (PDT)
Message-ID: <ca897537-bbfd-47ed-b80e-66f357ef5995@linaro.org>
Date: Mon, 4 Aug 2025 10:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] tests/functional: Move mips tests into
 target-specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-15-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-15-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi Thomas,

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> mips tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  8 ++--
>   tests/functional/meson.build                  | 47 ++-----------------
>   tests/functional/mips/meson.build             | 11 +++++
>   .../test_malta.py}                            |  0
>   .../test_replay.py}                           |  0
>   .../test_tuxrun.py}                           |  0
>   tests/functional/mips64/meson.build           | 10 ++++
>   .../test_malta.py}                            |  2 +-
>   .../test_tuxrun.py}                           |  0
>   tests/functional/mips64el/meson.build         | 14 ++++++
>   .../test_fuloong2e.py}                        |  0
>   .../test_loongson3v.py}                       |  0
>   .../test_malta.py}                            |  4 +-
>   .../test_replay.py}                           |  0
>   .../test_tuxrun.py}                           |  0
>   tests/functional/mipsel/meson.build           | 12 +++++
>   .../test_malta.py}                            |  2 +-
>   .../test_replay.py}                           |  0
>   .../test_tuxrun.py}                           |  0
>   19 files changed, 59 insertions(+), 51 deletions(-)
>   create mode 100644 tests/functional/mips/meson.build
>   rename tests/functional/{test_mips_malta.py => mips/test_malta.py} (100%)
>   rename tests/functional/{test_mips_replay.py => mips/test_replay.py} (100%)
>   rename tests/functional/{test_mips_tuxrun.py => mips/test_tuxrun.py} (100%)
>   create mode 100644 tests/functional/mips64/meson.build
>   rename tests/functional/{test_mips64_malta.py => mips64/test_malta.py} (96%)
>   rename tests/functional/{test_mips64_tuxrun.py => mips64/test_tuxrun.py} (100%)
>   create mode 100644 tests/functional/mips64el/meson.build
>   rename tests/functional/{test_mips64el_fuloong2e.py => mips64el/test_fuloong2e.py} (100%)
>   rename tests/functional/{test_mips64el_loongson3v.py => mips64el/test_loongson3v.py} (100%)
>   rename tests/functional/{test_mips64el_malta.py => mips64el/test_malta.py} (98%)
>   rename tests/functional/{test_mips64el_replay.py => mips64el/test_replay.py} (100%)
>   rename tests/functional/{test_mips64el_tuxrun.py => mips64el/test_tuxrun.py} (100%)
>   create mode 100644 tests/functional/mipsel/meson.build
>   rename tests/functional/{test_mipsel_malta.py => mipsel/test_malta.py} (98%)
>   rename tests/functional/{test_mipsel_replay.py => mipsel/test_replay.py} (100%)
>   mode change 100644 => 100755
>   rename tests/functional/{test_mipsel_tuxrun.py => mipsel/test_tuxrun.py} (100%)


> +subdir('mips')
> +subdir('mipsel')
> +subdir('mips64')
> +subdir('mips64el')

Just one single comment here. I'd rather have a single mips/ directory
and keep the variants inside it, i.e.:

   tests/functional/mips/test_mips64el_malta.py

Anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


