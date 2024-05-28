Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2668DC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBu00-0002Mx-2p; Tue, 28 May 2024 06:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sBtzu-0002MJ-FY; Tue, 28 May 2024 06:24:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sBtzs-0005j6-Q2; Tue, 28 May 2024 06:24:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so484835b3a.0; 
 Tue, 28 May 2024 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716891837; x=1717496637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WV0J4buDakTlrBzgJ0rNMX1xKXRSU6p21ZGDgZCBtPA=;
 b=OUGhBusjDPp/lRK0ZHE7P9A6ycPnDAppGfKkBFDDdyUo2CdwXOedTEJOnHKdgSYDcR
 u2TlzJ/GTQzLimjBCmLRr/lFCjcNCgjQduLd06wVXHDH4NQ9A+D0xbrAf8wUI73daBqZ
 mBDAgcn8cCYvwbVQ6ooaJzC7/6g1g1ELC3r1zSfsmQ4aGjwvoIMafIcjK7QNMlhqx+Vw
 a6cHNEYZi8ZZpweSQlQocjfzaOBiMSnoQRKzVl1q7Rtf1xfDMBvZjFuAMsuRgQkLX2yV
 eWJHEr0yZU7zBlMxiZmliO3VL8sfEHZhACn5hgUWBv08syGPqZIhB86iMOZCZV/W1dJQ
 T2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716891837; x=1717496637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WV0J4buDakTlrBzgJ0rNMX1xKXRSU6p21ZGDgZCBtPA=;
 b=CCNKW5IZ2/7IHUm3J0DKj9GIJofsUcLIWtb06ZlFsQyE4j5pLvctKKdl6IQx8GXL0W
 0acBXjJZhVGGpVFv3pAY6u7ZKKI8jkx/AUFKBqTm2ga8dfMwSvKp7m1QOeO6oaNDak7J
 32lBLnL0EUDwV8WK4n0QgVJURLNgkxwSFkDWnaF0HDvodZG7+ZFnF7aMoa0Szt7eFxD5
 SE4mNL2R+4pJ3YE6r/9877BKISYHZn/rNqwDgHjnmRhWyqYoAQc5N7t6j7Px+/ookmnd
 LZ+BYcoK2zZvVaOimNZ/zi1TFDxuHLu46MMAgiGQny8zMJG+FrgHaURN3Uq2ZxCNpuO6
 jm7Q==
X-Gm-Message-State: AOJu0YwpAht8if5duJe8lX24ukN+Qkncc8hpL/jmcsqDc9Tn/zCnLndD
 BwOZpacM0fnPyBNTqGA6tPs3T0rnhWlo4XFet72Cn68H8/pnGpS/FslNBg==
X-Google-Smtp-Source: AGHT+IHo6DDgggILzH0XwlTHwUsrsOAGqGB3pzZ43lnHPDgyMHVR+bSQfGFMfvR2aJzgVieuumBWIg==
X-Received: by 2002:a05:6a20:d48c:b0:1af:f92c:de8e with SMTP id
 adf61e73a8af0-1b212f724e1mr12762597637.52.1716891837174; 
 Tue, 28 May 2024 03:23:57 -0700 (PDT)
Received: from wijungle.bbrouter ([183.83.55.203])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc36d224sm6144663b3a.83.2024.05.28.03.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:23:56 -0700 (PDT)
From: Will Gyda <vilhelmgyda@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 Will Gyda <vilhelmgyda@gmail.com>
Subject: [PATCH] Issue #2294 | Machine microvm doesn't run under Xen accel for
 x86_64
Date: Tue, 28 May 2024 15:53:39 +0530
Message-Id: <20240528102339.106257-1-vilhelmgyda@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Issue #2294: Machine microvm doesn't run under Xen accel for qemu-system-x86_64. 
Solution: microvm is now not build if only Xen is available.

Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>

---
 configs/devices/i386-softmmu/default.mak | 2 +-
 hw/i386/Kconfig                          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 598c6646df..6a73aee7dd 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -29,4 +29,4 @@
 CONFIG_ISAPC=y
 CONFIG_I440FX=y
 CONFIG_Q35=y
-CONFIG_MICROVM=y
+#CONFIG_MICROVM=n
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6ee052f9a..f8ec8ebd7a 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -108,6 +108,8 @@ config Q35
 
 config MICROVM
     bool
+    default y
+    depends on KVM || WHPX || NVMM || HVF
     select SERIAL_ISA # for serial_hds_isa_init()
     select ISA_BUS
     select APIC
-- 
2.25.1


