Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E82C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhgh-0000Ns-J4; Mon, 24 Mar 2025 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1twhgX-0000LE-7C
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1twhgS-0006r1-UI
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wry/aMTn3nX0muHSFlJ0I/RUKgJ963k7dzawjW+bc38=;
 b=GByyfN0vGjs8X8R0W9fRnW3DeUvY5XW/i+ys2fnv5CM6jEF/r9D1D3m44Zqx13cnBwjXWC
 mOED2UhdOxI/AG723TBQGfC0MBu7EOhORDrxdh2WUoZ9VrJH3nJaIOB2H8P5lk+CwMH2A4
 RPDNS4tCsL6ueftJiyxMBgArQZc+mt0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-KDKNYZMONKSPFwxHmwt9mA-1; Mon,
 24 Mar 2025 09:17:37 -0400
X-MC-Unique: KDKNYZMONKSPFwxHmwt9mA-1
X-Mimecast-MFC-AGG-ID: KDKNYZMONKSPFwxHmwt9mA_1742822256
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C9DC196D2D3; Mon, 24 Mar 2025 13:17:35 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.127])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3DF91956095; Mon, 24 Mar 2025 13:17:32 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Dehan Meng <demeng@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 0/2] qga: Add 'guest-get-load' command
Date: Mon, 24 Mar 2025 15:17:27 +0200
Message-ID: <20250324131729.70992-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

v1 -> v2:
  - Added comments about init_load_avg_counter
v1: https://patchew.org/QEMU/20250314113847.109460-1-kkostiuk@redhat.com/


Konstantin Kostiuk (2):
  qga-win: implement a 'guest-get-load' command
  qga: Add tests for guest-get-load command

 qga/commands-win32.c   | 148 +++++++++++++++++++++++++++++++++++++++++
 qga/guest-agent-core.h |  10 +++
 qga/main.c             |  39 +++++++++++
 qga/meson.build        |   2 +-
 qga/qapi-schema.json   |   9 ++-
 tests/unit/test-qga.c  |  17 +++++
 6 files changed, 222 insertions(+), 3 deletions(-)

--
2.48.1


