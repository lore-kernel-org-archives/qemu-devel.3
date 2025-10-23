Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F69CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBp8p-0000D7-H8; Thu, 23 Oct 2025 02:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBp8m-0000CU-0Y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:49:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBp8i-00032z-Hf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:49:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso401099f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761202174; x=1761806974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Rl8enOBl7vutIaQbukrZ57LYa+Xe74Ni5pvEr1Gvio=;
 b=yQgp4FUEM/z/JXW7KJT8srBnQKc1BGXIBR/8/nBuelF09sE6RzbmVSE/Ikjif/QW/q
 h9fqy576U4cr8m5fWZdrYDc7ygXN/hnq+/CnHyoPtUvXGl7BnqJhU9yLRWWpleqkKsUh
 gUMrKks1QmGBcdUJku/2cgF+zwg6o4jb5kKFkQXJlwgpvRQUPRWrexc1HRENoBuxV2yx
 1mWZrI0wob5caQVpU/kImxODDeMBa3hJToh0P5GWMYSe6otGKmr8QxGbn8P4+qTZyod+
 K/Szc1ZL/WvPxL1/e4Fsry9luIPwwfEXVS7SnUVJ0WIMi2O6pSwLAeWIHqcZCn4EKqip
 q11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761202174; x=1761806974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Rl8enOBl7vutIaQbukrZ57LYa+Xe74Ni5pvEr1Gvio=;
 b=ofqAFIkWMhz8kpa7YyfX5tnhNyReXesL5hpxSLgbLsFJaXLnw6Qa/GwuI7Q2QW0TjF
 vtzJ3BlQW80R73wJhl5HXavqQyZoz2aE3K/kjIeWfi4JtU4dpcXDKuRl3ZwmojQD9L5S
 bldRnFO6ykfohP8LEkoVB8uKBPOgzZSjdp4HVjFuhFVXb72cgHDkrFRn0Av/4vKARpX9
 AtqniH2b9oA9QisuRDLgTFNvgGP3lkPMrX5MaNsUOjqzFQ7VYmgKTwodycLQhkcUhgvO
 6gK9c3phbRrwLf+qv6oiAADIenx+J6nRfTSgIzp9o4FRhl4YbWAQiKcJXUevy8grkg3B
 0d1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ6iWHcB25OMWZDTnxKhXdFQAUvIrsV4R7z16V/3NXQpqFGB/0kKgaYgG501624ELPLCGBS8AQ6QPZ@nongnu.org
X-Gm-Message-State: AOJu0YzABC8i1hgnz9nfZaB4GHQAftmZUO13KIt9TJbcoEqDXyPa+Itc
 lk2KqB57yFFiq0hB8WbHmrGW4T+Itj+y7Avl8yHZXwEqu4U8PoRRHBfJrHX3GpkZBss=
X-Gm-Gg: ASbGncteSl5R773CSbXIVlH5xmAj7yXYK+T84bqHJm/fPhtOWZN2eurZOs56HsY7ccU
 yN831NSCGaBqvEPyACcIn8wXTNSHqX8cp1rzXDieH3sCTOHXdSCYf3v/QH8xW4d0lmSj7Ot6d6z
 zHq5C5TzMTiuNtTag/a5f3jACPLykveVRd0dcKZgZK0LwzL/Oi3euHb13TnVg1m/ruxEMCsKW+B
 YGuDxhn3rRgoQhIO8fHum30YhHWWiLiTYV4XvVB//gVFzzuGi55E4ddj2E4tdvlwgM7bG5hjV+y
 FbPijoa3K2I8zPYvAcGUXA2X+2euUEw/hZl1EgvZY1BbZYV30k8m9VxrZsYEiP6KHZ8bACg+/Dt
 ghuyhHbm1L8kRARGk725sUoon5Yf6Uq/3tEifdZnq4wVHVyz9PNYJaCzg/UBEvdK3oo1Zn4UOKg
 evFxeZjqpL9nl4f/320tzJuEm4Io1TEn6hUJNUyi2xyoxzjlgGcryGyw==
X-Google-Smtp-Source: AGHT+IFKnMNZQGeUcOQLByULjQUuRX3ryi6wonLp9KD9fB/ZVWauoQLCQtBNhOjfO37sMrqNtNLuEQ==
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id
 ffacd0b85a97d-42704d7e928mr16650166f8f.13.1761202174565; 
 Wed, 22 Oct 2025 23:49:34 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898adf78sm2431986f8f.32.2025.10.22.23.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:49:34 -0700 (PDT)
Message-ID: <c8278577-32dc-4121-92f3-36ccca36e9de@linaro.org>
Date: Thu, 23 Oct 2025 08:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] hw/ppc/pegasos2: Add VOF support for pegasos1
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <d2d7f173dbd436b47382f384d5a93eb7e713424e.1761176219.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d2d7f173dbd436b47382f384d5a93eb7e713424e.1761176219.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 23/10/25 02:06, BALATON Zoltan wrote:
> When running without firmware ROM using Virtual Open Firmware we need
> to do some hardware initialisation and provide the device tree as the
> machine firmware would normally do.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   MAINTAINERS              |   1 +
>   hw/ppc/pegasos2.c        | 140 +++++++++++++++++++++++++++++++++------
>   pc-bios/dtb/meson.build  |   1 +
>   pc-bios/dtb/pegasos1.dtb | Bin 0 -> 857 bytes
>   pc-bios/dtb/pegasos1.dts | 125 ++++++++++++++++++++++++++++++++++
>   5 files changed, 246 insertions(+), 21 deletions(-)
>   create mode 100644 pc-bios/dtb/pegasos1.dtb
>   create mode 100644 pc-bios/dtb/pegasos1.dts

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


