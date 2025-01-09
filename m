Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4185E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsM6-00014K-Oi; Thu, 09 Jan 2025 08:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f1b91e3a33a6502be816d88dfb6b719101b69d41@kylie.crudebyte.com>)
 id 1tVsM5-00013s-5U
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:13:45 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f1b91e3a33a6502be816d88dfb6b719101b69d41@kylie.crudebyte.com>)
 id 1tVsM3-0004j4-IS
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=GbOHLbIjqzojBhKVmXxsq5nhRytrHfeSfWZ4sGCY+M8=; b=sVXzJ
 t6+fBXwVKj0u+UqTdGPb2+ayZVu+W6N/80Fm/yYuut5WSm6IQSxL72irHmhCK8XnzDP5IX+bzh1wf
 DcD/6cXTQCDk7obE5433Z5KqoesL+7Gg2XAPCg6N3vluIsY5nCiC0qL6VUJjzKoTsD5c6lud/N/qt
 wM55DM2NRVw2Ws5/mncBqTJ1V3mkVFdjHUJ5dZLYPx062oBc9vzEKCtElqrsZW85Uxv3VsPjrqzwT
 qCNezzgkpevZxn54euGmKdbGxubdf4XqLP1agmkylYcOncAt+kkyy0HIkJpQ2WR0BUkSKRjWBYcyY
 m2VxY3QFJ3xxgWiGxOXg3fK+FwzCoNqrvCBEg3HtbpgfgC2oJWbx+S8N708A54H5ARXfhwD9sZ6nO
 DP3Nw+NHFluDWSgdyg2OCQzjhfiNSR8ZyKWtMTkJv4HA/0K3aWbyAeSLs4kpd4+/EvVKS7U9PFOha
 1yqza7v9MZ/nAGUvQAaZfCO/t3szrgyBozP7aGuw2m5MeRcxb3b6/s7q71vLyUvrjNFYYggNADolJ
 IcfsG5BlLCnQbNtV9WtUGjx0mDQxrNuW33gG0siXfeEAiFtBunBqlZUj9FvBf4AnIHvWreil5JZvO
 JKoADikUzPVdmGgaQIl2l9xUuwZsXbM3EkmJzpINpgzNged9b2oALjDogaJVeY=;
Message-Id: <cover.1736427878.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 9 Jan 2025 14:04:38 +0100
Subject: [PATCH 0/3] tests/9p: add use-dir-after-unlink test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=f1b91e3a33a6502be816d88dfb6b719101b69d41@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a test case that verifies that it is possible to do some basic operations
on a deleted directory if 9p client opened the directory before directory was
removed.

Unlike the previous open-unlink-fstat idiom: no fix required here. It already
works with 9p server.

Christian Schoenebeck (3):
  tests/9p: rename test use_after_unlink -> use_file_after_unlink
  tests/9p: add use_dir_after_unlink test
  tests/9p: extend use_dir_after_unlink test with Treaddir

 tests/qtest/virtio-9p-test.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

-- 
2.39.5


