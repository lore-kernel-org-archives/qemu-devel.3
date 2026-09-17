Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1F7C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ecc-0005ud-To; Thu, 17 Sep 2026 12:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcG-0005pI-Ne
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcA-0006qY-PQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vsK008jneCPOWTLQgm33Ub5Z02WevHXo6MuuyRtYqgU=;
 b=Ph11NEa2l/k+zUmtEK+SmvfFOM1GRo69YDkZGJ5tZZeZ0hktsXpLx7xd8ypt5pDHUWSLcn
 CVKkitXafPxm9/dfFTBZlKQH0Md3heH8eBGowpAUrwl1oWGbv3n0Vz3FCKrmGw4YPCah7N
 kIlHcwvQSeVj2cvxDq+QNLMBxPRKKUE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-AMnvnH95P0mwGs93wX8kIA-1; Thu,
 17 Sep 2026 12:05:29 -0400
X-MC-Unique: AMnvnH95P0mwGs93wX8kIA-1
X-Mimecast-MFC-AGG-ID: AMnvnH95P0mwGs93wX8kIA_1789661128
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7E918C1074
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 16:05:28 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E3CD30002D5; Thu, 17 Sep 2026 16:05:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 00/14] QOM security status patches
Date: Thu, 17 Sep 2026 17:05:11 +0100
Message-ID: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:

  Merge tag 'pull-loongarch-20260917' of https://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to f49f267664ac9a681ab19c1790cc3d75a1723790:

  machine: add helpers for declaring secure/insecure machine types (2026-09-17 17:00:44 +0100)

----------------------------------------------------------------
Merge support for recording & reporting object security status

* '-compat' gains a new option 'insecure-types=reject|warn|accept'
* '-device help', '-accel help' and '-machine help' report
  security status of their objects
* 'qom-list-types' can filter and report on security status of types
* 'query-machines' can report on security status of machines
* Adding macros for defining secure machine types

----------------------------------------------------------------

Daniel P. Berrangé (14):
  qom: add tracking of security state of object types
  qapi: add 'insecure-types' option for -compat argument
  qom: add helper API for checking object class security policy
    compliance
  system: check security for accelerator types
  system: report acclerator security status in help output
  system: check security for machine types
  system: report machine security status in help output
  system: check security of device types
  system: report device security status in help output
  hw/core: report security status in query-machines
  qom: refactor data passing for QOM list filtering
  qom: report & filter on security status in qom-list-types
  docs: expand security docs with info about security status
  machine: add helpers for declaring secure/insecure machine types

 docs/system/security.rst     | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/bananapi_m2u.c        |  2 +-
 hw/arm/cubieboard.c          |  2 +-
 hw/arm/imx8mm-evk.c          |  2 +-
 hw/arm/integratorcp.c        |  2 +-
 hw/arm/mcimx7d-sabre.c       |  2 +-
 hw/arm/orangepi.c            |  2 +-
 hw/core/machine-qmp-cmds.c   |  1 +
 hw/ppc/pegasos.c             |  3 ++-
 include/hw/core/boards.h     | 25 ++++++++++++++++++++-----
 include/hw/i386/pc.h         | 11 ++++++++++-
 include/qapi/compat-policy.h |  5 +++++
 include/qom/object.h         | 26 ++++++++++++++++++++++++++
 qapi/compat.json             | 23 ++++++++++++++++++++++-
 qapi/machine.json            |  8 +++++++-
 qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
 qapi/qom.json                | 13 +++++++++++--
 qom/object.c                 | 16 ++++++++++++++++
 qom/qom-qmp-cmds.c           | 35 +++++++++++++++++++++++++++++------
 rust/qom/src/qom.rs          |  4 ++++
 system/qdev-monitor.c        |  7 +++++++
 system/vl.c                  | 30 +++++++++++++++++++++++++-----
 tests/qtest/fuzz/qos_fuzz.c  |  3 ++-
 23 files changed, 259 insertions(+), 29 deletions(-)

-- 
2.55.0


