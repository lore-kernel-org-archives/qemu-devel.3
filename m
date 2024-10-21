Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22187D0E6F7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhF-00028M-FA; Mon, 21 Oct 2024 07:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qgy-000266-MF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qgt-0001Uu-1T
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2AW0JMFGDoiKZeDB3X89zNWa0sAywienipoUJUTxBUY=;
 b=UqlBBY0GK3Z5RaLDnZxVQ4+tQApI4ENJX5IDF7ND+88zbhKx2B4TDdyRAX4/eQLv40ijNI
 rC6dnsXoY9XxMkrLtn46IGOMuhRkPwDjyaMyIo4CdYqy14W9zLXeFxTieK7bkjXxnkqNrD
 vgj5Lvq53tNg6BgJBEBcVGhIK3jsKiY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-S6ySwIVVMbGipxhQLkAgpw-1; Mon,
 21 Oct 2024 07:35:08 -0400
X-MC-Unique: S6ySwIVVMbGipxhQLkAgpw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6553419560B2; Mon, 21 Oct 2024 11:35:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11C7319560AA; Mon, 21 Oct 2024 11:35:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Brad Smith <brad@comstyle.com>
Subject: [PULL 01/21] tests/vm: update openbsd image to 7.6
Date: Mon, 21 Oct 2024 13:34:38 +0200
Message-ID: <20241021113500.122500-2-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
References: <20241021113500.122500-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

From: Brad Smith <brad@comstyle.com>

Remove tomli as Python has been updated to 3.11.

[thuth: The "Time appears wrong" line is now necessary since the server
 seems to provide a wrong timestamp. We likely have to remove that again
 later once the server is running with the correct time again]

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <ZwtmfVlWgFRF9G8W@humpty.home.comstyle.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/openbsd | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 49cab08782..dfd11c93f0 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.5/amd64/install75.iso"
-    csum = "034435c6e27405d5a7fafb058162943c194eb793dafdc412c08d49bb56b3892a"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
+    csum = "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
     size = "20G"
     pkgs = [
         # tools
@@ -32,7 +32,6 @@ class OpenBSDVM(basevm.BaseVM):
         "pkgconf",
         "bzip2", "xz",
         "ninja",
-        "py3-tomli",
 
         # gnu tools
         "bash",
@@ -160,6 +159,7 @@ class OpenBSDVM(basevm.BaseVM):
 
         self.print_step("Installation started now, this will take a while")
         self.console_wait_send("Location of sets",        "done\n")
+        self.console_wait_send("Time appears wrong.  Set to", "\n")
 
         self.console_wait("successfully completed")
         self.print_step("Installation finished, rebooting")
-- 
2.47.0


