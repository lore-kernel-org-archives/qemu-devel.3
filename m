Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE950E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPs-0002Ok-Q3; Sat, 27 Dec 2025 04:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPr-0002Nd-8u
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPp-0002Km-Lo
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbS0JQUdWC7+PPlxoYwxell0gjNOurJnHZcxaYE2tbA=;
 b=JPeVLoyW1KKOophZ/AL6NVx7vuj0+vKW4OGKnO69/YqxjjK4S9l8RgzWth1+45oscXrSMt
 NVn6+nGU3HPA+lFyfIQcOzxwSBavdljSameTbPvP4VTbQTKZix2aBcSbjoHhDSR43e2zbS
 INU5fXRtgQz3MkuCxT9fHs6b0Xqu7JU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-zgTtyXwDODasiJrGCHkVhA-1; Sat, 27 Dec 2025 04:16:46 -0500
X-MC-Unique: zgTtyXwDODasiJrGCHkVhA-1
X-Mimecast-MFC-AGG-ID: zgTtyXwDODasiJrGCHkVhA_1766827005
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso65459535e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827005; x=1767431805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JbS0JQUdWC7+PPlxoYwxell0gjNOurJnHZcxaYE2tbA=;
 b=oZ4WOVzNjFN8Ixsbwi43zlWAVcy6IOqKvJ6nBQZFdPt7Fb9FsR8CTmDnrByhPmdjA5
 oa88eirF0h7zq9YeVE04+1ebSoXDc9yWlTj7dhDbRl19vP8hRbJx9q2zTtG6BLg8CIfv
 8UjC5qbdr09K94BSoaNdb7oMHVPTHvf4bjo+EqD95fqDapdW5sqzWoXjZ4Q30KL26eoV
 jvjC0CLikS+aGJgjwtf7PKstNA0brXgVOd/kEt/rnCZYq1IvYiPiNqDaaalVSRBQ8sgE
 +Fb8B2v33HK2Jz+ydpZdNIQV3wAxPKd82/JLeBSWmGVxz5/NCeRu2MwC6K831rTc6SzP
 l4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827005; x=1767431805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JbS0JQUdWC7+PPlxoYwxell0gjNOurJnHZcxaYE2tbA=;
 b=hUI9RdaeqaPW77oEErvwxi0hvZOohlgowhIMy2Wc4TwPI7UnF0Sx/T1rfARcGNho5h
 UP00U5qqK1LcXy4UoRi8EJ4fOeFB4VUcZgLVe725bLDVt9Nirj7wj12go6/hFlGxJMkN
 ymMjm3sNYTWba9IbRRMEhpginitvwpivXJuAoqv5IzeX0+jfV9SS03W8L2HQuN7qIxYi
 xv+C/XQCnomtsRcKP4dh0gcUiOnQhN4Al1ZpniwUUL2e/0ZpSEXF9vH0wf9rFYm/E0zc
 0uQ48yWqu7IyyhGYGaZufeLWcpGLJ85NcaEsPNiOF1Yl+HVsi4JiKmTjpnVqpz957gdy
 tRfQ==
X-Gm-Message-State: AOJu0YxtuUfid2XFbra5w5ghpdODnkNVg/bc1VNv2tVRO+uVj8EILWmH
 j6aqBtzO6CGAg+SAVe9nbSOGFv0qD0L2sfS3bw1wY8yrBC4w7Icn6fXODIDVHkIDxKu2Qm1ICPh
 2kJ5Pq6Lms6h3HhLl/bJKYUbY15JW1Uf0B5Q0mFbk9w/LhUVbMEPFedtAE/EgiK4NKFKHNcbMRI
 8StG0MNsKrSeurnPymla42R0lIOfTs+1bFRsdmTi8V
X-Gm-Gg: AY/fxX6p27/PO/mGnb7hCdr5ERjszFOGgE4G673Z+dYdDcs5kFn29Ba0M61agHfMKoC
 eE2iN474hwznCrn98Q4KAtlbiZqnT6BJD9cwRHAdDn+6rl+ceknGEc9PcHpihM4RfQxDL5EKzdb
 iAnCxnZytjLssFnUXj//kHSO8ibKfU9xSNlohHsAm+FMMmMob45Zwm6IVqMOvbdDCOaxtSaPmSx
 0RhmxZAtxs3VDJJItoM/Kxr7O6+jwaoOgh0UbtcYTsDkCSS5Rd3JJOaeQF57EizIl185lYrDN5x
 qmtRFgNGaBxdht4W3lBgsTlZMmV8YVVOV0jrLp/BXXribM7NmhNf9HB9zh2Qu7WkfRMWbLhMGKM
 yigOqH7DJms7l0IpfDS8hjmyp9u+THIM8fx3C4VnxHUGId8JnhgEPp5lVFO6a0PXvj+VZKoeJKF
 /evLWV2n09CtkiHT8=
X-Received: by 2002:a05:600c:310c:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-47d19549f9bmr249828845e9.11.1766827004836; 
 Sat, 27 Dec 2025 01:16:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElye+KDDcmz75SxE9KLbG2whH13Z4GRpGLMzCXlNAuq6kqY6dqTYFNWthQ6Wo8DEVzULgPSA==
X-Received: by 2002:a05:600c:310c:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-47d19549f9bmr249828665e9.11.1766827004427; 
 Sat, 27 Dec 2025 01:16:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm474988815e9.4.2025.12.27.01.16.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 011/153] include: move hw/loader-fit.h to hw/core/
Date: Sat, 27 Dec 2025 10:13:58 +0100
Message-ID: <20251227091622.20725-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/{ => core}/loader-fit.h | 0
 hw/core/loader-fit.c               | 2 +-
 hw/mips/boston.c                   | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/{ => core}/loader-fit.h (100%)

diff --git a/include/hw/loader-fit.h b/include/hw/core/loader-fit.h
similarity index 100%
rename from include/hw/loader-fit.h
rename to include/hw/core/loader-fit.h
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 2dea485ae06..59a625ea57d 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -22,7 +22,7 @@
 #include "qemu/units.h"
 #include "system/memory.h"
 #include "hw/loader.h"
-#include "hw/loader-fit.h"
+#include "hw/core/loader-fit.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index dc9da0b0401..633b2a90523 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -26,7 +26,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/loader.h"
-#include "hw/loader-fit.h"
+#include "hw/core/loader-fit.h"
 #include "hw/mips/bootloader.h"
 #include "hw/mips/cps.h"
 #include "hw/pci-host/xilinx-pcie.h"
-- 
2.52.0


