Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE04C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZBd-00051i-TN; Mon, 07 Sep 2026 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBL-0004lL-K8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBJ-0006Zg-BY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62mvN3+6Ik4rJgbtSXh3PbCH0A6py8ADyiqg0AkiFTs=;
 b=Yxxe98J9Y35gfyWErNYJnvkbPLqjiGRloZcwYEcQPUDR0GcvM7qCGlMXJsQi5vAGnT0H5D
 J0B6drPP/FHIHOphWp2KsA4pXAjwLWZHPE2IOCBAd3Gc3/46XnPncvstBCx+lI3YYzPd4k
 X+ccNy/YazsUdYU99vGW2rgOEwaJHq4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-HSNUZ_GjOa-4QEOK_vldYA-1; Mon,
 07 Sep 2026 09:14:31 -0400
X-MC-Unique: HSNUZ_GjOa-4QEOK_vldYA-1
X-Mimecast-MFC-AGG-ID: HSNUZ_GjOa-4QEOK_vldYA_1788786859
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 684421954AE0; Mon,  7 Sep 2026 13:14:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9657F1955F06; Mon,  7 Sep 2026 13:14:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:13:58 +0400
Subject: [PATCH v3 4/9] tests/functional/s390x: use QMP for balloon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-4-c11e7d0d3d7d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=090HS6zLuSEZTINBqsIWMEfBWo0e9Nx0kELk6Jj7tAY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriXrUSpL4DQNyuUbQOvO1FhBmFAi0kYCJrVG
 +PF2DlajRaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64lwAKCRDa6OEJdZac
 5dbWD/9seRKQBe//1mKwGDdX3edyT6T0eCwZwt7+XMBsz7QvcQp8fGwrzWtWK3QKvhPfZTClXPI
 yqx1mZG6rlV1RaLMorbiBa7aXMDJEJP1BF6JMsPL+FEF2qxkEyLH5lrcsMUzEkqZZ9b/Jdor5GW
 k/fl8W6dFFxusZr9BVr3R9V/OUuCqMsTa72e/btmR+9Mj/ABxPtHiAJ0xvj7OgnZoU16KPek6nD
 7k7qSdzsDb8cysgHfAvLVjth0JnHgXSIxtYwEZ31VYVrQMy6CLMEPNy7f9YZvUv2kOw5ru2GZEJ
 kA/82PwZhBSwNmWR508k1op9bxir/cJfT5lfxfyZAItLSYXv+nqQaqZ0zCHWlv+M6uVKEnFli5s
 QcFArUXENDxOYe8A9VkzNYbWnpPpJuSXa5nu4gpuo1wzt5xhaVrmWl5smgICXCEJH1qyvdCGNsy
 6UPPEWOlsoJgJAsMLmlp4QkP8aRxrQnSM0FVJ65neeHgKec3UrQQL3JaU6hPzjzm1HXwcUtvI/s
 mNp5jPNVjuz+FnWf1qsb5eZmBd99aGiBYfvrY4PLI1S/lkcAPPd465i3FqmFVQzFBYalrWkptqL
 GMIWIRdrQAMo5x8njaxgSjpVQX7xvZEyULGxRNksDtKroaHV2vPdRXzuGE2Fei6x5FSiM+KICaN
 WYnQmj3V0qyyWaA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Unit is changed from megabytes to bytes.

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/s390x/test_ccw_virtio.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
index 1d4958bbe293..f816b1e201a1 100755
--- a/tests/functional/s390x/test_ccw_virtio.py
+++ b/tests/functional/s390x/test_ccw_virtio.py
@@ -162,10 +162,10 @@ def test_s390x_devices(self):
         # test the virtio-balloon device
         exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo',
                                           'MemTotal:         115640 kB')
-        self.vm.cmd('human-monitor-command', command_line='balloon 96')
+        self.vm.cmd('balloon', value=96 * 1024 * 1024)
         exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo',
                                           'MemTotal:          82872 kB')
-        self.vm.cmd('human-monitor-command', command_line='balloon 128')
+        self.vm.cmd('balloon', value=128 * 1024 * 1024)
         exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo',
                                           'MemTotal:         115640 kB')
 

-- 
2.55.0.543.g5ebe2ebe4ea8


