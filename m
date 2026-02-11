Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A10ECD6C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqD6n-0004g8-Lo; Wed, 11 Feb 2026 11:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vqD6l-0004fN-Lk
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:30:31 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vqD6i-0003EM-8C
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:30:31 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-354c67da885so3645698a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770827426; x=1771432226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7QZcWJnWVa5k+yszUH7E3DTG+Bx1A6dVCsXXTNy/HZM=;
 b=gIwIav2Bm3L6ZeeXiGeHY3hakzKAFtscLCf/Q0iis8xCujAM16DN/Lhyy7Xrsa5t4C
 WUFl01eUmD/W5kWzn+9V5DemIBgEt/sunN8ErWR4E0/9nN7l72jfQYZqgjE7exPW0gv/
 f/OMPHsASRTxhr0SkUkcONpk3m6zmnoHAs5GaW2zXLm+90G7Z+T/PaTYE5rJGsBh9Vm1
 9V58Me/LDd6hrXpEay/FGkH1Ozz0u8lROOsNikjTRDj30ssQ0KaCrACnXCct9Yf4DXGe
 ZjArhVBc4bPDRANPgNqC6iplpjtNfk0C7k5J0OBsa92kudOnPawMrGt0q4jNx+BIa3s1
 LG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770827426; x=1771432226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QZcWJnWVa5k+yszUH7E3DTG+Bx1A6dVCsXXTNy/HZM=;
 b=aBT9hzRCyu8PInzV25Wc064pV9QVEdg/faNVYhwBDCGnG40jd0ZA7IEvVUg69BLm78
 /xW8brrtne3WEZsjVCniwKsPcxxJObIdmDdkKV9CYAb5D6yPBxWvOMevcAh1AXSTaNHu
 LP0PkdMqkVBdEC6FdX13ZABvDt9ES6/iPfxWLTb2GqwarhaTHzuUC6KVF2WHB9yGgYBK
 TBd1fF/z1oVKORM+KOHrzjjQzf1pL6dP2F65dz/tyftqmxo9m7966GBsNUmq/bjdPoH3
 rL3TOhot6amzKLAAIoX7V4MMKKfr66dBEpkpUXAFBDUVJhiQgr+xs67LK9wm8btejxvT
 8Hog==
X-Gm-Message-State: AOJu0YxhrCJWX9pGhSosPlOuFg8TAHS9ZdLl8d3eh8zLeXHQekPVdDTe
 KAgMx/kO9oJEoHubjdc9Q2z/oBEoBDk8GvgLlXk28Z5auGxuyYhKDYaH50GlTA==
X-Gm-Gg: AZuq6aK2KNcgAQnooiLuqeCDarGRuzCUMcZsBWOX/zlXUD1INQn4QR+CuYMFBvmR3Fh
 O6Gm72/vzICRddsoReEYsODMxoaxxupGKn+KzQRBDmhnYx4L4nSNhfYjHxG8nchqx0f0SvPwINt
 s9QcyAGI2cEcj7tnYWKFx/v7gjpwKCCCRlylssOxYHf7XwkYRm9F78/KfWfeQfA2nNIe+TJbU73
 kmvpWZRwrjrwJWw71G803gl1EFOiiFDnPvm+33zuEZw1LWOAkFElzaL31Tq+2ryLV2EOGKk2d+A
 Q9/lGT39mfLY8OWIjNCUXHDIdnaZ7yXjuZa2XUU/wYO2TM+7y10bCLyTudSK15HG/2chSRSHcw7
 bIHT63ekzxxL8YjBpPjOG6vSEbApS4iKQaev1kEyQzGuytOdTVkZlm5cnx5XNweAA/SGMJTQ4XU
 Wy37wtra2TFn9ELzavE1eOD7/pdRXKN3/Ie6o4FGbJPhIpOURTI92O
X-Received: by 2002:a17:90b:2b87:b0:356:3ba2:122c with SMTP id
 98e67ed59e1d1-3568f30530bmr14829a91.9.1770827425626; 
 Wed, 11 Feb 2026 08:30:25 -0800 (PST)
Received: from localhost.localdomain ([119.234.105.149])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-356629314fbsm6387951a91.0.2026.02.11.08.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 08:30:25 -0800 (PST)
From: Choon Keong <ckeong.teo17@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 Choon Keong <ckeong.teo17@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2] hw/i386/pc.c: add description for fd-bootchk option
Date: Wed, 11 Feb 2026 16:29:09 +0000
Message-ID: <20260211162909.6550-1-ckeong.teo17@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The 'fd-bootchk' option for pc and q35 machines currently lacks of
description in the help output. This makes it difficult for users
to understand the purpose of the command.

This commit solve this issue by adding description using
object_class_property_set_description() in hw/i386/pc.c,
adding the the description message for the option 'fd-bootchk'.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3193
Signed-off-by: Choon Keong <ckeong.teo17@gmail.com>
---
 hw/i386/pc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cb074c0a0..4687719766 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1822,6 +1822,8 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
+    object_class_property_set_description(oc, "fd-bootchk",
+        "Enable/disable boot signature checking for floppy disks in BIOS");
 
 #if defined(CONFIG_IGVM)
     object_class_property_add_link(oc, "igvm-cfg",
-- 
2.43.0


