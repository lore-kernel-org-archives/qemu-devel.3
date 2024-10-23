Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BEDCF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bG1-0007hm-CR; Wed, 23 Oct 2024 09:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFm-0007Sd-NS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFj-0002HL-RU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZAgKjHoIK0f2Ml/A35Lz7dZewwqe78HY+smjQkjoSs=;
 b=OtT5i4c2jsrZUrEHg2aMG/lDnSgXJQdVWYOnPRtCWQ7t1/1IyqQjr3QhxMpHhYfWT29Fh2
 UT2KE3Qo7laSj5FA+GqkXz9jaZdXOeX3MJjvSBkLgp4eemWPont3MYcyZB2Q7J2PiKPkdM
 LLQlhOkksfAnyAs8MOZ+JvTm5YQT0VA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-emH_6pQqMwKiovvF7WHPMQ-1; Wed,
 23 Oct 2024 09:18:17 -0400
X-MC-Unique: emH_6pQqMwKiovvF7WHPMQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFF281955BC2; Wed, 23 Oct 2024 13:18:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D13C19560AE; Wed, 23 Oct 2024 13:18:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jens Remus <jremus@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL 21/23] pc-bios/s390-ccw: Don't generate TEXTRELs
Date: Wed, 23 Oct 2024 15:17:08 +0200
Message-ID: <20241023131710.906748-22-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jens Remus <jremus@linux.ibm.com>

Commit 7cd50cbe4ca3 ("pc-bios/s390-ccw: Don't use __bss_start with the
"larl" instruction") introduced the address constant bss_start_literal
for __bss_start in the .text section, which introduced a relocation in
code (i.e. TEXTREL). The dedicated constant is required, as __bss_start
may not necessarily be aligned on a 2-byte boundary (see subject commit
for details).

Move the constant to the .data section to get rid of the relocation in
the .text section. Add the linker option -z text to prevent TEXTRELs to
get introduced in the future.

Note that the R_390_RELATIVE relocations are taken care of by function
glue() in include/hw/elf_ops.h.inc introduced by commit 5dce07e1cb67
("elf-loader: Provide the possibility to relocate s390 ELF files").

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Message-ID: <20241001153618.17791-3-mhartmay@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile | 2 +-
 pc-bios/s390-ccw/start.S  | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index db9e8f0892..38254e22df 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -46,7 +46,7 @@ EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
 EXTRA_CFLAGS += -msoft-float
 EXTRA_CFLAGS += -std=gnu99
 EXTRA_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
-LDFLAGS += -Wl,-pie -nostdlib -z noexecstack
+LDFLAGS += -Wl,-pie -nostdlib -z noexecstack -z text
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 576fc12c06..b70213e412 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -113,8 +113,6 @@ io_new_code:
     br      %r14
 
     .balign 8
-bss_start_literal:
-    .quad   __bss_start
 disabled_wait_psw:
     .quad   0x0002000180000000,0x0000000000000000
 enabled_wait_psw:
@@ -124,6 +122,11 @@ external_new_mask:
 io_new_mask:
     .quad   0x0000000180000000
 
+.data
+    .balign 8
+bss_start_literal:
+    .quad   __bss_start
+
 .bss
     .balign 8
 stack:
-- 
2.47.0


