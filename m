Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1D9E65275
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 14:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmYKF-0004lo-VS; Sun, 01 Feb 2026 09:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYKE-0004lK-4b
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:21:18 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYKC-0003zs-Js
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:21:17 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-435a517be33so2137415f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 06:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769955675; x=1770560475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bXdsDxmkWCnNh1bgz3LKjzyhFdoc4oSja/dbdkx5rZQ=;
 b=EpVqw8fdO12kBrJQ6EtmMA5JdEW/z429m48M/+ftvzbHV3oYBYIcYqwBboq9GCjwsg
 giXUmQ4YhlrPyuZQRjeFaxlJYQKv63LJQx6r1hddGhTedvQmhjwX1TZjcLBLw/1jElTv
 FCGICqlZjiynMnkD5ttWQINpxw9rxH3voESumZL4AeYIXdMHXqNY2nfZMIpf/63rATHq
 tyYykmkSGWCBlCOOvDP79Tol914MUhDHtxRaOymS0BMR0zCO8DDnnYq7ddT1CyOOnNlf
 cVck9fHGXr3DRQhPqSON3vxR3+v0+yKd4IEIM6dZ7n0L3B3p5Q6GdsS4VmFsgo6v9FQl
 YUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769955675; x=1770560475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bXdsDxmkWCnNh1bgz3LKjzyhFdoc4oSja/dbdkx5rZQ=;
 b=D8ZKZ0gPGwSCPRLTNH2rnx70RDAA/DS452pTQL+LISkIdbSrfzDRtKxg9r6gcJbIRy
 W2ZVUFFwznBgjZe0wTo+UBEpGrF60tFw18V8arL+mm3L8AU3wQakgOAGWy910xUAs8CG
 zWTp0N4OpvAUEuPa63/t22/Yc9ix6HRYaCQRRBNjOqsvBlks3aUTB9LMJ1OmTBXTmhIb
 I6RxEL/ino3HfFpztiajBJn+W3WOBivnFzt4J03c4PyAghGUap9VMgBViNzNfPeazyvy
 RmIpN0sNBZ/BGhr2A3PdKyf1UIoZ7SkATu0VPXTa7tf1eg2Tt7UZ5KT2fFtuXJDlbvR8
 5GMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK4Pr3kdXDhaF+fBgKAou694ni/p/Ipkqkb+vCJEBp0c6cGhMIyPYSQH1u5O1mNZn12+zjaSXSIr4d@nongnu.org
X-Gm-Message-State: AOJu0Yw2bF+7jFdEPMfQmWhI+xj4B4H+ohrllgTlpE2w9O3xoTQoRt/9
 zapV8pTWK35RtD9FgUDUIVf2HNah8Ty534NlMmuVNxWMEN6TMIC7+YxSgTgXFdK6aa0=
X-Gm-Gg: AZuq6aL+zfQBZVmVtELyRWB0D8FgwDEJryUW/eMjZhF8QBX+Kx9PXFlMzaud/P2OFO0
 sdFI73ggp6qf/hfbEiNKpzHfqxG52GCglNOHVfSJBl2aANRkpC3XnXGZsTVSqQ8AXE0lVs/qTaM
 yS6FFmJUduf3HAEp93p01LrtpEp8IccMA5WiKqXZVmxrmVeg6CoQNYZWqEalcq7v7j/9ALbKHGL
 8SUMsFwTwMn2pcJbHFhT3O2+lXqSQ2tbJLkU3XfwawYYHd6gzdmUg/DiNd5LE3qqifrAW6+qQyr
 96SEQs3NAuw4n7yp0iw+AhzQ/IS09z00BnqxnJ8KS6GgHA7nd7efcHBaGpLTPB7vMpi2H7Hh+VX
 SifOAE6MDufXq0tug8qGrMZO6y8gjjSY764dKgTDJSNEnsSf5mVvzriDrpdyOsLljHwuOddYTbu
 lELLfjxXS54V/8Odpx9zzUe+rT07u/soU7a+09eVrClWUvriumNFoNLA==
X-Received: by 2002:a05:6000:2dc7:b0:430:f58d:40da with SMTP id
 ffacd0b85a97d-435f3a691fcmr12095241f8f.10.1769955674866; 
 Sun, 01 Feb 2026 06:21:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ed952sm37744071f8f.10.2026.02.01.06.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 06:21:14 -0800 (PST)
Message-ID: <a9a6d7a8-31d4-48bc-958e-e35342dbde92@linaro.org>
Date: Sun, 1 Feb 2026 15:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rutabaga: improve error handling, fix potential crash
 during init
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260127122400.100384-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260127122400.100384-1-marcandre.lureau@redhat.com>
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

On 27/1/26 13:24, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When virtio_gpu_rutabaga_get_num_capsets() returns 0, virtio_init()
> isn't called and the device later crashes during realize.
> ==72545==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x556ad6f7ba9e bp 0x7ffe6958f810 sp 0x7ffe6958f7e0 T0)
> ==72545==The signal is caused by a READ memory access.
> ==72545==Hint: address points to the zero page.
> #0 0x556ad6f7ba9e in virtio_memory_listener_commit ../hw/virtio/virtio.c:4034
> #1 0x556ad6a24c96 in listener_add_address_space ../system/memory.c:3128
> #2 0x556ad6a25d15 in memory_listener_register ../system/memory.c:3216
> #3 0x556ad6f7bf11 in virtio_device_realize ../hw/virtio/virtio.c:4075
> 
> Rework error handling of the function to set Error appropriately. 0
> capset may be ok now.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

