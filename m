Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DFCCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBl-0006xX-MU; Sat, 30 Aug 2025 11:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uruXE-00048K-4x
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uruX0-000706-VP
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756456329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FsaiQKyd0g1CH9huElZ/L3wWpKaP1lA41/6YfWyyxLQ=;
 b=PVVTm2WA0rjWmCJLQ61kFrPayyeni6TyV1364vxACEUGfS/hCY0ZJvR8xvZ/QlSF7526Ta
 TGTAEr55UhxkK5XpwV7lpv8r1jFSQwhkpAesnZKli6Z5Pje37qaOAhdVu+fyM5VZV4Vmwu
 KTMS/B7Z4Q/1JVaqrtZgxU/ZsgL6upk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-zTKL4RUqOjWVdE7Hh8-3Dg-1; Fri,
 29 Aug 2025 04:32:00 -0400
X-MC-Unique: zTKL4RUqOjWVdE7Hh8-3Dg-1
X-Mimecast-MFC-AGG-ID: zTKL4RUqOjWVdE7Hh8-3Dg_1756456320
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8780195E906; Fri, 29 Aug 2025 08:31:59 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1219C19560BC; Fri, 29 Aug 2025 08:31:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/3] tests/functional: improve handling flaky downloads
Date: Fri, 29 Aug 2025 09:31:53 +0100
Message-ID: <20250829083156.2570137-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

We can see teh download fail & retry, and then gracefully
skip pre-cache:

2025-08-29 08:02:16,510 - qemu-test - INFO - Downloading https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf to /builds/berrange/qemu/functional-cache/download/d3a01037f33e7512d46d50975588d5c3a0e0cbf25f37afab44775c2a2be523e6...
2025-08-29 08:04:28,104 - qemu-test - ERROR - Unable to download https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf: URL error <urlopen error [Errno 101] Network is unreachable>
2025-08-29 08:06:39,177 - qemu-test - ERROR - Unable to download https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf: URL error <urlopen error [Errno 101] Network is unreachable>
2025-08-29 08:08:50,248 - qemu-test - ERROR - Unable to download https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf: URL error <urlopen error [Errno 101] Network is unreachable>
2025-08-29 08:08:50,250 - qemu-test - ERROR - https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf: Download retries exceeded: skipping asset precache

And then later the test itself is skipped:

55/67 qemu:func-thorough+func-arm-thorough+thorough / func-arm-realview            SKIP              0.11s   0 subtests passed

Daniel P. Berrangé (3):
  tests/functional: enable force refresh of cached assets
  tests/functional: fix formatting of exception args
  tests/functional: handle URLError when fetching assets

 docs/devel/testing/functional.rst   |  3 +++
 tests/functional/qemu_test/asset.py | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.50.1


