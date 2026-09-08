Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A83C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rJD-0007DV-7R; Tue, 08 Sep 2026 04:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJB-0007Ce-FK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJA-0007Fy-1v
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788856559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62mvN3+6Ik4rJgbtSXh3PbCH0A6py8ADyiqg0AkiFTs=;
 b=M42krwxGQ+TB43V2VuXyceruV4F1ZqasRyMkPa9ymJsTNpPQqLFR01mr3tX+MBJE0GT0nY
 0AN50jpuHW1bhwdzbsmIP+zX6P0eppUss6yuC7L+h4VlmxMiUX+f1yP5Dfe/XwoYVesS2H
 BjgdCLqlM9PIe/XCyhEVATayjVMwJX4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-HUdCof06OfaelniHXzq_mA-1; Tue,
 08 Sep 2026 04:35:56 -0400
X-MC-Unique: HUdCof06OfaelniHXzq_mA-1
X-Mimecast-MFC-AGG-ID: HUdCof06OfaelniHXzq_mA_1788856554
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B67C11834589; Tue,  8 Sep 2026 08:35:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90E9719560AB; Tue,  8 Sep 2026 08:35:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 12:35:36 +0400
Subject: [GIT PULL 04/10] tests/functional/s390x: use QMP for balloon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-4-7a3d1f0f1caf@redhat.com>
References: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
Cc: peter.maydell@linaro.org, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=090HS6zLuSEZTINBqsIWMEfBWo0e9Nx0kELk6Jj7tAY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn8jYnXQ/9XsDpYGlkNpOOOf64T/j/eYzvig7a
 b3fEWomxruJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/I2AAKCRDa6OEJdZac
 5XSgEACf50CfNfSCAmH6mpxv5lbZg0eyFlglNwFxEG9HWxoCDddI32wwPz3LjhlLWviMs0270cd
 NkeVemAmmKDw5NpEUZRLSNZv5JeTaFJPxL0AkQJug5V44vwJ8vpXtZNmNo/8EIQQM3ectcdYsX0
 Ps8RACAwcfWxZXag+/GekPFOsr8ATFKJVI169lG0uQOhQ+iMSEY2Xy4bXfPGtzas0sizJhWBxrf
 z3Y9Oi7YxLEUggRTKXAoSHoEtCed8G+zFmRxrEf3f+xfbHW+NrmWc4L56AmHjbGzAz8rXv39eVh
 vJKtnCxAnC/R9yBO/gM6obHdHhxIKgo9DOivAnh5kIO49YFAq7JITt3WpMh4uz0Qc4KrIb5xmy5
 iLG+OU84etZQEV6I91jKPlonaNmS8lxuJuJa1z/DHtEZO9fYEUhnqU66Z1JhIukcBeuzA/tisji
 Z2cnajx8Ow7gjdxnqxTnnI8JoV9wBsLx0GgwYgTdbUqLb0i4g7VK6b2NzN+qStBqHc7og8Je4S/
 /tgySOUBpPTzB4n2Ve+rlEeq65dgMbOQE/aOjJx4/AW6Nj2XfeIwJAWq07AqGK1f7gVyrzwCcMF
 RX6gOqB6nbXI65rr8teZFhKthcWDEa6SZS4IIltcJYsssjWz3huNe1xf+eV+cJ8h0eJZ51gWmr4
 NhWa3fYtSAF455g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


