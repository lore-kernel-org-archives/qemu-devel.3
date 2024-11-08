Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B717D5C0F5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RUm-0002ER-Kq; Fri, 08 Nov 2024 11:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9RUj-0002CC-Jy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:05:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9RUh-0001Ed-3v
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731081953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=16z/EYkYvHDj1xMgrOlI3AYhohNTboiiTshzjamwqPs=;
 b=HvoXKFp/nawnxqW7AKDiwHqfDvDaCvWAMvHgQ3Pglyq6EPlu6nSVtFIRB6NjCUDK/P+0py
 VYZT91IeqVGOT2b750qBeuuw5vp6MLxSqfmuy3oCmRvpFv+T2urFK3qqT518PDyZRZX8Sw
 NfuW3lZFrfnXMNUSg4qoYHWyqv+KDYA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Ocl5CvBmOue7brYbTruePA-1; Fri, 08 Nov 2024 11:05:52 -0500
X-MC-Unique: Ocl5CvBmOue7brYbTruePA-1
X-Mimecast-MFC-AGG-ID: Ocl5CvBmOue7brYbTruePA
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e13b8143so2801196e87.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731081951; x=1731686751;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16z/EYkYvHDj1xMgrOlI3AYhohNTboiiTshzjamwqPs=;
 b=MmSbF5KG7I03tOoY1ZmAE3bysGC64npxKP6HeAi+zw0NokiHFFRU+NBBrKyRefcGsE
 62CbS6wA5pJTK7QDf11Zm1R9bQ+tJbRXwgVn9rTH97aLBAg8QDjMtsqo+n8uTHUEavoy
 yXKHno0Zs63f77Wmm67WU+AnnMh7tl+Bl1h8bKl8Vun4RDg6sR83fx1USnzyrxUlVdkl
 Y+OV9gGWdqYIaasofjIalOmxsJ+6VdQ912EEaPwV0fttoUP0Iau1jwJopULzDIQwng11
 TBFODFYnnryfUdXqckoeASLitFHkydfpSRkB/bZbypUxPJJVn5qi7p88UQ7jLzu6bMAY
 GYzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8l2eSGNnEpHyXp6i2DbPpv56g6bbfmFv9rVaWgoLQl/Jxmwqyk50oBoMmzfDx7/evhRhUhr7mkCqJ@nongnu.org
X-Gm-Message-State: AOJu0YxG72nol2GV+VMXZ+f+M4SKvlWIGcTGPzvgk4cNJmEWdYdSmX4E
 DwRnJPZ1LHJ/2F+YYs1zsoOH7FOAqZfx2U6gMhzQwfMT8y/Oht0PMzp/OksSha1LMJp5vJuSVaX
 HND8w+8N5dMajGhfb3SDtpNIJXmzthuP5WxNhpIuGc0jdRAnrRSgs
X-Received: by 2002:a05:6512:224f:b0:535:6a4d:ed74 with SMTP id
 2adb3069b0e04-53d8627953dmr1838189e87.51.1731081950243; 
 Fri, 08 Nov 2024 08:05:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcVM+I/G5liPyV+/XnYkz6qQlJjoAJ+dsMxUOi3JxHE8JTQowVA2Ro//+U/kNTkp2/tWHT+g==
X-Received: by 2002:a05:6512:224f:b0:535:6a4d:ed74 with SMTP id
 2adb3069b0e04-53d8627953dmr1838135e87.51.1731081949607; 
 Fri, 08 Nov 2024 08:05:49 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381ed97d658sm5266883f8f.39.2024.11.08.08.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 08:05:48 -0800 (PST)
Message-ID: <71a10d65-dd73-4f39-93ee-2c36928f8f4f@redhat.com>
Date: Fri, 8 Nov 2024 17:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/17] hw/net/xilinx_ethlite: Simplify by having
 configurable endianness
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20241108154317.12129-1-philmd@linaro.org>
 <20241108154317.12129-5-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241108154317.12129-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/8/24 16:43, Philippe Mathieu-Daudé wrote:
> The Xilinx 'ethlite' device was added in commit b43848a100
> ("xilinx: Add ethlite emulation"), being only built back
> then for a big-endian MicroBlaze target (see commit 72b675caac
> "microblaze: Hook into the build-system").
> 
> I/O endianness access was then clarified in commit d48751ed4f
> ("xilinx-ethlite: Simplify byteswapping to/from brams"). Here
> the 'fix' was to use tswap32(). Since the machine was built as
> big-endian target, tswap32() use means the fix was for a little
> endian host. While the datasheet (reference added in file header)
> is not precise about it, we interpret such change as the device
> expects accesses in big-endian order.
> 
> Instead of having a double swapping, one in the core memory layer
> due to DEVICE_NATIVE_ENDIAN and a second one with the tswap calls,
> allow the machine code to select the proper endianness desired,
> removing the need of tswap().
> 
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
> DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device endianness,
> defaulting to little endian.
> Set the proper endianness on the single machine using the device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC until I digest Paolo's review from v1:
> https://lore.kernel.org/qemu-devel/34f6fe2f-06e0-4e2a-a361-2d662f6814b5@redhat.com/

tl;dr: this works but would break migration compatibility with the 
previous version.  If you want to keep that, you need to add

> -            r = tswap32(s->regs[addr]);
> +            r = s->regs[addr];

if (s->little_endian_model)
	r = cpu_to_le32(r);
else
	r = cpu_to_be32(r);


> @@ -161,23 +165,26 @@ eth_write(void *opaque, hwaddr addr,
>               break;
>   
>           default:

if (s->little_endian_model)
	r = le32_to_cpu(r);
else
	r = be32_to_cpu(r);

> -            s->regs[addr] = tswap32(value);
> +            s->regs[addr] = value;
>               break;

These pairs ensure that RAM goes through an even number of swaps.  I 
don't think they are needed but you decide.

However, I am wondering if the double MemoryRegionOps are needed *at 
all*.  Since petalogix is arguably a little-endian only machine, can you 
just use DEVICE_LITTLE_ENDIAN?

Paolo


