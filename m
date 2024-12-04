Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00934E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 23:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIyrz-00021R-Se; Wed, 04 Dec 2024 18:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIyrx-00021E-04
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:33:21 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIyrv-0000bY-FZ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:33:20 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea47651a10so140422b6e.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 15:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733355197; x=1733959997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h13zZBrNXWxXS+eEesA9DkkUiKVM1BJtuwIy0tD0Yxc=;
 b=Cl9ZG6EAFy7ZAexaT9RaD6cOtpx+Efo072JJsrMfvxEwf5SaBOJgex1RgB1Iwho0lo
 HU3JeA6TmJ8rwxMPdMlZVypZovUzS90A3Vulxl2k0OOPP4bkdvAUpFnGjaUwmo/VQ825
 QctRTu5AfC1Dk1sy48aU3teePCgn4/WIOJrejbQiSmmPm/z/DJvGL4DCpapOn0gilYXV
 bJDA/szhPFgYyjgUzEJp7UZr7W2/Um2ezsZIJEe8RJIk6KGyII2Ut4sLQxYaKQXHI/Gp
 JikERbckkeqQ7pYRRbEq1R4pzCdlDxQDlnFSixws1d+sSPMyYJc+x68he+zJJY0HitFv
 AfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733355197; x=1733959997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h13zZBrNXWxXS+eEesA9DkkUiKVM1BJtuwIy0tD0Yxc=;
 b=Z10Xl1Vx9U9vXMU1yvg9sihjj2mYhBFguuyGqSE7Dx2rLAl8GQnLmT+x/7DqVzUks3
 A9OPG3PGxC430qr7d8rhmF0I8eMmDpA0FEFfTMCc2ECOqeSM7idygLcKAIlYrrABpzFU
 NqfriqnyA/I4vDzAvkdWHsiR5U/1uDlgtyd27CVx4nty++YgvLd42SFp/sX05LrC7v/R
 76ZupYLcsVXiJF/LbzxZoxh5BihnKzvvyrQUg7EWl7eCoNfLHjJOEosT0f/ztD5qzRlr
 c4nROvN1SiWN6DvR5AMY75AROWlK6kZ8//HF6MSI7e5eM58d7J7a96crxa11kGJls1d0
 Ub4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZnvZn6FPMgmUW4ufte3BS1Fvx4xWMJEyADz1OAvMb+A1Sg+7gnwF7zW4bydGWbAVZWmtK84Uido3h@nongnu.org
X-Gm-Message-State: AOJu0Yz/82f51magweDOXImSWSMMioeRr2bL5gnLu5pLDqgdO33Im6+V
 JfZDtxxN2IQGa6zYtMV9GCBaZ7j5MbBaEIpjJw7TxsyWDjMewoKbwwGNoWjGus8=
X-Gm-Gg: ASbGncugfdgMoBdkPBSRsiH8U71sEk9A430M7Q3GedeiMJYJH9aGxTjuFcA0E0fVQ8l
 3iF7fEdvTdOF6SdTxxKncqi2P8TuujpArxTsBdxnxCVJzD62yI1o8mBQVEVLC0SWfBAJJVPErJz
 KT9ASgj0vO2RovlKKe0yqcYqM1c7znLeAvvKR71YtEQavwsJiwqc1WSpeDGv+mhC+KMiqrmCvax
 QsWswy0AUCedMiOSaxEZILEVmx+CEUn94zOv6M49/l343YpZcHr0sLE8cP0rIfH0M5Rnc0cCu/5
 NouLFOYWRaAMKGxhIXtMe3dgX+g7
X-Google-Smtp-Source: AGHT+IGw0f8m6uM2auqKcamoh/yTCEJDUMLW29MvchTEZj6JOUHuLc5maFWIrB3HoWW1NDJOYPkRLQ==
X-Received: by 2002:a05:6830:4492:b0:71d:5f1b:28c2 with SMTP id
 46e09a7af769-71dad629ca0mr9001337a34.9.1733355197196; 
 Wed, 04 Dec 2024 15:33:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2791f7199sm77034eaf.1.2024.12.04.15.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 15:33:16 -0800 (PST)
Message-ID: <0aea264c-c284-4543-ad3f-be40f5b9afb0@linaro.org>
Date: Wed, 4 Dec 2024 17:33:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] exec/tswap: Rename target_words_bigendian ->
 qemu_binary_is_bigendian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241204202602.58083-1-philmd@linaro.org>
 <20241204202602.58083-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241204202602.58083-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/4/24 14:25, Philippe Mathieu-Daudé wrote:
> target_words_bigendian() doesn't return whether a target vCPU
> expects data in big-endian order, but whether the*binary* has
> been compiled with big-endian flavor by default. Rename it
> appropriately to reduce confusion. Mechanical change doing:
> 
>    $ sed -i -e s/target_words_bigendian/qemu_binary_is_bigendian/ \
>        $(git grep -l target_words_bigendian)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/tswap.h     | 18 +++++++++---------
>   cpu-target.c             |  2 +-
>   disas/disas-common.c     |  2 +-
>   hw/core/cpu-sysemu.c     |  2 +-
>   hw/core/generic-loader.c |  2 +-
>   hw/display/vga.c         |  4 ++--
>   hw/virtio/virtio.c       |  2 +-
>   system/qtest.c           |  2 +-
>   8 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

