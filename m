Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C7CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2eV-0000Lj-Ty; Mon, 01 Sep 2025 07:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eB-0000F1-VV
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2e9-00065G-AJ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Efo6+uvgkAvzw0I3vbA0P9FCri5WFXlT1OqOChk/mAY=;
 b=av9nLG5XFZbZPm4IVgGFlCRP6H/cLiy4gK+0aOvmbmWlymSVnPmdMV8VEjCzbU8GfNyIVI
 hriJojDvbd+nCegC9d5fCaOgCRbUFa1BdT6ADyxRuSuWi+iw06GlFr5S2HB9SZev2y8N5r
 ogqdXCuFGPzzTYmlk+H5UCSVkc+rwH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-YvHNjSgCPViIhrEEmhayCw-1; Mon,
 01 Sep 2025 07:24:19 -0400
X-MC-Unique: YvHNjSgCPViIhrEEmhayCw-1
X-Mimecast-MFC-AGG-ID: YvHNjSgCPViIhrEEmhayCw_1756725858
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A921F1800286; Mon,  1 Sep 2025 11:24:18 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 963CF1800446; Mon,  1 Sep 2025 11:24:16 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 0/9] Misc QGA fixes for 2025-08-29
Date: Mon,  1 Sep 2025 14:24:04 +0300
Message-ID: <20250901112413.114314-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

The following changes since commit e771ba98de25c9f43959f79fc7099cf7fbba44cc:

  Open 10.2 development tree (2025-08-26 14:10:25 -0400)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-08-29-v2

for you to fetch changes up to 28c5d27dd4dc4100a96ff4c9e5871dd23c6b02ec:

  qga: Fix truncated output handling in guest-exec status reporting (2025-09-01 14:02:18 +0300)

----------------------------------------------------------------
qga-pull-2025-08-29-v2


v2 -> v1: Fix author of commit
v1: https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04615.html

----------------------------------------------------------------
Denis V. Lunev (1):
      qga: fix potentially not initialized nr_volumes in qga_vss_fsfreeze()

Kostiantyn Kostiuk (6):
      qga-vss: Replace asserts with condition and report error
      qga-vss: Remove unused dependencies
      qga: Fix channel initialization check in run_agent_once
      qga: ignore channel_init() fail if 'retry_path' is set
      qga-vss: Write hex value of error in log
      qga/installer: Remove QGA VSS if QGA installation failed

Thomas Huth (1):
      qga: Fix ubsan warning

minglei.liu (1):
      qga: Fix truncated output handling in guest-exec status reporting

 qga/commands-linux.c        | 10 +++++-----
 qga/commands.c              |  6 ++++--
 qga/installer/qemu-ga.wxs   | 23 +++++++++++++++++++++--
 qga/main.c                  | 10 +++++++---
 qga/vss-win32.c             |  2 ++
 qga/vss-win32/meson.build   |  4 +---
 qga/vss-win32/requester.cpp | 24 +++++++++++++++++++-----
 7 files changed, 59 insertions(+), 20 deletions(-)

--
2.50.1


