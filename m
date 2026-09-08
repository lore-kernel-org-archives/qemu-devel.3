Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC67FC79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sV3-00049p-7C; Tue, 08 Sep 2026 05:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sUv-00049E-Sf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sUu-0002bP-J4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40LyvCDlaHAQHcMLKYj1Q0OPDSPjXdpYRkudFHr+oJg=;
 b=jMoT3WjXRtpK6OVQzMZJCz0X3o90aCZCOSUAVgLubE4ZsVPCAQwN+zY0DTdIsCkZmibbP+
 IW+C4UD+nsWskt0XXwZthyjWGxKi3Mu5RBt5IBeDn65cW3u6EUkalV6oJ5n9ZRZJ8fsYZn
 E4IR02BCCrOCeWEdHaLwY7nptHVHT7w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-f07NRklxMCu-s-8RkrZ-uA-1; Tue,
 08 Sep 2026 05:52:07 -0400
X-MC-Unique: f07NRklxMCu-s-8RkrZ-uA-1
X-Mimecast-MFC-AGG-ID: f07NRklxMCu-s-8RkrZ-uA_1788861126
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3E1F1801BF1; Tue,  8 Sep 2026 09:52:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C701D427; Tue,  8 Sep 2026 09:52:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:51 +0400
Subject: [GIT PULL 02/10] tests/functional: add skipTestIfNoHMP() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-2-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DKQeIhpML80zf1OYVo6I9MFIu0Q4mYbkgHIMXRWzZK0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q61Q+aIkI5L5wN9/fLiS/GxnTlxO8r/mU0l
 geEUn7BWv2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5YAMD/9hOU1BQsi5hvY6MfX2g9L637+lS0EwSXmzXpJc8P1VpUplOeX6V0Hm/HNPX6iCDJ/28y9
 y+QUqETfFjux7SRXeknwBUEQPSpmq6kg6s8Kn/Pw3vBo54MOafjVV4nv68IFOZkzajyGhXuqb6a
 MWTTolZpdrwVt/Cn3w0PLH62pirM1tSqd/iu2T/d3Z5DipMb1LZ7mHrVkU8Drk6mDcA84l3vtcd
 ASNLzpbegz+nbGOkaRHVnJVoD0LHzmmKjAMf75C9199qQc8CMRm/ICAt0VD5bk0z9PD5vxcTk+D
 6YQ4+oSHcHcJxa8aB6euw8eSnglOGeZgBi7z4XWrp4vQJLPy7WO/oLaZQFk/oXB6mX/oFruytir
 oie8JyJ6WjxlOPQzhixhC692HMKjnXWu/SZwupUOuNxZLiHkJ92lP+AuLjSc+vtCtrcAXR0tODR
 C7GiNkycCdg9+s2SG9rqAKU8Z7jk9D2Fg3cswjmnzT88rK413I6ilbO8WizYhanq2aIKOUTBHca
 /eu1R5VKlFennfxMT29u2y21I7PQAAHxTEp/rzBHKAtI8S2qTG/UvuWbTrNIv/crla7TUiSucVY
 mC1h2JFttTp5ytDY5IJTvPyrNWD6WWkFXUJH8cUcU4mH0p9Y+T1JOj36eB8cnM0oG/nzYJXy74z
 YQQmq/lEq02sD5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


