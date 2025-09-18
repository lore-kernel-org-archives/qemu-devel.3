Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08D3CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBuX-00071G-O4; Thu, 18 Sep 2025 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuK-0006wa-JA
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:40 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuI-0001L7-GH
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FE3941880;
 Thu, 18 Sep 2025 10:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A21C4CEEB;
 Thu, 18 Sep 2025 10:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758191419;
 bh=dP5IVGjmx5XftVX1vvgwnPL2aJr8KldT3GTZjykn2Yk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FxETtJFNX+jmX13mn+mvbN73JIqE8L+LWqtqxPRi+hcnfiNCAIgtQIQi03hpsMleg
 JekZvLZLPomHv0Wfk7jSHFbkFjZkUoiyMnDqRFf5kfH67tErPgpE1RUAfOWXU8yy+0
 rrspUlJbzZKUGMdzy5B9SZ+qNL9fVATB8H2/fmQZku/ZOuU5fVF++g+GzLvw4QK4l+
 94Tbgvqx1ULaLWhhONyFzKIWP/wrg9BFhZZqrxmltbYaQPExgo4TW96JuNqKbTlqqR
 A1oGzWW0QUyumi8qOTrz2IiN6niHLWC4j9vHnCsNNwjx0PC9u3ctd9t6pKFvJyxLy9
 uCl512O8rmmQg==
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
Subject: [PATCH 2/8] target/i386: SEV: Ensure SEV features are only set
 through qemu cli or IGVM
Date: Thu, 18 Sep 2025 15:57:00 +0530
Message-ID: <f9b23c74b04177f0dc088a246bdacf1cb158c35e.1758189463.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758189463.git.naveen@kernel.org>
References: <cover.1758189463.git.naveen@kernel.org>
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

In preparation for qemu being able to set SEV features through the cli,
add a check to ensure that SEV features are not also set if using IGVM
files.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 target/i386/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2fb1268ed788..c4011a6f2ef7 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1901,6 +1901,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
          * as SEV_STATE_UNINIT.
          */
         if (x86machine->igvm) {
+            if (sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE) {
+                error_setg(errp, "%s: SEV features can't be specified when using IGVM files",
+                           __func__);
+                return -1;
+            }
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
                     ->process(x86machine->igvm, machine->cgs, true, errp) ==
                 -1) {
-- 
2.51.0


