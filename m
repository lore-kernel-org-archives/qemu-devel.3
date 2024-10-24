Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B75FD0BB56
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 03:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3oVa-0008JQ-E3; Wed, 23 Oct 2024 23:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3oVY-0008J1-Ed
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 23:27:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3oVW-00081h-6h
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 23:27:32 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-207115e3056so3206295ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729740448; x=1730345248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C0U4mqd6T8oktV6VofwR7Wu4lSiuqUmoxkeslzhlwCk=;
 b=QbmyZ3Dzce50VbTmpnMKHdJgE5rNMF+5TZg+kF0yhxjcTigMM6jw0iI3Fo07WZTP2m
 phKYOSrhRgwguw3RAb0JWje5d3TmFRxA7iy/4gSh7pfNUD5wT0A+yxmBLW0y0Kx/Yzkh
 9gMOG6UjgnfgcQoso3CRJ7JkpExglZkB9qaN1lMMWSPJvdWYw+TB1JpQ/k9ZHU9kE1n9
 XYpMeBqZ6l0Cx4E2W4HHzlrmD41V+xGU4yRgREW8Vzuvi0CYCJCTNvluGaIIILMw+6P/
 bMSH3W9o9DS0yqVcIY0k5lS1jS+iLUXl0dsHfN32T/tRrlScbZBwtslFKDM6Zqom8TFD
 v/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729740448; x=1730345248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C0U4mqd6T8oktV6VofwR7Wu4lSiuqUmoxkeslzhlwCk=;
 b=FFyQQkGW+d6nvia3mB8HBDdhvNDTcZN/lY3F1Kv7SRMfYZ9aGBHAHwpe9je3WmMg3n
 f+8wQwMFJSiKdYRno5qweb9sEEVOlX0Gke48iIEwqrrkKPdH1/X++dghVKeV76ovjzfI
 UU1h7DyJ5hJu0ae27mXB/ts3DWldFSjIb2oQWjD/4RZrM8+j/iE2i3cm3uo4A+XFJgHm
 On4cBQ/udNS8HTKMukxLb/9IQtH9UQ80GtAgmBnoit6SgyIfIYVI1z4mMJhP3Q7sogMU
 qLG/v3bajsMY8zPs3zG22XofuUhPaGmGuNQ4rikCRQDXWnJO/3lBfrHLdXlWq6v8H+PD
 kMNA==
X-Gm-Message-State: AOJu0Yw0hVDilAo6UepEGsxKpoVeQUI4I2TczRKTpL5nwBL3z2DP76Yy
 0hjilsischTnEnSIcooQUp9aROxitiACPOxAmAhQxRp5GDVP1Caj+i3pph2ajzQ=
X-Google-Smtp-Source: AGHT+IELl0a6AMX1ZEGiCY9u0rT8kYG77X+m2uOIX0209Pci80TaYtZhV6vIRFHbfNKCLc9RzW75OQ==
X-Received: by 2002:a17:902:ce0e:b0:20c:8907:908 with SMTP id
 d9443c01a7336-20fb9aa20fbmr4948175ad.44.1729740448170; 
 Wed, 23 Oct 2024 20:27:28 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f65a3sm64085645ad.290.2024.10.23.20.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 20:27:27 -0700 (PDT)
Message-ID: <7965f970-cdbd-4e3e-bc4c-62fb496a9e24@linaro.org>
Date: Thu, 24 Oct 2024 00:27:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 51/98] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers
 (CMD9 & CMD10)
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-52-philmd@linaro.org>
 <94b2c5bf-53d0-4c74-8264-f3021916f38c@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <94b2c5bf-53d0-4c74-8264-f3021916f38c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Guenter,

On 23/10/24 19:24, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Jun 28, 2024 at 09:01:27AM +0200, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> ---
> 
> This patch results in:
> 
> [    5.976133] Waiting for root device /dev/mmcblk0...
> [    6.501462] mmc0: error -38 whilst initialising SD card
> [    7.557473] mmc0: error -38 whilst initialising SD card
> 
> ... (repeated until session is aborted)
> 
> when trying to boot Linux for sifive_u from sd card.
> The command used to boot the image is
> 
> qemu-system-riscv64 -M sifive_u -m 512M -no-reboot \
>      -kernel arch/riscv/boot/Image \
>      -snapshot -drive file=rootfs.ext2,format=raw,if=sd \
>      -bios default \
>      -append "root=/dev/mmcblk0 rootwait console=ttySIF0,115200 earlycon" \
>      -nographic -monitor none
> 
> Bisect log is attached.
> 
> Guenter
> 
> ---
> # bad: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 release
> # good: [c25df57ae8f9fe1c72eee2dab37d76d904ac382e] Update version for 9.0.0 release
> git bisect start 'HEAD' 'v9.0.0'
> # good: [2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219] hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
> git bisect good 2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219
> # bad: [76e375fc3c538bd6e4232314f693b56536a50b73] docs/qapidoc: add QMP highlighting to annotated qmp-example blocks
> git bisect bad 76e375fc3c538bd6e4232314f693b56536a50b73
> # good: [720c0f3e6cf856fa62c06a8f0005d814684c30d9] hw/sd/sdcard: Register generic optional handlers (CMD11 and CMD20)
> git bisect good 720c0f3e6cf856fa62c06a8f0005d814684c30d9
> # bad: [5915139aba1646220630596de30c673528e047c9] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
> git bisect bad 5915139aba1646220630596de30c673528e047c9
> # bad: [188569c10d5dc6996bde90ce25645083e9661ecb] target/i386/SEV: implement mask_cpuid_features
> git bisect bad 188569c10d5dc6996bde90ce25645083e9661ecb
> # bad: [8442e1625ba6723bee2c6d0fdb7207a3e27a2b05] hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
> git bisect bad 8442e1625ba6723bee2c6d0fdb7207a3e27a2b05
> # bad: [96f3d00ac1680f978984314d24ae6f2f6f281fdc] hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
> git bisect bad 96f3d00ac1680f978984314d24ae6f2f6f281fdc
> # good: [1ec3cb893fa8883f5baf69850a4d0a97502bbad8] hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
> git bisect good 1ec3cb893fa8883f5baf69850a4d0a97502bbad8
> # bad: [9318be060506be33a0fbf01198b0024fdeb28f39] hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler (CMD15)
> git bisect bad 9318be060506be33a0fbf01198b0024fdeb28f39
> # bad: [030897e89d3dff8ef7efd5cc570612da4476734f] hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler (CMD12)
> git bisect bad 030897e89d3dff8ef7efd5cc570612da4476734f
> # bad: [da954d0e32444f122a41c24948d4d1c718bf66d4] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
> git bisect bad da954d0e32444f122a41c24948d4d1c718bf66d4
> # first bad commit: [da954d0e32444f122a41c24948d4d1c718bf66d4] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)

I don't have access to my workstation, but looking at the patch,
maybe the fix is simply:

---
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a5d2d929a8a..1594d340a6e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1567,7 +1567,7 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState 
*sd, SDRequest req)
  /* CMD9 */
  static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
  {
-    if (sd->state != sd_standby_state) {
+    if (sd->state != sd_transfer_state) {
          return sd_invalid_state_for_cmd(sd, req);
      }
      return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
@@ -1586,7 +1586,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, 
SDRequest req)
  /* CMD10 */
  static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
  {
-    if (sd->state != sd_standby_state) {
+    if (sd->state != sd_transfer_state) {
          return sd_invalid_state_for_cmd(sd, req);
      }
      return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
---

Is it possible for you to test this snippet?

Regards,

Phil.

