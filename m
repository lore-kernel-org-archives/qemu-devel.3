Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7966CCED62A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySEY-0002ta-Cr; Wed, 09 Oct 2024 04:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sySEX-0002tS-JS
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sySEV-0001JS-PW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728463185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PLLPhh6HTSu0AqwVb1vgVWNJ3vb1YIQnEFeXJTdL0mQ=;
 b=blEUljGNBOzSpQEUA8qsV1iE2DChV0nBw73Of70nw3cN++4TS5XO2p3LBLf2lbN5XXp/L9
 yk5uiSgiXf3xj7P6OahQ+OPmw+TDsce4NC8Pwpst0ctlGzic8qmzSLrVPy79I1WxqS4lv5
 jP1khE2iD+1/oijhyxGb6acsV6G/bXQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-eLhT_UtuPIe3VxC0SoZv8w-1; Wed,
 09 Oct 2024 04:39:44 -0400
X-MC-Unique: eLhT_UtuPIe3VxC0SoZv8w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E82F195F12F; Wed,  9 Oct 2024 08:39:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1E7F1956052; Wed,  9 Oct 2024 08:39:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/2] chardev patches
Date: Wed,  9 Oct 2024 12:39:36 +0400
Message-ID: <20241009083938.1504695-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 2af37e791906cfda42cb9604a16d218e56994bb1:

  Merge tag 'pull-request-2024-10-07' of https://gitlab.com/thuth/qemu into staging (2024-10-07 12:55:02 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/chr-pull-request

for you to fetch changes up to b74cb8761c68275240af0826086590a03a1f419d:

  chardev: add path option for pty backend (2024-10-09 12:13:05 +0400)

----------------------------------------------------------------
chardev: introduce 'reconnect-ms' and deprecate 'reconnect'
chardev: add path option for pty backend

----------------------------------------------------------------

Daniil Tatianin (1):
  chardev: introduce 'reconnect-ms' and deprecate 'reconnect'

Octavian Purdila (1):
  chardev: add path option for pty backend

 docs/about/deprecated.rst     |  6 +++++
 qapi/char.json                | 44 ++++++++++++++++++++++++++++++++---
 include/chardev/char-socket.h |  2 +-
 chardev/char-pty.c            | 33 ++++++++++++++++++++++++++
 chardev/char-socket.c         | 33 +++++++++++++++++++-------
 chardev/char.c                |  8 +++++++
 qemu-options.hx               | 33 +++++++++++++++++++++-----
 7 files changed, 140 insertions(+), 19 deletions(-)

-- 
2.47.0


