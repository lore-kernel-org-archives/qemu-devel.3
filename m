Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FADC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYiH-00040Y-1G; Tue, 15 Jul 2025 02:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYiA-0003xF-E1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:00:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYi8-0007yB-FK
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:00:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2304836f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752559214; x=1753164014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WGiQwGN6ypQgr72KRxvOA5uv1G7IT6YtMSXt8sKtqh4=;
 b=CPTYqeUsZMyY/jmQcBFjiqnqhxjPKfhh/uiBmw85LzhzVPTKYrpIiH7AIxq8L5UJpN
 Gju636+oDXF+1q5YJnF/2albuwVRdNaOT9gcnXaDuJ5Mnaec8VaSIrJMPIE2boF224Iu
 Wu2aQ7lVUmOh5Q6xsBw0cMExgVBNvlGlUek+RuJziHxbQgKJgvza0iIIAMK+ZljPU6bm
 dIzEgl0tuKQZA5cNMjtlIl0dqzv06/aPBoSU3ugfpmMpxt3gF6MA0G+LcdqGx2xUTvWO
 /RsOzl6nf+sPulCSlEPtWExWgAXzxT2cNzwpof5rNJY/CT+AqZ0jXrDb0M4fhdPA3cEc
 LFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752559214; x=1753164014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WGiQwGN6ypQgr72KRxvOA5uv1G7IT6YtMSXt8sKtqh4=;
 b=FbDStYcWOc2t7WqfvzLGp2tBccNIlh0c0Ue0YmgQVMW8BbFXyAAFUX1/Kt3YBbd8vz
 da3EW98308OswFgop63NyspdpYsIZBBHCdkPrNmVBJFwL4esfWbikjaXPnYhMAgsryRN
 QQM0asHqWyaOG/NIkOc21nNyz5Q67si9pHLYpEcnXzN5TOVV7v3XmqS9mTwvK+XJGb82
 wtNQgcXoJeWtl2GZpeDZaToR2BV1YTUEpCyugiqzocTwKXNxalm3Kz1auNBGrZhmo4sZ
 Csn+N+pKXSiK5o50wxOPXbesZ5gU6hssLNCDgNH5MWxwhpUoeYauvpgPqB4EICQ27dZA
 LnLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT271UuKUYSPXwKA8jLKoN6Wa8Q3XAzhvqPp8teOZhnO4tyAQ6/AXNdvmRn5KE55/ojYs3CKmG9Ck9@nongnu.org
X-Gm-Message-State: AOJu0Yy3moNK0njm+0yiDApFAUQtJnq2sFqo+HtWdrSG/Kerbb2DC4ib
 V3OGqMhs++0YaanXUx2JB9gHK3aifHBeJWodIcGAMg5MFMIbl0qKYasBO6GpCmaeC8M=
X-Gm-Gg: ASbGncspOiiDJcCY9PbG1FIOEDQXxrr0ljGDEyjfWTbW4vOLR6TKuzndudq1MdRQ8FX
 8UC4S+kgGyr+GislKLZnNehIoW0ddNnT9God1oY2MbBkj6fcm6BtdP1rJwWqJEe3UuxKI2UKxa3
 34WiJvyXwTMeIIR525MJwbNUZkvdgd6vTs3qZWVg/aFcWpx7Y5hwdztK+/DSJefk+HhbHhX+ls4
 fuyrE2uQfXAi1AGwa/GLoz+I3qDikcPMNIlEFPlMVBZFsPupiafkt3dxufrKQIq973eDVo9e58B
 jbf5KrHwFmtG3+ttZeZNvBF3NvaOPw4l74uXBzFPdEeT2luTe7NQr0U+itAPGw6ormsfpH8v2kp
 +Ly8b5FmIz5ARMHx7vQ13BzYczeV5P+6++qLf0XeTxI73+VwcWYiTyu1XVVgZje6Yrg==
X-Google-Smtp-Source: AGHT+IGivnlWZ7ycUc1pKS4NY3WFXGGuEVcQ+39066cJtJSwXfjP3Zy1que4GeLeCi8x283GagleBg==
X-Received: by 2002:a05:6000:2012:b0:3a4:ea40:4d3f with SMTP id
 ffacd0b85a97d-3b5f18de8demr14270689f8f.53.1752559214266; 
 Mon, 14 Jul 2025 23:00:14 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5f16a6016sm12316792f8f.69.2025.07.14.23.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:00:12 -0700 (PDT)
Message-ID: <5454f715-91cf-4c2d-a664-966f91214064@linaro.org>
Date: Tue, 15 Jul 2025 08:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] Add support for emulation of CRC32 instructions
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "arikalo@gmail.com" <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20250627000246.1811052-1-aleksandar.rakic@htecgroup.com>
 <20250627000246.1811052-3-aleksandar.rakic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250627000246.1811052-3-aleksandar.rakic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 27/6/25 02:04, Aleksandar Rakic wrote:
> From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> 
> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
> Reuse zlib crc32() and Linux crc32c().
> 
> Enable CRC for mips64r6.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
> ---
>   target/mips/cpu-defs.c.inc                    |  10 +-
>   target/mips/helper.h                          |   2 +
>   target/mips/meson.build                       |   1 +
>   target/mips/tcg/op_helper.c                   |  27 ++++
>   target/mips/tcg/rel6.decode                   |   5 +
>   target/mips/tcg/rel6_translate.c              |  13 ++
>   target/mips/tcg/translate.c                   |  25 +++
>   target/mips/tcg/translate.h                   |   2 +

>   tests/tcg/mips/include/wrappers_mips64r6.h    |  35 +++++
>   tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  42 ++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 142 ++++++++++++++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 142 ++++++++++++++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 142 ++++++++++++++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 142 ++++++++++++++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 142 ++++++++++++++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 142 ++++++++++++++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 142 ++++++++++++++++++
>   .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 142 ++++++++++++++++++
>   18 files changed, 1294 insertions(+), 4 deletions(-)

Thanks, patch queued (as 2 patches, tests added on top) fixing style
issues reported by checkpatch.pl.

