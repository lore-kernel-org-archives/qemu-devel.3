Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E508C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2n-0001bI-Ia; Fri, 09 Aug 2024 14:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2l-0001VC-Qu
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2j-0007DA-LF
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3686b285969so1234316f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226928; x=1723831728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gFqkGsXiARvhRWrK655SyRQtokwmjKh8RhYlups7b4I=;
 b=X3XE8ibb1nm6u79yIzCWb43LSFhfKeP9MgCCEBqfyvg1DwyyAmI9WZtuH9G/StUOA5
 l1heXPNZMyFBrMWA4OY2Md06s9mxrc621bSDJ57o4FxTiTAoCSiLNeZYD4nGeyxjENZ/
 D7tjdV3VEkIhIL1TvqszTPLyb+jCCowIhoSxBfKme2VfRxhGnQ1uyXIprOoIyt+AueH4
 sfuYglVdxhRo1H5MrveZQkTc/UwlyV7L3XEg3F06sRfwP2udUYjzMlejiaKuwPpeTbod
 70poMrgUpwy7XZYLBUrCJYnZmdbe6UpHoB7iw+ToA1TImiycbzR5NbdXS3PqfVimXWPD
 ICEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226928; x=1723831728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFqkGsXiARvhRWrK655SyRQtokwmjKh8RhYlups7b4I=;
 b=KZ1iYOLuRyzFVep69Y5Ko2LKd9so11a4n/fu4tc/V3xK2NX1yW14DayMG1kej2qxLA
 Ze4T62Xr6305EOARgxr4yp1ro+Zlu8VCF2leJzc0/Oa63wqu0H6NJF41+X1KloULURAA
 LAQIV3kWA3jSZ9WkP0mLYnFjJDm0X3lTIpwmx3uE+IO/I3QEBzvCpE7LeZQ8F9kExw3P
 oYgH+0uWCC1C06VKvMVkd4Rp4V+gmci/U4Mk+qFR4W+0Q/eWje5UyysFYDdGucae9Unz
 uClIAV1cen083EQNc/Yf6L1h0lnvX704gVQHs4nh1q9qvTk2G9mTB4KAVonRe0xwm44O
 UMLw==
X-Gm-Message-State: AOJu0Yz0S0mu2TlG5oeivqTI2RDzIrI6oROSIn0jm8Sse1BQkr58GFw/
 HPhXlZoKl0uiLZCrZbEH6QAJJUdbNAQzd1i38gPZn0KkV29KhSKEWWx5i7E6I6edezHx2g6nH0z
 4
X-Google-Smtp-Source: AGHT+IFai4o1/ULVGtUSkwzaUA9x4LINU18MSTjVBIah+eVDHJjOaCPV9uANJ01jAqEJuP66k3SecQ==
X-Received: by 2002:adf:fa08:0:b0:367:98e6:2a15 with SMTP id
 ffacd0b85a97d-36d60353f60mr2121669f8f.53.1723226928001; 
 Fri, 09 Aug 2024 11:08:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] docs/interop/nbd.txt: Convert to rST
Date: Fri,  9 Aug 2024 19:08:28 +0100
Message-Id: <20240809180835.1243269-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Convert nbd.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20240801170131.3977807-3-peter.maydell@linaro.org
---
 MAINTAINERS            |  2 +-
 docs/interop/index.rst |  1 +
 docs/interop/nbd.rst   | 89 ++++++++++++++++++++++++++++++++++++++++++
 docs/interop/nbd.txt   | 72 ----------------------------------
 4 files changed, 91 insertions(+), 73 deletions(-)
 create mode 100644 docs/interop/nbd.rst
 delete mode 100644 docs/interop/nbd.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 36becfaf494..04a1fd08503 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3871,7 +3871,7 @@ F: nbd/
 F: include/block/nbd*
 F: qemu-nbd.*
 F: blockdev-nbd.c
