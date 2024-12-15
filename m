Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161CBE77184
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu0F-0004i4-QP; Sun, 15 Dec 2024 14:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu05-0003hj-98
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:57 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu03-0001Xg-7R
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:56 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e3cbd0583so369471a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289794; x=1734894594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pjAe5uWC/rd99tnYHP992w/Wxqt6VB986qUybTKyd0=;
 b=Mp3Gyraq34R++fsBpAqc4m4DmlLSOocHVAVZ9msc5jtYUAQG+ZRzQ7qAnoo910Gple
 6wLxgUb+KiZOdwHVcj/3IccxYnG9DLEaOwaBo/ubyl9XVADUAR0aysL8pqWSTb2Y+evZ
 5LULBKqSxNXc0gpc4b2nOHp2CMM/33xE48xEyTUDdDoa+Jb7MtTeCTqH6RYRkALLoPIL
 /W4vKxDUsn+yKhONI1Ij+2XPD1in52hLhMfU354/zpQ8GDmaDMxye+RmNdhMoGJql5i0
 sBdaqW1JAtCau50UulcK71sXU3KOUVoOENSGaFt6eWewr9B/gZZE5+n6aPYIrXUMOIPd
 FXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289794; x=1734894594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pjAe5uWC/rd99tnYHP992w/Wxqt6VB986qUybTKyd0=;
 b=HeHiefEFLnOgPtzV6i2eOL3L5IlOuaCY80/tVjDulDKEd5Ly94piWgyY45guisAv7G
 JURiJyCYRKvDBtTHpXROqawH0G0+gPtRTRS4HlvE0HpSkjqYeTP5OSUan3ghN/xJHl0M
 41rvE1w6xW2BUTAoV2AFkFCdJ98uvKukxrGvFxDvnxTtMBdbHCw6E0t4BCz8z1ca+7cX
 ln9sudnj9wZ+ytUNtCR0Fisx7EZ4lV/5rSssThq26DQGV3lesQqvLVbZs8XRewpf/ugX
 Wm6rQvTODoPhjUoZqreM15Jy9nNALhRng+wQsmbxUFp3y+bKs4Ee4fzHV1f7CjgiRxU/
 +jNA==
X-Gm-Message-State: AOJu0Yz4ThotIHKCOKIFsLv+Aw6JZTFXVhWztWEBdvvIE27katy8jCDa
 nmh+rT3SYZiVuB4R3IU9Lpq7H2SX+okQtz0+ER28c5oyjLgm5eiPifV0RRnjxmgZXJIXg+yo/Je
 auKqFOnS3
X-Gm-Gg: ASbGnctifKcwwaWQe+RSWtv04zMQUGfcEJ8QWMEjJru+lt/txL1DPit6R95fNhfvdHP
 sgGU6pLErofceqr353hHWLsNs4g0pulDfzkcoaQr+H8N9l9qtNVGdC4e2pRCWFGECFFea1h8kmi
 s2GCVWUHLHpM/9d6ayi1i4n4EW2PbQqXTMOkxwYeY3QQz/b/UlySBQ/OATN9E1ZwU35yaVr5TxV
 HYw6Lf2VlT1YZjTJBDtrR2UkDT0OhkyK+o9k6tJbZRgdZPrDTD17Q2Sl/px4sCM576z5l+/n+CL
 sp0/SOBfvwTAxgNhnLcYPjMWRl3kkxVnb08bTrF3hEQ=
X-Google-Smtp-Source: AGHT+IGi9r5n4YHigDg3muvWxgmjWVyky0N/pzJks7iyWOQbINym29hL7rBtMgjjqXFodEkrBfloJQ==
X-Received: by 2002:a05:6830:3695:b0:718:1cb6:e593 with SMTP id
 46e09a7af769-71e3ba4a008mr5528128a34.27.1734289793947; 
 Sun, 15 Dec 2024 11:09:53 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 59/67] hw/tpm: Constify all Property
Date: Sun, 15 Dec 2024 13:05:25 -0600
Message-ID: <20241215190533.3222854-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/tpm/tpm_crb.c        | 2 +-
 hw/tpm/tpm_spapr.c      | 2 +-
 hw/tpm/tpm_tis_i2c.c    | 2 +-
 hw/tpm/tpm_tis_isa.c    | 2 +-
 hw/tpm/tpm_tis_sysbus.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 5cd5a2533b..2bf6e7ffe9 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -226,7 +226,7 @@ static const VMStateDescription vmstate_tpm_crb = {
     }
 };
 
-static Property tpm_crb_properties[] = {
+static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 5f7a0dfc61..e15b67dd45 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -364,7 +364,7 @@ static const VMStateDescription vmstate_spapr_vtpm = {
     }
 };
 
-static Property tpm_spapr_properties[] = {
+static const Property tpm_spapr_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprTpmState, vdev),
     DEFINE_PROP_TPMBE("tpmdev", SpaprTpmState, be_driver),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index c5548b0a45..b27af230cd 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -491,7 +491,7 @@ static int tpm_tis_i2c_send(I2CSlave *i2c, uint8_t data)
     return 1;
 }
 
-static Property tpm_tis_i2c_properties[] = {
+static const Property tpm_tis_i2c_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", TPMStateI2C, state.be_driver),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 21109edcaa..9b2160972a 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -91,7 +91,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
     return tpm_tis_reset(s);
 }
 
-static Property tpm_tis_isa_properties[] = {
+static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
     DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 967f264634..88c1f1e478 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -90,7 +90,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
     return tpm_tis_reset(s);
 }
 
-static Property tpm_tis_sysbus_properties[] = {
+static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


