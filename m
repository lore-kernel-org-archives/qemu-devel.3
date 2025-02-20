Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E212C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8L0-0004CU-Dh; Thu, 20 Feb 2025 10:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl8Ky-0004CA-5Y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:19:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl8Kt-0007Kb-DG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:19:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so9575195e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740064773; x=1740669573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2hRksE2897PTlxlmHIHImfxlGxOMpZZQQSsn6Z6RGLM=;
 b=siC4iDBPiDdea7Zh6k3Z2OZZtlOnzd6/M/k8UPCic68TzlawH7P3+HHIVOZPej/LEG
 +Hw1lzwIT6f7YkMXMv3bY7DBx5OhZXC1TVHzdegMkXUeHIYKTmadbvaa6IsRraLOlmdm
 SxyOMVabLSoWh4ULq+BuxRGMfdv/hKK+RSrdTG5bCMBxMChqKyiuRNAPVFIpQPNT0woX
 DXFj1pLcNQpjs+Ktz7Hj/1Ki5jT7AXNXXPO8IY2lxusnOaEkjnQKMM6gGfYd5V2ve+Sq
 64lAn8dtmkWxRfcJetfcrF+09ZOMi7EWepLRwcaneYWZiW79eFSO4hZcUtkj5VBsUFNH
 R4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740064773; x=1740669573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2hRksE2897PTlxlmHIHImfxlGxOMpZZQQSsn6Z6RGLM=;
 b=ZOKylYkEePgtelz7+bkvRDdGzAu1zlim7iHE26zp7ki+ruhXoBYpnq8yS4/wPG8Cf8
 7VVxfGi+YZniktp8M0M8BIwJuVc3ajMJg4SmgOi1EIjaFTo5o/qDM2C7HYidTsC4J3q4
 X+CyZznRTuGVmOscK+nFCoWDcD7itNf0uFcAB7YnxImeObj7LsIromnxRcU2lcTWU7xU
 No2Cw+pxEIuOGbyXMvMwNrBm7cblY0dqn9lsqLohlN8m5yHA/d4mFEl0Z1LH0in4TaaO
 f2Bm0hcQtj9G7CN+EWDuW1WqKnavZAf5RZGEeWZHAGL5CpMzSLwahtaSa7+amofBCj3I
 +mqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKbX1dHOWQ0fB5qk3Gv8ezPohcWVhvgvNdg+di92JktDfZjCRR/jXJwZyw/kxPQA6CrVZr/KvgnHum@nongnu.org
X-Gm-Message-State: AOJu0YwQ7K/krIWR4yFhqgXOIRytXPFiU+0Tx5a0WsES5sVLf54tB69+
 H/oVnnbeptGamGBTQ6rrYxuQFboY1CkzJQgJ2e+EeXIq65lWpoNCINcrkY0IstA=
X-Gm-Gg: ASbGncvgeou7oul+zYWZ2YCRN/EdE9bao1nLu/D5VHn5fdDKhoVwGmDAmQXkhxL9NZF
 UT+t4Lw1AMA6r4FabU2TM062Qb+A/WmgO2qW/w0YshWmrA/4a8o1oUZo5qZgTtGF21H+ZoDrXnb
 ZwmTJD2SxvS2H7ew473nIrq/Rn27mhGddF6YtmOrgyadTRNDNCd1/SBcpzN8aUw/9DQRwUnJcah
 5mGqN4ym0YNL1HCLYuZ1TdvIRftY9CsOCmUZmKFmsOLoohPWPwfxu5trq7Mci6FTy2rSrpRRAZx
 BGf6wHBaZuJkdYnVFhapCVmvQ25lmyD2nlq9HX2tg0FyazZp3k+UgZ1M10yXWqXJo1kJwyyikAS
 DcfiyFA==
X-Google-Smtp-Source: AGHT+IGIR2cRb/7Z3h1BQ9GKIJpdqW62RVsh02aDfszaPCrEHcwcS2wOnAIfnkn8E9A0MRdlviHTuA==
X-Received: by 2002:a05:600c:354c:b0:439:5afa:ecd1 with SMTP id
 5b1f17b1804b1-43999d7210fmr79138695e9.6.1740064772847; 
 Thu, 20 Feb 2025 07:19:32 -0800 (PST)
