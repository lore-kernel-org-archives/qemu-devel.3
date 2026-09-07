Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA677C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wd1-0004MD-AI; Mon, 07 Sep 2026 06:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wcu-0004Im-Fo
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wcq-0003Um-Eh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62mvN3+6Ik4rJgbtSXh3PbCH0A6py8ADyiqg0AkiFTs=;
 b=ONldnZZAv2Q6h1v/Kvmr6p/jcvIFGshhVV5lQEAWpD9oO2FWNs1XtCZQLVjebYvxhYL9Lz
 oTgcE5pJiB0fu3TBKg/NsgevMpedABSTo8FMSLhtBNkF1jjVRz0bILrYdJKCtBtZ0VXUFi
 atwgDanH9eSotmj7k8Yj95atkk5wTWs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-lYQjBLE4ODuNxr-jmOAFog-1; Mon,
 07 Sep 2026 06:30:52 -0400
X-MC-Unique: lYQjBLE4ODuNxr-jmOAFog-1
X-Mimecast-MFC-AGG-ID: lYQjBLE4ODuNxr-jmOAFog_1788777049
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0E0B197702D; Mon,  7 Sep 2026 10:30:49 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92E8430001A2; Mon,  7 Sep 2026 10:30:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:23 +0400
Subject: [PATCH v2 05/10] tests/functional/s390x: use QMP for balloon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-5-6d952d972c21@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
In-Reply-To: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJCaTAN8GtF82maIt5YiyiLrAre5xkrOZH+w
 twYbGwLJNWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQgAKCRDa6OEJdZac
 5SHiD/9cxY1UaSPh8eCEXdooDkqiYWSJTCoO6IoTJPcovc/TV2ue+NTDQHJySi0lorbyenbsjgO
 Mv7u1iBjNBo/SVveNBTqco7+UpuM2DogeVVdeNJg7FOiPzAHXyiIZJuBh+mPlR2iPkShs0qo9Z6
 rDu6BalsBWH5CZBSgZmZy28JI2gPxFaczcnTvwFdAqzrPwBw2X8mZXokjjFWj2LcWKj8Rzye2cZ
 RpfRU7D8+swJcTbMWdOREXjpUf4v10pmmEqgyJkdwaFTk80qV2enZ3IEjZUehlsE9WcDFg32e57
 AQxYRRw/YvimR47cTA2GlF9qFcwaU9EQ7/c5wTZxECJSftFL3XRy/eEXptzw3K7krYPauI5LOIy
 a+cOgkQ9f4DhC6zZxf7XNt7d6OahQl9ntaRFxJ1oT5a4QWHn22J4KBTlHPRPFRjv56EPz3Uq8nr
 wcxkXuw5IMz19Qjx4vQk595mFrbk5QpMHj6bi+/+jJyG7u2Od+eF+T6FfHCxqYK8sQtaGaTRPXA
 EX47jPay9z+FJcKi2VMLkUqUSnApcWiLBYeheo+KYFibtPMO+y2JTFZWmj+kew4DeJ6lwfphCYC
 uxD3r0GWKef5t0BMdNVUXqF8oA+p24d8GeG6hzWLrVSxhBw2hEh2Hg6ZLMYZu7ewPZam3WnpGoK
 Cj8nVHW3wJJR1rA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


