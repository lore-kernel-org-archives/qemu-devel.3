Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90789CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNAq-0001Eh-Nw; Mon, 27 Oct 2025 09:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNAn-0001Da-4l
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:22:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNAf-0005BW-OT
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:22:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso65964825e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571312; x=1762176112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jZ1fI1xIEiwwuSm9s+d5nNAQs8HLDrT4pVzROFps4nI=;
 b=zrS/lKjM/iU+Bp8KbnTsCZfVpH7hHKjl7iUqbweMyR4dkuJ7Q2YNhrdPcfHxWfRBgf
 mUsWzoB9JnpgxUrGD+bdVStc/7Ni9gHQ0QYqGv7W0P/yBjQmvEGMv1Sne+9uO14/P5b0
 mRQQfDoFW44SIIu7rsi3RAVOGsof/ZBNudlxA81ZNr24Zv7em2yR943Y1rb2jxSfpf8J
 1elH9VSIBHk0S86uYsTyfDs257zY9blO0TltvQWRqgJ1iy2oH6s/vO6WmAn7haa7tpZE
 KvhvgN0lHGTZx2R7J7NiZ1ftOBQYOCwTBZLFx+3mwTRioLD0IG0V67ZoabBQzRVvi2y4
 1gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571312; x=1762176112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jZ1fI1xIEiwwuSm9s+d5nNAQs8HLDrT4pVzROFps4nI=;
 b=avODN/0CAu2cZ7M8rNBr8KesmAN54Ehlz55p3rMVOcUVqI8SrphIFjrrBwMqliaa/a
 045Ce75Q/kaz5Kgx1oPIpzFxchTDFQnOOmqkNE471SzeUVnVd1AgH8czLOdk8i98ZFwn
 G17j+enUHUxalXUTpNhjMdyV4JBHGPn4k7nlbbujvy/NIX9sY9YIoA2TMhWgGy7BM24S
 kVL6KX3TMDJuHggdCsoNKfvd6YYoV8NVCs+Mz3YOwLd9t3zn0YhZkiIWHRdukqcfmrN7
 DWTsaWdvZyWM+OFpJi+x4hzNu5HVVKS6Rs/tvLYcVACZAtWexrUoXFQlLx8LZMIbw84q
 jjRg==
X-Gm-Message-State: AOJu0Yzf9SSvpyth134kONf9UWBPyFbrR/SyJmV7eUDseVgTu3Vf/M1c
 2tw07nOtFxPjPcMn3XupJ/lNiKcdMOInmwiZKkxaObmHUeHrESkm/TWy/t2q3FG35T4=
X-Gm-Gg: ASbGncs6qBFBUnyu/IfIBhKrTldGNvFLDBbgm00x4FO2DaZvG7WBuWjmZz+p81fDfCV
 yx1twYzgxQSEibGv2oVNHVcYgQhHUSTRQW1RBPP3rWbc/ELG4kWMEFREb4m40yyTvaiwxF/anLo
 DwZaceovcRfMapBlfFdZWLfbC564GmqwB9rbhPofBY0ATMdu8bF35uFtF4r22wO5Gj9y50upPy8
 IUmw1TB/hcrM/pcmXEPyzyeByKrGEtD+woQ86PVn1dL5GYvxz3U0jfMP9XyRXYLPp78Af4hzCD5
 +q9WtWPmlACadoIKQKMzwf/3cXvwUmugxBa+hLQGW+3tGCxix9aAfkTqJSthyfiHm3/FEt7mNXg
 419czkL0ZoTwlhHB2Q2v6IRClOZlgKBCINeLaitM5iABojPS2T02uVZvaFkZ+nwIwIYxdxwvzPl
 bee4d4YybIiB2+Pf7JrUHbMKRhmN8QKCYZZZt0kaVihLblRWFmP3y2rA==
X-Google-Smtp-Source: AGHT+IEmaI+V7NSke+Xbg+NDwhfHtZLEpsooM6s7sWT8zcSsfh7niW0hEzqg2giTNXbYQeZ6DKbtRw==
X-Received: by 2002:a05:600c:4715:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-4711791c8c3mr293925985e9.31.1761571312503; 
 Mon, 27 Oct 2025 06:21:52 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7d1sm14390661f8f.16.2025.10.27.06.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 06:21:52 -0700 (PDT)
Message-ID: <7184eaba-0d11-40d2-bfaa-ff697baea6ad@linaro.org>
Date: Mon, 27 Oct 2025 14:21:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw: Log unassigned MMIO accesses with
 unassigned_mem_ops
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20251027123644.63487-1-philmd@linaro.org>
 <87pla8xzd2.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87pla8xzd2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27/10/25 14:12, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Do not log unassigned MMIO accesses as I/O ones:
>> expose unassigned_mem_ops then use it instead of
>> unassigned_io_ops.
> 
> But why? Is it because ioport.c is a x86 io thing?

Mainly. But also because log is confusing.
This is part of a bigger PCI host-bridge address-spaces
rework.

> 
>>
>> Philippe Mathieu-Daudé (6):
>>    system/memory: Expose unassigned_mem_ops symbol
>>    hw/display/vga: Log unassigned MMIO accesses with unassigned_mem_ops
>>    hw/pci-host/gpex: Log unassigned MMIO accesses with unassigned_mem_ops
>>    hw/pci-host/aspeed: Log unassigned MMIO accesses with
>>      unassigned_mem_ops
>>    hw/pci-host/astro: Log unassigned MMIO accesses with
>>      unassigned_mem_ops
>>    hw/sparc64/ebus: Log unassigned MMIO accesses with unassigned_mem_ops
>>
>>   include/system/memory.h    | 2 ++
>>   system/memory-internal.h   | 2 --
>>   hw/display/bochs-display.c | 2 +-
>>   hw/display/vga-pci.c       | 4 ++--
>>   hw/pci-host/aspeed_pcie.c  | 2 +-
>>   hw/pci-host/astro.c        | 2 +-
>>   hw/pci-host/gpex.c         | 2 +-
>>   hw/sparc64/sun4u.c         | 2 +-
>>   8 files changed, 9 insertions(+), 9 deletions(-)
> 

