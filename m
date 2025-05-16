Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D01AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwZ7-0000J6-TL; Fri, 16 May 2025 11:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uFwZ4-0008VO-ED
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:01:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uFwYy-0003zN-Nb
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:01:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so22054685e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747407687; x=1748012487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIx1p4dcWnB1aHzIAfv4UaoGOMDrztSsaMYdA+5phgg=;
 b=MOrCpjc6Tpi3fCaZIzLuCG9V348Lui3JnVYOkaSqj/t9cYKj7wLf3UuQjvBTx7nLEi
 7GbvJ+WfWBjdDB3FwV1M+3rcABCJ0AVohVMHwX0ceeZWTapCrJbRZqGFr0PyzWktamXk
 lI/f73KUvicvDYcOnyYs5tsBsOL3fcs0MwkUGJOZUbzLRLcp/3LLdWyTONRqw7MMgLbl
 PEJePK0oken9jvwl3/uqsFSrEtuuk7NLrLR9UjzlxpRXBsfJG8UVBWqUvyhl2SXlMjyw
 7oSVU4D9+TLFpn5sAJvBRluB02XEnTTdhlk+hfcva/lusmifakDGe1y/HK8LuO9qnjyq
 A3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747407687; x=1748012487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIx1p4dcWnB1aHzIAfv4UaoGOMDrztSsaMYdA+5phgg=;
 b=Ciy+ktxQbV/R9QviaZ86z70t/IuF963sxpwQExGtOftWIY7SpmCsS233oCjlak++lh
 WQ8vrb1LJJSVkhd2rvo0sEg+k1zWblj2NFxtMe77y+73ROll1hONh6hJEcCHKzgvULhi
 A06SivsZzmKj67Y5jAMbhwz8Qr3f+3+LpPm7TXprQJf5biCOhNxAIX8jJ+e7wU6EvLsu
 TRYeydccD5ilbNMMpwBRJlWF+0gNT1tIX7YUhWJY6fwBqhXEvgo4bJBSjY/d2MKyjwaf
 xGGizT4kEgS2DlYyNxsSiDMzakL+J8r4bN/fSPFSN/6sUkosdxToOXNVtSYiBXaEI7eW
 9vAA==
X-Gm-Message-State: AOJu0YzwwL7xYuHJed0u7hCAgVp31ffRhVSTeU8V7MB6AJ0NDEekM/Ew
 nAR2iRcmxtvFFnEbZHsoF+5x4oPhCLCgStsBMPlX26+scPF1KhhL34kgocWWI5Gc
X-Gm-Gg: ASbGncvr3cL44gO0wM2nFUO2z/gE9QK+v33dbntj0K6W5LwCicnGjrSGKRjkm+i5fF0
 AbgBPrCAhaVkkyppsqI6W1P6F+WOZx5RzJX/RW9ArB7DMPl4B+Jn+6lgzYbj6LcwF0guJIjmbHv
 N8Rgou59FM+kpHsFIdRf0VF+pQzG3Hj5WcuJecKv6iYiY7yZjoE8+5nAUXIS7rdoxkRAV9Ktg5Y
 rW0HVZeL6Xhpw1FDC83SDS4luvW//aH9tpCu8ZC33cpLE/1tfyxONBoP+5V6a2rKtNN5CvJsqqQ
 8GvJcYRFqkaEDOr3hnOctjTA57cAF+YwqiJ2WeaSmtDnm/NY+am2iEuEgmHVPU+pCEbhpX6llG9
 NkQ==
X-Google-Smtp-Source: AGHT+IG8qFmIyjuSnwD7udxRvG5jdfIQRM1jBTYNGbvj34ekrvmSFiIXaJIrnPKivHUYKG51OhkoZQ==
X-Received: by 2002:a05:600c:3e88:b0:43d:fa59:af98 with SMTP id
 5b1f17b1804b1-442fd671c82mr36347725e9.33.1747407685898; 
 Fri, 16 May 2025 08:01:25 -0700 (PDT)
