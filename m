Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F3CC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 01:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8rW9-0007lu-5H; Sun, 19 May 2024 21:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hburaylee@gmail.com>)
 id 1s8rW5-0007lc-Op
 for qemu-devel@nongnu.org; Sun, 19 May 2024 21:08:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hburaylee@gmail.com>)
 id 1s8rW4-0007mx-8x
 for qemu-devel@nongnu.org; Sun, 19 May 2024 21:08:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1eeb1a4c10aso59297885ad.3
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 18:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716167316; x=1716772116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SOHkXSWvHgA3/1fNfAvKV3xIPtBkGnRPeqH31mGkXAs=;
 b=iB16EGRX4E+8BtziJ+5dL67JRwKv00KD/UT0vxhdTOl3aFVbEYKyJ46ECNAL011nQG
 2y17j++90Uz7KJbYEssTCPm4rGBeyc5uT/1lli9cJXb7FoamjcBeZ7Yjb5Feha8oEQ4D
 98hcJ9pb6e+jlYzueXuePiQe32NVmijFaaC8lmtg16mMiX/KXqIEOsZgXN3ZJkm75mjO
 BpmfFK+K9+1ImrMqV8vB4JMaFF+8XiJK5rkAk22bC2elaM9AKj6T6mJp0m/LPTDLJ5ld
 Pdy/o6spZtm6bT5O+mV+OpImCBmb+o+CF+5P3od+ocZqBRuVFs1Bz1YDO9d/Fq3fQNDn
 BOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716167316; x=1716772116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SOHkXSWvHgA3/1fNfAvKV3xIPtBkGnRPeqH31mGkXAs=;
 b=dxRqVj0vRIv2zqWX7iSSfGrdnLU01/IJhXdyOjeuuc1r7ThgpAEZe02Fw1VsDvLvfr
 zwTPlFDaGSds6u72RYvgYRtuM0/Sqid4bmPKpxGu3PZcmuXIQjsS9+mQ1TYa5X0HWNd9
 LWixP0+YcxaPwheNWEPNkW6XbjUfHzUMwuRyBv+fVRK7c7wiMfc5Isv+uySPtETgaCtC
 QcqtruzSMiYEYRsQC3Esq8oIgGInP4pomiLd0lZ+EmGNfCEik0iiZ79RwmPzgy8dS1gT
 sAu8yA29YInKtpDAvaQkQ/KiOOmNwKOWQFHgy6EH7kA6XOgbII3yQIKyzS2u43lMmUOd
 oHpw==
X-Gm-Message-State: AOJu0YzvCrVJ/gFXtdHaAsVzJ5UMe+/dgRB1emOfFKU+4E1QmBrTRdLN
 ERkyXtLLN/Ce2A03XfJjoLuzQkQtSQGqG7MgcPIfiUMfrXd8SsDyDrrNWw==
X-Google-Smtp-Source: AGHT+IGXsrsV4Qgbrfm3TGpMqnzxRp8Lzv9wmWyhoGNm8powRl2rSMPe8hvi7ezc4aGehwaJ0hZ8YQ==
X-Received: by 2002:a17:903:32cf:b0:1f2:f382:501f with SMTP id
 d9443c01a7336-1f2f3825607mr40302065ad.1.1716167316030; 
 Sun, 19 May 2024 18:08:36 -0700 (PDT)
Received: from localhost.localdomain ([8.141.6.128])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bad9e66sm191923925ad.110.2024.05.19.18.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 18:08:35 -0700 (PDT)
From: Ray Lee <hburaylee@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	fam@euphon.net,
	Ray Lee <hburaylee@gmail.com>
Subject: [PATCH 1/1] scsi-bus: Remove unused parameter state from
 scsi_dma_restart_cb
Date: Mon, 20 May 2024 09:08:30 +0800
Message-Id: <20240520010830.191319-1-hburaylee@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=hburaylee@gmail.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Ray Lee <hburaylee@gmail.com>
---
 hw/scsi/scsi-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9e40b0c920..7c3df9b31a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -255,7 +255,7 @@ static void scsi_dma_restart_req(SCSIRequest *req, void *opaque)
     scsi_req_unref(req);
 }
 
-static void scsi_dma_restart_cb(void *opaque, bool running, RunState state)
+static void scsi_dma_restart_cb(void *opaque, bool running)
 {
     SCSIDevice *s = opaque;
 
-- 
2.39.3


