Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD43C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDqw-0002V2-HX; Fri, 10 Jul 2026 12:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqq-0002SK-MG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqo-0006b4-Fw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493ba701891so9729895e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1783699996; x=1784304796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TJGSqNXeeEITi5YiFnKI3FfRbKLjBMns+gBb/y9J3j4=;
 b=GrMH/Pr67OIVAVTRxTIgF3SuaxRASi36zivGyDFwTRFfyF6tMzaPwr66eKUAta5kE2
 iyEFWKNAtiX2ucT/mh8t489nBVeHQm4MBRQbROte+0QtMZ1TyCqPhtHiAnR2BHlQtgVK
 GquKQUHckaGZRPGhJPpiSZl0rwfVXi+cCRDhZQnROOU51NprZ/9aavCMFXLxY80uC97T
 /UxXg+boy3x79bvd58EtT/BvJwwKJoXfa1TmTax+a8aaKW6D03wH3nIxmi3L7cZmLQR0
 k7R71cnKRgZdh2420qyicGH8zALR8h6egf5FL9tUg0x3Gif38TcGwkpE+QB64UNlZCyv
 s7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783699996; x=1784304796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TJGSqNXeeEITi5YiFnKI3FfRbKLjBMns+gBb/y9J3j4=;
 b=LgioVLk2hbM6mwntfnyNE+ZCJIz/kW1T7ov/IsEfa1jXztcWP4x0pRU9PPXZAC2aZg
 BLB/egmSgAUtEgWmv14id1UkISE4o4FnopcKOVT4O/IKKw59GT/hkCO9BeTk+1M3DiOZ
 crXKGlEnAxRzNJeIukPG2kI6uf3+4Uk9bc7WK08zD2okjn0BQDOOMcvPS700Si1vCOK/
 HzjB3hAmwHYK5vGoTOgSm3GeAKRr/8+VDQU0lCR6NzVSNE/uYpo+PbcENQWUdPvmpvto
 +MxuxSqrbnGc8m3qpdRLrCvZR2EsTeiD4TH4O4dgY76fshmfmpK98ed0Ok7T1DqsZY9Y
 zN7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWyfmVwEuJ+6Ey7ooYoJgTYDyiby6fKl273D9WMPuXOPtzkZapFMv9M/8y+Kt7ZH3PlMVyrRan/Nr0@nongnu.org
X-Gm-Message-State: AOJu0Yyp8NzS3keXdTTx/DJTJlb1mMab12SfSS8crU4LpJ2e/D3aXbqj
 9bSFjDmdL0YwWbLHrSnMbUXlk7yWviNtwfUud2PzgSrDJ5x5jTQdxfqRsNCdLnit/sU=
X-Gm-Gg: AfdE7ckKzoWnB+QWKyaLplhIs9otcdOpzgxs/fh7X+AHpI3JlcIXjTrXeO6LFLHerfq
 qZzMgMuhLJSLD5/YKQjhAzR4A7IPKpHhmQ7rIz8yq2hPPOrjjXz+GiHbXAD27BB40H4BFOfCQK+
 VsOAvHngQwKOTTvCnFfEmdhyUZT0g40n2hgp7adV59/Q+fW1+jEk+L/M1zzL+imIMDLT/kdm8zO
 FMWIFwLvgT0HQ6NF7FgfuHVoQOUkvKrNJ/WiuPyLQ8eKeTyOXEuMkfS+R77wqFkOLViZ532IdQq
 kVgPn4EP/KKAHbZr1fhfp4ZSee5xpcrzuvGfYSlveUtUpljPQsSo3gBg2c5Cx1IlE2TGdsor4kN
 UXrjonkzfmhZZ16Gn54MzgXhNmHuiP+NmnueUweLPLfhtijHl3I7S/gQwVtvNb0K9w71YTdZckY
 doNQ==
