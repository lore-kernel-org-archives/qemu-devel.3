Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D1BC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZBY-0003cv-Rb; Thu, 01 Aug 2024 13:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBN-0003B5-92
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBI-0003PW-AZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso46527745e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531695; x=1723136495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnaoF6Fbe7vpRk+nEopMX5bSeltvF/nw8CMgLdRDdWs=;
 b=fHEo60nQypRuNqiNQbMcK9yX16dUTxXFS3rxRzuwY8JCvIM28BED67d99z1Q87e3Rc
 n6Z5+LiieZC3abILAcfo5kKqQAOKAFUORrEkW3bumwx1sPLY9e4jIj+qNy4/28MR91me
 RYGP5KltogXHQP1OKxMpa9jTI7GxUjXBvSEXxu7O5i+bhneBbipNwP+GxWYbhCwYa75v
 vT4bcOPiv+ykhrcDibTZsdtLq9/3/UrijcixKBKoJLLEL3jXVzNWBuguG8CpJ/wY/yW4
 6qigobp2jyOd/ZxNOpOc4lTF7UCUwX4WvBgZ/YRfJ8J2aV1Qhs46TWxLWcP+BSu7C8S9
 uVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531695; x=1723136495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnaoF6Fbe7vpRk+nEopMX5bSeltvF/nw8CMgLdRDdWs=;
 b=AOSApoTOtW8x0Im8g1nxt/zL0e16rhtRjEFtjEk1V4/BW2hN/BxXcqmgy26PfCodiN
 4+7RRQJD1BwTb6fbIPYy4c6Fja9Pq0qxL4xfExyS2lTdj2F0v8Nrl9kSJtvhy0re4CzX
 QLvZndtkUjf0T9bC7M093ttr9K6nZp0PSGCoLkM7e2SV34m7f60HscRXEoUb6cZKRdRn
 m0fqXWDCtgPurJDzPDsGN+1Q3y/kHKCDPlkbLXc05dqq70vL0dtLPQRLlNiauVSQo+8f
 pXHU25N2Xh0J91tEajvvMM48Z+6dQUFquJfOlvE8/heo857CFp9FObTPwqX53cY9aYOG
 n0bQ==
X-Gm-Message-State: AOJu0Yx06qb/KH0j0LbHXn5Wu5wliKR7+PiB39dgFT2XLyUuMB/50r6y
 AXXUf+mH8sP5XvtLFegeA8W7kRnnIRP8VFExzVBxsMYsk0wPm4A+/y4bfDxRzf1ppPbFp7xBgiq
 g
X-Google-Smtp-Source: AGHT+IEvlbN77RGfdvoSzyp4jaggmfMxzJg/9LQ2qXJhCXPexJ5uB0H/kSo+AtJ9I5jcRpy2qUlxsQ==
X-Received: by 2002:a05:600c:5489:b0:426:629f:154e with SMTP id
 5b1f17b1804b1-428e6b7c5cemr3426935e9.30.1722531694435; 
 Thu, 01 Aug 2024 10:01:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e24c2b4csm30385255e9.31.2024.08.01.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:01:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 3/5] docs/interop/parallels.txt: Convert to rST
