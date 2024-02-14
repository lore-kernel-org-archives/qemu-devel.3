Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0611C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 06:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra94G-0002rU-DW; Wed, 14 Feb 2024 01:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ra942-0002pu-4m
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ra93n-0003P2-8s
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707893278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lv5jrriubJogr3r0uXogdeQ4DPY7g5NpUD3NT/U4MEs=;
 b=SmTeeCq8h+f2UBho57mXzn8CSoa8Maj5HZiaIyHG5VWt2KBY+Q7TcVDV9S4N7gEYrK3x5G
 GqDVsfNstj1roPdTFZBYUalfcerZslVXkDEpvXMxgDS2/bnEtwrGNicsXqA8GPmQpgQQtd
 lEr5M4lhfKnDmi/wHjGYRTYnYDbV4tg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-tgwJuiLdOGiHBCW3WaIEbw-1; Wed, 14 Feb 2024 01:47:55 -0500
X-MC-Unique: tgwJuiLdOGiHBCW3WaIEbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEDF983B821;
 Wed, 14 Feb 2024 06:47:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D5C51BDB1;
 Wed, 14 Feb 2024 06:47:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A6DF21E66D0; Wed, 14 Feb 2024 07:47:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL v2 0/4] Character device backend patches for 2024-02-12
Date: Wed, 14 Feb 2024 07:47:45 +0100
Message-ID: <20240214064749.1060107-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

I offered Marc-André to do this pull request, and he accepted.

The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa0296c:

  Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-09 11:22:20 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-char-2024-02-12-v2

for you to fetch changes up to b04c12282b33e81ba29b54dd001667f5c4002252:

  qapi/char: Deprecate backend type "memory" (2024-02-14 07:45:08 +0100)

----------------------------------------------------------------
Character device backend patches for 2024-02-12

----------------------------------------------------------------
Markus Armbruster (4):
      chardev/parallel: Don't close stdin on inappropriate device
      tests/unit/test-char: Fix qemu_socket(), make_udp_socket() check
      qapi/char: Make backend types properly conditional
      qapi/char: Deprecate backend type "memory"

 docs/about/deprecated.rst |  8 ++++++++
 qapi/char.json            | 28 +++++++++++++++++-----------
 include/qemu/osdep.h      |  9 ++++++++-
 chardev/char-parallel.c   |  7 +++++--
 tests/unit/test-char.c    | 31 +++++++++++++++++++++++++++++--
 chardev/meson.build       |  4 +---
 6 files changed, 68 insertions(+), 19 deletions(-)

-- 
2.43.0


