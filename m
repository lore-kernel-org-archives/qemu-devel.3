Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B12CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlLX-0005HQ-Pg; Mon, 20 Oct 2025 04:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlLV-0005H4-Ng
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:34:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlLS-0008OD-3y
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:34:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so31288065e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760949259; x=1761554059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QZOu69Wpkt3dDJ7X/UjOQfTO/q/0Y84qP/FVRQHU0gQ=;
 b=TxXC+VVwnrRXF0QCDw/UmOgEMelTWprROlGeIWUM3REgWvwE1ckfSgP8FvaXD8yrL/
 1tnYa7OPKX24Zv+NAmRt3r4b8ZJhq6r/S1QbWVxUM6pb2l+vnRh6db89g2fWTV/R0pQF
 GFyYfkR8pmHGRt1tbwP5ebrjVBHqKdOOwYye0gKMDJWUHpgNBBOqDrTnCUKoxfuCa6B/
 pa9ycvf9EHenGm3OK5t12vyfhkevFEseB16k304p2SRPSYXkJBGN9Papdacle3+hjVpa
 m3qMec3HxG/4whoKx5eHipxMXOBu+/HPdUA6znEIdLLPL3HYz0z1svEmpHTdrGa2x4bF
 aXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760949259; x=1761554059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZOu69Wpkt3dDJ7X/UjOQfTO/q/0Y84qP/FVRQHU0gQ=;
 b=Ri7iqZh07QVrCZaWnreAQokHfWqjtSbaXIwtV1yy8pbJBVivYmzOkwNxBxJ6J5JnQ5
 WWC+soQrZTudux+emvFvTMMhuCl4f36yNqMRS7QRD04aiKBNG4+qr8+TRTu4KmE22aj8
 7ppm7k65G/GBhYkgBs1s6hW6Nf72Nr8bx3/lVtohUi/rDASzoE15fmv9xi+/l+3+omuO
 Rn+Wa25iQqiPsttklL69nFJ/JTCKBEBpPZr0RmzjULXKI8LoeWUEetEa+TLSx+VI6yhW
 4z4tCxIQ1oIsxcJ36+16SHV0Do9uYSjnqVLUeOzU1TELC5RK+QQ7neCBqU28SGmglMt6
 mnQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyzKnTZgn9tZuHiqo6FRC0P2wR2ywXqW5qKWc1Z0pj1o6V3b8Zt4pf0kXntWz9iplk85QEOvVGTIQ+@nongnu.org
X-Gm-Message-State: AOJu0Ywa7+ak4OvdQC0P+7wASyH2/a0D8FGJgI/O7URGPRKgUWn4hF5s
 jSPPVGlB0XfVGvjLfkb0IF26HJfjw5zc0xP/qoTtu5SJPo4eJ/9HbzXJ1cbUvdIElrU=
X-Gm-Gg: ASbGncvVI6dOwKLXPaoHtVU16nDnnFplx3mxCObsXECW3w+pUR+h4lgVKS5FIha5TsT
 n9p0KFcb1tvzw9ykAUKvnNQ+86UVhHrmqjXynBquK3MtZs0bNGw6sKGxlZW1crI8aLn5rX2smWE
 Zbk+ah69WGmUcVnwRUBdwtTs8edBFu2+HlScojeWh1qXgJmRThLufsweoDSTh+VzxZ44GxRh0rg
 KDy0LgHHRH2wWw7Z7wWpUU3I6MMc2Iuep3hjlflq6sj+HEN67bXno2UB0NlM8polYWdADnkUQFD
 k6u2KCP+AeNzNOuDZGCLZc2CGBGhhL8m/MnOIVUpYycJf+rJ9nMh2SZIlfMFkrTS8dcvK8RP/XV
 TsHT0smrX0rD7cPMGqaQo1kW8jXyof4G2223lzePgbY6O3gOZKPqBFTvKZGAaMghYyp1CxnuRTw
 zzsEKFtl5cNXUk2FUaDCSi4uCcTj1qoKTIFDboYZuwN3+e2xT3dgCe7A==
X-Google-Smtp-Source: AGHT+IGGsye8M5+dwNaN8vHqp+cAUAvPtJ8oi5JS9xfyqWbcRhTeKqxsvvtbikovqWp1apKaFsOGxA==
X-Received: by 2002:a05:600c:820b:b0:46e:1fc2:f9ac with SMTP id
 5b1f17b1804b1-4711787dc76mr80589615e9.10.1760949258665; 
 Mon, 20 Oct 2025 01:34:18 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm103955975e9.10.2025.10.20.01.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:34:17 -0700 (PDT)
Message-ID: <3139a9ae-c251-4544-b9a4-8818587e85e4@linaro.org>
Date: Mon, 20 Oct 2025 10:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] hw/rtc/mc146818rtc: Convert CMOS_DPRINTF() into
 trace events
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
 <20251019210303.104718-4-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/10/25 23:02, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/rtc/mc146818rtc.c | 14 +++-----------
>   hw/rtc/trace-events  |  4 ++++
>   2 files changed, 7 insertions(+), 11 deletions(-)


> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index b9f2852d35..d2f36217cb 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -32,6 +32,10 @@ m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx6
>   m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%04x value:0x%02x"
>   m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x value:0x%02x"
>   
> +# mc146818rtc.c
> +mc146818_rtc_ioport_read(uint8_t addr, uint8_t value) "[0x%02" PRIx8 "] -> 0x%02" PRIx8
> +mc146818_rtc_ioport_write(uint8_t addr, uint8_t value) "[0x%02" PRIx8 "] <- 0x%02" PRIx8

The block could be theorically mapped anywhere in the I/O ISA space,
so 'uint8_t addr' is a bit too restrictive here. Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
>   # goldfish_rtc.c
>   goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
>   goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64


