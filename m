Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB8DE7719B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsMJ-00016N-IV; Thu, 09 Jan 2025 08:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f1b91e3a33a6502be816d88dfb6b719101b69d41@kylie.crudebyte.com>)
 id 1tVsMI-000166-5M
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:13:58 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f1b91e3a33a6502be816d88dfb6b719101b69d41@kylie.crudebyte.com>)
 id 1tVsMG-0004nD-Jt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=QISezSY7oBObokWL0tL8UTCzKj4XmSnRBn+ToQwCAuE=; b=MA9hC
 lx3MpzGwiswsJAezSK/9Kwo2Xf47BtJtD2StHrmqs4YHUAzdFF6gEVWR8pbtWRFe7PdVFmLMSZtQ7
 cpoFWemYc75HaTjC1JRkxTh5M2K7fAIAevnfmMFW1TtZhppt+p6WCnGhtTfM0hMecds0o8QY37No9
 7459aaZ0od4pZWpobAfiL0d3tbd50sRSwV8f8CE9MWNGq5xIty9RwKa2zNHlm6AJBTUmHuhq+E1oQ
 AwehHVOkO6FEWShdaPhnZ6KbMv6/bO5VNihKPeWY5ICj+Jni9vVXg5nND5Dw6Q/sUbWOHebw5roK7
 T72zQTHc1tcFk4CuE/UJYi6fAwkfuYOVkC+Eryjm8YugLrKVPqF0sAhUIXQZq8ktuVLbmNxsEIMau
 w1juEAAGz6ZJH/81MMY7I0YCnZ/Q/iha/y2/j2tdP6YPpYlPQMuMRTXLLiBXjf/cky16TSHnJGXOG
 LsoLhzdM/ABU3aQVBA2keH+BnD1YAYpOOacM4ELRdqLnKfoGKbWIjikca1Dw3g3t3Y73wuzHQI+ZA
 5YSb8KtHhPtyWyf1aqk62L4C60xPwePAFMcWECV/70wQ8AYUvza2WZDiNZf5fn37TmwXka9Wd8pAc
 YS+2LTe1LqYCT3yXd+WlQ//7x06aFnmK7ULcHl0pRrr1gl1DxXNU7Z/EHvjvsM=;
Message-Id: <f1b91e3a33a6502be816d88dfb6b719101b69d41.1736427878.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1736427878.git.qemu_oss@crudebyte.com>
References: <cover.1736427878.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 9 Jan 2025 13:59:56 +0100
Subject: [PATCH 3/3] tests/9p: extend use_dir_after_unlink test with Treaddir
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

Sending a Treaddir request on an unlinked directory should also succeed
if the directory was alread opened before unlink. We just check that no
error occurs and that we get some kind of Treaddir result, but completely
ignore the actual Treaddir result content. In fact, there should be no
system as of to date that would allow a removed directory to have any
content (files, links, devices, subdirectories) and POSIX specifies that
a directory must be empty when trying to remove it from the file system.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 35c42cd0d7..10243247ab 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -772,6 +772,9 @@ static void fs_use_dir_after_unlink(void *obj, void *data,
         .client = v9p, .fid = fid_dir, .request_mask = P9_GETATTR_BASIC,
         .rgetattr.attr = &attr
     });
+    treaddir({
+        .client = v9p, .fid = fid_dir, .offset = 0, .count = P9_MAX_SIZE - 11
+    });
 }
 
 static void cleanup_9p_local_driver(void *data)
-- 
2.39.5


