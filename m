Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC543E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIUv-0003uS-Jn; Thu, 02 Jan 2025 05:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUt-0003u0-UX
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUs-0005rT-Cl
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735813929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPPa8vdt58GXiSGixVwbRhcXl4KjcGndA41w2wQfI/4=;
 b=e8wRHdiib5IMTDuV+KXpDubZ1JybNS2WddVEUvY77RF9VWaEByeWHvo3e2X35nYi/fkYFa
 GDvkrwLpMSxJ8BOBsWwlv7FQAorDm1a7BneOkZennM9f81vtbYYksAY2JPCPoM5VK+3IWO
 XkIV3O8xvozklu6oxzRw0lYAtyVCX5g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-XYsfp3L5NZKwLRSSF2aZjg-1; Thu,
 02 Jan 2025 05:32:06 -0500
X-MC-Unique: XYsfp3L5NZKwLRSSF2aZjg-1
X-Mimecast-MFC-AGG-ID: XYsfp3L5NZKwLRSSF2aZjg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 179831956087; Thu,  2 Jan 2025 10:32:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E2D11956052; Thu,  2 Jan 2025 10:32:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 07/10] tests/functional/test_ppc64_hv: Update repo management
Date: Thu,  2 Jan 2025 11:31:35 +0100
Message-ID: <20250102103138.354618-8-thuth@redhat.com>
In-Reply-To: <20250102103138.354618-1-thuth@redhat.com>
References: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

`setup-apkrepos` can be used to set repos rather than open-coding URLs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20241220024617.1968556-4-npiggin@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_hv.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 2182a68c91..e0dffb1f15 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -81,6 +81,10 @@ def do_start_alpine(self):
         exec_command_and_wait_for_pattern(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'), ps1)
         ps1='alpine:~#'
         exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
+        exec_command_and_wait_for_pattern(self, 'setup-apkrepos -c1', ps1)
+        exec_command_and_wait_for_pattern(self, 'apk update', ps1)
+        # Could upgrade here but it usually should not be necessary
+        # exec_command_and_wait_for_pattern(self, 'apk upgrade --available', ps1)
 
     def do_stop_alpine(self):
         exec_command(self, 'echo "TEST ME"')
@@ -91,9 +95,6 @@ def do_stop_alpine(self):
 
     def do_setup_kvm(self):
         ps1='alpine:~#'
-        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories', ps1)
-        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories', ps1)
-        exec_command_and_wait_for_pattern(self, 'apk update', ps1)
         exec_command_and_wait_for_pattern(self, 'apk add qemu-system-ppc64', ps1)
         exec_command_and_wait_for_pattern(self, 'modprobe kvm-hv', ps1)
 
-- 
2.47.1