Received: from localhost ([94.239.154.20]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-442f39ef8bbsm111682575e9.37.2025.05.16.08.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 08:01:25 -0700 (PDT)
From: conte.souleymane@gmail.com
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org,
 Souleymane Conte <conte.souleymane@gmail.com>
Subject: [PATCH v2 1/1] docs/interop: convert text files to restructuredText
Date: Fri, 16 May 2025 15:00:52 +0000
Message-ID: <20250516150052.30818-3-conte.souleymane@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516150052.30818-1-conte.souleymane@gmail.com>
References: <20250516150052.30818-1-conte.souleymane@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=conte.souleymane@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Souleymane Conte <conte.souleymane@gmail.com>

buglink: https://gitlab.com/qemu-project/qemu/-/issues/527

Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
---
 docs/interop/index.rst                |   1 +
 docs/interop/{qcow2.txt => qcow2.rst} | 218 +++++++++++++++-----------
 2 files changed, 128 insertions(+), 91 deletions(-)
 rename docs/interop/{qcow2.txt => qcow2.rst} (88%)

diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 999e44eae1..bfe3cf0beb 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -23,6 +23,7 @@ are useful for making QEMU interoperate with other software.
    qemu-ga-ref
    qemu-qmp-ref
    qemu-storage-daemon-qmp-ref
+   qcow2
    vhost-user
    vhost-user-gpu
    vhost-vdpa
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.rst
similarity index 88%
rename from docs/interop/qcow2.txt
rename to docs/interop/qcow2.rst
index 2c4618375a..2295dd4ae6 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.rst
@@ -1,6 +1,8 @@
-== General ==
+================
+Qcow2 Image File
+================
 
-A qcow2 image file is organized in units of constant size, which are called
+A *qcow2* image file is organized in units of constant size, which are called
 (host) clusters. A cluster is the unit in which all allocations are done,
 both for actual guest data and for image metadata.
 
@@ -9,10 +11,10 @@ clusters of the same size.
 
 All numbers in qcow2 are stored in Big Endian byte order.
 
+Header
+------
 
-== Header ==
-
-The first cluster of a qcow2 image contains the file header:
+The first cluster of a qcow2 image contains the file header::
 
     Byte  0 -  3:   magic
                     QCOW magic string ("QFI\xfb")
@@ -38,7 +40,7 @@ The first cluster of a qcow2 image contains the file header:
                     within a cluster (1 << cluster_bits is the cluster size).
                     Must not be less than 9 (i.e. 512 byte clusters).
 
-                    Note: qemu as of today has an implementation limit of 2 MB
+                    Note: Qemu as of today has an implementation limit of 2 MB
                     as the maximum cluster size and won't be able to open images
                     with larger cluster sizes.
 
@@ -48,7 +50,7 @@ The first cluster of a qcow2 image contains the file header:
          24 - 31:   size
                     Virtual disk size in bytes.
 
-                    Note: qemu has an implementation limit of 32 MB as
+                    Note: Qemu has an implementation limit of 32 MB as
                     the maximum L1 table size.  With a 2 MB cluster
                     size, it is unable to populate a virtual cluster
                     beyond 2 EB (61 bits); with a 512 byte cluster
@@ -88,6 +90,7 @@ The first cluster of a qcow2 image contains the file header:
 For version 2, the header is exactly 72 bytes in length, and finishes here.
 For version 3 or higher, the header length is at least 104 bytes, including
 the next fields through header_length.
+::
 
          72 -  79:  incompatible_features
                     Bitmask of incompatible features. An implementation must
@@ -185,7 +188,8 @@ the next fields through header_length.
                     of 8.
 
 
-=== Additional fields (version 3 and higher) ===
+Additional fields (version 3 and higher)
+----------------------------------------
 
 In general, these fields are optional and may be safely ignored by the software,
 as well as filled by zeros (which is equal to field absence), if software needs
@@ -193,21 +197,25 @@ to set field B, but does not care about field A which precedes B. More
 formally, additional fields have the following compatibility rules:
 
 1. If the value of the additional field must not be ignored for correct
-handling of the file, it will be accompanied by a corresponding incompatible
-feature bit.
+   handling of the file, it will be accompanied by a corresponding incompatible
+   feature bit.
 
 2. If there are no unrecognized incompatible feature bits set, an unknown
-additional field may be safely ignored other than preserving its value when
-rewriting the image header.
+   additional field may be safely ignored other than preserving its value when
+   rewriting the image header.
+
+.. _ref_rules_3:
 
 3. An explicit value of 0 will have the same behavior as when the field is not
-present*, if not altered by a specific incompatible bit.
+   present*, if not altered by a specific incompatible bit.
 
-*. A field is considered not present when header_length is less than or equal
+(*) A field is considered not present when *header_length* is less than or equal
 to the field's offset. Also, all additional fields are not present for
 version 2.
 
-              104:  compression_type
+::
+
+        104:        compression_type
 
                     Defines the compression method used for compressed clusters.
                     All compressed clusters in an image use the same compression
@@ -219,28 +227,30 @@ version 2.
                     or must be zero (which means deflate).
 
                     Available compression type values:
-                        0: deflate <https://www.ietf.org/rfc/rfc1951.txt>
-                        1: zstd <http://github.com/facebook/zstd>
+                       - 0: deflate https://www.ietf.org/rfc/rfc1951.txt
+                       - 1: zstd <http://github.com/facebook/zstd>
 
-                    The deflate compression type is called "zlib"
+                    The deflate compression type is called zlib
                     <https://www.zlib.net/> in QEMU. However, clusters with the
                     deflate compression type do not have zlib headers.
 
         105 - 111:  Padding, contents defined below.
 
-=== Header padding ===
+Header padding
+--------------
 
-@header_length must be a multiple of 8, which means that if the end of the last
+*header_length* must be a multiple of 8, which means that if the end of the last
 additional field is not aligned, some padding is needed. This padding must be
 zeroed, so that if some existing (or future) additional field will fall into
-the padding, it will be interpreted accordingly to point [3.] of the previous
+the padding, it will be interpreted accordingly to point `[3.] <#ref_rules_3>`_ of the previous
 paragraph, i.e.  in the same manner as when this field is not present.
 
 
-=== Header extensions ===
+Header extensions
+-----------------
 
 Directly after the image header, optional sections called header extensions can
-be stored. Each extension has a structure like the following:
+be stored. Each extension has a structure like the following::
 
     Byte  0 -  3:   Header extension type:
                         0x00000000 - End of the header extension area
@@ -270,17 +280,19 @@ data of compatible features that it doesn't support. Compatible features that
 need space for additional data can use a header extension.
 
 
-== String header extensions ==
+String header extensions
+------------------------
 
 Some header extensions (such as the backing file format name and the external
 data file name) are just a single string. In this case, the header extension
 length is the string length and the string is not '\0' terminated. (The header
-extension padding can make it look like a string is '\0' terminated, but
+extension padding can make it looks like a string is '\0' terminated, but
 neither is padding always necessary nor is there a guarantee that zero bytes
 are used for padding.)
 
 
-== Feature name table ==
+Feature name table
+------------------
 
 The feature name table is an optional header extension that contains the name
 for features used by the image. It can be used by applications that don't know
@@ -288,7 +300,7 @@ the respective feature (e.g. because the feature was introduced only later) to
 display a useful error message.
 
 The number of entries in the feature name table is determined by the length of
-the header extension data. Each entry look like this:
+the header extension data. Each entry looks like this::
 
     Byte       0:   Type of feature (select feature bitmap)
                         0: Incompatible feature
@@ -302,7 +314,8 @@ the header extension data. Each entry look like this:
                     terminated if it has full length)
 
 
