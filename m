Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637D6CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R4-00068m-9p; Tue, 07 Oct 2025 10:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Ql-0005vE-O9
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QM-0002Ka-2a
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46f53f88e0bso18541725e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846334; x=1760451134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGPgMMlCVRnRjuzbPKqc0kAA2T5wiZUCBp+W8rMaiIk=;
 b=fNmft2nUUrfr4ZA2Z4sr0/86ga2CXg3ISGj7bvn0yEWRTPUZZJ7kGNffLuUsiOQMuh
 mmBC/mE3Zpn8i2HOqWUBh9ELn7rKugZMN6Jg0mce6ZBEQ/SKu7GwKfzPR858h0hPeUy3
 U4pNsfk5YgDWqFcT5nogsNUpPP9nx/pf8bdNXX+//eOJoUN61V6GfW5EBxwCRsF9ZMOh
 yGPPddVwFtJj9B6i95O7sC1udk2BvpXS+GIWly9Gc2fvmLRakyCRVhQdIPzAOM4UHw5u
 Qz7XrW94M3s4ni+NFrvj29pKYUybPAq4NkFeYkJobe4iLqaYv1zCJUSy2x7WUdMHh3TN
 Wbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846334; x=1760451134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGPgMMlCVRnRjuzbPKqc0kAA2T5wiZUCBp+W8rMaiIk=;
 b=O3CnoOqODbzOa4wJfof7/ICZF2wjaVCm9dPUXAacQaXmq3AVAxggCQrTw4ndEbcXVG
 UOgvNcc1KeQCGmEk2gX6hD4ZvZhNpDOiFJQAXghKTbheVCNXqKlcO36v8qe0zaugiPyB
 w4HZIELnQKdCaGykE1VaJG+g/lIMxYVa42ZdRmjgDwbMPtl/XhDDmfZlKMxLUAINTdsJ
 2tL9TWa1prnbSq6p3mDX/DzVt69ycijmJdFpuk/zG3MLWzS5dNu+Qn6Ak8jHfjbbuMbM
 DF3o8oMns07LKGkD4gmqTYf8CeVk1Krvr+PlrY+SJjdBv2hvrulxqSxgsaKIKtnFvv9m
 I4Bw==
X-Gm-Message-State: AOJu0Yx5mG5z7foqb00CvIFPaVBlzUPAqx4uXQ2DgRGv8Lh6v6PqhVWK
 H78YA7bE6+pgnqaVBXjFgfUR1P+q43MPomJVTgjuBtjpLCdmttvor54jnnt/O9mHkrWCPrw2t4z
 dh0sm
X-Gm-Gg: ASbGncso4mFx0ScAr3j9fMfN3H8jXMHFgGJhS+y8ia61DttvNkE9WT7BhJSNSVt/PBr
 S6WI8+HdOFvTmtiseDNDW8QXDh+4UHiT+rQzFNVn3STQ0QWb6p9K1l2uV/o7faBWHrypRoPUgqT
 Cm2DhR+eBCqoa8Gr9b/SP0atiD7cI9jSM0jkKHVaeRfV0HHMqXh5silNwDw5wnRpgcuOKCuQCbY
 5rCoJBUkv+/Tfx4e131XZcI02w85KxYx4Tn5ktkqClREsSs5uPf7+FEo4LYbnbKMEyH+lB6yoc9
 HPGq/ZC34UaarAB+fWOqGSoosXW5gqW9MAxXyioDDizVCFvbzflQRokugTD5Ww0/h+KitNmZLaj
 magB+mxtY0/dyDezgtWb/T2KV3gxmeg6oi7l5QM3haYL+WUkEhpGCYMtR
X-Google-Smtp-Source: AGHT+IHYkUvMIMvpEBgOxn3sCAyJrutPHbD6UDwWlCw/pzgvE7lGYbScWPXNVwN9FKEKDykLv+CfrQ==
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46e74cc4609mr86519385e9.17.1759846334234; 
 Tue, 07 Oct 2025 07:12:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/62] docs/system/arm/xlnx-versal-virt: update supported
 devices
Date: Tue,  7 Oct 2025 15:11:05 +0100
Message-ID: <20251007141123.3239867-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Luc Michel <luc.michel@amd.com>

Update the list of supported devices in the Versal SoCs.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-45-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 2c63fbf519f..94c8bacf61a 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -23,11 +23,11 @@ limitations. Currently, we support the following cores and devices:
 
 Implemented CPU cores:
 
-- 2 ACPUs (ARM Cortex-A72)
+- 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
+- 2 RCPUs (ARM Cortex-R5F) with their GICv2
 
 Implemented devices:
 
-- Interrupt controller (ARM GICv3)
 - 2 UARTs (ARM PL011)
 - An RTC (Versal built-in)
 - 2 GEMs (Cadence MACB Ethernet MACs)
@@ -39,6 +39,9 @@ Implemented devices:
 - BBRAM (36 bytes of Battery-backed RAM)
 - eFUSE (3072 bytes of one-time field-programmable bit array)
 - 2 CANFDs
+- USB controller
+- OSPI controller
+- TRNG controller
 
 QEMU does not yet model any other devices, including the PL and the AI Engine.
 
-- 
2.43.0


