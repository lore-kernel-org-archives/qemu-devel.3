Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67732EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKE-0001KF-1d; Mon, 23 Feb 2026 12:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKB-0001EM-Gf
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:23 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK9-0008VL-UX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:23 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4362197d174so2920754f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866140; x=1772470940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bp3RXdjJyq2zUkMPFoXr57Ilr22nwEt2DEhIgGusj+Q=;
 b=OxZ9v46BKMhJwt8TwEKAcCSe3Q1PCbjwhH1sQ24HIhDhQHEuLOsxaYhK5++D3jN/dG
 ZINsItsXfmpHJPoRWODIpRKmLZ4J3jbxrmpsAkfePLA5eiPMTNZrvfs+fT1YSqIBxwud
 GIH0XOsH9xCOB01JiN6QcQEW+6jnH+9kyRo1uAoVR0QffwVQO5TdTOfn0XBMbcnj9T5e
 bj5gvBBp/1cgm795QRG1jATPPVFkjHhZc6HFM0LRBvpsaOGVuBnWSIL57iIkDp0hsUfy
 ndfXV3VISxPjSCzG37FbBPo0wXUiA7Ps9t7IrBmUHd+KXbhz1ZkektHidbTW58XexeQT
 MroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866140; x=1772470940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bp3RXdjJyq2zUkMPFoXr57Ilr22nwEt2DEhIgGusj+Q=;
 b=CcGy5hzrsZgATDyGibM59FwjL7SLBCNAydK3obBr5YSLcNowyT92qB1qtlLXrsiKec
 REMYzYtwivrU57Nh02W3EEzAv5kme+EtqQAy0TxQh7tU3TmJmRdtRenC20ue+AzggE00
 sxcKA4aV6tl9KvLb5rLzP2X+ay/+Iw0b9Sd7NX1C9dEJiF2II23wxKLDcbV02MRBdSN4
 LUTUJiF2L+xvxMB1KaJPpdwTW4/ifuoUp/vcDXkiUUE9TAHcEFYmz2CUBQ1Ibw290Bx4
 PMf7vQAg3avcHfWrRzkGtx2a3KuzUAturD2eBSSLS9sb0gJSk2Sq4nV0sF0ZeT2q6Nfz
 gaLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuPxMFdRw0cwbaJkTQ+AC9X+LkbC2GtOiiL5fB4A25TSxBV7v9z1OqgtZmLhWyD5+OBPF6xxz9Fl52@nongnu.org
X-Gm-Message-State: AOJu0YyasZECinwMKlL86jit2rm3YRtT4iMyeh8M0dVAEevVK75mp8fY
 SDnNBkK+0KbtkOUN7LM21z7iutnn0RyTzyoAVi3B/039Wdci9kstez9plvF/89pPLb4=
X-Gm-Gg: AZuq6aKbU+kga7ZQZLgpRdj3B1DRHUNyoSXBng3GI3LDgYgll/0zUsxxfUb4AQ1rC+t
 CmrRl3O802G2PXVSgincD5/8nei18U4gP+SoLTEZxInckd+YsZjipXUzOHnboOeMWNMADS43oHN
 gkWvV/2YC1zvEG2tnffiXfy2c2plZwqluiEeUOtzhZ1V3GODKdppCYiD00ekT6K6oJ4yxiUkJRx
 E96kmQhNqphtXRLKgcMrsiV6ZkIEvpM/cR37i4bzu3pDjUJ3ynrwbmIEMtkf+KyLD4nQ1l0SQRN
 0gmTtxh04fU12NVQkiXCB9rIRLPs0g8ZUQdn62ZwpvQN48JBaJWRaYHWnxgfJDVytEsn7rBxPCM
 F/yGRiQp4Jt2NevrbspS0mdWVVbZrNaTkrTnkJ61zLaHuLbO+6xXIcXmAC1oBziOsBeqKAXMRvz
 /Kxx3BmwCwcEN2jjC+dhJwpnrHEFDlSaAb+/pmhhkBkBCB/7EZMSORi2dLymeYkwSnF90hTpd6D
 9pRn63/DOx5B3NfKN/Qn9U+4YD7iwY=
X-Received: by 2002:a05:600c:a00d:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483a95bf2f3mr162385865e9.14.1771866139684; 
 Mon, 23 Feb 2026 09:02:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/65] hw/intc/arm_gicv5: Add migration blocker
Date: Mon, 23 Feb 2026 17:01:12 +0000
Message-ID: <20260223170212.441276-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This initial version of the GICv5 will not support migration:

 * the spec is still only at EAC level, so the data to be
   migrated might in theory change before it is finalised
 * when we add support for missing features like EL2/EL3/Realm
   we might find we want to refactor the data structures we use
 * I still need to check against the proposed KVM GICv5
   handling to see if there are any awkward mismatches
   that might affect how we want to store the data
 * it's experimental, so for pragmatic reasons I'm skipping
   it to get the initial version done faster

Install a migration blocker to enforce this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 0eb4348e81..73a6e629df 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include "migration/blocker.h"
 
 OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
 
@@ -194,6 +195,7 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(dev);
     GICv5Class *gc = ARM_GICV5_GET_CLASS(dev);
+    Error *migration_blocker = NULL;
 
     ERRP_GUARD();
 
@@ -202,6 +204,12 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    error_setg(&migration_blocker,
+               "Live migration disabled: not yet supported by GICv5");
+    if (migrate_add_blocker(&migration_blocker, errp)) {
+        return;
+    }
+
     /*
      * When we implement support for more than one interrupt domain,
      * we will provide some QOM properties so the board can configure
-- 
2.43.0


