Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB6BC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sV5-0004Ak-H3; Tue, 08 Sep 2026 05:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sV1-00049q-PT
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sV0-0002cT-C5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62mvN3+6Ik4rJgbtSXh3PbCH0A6py8ADyiqg0AkiFTs=;
 b=A8inVvP9+5vcXjkmAgpfWY2owg9LMeHOQ4HFRyAE7HND3i4cTiim5GHmI1i1PEAWXqCdrw
 fet2Ckqbt0bG52ByZpO6Rut0CSH0lJcq2ueAXushIVK6pXPpBXTgXiUrgkd3JXs++CUyvS
 OhbcytzS2QCFOdQeO5WH3OF9ykHZaHk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Ztec0BrMPxOo8djE5oKPIQ-1; Tue,
 08 Sep 2026 05:52:14 -0400
X-MC-Unique: Ztec0BrMPxOo8djE5oKPIQ-1
X-Mimecast-MFC-AGG-ID: Ztec0BrMPxOo8djE5oKPIQ_1788861133
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E80F8184AF9D; Tue,  8 Sep 2026 09:52:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1B8D5B1; Tue,  8 Sep 2026 09:52:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:53 +0400
Subject: [GIT PULL 04/10] tests/functional/s390x: use QMP for balloon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-4-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=090HS6zLuSEZTINBqsIWMEfBWo0e9Nx0kELk6Jj7tAY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q65LtUsoMj71Fe7qhqQrWmYe8Anm8MEfIVE
 ELD7UctZnaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5XDgD/9X2FoQ/lssYigXOUCiHLomSvZuexHRmSTe19CUEoWsPDKn53lEblqMHetJWS6Ac/mRww9
 r2CSq8GDTycPAdxgQCOUJ/w2o6mtE2QRZPxTiqydGqsOGia+7cLUtedcf8dJMBU9RzNNhJJyrLr
 SojJB6ELei+OQ/Tg+V0972SkxSQZUaLxaAUZXamaTDZ70Kn5n2mJ2wx91Gp2c1MztqF/o5VQOsG
 aZZ3sV2OIS4mjJxzscElRHfQW1rztPz3PqmxfrF/Guv9EIO3IP+cFpgWILywQ/eLtTrSo8OZ8B1
 vOXCNoXfXLCGO1YoZSsqPttXRFONM9ZxvXK1ctsJWhBt0JP8qciYWKQZYMfQDUAkgPSDYl5NmsA
 wbNayLZVxN5+kfx5OsC9DLXzIfdYiKILbvXbbFZuRucv6OkQ4IRnfa576uQCsE/Bg7ghYtT9sqP
 827SG7XNcaHwCeUfgp8BnoquKDoOmnoEjNbYwBEnS/D9TfJptlWkm1D8Y821q1utYWes9E9T3pY
 cFurHmMjGGfK0b1yrxaX9LAyklqwQNnkGKS7CHHpKiaZJzPkDSd+Hqjb8K12LlXe6/79Ie/HSTX
 jQLzHruJydIcGCk6UxGBnqUwD1+xbIwlvC3x/CA+dxoBhbVX3HQZsBzGVlsAR8TfO04mICfl5KG
 REiZb95DdYk8fZA==
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


