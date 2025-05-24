Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274E9C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmP-0007ya-8s; Sat, 24 May 2025 13:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmM-0007yJ-FM
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmK-0000fu-C9
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=byUOXe8VwAUSQArOqwNd3ereEs2i5qTgip2wOvJ7d8k=;
 b=dokUHbI9xZ07FrCoZcDHcK245P4SxZ17vK9Enfng44qzRpH2iZbfAnxqwB0GdfzzedZLFO
 5Pr1WOHjQ9KHWnLl0Nw5g2N3JLOKa3MZgh+jKeP7dTMTpROK5Kud7J9SiHiITQUQMRQhCo
 jnVxdR1TIm0HKQsNU6ICb1Ow1Hu20kw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-b3bkYeb9Ohy-Lj4dHi6peA-1; Sat,
 24 May 2025 13:35:18 -0400
X-MC-Unique: b3bkYeb9Ohy-Lj4dHi6peA-1
X-Mimecast-MFC-AGG-ID: b3bkYeb9Ohy-Lj4dHi6peA_1748108118
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E392F19560A1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:17 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56C1430001A1; Sat, 24 May 2025 17:35:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 00/19] Ui patches
Date: Sat, 24 May 2025 19:34:53 +0200
Message-ID: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 668df86ee8076152320345d8e36be7c95ec0a09a:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-05-23 09:26:29 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to f05e1a93f48729b568fdf86a12d56ee142cee5e1:

  ui/gtk-egl: Render guest content with padding in fixed-scale mode (2025-05-24 17:04:09 +0200)

----------------------------------------------------------------
UI-related

- vdagent migration support
- gtk: improve scale handling

----------------------------------------------------------------

Marc-André Lureau (10):
  ui/gtk: warn if setting the clipboard failed
  ui/clipboard: use int for selection field
  ui/clipboard: split out QemuClipboardContent
  ui/clipboard: add vmstate_cbinfo
  ui/clipboard: delay clipboard update when not running
  ui/vdagent: replace Buffer with GByteArray
  ui/vdagent: keep "connected" state
  ui/vdagent: factor out clipboard peer registration
  ui/vdagent: add migration support
  ui/vdagent: remove migration blocker

Weifeng Liu (9):
  ui/gtk: Document scale and coordinate handling
  ui/gtk: Use consistent naming for variables in different coordinates
  gtk/ui: Introduce helper gd_update_scale
  ui/gtk: Update scales in fixed-scale mode when rendering GL area
  ui/sdl: Consider scaling in mouse event handling
  ui/gtk: Don't update scale in fixed scale mode in gtk-egl.c
  ui/gtk: Consider scaling when propagating ui info
  ui/gtk-gl-area: Render guest content with padding in fixed-scale mode
  ui/gtk-egl: Render guest content with padding in fixed-scale mode

 include/ui/clipboard.h   |  31 +++--
 include/ui/egl-helpers.h |   4 +-
 include/ui/gtk.h         |   2 +
 ui/clipboard.c           |  66 ++++++++++-
 ui/egl-helpers.c         |  10 +-
 ui/gtk-clipboard.c       |  13 ++-
 ui/gtk-egl.c             |  58 ++++++---
 ui/gtk-gl-area.c         |  53 +++++++--
 ui/gtk.c                 | 245 +++++++++++++++++++++++++++------------
 ui/sdl2-gl.c             |   2 +-
 ui/sdl2.c                |  20 +++-
 ui/vdagent.c             | 205 +++++++++++++++++++++++++++-----
 12 files changed, 561 insertions(+), 148 deletions(-)

-- 
2.49.0


