Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1E6C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1Xm-0006V6-JY; Mon, 19 Feb 2024 06:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1Xj-0006US-L8
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:10:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1Xi-0005H5-54
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708341037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wwhcq9d24Y8fXRPCPmM5LJVrD3A40ujKe6m1ZsX7wGk=;
 b=UZh0X4xz0M3IHLGSmKXxPvC1ImDNjUI6BorVXgln/jHUfwlHSHq7MQxMEj3aSkV/VVsBHL
 TXctw11F65sYucv533TNVYO54AdCduOESFd0hHAmaqcc7tUqDaYIjqXWXoX7ZIpFgy6PVm
 5o7obE3ZOcwmyd9vs8TOhVueUzMiOb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-p_KVqQn0Oba8h5kEL24WQg-1; Mon, 19 Feb 2024 06:10:32 -0500
X-MC-Unique: p_KVqQn0Oba8h5kEL24WQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B93B1025620;
 Mon, 19 Feb 2024 11:10:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 438EF492BE7;
 Mon, 19 Feb 2024 11:10:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-trivial@nongnu.org
Subject: [PATCH] tests/qtest: Fix boot-serial-test when using
 --without-default-devices
Date: Mon, 19 Feb 2024 12:10:30 +0100
Message-ID: <20240219111030.384158-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
always be there for PCIe-based machines like the sam460ex.

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


