Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48279C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjwxF-00040l-6F; Wed, 15 Jul 2026 06:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwx9-0003yU-0b
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:34:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwx7-0000uk-Bk
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:34:58 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so2426993f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784111696; x=1784716496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s4zeJDdtxVbftajOrHOMfQ8V+NcJ7E3IkRzNWHPvZJQ=;
 b=ETTOMH0MdaHZJo1uFL0k5ddICSmb/BdrfdUYuCJtnTgD+K/o87TWXO9/EJo+3RmVFa
 2LgtvhG8GLN7ouNP8td6B6vGCX0v2v9d8hPnr4WS8IhRL/Xkwnd0DA+YbQbLYinH12oZ
 h74mkYJ1dqJeauG+Kd9+CYW6r7uvqeL33m1K1C+BvHG5aGylS5NhOiR1zXfnyzf/rlB6
 4s6g7legJzseb7cZPqaVJWaQN2eQ8xNZbBZyk4620Nt1nFrZtf9Jjqb9ctd8IEJvde6n
 d1QMsohCz+LOZOJ3crubNVJBj7d52KRicNFKHoDi9YJCk3+kdfhSV/EAVRr9gCxNkrW6
 bMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784111696; x=1784716496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s4zeJDdtxVbftajOrHOMfQ8V+NcJ7E3IkRzNWHPvZJQ=;
 b=bJ1yPFYJh7AUC+fxDUx1p+LPV+8Ps8pR8g+mvW88ZlXWIkO2aBrYOMIUb87E/b1Xpy
 BezNhg67xGnSJzQupyd8QKKcGJW2Mlu7EHS53+PgAXD5TUI4mMIam20lEy3lyVGYCn++
 cHkAWUFONR3eNHFr4oCkMjwf+VcQsEopDBhRyEo//ZU9bcHjn+92S2kbc/Mu/L9BgXdU
 GuZoxKDMyC7Jv7o52C+RY3TPHFzAUna200rDtLvJL0xByE7NzwIeBw8N9LEOlFbfAeMd
 qnHyyoiYEMKdDeAjLl8YBMlIKJFDilBHjGjKgXCrjXpML/Q7N7BI1KIlL6DHZzJkURMU
 fR/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqtg1kEKrxioASB9n5KdAhJCK7LL4dvldxDm5+sJGbd2TC2cTgbpYX0sqcimgaOFcCGGIYtIdqOsxFp@nongnu.org
X-Gm-Message-State: AOJu0YzswAMq6L/lfp73OpzTMr/O39iqaaIrBPZv3Q7XmsgJ7dKWRQqI
 NLgcA1Dfp0NWKUyDihyaoEk6y3w9Vr5sXD+hB5ym6QcW15QWXNR5hFf/VsmjhlFL24A=
X-Gm-Gg: AfdE7ckgeYF+MqxDT/OGl7Wg3HPD0ksRdwvEq3dlc7Ow8v3/s+J1jopJqyk8igFCKb9
 P8JQnJT0PCdjFsBz9qK0mbgWDiVeCdLd8xjqyG5i6cmtf2ZrLVC6h3xyfenqLXm30+Gk0IjmVXF
 uES0OvEW7NCIH5ESmZFWx4jl42P22ZK0EKhhgH8TeQ9vWt8uhZB4ay0zi77yXk3KQyA1t5NkZvH
 rPL6vEuQRhgbfPfCYPzWOLnnN95RC1gQ7Zp5ZLKio03Xs6dRl2dMmlPI3k5lnIBF+Lqm1ix4iru
 MSJEiGrL1Oc3Pqfh7EJxALgdYiM3Rcy8BZtWF2ZtpoCXOhr28HdIA5aODCPEvoz4TLnpV4aQlvS
 ZhtTp6UlQIzjWkiXeFkk61HP5y5JbWpK+feEdu/CxvjYV7+66IFHJuL4xfYk1RPrh+NMd6W4nOt
 s9FA==
X-Received: by 2002:a05:6000:178e:b0:47d:ee23:f15e with SMTP id
 ffacd0b85a97d-47f4fc99a5amr2650290f8f.5.1784111695800; 
 Wed, 15 Jul 2026 03:34:55 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:c44f:405f:37a5:5992])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm17292644f8f.18.2026.07.15.03.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:34:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 2/3] iotests: skip FUSE tests when FUSE is not usable
Date: Wed, 15 Jul 2026 12:34:50 +0200
Message-ID: <20260715103451.1930909-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715103451.1930909-1-den@openvz.org>
References: <20260715103451.1930909-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=den@openvz.org; helo=mail-wr1-x42f.google.com
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

Add _notrun_on_fuse_error() to common.rc and use it in the shell
tests. fuse-mmap-shared is Python, so it gets an equivalent inline
check.

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
index 298bc483e0..bcb1ec50a9 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -981,6 +981,20 @@ _require_drivers()
     done
 }
 
+# Skip if FUSE is unusable: not compiled in, or the export failed to
+# mount. $1 is the failing 'block-export-add' reply.
+_notrun_on_fuse_error()
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
index fb8db73b31..0d970c102f 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -89,9 +89,7 @@ output=$(_send_qemu_cmd $QEMU_HANDLE \
     'return' \
     | grep -v 'option allow_other only allowed if')
 
-if echo "$output" | grep -q "Parameter 'type' does not accept value 'fuse'"; then
-    _notrun 'No FUSE support'
-fi
+_notrun_on_fuse_error "$output"
 echo "$output"
 
 echo
diff --git a/tests/qemu-iotests/tests/fuse-allow-other b/tests/qemu-iotests/tests/fuse-allow-other
index eaa39f8f23..50a36601d7 100755
--- a/tests/qemu-iotests/tests/fuse-allow-other
+++ b/tests/qemu-iotests/tests/fuse-allow-other
@@ -77,6 +77,8 @@ fuse_export_add()
         _notrun "allow_other not supported"
     fi
 
+    _notrun_on_fuse_error "$output"
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


