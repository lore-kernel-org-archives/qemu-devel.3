Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCA4D65C6F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 10:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXNR-0006yi-Qt; Thu, 14 Nov 2024 05:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBXNQ-0006wk-Ss
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:47:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBXNP-00039H-CF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731581221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QRyjjvGWmTxYlaLZ0/OczvAJKqqWf3ryi3aOg9DaiFM=;
 b=dgtTOK4TsB7qt5/B+xuXcx7Yen4HLzq+jjpo3+2GtF/b7nl4w2ZoFScrDjAD2TMYt4ktuN
 hlRwY+8Wlir5l+lfps7b9o9dCPpfigY7E7thgvyYzeX3j4UAgybBp+klwPxXO+uttlod6L
 EXKeKEfe1NGe92rpeXqPO6oQ0zaOei0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-X8dSH3s1NU2NoawMvKxbqw-1; Thu,
 14 Nov 2024 05:46:59 -0500
X-MC-Unique: X8dSH3s1NU2NoawMvKxbqw-1
X-Mimecast-MFC-AGG-ID: X8dSH3s1NU2NoawMvKxbqw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1DA719560B5; Thu, 14 Nov 2024 10:46:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.59])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60CEC1956054; Thu, 14 Nov 2024 10:46:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/misc/mos6522: Fix bad class definition of the MOS6522
 device
Date: Thu, 14 Nov 2024 11:46:53 +0100
Message-ID: <20241114104653.963812-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When compiling QEMU with --enable-cfi, the "q800" m68k machine
currently crashes very early, when the q800_machine_init() function
tries to wire the interrupts of the "via1" device.
This happens because TYPE_MOS6522_Q800_VIA1 is supposed to be a
proper SysBus device, but its parent (TYPE_MOS6522) has a mistake
in its class definition where it is only derived from DeviceClass,
and not from SysBusDeviceClass, so we end up in funny memory access
issues here. Using the right class hierarchy for the MOS6522 device
fixes the problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2675
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/misc/mos6522.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index fba45668ab..920871a598 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -154,7 +154,7 @@ struct MOS6522State {
 OBJECT_DECLARE_TYPE(MOS6522State, MOS6522DeviceClass, MOS6522)
 
 struct MOS6522DeviceClass {
-    DeviceClass parent_class;
+    SysBusDeviceClass parent_class;
 
     ResettablePhases parent_phases;
     void (*portB_write)(MOS6522State *dev);
-- 
2.47.0


