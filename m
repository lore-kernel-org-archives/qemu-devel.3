Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91836C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZB8-0004GU-Oy; Mon, 07 Sep 2026 09:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZB1-0004Bp-7o
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZAy-0006Sm-8s
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p7jtalzlLyhCAYc3MxC7WWwgcA0LpGHOMMDNN/DBTg=;
 b=J8GNOD6yc4Xvt2lgvjlRM4i8AMMyfO1nl2YiQutl5M2seuZ6Rsu00rz9SfASxLEClYNws7
 e/D4G5d33OPmBgslWgQpN0SFGLJw87RbDAlNFkgT5jpAX+25oZ43TOy4o05WOjRthm6DSj
 yGF+lurbord0PsxYShDnuHJdGg948jk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-7EeU7Lw0M8GeMlUjwCZ7nQ-1; Mon,
 07 Sep 2026 09:14:18 -0400
X-MC-Unique: 7EeU7Lw0M8GeMlUjwCZ7nQ-1
X-Mimecast-MFC-AGG-ID: 7EeU7Lw0M8GeMlUjwCZ7nQ_1788786856
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3A471954238; Mon,  7 Sep 2026 13:14:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D474A427; Mon,  7 Sep 2026 13:14:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:13:57 +0400
Subject: [PATCH v3 3/9] tests/functional: skip some tests that require HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-3-c11e7d0d3d7d@redhat.com>
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
In-Reply-To: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=c8qgPpmZ3XLl9uO8pUVbfyeeb4zTdwm0KeCmlMQU5BE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriXUyIoQ4RFCIcynTuStlQLJ7RHtw6y5XZTH
 e9teC/wh8iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64lwAKCRDa6OEJdZac
 5XIAEACKxFXv4vn6pB0LQW6YGimEQCFSpe8kz0H7QKtrrquP6Oaor1Tnvs13RnJk38IOQ+64E/n
 ZT/YfCguvyX7oSTX4GqajwwgpBXXqnMkuLLE+V4aAHn4HmwoWOTWA7cQXnC+PjwzYmLSCnkfxC5
 Xxu33Q99L50gYfsrlSUNAI+3elEL0oSeiZNKglwBdz7zBIDqbyJVb36qLxDkI4z+4YhCXWidmOj
 NhfA2yA1xpF9bEk+9TY8XXHwwb6a3huSM0uxwTmMpqfZpowrgKeuIQErabmIC2bfshLnY0vs5UX
 JVkiniBfMVu3scy6XjlQQI45gvlEduBCi2D6OX+wj936zL5JiK/OOT/0UMdLSjCdcTCtimHYhSd
 eb4wBg+5n0N93LRXNrtrt99tLxmH40RB/HSQGuPS123FABwR84SPuKdxhxzp1Dbjc73WR2redft
 kxuPhuoraetcM83gRp5iqYcLJ3ZqG8t0yWAqTACa6/DD4sthaqy9ZkVCRTVS8vzDdzbAYqmDXrV
 Dmbt8LsH+K+XzlHQSRqW3tO5R0MG4b0wY8G8wBPUlYlfeEz0kQL+jJRHz6LZnmdOOrOiUUIK66n
 8bRQSXXqfwTgvyG7Jrhb7EVw73KxpI0+EoRwsP5DeQ467oVPz/qCKj0tr9vHjB5dKmuyp8eH2x3
 dcvA4kkBoMP2mlw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Those tests use "info registers" command and cannot be converted
easily, for now skip them

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/m68k/test_nextcube.py | 1 +
 tests/functional/ppc/test_ppe42.py     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index f3d92034b127..e7fca50292b6 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -28,6 +28,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
 
         self.vm.add_args('-bios', rom_path)
         self.vm.launch()
+        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
 
         self.log.info('VM launched, waiting for display')
         # Wait for the FPU test to finish, then the display is available, too:
diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
index 53958a7938d1..a9c154f67328 100755
--- a/tests/functional/ppc/test_ppe42.py
+++ b/tests/functional/ppc/test_ppe42.py
@@ -72,6 +72,7 @@ def test_ppe42_instructions(self):
         self.vm.add_args('-device', 'loader,addr=0xfff80040,cpu-num=0')
         self.vm.add_args('-action', 'panic=pause')
         self.vm.launch()
+        self.skipTestIfNoHMP() # FIXME: QMP x-query-registers
         self._wait_pass_fail(self.timeout)
 
 if __name__ == '__main__':

-- 
2.55.0.543.g5ebe2ebe4ea8


