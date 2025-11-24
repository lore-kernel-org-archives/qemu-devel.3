Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8628ACFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 07:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNR2V-0002LH-Q6; Mon, 24 Nov 2025 02:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNR2T-0002KH-T7
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:31:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNR2S-0007DI-3j
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:31:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-477632d9326so24140855e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763969466; x=1764574266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nx/9XKXx0vttGVqTiw4W+ppRW1gPYEutkG1zxZiVplA=;
 b=LBBjXKRuuXBD/V46bSyPxZuj+4fm6x3RVTg9hOamhZEeQ1/JRcm/2p7OZnV3fkkquX
 JbSOg+8U3gzfZ6PJc3/06MV7qKjMrUDJ4WWA4Dl6d5izv9FBV4HN8V40BybnT/FHaiDW
 dOYvsEJ+GDSKhmZfH3W/G7qSV4aw9Ys7XRAaUg9EA6sc8GRQM6k0M2wgllI801RRaEeG
 qV0r2H0qQD4KPQMPjQyijpMVrVH2lDwXhcLqgh4yj3om+YRpq3eEtBgT9ECZH2UTdCuG
 hJ/u7C25BkAwCsq8s9vGla8OULF3oAzU1Ca3UjSFErLtE7V0TTZ7hS7cij59Psg9dcib
 ZPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763969466; x=1764574266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nx/9XKXx0vttGVqTiw4W+ppRW1gPYEutkG1zxZiVplA=;
 b=Mp/Fdc3rh5FaOoxKK3IbjR5PxePTuv1edaKo/eRbEkfYY+Hu6QRHGG15asJpRAlcig
 U5mp9Qw+Wl8i/yCnEk6TFi3BS3I79midYpAN6c02w35hQKDAZnck6psr6f/JwtJgtpX5
 5miJqBiposUspfbRU7mnUw7Ywe3A+4lBxNl8/xuWLtO0+aINCtKjU4TlPZa7x74Sv3+T
 uSZfpgkHCu089lASwpxWC5ktYsZcgX1Q80Sbkq6qVVbZwtdnttpwAHlZ2t71kZ/jqFyh
 hRLfQHT71qC8QT1iIGJWcQU+vrywbCeQ8M7aF/hki0epVlO7pdZfF9DHyFruuz9rPSMu
 54vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWs9nvQxv0WLpqVCpmPacs9lwrvLTjwHI0hFi6OhA1gg8GQ/7qndyfQLjaAsahb5x1y8f5PXAbU9yq@nongnu.org
X-Gm-Message-State: AOJu0Yx19dTVU6fc50ja+gf/EZtjwdZsCvk+npZLvHyshbu+4fy8Ak/U
 OVTBv6/+lZLMGPe30aZLmZcA4NfvTLq/2328DNDfSIleLmI9WaoCtmXRxt6x8YceB1Q=
X-Gm-Gg: ASbGncsI5sks0fy5amC7nOoCBFhvUUW03LzFz1mWXvzrluhzbenzpJZi8OJtkCSy5YF
 Vw1z2XHs1Ne1BCjwndcP0fuJjKJ0k3sCnM+Rx3BmqVXQvN1v+MHoOpmrWAa5GtSzIKZP5t9jJJs
 ivxv5m+W8TSUp+vwelBRCLG53FSwkZ+tXgHQ1yvsCzaXA0Xy+U8TkFrIX+xNmL4i/S/ICNLPADs
 Ssz4RKwCopz3IkYP+1GNV4wlOHCJ0NxuwqxkMqymNC1scDUEdeJW3TF94kS33od69Lixr8NtA9U
 Kr/cioKQci7HBP5fz27kn2dJgvCdCvX6WXyExcT+rh+Vd51Yjk65nUS4KjGNJe6DQjJFfQ/hGwc
 7zaY9aZekqBpB23LxX53c6JqjS913y+4eIx/dng5JTdazPaoQIbTPeHO60nDmit8WuvG+eG90YN
 zutP3P6qtbLb2T1w0/r++0QMMVAxIkE2H+TIKnJNAUTs1zeyzcgI3rag==
X-Google-Smtp-Source: AGHT+IGobOErczOKLWR/BHEjDIojdrhHS5GnwoLh6XejaBhaphGalWUlTTHXiIJHFeG6CD0ZI8tmdg==
X-Received: by 2002:a05:600c:4e88:b0:46e:7247:cbc0 with SMTP id
 5b1f17b1804b1-477c01d4af2mr108288705e9.18.1763969465715; 
 Sun, 23 Nov 2025 23:31:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1f3e63sm183519735e9.7.2025.11.23.23.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 23:31:05 -0800 (PST)
