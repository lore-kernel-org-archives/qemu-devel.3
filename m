Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDB0C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIw3-0006y1-CQ; Tue, 06 Feb 2024 05:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIw2-0006wz-8J
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvz-0003FX-Gj
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfQYURFrI4iuL99hnnFo/uP7RDaDGmB5jkJpCrKd84s=;
 b=XKcbErifvPUIF09tr1ZS5mQL1IoY/Nx6OvQ11+btri9uNhX09I4+Zj9VlmF+h4ZGz9L9Ds
 W5eX9Nmevzj2+vlI3+OWnIvvTeYMqy8RwqQq+q7i2LG4GR7DWFSTKddbgVp406tqee9Nte
 cJLWzL8LvWJ8FCSjthxKywTUesanQBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-bWdsy1ukN5-qQeaP1WHqVg-1; Tue, 06 Feb 2024 05:44:07 -0500
X-MC-Unique: bWdsy1ukN5-qQeaP1WHqVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71B9B862DC1;
 Tue,  6 Feb 2024 10:44:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43077492BF0;
 Tue,  6 Feb 2024 10:44:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 10/12] tests/vm/freebsd: Reload the sshd configuration
Date: Tue,  6 Feb 2024 11:43:45 +0100
Message-ID: <20240206104347.238825-11-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
References: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

After console_sshd_config(), the SSH server needs to be nudged to pick
up the new configs. The scripts for the other BSD flavors already do
this with a reboot, but a simple reload is sufficient.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240206002344.12372-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/freebsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b581bd17fb..1247f40a38 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -108,6 +108,7 @@ class FreeBSDVM(basevm.BaseVM):
         prompt = "root@freebsd:~ #"
         self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
+        self.console_wait_send(prompt, "service sshd reload\n")
 
         # setup virtio-blk #1 (tarfile)
         self.console_wait(prompt)
-- 
2.43.0


