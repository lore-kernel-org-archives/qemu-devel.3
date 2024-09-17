Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C64C3600A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVZc-0006Np-Aa; Tue, 17 Sep 2024 06:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZQ-0005SZ-Ku
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZO-0007OT-Ls
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnivrXaLt5F2vc6x4kYiMWJdRDW48PC323ljZj38Ehg=;
 b=ObsmD0TeJI/3y5j7xVtSCBr6gEF6zv1X3+z4R1J00OH6ux7j/mTtl3n0FBVFTYkvjAJqnl
 Zn57uallh1K5AnVukWNKnxNW817PozdKbZ+lXor2cjog103vDCwnZyckrHxGwmlhSjhDmi
 Z9O6yhn3opVgradU7oQJup0deJxnJMc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-cDfNWp-0PJW4Z47D50P1xQ-1; Tue,
 17 Sep 2024 06:36:23 -0400
X-MC-Unique: cDfNWp-0PJW4Z47D50P1xQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAF091955D4F; Tue, 17 Sep 2024 10:36:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED0571955F54; Tue, 17 Sep 2024 10:36:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/17] system: Enable the device aliases for or1k, too
Date: Tue, 17 Sep 2024 12:35:37 +0200
Message-ID: <20240917103540.149144-15-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that we've got a "virt" machine for or1k that supports PCI
too (commit 40fef82c4e "hw/openrisc: Add PCI bus support to virt")
we can also enable the virtio device aliases like we do on other
similar platforms. This will e.g. help to run the iotests with
qemu-system-or1k later.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240705090808.1305765-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240705124528.97471-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 system/qdev-monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index acdc8b73a3..44994ea0e1 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -61,6 +61,7 @@ typedef struct QDevAlias
                               QEMU_ARCH_I386 | \
                               QEMU_ARCH_LOONGARCH | \
                               QEMU_ARCH_MIPS | \
+                              QEMU_ARCH_OPENRISC | \
                               QEMU_ARCH_PPC | \
                               QEMU_ARCH_RISCV | \
                               QEMU_ARCH_SH4 | \
-- 
2.46.0


