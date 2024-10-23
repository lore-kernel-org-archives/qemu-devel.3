Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44F0CF538B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFy-0007Xo-7X; Wed, 23 Oct 2024 09:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFi-0007Qh-Uc
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFg-0002Gs-Is
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlisWTeQGQ6ZToRii2cnDBBtfS/haEMK8f6BSEWEyKo=;
 b=Z5TA26SDVnFyXNRIsgSEbtfXjlP/kImd/mX6ZVcMG6yVKVUkjg5genStUsbmzxtcQ1OqiR
 reY8N7YJPas8b4AETS8FzXl6ZXk0AtFyeXnNZWXZnZj93n4j28OX3+eBIMxs4nHJQ1p6Z0
 FgE+x/fOF+jkY7GEPVUS4EzunLl+azQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-ahgd2XjvPhencQbgWssxnw-1; Wed,
 23 Oct 2024 09:18:12 -0400
X-MC-Unique: ahgd2XjvPhencQbgWssxnw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0341193EB3C; Wed, 23 Oct 2024 13:18:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C8B519560AE; Wed, 23 Oct 2024 13:18:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jens Remus <jremus@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL 20/23] pc-bios/s390-ccw: Clarify alignment is in bytes
Date: Wed, 23 Oct 2024 15:17:07 +0200
Message-ID: <20241023131710.906748-21-thuth@redhat.com>
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

The assembler directive .align [1] has architecture-dependent behavior,
which may be ambiguous for the reader. Some architectures perform the
alignment in bytes, others in power of two. s390 does in bytes.

Use the directive .balign [2] instead, to clarify that the alignment
request is in bytes. No functional change.

[1] https://sourceware.org/binutils/docs/as/Align.html
[2] https://sourceware.org/binutils/docs/as/Balign.html

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Message-ID: <20241001153618.17791-2-mhartmay@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/start.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 061b06591c..576fc12c06 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -112,7 +112,7 @@ io_new_code:
     lctlg   %c6,%c6,0(%r15)
     br      %r14
 
-    .align  8
+    .balign 8
 bss_start_literal:
     .quad   __bss_start
 disabled_wait_psw:
@@ -125,7 +125,7 @@ io_new_mask:
     .quad   0x0000000180000000
 
 .bss
-    .align  8
+    .balign 8
 stack:
     .space  STACK_SIZE
     .size   stack,STACK_SIZE
-- 
2.47.0


