Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C84C531DD
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2o-0001dH-4q; Fri, 09 Aug 2024 14:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2m-0001Y3-HW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2k-0007DC-Aa
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso1296820f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226929; x=1723831729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=agG5AiF1eAhZlwXMsZvTErllzGZ75Y15g9KkwWX0cZI=;
 b=K93YX/9noKVt/to1LE+MCGGsgfcInbSprDYIf7qSkEXAZcMvdiaAkm17qslVdsuNja
 UiVQOuky5P+1LAlL8tLY9zdcBOpSnxnqf4gL+6703QdXOez44A7Dxc7qvy/ouDQhRiLh
 cSocJLalqTwCLUtwcKql1YiV7vFck2B+Gr4aWWc3oYLIUed5+zn3+oPJb21jLQ62cgnl
 b1AdTl697X+hEOT+NMqQyIHdy2EbXc0FMLm+BKlg2NZicNWfVNKJbUPT4K5jc8GiEqCd
 Hx/S3ViX3ZhbCiO/bzTzw5iuHQT7hRG6tFHTCtrNv4D/OsHpg8QDPGkHi8iQqFsgWZBk
 OyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226929; x=1723831729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agG5AiF1eAhZlwXMsZvTErllzGZ75Y15g9KkwWX0cZI=;
 b=N+MrpGl49QTNuthD3LU1/5rWNSIWyOZvYYJ44nMb6nxZ+Cc4BFHnr9bvSNn1QT/NSZ
 /MYhoSHJF8tx9o+8Xyb2kYHjte3zvn7yr/Se+WJk0zV5FKwbfb2bmCQfz+XIDUYptHWt
 60nitpLEK4UnqV8RQIlFJWImxcf8Hl0XEOGAloeTBUAoqrOPwYs+bLfx2Rza1i9++1nk
 m7buwvgSkZsi6wvevK8GC5/j1PeMaz2s+nZ9TR5hkUhvuGHcz1VdF9gyKUUe3tnJOFs8
 4XQgSfsMatHdSX40ckQFh5svZC5f86/m34lMkVywuHX8iG7Q/ILkfYuEFTM/1y3xhdLY
 HLhA==
X-Gm-Message-State: AOJu0YzHXJ+JPbwHO9XxZa2SZvCHts44dEk/oxYodtByQ0hFERI/Xjqt
 R8otbshvHqZfREQYAH0c7JZnzaDdqQfsXMLlTICZRSZ24HaPmYSq9tGcnDN4ggEPXHpTYnaiK1F
 d
X-Google-Smtp-Source: AGHT+IFj8NX652LCVHS/Sr3a4C5UGz4yBLHzOqUx9KNUw7b6DgdZg3rccmcbHhl3bDMEUwWB4j+Viw==
X-Received: by 2002:a5d:5488:0:b0:367:9903:a79 with SMTP id
 ffacd0b85a97d-36d5fd7fb14mr1413557f8f.48.1723226928625; 
 Fri, 09 Aug 2024 11:08:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] docs/interop/parallels.txt: Convert to rST
Date: Fri,  9 Aug 2024 19:08:29 +0100
Message-Id: <20240809180835.1243269-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20240801170131.3977807-4-peter.maydell@linaro.org
---
 MAINTAINERS                                   |   2 +-
 docs/interop/index.rst                        |   1 +
 docs/interop/{parallels.txt => parallels.rst} | 108 ++++++++++--------
 3 files changed, 60 insertions(+), 51 deletions(-)
 rename docs/interop/{parallels.txt => parallels.rst} (72%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04a1fd08503..ae8bed8c757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3964,7 +3964,7 @@ L: qemu-block@nongnu.org
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


