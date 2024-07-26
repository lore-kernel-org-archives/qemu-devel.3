Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAF0C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLGB-0004dm-8p; Fri, 26 Jul 2024 09:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLFz-0004Z4-7c
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLFx-0001sk-KJ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722001512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3IWYfQZY9Vtpyu9w1tUYKrkYYnY1w3NcI8rW4hxkqc=;
 b=R3DHgSxWB8Nkbx1L8hiKg4JD8LgUJkfyRTz7olKuJq7bA44SjWfGB2NquSedA4jZmZgeka
 nZGwVUW+jUW/uPquw4rJGY5MltPu/wYciUBNd7AXkaNoZZHK4Wqo3IUFX5AYPhwkwHZtSP
 DwIqa9Kf0JH8ddB2p7kJ36jF7KEENkQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-PAgA_eesNUeDe2ihR7jBMg-1; Fri,
 26 Jul 2024 09:45:05 -0400
X-MC-Unique: PAgA_eesNUeDe2ihR7jBMg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D3B11955D4E; Fri, 26 Jul 2024 13:45:03 +0000 (UTC)
Received: from p1.localdomain.com (unknown [10.22.17.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 102E31955D42; Fri, 26 Jul 2024 13:44:57 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 03/13] tests/avocado/intel_iommu.py: increase timeout
Date: Fri, 26 Jul 2024 09:44:28 -0400
Message-ID: <20240726134438.14720-4-crosa@redhat.com>
In-Reply-To: <20240726134438.14720-1-crosa@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Based on many runs, the average run time for these 4 tests is around
250 seconds, with 320 seconds being the ceiling.  In any way, the
default 120 seconds timeout is inappropriate in my experience.

Let's increase the timeout so these tests get a chance to completion.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/intel_iommu.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
index 008f214397..9e7965c5df 100644
--- a/tests/avocado/intel_iommu.py
+++ b/tests/avocado/intel_iommu.py
@@ -25,6 +25,8 @@ class IntelIOMMU(LinuxTest):
     :avocado: tags=flaky
     """
 
+    timeout = 360
+
     IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
     kernel_path = None
     initrd_path = None
-- 
2.45.2


