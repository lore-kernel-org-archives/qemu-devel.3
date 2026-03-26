Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686A0106F312
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gtp-0000ps-DG; Thu, 26 Mar 2026 05:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gtl-0000nx-S9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:21:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gtk-0000Ks-2P
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:21:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so9422615e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quobyte.com; s=google; t=1774516862; x=1775121662; darn=nongnu.org;
 h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HieXZL5piOqwNT+BgcNMrHvOisMf+bvhJjQFWY3kJhA=;
 b=2ocIbG3p9DB5wPk+GbbTmwRJUPNdYzafGEfDiN4oxmmv8qwiwueRhcX0gBKa2cSKOJ
 rigQD9J8YW4JZcYB5wi+4TYnib5K2TjgBlv2MLRr5p266Q9MODqHLbjgszqEbXVIZIX+
 VGwZywzN9icAxc0SqVhvEBsycKr2gxyIoAZOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774516862; x=1775121662;
 h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HieXZL5piOqwNT+BgcNMrHvOisMf+bvhJjQFWY3kJhA=;
 b=k/1q7mXh3HotCFv/ovHqBAZ8pt+l6bKiP7GNzQFm5Y0gvuksjrZY1PBUlKC91tH0px
 mVT4eSOxcJnoALJiaUklVtnP7UBZvH0TBfnJcdKJ0ctikl9xEW7/5QBX9xFUs8NQIgTW
 JnAC1jr81jG3EqKBY7wJVyl007c2bw3Zp26i59JIu9FuBEf9N/S5yZdkcDW0vyfBpeKR
 I3A81uLVGJuBQcFeiCQiFk5obsQuSFjQN1WeMCWtZqkgYnH7e+UiKkFMn5BMLcvRumkt
 tNeHm11CCTvnNj3ZZxVWJ+KR6BdkPrVPmwDWGIltfs6FOmUY9LAmXhR+GTEcb6NUXvdH
 jVYw==
X-Gm-Message-State: AOJu0Yyivw8zyhll+Lm/rOiKFXgqwHbT5bbkM9qZMSgN7c6QedMQUwWM
 xHulSbQKALwmTe9CMpzEiCumVvLuWTdKz6Hcks5SgazXabWcnXl89Qykc4mZoC6YtdQbuEf5UHN
 Q89YL+DxuZO1hl+MIeZnoBKw77BGhSf+/GRebv55HCT+2FGVdTOb3pK5IFriSGh6EpMQt
X-Gm-Gg: ATEYQzwYxuimMy83M59kpq3jUTp1MaMJoNxoHK2Gt/tv0EWOZPJv29EHpbMjsorTqWH
 qog0WgTt9S2fKToqyesrooCCYZxZSKvCoszjddDJQtfUvqnF3G6RID1vpAUqYrQp/C1JfTlWkQy
 W1yEN6VQj6wOzgKA3AF4HwKr0hOw1q/aDqbbm5FZa5oojzaPR5XW7mSiPOdiZbCTaPnqviVoqTu
 G5nKXfpkpUfWNTCztC8NpvswGnjfVzUXsVFzX8q4zivaFBR8JCQr1R6mK0DxxasNCC/2yFY7xXm
 h9k5l7TCbwzitJuctMxt1LI01t64ZMOJfDsZISLnpcdRy5EAqlpEDIuJbuc//OzzVGrd21d/q6Q
 Iit5cmPNmQMq5tv3H5aQT8GxkN+ZjaFG/nTVv4q8uYcpfH5F2X+zPkzvJWQpmjw8RuBP4sZNrE8
 Rui65fbaXTwk+AhIXgdTGN8WLnYc3vWSn2Qr/X1nke4XqIgELhgpJkLC+BZPPwk4gCEeekYcqHt
 h/9xsFOx3m+dFHTuEZ+ei5NjbUZ0fMzYAQwtBMLi40tZ/XMfkrmxw5zuds=
X-Received: by 2002:a05:600c:3484:b0:485:5ba3:37d8 with SMTP id
 5b1f17b1804b1-48715fd4649mr92903385e9.5.1774516862308; 
 Thu, 26 Mar 2026 02:21:02 -0700 (PDT)
