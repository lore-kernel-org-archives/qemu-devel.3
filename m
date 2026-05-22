Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935E8CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLbh-0004hb-Jj; Fri, 22 May 2026 04:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wQLbe-0004h7-PG; Fri, 22 May 2026 04:51:47 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wQLbd-0004Vs-8P; Fri, 22 May 2026 04:51:46 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id A4CEB1520E21;
 Fri, 22 May 2026 10:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1779439901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GVdO4iugPWcS3nkGUHcMUMi0eNEwWfa4yR8dvdkgN+A=;
 b=JSnqrDlMZthyDaa/QQ0rO/m1dmzJ1M4iNgCjBFJl/E2fFvoUBEX85bH/e75xw1UJGcrTmj
 faVwE7hJY+pp76GWu5eILCEtqIhDF5+Qis0CJl64FK1enIFB9eA+W0TYdAc2UvEqq/SnRk
 m09Rmp6mgNsa1Ln4hfICebm2dChKo2T8eNbcu5GllVN1xgz6jIEVoZBWnhf5z7lE8ABQrg
 m7gKMrUvBjZLHvjuXMhClbCKSxZ3WSNDhLplQnRZiHsbDVBJUQybBlOY4e6zNdsAlYjSjZ
 JtkXnJDDdne6dy3xz9HQ5ZWWnBXIto1vC77zpV9WXk0zOYCVC7oZRf6LZLWWog==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v3 0/1] qcow2: add a way to repair bitmaps
Date: Fri, 22 May 2026 10:51:27 +0200
Message-ID: <20260522085128.428672-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
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

A v3 version of the patch.

- Added a forward declaration for update_ext_header_and_dir so the function doesn't need to be moved anymore.
- Style fix of comment
- Keep s->nb_bitmaps in a variable in order to have correct corruption fixed count
- Remove obsolete if in bitmap_list_free

Thanks
Jean-Louis

Jean-Louis Dupond (1):
  qcow2: add functionality to repair bitmaps

 block/qcow2-bitmap.c   | 43 +++++++++++++++++++++++++++++++++++++++++-
 block/qcow2-refcount.c |  3 ++-
 block/qcow2.c          | 16 ++++++++++++----
 block/qcow2.h          |  3 ++-
 4 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.54.0


