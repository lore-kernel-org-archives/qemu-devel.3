Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88221CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBuZ-00073O-EY; Thu, 18 Sep 2025 06:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuI-0006wO-TU
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:40 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uzBuE-0001Kw-Do
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:30:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 03D8844668;
 Thu, 18 Sep 2025 10:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B65C4CEEB;
 Thu, 18 Sep 2025 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758191415;
 bh=/t/seh31KV2q7u6Vwfa5Gxj43/rdwqpf1rIihSlnvCQ=;
 h=From:To:Cc:Subject:Date:From;
 b=ht73uFWHumP9sqZf0Q6V5C3CalsbAfdhf5abUfVeZG3a3V8fqTd/WashvS2gg0W7P
 19m9SI8rqK/iAkzVy4igdtwCxUgv8s1NogzXzwuBy+Y8lDRUyj79iGdUOAR+nk4ubH
 sEsutPxzp7i7FahkkYpt3NKvyBWxT9/hIuqPKQtqSk2vJPBhKe3U+xsOW3r6dc8IQp
 9dQYawVxDykXH7pW0FgYUsYaQ8MQ5Y3XAyPpEn1SrZ0oQ0aQsecepMmQAcFEdXg4D6
 Bz6AasXbVuJRoxEP+2ISNeNqjMYEeb32vBh3zh70Bqo3sa0+p5vyzi0R8d0YrcpS0f
 OmCqP/EDQygdQ==
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
Subject: [PATCH 0/8] target/i386: SEV: Add support for enabling VMSA SEV
 features
Date: Thu, 18 Sep 2025 15:56:58 +0530
Message-ID: <cover.1758189463.git.naveen@kernel.org>
X-Mailer: git-send-email 2.51.0
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

This series adds support for enabling VMSA SEV features for SEV-ES and
SEV-SNP guests. Since that is already supported for IGVM files, some of
that code is moved to generic path and reused.

Debug-swap is already supported in KVM today, while patches for enabling
Secure TSC have been accepted for the upcoming kernel release.

Changes since RFC (http://lkml.kernel.org/r/cover.1757589490.git.naveen@kernel.org):
- Split the first patch up into the initial three patches (Tom)
- Fix up indents in qom.json (Markus)
- Drop Secure-AVIC flag enablement pending KVM enablement (Tom)
- Collect Tom's reviewed-by tag for patch 4


- Naveen

Naveen N Rao (AMD) (8):
  target/i386: SEV: Generalize handling of SVM_SEV_FEAT_SNP_ACTIVE
  target/i386: SEV: Ensure SEV features are only set through qemu cli or
    IGVM
  target/i386: SEV: Consolidate SEV feature validation to common init
    path
  target/i386: SEV: Validate that SEV-ES is enabled when VMSA features
    are used
  target/i386: SEV: Add support for enabling debug-swap SEV feature
  target/i386: SEV: Enable use of KVM_SEV_INIT2 for SEV-ES guests
  target/i386: SEV: Add support for enabling Secure TSC SEV feature
  target/i386: SEV: Add support for setting TSC frequency for Secure TSC

 target/i386/sev.h |   4 +-
 target/i386/sev.c | 126 ++++++++++++++++++++++++++++++++++++++++------
 qapi/qom.json     |  16 +++++-
 3 files changed, 128 insertions(+), 18 deletions(-)


base-commit: 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8
-- 
2.51.0


