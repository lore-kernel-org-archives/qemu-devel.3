Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748C2C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs5f-0007wl-JN; Wed, 21 May 2025 18:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs5c-0007sW-SB
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:39:08 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs5X-0005jR-Mp
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:39:07 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af523f4511fso5609219a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867141; x=1748471941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JjFDse8vvxEF+z5TEd+TMPYfR6DXZF4ktjUOUAx1KzM=;
 b=aMPXKA7T78jdrO/FhPtY1I8/L7/JhCdc4hRewJVtJOu5TjywpVkTRV9tYGzH4ek68A
 B7oQBRhAWEfl05hldXN7AdqbiYmH9dvNpVnk0sGO4TSgCx+1CEzwgDPV7zX2LX47+V0l
 olloN+AeQY1WU9Nvp+2TW+bJQQGhITLyfzrDTnmBK4V+L35AVRE17uEHa6e4up0axhQu
 40c9/76jbZtWsTx4E4uE09V4JC1m4Yh7kroPHuQ/5YqYOcx+12Si4KAmHrjm++xl9DW6
 EsMM69sBgB3qGub2jKO12RrkSPF9cBmtENE07K6gwCBhLyRJzQsfLxQIAYFKrZ9ZeYGT
 QC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867141; x=1748471941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjFDse8vvxEF+z5TEd+TMPYfR6DXZF4ktjUOUAx1KzM=;
 b=CWvb8kby2C54kFLWAqjhp4IK2RDtO5EIErvwa3++apLSeWxBjM835H9Ip1e3Wh1FYD
 mFxDU64DBfaMb8S9gOEIz0LquK9w5vSpgF5JwZB9vsOjlFKs1SuvwpeRGCKcZhrzxJiQ
 2Vw5Oy6XCX0DpTC3sRl0rVM5ubVHc+0zvpOdf+U6hRRuVxVHbh3etMpUYgmq9JvKPSrN
 tmmBZkJwcFlJ2KwctK0yek6n9O5ULTbFDnPxXsb+SVYkOZnIn8A/PK0tKUvEvkCBMMMi
 pPc8B1BsUOR6dMXDpwVD+V53GxNc1qrXq+VXao7/AatXe497V2O1dFpE5Vg54L1VqJoW
 sgrA==
X-Gm-Message-State: AOJu0YzDROmm9EDFC3ZlG9NUVNg6IIiTdfzZdu0NfNLgSij4hPiKzl/W
 VL9HE/vgQZOXZqkYMrD11JU3597ABdggvF0l7rSvgjDrYX4KQwlS1BKk4Zz4IYh0AW1fJ4bCqt0
 gr9Au
X-Gm-Gg: ASbGnctSBEpRSNxK7z554e/7HrDLbU3Wyl4azU6AzLb2dq+l8fKvE3s15IlzsfNd8zS
 we4TzyT+IMdUQ+9jAzn+OtIh2/wEZ2kXOg7ozYM8ze3AoVhe8eIizWn8h4PQLGVabZDdbHeGLeN
 p9vLKoxnH9E/kBD+QlFzZyzTASm56LLy7dW1XImCBJJSWFhZpjK1TajLjLqZlLzjv8IfpTj4PWF
 th1FZrP0+PFMoOK/XZ1AxTQ8cIZCCeikIl0BnvOpX5l9cPQD2oZLBnUv0SoB4NVQLcsF2IwInzw
 n1AGmJ66OqkQIxFNR+9aLmIUAHyJ4IzfmdhMRF8fvPBIM/O4bnlTasRphQslXntq
X-Google-Smtp-Source: AGHT+IHT/4qENw/uP3sGZHwUmGTP+CZUWWHZ1CrSZppabxwdUWvp9t2RdiBUlJQvCXq3NZ0KmZ7zmw==
X-Received: by 2002:a17:903:3d0f:b0:231:c99b:9fd7 with SMTP id
 d9443c01a7336-231d43ad4b6mr320178435ad.19.1747867140860; 
 Wed, 21 May 2025 15:39:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adb71dsm97972575ad.62.2025.05.21.15.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 15:39:00 -0700 (PDT)
Message-ID: <740a64ae-fece-491b-aaf4-e2bcdd61b02c@linaro.org>
Date: Wed, 21 May 2025 15:38:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] single-binary: build target common libraries with
 dependencies
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 5/15/25 10:27 PM, Pierrick Bouvier wrote:
> Recently, common libraries per target base architecture were introduced in order
> to compile those files only once. However, it was missing common dependencies
> (which include external libraries), so it failed to build on some hosts.
> 
> This series fixes this, inspired by Thomas fix [1], and applied to other
> libraries introduced very recently with [2].
> 
> As well, we do further cleanup by removing lib{system, user} source sets that
> were recently introduced, by merging them in system/user libraries, thus
> simplifying the work on single-binary.
> 
> This series was built on {linux, macos, windows} x {x86_64, aarch64} and
> freebsd on x86_64. Fully tested on linux x {x86_64, aarch64}.
> In addition to that, it was checked that compilation units compiled per binary
> stayed the same, and that their size was identical.
> 
> [1] https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/
> [2] https://gitlab.com/qemu-project/qemu/-/commit/b2bb3f3576e5dc99218607dde09e25ac0e55693c
> 
> Pierrick Bouvier (6):
>    meson: build target libraries with common dependencies
>    hw/arm: remove explicit dependencies listed
>    target/arm: remove explicit dependencies listed
>    meson: apply target config for picking files from lib{system, user}
>    meson: merge lib{system, user}_ss with {system, user}_ss.
>    meson: remove lib{system, user}_ss aliases
> 
>   meson.build            | 65 +++++++++++++++++++++++++++---------------
>   accel/tcg/meson.build  |  8 +++---
>   gdbstub/meson.build    |  4 +--
>   hw/arm/meson.build     |  4 +--
>   hw/core/meson.build    |  4 +--
>   plugins/meson.build    |  4 +--
>   system/meson.build     |  2 +-
>   target/arm/meson.build |  2 +-
>   tcg/meson.build        |  4 +--
>   9 files changed, 58 insertions(+), 39 deletions(-)
> 

v2 was posted here:
https://lore.kernel.org/qemu-devel/20250521223414.248276-1-pierrick.bouvier@linaro.org