-== Bitmaps extension ==
+Bitmaps extension
+-----------------
 
 The bitmaps extension is an optional header extension. It provides the ability
 to store bitmaps related to a virtual disk. For now, there is only one bitmap
@@ -312,7 +325,7 @@ point in time.
 The data of the extension should be considered consistent only if the
 corresponding auto-clear feature bit is set, see autoclear_features above.
 
-The fields of the bitmaps extension are:
+The fields of the bitmaps extension are::
 
     Byte  0 -  3:  nb_bitmaps
                    The number of bitmaps contained in the image. Must be
@@ -331,15 +344,17 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
-== Full disk encryption header pointer ==
+Full disk encryption header pointer
+-----------------------------------
 
 The full disk encryption header must be present if, and only if, the
-'crypt_method' header requires metadata. Currently this is only true
-of the 'LUKS' crypt method. The header extension must be absent for
+*crypt_method* header requires metadata. Currently this is only true
+of the *LUKS* crypt method. The header extension must be absent for
 other methods.
 
 This header provides the offset at which the crypt method can store
 its additional data, as well as the length of such data.
+::
 
     Byte  0 -  7:   Offset into the image file at which the encryption
                     header starts in bytes. Must be aligned to a cluster
@@ -357,10 +372,10 @@ The first 592 bytes of the header clusters will contain the LUKS
 partition header. This is then followed by the key material data areas.
 The size of the key material data areas is determined by the number of
 stripes in the key slot and key size. Refer to the LUKS format
