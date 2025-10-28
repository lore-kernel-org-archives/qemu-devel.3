Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC44CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhCf-0007Fz-E4; Tue, 28 Oct 2025 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhCd-0007Fb-Lm
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:24 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhCa-0005V4-Gt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 67F6248D5E;
 Tue, 28 Oct 2025 10:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DABBC4CEE7;
 Tue, 28 Oct 2025 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761648318;
 bh=xVnqX8crbKqd8uWLNFV2xVdJ2zPB23rGCWpVzawCkbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=myMMvoSXfcqZ+0CGHxOkDKAKjEOysapkQVz0Ulpqm+I32MhAuY5Vp41IDXyC6hd7b
 rmxTCDavsP7AjvABLENeHPe6iHWqwnDu3Sjd8azjYNzbaSPf6xE6YTAxOAonkj1Laf
 Ka6uV0nlbJVl3UUA5Por882ky7OolzURTYGlhAoWUMSSwrz2O0Wx+d8kf3fHrt6PDc
 sHuItETnQDwVqNR/4ehP5zJOwJz2ZAS/5dA9sIVQsTF7MSGg366Nrp4EbjIdXPKJuS
 ovIF8pq7dtyG9/+Bl6gLcKszHNc5XqGHeEPiG1WX8HCBbw4Co1s61pQZLdZoe1w5cw
 pcY4XHTx09IbA==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>
Subject: [PATCH v3 4/9] target/i386: SEV: Validate that SEV-ES is enabled when
 VMSA features are used
Date: Tue, 28 Oct 2025 16:13:29 +0530
Message-ID: <57e9313692d7aad7f663a267f360e9ff708a1c77.1761648149.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761648149.git.naveen@kernel.org>
References: <cover.1761648149.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 89cde2c6464a..35df7be4f67c 100644
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


