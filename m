Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E23C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 18:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHeE-0002Ax-Pd; Mon, 18 Mar 2024 14:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmHeD-0002A3-RE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmHe9-0003j0-8N
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 14:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710786219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3Rq8qA9wFTOqwueklBZgafNhF22LkdA+IQy8uPN2odU=;
 b=jFZE+uzqJBgCR3FBenuqa4H/0k7nedgc8aZhb0RFEil6m4p/cV02gw6jEb8MXwd3UPA7po
 XysG1IYCJjv00iQNEm46cw5pqqDM3ctc0aqo0YCcby1nG7KD2ie6LhKuZssVPrYrzt10Gb
 aqNo0jvx09UASrmAGLbsbIWZ1K2QuBE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Xe5Rgf9CNFOEXoSHey0nUg-1; Mon, 18 Mar 2024 14:23:37 -0400
X-MC-Unique: Xe5Rgf9CNFOEXoSHey0nUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 000D08007C0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 18:23:36 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 751B917B3A;
 Mon, 18 Mar 2024 18:23:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/3 for 9.0] Fix TLS support for chardevs and incoming data
 loss on EOF
Date: Mon, 18 Mar 2024 18:23:27 +0000
Message-ID: <20240318182330.96738-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This fixes a problem with TLS support on chardevs that Thomas has
previously attempted to deal with:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg06915.html

Unfortunately that fix caused unexpected side effects that resulted
in premature termination of the TLS connection. See patch 2 for
details.

I've since identified the root cause of the problem that Thomas was
trying to fix - bad assumptions about GSource 'prepare' functions
always being run. See patch 3 for details.

Patch 3 re-exposed a bug we've know about for a while whereby incoming
data on chardevs is sometimes discarded when POLLHUP is reported at the
same time. This required patch 1 to be applied before doing the revert
in patch 3, otherwise test-char would now very frequently fail.

So we get 2 bug fixes for the price of one :-)

Daniel P. Berrangé (3):
  chardev: lower priority of the HUP GSource in socket chardev
  Revert "chardev/char-socket: Fix TLS io channels sending too much data
    to the backend"
  Revert "chardev: use a child source for qio input source"

 chardev/char-io.c     | 55 +++++++++++++++++++++++++++++++++++++++----
 chardev/char-socket.c | 22 ++++++++++++++---
 2 files changed, 69 insertions(+), 8 deletions(-)

-- 
2.43.0


