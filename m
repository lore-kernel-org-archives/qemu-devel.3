Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B1C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbG4-0007GN-WB; Fri, 23 Feb 2024 14:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawB-0005m5-2g
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdaw0-0005Am-Ma
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hM/lKf8JPHxpGSr0QY2uGdTqxRYMo4aIX91DJySYzoc=;
 b=KTq/v7UNNf8yyl7qcofA+ie23PKPahJKOg9octW7JnS0XZ30yXHRqDG9hMURPpxpMR6Zmj
 QmTI4/w0qBJnOhvr55cbUKJnsXtfSCITuhIRzYLFmpWZq3vvrwBH0YykBk3NplAbMW1qUt
 bmGLMqOQTUY+VxggoZ+KlRLpnLS3uqg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-6vZfZHPFOey56eDjnTNEwQ-1; Fri,
 23 Feb 2024 14:10:08 -0500
X-MC-Unique: 6vZfZHPFOey56eDjnTNEwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2825938562C9;
 Fri, 23 Feb 2024 19:10:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2877110800;
 Fri, 23 Feb 2024 19:10:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 02/11] tests/cdrom-test: Add cdrom test for LoongArch virt
 machine
Date: Fri, 23 Feb 2024 20:09:54 +0100
Message-ID: <20240223191003.6268-3-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

The cdrom test skips to execute on LoongArch system with command
"make check", this patch enables cdrom test for LoongArch virt
machine platform.

With this patch, cdrom test passes to run on LoongArch virt
machine type.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20240217100230.134042-1-maobibo@loongson.cn>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/cdrom-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 0945383789..5d89e62515 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -271,6 +271,11 @@ int main(int argc, char **argv)
             const char *virtmachine[] = { "virt", NULL };
             add_cdrom_param_tests(virtmachine);
         }
+    } else if (g_str_equal(arch, "loongarch64")) {
+        if (qtest_has_device("virtio-blk-pci")) {
+            const char *virtmachine[] = { "virt", NULL };
+            add_cdrom_param_tests(virtmachine);
+        }
     } else {
         const char *nonemachine[] = { "none", NULL };
         add_cdrom_param_tests(nonemachine);
-- 
2.43.2


