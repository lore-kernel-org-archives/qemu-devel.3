Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A39606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=Mypr7WM/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWGS-0000WR-JB; Mon, 23 Nov 2026 10:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <98d19860ac1d82610490d46382299d58d8d8a784@kylie.crudebyte.com>)
 id 1xVWGP-0000W6-Bz
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:29 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <98d19860ac1d82610490d46382299d58d8d8a784@kylie.crudebyte.com>)
 id 1xVWGN-0003Nc-1h
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=CMfIFY91NxTE8Mxf0+xpvu0MzSeqS8KrFI5n24wdUpw=; b=Mypr7
 WM/xz0iCjeYTa6Ln/ZVW9BoOv5HXwk0odkGsme/MzsIT4+uMjJ4GUljBua82P7zTQJy2wV257B0OJ
 iZqWtIZhtHlea8GH+EaZorDo6ORr4xQHlXLln5vZzaGLykU/+v3O75h9mYSUtX9z7yO0MPwWxT9JK
 Pqjygd7lxkRnrzJDRzZerkDuO6AFBubOHvk232ZhaxaKCF7SW2NaVJGM8x4/7sNlhSmvm1Xj2y3ZB
 2WGPDGpQfo/TBQIa47DH4dQ4wbquVIKSRqQVDSQaT4T/QQljQiBSLsqCU9Vcn4OGPRL2munGfLt1q
 n2YpdYnk4+Q+qvW1I6RZ9oWRh2QMh507OVJhG+e1XcwTZE43on0m1dMTwyvx07mm6rTK5sByQFgAf
 7L0LPj8eSq8Z8Zt5AkCsneziQtls2pou+8lB17jUVGxpyZXs6Q+C5RHzSf73jevktoZkE9koKn8UI
 eBtoDNUeYyw6qkC0FHlPixrMz3mdUYxbh+sXF/J1Vvtn6cuJnTnmlmO6N4/G/yg6cTF/Xrgwdt5CV
 V+9h6J2l7mBV3uf6OBJj2ixeiXx2Lbyfa17sUZqUKAt6kC4a+LW8etFgMUWncbp1PCO8sIS9uKftj
 CvbhhttgNcVvmfvHXMA70tqtTTkfe3hTzlaF9/tj6+0g7AF4+FgomXgrX/xBK4=;
Message-ID: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:31:09 +0100
Subject: [PATCH 0/7] 9pfs: hardening against export root escape
 (CVE-2026-93834)
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Paolo Bonzini <pbonzini@redhat.com>,
    "Marc-André Lureau" <marcandre.lureau@redhat.com>,
    "Daniel P. Berrangé" <berrange@redhat.com>,
    Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=98d19860ac1d82610490d46382299d58d8d8a784@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

CVE-2026-93834 (fixed by fe9e30899ff) allowed guests to escape from
9p server's export root. Due to that severe impact, it is therefore
worth hardening the 9p server at relevant, affected code locations.

Core patches of this series are the following 2 patches:

 - Patch 1 hardens local_open_nofollow(), the most vulnerable place in 9p
   server for this, as this function does the actual element-wise path walk
   and openat() calls. Key change of this patch is to longer trust the passed
   path. The path is instead copied right at the beginning of the function to
   retain an immutable string so that nobody could pull the rug under our feet
   while we are then validating the path string upon that immutable path
   string, and the function would now abort QEMU process on any illegal path,
   not expected at this point, as it means server state is already corrupted.

 - Patch 6 adds a sanity check exactly at those locations in the 9p local
   backend, where a manipulated path would manifest into real filesystem
   action. This new sanity check verifies the V9fsPath object, and again aborts
   the QEMU process loudly in this case, for the same reason described above.
   
Furthermore this series adds a new 9p test suite tests/unit/test-9p-internals.c,
which checks expected behaviour of specific 9p server internal functions.

Christian Schoenebeck (7):
  hw/9pfs: local_open_nofollow(): abort on illegal FID path components
  hw/9pfs: move struct LocalData into 9p-local.h
  meson: move 9pfs-util selection to toplevel meson file
  tests/unit: add forktest.h, a forked-child run-and-verify helper
  tests/unit: add test-9p-internals.c
  hw/9pfs: local: abort on corrupt V9fsPath objects
  tests/9p-internals: test 9p's local_path_sanity_check() function

 MAINTAINERS                    |   2 +
 hw/9pfs/9p-local.c             | 117 +++++++++++++-
 hw/9pfs/9p-local.h             |   5 +
 hw/9pfs/meson.build            |   8 +-
 meson.build                    |  10 ++
 tests/unit/forktest.h          | 132 ++++++++++++++++
 tests/unit/meson.build         |  22 +++
 tests/unit/test-9p-internals.c | 270 +++++++++++++++++++++++++++++++++
 8 files changed, 554 insertions(+), 12 deletions(-)
 create mode 100644 tests/unit/forktest.h
 create mode 100644 tests/unit/test-9p-internals.c

-- 
2.47.3


