Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5B3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPh3l-0005Z1-Id; Wed, 20 May 2026 09:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh3j-0005Yt-VU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh3i-0004Vg-8r
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:03 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12052601FC;
 Wed, 20 May 2026 13:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062A71F000E9;
 Wed, 20 May 2026 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779284040;
 bh=E0SC7AD4xg+opLCvydgBAIKYqb02rk7N/+pspd2LlVo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GwsRL/bc/KfBjiBFuJXiCTq4Fh/w1aIecd2WZkBHQSzEM/933Oy8fvI7GomsPs376
 PIkGs2/n6IA0tWq5jz+u+pwdlh/HZsfB7TqRq1TsjY0Kh6ob5nLWs0xA2d19g4u5OH
 +KeRZe3cbFf+jNAMwZ+Y6pMpgNV/IQksyMBtFfGwd0bgwV3kiaR6H0Rm6z+YbZyxXO
 GWQqcWFGkuMnRzTBkKbNu4oYW4CpIxxDKAdTJ6FvRG2MnaMAgOGq3GEE1tMQ2FtC7L
 uRyerTVtMIduphf5LFU2JlI1spM03vdChPhci09VPNpQn+9AJOMmDfYW/VWybs1HI6
 HHebWPMrGK6kw==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>,
 Kim Phillips <kim.phillips@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 2/9] target/i386: SEV: Ensure SEV features are only set
 through qemu cli or IGVM
Date: Wed, 20 May 2026 18:57:55 +0530
Message-ID: <6939de99f13d7170af68b74e711eb9f03f32f682.1779281646.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779281646.git.naveen@kernel.org>
References: <cover.1779281646.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for qemu being able to set SEV features through the cli,
add a check to ensure that SEV features are not also set if using IGVM
files.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 22c350fe14b7..641a295c42b7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1908,6 +1908,16 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
          * as SEV_STATE_UNINIT.
          */
         if (x86machine->igvm) {
+            /*
+             * Test only the user-set SEV features by masking out
+             * SVM_SEV_FEAT_SNP_ACTIVE which is set by default.
+             */
+            if (sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE) {
+                error_setg(errp,
+                           "%s: SEV features can't be specified when using IGVM files",
+                           __func__);
+                return -1;
+            }
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
                     ->process(x86machine->igvm, machine, true, errp) == -1) {
                 return -1;
-- 
2.54.0