Date: Thu,  1 Aug 2024 18:01:29 +0100
Message-Id: <20240801170131.3977807-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801170131.3977807-1-peter.maydell@linaro.org>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Convert parallels.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                   |   2 +-
 docs/interop/index.rst                        |   1 +
 docs/interop/{parallels.txt => parallels.rst} | 108 ++++++++++--------
 3 files changed, 60 insertions(+), 51 deletions(-)
 rename docs/interop/{parallels.txt => parallels.rst} (72%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd159053dbd..37cfe16fd09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3962,7 +3962,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: block/parallels.c
 F: block/parallels-ext.c
-F: docs/interop/parallels.txt
+F: docs/interop/parallels.rst
 T: git https://src.openvz.org/scm/~den/qemu.git parallels
 
 qed
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index b9ceaabc648..70bba62d907 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -15,6 +15,7 @@ are useful for making QEMU interoperate with other software.
    dbus-display
    live-block-operations
    nbd
+   parallels
    pr-helper
    qmp-spec
    qemu-ga
diff --git a/docs/interop/parallels.txt b/docs/interop/parallels.rst
similarity index 72%
rename from docs/interop/parallels.txt
rename to docs/interop/parallels.rst
index bb3fadf3692..7b328a40c80 100644
--- a/docs/interop/parallels.txt
+++ b/docs/interop/parallels.rst
@@ -1,41 +1,46 @@
-= License =
+Parallels Expandable Image File Format
+======================================
 
-Copyright (c) 2015 Denis Lunev
-Copyright (c) 2015 Vladimir Sementsov-Ogievskiy
+..
+   Copyright (c) 2015 Denis Lunev
+   Copyright (c) 2015 Vladimir Sementsov-Ogievskiy
 
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
+   This work is licensed under the terms of the GNU GPL, version 2 or later.
+   See the COPYING file in the top-level directory.
 
-= Parallels Expandable Image File Format =
 
 A Parallels expandable image file consists of three consecutive parts:
-    * header
-    * BAT
-    * data area
+
+* header
+* BAT
+* data area
 
 All numbers in a Parallels expandable image are stored in little-endian byte
 order.
 
 
-== Definitions ==
+Definitions
+-----------
 
-    Sector    A 512-byte data chunk.
+Sector
+  A 512-byte data chunk.
 
-    Cluster   A data chunk of the size specified in the image header.
-              Currently, the default size is 1MiB (2048 sectors). In previous
-              versions, cluster sizes of 63 sectors, 256 and 252 kilobytes were
-              used.
+Cluster
+  A data chunk of the size specified in the image header.
+  Currently, the default size is 1MiB (2048 sectors). In previous
+  versions, cluster sizes of 63 sectors, 256 and 252 kilobytes were used.
 
-    BAT       Block Allocation Table, an entity that contains information for
-              guest-to-host I/O data address translation.
+BAT
+  Block Allocation Table, an entity that contains information for
+  guest-to-host I/O data address translation.
 
-
-== Header ==
+Header
+------
 
 The header is placed at the start of an image and contains the following
-fields:
+fields::
 
-Bytes:
+ Bytes:
    0 - 15:    magic
               Must contain "WithoutFreeSpace" or "WithouFreSpacExt".
 
@@ -103,44 +108,46 @@ Bytes:
               ext_off must meet the same requirements as cluster offsets
               defined by BAT entries (see below).
 
-
-== BAT ==
+BAT
+---
 
 BAT is placed immediately after the image header. In the file, BAT is a
 contiguous array of 32-bit unsigned little-endian integers with
-(bat_entries * 4) bytes size.
+``(bat_entries * 4)`` bytes size.
 
 Each BAT entry contains an offset from the start of the file to the
-corresponding cluster. The offset set in clusters for "WithouFreSpacExt" images
-and in sectors for "WithoutFreeSpace" images.
+corresponding cluster. The offset set in clusters for ``WithouFreSpacExt``
+images and in sectors for ``WithoutFreeSpace`` images.
 
 If a BAT entry is zero, the corresponding cluster is not allocated and should
 be considered as filled with zeroes.
 
 Cluster offsets specified by BAT entries must meet the following requirements:
-    - the value must not be lower than data offset (provided by header.data_off
-      or calculated as specified above),
-    - the value must be lower than the desired file size,
-    - the value must be unique among all BAT entries,
-    - the result of (cluster offset - data offset) must be aligned to cluster
-      size.
 
+- the value must not be lower than data offset (provided by ``header.data_off``
+  or calculated as specified above)
+- the value must be lower than the desired file size
+- the value must be unique among all BAT entries
+- the result of ``(cluster offset - data offset)`` must be aligned to
+  cluster size
 
-== Data Area ==
+Data Area
+---------
 
-The data area is an area from the data offset (provided by header.data_off or
-calculated as specified above) to the end of the file. It represents a
+The data area is an area from the data offset (provided by ``header.data_off``
+or calculated as specified above) to the end of the file. It represents a
 contiguous array of clusters. Most of them are allocated by the BAT, some may
-be allocated by the ext_off field in the header while other may be allocated by
-extensions. All clusters allocated by ext_off and extensions should meet the
-same requirements as clusters specified by BAT entries.
+be allocated by the ``ext_off`` field in the header while other may be
+allocated by extensions. All clusters allocated by ``ext_off`` and extensions
+should meet the same requirements as clusters specified by BAT entries.
 
 
-== Format Extension ==
+Format Extension
+----------------
 
 The Format Extension is an area 1 cluster in size that provides additional
 format features. This cluster is addressed by the ext_off field in the header.
-The format of the Format Extension area is the following:
+The format of the Format Extension area is the following::
 
    0 -  7:    magic
               Must be 0xAB234CEF23DCEA87
@@ -149,10 +156,10 @@ The format of the Format Extension area is the following:
               The MD5 checksum of the entire Header Extension cluster except
               the first 24 bytes.
 
-    The above are followed by feature sections or "extensions". The last
-    extension must be "End of features" (see below).
+The above are followed by feature sections or "extensions". The last
+extension must be "End of features" (see below).
 
-Each feature section has the following format:
+Each feature section has the following format::
 
    0 -  7:    magic
               The identifier of the feature:
@@ -183,16 +190,17 @@ Each feature section has the following format:
 
   variable:   data (data_size bytes)
 
-    The above is followed by padding to the next 8 bytes boundary, then the
-    next extension starts.
+The above is followed by padding to the next 8 bytes boundary, then the
+next extension starts.
 
-    The last extension must be "End of features" with all the fields set to 0.
+The last extension must be "End of features" with all the fields set to 0.
 
 
-=== Dirty bitmaps feature ===
+Dirty bitmaps feature
+---------------------
 
 This feature provides a way of storing dirty bitmaps in the image. The fields
-of its data area are:
+of its data area are::
 
    0 -  7:    size
               The bitmap size, should be equal to disk size in sectors.
@@ -215,7 +223,7 @@ clusters inside the Parallels image file. The offsets of these clusters are
 saved in the L1 offset table specified by the feature extension. Each L1 table
 entry is a 64 bit integer as described below:
 
-Given an offset in bytes into the bitmap data, corresponding L1 entry is
+Given an offset in bytes into the bitmap data, corresponding L1 entry is::
 
     l1_table[offset / cluster_size]
 
@@ -227,6 +235,6 @@ are assumed to be 1.
 
 If an L1 table entry is not 0 or 1, it contains the corresponding cluster
 offset (in 512b sectors). Given an offset in bytes into the bitmap data the
-offset in bytes into the image file can be obtained as follows:
+offset in bytes into the image file can be obtained as follows::
 
     offset = l1_table[offset / cluster_size] * 512 + (offset % cluster_size)
-- 
2.34.1