-F: docs/interop/nbd.txt
+F: docs/interop/nbd.rst
 F: docs/tools/qemu-nbd.rst
 F: tests/qemu-iotests/tests/*nbd*
 T: git https://repo.or.cz/qemu/ericb.git nbd
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index ed65395bfb2..b9ceaabc648 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -14,6 +14,7 @@ are useful for making QEMU interoperate with other software.
    dbus-vmstate
    dbus-display
    live-block-operations
+   nbd
    pr-helper
    qmp-spec
    qemu-ga
diff --git a/docs/interop/nbd.rst b/docs/interop/nbd.rst
new file mode 100644
index 00000000000..de079d31fd8
--- /dev/null
+++ b/docs/interop/nbd.rst
@@ -0,0 +1,89 @@
+QEMU NBD protocol support
+=========================
+
+QEMU supports the NBD protocol, and has an internal NBD client (see
+``block/nbd.c``), an internal NBD server (see ``blockdev-nbd.c``), and an
+external NBD server tool (see ``qemu-nbd.c``). The common code is placed
+in ``nbd/*``.
+
+The NBD protocol is specified here:
+https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
+
+The following paragraphs describe some specific properties of NBD
+protocol realization in QEMU.
+
+Metadata namespaces
+-------------------
+
+QEMU supports the ``base:allocation`` metadata context as defined in the
+NBD protocol specification, and also defines an additional metadata
+namespace ``qemu``.
+
+``qemu`` namespace
+------------------
+
+The ``qemu`` namespace currently contains two available metadata context
+types.  The first is related to exposing the contents of a dirty
+bitmap alongside the associated disk contents.  That metadata context
+is named with the following form::
+
+    qemu:dirty-bitmap:<dirty-bitmap-export-name>
+
+Each dirty-bitmap metadata context defines only one flag for extents
+in reply for ``NBD_CMD_BLOCK_STATUS``:
+
+bit 0:
+  ``NBD_STATE_DIRTY``, set when the extent is "dirty"
+
+The second is related to exposing the source of various extents within
+the image, with a single metadata context named::
+
+    qemu:allocation-depth
+
+In the allocation depth context, the entire 32-bit value represents a
+depth of which layer in a thin-provisioned backing chain provided the
+data (0 for unallocated, 1 for the active layer, 2 for the first
+backing layer, and so forth).
+
+For ``NBD_OPT_LIST_META_CONTEXT`` the following queries are supported
+in addition to the specific ``qemu:allocation-depth`` and
+``qemu:dirty-bitmap:<dirty-bitmap-export-name>``:
+
+``qemu:``
+  returns list of all available metadata contexts in the namespace
+``qemu:dirty-bitmap:``
+  returns list of all available dirty-bitmap metadata contexts
+
+Features by version
+-------------------
+
+The following list documents which qemu version first implemented
+various features (both as a server exposing the feature, and as a
+client taking advantage of the feature when present), to make it
+easier to plan for cross-version interoperability.  Note that in
+several cases, the initial release containing a feature may require
+additional patches from the corresponding stable branch to fix bugs in
+the operation of that feature.
+
+2.6
+  ``NBD_OPT_STARTTLS`` with TLS X.509 Certificates
+2.8
+  ``NBD_CMD_WRITE_ZEROES``
+2.10
+  ``NBD_OPT_GO``, ``NBD_INFO_BLOCK``
+2.11
+  ``NBD_OPT_STRUCTURED_REPLY``
+2.12
+  ``NBD_CMD_BLOCK_STATUS`` for ``base:allocation``
+3.0
+  ``NBD_OPT_STARTTLS`` with TLS Pre-Shared Keys (PSK),
+  ``NBD_CMD_BLOCK_STATUS`` for ``qemu:dirty-bitmap:``, ``NBD_CMD_CACHE``
+4.2
+  ``NBD_FLAG_CAN_MULTI_CONN`` for shareable read-only exports,
+  ``NBD_CMD_FLAG_FAST_ZERO``
+5.2
+  ``NBD_CMD_BLOCK_STATUS`` for ``qemu:allocation-depth``
+7.1
+  ``NBD_FLAG_CAN_MULTI_CONN`` for shareable writable exports
+8.2
+  ``NBD_OPT_EXTENDED_HEADERS``, ``NBD_FLAG_BLOCK_STATUS_PAYLOAD``
diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
deleted file mode 100644
index 18efb251de9..00000000000
--- a/docs/interop/nbd.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-QEMU supports the NBD protocol, and has an internal NBD client (see
-block/nbd.c), an internal NBD server (see blockdev-nbd.c), and an
-external NBD server tool (see qemu-nbd.c). The common code is placed
-in nbd/*.
-
-The NBD protocol is specified here:
-https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
-
-The following paragraphs describe some specific properties of NBD
-protocol realization in QEMU.
-
-= Metadata namespaces =
-
-QEMU supports the "base:allocation" metadata context as defined in the
-NBD protocol specification, and also defines an additional metadata
-namespace "qemu".
-
-== "qemu" namespace ==
-
-The "qemu" namespace currently contains two available metadata context
-types.  The first is related to exposing the contents of a dirty
-bitmap alongside the associated disk contents.  That metadata context
-is named with the following form:
-
-    qemu:dirty-bitmap:<dirty-bitmap-export-name>
-
-Each dirty-bitmap metadata context defines only one flag for extents
-in reply for NBD_CMD_BLOCK_STATUS:
-
-    bit 0: NBD_STATE_DIRTY, set when the extent is "dirty"
-
-The second is related to exposing the source of various extents within
-the image, with a single metadata context named:
-
-    qemu:allocation-depth
-
-In the allocation depth context, the entire 32-bit value represents a
-depth of which layer in a thin-provisioned backing chain provided the
-data (0 for unallocated, 1 for the active layer, 2 for the first
-backing layer, and so forth).
-
-For NBD_OPT_LIST_META_CONTEXT the following queries are supported
-in addition to the specific "qemu:allocation-depth" and
-"qemu:dirty-bitmap:<dirty-bitmap-export-name>":
-
-* "qemu:" - returns list of all available metadata contexts in the
-            namespace.
-* "qemu:dirty-bitmap:" - returns list of all available dirty-bitmap
-                         metadata contexts.
-
-= Features by version =
-
-The following list documents which qemu version first implemented
-various features (both as a server exposing the feature, and as a
-client taking advantage of the feature when present), to make it
-easier to plan for cross-version interoperability.  Note that in
-several cases, the initial release containing a feature may require
-additional patches from the corresponding stable branch to fix bugs in
-the operation of that feature.
-
-* 2.6: NBD_OPT_STARTTLS with TLS X.509 Certificates
-* 2.8: NBD_CMD_WRITE_ZEROES
-* 2.10: NBD_OPT_GO, NBD_INFO_BLOCK
-* 2.11: NBD_OPT_STRUCTURED_REPLY
-* 2.12: NBD_CMD_BLOCK_STATUS for "base:allocation"
-* 3.0: NBD_OPT_STARTTLS with TLS Pre-Shared Keys (PSK),
-NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
-* 4.2: NBD_FLAG_CAN_MULTI_CONN for shareable read-only exports,
-NBD_CMD_FLAG_FAST_ZERO
-* 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
-* 7.1: NBD_FLAG_CAN_MULTI_CONN for shareable writable exports
-* 8.2: NBD_OPT_EXTENDED_HEADERS, NBD_FLAG_BLOCK_STATUS_PAYLOAD
-- 
2.34.1