Received: from kaisers.corp.quobyte.com ([24.134.167.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9506dsm16474295e9.7.2026.03.26.02.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:21:01 -0700 (PDT)
From: Silvan Kaiser <silvan@quobyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 pierrick.bouvier@linaro.org, eblake@redhat.com, armbru@redhat.com,
 Silvan Kaiser <silvan@quobyte.com>
Subject: [PATCH 3/3] tests/qemu-iotests: Add test 315 for locking=posix
Date: Thu, 26 Mar 2026 10:19:48 +0100
Message-ID: <20260326091948.194529-4-silvan@quobyte.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091948.194529-1-silvan@quobyte.com>
References: <20260326091948.194529-1-silvan@quobyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=silvan@quobyte.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Silvan Kaiser <silvan@quobyte.com>
---
 tests/qemu-iotests/315     | 88 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/315.out |  7 +++
 2 files changed, 95 insertions(+)
 create mode 100755 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out

diff --git a/tests/qemu-iotests/315 b/tests/qemu-iotests/315
new file mode 100755
index 0000000000..9ccc4b0439
--- /dev/null
+++ b/tests/qemu-iotests/315
@@ -0,0 +1,88 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test image locking with locking=posix
+#
+# Unlike 'locking=on', which prefers OFD locks and falls back to POSIX
+# with a warning, 'locking=posix' explicitly forces the use of POSIX
+# locks without any warning.  This test verifies that:
+#   - locking=posix does not emit a fallback warning
+#   - locking=posix actually applies POSIX locks on the image
+#
+# The lock check uses qemu-storage-daemon opening the image via the
+# 'file' protocol driver directly (no format layer on top), because
+# POSIX locks are per-process and are silently released when any fd to
+# the same inode is closed -- which happens during qcow2 initialisation
+# inside a full QEMU instance.
+#
+# Copyright 2026 Quobyte Inc
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# creator
+owner=silvan@quobyte.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    if [ -f "$TEST_DIR/qsd.pid" ]; then
+        kill -SIGTERM "$(cat "$TEST_DIR/qsd.pid")" 2>/dev/null
+        rm -f "$TEST_DIR/qsd.pid"
+    fi
+    rm -f "$SOCK_DIR/qsd-315.sock"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+size=32M
+
+_make_test_img $size
+
+# locking=posix is an explicit choice, not a fallback, so the
+# "falling back to POSIX file locks" warning must never appear,
+# regardless of whether OFD locking is available on this host.
+echo "Checking that locking=posix does not warn about OFD fallback"
+if $QEMU_IMG info --image-opts \
+        "driver=file,locking=posix,filename=$TEST_IMG" 2>&1 |
+    grep -q 'falling back'; then
+    _fail "FAIL: unexpected fallback warning with locking=posix"
+fi
+echo "OK: no fallback warning"
+
+# Use qemu-storage-daemon with driver=file (no format layer) to hold the
+# image open with locking=posix, then verify POSIX locks appear in
+# /proc/locks.  A format layer (e.g. qcow2) would trigger internal fd
+# reopen operations that silently release POSIX locks, so we bypass it.
+echo "Checking that locking=posix applies POSIX locks on the image"
+$QSD \
+    --blockdev "driver=file,node-name=file0,filename=$TEST_IMG,locking=posix" \
+    --nbd-server "addr.type=unix,addr.path=$SOCK_DIR/qsd-315.sock" \
+    --export "type=nbd,id=exp0,node-name=file0,writable=on" \
+    --daemonize --pidfile "$TEST_DIR/qsd.pid"
+
+INODE=$(stat -c %i "$TEST_IMG")
+if grep -q "POSIX.*:${INODE} " /proc/locks; then
+    echo "OK: POSIX locks present on image"
+else
+    _fail "FAIL: no POSIX locks found on image"
+fi
+
+kill -SIGTERM "$(cat "$TEST_DIR/qsd.pid")"
+rm -f "$TEST_DIR/qsd.pid" "$SOCK_DIR/qsd-315.sock"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/315.out b/tests/qemu-iotests/315.out
new file mode 100644
index 0000000000..e90082fc64
--- /dev/null
+++ b/tests/qemu-iotests/315.out
@@ -0,0 +1,7 @@
+QA output created by 315
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
+Checking that locking=posix does not warn about OFD fallback
+OK: no fallback warning
+Checking that locking=posix applies POSIX locks on the image
+OK: POSIX locks present on image
+*** done
-- 
2.47.3


-- 
Quobyte GmbH, Berlin, AG Charlottenburg HRB 149012 B, Dr. Felix Hupfeld, 
Dr. Bjoern Kolbeck

