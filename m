Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD6CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNN8-0000Vp-EN; Sat, 30 Aug 2025 11:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us03l-0002WS-3t
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us03g-0003iX-Ay
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756477584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AcCUi87z7t9GF0Ysx99vdQYv+rTU41jhVQXXmpeaZtY=;
 b=X65Ximcwv+w0NVHvWls+3+49QQevkkC8oEewyqHdVXQYMLC6Mu4+lf1HUozDSAGy8Etl40
 KaXkFiXJV3AOv/JFKRCo3A+tHtyl9VzYFwso3yjQV+yPC6OCW3e02Z6YTgIlYNdpERYUqz
 44Pvt4Zi6yfGDpp/oPHaqmvOen23X3w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-xUaVLUJUMYW9sFeSCzubpg-1; Fri,
 29 Aug 2025 10:26:21 -0400
X-MC-Unique: xUaVLUJUMYW9sFeSCzubpg-1
X-Mimecast-MFC-AGG-ID: xUaVLUJUMYW9sFeSCzubpg_1756477580
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 459C419560AE; Fri, 29 Aug 2025 14:26:20 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D45F1955E89; Fri, 29 Aug 2025 14:26:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/3] tests/functional: improve handling flaky downloads
Date: Fri, 29 Aug 2025 15:26:13 +0100
Message-ID: <20250829142616.2633254-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This fixes the functional-system-debian job with the currently
awol archive.openwrt.org server.

  https://gitlab.com/berrange/qemu/-/jobs/11173491503

We can see the download fail & retry, and then gracefully
skip pre-cache:

2025-08-29 15:10:11,242 - qemu-test - INFO - Attempting to cache '/var/home/berrange/.cache/qemu/download/d3a01037f33e7512d46d50975588d5c3a0e0cbf25f37afab44775c2a2be523e6'
2025-08-29 15:10:11,242 - qemu-test - INFO - Downloading https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf to /var/home/berrange/.cache/qemu/download/d3a01037f33e7512d46d50975588d5c3a0e0cbf25f37afab44775c2a2be523e6...
2025-08-29 15:12:24,116 - qemu-test - ERROR - Unable to download https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf: URL error [Errno 110] Connection timed out
2025-08-29 15:12:24,116 - qemu-test - ERROR - https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf: Unable to download: URL error [Errno 110] Connection timed out: skipping asset precache

And then later the test itself is skipped:

55/67 qemu:func-thorough+func-arm-thorough+thorough / func-arm-realview            SKIP              0.11s   0 subtests passed

Changed in v2:

 - Simplifiy patch 2 - adding the URL was NOT in fact needed,
   as AssetError adds that automatically
 - Avoid retries on URLError failures

Daniel P. Berrangé (3):
  tests/functional: enable force refresh of cached assets
  tests/functional: fix formatting of exception args
  tests/functional: handle URLError when fetching assets

 docs/devel/testing/functional.rst   |  3 +++
 tests/functional/qemu_test/asset.py | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.50.1


