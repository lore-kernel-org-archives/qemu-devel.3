Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E933FC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH60-0001sz-8u; Wed, 29 Jul 2026 23:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5y-0001sZ-NZ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:06 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5x-0002tm-6v
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=3WWfX55JwVeFWu5Dl5xBCgAYmh0Nf5OcQb4Hh4OkbpA=; b=hRwe9GdoiysiGaI
 Xj6C7rf7VKJ33WPzzQZLsNahTg9rxInLJ33XNKi9fDCSl10zEuKGTNpQl9DXMwJy7DGF0OHYYNIrW
 huAYwYJ/DbFKdOtit9D4CpDP0IqVFA6Ic4nitan+pIx1TjSKS39mYfei9K0nxYL02eyTxnDtvmgl3
 F8=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 11/50] helper-to-tcg: Add simple error creation helper
Date: Thu, 30 Jul 2026 05:09:45 +0200
Message-ID: <20260730031025.12926-12-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Simple function for creating Expected<> with nice error messages.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/include/Error.hpp | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/Error.hpp

diff --git a/subprojects/helper-to-tcg/include/Error.hpp b/subprojects/helper-to-tcg/include/Error.hpp
new file mode 100644
index 0000000000..835610d83e
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/Error.hpp
@@ -0,0 +1,38 @@
+//
+//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
+//
+//  This program is free software; you can redistribute it and/or modify
+//  it under the terms of the GNU General Public License as published by
+//  the Free Software Foundation; either version 2 of the License, or
+//  (at your option) any later version.
+//
+//  This program is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+//  GNU General Public License for more details.
+//
+//  You should have received a copy of the GNU General Public License
+//  along with this program; if not, see <http://www.gnu.org/licenses/>.
+//
+
+#pragma once
+
+#include <llvm/IR/Value.h>
+#include <llvm/Support/Error.h>
+
+inline llvm::Error mkError(const llvm::StringRef Msg) {
+    return llvm::createStringError(llvm::inconvertibleErrorCode(), Msg);
+}
+
+// TODO: Usage of `mkError()` and `dbgs()` for serializing `Value`s is
+// __really__ slow, and should only occur for error reporting.
+// `ModuleSlotTracker` could be used which would speed up repeated serialization
+// of a `Value`.
+inline llvm::Error mkError(const llvm::StringRef Msg, const llvm::Value *V) {
+    std::string Str;
+    llvm::raw_string_ostream Stream(Str);
+    Stream << Msg;
+    Stream << *V;
+    Stream.flush();
+    return llvm::createStringError(llvm::inconvertibleErrorCode(), Str);
+}
-- 
2.52.0


