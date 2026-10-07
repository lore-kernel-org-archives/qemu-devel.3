Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274B5CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbN-0002yK-Rc; Wed, 07 Oct 2026 12:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbE-0002vj-DD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbC-0006L2-OF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5r3uYNUveHIZig2KQjPRXbepG24d9dhnvim5UCJQY0=;
 b=AaKA9n86Y0jt6BSv5WSpb1tpRAUCUb7u3VhbKityo++vjD8iyYkuJJdt0cx7i1n5GNHLZD
 dKwTNd5qL+L4Wv6sxp1eFKKK41thZaJ5TrMyQcEEWkr6W2MsJGCku91wldOeJSWcort4hh
 oklsweD6TYlhPO+Ss7fAMtn4EO3tErQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-hwUvI5S1NEuCT4TronKLdw-1; Wed,
 07 Oct 2026 12:34:30 -0400
X-MC-Unique: hwUvI5S1NEuCT4TronKLdw-1
X-Mimecast-MFC-AGG-ID: hwUvI5S1NEuCT4TronKLdw_1791390869
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94EDB1956043; Wed,  7 Oct 2026 16:34:29 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31FD81956087; Wed,  7 Oct 2026 16:34:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/21] scripts/qemugdb: coroutine: Fix patching pt_regs in the
 coredump
Date: Wed,  7 Oct 2026 18:32:50 +0200
Message-ID: <20261007163302.332250-10-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

patch_regs() and restore_regs() open the coredump with 'ab', i.e. with
O_APPEND.  This repositions the file offset to the end of the file before
every write.  The seek() to pt_regs therefore has no effect: instead of
patching the saved registers, we just append the binary blob with patched
regs at the end of the file.

Nothing fails, and the gdb subprocess still prints a plausible backtrace.
However it's a backtrace of the crashed thread rather than of the
requested coroutine.  The .ptregs blob kept for recovery is dead for the
same reason as there's never anything to restore.

Open the file with 'r+b' so that the writes actually land where seek()
points.

Fixes: 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining detailed trace in coredump")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-6-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index da395a1a13e..4803914dde0 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -90,7 +90,7 @@ def patch_regs(self, regs):
         int_regs = {k: int(v) for k, v in regs.items()}
         patched_ptregs.update(int_regs)
 
-        with open(self.coredump, 'ab') as f:
+        with open(self.coredump, 'r+b') as f:
             gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
             f.seek(self._ptregs_offset, 0)
             gdb.write('writing regs:\n')
@@ -106,7 +106,7 @@ def restore_regs(self):
             return
 
         gdb.write(f'\nrestoring original regs in core file {self.coredump}\n')
-        with open(self.coredump, 'ab') as f:
+        with open(self.coredump, 'r+b') as f:
             gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
             f.seek(self._ptregs_offset, 0)
             f.write(struct.pack(f"={len(PT_REGS)}q",
-- 
2.56.0


