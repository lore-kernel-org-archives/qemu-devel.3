Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E4DCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRRV-0004Ho-GB; Fri, 22 May 2026 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wQRRT-0004HO-Nh; Fri, 22 May 2026 11:05:39 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wQRRR-0004kp-Sq; Fri, 22 May 2026 11:05:39 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id 755201520E21;
 Fri, 22 May 2026 17:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1779462334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UUTag9HvdlPL3MrFAG+raF9ZGv4eIQMJAmZjVcq+JWg=;
 b=eR1UN/1PXNmPRtAp2vp7WS/0VByix7M9OE/NU4cGwqiOlbLvBtPz+hARiuP/cmNBQoPRb5
 SNkFDB8gqocVKC7XOmLmw3Lx/JEOavs5kJhqOS1Ax4QouR9AhpRj/FBEwXcYVY2+JJ7Mxf
 rPw3OCXGLxo7LuAYhLUX4/cQxGxlTea+mmZXEDCdx+8qgGo3/OJZSfz3gKkJgb7sPJ2+vT
 XynrJm9223z+JeqEHzSLpgovpKoA+oNqL1yBqNp6728gXP0v8PhizDdB943oB/SBicghNw
 7vfclJOrbagNJOJZirKqqc3llq4Liuzul6dqbMKLTSwyO2YEYfMcCHuaxVWLTQ==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v4 0/1] qcow2: add a way to repair bitmaps
Date: Fri, 22 May 2026 17:05:23 +0200
Message-ID: <20260522150524.855403-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
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

A v4 version of the patch.

- Dropped fixed_list and now removes corrupt bitmaps from the list via QSIMPLEQ_REMOVE
- We don't need to count the valid bitmaps, just know if the list was changed, so s/valid_bitmaps/bitmap_modified/
- update_ext_header_and_dir handles empty QSIMPLEQ and NULL the same way, so avoid the overhead of creating an empty QSIMPLEQ
- update_ext_header_and_dir modifies s->nb_bitmaps, so we can use that for # of corruptions fixed

Thanks
Jean-Louis

Jean-Louis Dupond (1):
  qcow2: add functionality to repair bitmaps

 block/qcow2-bitmap.c   | 38 +++++++++++++++++++++++++++++++++++++-
 block/qcow2-refcount.c |  3 ++-
 block/qcow2.c          | 16 ++++++++++++----
 block/qcow2.h          |  3 ++-
 4 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.54.0