X-Received: by 2002:a05:6000:420b:b0:479:e2ea:3d51 with SMTP id
 ffacd0b85a97d-47df071e891mr14348151f8f.17.1783699995773; 
 Fri, 10 Jul 2026 09:13:15 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:5926:51ec:1f64:b9b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm59944836f8f.33.2026.07.10.09.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:13:15 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 2/3] iotests: skip FUSE tests when FUSE is not usable
Date: Fri, 10 Jul 2026 18:13:08 +0200
Message-ID: <20260710161309.1104712-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710161309.1104712-1-den@openvz.org>
References: <20260710161309.1104712-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

file-io-error, fuse-allow-other and fuse-mmap-shared skip only when
FUSE is not compiled in. When FUSE is built in but unusable at run
time (no /dev/fuse access, fusermount lacking permissions), the
export fails to mount with "Failed to mount FUSE session to export"
and the tests report a spurious failure instead of skipping, like
NBD tests already do for missing NBD support.

Add _notrun_on_no_fuse() to common.rc and use it in the shell tests.
fuse-mmap-shared is Python, so it gets an equivalent inline check.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 tests/qemu-iotests/common.rc              | 14 ++++++++++++++
 tests/qemu-iotests/tests/file-io-error    |  4 +---
 tests/qemu-iotests/tests/fuse-allow-other |  2 ++
 tests/qemu-iotests/tests/fuse-mmap-shared |  9 ++++++---
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 298bc483e0..62a2bc146b 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -981,6 +981,20 @@ _require_drivers()
     done
 }
 
+# Skip if FUSE is unusable: not compiled in, or the export failed to
+# mount. $1 is the failing 'block-export-add' reply.
+_notrun_on_no_fuse()
+{
+    case "$1" in
+        *"Parameter 'type' does not accept value 'fuse'"*)
+            _notrun "No FUSE support"
+            ;;
+        *"Failed to mount FUSE session"*)
+            _notrun "FUSE not usable in this environment"
+            ;;
+    esac
+}
+
 # Check that we have a file system that allows huge (but very sparse) files
 #
 _require_large_file()
diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
index fb8db73b31..3cdb41f33d 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -89,9 +89,7 @@ output=$(_send_qemu_cmd $QEMU_HANDLE \
     'return' \
     | grep -v 'option allow_other only allowed if')
 
-if echo "$output" | grep -q "Parameter 'type' does not accept value 'fuse'"; then
-    _notrun 'No FUSE support'
-fi
+_notrun_on_no_fuse "$output"
 echo "$output"
 
 echo
diff --git a/tests/qemu-iotests/tests/fuse-allow-other b/tests/qemu-iotests/tests/fuse-allow-other
index eaa39f8f23..bcba191951 100755
--- a/tests/qemu-iotests/tests/fuse-allow-other
+++ b/tests/qemu-iotests/tests/fuse-allow-other
@@ -77,6 +77,8 @@ fuse_export_add()
         _notrun "allow_other not supported"
     fi
 
+    _notrun_on_no_fuse "$output"
+
     echo "$output"
 }
 
diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared b/tests/qemu-iotests/tests/fuse-mmap-shared
index 52941a3bb6..b190105894 100755
--- a/tests/qemu-iotests/tests/fuse-mmap-shared
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared
@@ -28,9 +28,12 @@ def test_fuse_support(mount_point):
     })
     test_qsd.stop()
     if 'error' in res:
-        assert (res['error']['desc'] ==
-                "Parameter 'type' does not accept value 'fuse'")
-        iotests.notrun('No FUSE support')
+        desc = res['error']['desc']
+        if desc == "Parameter 'type' does not accept value 'fuse'":
+            iotests.notrun('No FUSE support')
+        if 'Failed to mount FUSE session' in desc:
+            iotests.notrun('FUSE not usable in this environment')
+        assert False, desc
 
 # Shared mmap when using direct IO is only supported for Linux kernels >= 6.6
 # with commit e78662e818f94 ("fuse: add a new fuse init flag to relax
-- 
2.53.0


