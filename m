Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105FD0E6EE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNttU-0004EC-EP; Tue, 25 Nov 2025 09:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vNtrd-0003Tb-Gx
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vNtrX-0001RE-It
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764080257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l/qgUWSnRlbL2QUhXfjS90ZVvYL4cI0gm0qxYaxDgLc=;
 b=KjYPIjBAnqp/TmfDxOyqExItTSaILNIRkJQ2yUSwaWNpDomv9dFgXoveXFx/MiE7Zb1Itg
 NC0mfy170Hhyew42PAcOZv1EYx9CO1exlwKGn+PK1gMIZ+bQgrjHkT7S5TQCcAJtxWMr2/
 OQxkCRsgOqs/Vm9tQmqq8El4YsTbY2g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-_yZ2YTUpPgKfLmdY9njutw-1; Tue,
 25 Nov 2025 09:17:33 -0500
X-MC-Unique: _yZ2YTUpPgKfLmdY9njutw-1
X-Mimecast-MFC-AGG-ID: _yZ2YTUpPgKfLmdY9njutw_1764080252
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 818DF1954B11; Tue, 25 Nov 2025 14:17:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02820195608E; Tue, 25 Nov 2025 14:17:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/4] ui/chardev patches
Date: Tue, 25 Nov 2025 18:17:22 +0400
Message-ID: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit de074358e99b8eb5076d3efa267e44c292c90e3e:

  Merge tag 'pull-target-arm-20251124' of https://gitlab.com/pm215/qemu into staging (2025-11-24 09:03:12 -0800)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/fix-pull-request

for you to fetch changes up to 4c1646e23f761e3dc6d88c8995f13be8f668a012:

  ui/vnc: Fix qemu abort when query vnc info (2025-11-25 18:03:13 +0400)

----------------------------------------------------------------
ui/chardev fixes for v10.2

----------------------------------------------------------------

AlanoSong@163.com (1):
  ui/vnc: Fix qemu abort when query vnc info

Marc-André Lureau (1):
  ui/vdagent: fix windows agent regression

Philippe Mathieu-Daudé (1):
  chardev/char-pty: Do not ignore chr_write() failures

Vladimir Sementsov-Ogievskiy (1):
  chardev/char-file: fix failure path

 chardev/char-file.c |  4 +++-
 chardev/char-pty.c  |  2 +-
 ui/vdagent.c        | 20 ++++++++++++++------
 ui/vnc.c            |  9 ++++++---
 4 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.51.1


