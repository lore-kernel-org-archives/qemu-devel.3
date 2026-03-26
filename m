Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148D4106F312
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gtm-0000oY-CU; Thu, 26 Mar 2026 05:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gtk-0000lj-Vt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:21:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w5gth-0000KS-VX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:21:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso8006935e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quobyte.com; s=google; t=1774516860; x=1775121660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7G7nq1NGmHEb9erj4D2akBfJiwls4FugzcHGpskJvPs=;
 b=yKtRcrCCXQ492PWxrdnz5Y1JkH69ODHnMtS+7pFLvwo19qBhUp1KIwOKHEF8/jWZTh
 0VZyvhWKQH54hAfGES2Anvb8BWtCk185OOHLgus02b4eYIMBp8WBVu/Te1t3ehxWvfe+
 Zh9RT4PtN0FMOJNOdkTrVf+tEj9LdnxEd8QjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774516860; x=1775121660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7G7nq1NGmHEb9erj4D2akBfJiwls4FugzcHGpskJvPs=;
 b=gYEU5x4KnIBZN0c5RtYzZaR6W2r15JYYrP4lBetl4aXERKq+t/Gy0aGduS+Jf9TQub
 1lkncHgChy9ruOJWdlTOSiu6gXDa6MyW8Z4m+6OH+xtp66tiuZ+RLCbEHLwmg0IadJci
 BDIZfEhrAvRDOuhAkIw6rw/B/YX7thV/jmYOKXYJ+6CJ5Vags3DwbA+ANMvE8HlsRUoK
 PUhX01eARhtzswm90XejaivnMymz+0VcFlGudeggQ1OBEaRY99ewR5P2/0SkDqmN7URf
 q4xmzD17YkdJ3KbKMnDB+zQU4SpJ1fJEWFIZhX4YjRAGuvPMZp04wBtFUVwUafPAQlSk
 BGSA==
X-Gm-Message-State: AOJu0Yzr+aA7VuMcgo1NFhrCBBiey3tNrZWeqMPddv8ftD69lnoJN5Tq
 l1kIrQ/noJAxDGZn0EVTd2r41C1sKeL+uL7zQZNXKaQbGDm+opXbPj2Pr4xhujk7ATgiO9v8tBC
 j2yuLoY5dYTw2T1m7yWk988dmSpKjsx1/RbHJ9uRCOaQV52TsTovfl5dzHDVuSJrJdtTX
X-Gm-Gg: ATEYQzwyglRdzQ1aluqHu0dBz5XwR65sOVBY792aY/7eQWE2QQo/EgyfbLvpf9+Bcen
 hxvWRcxvfWw5H+rafNL1hS9VCNggIuKmtU5R6o6KerMsq2NMGUv1/uB5aNpKJSTn2a7EFG8R8Gq
 2MRzW3Bgz/uTrb+SWOyh5Ab/L3tg3xKaTN4AvPZBjItkUPgBGYVkFYVnSiAQhlz6kgVtC6q1lBH
 +kWf0QQ9oVFuL05WkifmatccziaeWNNHRAS/758Zn9BE9y2bZmAMsA5YNJ5tZm60Pzwgp3J3tGj
 eSm8i00Iig//DzTn9kbUCkvJ7WuVZCtRM+IFaGrF/IPwp1rzRNdb2JRFR033eHfNYQ+bcU+tDJJ
 CZzJtvJx5LxOwwWveKLUBi9stfzdJmFACsYULwbHmnaXLW/xRM0ujkSIEnjcyrKXDvNR0eL8VG4
 nV/Gl2X4IKt2YraVzj4HeIhPy4bM91ZQjqmXgtJYVi3Ql+rZF+y0VhsnkUSOYrR80SzPr3ztF/4
 +9UqjEGM4/ct6dryhMhUBXz5ptMyKJAIj6wuaxjN2Sn5+FHUxl6Qv7bInw=
X-Received: by 2002:a05:600c:6ca:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-4871fb409d4mr16150575e9.22.1774516859932; 
 Thu, 26 Mar 2026 02:20:59 -0700 (PDT)
