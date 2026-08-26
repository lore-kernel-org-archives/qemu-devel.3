Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE29EC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKP6-00038p-B4; Wed, 26 Aug 2026 16:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzKP4-00038D-Ov
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:39:22 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzKP2-0001og-IA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:39:22 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1220658a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787776759; x=1788381559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+8Tzwt5jAbFq6VTfGd0F2zcZQiOeBEAbJwc+3iUYYJU=;
 b=nL1uHrcQdVbsP7hyWT4CNA3K7tEpiUhHqE+Hy4x8qQmZ5y1N/oK38jyJbkOZctKwuI
 zJn5CSmj+gU4XzgV2nj+hhljNVyeMC1KV+JDZ5+b5vjyjSanVXS/cY86HYWQSHM7+nrN
 sIWQFNAhfalX5azAu8l9bUTE4rn4W3/Fy7nZvjO+jaTC2Z+X423plGBPMzjx8gpQWtRt
 dCSWk1hEQpXHAaddB6EVjbTSE76m0lSnq/SeQ/ANvvPDlJM3aNBUIBwoNvHR+Nsw7Wdi
 3TNMqnvrbeD8Zk0hyyPeUADYU3RGHTOznf6WAkx/4ZveX6c8d7qt61/ag+6NP0xHNY0T
 +EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787776759; x=1788381559;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8Tzwt5jAbFq6VTfGd0F2zcZQiOeBEAbJwc+3iUYYJU=;
 b=YfVCWm6CbSjrP/iOBhKitOE7EGLNUT2fHAdjfQCLkCbUYeTkxqN1ZKXcBHrcLq1Rd8
 GJfhdTfWgDm0nMRcu6RJA9XyMKHgivv/67npUMI7ufHitmMzC5WibNSgptEO1zHi06Zl
 wFBRKLjbE+AyvKdhmzQMZPIkDYvwAXFbebnjswMABU9nzbVzJHFIc2on0/AyjviFx/EI
 abXq79P4RPoPC7D3JSVbRn//H1ZOF3qAinbzPh4AuqV3qeWJ4195OLoCFscKNCzAmpau
 9b0lm2pDsiT6/4LiU1/QdgMSm96Y6xELTZXu6TVrEYu3/44B/5DRgSO2c4O+7wll+/H0
 f+fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUX7WtK38TClhAKD2yLo7S+lDbqVMCq+nYih2TpTnHUl9ubrzvc47WzM7LnufrtAEmvHwKd/0vd2lP@nongnu.org
X-Gm-Message-State: AFuF++lBH67Kl1v7rc0wMaaYcoDgBaeJVxLeR1O4kuMhdSUZcJx7eg+R
 TU5qZ2HGPFPAAKq4ScTcQR0T1hxYbgjY5pZSXXqkjp1M8Q6OfydN2VdM2bb2gGG7VrA=
X-Gm-Gg: AR+sD12xflnOWBHw0830LAvHN+/uf2wWgVq4HSSrCtLBzFxdcR0IzUVM9MhKsDKWMZM
 ZNMEYET2dFqDiuVtfVLI+uMxVqD7ez/A+TU+jWuc5Rvor2Y1lmpE3vRGPPGm9Prr/Tz/0265kC+
 NV5nlh83foGIupBVJt7pfhTWRRPes11gGjXXvlBk/WWE55WkgbEiBOXIRvM7E81N2Yw/TbgdJUO
 SdgIhri0PHOSk3imOlTvinVPCKxDKz0CUfE8RFcu6ACPxprdpwZlcRrtwrhDxYxgQj96w6pHD0n
 pxZZI51CIHPpVeqtsvi+8lmq+g4j2nO1fBc5wxb5SwPQwlGveB2baCmwsszfWZpZzGMINB9kwmy
 nIRyOZ0JS2iPs1ge0Oti3JBH7rW5+F2WCcPyBILsqoUm6b7sSq5PpIsfODqHm03X2hhemkw6aa8
 tfw580GDHh01hGqbep6y6T4ih+VFxbGfsp3NaumBi/WC+bNN8YXTMV39P5XUYEZC0Hy7DjCOYqv
 jyeEdXImjuaCXMVVMI1l6ejuy9F
X-Received: by 2002:a17:90b:4f49:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-3966d1baf30mr18338795a91.5.1787776758796; 
 Wed, 26 Aug 2026 13:39:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396825f2d32sm3478263a91.10.2026.08.26.13.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 13:39:18 -0700 (PDT)
Message-ID: <978aecb2-7116-4837-be7e-ceab6a4baa78@linaro.org>
Date: Wed, 26 Aug 2026 13:39:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] IDE patches
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260826111524.3383479-1-den@openvz.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/26/26 04:15, Denis V. Lunev wrote:
> The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:
>
>    Merge tag 'fixes-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)
>
> are available in the Git repository at:
>
>    https://gitlab.com/dlunev/qemu.git tags/pull-ide-2026-08-26
>
> for you to fetch changes up to dd90d3cd73b9b2b0f27a9e51bfe542b3a510545b:
>
>    tests/qtest/ide-test: cover the UDMA5 identify words (2026-08-26 12:59:19 +0200)
>
> ----------------------------------------------------------------
> IDE patches
>
> - fix the logical CHS translation a guest selects with INITIALIZE
>    DEVICE PARAMETERS: reject a translation the device may not accept
>    instead of dying on a division by zero, report the default
>    translation in IDENTIFY DEVICE words 1, 3 and 6 and the one in
>    effect in words 54 to 58, keep those words in sync when the
>    translation changes, migrate both the translation and the SET
>    FEATURES 0xCC revert flag, and return the power-on defaults on a
>    hardware reset rather than on every reset
> - harden the IDE and AHCI state a guest or an incoming migration
>    stream can reach: reject an out-of-range PIO transfer window on
>    load, refuse a PIO transfer with no command header, clear cur_cmd
>    when the command list is unmapped, treat a failed PRDT walk as a
>    transfer failure, reject a command header with an invalid FIS
>    length, and drain the ports on teardown so that a request cannot
>    outlive an unplug
> - report ATAPI UDMA5 with a matching standard and cable
> - extend the IDE/AHCI qtest coverage for all of the above
>
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: John Snow<jsnow@redhat.com>
> CC: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>

Applied, thanks.

r~


