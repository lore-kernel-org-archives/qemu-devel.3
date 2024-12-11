Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C979E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 22:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLV96-00059r-8S; Wed, 11 Dec 2024 17:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=068cdc04d=graf@amazon.de>)
 id 1tLV93-00056G-Hn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:25:25 -0500
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=068cdc04d=graf@amazon.de>)
 id 1tLV91-0004bg-I1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1733955923; x=1765491923;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=C9KKVNukJqWzsIdy6TecGNv46rw98HXzQ3UA8qrjbEE=;
 b=Wra07dP2aUpXlT8TGk8tRm8g8KiMiNrTioDLX9opRMHMaYIRMnQ7ffYi
 WJ2LrXstUkUbgsAufxXGT/QKqmc0vulNJ0oDwmigxjwTBY0AfWeI8v8UR
 qtqpwNU/j8hgS7Btin3GgUXfyKzlHAqgb/yLu0Yxffaoa9V+FU9wkAPH6 M=;
X-IronPort-AV: E=Sophos;i="6.12,226,1728950400"; d="scan'208";a="152312430"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:25:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:57349]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.242:2525]
 with esmtp (Farcaster)
 id e26df60b-9b39-43b8-9d9d-f9bda3174764; Wed, 11 Dec 2024 22:25:17 +0000 (UTC)
X-Farcaster-Flow-ID: e26df60b-9b39-43b8-9d9d-f9bda3174764
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 11 Dec 2024 22:25:15 +0000
Received: from ip-10-253-83-51.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 11 Dec 2024 22:25:14 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: Dorjoy Chowdhury <dorjoychy111@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [PATCH 1/1] docs/nitro-enclave: Clarify Enclave and Firecracker
 relationship
Date: Wed, 11 Dec 2024 22:25:12 +0000
Message-ID: <20241211222512.95660-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=99.78.197.219;
 envelope-from=prvs=068cdc04d=graf@amazon.de; helo=smtp-fw-80008.amazon.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The documentation says that Nitro Enclaves are based on Firecracker. AWS
has never made that statement.

This patch nudges the wording to instead say it "looks like a
Firecracker microvm".

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 docs/system/i386/nitro-enclave.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
index 73e3edefe5..6e8441b3f8 100644
--- a/docs/system/i386/nitro-enclave.rst
+++ b/docs/system/i386/nitro-enclave.rst
@@ -13,7 +13,7 @@ the enclave VM gets a dynamic CID. Enclaves use an EIF (`Enclave Image Format`_)
 file which contains the necessary kernel, cmdline and ramdisk(s) to boot.
 
 In QEMU, ``nitro-enclave`` is a machine type based on ``microvm`` similar to how
-AWS nitro enclaves are based on `Firecracker`_ microvm. This is useful for
+AWS nitro enclaves look like a `Firecracker`_ microvm. This is useful for
 local testing of EIF files using QEMU instead of running real AWS Nitro Enclaves
 which can be difficult for debugging due to its roots in security. The vsock
 device emulation is done using vhost-user-vsock which means another process that
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


