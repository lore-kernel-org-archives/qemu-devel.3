Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1D6C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 13:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJBNy-0007S5-QU; Sun, 25 May 2025 09:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBNw-0007Rd-DN
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBNt-0003Jl-FI
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748179643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SWGHaEQdspEk5wJbx6CeF7C+r0jnB0xOHE5RwJMty3A=;
 b=dobxkhdIN2/5IQPTOCVHeq7bGys40Bsx1vJ3CE0uDiSi3pci8etxmmcrUzGljvvEvBOtW8
 52kld/CTttmuf5AVUxxrK4VBGvQQFEfR43E9t5W1teSQ+Jqyut3ih1gs4h1hNu0RGBNP2Y
 PjwNra6lSa6BV7YvYmpInxGk18aIvqs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-PZWnLQr-MXCRR-yfarJRRQ-1; Sun,
 25 May 2025 09:27:21 -0400
X-MC-Unique: PZWnLQr-MXCRR-yfarJRRQ-1
X-Mimecast-MFC-AGG-ID: PZWnLQr-MXCRR-yfarJRRQ_1748179641
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4BC180034E
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 13:27:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E3FE1800ECA; Sun, 25 May 2025 13:27:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/9] Audio patches
Date: Sun, 25 May 2025 15:27:07 +0200
Message-ID: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

  https://gitlab.com/marcandre.lureau/qemu.git tags/audio-pull-request

for you to fetch changes up to 2bccabe6df5e91145c1313bb79b98200aa13b5ff:

  audio: Reset rate control when adding bytes (2025-05-25 15:25:21 +0200)

----------------------------------------------------------------
Audio patches

- add float sample endianness converters
- various fixes

----------------------------------------------------------------

Akihiko Odaki (1):
  audio: Reset rate control when adding bytes

BALATON Zoltan (1):
  alsaaudio: Set try-poll to false by default

Volker Rümelin (7):
  tests/functional: use 'none' audio driver for q800 tests
  audio: fix SIGSEGV in AUD_get_buffer_size_out()
  audio: fix size calculation in AUD_get_buffer_size_out()
  hw/audio/asc: fix SIGSEGV in asc_realize()
  hw/audio/asc: replace g_malloc0() with g_malloc()
  audio/mixeng: remove unnecessary pointer type casts
  audio: add float sample endianness converters

 qapi/audio.json                      |  2 +-
 audio/audio_int.h                    |  1 +
 audio/audio_template.h               | 12 ++--
 audio/mixeng.h                       |  6 +-
 audio/alsaaudio.c                    |  2 +-
 audio/audio.c                        | 25 ++++++---
 audio/mixeng.c                       | 83 ++++++++++++++++++++++++----
 hw/audio/asc.c                       |  9 ++-
 qemu-options.hx                      |  4 +-
 tests/functional/test_m68k_q800.py   |  3 +-
 tests/functional/test_m68k_replay.py |  3 +-
 11 files changed, 119 insertions(+), 31 deletions(-)

-- 
2.49.0


