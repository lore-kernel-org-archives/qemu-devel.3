Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0368DFC6160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9Ku-0006On-FM; Fri, 13 Sep 2024 12:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Kq-00068M-FF; Fri, 13 Sep 2024 12:39:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Km-0000q9-7P; Fri, 13 Sep 2024 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=potystAWMZvYnsU7EW1YLyiuakGYfGq1uqHvdujQcJ4=; b=SQNnAx1Djmjv
 ascdKNxQ977OYqfDr97T34csA/DaoMfwP6OwyRna2nxpplpD9E/qqyUS7qBwcUtPX/lrA32WPYMsR
 Exnv94oSWzpYPGZ9kB5jg9JoomiPX6X7yT6KrsIUQ0Ps8HMniXCXZqiSbc0jKaJo7lMO3O/I3e3D0
 ogbZXOzKq9CjUNqTvJDirgUfwm0GkdkAXRrXoARZ2TV/UhDPagFobnp+A1cj3L6cAcANem+X+Bypt
 t4HdPtTTIdvYALALLpfC5ivTSFdUooEWPRMlc58fsYhb7AnN487JaeskSTZXZOCzlPXZunjdjVbDm
 DrJZ9DVivVYJvtSaKm0/TA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hy-002OPf-2O;
 Fri, 13 Sep 2024 18:39:39 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 00/12] qcow2: make subclusters discardable
Date: Fri, 13 Sep 2024 19:39:30 +0300
Message-Id: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v2: https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg02396.html

v2 -> v3:
  * Added patch 12/12 "qcow2: add discard-subclusters option" which
    makes subcluster-based discards optional;
  * Added a bunch of R-b's.

Andrey Drobyshev (12):
  qcow2: make function update_refcount_discard() global
  qcow2: simplify L2 entries accounting for discard-no-unref
  qcow2: put discard requests in the common queue when discard-no-unref
    enabled
  block/file-posix: add trace event for fallocate() calls
  iotests/common.rc: add disk_usage function
  iotests/290: add test case to check 'discard-no-unref' option behavior
  qcow2: add get_sc_range_info() helper for working with subcluster
    ranges
  qcow2: zeroize the entire cluster when there're no non-zero
    subclusters
  qcow2: make subclusters discardable
  qcow2: zero_l2_subclusters: fall through to discard operation when
    requested
  iotests/271: add test cases for subcluster-based discard/unmap
  qcow2: add discard-subclusters option

 block/file-posix.c           |   1 +
 block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
 block/qcow2-refcount.c       |   8 +-
 block/qcow2-snapshot.c       |   6 +-
 block/qcow2.c                |  44 +++--
 block/qcow2.h                |   8 +-
 block/trace-events           |   1 +
 tests/qemu-iotests/250       |   5 -
 tests/qemu-iotests/271       |  74 ++++++--
 tests/qemu-iotests/271.out   |  69 ++++++-
 tests/qemu-iotests/290       |  34 ++++
 tests/qemu-iotests/290.out   |  28 +++
 tests/qemu-iotests/common.rc |   6 +
 13 files changed, 513 insertions(+), 117 deletions(-)

-- 
2.39.3


