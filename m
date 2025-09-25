Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A579CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jDD-0001wF-KX; Thu, 25 Sep 2025 06:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jDB-0001w5-80
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:28:29 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jD2-0002gU-OQ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:28:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EEDF2604C2;
 Thu, 25 Sep 2025 10:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85624C113CF;
 Thu, 25 Sep 2025 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758796095;
 bh=zTjyNOX5qfNThUt3QCXjlNUgpQHT7Y8dtEBwrZW4XNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YYk330OuDfNejjkFh8VB5AzQkWTZ1LZySQ+ol7/zQk/hU2EtnJYGkMXbW3rZi+moE
 +TDo+fuksDG2Kz9029tMTuWyvuuoly28PkmFcvsh6q4Q48PB4gAPutBe0yulST58fg
 c8UFzlCQmuZIlboskw4wn55VqFpdBO7ZhdfQMsEK/Pw/bzmRwu9g8GTRIoB2kUjouw
 zux77B3ABrMPKs2yltOyTGOja0ZCDJLZEB4WLgYv0u9BaN7LQQ3O9aPZ7TfYrx3VP5
 gwjUoHrIpGxcYMipIqgA1mTs4CLuCg2B0p7MkZ8H9tSTF3M1+cnF4LFQsbKEqvo7aH
 PLkF9IycM036g==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: [PATCH v2 4/9] target/i386: SEV: Validate that SEV-ES is enabled when
 VMSA features are used
Date: Thu, 25 Sep 2025 15:47:33 +0530
Message-ID: <bbde63259b4fa7e474f1b874319d5a6aa9dd1309.1758794556.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758794556.git.naveen@kernel.org>
References: <cover.1758794556.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SEV features in the VMSA are only meaningful for SEV-ES and SEV-SNP
guests, as they control aspects of the encrypted guest state that are
not relevant for basic SEV guests.

Add a check in check_sev_features() to ensure that SEV-ES or SEV-SNP is
enabled when any SEV features are specified.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 3b11e61f78d8..2f41e1c0b688 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -518,6 +518,12 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
             __func__);
         return -1;
     }
+    if (sev_features && !sev_es_enabled()) {
+        error_setg(errp,
+                   "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
+                   __func__);
+        return -1;
+    }
     if (sev_features & ~sev_common->supported_sev_features) {
         error_setg(errp,
                    "%s: VMSA contains unsupported sev_features: %lX, "
-- 
2.51.0


