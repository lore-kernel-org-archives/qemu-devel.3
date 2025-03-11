Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357ABC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxDM-0006mw-Nv; Tue, 11 Mar 2025 06:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxDL-0006mW-Fd
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:51:59 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxDH-0004eN-TO
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=IM2hNutyzqUwDOpFM/g3FqExXHiRDwYUwzNKSQiFeE0=; b=jARRwUU1i0wD/pRV6UtPj51+57
 dR1RsgcRfU+NffGCIAA6YkIZIW4ONLW119jI5ULWxlXnvaugq7iR+19ZUWWmO5dBimYaPtfOTEaRz
 CddQtPjrIa4dtDQzOosbLRzXRlp6IkfbUem6cP6zfy2KWmzcWDJbEhlyaB8VmHzq06vHrGCrnq23w
 RIt4zBuRx0dgFGyPOJrJF+M5AxGYdgBf5mUqyvg790I+JtKdAHKtDFGXlTFWbbrCwigWPTLPyyl8/
 yxAubGcNTFebtvnaYOjfi4yjbCqPYomq9pNQUn1IIxDTdGCgYh9jqo09z5xB5eWHKU2nevSCTditd
 4yNlkk5Gal3G46ZT4Sb+j+GnHZxgL+qtHn3a9TmnLoUkyufx9cFEXmJHQgzealX+qZyjCkWG1sCUP
 STSuZe3XYcxK4K5quT/PR7UZpg+JeQOE/3QJ84mO9oc2TwyZI/q7HrQZ8xwg0OLMds5tKqiK6frMH
 sg2+ovFbaRBrf0H/ioyZ6VafOPpsHNbOn650VAKC7swPLU+Yk7QIDq84yL0TBhS8f1M/ZRMIKvZEo
 5ujUTWIRF3FYVUKUzPTtwn8BWHSUYSpNztDLVPHCaAyxYrE9/WwFsFwWcPqPcNNGCQZLNrB/aYYNv
 6l50bwCb8ffVUxVpGI65Pm4Wvglp0aqZKCgkrTFgg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/4] 9pfs: Fix ftruncate-after-unlink
Date: Tue, 11 Mar 2025 11:51:50 +0100
Message-ID: <3436766.7mbngL4j9h@silver>
In-Reply-To: <20250310171101.138380-1-groug@kaod.org>
References: <20250310171101.138380-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Monday, March 10, 2025 6:10:57 PM CET Greg Kurz wrote:
> QEMU 9.2 already fixed the long standing limitation of failing fstat() on
> unlinked files. This series does something similar for ftruncate().
> 
> The following program can be straced inside the guest with a shared fs in
> passthrough mode over 9p2000.L.
> 
> int main(void)
> {
> 	struct stat st;
> 	int fd = creat("./foo", 0000);
> 
> 	ftruncate(fd, 100);
> 	unlink("./foo");
> 	ftruncate(fd, 1000);
> }
> 
> Before :
> 
> creat("./foo", 000)                     = 3
> ftruncate(3, 100)                       = -1 EACCES (Permission denied)
> unlink("./foo")                         = 0
> ftruncate(3, 1000)                      = -1 ENOENT (No such file or directory)
> 
> After :
> 
> creat("./foo", 000)                     = 3
> ftruncate(3, 100)                       = 0
> unlink("./foo")                         = 0
> ftruncate(3, 1000)                      = 0
> 
> Christian,
> 
> I'm not familiar enough with the latest changes to write a proper test
> for this case and I don't have enough cycles to learn. I'm sorry for that
> but I guess it will be a lot easier for you and I'll review.

With the following test client patch applied:

  https://lore.kernel.org/all/E1trx7R-002JEJ-0l@kylie.crudebyte.com/

then something like this should do it:

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f515a9bb15..d15721e4b2 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -736,6 +736,12 @@ static void fs_use_after_unlink(void *obj, void *data,
         .data = buf
     }).count;
     g_assert_cmpint(count, ==, write_count);
+    tsetattr({ /* truncate file to (arbitrarily chosen) size 2001 */
+        .client = v9p, .fid = fid_file, .attr = (v9fs_attr) {
+            .valid = P9_SETATTR_SIZE,
+            .size = 2001
+        }
+    });
 }
 
 static void cleanup_9p_local_driver(void *data)

/Christian

> Cheers,
> 
> --
> Greg
> 
> Greg Kurz (4):
>   9pfs: local : Introduce local_fid_fd() helper
>   9pfs: Don't use file descriptors in core code
>   9pfs: Introduce ftruncate file op
>   9pfs: Introduce futimens file op
> 
>  fsdev/file-op-9p.h |  5 +++++
>  hw/9pfs/9p-local.c | 49 ++++++++++++++++++++++++++++++++++------------
>  hw/9pfs/9p-synth.c | 22 +++++++++++++++++++++
>  hw/9pfs/9p-util.h  |  1 +
>  hw/9pfs/9p.c       | 21 +++++++++++++++-----
>  hw/9pfs/cofs.c     | 37 ++++++++++++++++++++++++++++++++++
>  hw/9pfs/coth.h     |  4 ++++
>  7 files changed, 122 insertions(+), 17 deletions(-)
> 
> 



