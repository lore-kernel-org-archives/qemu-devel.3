Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025AAC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9koJ-0000Lo-DB; Tue, 29 Apr 2025 09:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9koH-0000LQ-I6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9koF-00040T-SQ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745932538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6V7XFxCoLB8K03dExujKCIN8n66f4CpcpEnHTwhO3Zg=;
 b=OHAIKV8nktrzHCW1QW1N7NQRhs1cPMqiSPCR+MXpbeDjVYj/WaiOyJxSa7Lc8T5JR5BvPX
 Dba1LLG3cYa7iyPHQzuMWVvoZMM0ywjVVmPEeop2DVDdpJ1rVuVANt6tIVsdMRHGyiCQ5o
 T84RXxHPr4qe0UI3JFYS3g6UauY9N+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-F4DkB8oHOVq93XhRnZF8LA-1; Tue,
 29 Apr 2025 09:15:33 -0400
X-MC-Unique: F4DkB8oHOVq93XhRnZF8LA-1
X-Mimecast-MFC-AGG-ID: F4DkB8oHOVq93XhRnZF8LA_1745932532
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E945180048E; Tue, 29 Apr 2025 13:15:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.98])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09DBE18001D7; Tue, 29 Apr 2025 13:15:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/5] docs: automated info about machine deprecation/removal
 info
Date: Tue, 29 Apr 2025 14:15:21 +0100
Message-ID: <20250429131526.1842130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

Since we deprecate and remove versioned machine types on a fixed
schedule, we can automatically ensure that the docs reflect the
latest version info, rather than requiring manual updates on each
dev cycle.

The first patch in this series removes the hack which postponed
automatic removal of versioned machine types to the 10.1.0 release,
since we're now in the 10.1.0 dev cycle.

The second patch in this series fixes the logic to ensure dev snapshots
and release candidates don't have an off-by-1 error in setting
deprecation and removal thresholds - they must predict the next formal
release version number.

The following three patches deal with the docs stuff.

With this series applied all versioned machine types prior to 4.1
are now removed (hidden). We can delete the code at our leisure.

Changed in v2:

 - Remove hack that temporarily postponed automatic deletion
   of machine types
 - Fix docs version info for stable bugfix releases

Daniel P. Berrangé (5):
  Revert "include/hw: temporarily disable deletion of versioned machine
    types"
  include/hw/boards: cope with dev/rc versions in deprecation checks
  docs/about/deprecated: auto-generate a note for versioned machine
    types
  docs/about/removed-features: auto-generate a note for versioned
    machine types
  include/hw/boards: add warning about changing deprecation logic

 docs/about/deprecated.rst       |  7 ++++
 docs/about/removed-features.rst | 10 +++---
 docs/conf.py                    | 39 +++++++++++++++++++++-
 include/hw/boards.h             | 58 +++++++++++++++++++++------------
 4 files changed, 89 insertions(+), 25 deletions(-)

-- 
2.49.0