-specification ('docs/on-disk-format.pdf' in the cryptsetup source
+specification (*docs/on-disk-format.pdf* in the cryptsetup source
 package) for details of the LUKS partition header format.
 
-In the LUKS partition header, the "payload-offset" field will be
+In the LUKS partition header, the **payload-offset** field will be
 calculated as normal for the LUKS spec. ie the size of the LUKS
 header, plus key material regions, plus padding, relative to the
 start of the LUKS header. This offset value is not required to be
@@ -369,7 +384,7 @@ context of qcow2, since the qcow2 file format itself defines where
 the real payload offset is, but none the less a valid payload offset
 should always be present.
 
-In the LUKS key slots header, the "key-material-offset" is relative
+In the LUKS key slots header, the **key-material-offset** is relative
 to the start of the LUKS header clusters in the qcow2 container,
 not the start of the qcow2 file.
 
@@ -377,35 +392,42 @@ Logically the layout looks like
 
   +-----------------------------+
   | QCow2 header                |
+  +-----------------------------+
   | QCow2 header extension X    |
+  +-----------------------------+
   | QCow2 header extension FDE  |
+  +-----------------------------+
   | QCow2 header extension ...  |
+  +-----------------------------+
   | QCow2 header extension Z    |
   +-----------------------------+
+  | ...                         |
+  +-----------------------------+
+  | ...                         |
+  +-----------------------------+
   | ....other QCow2 tables....  |
-  .                             .
-  .                             .
   +-----------------------------+
-  | +-------------------------+ |
-  | | LUKS partition header   | |
-  | +-------------------------+ |
-  | | LUKS key material 1     | |
-  | +-------------------------+ |
-  | | LUKS key material 2     | |
-  | +-------------------------+ |
-  | | LUKS key material ...   | |
-  | +-------------------------+ |
-  | | LUKS key material 8     | |
-  | +-------------------------+ |
+  | +------------------------+  |
+  | | LUKS partition header  |  |
+  | +------------------------+  |
+  | | LUKS key material 1    |  |
+  | +------------------------+  |
+  | | LUKS key material 2    |  |
+  | +------------------------+  |
+  | | LUKS key material ...  |  |
+  | +------------------------+  |
+  | | LUKS key material 8    |  |
+  | +------------------------+  |
+  +-----------------------------+
+  |   QCow2 cluster payload     |
+  +-----------------------------+
+  |                             |
   +-----------------------------+
-  | QCow2 cluster payload       |
-  .                             .
-  .                             .
-  .                             .
   |                             |
   +-----------------------------+
 
-== Data encryption ==
+Data encryption
+---------------
 
 When an encryption method is requested in the header, the image payload
 data must be encrypted/decrypted on every write/read. The image headers
@@ -413,7 +435,7 @@ and metadata are never encrypted.
 
 The algorithms used for encryption vary depending on the method
 
- - AES:
+ - **AES**:
 
    The AES cipher, in CBC mode, with 256 bit keys.
 
@@ -425,7 +447,7 @@ The algorithms used for encryption vary depending on the method
    supported in the command line tools for the sake of back compatibility
    and data liberation.
 
- - LUKS:
+ - **LUKS**:
 
    The algorithms are specified in the LUKS header.
 
@@ -433,7 +455,8 @@ The algorithms used for encryption vary depending on the method
    in the LUKS header, with the physical disk sector as the
    input tweak.
 
-== Host cluster management ==
+Host cluster management
+-----------------------
 
 qcow2 manages the allocation of host clusters by maintaining a reference count
 for each host cluster. A refcount of 0 means that the cluster is free, 1 means
@@ -453,14 +476,15 @@ Although a large enough refcount table can reserve clusters past 64 PB
 large), note that some qcow2 metadata such as L1/L2 tables must point
 to clusters prior to that point.
 
-Note: qemu has an implementation limit of 8 MB as the maximum refcount
-table size.  With a 2 MB cluster size and a default refcount_order of
-4, it is unable to reference host resources beyond 2 EB (61 bits); in
-the worst case, with a 512 cluster size and refcount_order of 6, it is
-unable to access beyond 32 GB (35 bits).
+.. note::
+    Qemu has an implementation limit of 8 MB as the maximum refcount
+    table size.  With a 2 MB cluster size and a default refcount_order of
+    4, it is unable to reference host resources beyond 2 EB (61 bits); in
+    the worst case, with a 512 cluster size and refcount_order of 6, it is
+    unable to access beyond 32 GB (35 bits).
 
 Given an offset into the image file, the refcount of its cluster can be
-obtained as follows:
+obtained as follows::
 
     refcount_block_entries = (cluster_size * 8 / refcount_bits)
 
