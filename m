Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A9C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRbt-0000Bd-KS; Mon, 28 Jul 2025 13:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugRbr-0008QX-5Q
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugRbp-0005ZM-Ey
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753723556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4gcMDGkU7vR5AmGFsCSLxqFiamRKfDfSNEO0CvHrKl4=;
 b=Q2DQLSKB4xc8v57dNZGZoOBqqEH/MM891E3nucd+yonptWIwX+FC9i9X7RrMM4c9LZHLsN
 qJDGdITkQFZ8OUceZK9opidNu4t4GH5kLZc3lA1e6lo+BBi0xUehhtc6K9HfOcXdjndGLI
 qB7veSXBJBvo65LILdVICEkqVSH1HRg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-q2b8ltdtPNORrP47y2B3-Q-1; Mon,
 28 Jul 2025 13:25:51 -0400
X-MC-Unique: q2b8ltdtPNORrP47y2B3-Q-1
X-Mimecast-MFC-AGG-ID: q2b8ltdtPNORrP47y2B3-Q_1753723551
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDF291800360; Mon, 28 Jul 2025 17:25:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5F1F1800287; Mon, 28 Jul 2025 17:25:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] system/physmem: Silence warning from ubsan
Date: Mon, 28 Jul 2025 19:25:45 +0200
Message-ID: <20250728172545.314178-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-ubsan there is a undefined behavior
warning when running the bios-tables-test for example:

 .../system/physmem.c:3243:13: runtime error: applying non-zero offset 262144 to null pointer
    #0 0x55ac1df5fbc4 in address_space_write_rom_internal .../system/physmem.c:3243:13

The problem is that buf is indeed NULL if the function is e.g. called
with type == FLUSH_CACHE. Add a check to fix the issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 system/physmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 130c148ffb5..00333ffa7f7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3240,8 +3240,10 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
             }
         }
         len -= l;
-        buf += l;
         addr += l;
+        if (buf) {
+            buf += l;
+        }
     }
     return MEMTX_OK;
 }
-- 
2.50.1


