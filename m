Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09817C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBnX-0006aZ-4I; Mon, 13 Jul 2026 04:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wjBnI-0006PY-Cm; Mon, 13 Jul 2026 04:13:43 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wjBnC-0006xE-Fv; Mon, 13 Jul 2026 04:13:39 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id D999D1520B94;
 Mon, 13 Jul 2026 10:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1783930407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3gIlsEMhOSep+21QdqWXQNHq7rkSv32H3rD7FWtn5Qw=;
 b=dL8oXRqeuYT41LmS2aesA1+R/MjwqoqmTZLdHPxjjZddWY7oFh3K1IdLWEkqGAaympkxVE
 ne0RVs/xDFumljgvakdue0FAlhZ56wbtxZXCQcGgT7OChrZhz3KsUgQzXtrCxA4C9SRCEy
 HferY36SSrS/nCnua4LzMeaJQNeXDF4YbDJ7HzbEg8OXcM+RdC6k1HAwFLCJc4Of9TAC9n
 iPpiWafzTGazb4AthMDuJIqfTSXS+r6U1oCtBJjsRlnoYUZSU8woOnAezIdRrdfkQtgsqL
 unOi9NeavhVigpCAvbxwlJOlDUeSF9dFgQzaQOLj8SpWsTFxBY8PzXUdXASZKw==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v6 0/1] qcow2: add a way to repair bitmaps
Date: Mon, 13 Jul 2026 10:13:03 +0200
Message-ID: <20260713081304.84812-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A v6 version of the patch that resolves the remarks from Vladimir.

- Report the error when not in check mode
- Fix counting of corruptions and fixed corruptions

Thanks
Jean-Louis

Jean-Louis Dupond (1):
  qcow2: add functionality to repair bitmaps

 block/qcow2-bitmap.c   | 42 +++++++++++++++++++++++++++++++++++++++---
 block/qcow2-refcount.c |  3 ++-
 block/qcow2.c          | 16 ++++++++++++----
 block/qcow2.h          |  3 ++-
 4 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.55.0