Message-ID: <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
Date: Mon, 24 Nov 2025 08:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: 64mb limitation of qemu-system-sh4 board
Content-Language: en-US
To: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Cc: security@debian.org,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 debian-ports@lists.debian.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 24/8/25 20:07, Rob Landley wrote:
> On 8/23/25 09:19, Thorsten Glaser wrote:
>>> There are no alternatives - qemu is unique in this regard.  And
>>> it has never been designed for this usage.  What we had for 15+
>>> years, unnoticed, is like `chmod u+s /bin/sh`, which is never
>>> supposed to be used like this.
>>
>> Perhaps, but there’s shades in between.
> 
> I find qemu system emulation a LOT less problematic.
> 
> For sh4 I boot qemu-system-sh4 and then use a network block device to 
> provide swap (so the 64mb limitation of the board isn't a limiting 
> factor).

The R2D+ board uses a SH7751 SoC, which memory controller can access
7 external banks. This board has its boot flash on CS#0, a FPGA on CS#1,
64MB of SDRAM on CS#3, a SM501 display on CS#4 and some ISA bus on CS#5;
leaving CS#2, and CS#6 available. CS#2 can have SDRAM, while CS#6 only
SRAM (not really a difference in emulation).

 From QEMU side, we could fill these empty slots with 2*64MB of RAM, so
the machine could use up to 192MB. But then it is up to the guest to
use it.

Looking at Linux i.e. it seems to hardcode the RAM base/size in
arch/sh/include/asm/page.h, so we'd need changes there to use more
memory, which seems unlikely to get for a such old board...

> The sh4 build in toybox's mkroot works fine for this (binaries 
> at https://landley.net/bin/mkroot if you'd like to try). It also works 
> with -hda but I think can only provide _one_ of those so you have to 
> partition it, which I generally don't bother.
> 
> qemu-system-sh4: -hdb hdb.img: machine type does not support 
> if=ide,bus=0,unit=1
> qemu-system-sh4: -hdc hdc.img: machine type does not support 
> if=ide,bus=1,unit=0
> qemu-system-sh4: -hdd hdd.img: machine type does not support 
> if=ide,bus=1,unit=1
> 
> (You'd think it could at least do -hdb since that's just master/slave on 
> the same controller but the qemu guys never bothered to wire it up. 
> Anyway, I stick a 4gb ext3 image in /dev/sda so I have lots of scratch 
> space for builds because building on network filesystems tends to have 
> strange permission hiccups for me, or rm -rf fails because nfs didn't 
> _really_ delete a file that's still open but just renamed it, or...)
> 
> Anyway, this works fine on little endian, but the qemu-system-sh4eb 
> build has something hinky in the ethernet, I haven't tackled it myself 
> because I don't know whether the device emulation or the driver is 
> what's missing an endian swap. (I don't want to fix it the "wrong way", 
> and don't have big endian physical hardware lying around to try it on. I 
> moved _again_ at the start of the month, just unpacked the storage space 
> with those boxes into my sister's garage last weekend, but haven't 
> sorted very far yet.)
> 
> In theory I could use a swap _file_ instead of swap partition, and thus 
> a single /dev/hda would be plenty without partitioning it, but I haven't 
> tried? (When the network doesn't work I can't upload the results of the 
> build in an automated fashion anyway, so...)
> 
> You can speed this build process up further by hooking up distcc to call 
> out to the cross compiler, which lets you keep about -j3 busy before the 
> preprocessing, data transmission, and linking become the bottleneck. (I 
> mean ./configure is _always_ the bottleneck but that's because autoconf 
> is really stupid and largely pointless.) I had that distcc setup working 
> (and even automated) back in https://landley.net/aboriginal/about.html 
> and can help anyone interested fish the relevant bits out of those old 
> build scripts.
> 
>>> If you rely on suid/sgid *foreign* binaries, that's where the
>>> problem lies.
>>
>> Yes. People expect to be able to run foreign-arch chroots.
>> Entire buildd setups partly rely on this, too…
> 
> A qemu-system vm doesn't require any weird translation. As far as the 
> kernel running in the emulator is concerned, everything is entirely 
> native. :)
> 
> Rob
> 


