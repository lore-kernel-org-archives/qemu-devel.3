Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156F1C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbG5-0007GL-9K; Fri, 23 Feb 2024 14:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawK-0005oD-94
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdaw2-0005BN-Ob
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IezDwMYo04OSAJvi1EoNt37k9i5h7cpqiwzb+gmay2k=;
 b=C2+JXB1AAeDK/zK1VHa0XjWV+Abd4GQmCo2DlxizL3vrIMOCxT8tPTTK45vf66hIcxK+9n
 UJGROcsmIgZXH7caSg76qHpmt+NKdurVkR4sHai5pLGVj8BZr1hYg8KY9w4mX8u2dAzwan
 jLBtNOeizfrc5JcE+fJnm3C277Pglo0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-pirtAEIUN0-Ir5b2GzzLtQ-1; Fri,
 23 Feb 2024 14:10:09 -0500
X-MC-Unique: pirtAEIUN0-Ir5b2GzzLtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44E9B38562CE;
 Fri, 23 Feb 2024 19:10:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D57210800;
 Fri, 23 Feb 2024 19:10:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/11] tests/qtest: Fix boot-serial-test when using
 --without-default-devices
Date: Fri, 23 Feb 2024 20:09:55 +0100
Message-ID: <20240223191003.6268-4-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If "configure" has been run with "--without-default-devices", there is
no e1000 device in the binaries, so the boot-serial-test currently fails
in that case since it tries to use the e1000 with the sam460ex machine.

Since we're testing the serial output here, and not the NIC, let's
simply switch to the "pci-bridge" device here instead, which should
always be there for PCI-based machines like the sam460ex.

Message-ID: <20240219111030.384158-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/boot-serial-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 6dd06aeaf4..e3b7d65fe5 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -156,7 +156,7 @@ static const testdef_t tests[] = {
       "Open Firmware" },
     { "ppc64", "powernv8", "", "OPAL" },
     { "ppc64", "powernv9", "", "OPAL" },
-    { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
+    { "ppc64", "sam460ex", "-device pci-bridge,chassis_nr=2", "1b36  0001" },
     { "i386", "isapc", "-cpu qemu32 -M graphics=off", "SeaBIOS" },
     { "i386", "pc", "-M graphics=off", "SeaBIOS" },
     { "i386", "q35", "-M graphics=off", "SeaBIOS" },
-- 
2.43.2


