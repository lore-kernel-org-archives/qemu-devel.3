Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C7BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VDq-0001Nt-K1; Tue, 30 Sep 2025 03:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDm-0001NZ-U7
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDe-0008Pc-Np
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/BG6cJ2MdL2F3EFk0gEyBTdltqZXcyQ/KvC8RD9dhTg=;
 b=gSsj/N5UELqtwXLnSaL+nm0RxQwhUoT3m7BwRu8k20etX+XupeZLb02YUIlJ0dDGkK3I7z
 e0XZbzolZhdd+rYcC0jCUqOyqnEf6OfQDbWjwhuDKxdJ3wX6BC/cEH+qFFsBlxGwTmHYBy
 GKU1WKnWIRvf7Yk2DuA/trmmaeJxx64=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-SsWwrGKLPXi5xSIo4Pp7sw-1; Tue,
 30 Sep 2025 03:56:05 -0400
X-MC-Unique: SsWwrGKLPXi5xSIo4Pp7sw-1
X-Mimecast-MFC-AGG-ID: SsWwrGKLPXi5xSIo4Pp7sw_1759218965
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDA341955EC6; Tue, 30 Sep 2025 07:56:04 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A61C1800446; Tue, 30 Sep 2025 07:56:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 richard.henderson@linaro.org
Subject: [PULL 0/5] Ui patches
Date: Tue, 30 Sep 2025 11:55:54 +0400
Message-ID: <20250930075559.133650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 9b16edec6e9a483469c789475b2065d26b52db35:

  Merge tag 'pull-ppc-for-20250928-20250929' of https://gitlab.com/harshpb/qemu into staging (2025-09-29 07:25:28 -0700)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 9163424c50981dbc4ded9990228ac01a3b193656:

  ui/icons/qemu.svg: Add metadata information (author, license) to the logo (2025-09-30 11:21:55 +0400)

----------------------------------------------------------------
UI-related

Fixes for gtk, sdl2, spice UI backends.

----------------------------------------------------------------

Marc-André Lureau (1):
  ui/spice: fix crash when disabling GL scanout on

Mohamed Akram (1):
  ui/spice: Fix abort on macOS

Nir Lichtman (1):
  ui/sdl2: fix reset scaling binding to be consistent with gtk

Thomas Huth (1):
  ui/icons/qemu.svg: Add metadata information (author, license) to the
    logo

Weifeng Liu (1):
  gtk: Skip drawing if console surface is NULL

 ui/gtk-egl.c       |  5 +----
 ui/gtk-gl-area.c   |  5 +----
 ui/sdl2.c          |  2 +-
 ui/spice-core.c    |  6 +-----
 ui/spice-display.c |  4 +++-
 ui/icons/qemu.svg  | 21 ++++++++++++++++++++-
 6 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.51.0


