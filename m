Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B84CCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 08:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Uk5-0006yO-Bn; Sat, 11 Oct 2025 04:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Uk0-0006wo-2d
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:14:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Ujs-0005W4-HI
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:14:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso20513325e9.1
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760170440; x=1760775240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZmS854JNizXteH5fQgov1YImLr9bd+1MSOjC63rT+M=;
 b=MGD/T4mm2+/zsjVrR3rdO1qzd8oXpdCpIGIHAI/iztYyVA9p1c/xdfI0fBsVI7cvFA
 2cRTxuHQWvEULuoWzPWrU3wyKp+FaB2vX2qa3vkMpdXm6k3WHyn+g5g9/BVMwIpwCX08
 h+PWZndDIVfn4wJFXOCKsbcpFHLn7A5F/FdfHMIGNto1rZHMlmsXU8wjZ62oDpELAgjV
 gu5R9jpGscYAERsRpOjnKOLh+9mFpcJawdV2/gvYr3msbZ7NHH+5oKDZ9/HJ/efKK63T
 GJ9bss++WGTSqoEorkO2aprkHNNjiYVZAgq2jGg6pWcvB4p9n0Xi4OrIKcxSfUeWA30P
 aYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760170440; x=1760775240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZmS854JNizXteH5fQgov1YImLr9bd+1MSOjC63rT+M=;
 b=e+i2PDDrzZZ+LLrhF/KHnzN9uKmLmnXABCgGUBz1A1a4z2nWon74Xgcr9vIGWEg/69
 WBNUrApDejZkOHdEj/eXmvPHVf+LOjaGfEoqbhoe81M1/kzGFxJMpc/1JIhE4QbELhIl
 Ovy4pjS0USru45lcHyKSNb3w50c149tHgW3n376vcC01j3IYKwoUsR+i9jc0or4+gmxB
 kDXtMv8+OYRT4ywPJeyCXQ+ePkdmqOzLi2eLO42pauyCd/iIE8Doxr3cSh+bAD7cPkUS
 v3WeVeI4llkAZhHAW8dd6GyzKZYwbsAO73RP0YOp+uEL/n0rdyrSlIm0LUZpcJMuPTMo
 qnkg==
X-Gm-Message-State: AOJu0YwpLetNzcgsmkxtM1wJ0EjYik18oaIZFX4cgc+kMn1FijcgkEr2
 kWz44NXlaNdhvjlUiNa54YJVLUWwW/kwkNkXH40HOK93VUSkbu5csh2HY6QvvsPY
X-Gm-Gg: ASbGnculkOD0wITGYx6U2QTSdpZoZ94bjC/N0b/K0Xd1gwhbL6hhQTgNoHWjkbq+ZXU
 VNzQnKPsQj7Pp+AuvUjViPW8buakLRIRlLO5W2NtBx+SQKw4ztCBUO1IymT9++Ch4VBjWiv7ZCh
 O9AZncBUouLHiQhPrsddcjZhmRi/QzC3lS2sDUVC8h+H+yhGtbAhzFCRl+eNA6wpcpO0AqSvU9h
 ew/OItNQmpSv8wkEO865kNTey0F5s8TjsBkhG62nUelf9TCOfg4q6dNEX9u8P1M8TFuf4lY3ix2
 TZ95AgX5t+cw1UQ0Dizjfzk6kUKineyZiCSV8EBzYk/eKtPeO/kcoY0ACAzyZiq4moiLD4/Fu/N
 36lRpVU5f6LhY7iftNGv4QdiHFekAWecukBP+eo+lY8agKTsdx8bUVvTp1SozTOtM0cS5bXaQj1
 1/rTXXbzGci1u2Z6L0gAHw
X-Google-Smtp-Source: AGHT+IFg8a7gcQiqOIf7Kak5dhIYggmzGVoyxryF0M5LCH/UOeIzmC5jsVaip+nHdwig5hVwPAdVuw==
X-Received: by 2002:a05:600d:4384:b0:46e:6d12:ee2a with SMTP id
 5b1f17b1804b1-46fa29f5e70mr81247935e9.16.1760170440337; 
 Sat, 11 Oct 2025 01:14:00 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46fb497aec2sm83873195e9.1.2025.10.11.01.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 01:13:59 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH v2 0/3] Add support for zboot images compressed with zstd
Date: Sat, 11 Oct 2025 10:13:44 +0200
Message-ID: <20251011081347.4063198-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Fedora arm64 has an EFI_ZBOOT kernel image compressed
with zstd. Let's make sure we can use it for direct kernel
boot with qemu.

Daan De Meyer (3):
  Rename LOAD_IMAGE_MAX_GUNZIP_BYTES to
    LOAD_IMAGE_MAX_DECOMPRESSED_BYTES
  Use g_autofree in unpack_efi_zboot_image()
  Add support for zboot images compressed with zstd

 hw/arm/boot.c       |  2 +-
 hw/core/loader.c    | 40 ++++++++++++++++++++++++++--------------
 hw/nvram/fw_cfg.c   |  2 +-
 include/hw/loader.h |  2 +-
 4 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.51.0


