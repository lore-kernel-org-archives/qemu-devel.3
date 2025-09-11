Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AB0CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 11:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwfwB-0002LW-Mf; Thu, 11 Sep 2025 07:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uwfw5-0002Ja-P0
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:57:57 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uwfvn-0006IJ-FJ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:57:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A741760234;
 Thu, 11 Sep 2025 11:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC1BC4CEF0;
 Thu, 11 Sep 2025 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757591850;
 bh=CSzllqS1dlwgFiif2Sq7vyEsfYTDBSjBnppZcpm7Kts=;
 h=From:To:Cc:Subject:Date:From;
 b=Y/FNLQXDGtsiJlinu7l9KyUyYJkq1G+cJWlLoZ8iq90w7B1JE84+n8xezxpWxaxlQ
 Q0QpWWJMWzt/HLpiSoFht/M+vToiqDc638Cn9K3azU8WhKuxxJSpjXCXMdsqHyErak
 cr8Ifz+VZJCExKItC61542pKB8wOF8UZa8tu0AwcCXmd4oIaiWPo4hkQ5QAvvf9Ztt
 djrNXAwatSKfH2cibwVC7QGm7tolEadVSxHf6NOik5UMkMC3n9XY0oU9EDnzRzZlHo
 oSmWI/A2gd0sRMRhKtKmB8+upB5FqBXXN/MjOZFEYJFDMwBl7p4EZHKgDo3VuN1GeE
 53ndjSAdqTP7g==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: [RFC PATCH 0/7] target/i386: SEV: Add support for enabling VMSA SEV
 features
Date: Thu, 11 Sep 2025 17:24:19 +0530
Message-ID: <cover.1757589490.git.naveen@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Secure TSC and Secure AVIC have been posted. 


- Naveen



Naveen N Rao (AMD) (7):
  target/i386: SEV: Consolidate SEV feature validation to common init
    path
  target/i386: SEV: Validate that SEV-ES is enabled when VMSA features
    are used
  target/i386: SEV: Add support for enabling debug-swap SEV feature
  target/i386: SEV: Enable use of KVM_SEV_INIT2 for SEV-ES guests
  target/i386: SEV: Add support for enabling Secure TSC SEV feature
  target/i386: SEV: Add support for setting TSC frequency for Secure TSC
  target/i386: SEV: Add support for enabling Secure AVIC SEV feature

 target/i386/sev.h |   5 +-
 target/i386/sev.c | 139 +++++++++++++++++++++++++++++++++++++++++-----
 qapi/qom.json     |  18 +++++-
 3 files changed, 144 insertions(+), 18 deletions(-)


base-commit: 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8
-- 
2.50.1


