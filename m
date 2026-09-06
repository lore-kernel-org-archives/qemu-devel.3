Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3AFC79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38St-000482-Ht; Sun, 06 Sep 2026 04:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38Sq-00045a-EX
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38So-00084Q-Lg
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEbb4dhaeD+lsM0AA0lFSd4ZvixReOMLo4xWix/U3NY=;
 b=TIDgkMgUgXqEwrvbFreOWi715ay4MhcuqYxuEDAhIR6nPE8LCpgVk2Us2dbF2/rb611u6k
 jHhqRNACzPqpNZ/b8NP07RW7XyY4Mo/UkMGsJVEBti2qj0qjDU1csNGKXlkXrjIRQP0++/
 IJbMrR8wbaA6hNaGDf2oWf4KRqS4fTQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-jyHSl4O5P2-31v0Hi24leQ-1; Sun,
 06 Sep 2026 04:42:54 -0400
X-MC-Unique: jyHSl4O5P2-31v0Hi24leQ-1
X-Mimecast-MFC-AGG-ID: jyHSl4O5P2-31v0Hi24leQ_1788684172
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C34219541A8; Sun,  6 Sep 2026 08:42:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A18B41956042; Sun,  6 Sep 2026 08:42:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:42:34 +0400
Subject: [PATCH 3/9] tests/functional/s390x: use QMP for balloon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-v1-3-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
In-Reply-To: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2fq7U7xC1QIIAG0QCeRA3MsEDE/4ODTTnvIrI+PgNc4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5T4ZD+4sh89bIl/YejIJJatjgopQJPOJtH
 YhvLgw2iRqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5ay9D/4wqIrXsMC8J/zbbtFME6inLBpGo2dYBQREb2AGrQA2W0AsUPYO4HPXLfIMjmhwxBXmnWi
 pF1Sg/UZ0Y2//u7JgM2njSiP5H5vYI0N/MCHbanImS5Tenj8ORP/1dFraFqL1oJfw0FH932cOWO
 4+IrYbm3/zrrUHuf0suM70FNFTQ/3bIiYRqaHVFHnCyi4Jk7rszO1G4MJNBqpiYY3a6ghxFuany
 rfYMxSDdvmArg8MJgnn45FwgGzFhBsTO7YwPTIW0QsOqlzRA7CoWPhkddUfbMHMM2iYHWQ5UR6o
 SEPF1rSxD9sT6XnSmynpIra7+JKAZ96DgXPH5JIEP1xPssvhBB6EBmIRvq1bXiRpSjxGU1rOKas
 VDihOL5lm/QHowoddkbBW6EwqxSqSmFrBJQARBoBFFPd3cp+jFr7o0I/TZ48VY+NUKwSsD8s3js
 Csk168cM9T1PEkV5o9vLImZ0izATAHKFxmvc/5FJ0ZN+Tq1ePw0Cg2YqK68pH0w9KWZBDh6dluO
 x6/xKaJGPjnEJ8+Du3SigELn/Q3OegCZaPy/CxbeOyxc6yw/XaaR31O5VS6xJVyx6O2t79n8YzK
 Io+igPIpXlfIRm1O/Ni0dKjyCh9gCfZLfZ84fNAc806TUrOA56oZRnvuS5AeypTbgmAhPlY5mLh
 G5qfCplvrav0t0g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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


