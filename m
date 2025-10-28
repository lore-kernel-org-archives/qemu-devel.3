Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E7ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhCs-0007Ht-TQ; Tue, 28 Oct 2025 06:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhCo-0007H7-EE
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:34 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vDhCl-0005XE-1y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:45:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 01EA040195;
 Tue, 28 Oct 2025 10:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B889AC4CEE7;
 Tue, 28 Oct 2025 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761648327;
 bh=RSWeHer5ogiaCBX7doP42pYj41uDEP8FTTxi62xTfuM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DkcVPH12APd1M/K7syTb2yNbeTJTw25gc35SlBskQgAAUe5OL31jg8euPhf6yBMpi
 19MRW5Cf9tSIx8aHI4pV8v9+SXOTiXfxYE8NSEAEW6OY6oRSoihY2vSSvnSUTxzDmK
 naLcO8cGjNXKzRmplwr0eA8sVGognWNBeZ5PYMYy7UgN9nWZixytzNY3V+JTeCd4w5
 uunresLv3at5y/d1JsYiL309A2GIWHHYoU5o7RCITL5lnXp23uAU9iDVXH/4ce4YWs
 vxS51HL3yEVkSdkWojI1HXeXekfyJLGxqSKAL0ToS/agjWMQtTqGQIzTqF9f40W8nO
 zh4uossSOAf0w==
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
Subject: [PATCH v3 5/9] target/i386: SEV: Enable use of KVM_SEV_INIT2 for
 SEV-ES guests
Date: Tue, 28 Oct 2025 16:13:30 +0530
Message-ID: <99f1b890070a36862766bbd496ad18dd5b24aa18.1761648149.git.naveen@kernel.org>
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
index 35df7be4f67c..0508b8998997 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1699,8 +1699,7 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
  */
 static bool sev_init2_required(SevGuestState *sev_guest)
 {
-    /* Currently no KVM_SEV_INIT2-specific options are exposed via QEMU */
-    return false;
+    return !!SEV_COMMON(sev_guest)->sev_features;
 }
 
 static int sev_kvm_type(X86ConfidentialGuest *cg)
-- 
2.51.0


