Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5762F589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuba-0007c5-Bv; Thu, 23 Apr 2026 10:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFub7-0007T7-Ku
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:00:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFub2-00039A-DJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:00:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so48264885e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952799; x=1777557599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kpU0pR3fRxOtMwwu8Dm54hGShQtdm9nbRo00luWuyAM=;
 b=lq+pK4yQD1VaGUYOQqQeLitsiSRjAmw0fXcQzkOVi5WfgZMagmiUZw45S1O/bsUcFo
 7Gq+tGOUBIka2hLKVzDuoIwq5luzGe/EJ4l7Rbpscw0ljiABRXvvhsuay2TRAxHOyb5s
 IrHFa5RiWzNy05fwNqpdDP83HHAoaIkTzm/9b9w9pAZYLWtR5hz+MEDmN4nsfGUHqDvh
 KiSzBCdF7M6JVSgQFX15P1Cke3fr1LPTb0vYFLjEmFLVZmUtUHGZlynuEcEIBBmmzq4Q
 RiRM5J0FPRpSneZtO98XdhsTWIjnkHF5sgT1n1al5fqumxRgBAnCm9CdATiSLaUNEqqR
 ljCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952799; x=1777557599;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kpU0pR3fRxOtMwwu8Dm54hGShQtdm9nbRo00luWuyAM=;
 b=rFNXM4TgTXiL+yuPCSPA0BZSEuFX/BeTJAaGuRI+MfrXnfDiHyAueLEQhRHeEfrdbx
 1lWifX+PseVmxHaCiXiAImUyzpB9PP2RAePN0GCcG55BOID+L6gUYiwLsNVvMi93cMYx
 xvWTPze28ep+Rg7XWbJWPcM6NwphML/Yo2PCwooAY13/gSAzjO428JPjZ0SmDwC11afb
 kqC2yYIlV8kb7035AJ+xleEnFtRlZtzIkCpXFa5zbFCg8f0F9Gxqbqy91Tz+GmllFgWO
 rTEJy0+w4rZfbjlia2y8QSBNv0AxMXr31vVR1OdMGFUU8ly6Tx9ycfUr1KiXOOpryhTO
 dkYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vDBA1ajI4x2GtstYV5YB4L8IxAJoMxN9yFblFaloYOujgQ6ZWIJRXo9qpCuGMTLIxcuWhb+h5fM7k@nongnu.org
X-Gm-Message-State: AOJu0YyOZckbzhVCsiMxf32lYVWbFDjnfFgZ1R+c4VEDB7URXW9vMWiJ
 rg6g0GFaFib/+DZ0aMbnkzdNgDal9IjUY6IPEpyunnxqZeXBtaHSIgdWVurAVsowv0khYPqhx+u
 cAY/MJ3Q=
X-Gm-Gg: AeBDieuBsrK+kcHOBaNTk8N48AXQpPr70cvjcej62TpfyVDYwlp8lAOUt+6TFERD+ez
 /KovAlD6ZJxYfXgNF7FhT0V4FQgX/oGUSW6P2yxqiEBpFGq5LUlMIRrkUoTBXoPVeO9WOIDY3BD
 EwJaMdj2bx4cQT8+N8kmBQjeUn33JSleWGyhaVbt8p2RoF3DtVPSFmtZiHnJDUNuq1cGxSoEbX7
 vyxmlxzl8xkseAD7YJSZr6Jj0avXgdFn6TJihVClgd6dWq9kVlQai2QE5v9vCdjv7UfzbZ4b4uZ
 0GFsYpToe4TWNWt5PLX/V1U7EFX5WzDyOIdTQDR7F654hZeWp/aAkvoDduFbhbyOmEcnPGz/O0n
 jb9QWPb6I1P5aveS3fxNdveukKGZuCs6uT3d783gOxDZQn9qHT9GVcuNq9RQ96v5lPFpcZRM3+v
 3GRl9ejLFffsSWwp2LAloCIkzaY6Q5re9BcC6nczk31cv/sai7oD/z7DPTSeiiqy96YEV46YaDb
 1hS
X-Received: by 2002:a05:600c:154e:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-488fb74fc02mr377126525e9.10.1776952798703; 
 Thu, 23 Apr 2026 06:59:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm80466035e9.31.2026.04.23.06.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 06:59:57 -0700 (PDT)
Message-ID: <970ef412-344e-4e9c-b1e2-81f9e33e6e5a@linaro.org>
Date: Thu, 23 Apr 2026 15:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 59/67] ui/console: return completion status from
 gfx_update callback
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-59-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-59-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/4/26 21:19, Marc-André Lureau wrote:
> Replace the two-field design (gfx_update void callback + gfx_update_async
> flag) with a single bool return value from gfx_update. Returning true
> means the update completed synchronously and graphic_hw_update_done()
> should be called by the console layer. Returning false means the update
> is deferred and the device will call graphic_hw_update_done() itself
> later (as done by QXL/SPICE and Apple GFX).
> 
> This simplifies the interface and makes the async contract explicit at
> each call site rather than relying on a separate struct field.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/qxl.h              |  2 +-
>   include/ui/console.h          |  9 +++++++--
>   hw/arm/musicpal.c             |  3 ++-
>   hw/display/artist.c           |  4 +++-
>   hw/display/bcm2835_fb.c       |  7 ++++---
>   hw/display/bochs-display.c    |  6 ++++--
>   hw/display/cg3.c              |  5 +++--
>   hw/display/dm163.c            |  4 +++-
>   hw/display/exynos4210_fimd.c  |  6 ++++--
>   hw/display/g364fb.c           |  9 ++++++---
>   hw/display/jazz_led.c         |  6 ++++--
>   hw/display/macfb.c            |  6 ++++--
>   hw/display/next-fb.c          |  4 +++-
>   hw/display/omap_lcdc.c        | 14 ++++++++------
>   hw/display/pl110.c            |  5 +++--
>   hw/display/qxl-render.c       |  6 +++---
>   hw/display/qxl.c              |  7 +++----
>   hw/display/ramfb-standalone.c |  4 +++-
>   hw/display/sm501.c            |  8 +++++---
>   hw/display/ssd0303.c          | 10 ++++++----
>   hw/display/ssd0323.c          | 11 ++++++-----
>   hw/display/tcx.c              |  6 ++++--
>   hw/display/vga.c              |  4 +++-
>   hw/display/virtio-gpu-base.c  |  3 ++-
>   hw/display/virtio-vga.c       |  6 +++---
>   hw/display/vmware_vga.c       |  7 ++++---
>   hw/display/xenfb.c            |  6 ++++--
>   hw/display/xlnx_dp.c          | 10 ++++++----
>   hw/vfio/display.c             | 17 ++++++++++-------
>   ui/console.c                  |  7 +------
>   hw/display/apple-gfx.m        | 10 +++++-----
>   31 files changed, 127 insertions(+), 85 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

