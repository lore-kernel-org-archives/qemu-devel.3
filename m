Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ACD104891F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6ZX-0000XN-LM; Fri, 27 Feb 2026 17:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6ZW-0000X0-Pv
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:44:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6ZU-0003IM-Vt
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:44:34 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so17082115e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772232271; x=1772837071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5I/uLJZdgjl7g+VbGxPdZ4+lhoJ//75nOJoZ2VKInXo=;
 b=qen3FG9L/S0PhDAphfGzdu11O43zhun5q/3HkrGPZ/S0jpUYkKpT5EG+ztfK0hR/Pd
 eIgBGwXS2G05c7KZcAwaROBobU7VvIKEMZjw3dSdVrkJzxLGKW9DLK2wvfUHPqxbHjt3
 NWdaIM7N/lH2Gm5EWrjhIpfw04eu5/YiFYPoG0DmvG7lVfA1IhyXfPI4feJzFGeSj5At
 hEe1ucOhjdb70RY+R/ZDhVkoNYvUBUe+WKdQv3SsgKDZoFeoRRujy9xXPWxgrgfvpWSo
 5POMOWKz1sNL7QkJrtBaRtsDVteTOiauDEQ1AHzlJb1xjnOeOUyZUkUISKzgznkOxGKT
 JLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232271; x=1772837071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5I/uLJZdgjl7g+VbGxPdZ4+lhoJ//75nOJoZ2VKInXo=;
 b=T3f62ek9Map9PZRhop3MZwfO7L+fFfUPwf2ltXCKUUTE9XiI+Xj785UVn4jvY/82U3
 bIeo84kNxjK8hLv+iGzpWmTQP7ATsca2UEFDltB+WXcoTK6EvZW6RQHuiM9TQYxGPb2o
 8XJxaIMTkw7RD4ftQI7hI5xqLRtTqdrJd8YbQHRJdLFycEdiYBCT8qdc8gSlWI41ufv7
 MkDSQg7OFNdGluAclTe+0wLjtXQIrlSphIXCZibhMsVYZdD+RzgZIeGW5bR7k3PzmIzm
 sztZMsjzFZYua8Txl5trfQvhbk7kGT4jUqwT57yQQwN7OfKOokD1zoMHSkxAGIWSCgA1
 Cslw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDYrHzKqod8tPgszeIaO9N+vdpWIog+8+VhxQdoz7KuLQKDhErVBgMWTqqRujAnyYVzhn4MYoqWbM1@nongnu.org
X-Gm-Message-State: AOJu0YxLcyNaf/QrD0Te6nn9KJylZOM5+53FOQLJFshuQAqTTMh9BUkY
 2Yp8rqH8y33uuPSbqssAoYn17zVTOQoSKPZu32ptqtc4jVvkISK25MiY35euIVIXLZM=
X-Gm-Gg: ATEYQzykJ9n3yoBI/BeYyZvL8nwtz9cVKsvjVNBilq/InfmC6rhxO4G2kU8lPOTyfdy
 +9WQMBT79N5hhGzfYLYUxtZgGGTt+Ps5t1vYkrT2HzN05RQCydM+bBEHx2wTXiNXZx1UHbHqnse
 tNTjx1Sd5GJ0nw6Q9BbyckP2PlywSZTPWa3KF8OOCA2vO3IPK4EYux+GeIXQIxVEjQ2Fz5pfmGd
 xv/hZlPitGYH9v3cVzReuTTr95uXMP7y+4u/TU/02M+NdX96Tiff0MvFEUryDEfVUT9Yu040OJV
 nVI6S8qzEuInw/pjraz8HEGJZKHnHLiwWyxVgqcMTb7PMxCPEz0NLqJZbBEHydhZddQWufhfnrT
 Fmu4IfJ3UJMyJwzggfFIrSSfm0adL7SE2nUkKwJ/eD4jdPbloeAgl5PD3Xzby3yL9tiA2oo0opg
 YKKmfe6bTMOeM0aiHo2eFXcset9PBXIv6QC8yrOX+ykwD6/alQYmxQJQd9gAyxkeF0Xw==
X-Received: by 2002:a05:600c:4fd4:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-483c9c191d0mr61719875e9.28.1772232270939; 
 Fri, 27 Feb 2026 14:44:30 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb296bfsm88928395e9.0.2026.02.27.14.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:44:30 -0800 (PST)
Message-ID: <752ca181-8e7a-4304-84da-935589476dff@linaro.org>
Date: Fri, 27 Feb 2026 23:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] hw/riscv: Ensure proper ELF endian expectation
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-7-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225102016.200654-7-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/2/26 11:20, Djordje Todorovic wrote:
> load_elf_ram_sym has a `big_endian` paramater that notifies
> it if the loaded elf file is expected to be LE or BE. This
> paramater needs to be set based on target endianess to ensure
> proper elf loading.
> ---
>   hw/riscv/boot.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index dc9f8a7327..6dab521a6b 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -166,7 +166,8 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
>   
>       if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
>                            &firmware_entry, NULL, &firmware_end, NULL,
> -                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
> +                         TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
> +                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
>           *firmware_load_addr = firmware_entry;
>           return firmware_end;
>       }
> @@ -248,8 +249,9 @@ void riscv_load_kernel(MachineState *machine,
>        */
>       kernel_size = load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NULL,
>                                      &info->image_low_addr, &info->image_high_addr,
> -                                   NULL, ELFDATA2LSB, EM_RISCV,
> -                                   1, 0, NULL, true, sym_cb);
> +                                   NULL,
> +                                   TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
> +                                   EM_RISCV, 1, 0, NULL, true, sym_cb);

See commit c36ec3a9655 ("hw/microblaze/s3adsp1800: Explicit CPU
endianness") and around.

