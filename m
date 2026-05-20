Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC86CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPh4S-0005hS-O0; Wed, 20 May 2026 09:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh44-0005bh-En
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:26 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh42-0004YL-6g
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:23 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FD6260121;
 Wed, 20 May 2026 13:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460571F000E9;
 Wed, 20 May 2026 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779284061;
 bh=rdJp/J3F9UFFZHU/Ts99uTkuRk+JOQWm2QJtbNtSatc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KR7GJyaTrnu51b7/fPXkXTheJd419p8gctqT7L7hS6xjvzLQzi2Uz4HOALVX+7ATP
 pXbSqYLXUg32RDm0BlDfNa+V1D4XwYfBkOp4pjA6Rt7gY1GoRHudSbjA8NixbHQ9fk
 33msTcFV9QysOwO531pTSBq7N9GL3uXrD3DoSB6B3jieAuIq8V1R+WsOtwx9OEXd8l
 ygS8L+OiICFD60vWkS64F7KDk3uoSASTxGE3WqEpYbRg0utBT2eecw5h4Q46uUl+uY
 C9353JVKYEY+JHFWkxqT5tY1wAVAEuswVZ/EC6NV1ur0FVRRlBGgO8b/HXAEvd7Rxx
 Lw5vRHqx+ApdQ==
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
Subject: [PATCH v4 5/9] target/i386: SEV: Enable use of KVM_SEV_INIT2 for
 SEV-ES guests
Date: Wed, 20 May 2026 18:57:58 +0530
Message-ID: <f2a7778ab26b11a8de90e170ff984ccd29dc05a0.1779281646.git.naveen@kernel.org>
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

In preparation for allowing SEV-ES guests to enable VMSA SEV features,
update sev_init2_required() to return true if any SEV features are
requested. This enables qemu to use KVM_SEV_INIT2 for SEV-ES guests when
necessary.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 196a70b35c51..4553fe4d6e4a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1701,8 +1701,7 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
  */
 static bool sev_init2_required(SevGuestState *sev_guest)
 {
-    /* Currently no KVM_SEV_INIT2-specific options are exposed via QEMU */
-    return false;
+    return !!SEV_COMMON(sev_guest)->sev_features;
 }
 
 static int sev_kvm_type(X86ConfidentialGuest *cg)
-- 
2.54.0