Received: from [192.168.1.33] (lputeaux-658-1-173-28.w92-154.abo.wanadoo.fr.
 [92.154.108.28]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398a8007easm106846815e9.21.2025.02.20.07.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 07:19:31 -0800 (PST)
Message-ID: <df0b1287-1a4d-43ad-860a-59bcd6ec3c7e@linaro.org>
Date: Thu, 20 Feb 2025 16:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pvg: do not enable it on cross-architecture targets
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250220133306.1104382-1-pbonzini@redhat.com>
 <20250220133306.1104382-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250220133306.1104382-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 20/2/25 14:33, Paolo Bonzini wrote:
> PVG is not cross-architecture; the PVG guest drivers with x86-64 macOS do not give
> useful results with the aarch64 macOS host PVG framework, and vice versa.
> To express this repurpose CONFIG_MAC_PVG, making it true only if the target has
> the same architecture as the host.  Furthermore, remove apple-gfx.m unless
> one of the devices is actually present.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build            | 6 ++++++
>   Kconfig.host           | 3 +++
>   hw/display/Kconfig     | 4 ----
>   hw/display/meson.build | 9 +++------
>   4 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0ee79c664d3..ad2c6b61930 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3367,6 +3367,12 @@ foreach target : target_dirs
>       target_kconfig += 'CONFIG_' + config_target['TARGET_ARCH'].to_upper() + '=y'
>       target_kconfig += 'CONFIG_TARGET_BIG_ENDIAN=' + config_target['TARGET_BIG_ENDIAN']
>   
> +    # PVG is not cross-architecture.  Use accelerator_targets as a proxy to
> +    # figure out which target can support PVG on this host
> +    if pvg.found() and target in accelerator_targets.get('CONFIG_HVF', [])
> +      target_kconfig += 'CONFIG_MAC_PVG=y'
> +    endif
> +
>       config_input = meson.get_external_property(target, 'default')
>       config_devices_mak = target + '-config-devices.mak'
>       config_devices_mak = configure_file(
> diff --git a/Kconfig.host b/Kconfig.host
> index 842cbe0d6c5..933425c74b4 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -61,3 +61,6 @@ config HV_BALLOON_POSSIBLE
>   
>   config HAVE_RUST
>       bool
> +
> +config MAC_PVG
> +    bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 2b53dfd7d26..1e95ab28ef4 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -141,10 +141,6 @@ config XLNX_DISPLAYPORT
>   config DM163
>       bool
>   
> -config MAC_PVG
> -    bool
> -    default y
> -
>   config MAC_PVG_MMIO
>       bool
>       depends on MAC_PVG && AARCH64

Hmm what about keeping a MAC_PVG_COMMON instead:

-- >8 --
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -141,15 +141,17 @@ config XLNX_DISPLAYPORT
  config DM163
      bool

-config MAC_PVG
+config MAC_PVG_COMMON
      bool
-    default y
+    depends on MAC_PVG

  config MAC_PVG_MMIO
      bool
-    depends on MAC_PVG && AARCH64
+    depends on AARCH64
+    select MAC_PVG_COMMON

  config MAC_PVG_PCI
      bool
-    depends on MAC_PVG && PCI
+    depends on PCI
+    select MAC_PVG_COMMON
      default y if PCI_DEVICES
---

> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 94f4f05d36f..b9bdf219103 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -61,12 +61,9 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>   
>   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
>   
> -if host_os == 'darwin'
> -  system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: [files('apple-gfx.m'), pvg, metal])
> -  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx-pci.m'), pvg, metal])
> -  if cpu == 'aarch64'
> -    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: [files('apple-gfx-mmio.m'), pvg, metal])
> -  endif
> +if pvg.found()
> +  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m'), pvg, metal])
> +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m'), pvg, metal])
>   endif

Directly using here:

-- >8 --
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 94f4f05d36f..f636ca0999c 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -61,13 +61,9 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: 
files('artist.c'))

  system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 
'ati_2d.c', 'ati_dbg.c'), pixman])

-if host_os == 'darwin'
-  system_ss.add(when: 'CONFIG_MAC_PVG',         if_true: 
[files('apple-gfx.m'), pvg, metal])
-  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: 
[files('apple-gfx-pci.m'), pvg, metal])
-  if cpu == 'aarch64'
-    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true: 
[files('apple-gfx-mmio.m'), pvg, metal])
-  endif
-endif
+system_ss.add(when: 'CONFIG_MAC_PVG_COMMON', if_true: 
[files('apple-gfx.m'), pvg, metal])
+system_ss.add(when: 'CONFIG_MAC_PVG_PCI',    if_true: 
[files('apple-gfx-pci.m'), pvg, metal])
+system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',   if_true: 
[files('apple-gfx-mmio.m'), pvg, metal])

  if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
    virtio_gpu_ss = ss.source_set()
---

?

