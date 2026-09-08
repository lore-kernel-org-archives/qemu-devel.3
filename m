Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062F9C79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rJ7-0007Bd-9K; Tue, 08 Sep 2026 04:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJ4-0007BL-JC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJ2-0007Eu-Ss
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788856552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40LyvCDlaHAQHcMLKYj1Q0OPDSPjXdpYRkudFHr+oJg=;
 b=GOJ6bun9R2czalSi+rOyD2I2YOolgwKJdiVZzocc3GWo613BXYLa8hU/5mZSGQ/HnO3pb/
 qBZPjIroXVC7e3ZZJRzKxSJqDR3OKi7YI8qN7Yd//vKQzxDe7Mknqjxap4kZ10qt0iQRRt
 drjNal7rz6hwOgcc6jXpUXjqEp/pNvQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-PkgkHzyaNqO9SDSyxA4_Jw-1; Tue,
 08 Sep 2026 04:35:49 -0400
X-MC-Unique: PkgkHzyaNqO9SDSyxA4_Jw-1
X-Mimecast-MFC-AGG-ID: PkgkHzyaNqO9SDSyxA4_Jw_1788856548
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCE1B183EEEA; Tue,  8 Sep 2026 08:35:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 016191800346; Tue,  8 Sep 2026 08:35:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 12:35:34 +0400
Subject: [GIT PULL 02/10] tests/functional: add skipTestIfNoHMP() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-2-7a3d1f0f1caf@redhat.com>
References: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
Cc: peter.maydell@linaro.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DKQeIhpML80zf1OYVo6I9MFIu0Q4mYbkgHIMXRWzZK0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn8jYee5DnzUtNWA5AHKOnouiWGRK2DhUi7tJz
 QRXJIdnU5yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/I2AAKCRDa6OEJdZac
 5TGiEACoh4sTyAYmSY4hE1NXKUprpyvFo62uBsFYBiuOJ9OF2DU725yO9oqTgaxvBzaBxdXVWOH
 Bz626V/UjLGhvjNqPWHgfzEbcLMQ9LSJ/cvz6RbV+4XKaGmF0Gd8nMxxIEZMo/siAgA2ZZxhuVD
 CKKeCuIUsVMwVMiSfbbX3n9hZbNoQiYYttK3UJIXgGxLeRjpUGCLMtTMEhIVYxkLu9H1gJSPqnc
 8EgEmJ/6YWlcSjb/B66fgC1rWqhA5EdjnUK3bFdFd8VzhUlehBlZQDvRFWQT5Y8+02tEQt5ocBP
 oOM9lhXLLzzeBVOCZfJT8FDr1Uyju6WYGw5xUlguSRSVXNJUyQVoUUg3ts4D/etuC5nnWXkXlKG
 vuOO4yDI8hB2xM+p9cwhIv/HNke6rbCSwxSyTcIjzNYjyYJFFRfk8PAGPK6mcruhEH0LuPMHCep
 6IfQZpNALGYjjRdhQkoLM5eRxlJn+uAImXhpZhzEYP0kI37UPLJdNm+A3ymxFC2/T0J5oPp9pjs
 b/PF6fMbHd8X6jh0mUWh0ZfMrudUVRgq3nhOsbAZ5XsaxBmgL9CslIiTHsbCIqsBNpcZZ6z2X6i
 Fnz3eqegP2a9uYncZ298201CI8VIVHs1GBQQMYpAC6CQNmbOSM3xhDEuP7Xtk6oiHqkjq8x9Qdx
 7boVLJAXlexnpBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 69d3d06cc0e3..bf2dc1dc101c 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -369,6 +369,12 @@ def require_accelerator(self, accelerator):
             self.skipTest("%s accelerator does not seem to be "
                           "available" % accelerator)
 
+    def skipTestIfNoHMP(self):
+        commands = self.vm.cmd('query-commands')
+        if not any(cmd['name'] == 'human-monitor-command'
+                   for cmd in commands):
+            self.skipTest('HMP support is not available')
+
     def require_netdev(self, netdevname):
         helptxt = run([self.qemu_bin, '-M', 'none', '-netdev', 'help'],
                       capture_output=True, check=True, encoding='utf8').stdout

-- 
2.55.0.543.g5ebe2ebe4ea8


