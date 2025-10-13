Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523A1CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HUg-00050v-Jj; Mon, 13 Oct 2025 08:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8HUb-00050a-MT
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8HUY-0004Aj-NQ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760357848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4lHD3rpGtLD5XurvaKbNQCyM7S9BX4Hy8HxVFBcKrrs=;
 b=OwuD9UQrqwD5cdIclji1c3SHI51Nd1QJEFqKNV3gecX8OMlWiT9bEp78OHbQJNO847BAXF
 miIRwlbQI65fZK6dg/Yn7tWU8+CRvQatg9pKee4SSNe2AmCgAW1XQrgBC059ROHFEkSCBu
 yRFSfHpYir4KD7ElOvexITNkqB/sbzk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-PXIw33mHNcSIdIX0IgUZkg-1; Mon,
 13 Oct 2025 08:17:25 -0400
X-MC-Unique: PXIw33mHNcSIdIX0IgUZkg-1
X-Mimecast-MFC-AGG-ID: PXIw33mHNcSIdIX0IgUZkg_1760357844
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 727FE1800577; Mon, 13 Oct 2025 12:17:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.160])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DD281954105; Mon, 13 Oct 2025 12:17:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] Clean up the functional download cache after some
 months
Date: Mon, 13 Oct 2025 14:17:17 +0200
Message-ID: <20251013121720.34552-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The download cache of the functional tests is currently only growing.
But sometimes tests get removed or changed to use different assets,
thus we should clean up the stale old assets after a while when they
are not in use anymore.

This little patch series now introduces time stamps for the assets in
the cache (first patch) that we update during each test run, so we can
check these time stamps regularly and evict stale assets after half
of a year not being used anymore (that should be enough time to still
keep the assets around for a while in case you want to diagnose a
problem that is still some months old).

v2:
- Add some wordings to the 1st patch why we cannot use mtime/atime here
- Use functions from Path object instead from "os" (thanks to Daniel!)

Thomas Huth (2):
  tests/functional: Set current time stamp of assets when using them
  tests: Evict stale files in the functional download cache after a
    while

 MAINTAINERS                         |  1 +
 scripts/clean_functional_cache.py   | 45 +++++++++++++++++++++++++++++
 tests/Makefile.include              |  1 +
 tests/functional/qemu_test/asset.py | 15 ++++++++++
 4 files changed, 62 insertions(+)
 create mode 100755 scripts/clean_functional_cache.py

-- 
2.51.0


