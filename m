Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3815CAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jCu-0001mh-Fv; Thu, 25 Sep 2025 06:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jCp-0001hX-Pk
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:28:08 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1v1jCk-0002bi-EG
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:28:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 90FC343F55;
 Thu, 25 Sep 2025 10:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8B9C4CEF0;
 Thu, 25 Sep 2025 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758796074;
 bh=9aHXXx+1F5HOMtyaoplqvf/ofDWhN91Htcmm6SX+cpM=;
 h=From:To:Cc:Subject:Date:From;
 b=lOwFSbMfuBFxtrZiLZCjDS/WFCgU/qZZQQBiUgVw5AIz8UZx3BvL9g6+Ot8XXmnmc
 0i6CpbdB+s5uvYjbJMQrsFwid6iumMGoiWfEXngFxFLRjYoXHDXIqy9IfgZDauPRER
 2ZBpAP6vjNNczCV+BBmusRvvMLxy5wlfYGtViy2xjJuVcQHrWE5miJ7CFeohKrBaB3
 3JPD3LkritE5WeDH3n+NmWxS3+OhZOGlnu9MlSX+pTcCrLY4+VgF2jdaGj4Q7iOIK0
 5fHJkmoITER3YWlcq6CxyqAhdpki36GJ3P/Qv1Hl7FKQ8mba6VEGf01woqCTBdRiUO
 ea36qa4iQxoxQ==
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
Subject: [PATCH v2 0/9] target/i386: SEV: Add support for enabling VMSA SEV
 features
Date: Thu, 25 Sep 2025 15:47:29 +0530
Message-ID: <cover.1758794556.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
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

This series adds support for enabling VMSA SEV features for SEV-ES and
SEV-SNP guests. Since that is already supported for IGVM files, some of
that code is moved to generic path and reused.

Debug-swap is already supported in KVM today, while patches for enabling
Secure TSC have been accepted for the upcoming kernel release.

Roy,
I haven't been able to test IGVM, so would be great if that is tested to 
confirm there are no unintended changes there.

Changes since v1 (*):
- Move patch enabling use of KVM_SEV_INIT2 for SEV-ES guests before 
  patch enabling use of debug-swap VMSA SEV feature (Tom)
- Only issue KVM_SET_TSC_KHZ if user has specified a tsc-frequency for 
  Secure TSC (Tom)
- Patch 9/9 is new and refactors check_sev_features in preparation for 
  future SEV feature support (Tom)
- Minor updates to commit log and comments (Tom)
- Collect review tags from Tom

(*) http://lkml.kernel.org/r/cover.1758189463.git.naveen@kernel.org


- Naveen

Naveen N Rao (AMD) (9):
  target/i386: SEV: Generalize handling of SVM_SEV_FEAT_SNP_ACTIVE
  target/i386: SEV: Ensure SEV features are only set through qemu cli or
    IGVM
  target/i386: SEV: Consolidate SEV feature validation to common init
    path
  target/i386: SEV: Validate that SEV-ES is enabled when VMSA features
    are used
  target/i386: SEV: Enable use of KVM_SEV_INIT2 for SEV-ES guests
  target/i386: SEV: Add support for enabling debug-swap SEV feature
  target/i386: SEV: Add support for enabling Secure TSC SEV feature
  target/i386: SEV: Add support for setting TSC frequency for Secure TSC
  target/i386: SEV: Refactor check_sev_features()

 target/i386/sev.h |   4 +-
 target/i386/sev.c | 170 +++++++++++++++++++++++++++++++++++++---------
 qapi/qom.json     |  16 ++++-
 3 files changed, 155 insertions(+), 35 deletions(-)


base-commit: 95b9e0d2ade5d633fd13ffba96a54e87c65baf39
-- 
2.51.0


