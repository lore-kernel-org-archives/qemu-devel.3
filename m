Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15279CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESSc-0002pD-N7; Thu, 30 Oct 2025 09:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSY-0002oY-Nb
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vESSO-00041w-Ut
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761829965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4QvlVAO7SRJEquwGK1M0Z1RIJtthDovYu1Y+yqBxGAA=;
 b=S/twMkierm5WtSQ1TXXA8qmK23RfQT87M+ThXLzFGyyE8M5UZneCrhsGCVDfhfZD3gcQgF
 7hsTfheuanNcKfA2VUmL7aoydDosuS4SLdVG/mSTuxi6fsnp55zgKKS6dfBaetnprpLDas
 U8vK+e0Bs2ZM4JI7+0DWrL6VxY/reLs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-v3btXLklOCOPkLwnNdZ_WA-1; Thu,
 30 Oct 2025 09:12:43 -0400
X-MC-Unique: v3btXLklOCOPkLwnNdZ_WA-1
X-Mimecast-MFC-AGG-ID: v3btXLklOCOPkLwnNdZ_WA_1761829962
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77ECF1956078; Thu, 30 Oct 2025 13:12:42 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.177])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC09019560A2; Thu, 30 Oct 2025 13:12:40 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] Misc QGA improvements and fixes (2025-10-30)
Date: Thu, 30 Oct 2025 15:12:34 +0200
Message-ID: <20251030131237.181588-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-10-30

for you to fetch changes up to c5b4afd4d56e9c2251e6674d8c9ae530a923ecb9:

  qga: Support guest shutdown of BusyBox-based systems (2025-10-30 14:52:57 +0200)

----------------------------------------------------------------
qga-pull-2025-10-30

----------------------------------------------------------------
Fiona Ebner (1):
      scripts/qemu-guest-agent/fsfreeze-hook: improve script description

Rodrigo Dias Correa (1):
      qga: Support guest shutdown of BusyBox-based systems

minglei.liu (1):
      qga: Improve Windows filesystem space info retrieval logic

 qga/commands-posix.c                   | 29 +++++++++++++++++++++++++++++
 qga/commands-win32.c                   | 18 +++++++++---------
 scripts/qemu-guest-agent/fsfreeze-hook | 13 +++++++------
 3 files changed, 45 insertions(+), 15 deletions(-)


--
2.51.1.dirty


