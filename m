Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BCBD262B2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSxI-0004Oc-1n; Wed, 21 Jan 2026 02:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viSx4-0004Nk-DI
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:48:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viSx2-0003Na-Qc
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768981707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XKTl4qYDaE6tsTB9IB8upa2zqoP53BZQ8uogKZtPxYs=;
 b=eh1OSNZg/u+A4LZSgdmL2rD6pRMW3oGQmMR9jRX4q9osor0m6CMF2pwbt5rpJVHP5G1Xou
 tmmMExbS2gQu2jgCPWSgR7hr5G94gCrCGtLQepX+N+1Is23mRiVDrbQoasoYA4jcxXHp2Z
 WlmXyoEkME4kbglnQKA9QxX50gOOpEQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-pY_6Jby-PwqHIKXekBJgUA-1; Wed,
 21 Jan 2026 02:48:23 -0500
X-MC-Unique: pY_6Jby-PwqHIKXekBJgUA-1
X-Mimecast-MFC-AGG-ID: pY_6Jby-PwqHIKXekBJgUA_1768981703
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8A0118003FC; Wed, 21 Jan 2026 07:48:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C1A830002D5; Wed, 21 Jan 2026 07:48:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
	Ryo ONODERA <ryoon@netbsd.org>
Subject: [PATCH] pc-bios/optionrom: Use 32-bit linker emulation for the
 optionroms
Date: Wed, 21 Jan 2026 08:48:19 +0100
Message-ID: <20260121074819.29396-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Without this linker flag, the linking fails on NetBSD v10.1 with:

 ld: i386 architecture of input file `multiboot.o' is incompatible with i386:x86-64 output
 ld: i386 architecture of input file `multiboot_dma.o' is incompatible with i386:x86-64 output

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/optionrom/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index 30d07026c79..e6674a76e73 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -36,7 +36,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds,-m,elf_i386
 
 pvh.img: pvh.o pvh_main.o
 
-- 
2.52.0