@@ -470,7 +494,7 @@ obtained as follows:
     refcount_block = load_cluster(refcount_table[refcount_table_index]);
     return refcount_block[refcount_block_index];
 
-Refcount table entry:
+Refcount table entry::
 
     Bit  0 -  8:    Reserved (set to 0)
 
@@ -482,14 +506,15 @@ Refcount table entry:
                     been allocated. All refcounts managed by this refcount block
                     are 0.
 
-Refcount block entry (x = refcount_bits - 1):
+Refcount block entry (x = refcount_bits - 1)::
 
     Bit  0 -  x:    Reference count of the cluster. If refcount_bits implies a
                     sub-byte width, note that bit 0 means the least significant
                     bit in this context.
 
 
-== Cluster mapping ==
+Cluster mapping
+---------------
 
 Just as for refcounts, qcow2 uses a two-level structure for the mapping of
 guest clusters to host clusters. They are called L1 and L2 table.
@@ -509,7 +534,7 @@ compressed clusters to reside below 512 TB (49 bits), and this limit
 cannot be relaxed without an incompatible layout change).
 
 Given an offset into the virtual disk, the offset into the image file can be
-obtained as follows:
+obtained as follows::
 
     l2_entries = (cluster_size / sizeof(uint64_t))        [*]
 
@@ -523,7 +548,7 @@ obtained as follows:
 
     [*] this changes if Extended L2 Entries are enabled, see next section
 
-L1 table entry:
+L1 table entry::
 
     Bit  0 -  8:    Reserved (set to 0)
 
@@ -538,7 +563,7 @@ L1 table entry:
                     refcount is exactly one. This information is only accurate
                     in the active L1 table.
 
-L2 table entry:
+L2 table entry::
 
     Bit  0 -  61:   Cluster descriptor
 
@@ -555,7 +580,7 @@ L2 table entry:
                     mapping for guest cluster offsets), so this bit should be 1
                     for all allocated clusters.
 
-Standard Cluster Descriptor:
+Standard Cluster Descriptor::
 
     Bit       0:    If set to 1, the cluster reads as all zeros. The host
                     cluster offset can be used to describe a preallocation,
@@ -577,7 +602,7 @@ Standard Cluster Descriptor:
         56 - 61:    Reserved (set to 0)
 
 
-Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
+Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8))::
 
     Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
                     cluster or sector boundary!  If cluster_bits is
@@ -601,7 +626,8 @@ file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
 no backing file or the backing file is smaller than the image, they shall read
 zeros for all parts that are not covered by the backing file.
 
-== Extended L2 Entries ==
+Extended L2 Entries
+-------------------
 
 An image uses Extended L2 Entries if bit 4 is set on the incompatible_features
 field of the header.
@@ -615,6 +641,8 @@ subclusters so they are treated the same as in images without this feature.
 The size of an extended L2 entry is 128 bits so the number of entries per table
 is calculated using this formula:
 
+.. code::
+
     l2_entries = (cluster_size / (2 * sizeof(uint64_t)))
 
 The first 64 bits have the same format as the standard L2 table entry described
@@ -623,7 +651,7 @@ descriptor.
 
 The last 64 bits contain a subcluster allocation bitmap with this format:
 
-Subcluster Allocation Bitmap (for standard clusters):
+Subcluster Allocation Bitmap (for standard clusters)::
 
     Bit  0 - 31:    Allocation status (one bit per subcluster)
 
@@ -647,13 +675,14 @@ Subcluster Allocation Bitmap (for standard clusters):
                     Bits are assigned starting from the least significant
                     one (i.e. bit x is used for subcluster x - 32).
 
-Subcluster Allocation Bitmap (for compressed clusters):
+Subcluster Allocation Bitmap (for compressed clusters)::
 
     Bit  0 - 63:    Reserved (set to 0)
                     Compressed clusters don't have subclusters,
                     so this field is not used.
 
-== Snapshots ==
+Snapshots
+---------
 
 qcow2 supports internal snapshots. Their basic principle of operation is to
 switch the active L1 table, so that a different set of host clusters are
@@ -672,7 +701,7 @@ in the image file, whose starting offset and length are given by the header
 fields snapshots_offset and nb_snapshots. The entries of the snapshot table
 have variable length, depending on the length of ID, name and extra data.
 
-Snapshot table entry:
+Snapshot table entry::
 
     Byte 0 -  7:    Offset into the image file at which the L1 table for the
                     snapshot starts. Must be aligned to a cluster boundary.
@@ -728,7 +757,8 @@ Snapshot table entry:
                     next multiple of 8.
 
 
