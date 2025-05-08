Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F672C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3uh-00089o-Gx; Thu, 08 May 2025 12:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3ua-00089J-Nc
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3uY-0007YM-IF
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746720946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZcJjDLYILksVF3OyFPPTQMnJuERNkmPbZFUXpPTzQ+o=;
 b=OI2dRqRe/ypmtmINqJgzrwjWk+dUpJaIQ/1/0D43zp+BkGnFW48pbpX4VqYeJXue0pIYP+
 fARYkju71ZQpFaBMd9uEod0xkik1T5GL9An/5rJSVMA3Hb9CyfPD+WvmZPcplU1kvQpaHC
 60mpjva6ofOH9F5/kvpYhsg7TtOVs7c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-Axhgb3NyNWy8Fwo41ynIlg-1; Thu,
 08 May 2025 12:15:44 -0400
X-MC-Unique: Axhgb3NyNWy8Fwo41ynIlg-1
X-Mimecast-MFC-AGG-ID: Axhgb3NyNWy8Fwo41ynIlg_1746720943
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCF461800256; Thu,  8 May 2025 16:15:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00ADB180049D; Thu,  8 May 2025 16:15:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/6] Versioned machine type deprecation policy patches
Date: Thu,  8 May 2025 17:15:30 +0100
Message-ID: <20250508161536.865866-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 57b6f8d07f1478375f85a4593a207e936c63ff59:

  Merge tag 'pull-target-arm-20250506' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2025-05-07 14:28:20 -0400)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/docs-dep-pull-request

for you to fetch changes up to 3fbb0a1397a9acea523f3c8062df8c6f8032788d:

  include/hw/boards: add warning about changing deprecation logic (2025-05-08 17:11:16 +0100)

----------------------------------------------------------------

* Remove test relying on 4.1 machine type that is about to
  be disabled
* Fix off-by-1 in deprecation/removal logic for versioned
  machine types to cope with dev/rc versions
* Enable logic for disabling registration of versioned machine
  types which have exceeded the deprecation lifetime policy.
* Add automated version information to documentation about which
  versioned machine types are deprecated and removed

----------------------------------------------------------------

Daniel P. Berrangé (5):
  Revert "include/hw: temporarily disable deletion of versioned machine
    types"
  include/hw/boards: cope with dev/rc versions in deprecation checks
  docs/about/deprecated: auto-generate a note for versioned machine
    types
  docs/about/removed-features: auto-generate a note for versioned
    machine types
  include/hw/boards: add warning about changing deprecation logic

Thomas Huth (1):
  tests/qtest/q35-test: Remove the obsolete test_without_smram_base test

 docs/about/deprecated.rst       |  7 ++++
 docs/about/removed-features.rst | 10 +++---
 docs/conf.py                    | 39 +++++++++++++++++++++-
 include/hw/boards.h             | 58 +++++++++++++++++++++------------
 tests/qtest/q35-test.c          | 37 +--------------------
 5 files changed, 90 insertions(+), 61 deletions(-)

-- 
2.49.0


