Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B55FC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxaz-0001sM-JT; Fri, 28 Feb 2025 05:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnxay-0001rw-IS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnxaw-0002sU-UA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=abB4Z0wHw3i8cnKiY3rcpmTPIzZ79A0ZbRFJ8iskHT0=;
 b=jJZIpcPSxT3WFil3cDXhwB3UY+weFhF2LkO4TzMXt+NvrlqkBCrYRwK6yeWoysFHSVkm3T
 VivZmQo2zPJY4CHkf0IlaJIt1x1Ai4fbFBF9ItZyJjvLrUTzRBM0iitieDVj5SVDsIcSpk
 GXYO87Su65JzbL623qcV112+JLlsMhA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-kdet99gzPpmH1lPnpLj_qw-1; Fri,
 28 Feb 2025 05:27:46 -0500
X-MC-Unique: kdet99gzPpmH1lPnpLj_qw-1
X-Mimecast-MFC-AGG-ID: kdet99gzPpmH1lPnpLj_qw_1740738464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8BB1180087A; Fri, 28 Feb 2025 10:27:44 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE62D1800367; Fri, 28 Feb 2025 10:27:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 0/7] tests/functional: a few misc cleanups and fixes
Date: Fri, 28 Feb 2025 10:27:31 +0000
Message-ID: <20250228102738.3064045-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

See individual commit messages for descriptions of the
cleanups/fixes.

Changed in v2:

 * Drop the patch which skips tests when QEMU_TEST_QEMU_BINARY is unset
 * Change the way we skip tests on 32-bit builds to check the ELF binary
   format
 * Make ppc64 tuxrun tests work on 32-bit
 * Removed unused 'get_tag' method
 * Hide output from zstd command

Daniel P. Berrangé (7):
  tests/functional: remove unused 'bin_prefix' variable
  tests/functional: set 'qemu_bin' as an object level field
  tests/functional: remove all class level fields
  tests/functional: reduce tuxrun maxmem to work on 32-bit hosts
  tests/functional: skip memaddr tests on 32-bit builds
  tests/functional: drop unused 'get_tag' method
  tests/functional: stop output from zstd command when uncompressing

 docs/devel/testing/functional.rst        |  2 +-
 tests/functional/qemu_test/testcase.py   | 14 +++-------
 tests/functional/qemu_test/tuxruntest.py | 11 --------
 tests/functional/qemu_test/uncompress.py |  6 ++---
 tests/functional/test_mem_addr_space.py  | 34 ++++++++++++++++++++++++
 tests/functional/test_ppc64_tuxrun.py    |  2 +-
 6 files changed, 43 insertions(+), 26 deletions(-)

-- 
2.48.1