-== Bitmaps ==
+Bitmaps
+-------
 
 As mentioned above, the bitmaps extension provides the ability to store bitmaps
 related to a virtual disk. This section describes how these bitmaps are stored.
@@ -739,12 +769,15 @@ each bitmap size is equal to the virtual disk size.
 Each bit of the bitmap is responsible for strictly defined range of the virtual
 disk. For bit number bit_nr the corresponding range (in bytes) will be:
 
+.. code::
+
     [bit_nr * bitmap_granularity .. (bit_nr + 1) * bitmap_granularity - 1]
 
 Granularity is a property of the concrete bitmap, see below.
 
 
-=== Bitmap directory ===
+Bitmap directory
+----------------
 
 Each bitmap saved in the image is described in a bitmap directory entry. The
 bitmap directory is a contiguous area in the image file, whose starting offset
@@ -752,7 +785,7 @@ and length are given by the header extension fields bitmap_directory_offset and
 bitmap_directory_size. The entries of the bitmap directory have variable
 length, depending on the lengths of the bitmap name and extra data.
 
-Structure of a bitmap directory entry:
+Structure of a bitmap directory entry::
 
     Byte 0 -  7:    bitmap_table_offset
                     Offset into the image file at which the bitmap table
@@ -833,7 +866,8 @@ Structure of a bitmap directory entry:
                     next multiple of 8. All bytes of the padding must be zero.
 
 
-=== Bitmap table ===
+Bitmap table
+------------
 
 Each bitmap is stored using a one-level structure (as opposed to two-level
 structures like for refcounts and guest clusters mapping) for the mapping of
@@ -843,7 +877,7 @@ Each bitmap table has a variable size (stored in the bitmap directory entry)
 and may use multiple clusters, however, it must be contiguous in the image
 file.
 
-Structure of a bitmap table entry:
+Structure of a bitmap table entry::
 
     Bit       0:    Reserved and must be zero if bits 9 - 55 are non-zero.
                     If bits 9 - 55 are zero:
@@ -860,11 +894,12 @@ Structure of a bitmap table entry:
         56 - 63:    Reserved and must be zero.
 
 
-=== Bitmap data ===
+Bitmap data
+-----------
 
 As noted above, bitmap data is stored in separate clusters, described by the
 bitmap table. Given an offset (in bytes) into the bitmap data, the offset into
-the image file can be obtained as follows:
+the image file can be obtained as follows::
 
     image_offset(bitmap_data_offset) =
         bitmap_table[bitmap_data_offset / cluster_size] +
@@ -875,7 +910,7 @@ above).
 
 Given an offset byte_nr into the virtual disk and the bitmap's granularity, the
 bit offset into the image file to the corresponding bit of the bitmap can be
-calculated like this:
+calculated like this::
 
     bit_offset(byte_nr) =
         image_offset(byte_nr / granularity / 8) * 8 +
@@ -886,21 +921,22 @@ last cluster of the bitmap data contains some unused tail bits. These bits must
 be zero.
 
 
-=== Dirty tracking bitmaps ===
+Dirty tracking bitmaps
+----------------------
 
-Bitmaps with 'type' field equal to one are dirty tracking bitmaps.
+Bitmaps with *type* field equal to one are dirty tracking bitmaps.
 
-When the virtual disk is in use dirty tracking bitmap may be 'enabled' or
-'disabled'. While the bitmap is 'enabled', all writes to the virtual disk
+When the virtual disk is in use dirty tracking bitmap may be *enabled* or
+*disabled*. While the bitmap is *enabled*, all writes to the virtual disk
 should be reflected in the bitmap. A set bit in the bitmap means that the
 corresponding range of the virtual disk (see above) was written to while the
-bitmap was 'enabled'. An unset bit means that this range was not written to.
+bitmap was *enabled*. An unset bit means that this range was not written to.
 
 The software doesn't have to sync the bitmap in the image file with its
-representation in RAM after each write or metadata change. Flag 'in_use'
+representation in RAM after each write or metadata change. Flag *in_use*
 should be set while the bitmap is not synced.
 
-In the image file the 'enabled' state is reflected by the 'auto' flag. If this
-flag is set, the software must consider the bitmap as 'enabled' and start
+In the image file the *enabled* state is reflected by the *auto* flag. If this
+flag is set, the software must consider the bitmap as *enabled* and start
 tracking virtual disk changes to this bitmap from the first write to the
 virtual disk. If this flag is not set then the bitmap is disabled.
-- 
2.49.0


