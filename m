Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71710EA3F3A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplwj-0005Jb-DT; Tue, 10 Feb 2026 06:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vplwh-0005Gg-Aj
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:30:19 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vplwf-0008I4-L1
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=1QWf+2DdLLTe76hTUNOLUTqqd9JLohu4JMeszhVSw/g=; b=Uczrj3bkbWEskK/
 scWEvH8z+BVg54cYL2aYEgbUaMW+Jjt4J/ihU7zQGj7CRpT7PBJpk4MGS6eKimzcQEQ0KKBsM76J6
 FxhybC3x73ip7beBuKw7xxif1siALMC/uKaLViAoSIozaZ+0wqhfNTI2hoo2EyLxcClbxufA/MAQE
 R0=;
Date: Tue, 10 Feb 2026 12:33:12 +0100
Subject: [PATCH v4 1/8] target/alpha: Introduce
 alpha_phys_addr_space_bits()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-phys_addr-v4-1-725a589e83c8@rev.ng>
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
In-Reply-To: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, palmer@dabbelt.com, alistair.francis@wdc.com, 
 pbonzini@redhat.com, gaosong@loongson.cn, maobibo@loongson.cn, 
 deller@gmx.de
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, add a
a runtime function to correctly represent the size of the physical
address space for EV4-6 based on the current CPU version.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 linux-user/alpha/target_proc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index 71949d380d..6b491ffa3a 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -6,6 +6,7 @@
 #ifndef ALPHA_TARGET_PROC_H
 #define ALPHA_TARGET_PROC_H
 
+#include "qemu/osdep.h"
 #include "target/alpha/cpu.h"
 
 static uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env)

-- 
2.52.0


