Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD42C49EA1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZBQ-0003Ff-Qj; Thu, 01 Aug 2024 13:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBN-0003BE-AX
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBI-0003PR-8B
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so6434195e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531694; x=1723136494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dw4w8DX6EHAaNzhMmT3/w3NtJlxoy987bWug5+S1bQA=;
 b=NCoq2Ppy4+kARIyBSI6Y2NMD6l47g8MSWSTTotjT09zVDPu+Gv6nGedqxebSblju+s
 dzABJ44sEO85Otgo59iOO9sCPIK9fYFoVdV3Yhb+RpEDYCKkn6v6PPzTLP/vWyuwVMyo
 g9XrjFnxkvPfIAM8Q2cB3uu55dWAm8XI6XEl+ECQQqkVXQDdzezQT9o/1AyRZTiejGEK
 bPCOpPR+vZ2MDLEZM/aTrxas4FhoTJAMny5taqnSrX/ym/+QhjV/Rd8W+n40ZdpRoInj
 4t6L1/KFo3WjmIPLBn2ym+mgxiMwHTFAzBGor30F7YFYuGE4wppb3ZAcTSWD3kZJy+G9
 0kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531694; x=1723136494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dw4w8DX6EHAaNzhMmT3/w3NtJlxoy987bWug5+S1bQA=;
 b=HniiADE4LvbzRXusDBcxUodwtUU9K/4EUTmnkd8GEZDPKu6aV7GZaAUxWwlqagFuyv
 AQTpN/AJDpjxlnrRRuxYNeQbor/nxcK30iPPFL0U2VNiMZwK/NSD/H+0H1ho4GKpSeQA
 DpK3Nw2P9xWEukN6OLhvSbMLPXpZdYRGaYLzZeYSzLAGE9akn4bPQOuuQSLNJ44iLRrH
 AiOtkZ1ft5HHhsjEkDSIIMNuoi9ishN29p+6QWR04BL5i4/xMI+yCc1CCNd82Li7HuHi
 JhzsasGPHBDgz891cE0arhGskilXtj//LQZwC4eHRwcSviCMx2li1d6gNhwKkIWNiq81
 MVxg==
X-Gm-Message-State: AOJu0Yworgl3A585CYWOL43HsYASaeW7D5GUt1Dd808+Ga6n0d7dDwpC
 HNSq51D27SzQp1K7yNu0DyrRWHzMDeZe9WZ6Ylltfd9lHokCR30mgQq19v35M/1HZhsveq3/cA7
 i
X-Google-Smtp-Source: AGHT+IHN+2zq8car3XrKKSsg6/HQyT5+NbDlX9w7OcIy8ogQnoVvXbe1tu7LeH7WkobxgiJAnVTrbQ==
X-Received: by 2002:a05:600c:314a:b0:426:6688:2421 with SMTP id
 5b1f17b1804b1-428e6b059a6mr3862475e9.11.1722531693854; 
 Thu, 01 Aug 2024 10:01:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e24c2b4csm30385255e9.31.2024.08.01.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:01:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 2/5] docs/interop/nbd.txt: Convert to rST
Date: Thu,  1 Aug 2024 18:01:28 +0100
Message-Id: <20240801170131.3977807-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801170131.3977807-1-peter.maydell@linaro.org>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
---
 MAINTAINERS            |  2 +-
 docs/interop/index.rst |  1 +
 docs/interop/nbd.rst   | 89 ++++++++++++++++++++++++++++++++++++++++++
 docs/interop/nbd.txt   | 72 ----------------------------------
 4 files changed, 91 insertions(+), 73 deletions(-)
 create mode 100644 docs/interop/nbd.rst
 delete mode 100644 docs/interop/nbd.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a183fe960b..dd159053dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3869,7 +3869,7 @@ F: nbd/
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


