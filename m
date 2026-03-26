Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D6410A88E2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n9L-0004YO-Hw; Thu, 26 Mar 2026 12:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n8z-000482-Up
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5n8r-0001gk-Jw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WiqwYtIG7tcO6QxBcfjgkfDOFEQm7B4CUCa4zGnKzo0=;
 b=DIszlAQfMpwrFAxwAwjOXwUzADWFD811HozTs9RM9Go0YkVC8a3AOklhP1NIgQ3e02+hrB
 vNp6vy5UzwualMa819AF40+81iSZytp1YawaI+qTOcVLVkxTR1CSuY3MqqNW2T1/P2m68E
 4iqEZSBNZYC475sHIFbHuC96WPgKmzw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-PfdcaHXZPTWjXGRKK3oR3A-1; Thu,
 26 Mar 2026 12:00:41 -0400
X-MC-Unique: PfdcaHXZPTWjXGRKK3oR3A-1
X-Mimecast-MFC-AGG-ID: PfdcaHXZPTWjXGRKK3oR3A_1774540840
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 491621954B08; Thu, 26 Mar 2026 16:00:40 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31BAA3000223; Thu, 26 Mar 2026 16:00:36 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH 0/7] Misc changes to allow building with Windows Clang
Date: Thu, 26 Mar 2026 18:00:26 +0200
Message-ID: <20260326160033.68318-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is the first set of changes to allow building qemu-ga with Microsoft Windows Clang.
It includes some cleanups and fixes that also make the code more portable.
The main goal is to be able to build qemu-ga with the MSVC toolchain
because MinGW-w64 is not available for ARM64 Windows.

These changes were tested on CentOS Stream, Arch Linux, FreeBSD, NetBSD.
Full QEMU tree was compiled without any issues on all these platforms.

The full set of changes consists of about fifteen more patches.
Once that is complete, I will add documentation on how to build
qemu-ga with MSVC clang and a CI job that tests it.

Kostiantyn Kostiuk (6):
  meson: Use stddef.h instead of unistd.h
  qom: Use g_ascii_strcasecmp instead of strcasecmp
  osdep: Remove unused strings.h
  Remove unused dirent.h
  Remove unused sys/param.h
  meson: Build block_syms and qemu_syms only when enable_modules

Paolo Bonzini (1):
  storage-daemon: use same link arguments as other tools

 include/qemu/osdep.h       |  1 -
 meson.build                | 35 +++++++++++++++++++----------------
 qom/object.c               |  4 ++--
 storage-daemon/meson.build | 16 ++++++++--------
 util/drm.c                 |  1 -
 util/path.c                |  2 --
 6 files changed, 29 insertions(+), 30 deletions(-)

--
2.52.0


