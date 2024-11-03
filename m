Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6748D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alE-0006eM-06; Sun, 03 Nov 2024 08:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alA-0006a4-6o; Sun, 03 Nov 2024 08:35:16 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al8-0001WS-KJ; Sun, 03 Nov 2024 08:35:15 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so442272566b.0; 
 Sun, 03 Nov 2024 05:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640912; x=1731245712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=568WB/HhdhShwfBcr5m1kUkKamKkxukqnLj/PaLkUro=;
 b=VuxTaBKnUaUfg7fpzPqkIUkzc/pBbxK7eSzopC+cDMDF1J95PweX6V1tJOYwQEEwQg
 pf5lrZz3d2sYjZpCeQLfLggVL1h+obzPVZb+iQQvu285IafM2KTrxXlHppxLMwggBYw6
 UzVS2K5Cl0IL0zYrHxdvaVvzmBnYC6k9uiFHPgKZRHnxKouSp7/QVwH+cfkbdDUKcIvS
 hZbRV5+wiGqi6pO244qBbUKlkBDnfYG9kOiYNSSR6KeGDOr6up0GwYDjb5SBpSDixhfR
 tlZbl/VQaHmXw43nU8CIycFz+NskP8wTB5LJmsYbgWZMNV6UmiI68e/7PLkUWeNc2YYN
 q17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640912; x=1731245712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=568WB/HhdhShwfBcr5m1kUkKamKkxukqnLj/PaLkUro=;
 b=pH661Gr+n3zc4ip72WmpLqyEdYoAJwrjS1bWpbH9P9aRuLIoqgcvBIqA3JFktYI92A
 5Joqv0ZWQV1n2J4xGiL7IySV058PKzzo3pNMootNAEPvS0MrhevvqKkAqw10dB7vSMb8
 kuH2dc7UWOsLE9ABRnujIFGvaxc23NrKG+5PfnSwvDQubCGrMGLamb61/Ccp6F/afLsR
 7G6+7VIepdv2NY2nB0O0mInPSe90Gxxg483nLspvToaDUXBBNvwainQkyASchgI9uglW
 S5yUoDibHBbbCnZ+/j3t+VCWC23076Q2ao0IHS2gSquCZOAPlt6K8//tkxmN4NNp7Aar
 HPxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr54p38XXS2fNPPq8ZOJuHXkRybYcz+EC/7ic/c02wIy0AB2WOJsLvHr/V31OUJZ0XOjmD/sNCgDYA@nongnu.org,
 AJvYcCVyVSN+lSIincVQa43Y2jvZ/uh9UJHtoTFukz1jDxi0pz9+vHUObXHW5HH5Pcfq26z1n7WLm4CwZeU=@nongnu.org
X-Gm-Message-State: AOJu0YxtkhhaFsQNSO+93iqa5u9HebbLqsPqB2jTMliYPc586ByC4Ypq
 wAJ3B7uhuA085sfVxE8dX3zCS76HMYzhl3EhqHv0GrS1Lr3fPjU7iG1pLg==
X-Google-Smtp-Source: AGHT+IHYHxcRTnkfIsp7f1mRhHmZs95LZaTT6yxpsE37c8QlQfGO6n6UtdgOjl+iD2KK3cpnLAgLEg==
X-Received: by 2002:a17:907:7ea4:b0:a99:ce2f:b0ff with SMTP id
 a640c23a62f3a-a9e5093895emr1243348566b.33.1730640911637; 
 Sun, 03 Nov 2024 05:35:11 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:11 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 22/26] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:08 +0100
Message-ID: <20241103133412.73536-23-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i2c/smbus_eeprom.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 9e62c27a1a..e3e96d4a2d 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo smbus_eeprom_info = {
-    .name          = TYPE_SMBUS_EEPROM,
-    .parent        = TYPE_SMBUS_DEVICE,
-    .instance_size = sizeof(SMBusEEPROMDevice),
-    .class_init    = smbus_eeprom_class_initfn,
+static const TypeInfo smbus_eeprom_types[] = {
+    {
+        .name          = TYPE_SMBUS_EEPROM,
+        .parent        = TYPE_SMBUS_DEVICE,
+        .instance_size = sizeof(SMBusEEPROMDevice),
+        .class_init    = smbus_eeprom_class_initfn,
+    },
 };
 
-static void smbus_eeprom_register_types(void)
-{
-    type_register_static(&smbus_eeprom_info);
-}
-
-type_init(smbus_eeprom_register_types)
+DEFINE_TYPES(smbus_eeprom_types)
 
 void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 {
-- 
2.47.0


