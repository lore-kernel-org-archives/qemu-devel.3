Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5370CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPh3i-0005YW-DK; Wed, 20 May 2026 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh3h-0005YO-2x
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:01 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wPh3f-0004Su-HX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:00 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62FAA6012B;
 Wed, 20 May 2026 13:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1371F000E9;
 Wed, 20 May 2026 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779284037;
 bh=0H0PhzIavV7JEOYrfL4kjZuPihNXWTZem2Tr+O2TU/M=;
 h=From:To:Cc:Subject:Date;
 b=QMP9bEMIApttk6CHXaFacwYkhPR0ku01w8ffIWfO500VsEXZo+OBZImEQOEi5G/eu
 bKfOGJ4NBejM2AJMdVfvmhLk+w7qWm0UV7A59085HYBlES1Tdrq1lEZzmgCmeo8YgW
 kzxlOsINxkeXETWpFtUkNqzof2TS3gp0zYAGKiw3AJprjFfp1ICESwIs3N9UWEIJlt
 ViBEFIgOGYV+Kr6hRGgUy7zlMLnje9TZP/fiZd7vgsp/4rRqxHZHlgLac+T3sOFTk1
 7EHc0txK61HZF/u4wjaDh2hgvyydgpvi7cqvFcPMCVQhhEm5NjY/EBSqdI78nv/YdZ
 XUBiF808K2lfA==
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
Subject: [PATCH v4 0/9] target/i386: SEV: Add support for enabling VMSA SEV
 features
Date: Wed, 20 May 2026 18:57:53 +0530
Message-ID: <cover.1779281646.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=naveen@kernel.org;
 helo=tor.source.kernel.org
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

This series adds support for enabling VMSA SEV features for SEV-SNP 
guests through the Qemu command line. This is already supported for IGVM 
files, so some of that code has been generalized and reused.

The primary change w.r.t v3 (apart from rebasing and targeting v11.1) is 
a change to patch 6/9 to restrict debug-swap to SEV-SNP guests due to a 
compatibility issue with SEV-ES guests and pflash, discussed here:
http://lore.kernel.org/r/fcqjl5a7m27f2mfpblnhgmozbipdjmvpdyk3m5hhzwcenp4cpg@m2ooa7ykrcvs

I plan to post a workaround for that separately. For that reason, I have 
retained patch 5/9 so that enabling debug-swap for SEV-ES guests will be 
a simpler subsequent change.

The only other concern has been around patch 8/9 adding a new 
tsc-frequency property on sev-snp-guest object (and not re-using the one 
on the cpu object). If that's required/possible, I would appreciate some 
help since I've been unable to get that working.

Tom,
I have dropped your reviewed-by tag on patch 6/9 due to this change.  
Kindly take a look once.

v3: http://lore.kernel.org/r/cover.1761648149.git.naveen@kernel.org


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
 target/i386/sev.c | 177 +++++++++++++++++++++++++++++++++++++---------
 qapi/qom.json     |  17 ++++-
 3 files changed, 163 insertions(+), 35 deletions(-)


base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
-- 
2.54.0


