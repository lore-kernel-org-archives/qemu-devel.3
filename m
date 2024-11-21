Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A01D743FE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHj-0001YT-HS; Wed, 20 Nov 2024 20:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHh-0001Wj-DX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:05 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHg-0004Wt-4z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=23UMfXZbF/6Igxr41KQ6yE+eWu+hARLGdgl4G57ZkEA=; b=dn5Vc9z7EagOZg7
 jpSg5S7ifsdtyL/qDAmIbcgFfaqSJeGw9st6ai6BWao83NaolRFO7p9aZMbWm7nEQx2/KHNc5RwnZ
 OE92j+cX7+i9Xsn4mXBVioeZNwuxZLct7SVw7hoDQDwaUGn3NoqSPF+crDHorbvY65IxYFDp/V+bg
 rY=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 07/43] tcg: Increase maximum TB size and maximum
 temporaries
Date: Thu, 21 Nov 2024 02:49:11 +0100
Message-ID: <20241121014947.18666-8-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Doubles amount of space allocated for translation blocks.  This is
needed, particularly for Hexagon, where a single instruction packet may
consist of up to four vector instructions.  If each vector instruction
then gets expanded into gvec operations that utilize a small host vector
size the TB blows up quite quickly.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/tcg/tcg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d3e820568f..bd8cb9ff50 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -39,7 +39,7 @@
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
 
-#define CPU_TEMP_BUF_NLONGS 128
+#define CPU_TEMP_BUF_NLONGS 256
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
 #if TCG_TARGET_REG_BITS == 32
@@ -231,7 +231,7 @@ typedef struct TCGPool {
 
 #define TCG_POOL_CHUNK_SIZE 32768
 
-#define TCG_MAX_TEMPS 512
+#define TCG_MAX_TEMPS 1024
 #define TCG_MAX_INSNS 512
 
 /* when the size of the arguments of a called function is smaller than
-- 
2.45.2