Received: from kaisers.corp.quobyte.com ([24.134.167.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9506dsm16474295e9.7.2026.03.26.02.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:20:59 -0700 (PDT)
From: Silvan Kaiser <silvan@quobyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 pierrick.bouvier@linaro.org, eblake@redhat.com, armbru@redhat.com,
 Silvan Kaiser <silvan@quobyte.com>
Subject: [PATCH 1/3] block: Add 'posix' option for file locking
Date: Thu, 26 Mar 2026 10:19:46 +0100
Message-ID: <20260326091948.194529-2-silvan@quobyte.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091948.194529-1-silvan@quobyte.com>
References: <20260326091948.194529-1-silvan@quobyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=silvan@quobyte.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The new 'posix' value for the 'locking' property of file-based block
devices forces the use of traditional POSIX locks (F_SETLK/F_GETLK)
instead of OFD (Open File Descriptor) locks.

While OFD locks are preferred when available =E2=80=94 they are per file de=
scriptor and
thus survive QEMU-internal fd operations such as hot-plug and block jobs =
=E2=80=94 some
userspace filesystem implementations (e.g. FUSE) handle POSIX locks correct=
ly
but do not fully support OFD lock semantics. Issues with OFD support detect=
ion
on underlying file systems and some OFD guarantees not being fully supporte=
d
can prohibit users from using the default OFD locking.
Previously, users in this situation had no way to force POSIX locks without
disabling locking entirely; 'locking=3Don' would silently fall back to POSI=
X only
when OFD was unavailable.

The new 'posix' option makes the choice explicit and allows users to set up=
 a
clear POSIX config, allowing users to control the locking setup for any sce=
nario
where OFD locking is not advisable.
Note that the known shortcoming of POSIX locks still applies: locks
can be silently lost when QEMU closes and reopens file descriptors
during hot-plug or block job operations.

Signed-off-by: Silvan Kaiser <silvan@quobyte.com>
---
 block/file-posix.c   | 18 +++++++++++-------
 include/qemu/osdep.h |  1 +
 qapi/block-core.json | 18 ++++++++++++++++--
 util/osdep.c         |  9 +++++++--
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index e49b13d6ab..c99974000d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -625,7 +625,7 @@ static int raw_open_common(BlockDriverState *bs, QDict =
*options,
     BlockdevAioOptions aio, aio_default;
     int fd, ret;
     struct stat st;
-    OnOffAuto locking;
+    BlockdevLockingOptions locking;
=20
     opts =3D qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
     if (!qemu_opts_absorb_qdict(opts, options, errp)) {
@@ -666,16 +666,16 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
=20
     s->aio_max_batch =3D qemu_opt_get_number(opts, "aio-max-batch", 0);
=20
-    locking =3D qapi_enum_parse(&OnOffAuto_lookup,
-                              qemu_opt_get(opts, "locking"),
-                              ON_OFF_AUTO_AUTO, &local_err);
+    locking =3D qapi_enum_parse(&BlockdevLockingOptions_lookup,
+                          qemu_opt_get(opts, "locking"),
+                          BLOCKDEV_LOCKING_OPTIONS_AUTO, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
         goto fail;
     }
     switch (locking) {
-    case ON_OFF_AUTO_ON:
+    case BLOCKDEV_LOCKING_OPTIONS_ON:
         s->use_lock =3D true;
         if (!qemu_has_ofd_lock()) {
             warn_report("File lock requested but OFD locking syscall is "
@@ -684,12 +684,16 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
                          "unexpectedly.\n");
         }
         break;
-    case ON_OFF_AUTO_OFF:
+    case BLOCKDEV_LOCKING_OPTIONS_OFF:
         s->use_lock =3D false;
         break;
-    case ON_OFF_AUTO_AUTO:
+    case BLOCKDEV_LOCKING_OPTIONS_AUTO:
         s->use_lock =3D qemu_has_ofd_lock();
         break;
+    case BLOCKDEV_LOCKING_OPTIONS_POSIX:
+        s->use_lock =3D true;
+        qemu_use_posix_locks();
+        break;
     default:
         abort();
     }
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f151578b5c..8ea506e462 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -634,6 +634,7 @@ int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
 int qemu_fcntl_addfl(int fd, int flag);
+void qemu_use_posix_locks(void);
 #endif
=20
 bool qemu_has_direct_io(void);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 508b081ac1..cec369f0fe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3362,6 +3362,19 @@
             { 'name': 'virtio-blk-vhost-vdpa', 'if': 'CONFIG_BLKIO' },
             'vmdk', 'vpc', 'vvfat' ] }
=20
+##
+# @BlockdevLockingOptions:
+#
+# @off: Disable locking.
+# @on: Enable locking (prefer OFD).
+# @auto: Use locking if OFD is available.
+# @posix: Force use of traditional POSIX locks.
+#
+# Since: 10.3
+##
+{ 'enum': 'BlockdevLockingOptions',
+  'data': [ 'off', 'on', 'auto', 'posix' ] }
+
 ##
 # @BlockdevOptionsFile:
 #
@@ -3382,7 +3395,8 @@
 #     automatically.  (default: 0, since 6.2)
 #
 # @locking: whether to enable file locking.  If set to 'auto', only
-#     enable when Open File Descriptor (OFD) locking API is available
+#     enable when Open File Descriptor (OFD) locking API is available.
+#     'posix' forces use of POSIX locks.
 #     (default: auto, since 2.10)
 #
 # @drop-cache: invalidate page cache during live migration.  This
@@ -3412,7 +3426,7 @@
 { 'struct': 'BlockdevOptionsFile',
   'data': { 'filename': 'str',
             '*pr-manager': 'str',
-            '*locking': 'OnOffAuto',
+            '*locking': 'BlockdevLockingOptions',
             '*aio': 'BlockdevAioOptions',
             '*aio-max-batch': 'int',
             '*drop-cache': {'type': 'bool',
diff --git a/util/osdep.c b/util/osdep.c
index 000e7daac8..76495282cc 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -223,8 +223,7 @@ static void qemu_probe_lock_ops(void)
             fcntl_op_getlk =3D F_GETLK;
         }
 #else
-        fcntl_op_setlk =3D F_SETLK;
-        fcntl_op_getlk =3D F_GETLK;
+        qemu_use_posix_locks();
 #endif
     }
 }
@@ -239,6 +238,12 @@ bool qemu_has_ofd_lock(void)
 #endif
 }
=20
+void qemu_use_posix_locks(void)
+{
+    fcntl_op_setlk =3D F_SETLK;
+    fcntl_op_getlk =3D F_GETLK;
+}
+
 static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type=
)
 {
     int ret;
--=20
2.47.3


--=20
Quobyte GmbH, Berlin, AG Charlottenburg HRB 149012 B, Dr. Felix Hupfeld,=20
Dr. Bjoern Kolbeck

