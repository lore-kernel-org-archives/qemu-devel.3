Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7EE606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=bMmPsahv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OU-0005L3-9j; Mon, 16 Nov 2026 15:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3M2-0000gM-D2; Mon, 16 Nov 2026 15:31:18 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3LS-0002CK-KG; Mon, 16 Nov 2026 15:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=oBvztot5RygZe9Wu0p7nRZjRlCb6mXp066CN+gHE2zk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bMmPsahv7pK0qNNqztqBte0CSyTIOmgRwLdoM6xqryyKJXjmov98osiRj7RuQHD7e
 I5NzMYtm0Jb6sjj0FYGaS1j6LgCzaEeyG62HAjbgkeVrJ+YmjG5hptAGrbg8RfUIZD
 MLLiRKYDJcOpRob81QYG0Og+VxpBy5tPo04ZJGZI2DhpRgDizUb1gnm2sb4MG7F8ry
 W2kOWGGSJ8pYyMSABK9cWu8QTAFkrmMdTWp5jdyoYtlwI7iHufhR8k38StTn2bfKih
 +xSEOYfYf2/PiDF2A9ZNs8Jzw9wfaHuMCk1MkfhI7MDQaR4HuNOPmTEGVkCZ8WItaG
 vadNoff8yoKVg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 950441E71C3;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9290745FBEF;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4DBA9B8EA2; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chris Copeland <chris@chrisnc.net>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 46/63] target/arm: Clear the local monitor on AArch32
 (v8) exception returns
Date: Mon, 16 Nov 2026 23:25:25 +0300
Message-ID: <20261116202554.535325-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Copeland <chris@chrisnc.net>

A/R-profile exception returns prior to Armv8 do not clear the local
exclusive monitor, but in Armv8-A/R it is cleared.

From the Arm Architecture Reference Manual for A-profile architecture
(DDI0487 M.d) §E2.10.4 "Context switch support":

    "An exception return clears the local monitor."

The same language appears in the R-profile manual (DDI111353 A.a)
§B2.11.4 "Context switch support".

We correctly clear the monitor for an A64 exception return, but
in adding v8 support we missed that the A32 exception return path
needed updating.

Cc: qemu-stable@nongnu.org
Signed-off-by: Chris Copeland <chris@chrisnc.net>
Message-id: 20261108-armv8-exception-return-clrex-v1-1-ec11079bf695@chrisnc.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: commit message tweak]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 47ecb80041034b09b96490e4ee72d06232dfc919)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 38ba515bef4..422cef2163c 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -808,6 +808,10 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
     mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
     cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
 
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        arm_clear_exclusive(env);
+    }
+
     /* Generated code has already stored the new PC value, but
      * without masking out its low bits, because which bits need
      * masking depends on whether we're returning to Thumb or ARM
-- 
2.47.3


