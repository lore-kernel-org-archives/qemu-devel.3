Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B76C369D3
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 23:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Ay2-0006gY-MU; Sun, 27 Apr 2025 18:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1u9Axz-0006d4-FM; Sun, 27 Apr 2025 18:59:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1u9Axs-0007Ak-Jj; Sun, 27 Apr 2025 18:59:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso49120825e9.3; 
 Sun, 27 Apr 2025 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745794749; x=1746399549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSuwgn3kwaToSHFvmtmMXzxOsbtyQZbX33X5rqvsZxU=;
 b=WSIULo/aF6G6ML7JgJy8g3aqBTDbsBJLOQtoXCfxjfjtuYMedHymrHOZNhhvzknlBl
 5HrRMfl9ALpDYGXeMjNgBrOP9cstoiTSVcKYOrD9Lx2Xk/KG1V9nSSMvR8NdTrRlO51k
 zCw95L+nX3sXPAdlJO/f820sqYgLFgzRlXEj9GP1a4t81Ccnt590TU23Os7wxR62Ls5k
 baji8O9FpZqt8m3i9woTqNTFryF92DPcseUMEL+MbJ9MxjZkNbET/WqKh56F4nDKds0j
 +lnT50Kmh87+wmgTzd0uB60/fsPR5ov2cv+fuE4fpHJgntSzGZs21F2UtFqpMzN1OgMg
 ZHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745794749; x=1746399549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HSuwgn3kwaToSHFvmtmMXzxOsbtyQZbX33X5rqvsZxU=;
 b=j2lVdYp/J2aI7a040Cue4IpvTX5ltOG90HmU5cFt3Yakaq+Y1cNHWnexND0+0uwzhC
 cbEgRmFLXTjmREMdv2rAG32BVoVTiA2eEBDmG269nzENbrtYGBZK/Vtn+TUc2DEJFQlf
 uOgT8CCtsi66LIU0asMQB1UNEuRrzMC6MH9zIs2IXP1wTBSpcfONNpBpseeEM52yiPcR
 jFZrDFtG/Ic8DJdDJf0W9TZ7X+ZnPfvmKP+qhbX/FxKauzbNCc2FEHRwq0V1XEO0dKXw
 gofVhqWbuhyT2YVBVSGejlvn8TEjG4GxVCK22oeSmuMXJp/9xYD1lShAC5gGTWqtZzJP
 282A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWGlaI48MNOsZhq1/YouZl9cMMjcxSvN4NgNep9nu4mJF/p0n61slZxeYT1omqslimuD3Hezg0H+zP@nongnu.org
X-Gm-Message-State: AOJu0Yw9napq4Ayy76B9gl4zxYHxAmk5An4Gn5eepLUmMztlcs5Ve/QB
 2Z1vWtdpTyX/w2C3h80wi/c2GmmatyEY5uITrbs0LxBYB2xL1iDDFDs3lekG
X-Gm-Gg: ASbGnctSQzkJuVpdju7nFPqjDNkgc6pbV8c4vFxid3+u+nZX6Esvna9PedQUIHwNYcN
 K1Yqgz6kTWGnocmoABpGpPPgUKqDA2QDtcQUeCNI4Sa4FVgdVDBydSZFtJeAEXv9NwLSo+cqNVT
 Vd4ul7JnwF6eA3pNbiHAxIhxLLoi4noF1G1kNQgf9gsUdOuFzjbBU1cisFLNpl/rC4JN3hT74v3
 rcSa3klvzIS8cLUVfP2Vebcfy+XraK+YGZUhQCW+wffcm0/ZoA5gcBmmjtns2h7vGli0ireC3rX
 EkAqzRKzkAiR3BAHPAAjLx+JhTQd46piSJZlCTM1ybAhNsN20SXjk3JU9uh0vv7665+AShZOlvV
 t6jPZMVIJdsQFHO3nlOZJgilF/VOm
X-Google-Smtp-Source: AGHT+IEc9i3q1YnwpFzxCGe/OJT8SWB+7F+kd0M3pEjKhdmofZAefL4JadNRdb2j0Z2CAazGHaj82g==
X-Received: by 2002:a05:6000:2207:b0:3a0:839b:f52c with SMTP id
 ffacd0b85a97d-3a0839bf543mr1350794f8f.0.1745794749024; 
 Sun, 27 Apr 2025 15:59:09 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da4dsm9499765f8f.99.2025.04.27.15.59.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Apr 2025 15:59:07 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH 2/2] block/null: Add read-pattern option
Date: Mon, 28 Apr 2025 01:59:00 +0300
Message-Id: <20250427225900.24316-3-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250427225900.24316-1-nirsof@gmail.com>
References: <20250427225900.24316-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32f.google.com
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

When the `read-zeroes` is set, reads produce zeroes, and block status
return BDRV_BLOCK_ZERO, emulating a sparse image.

If we don't set `read-zeros` we report BDRV_BLOCK_DATA, but image data
is undefined; posix_memalign, _aligned_malloc, valloc, or memalign do
not promise to zero allocated memory.

When computing a blkhash of an image via qemu-nbd, we want to test 3
cases:

1. Sparse image: skip reading the entire image based on block status
   result, and use a pre-computed zero block hash.
2. Image full of zeroes: read the entire image, detect block full of
   zeroes and skip block hash computation.
3. Image full of data: read the entire image and compute a hash of all
   blocks.

This change adds `read-pattern` option. If the option is set, reads
produce the specified pattern. With this option we can emulate an image
full of zeroes or full of non-zeroes.

Specifying both `read-zeroes` and `read-pattern != 0` is not useful
since `read-zeroes` implies a sparse image.  In this case `read-zeroes`
wins and we ignore the pattern. Maybe we need to make the options mutual
exclusive.

The following examples shows how the new option can be used with blksum
(or nbdcopy --blkhash) to compute a blkhash of an image using the
null-co driver.

Sparse image - the very fast path:

    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/sparse.sock \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-zeroes': true}}" &

    % time blksum 'nbd+unix:///?socket=/tmp/sparse.sock'
    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/sparse.sock
    blksum 'nbd+unix:///?socket=/tmp/sparse.sock'  0.05s user 0.01s system 92% cpu 0.061 total

Image full of zeros - same hash, 268 times slower:

    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/zero.sock \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': 0}}" &

    % time blksum 'nbd+unix:///?socket=/tmp/zero.sock'
    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/zero.sock
    blksum 'nbd+unix:///?socket=/tmp/zero.sock'  7.45s user 22.57s system 183% cpu 16.347 total

Image full of data - difference hash, heavy cpu usage:

    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/data.sock \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': -1}}" &

    % time blksum 'nbd+unix:///?socket=/tmp/data.sock'
    2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  nbd+unix:///?socket=/tmp/data.sock
    blksum 'nbd+unix:///?socket=/tmp/data.sock'  46.05s user 14.15s system 448% cpu 13.414 total

Tested on top of
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 block/null.c         | 17 +++++++++++++++++
 qapi/block-core.json |  9 ++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/block/null.c b/block/null.c
index 7ba87bd9a9..cbd7d1fdbd 100644
--- a/block/null.c
+++ b/block/null.c
@@ -22,11 +22,14 @@
 
 #define NULL_OPT_LATENCY "latency-ns"
 #define NULL_OPT_ZEROES  "read-zeroes"
+#define NULL_OPT_PATTERN  "read-pattern"
 
 typedef struct {
     int64_t length;
     int64_t latency_ns;
     bool read_zeroes;
+    bool has_read_pattern;
+    int read_pattern;
 } BDRVNullState;
 
 static QemuOptsList runtime_opts = {
@@ -49,6 +52,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "return zeroes when read",
         },
+        {
+            .name = NULL_OPT_PATTERN,
+            .type = QEMU_OPT_NUMBER,
+            .help = "return pattern when read",
+        },
         { /* end of list */ }
     },
 };
@@ -95,6 +103,10 @@ static int null_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -EINVAL;
     }
     s->read_zeroes = qemu_opt_get_bool(opts, NULL_OPT_ZEROES, false);
+    s->has_read_pattern = qemu_opt_find(opts, NULL_OPT_PATTERN) != NULL;
+    if (s->has_read_pattern) {
+        s->read_pattern = qemu_opt_get_number(opts, NULL_OPT_PATTERN, 0);
+    }
     qemu_opts_del(opts);
     bs->supported_write_flags = BDRV_REQ_FUA;
     return ret;
@@ -125,6 +137,8 @@ static coroutine_fn int null_co_preadv(BlockDriverState *bs,
 
     if (s->read_zeroes) {
         qemu_iovec_memset(qiov, 0, 0, bytes);
+    } else if (s->has_read_pattern) {
+        qemu_iovec_memset(qiov, 0, s->read_pattern, bytes);
     }
 
     return null_co_common(bs);
@@ -199,6 +213,8 @@ static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
 
     if (s->read_zeroes) {
         qemu_iovec_memset(qiov, 0, 0, bytes);
+    } else if (s->has_read_pattern) {
+        qemu_iovec_memset(qiov, 0, s->read_pattern, bytes);
     }
 
     return null_aio_common(bs, cb, opaque);
@@ -272,6 +288,7 @@ null_co_get_allocated_file_size(BlockDriverState *bs)
 static const char *const null_strong_runtime_opts[] = {
     BLOCK_OPT_SIZE,
     NULL_OPT_ZEROES,
+    NULL_OPT_PATTERN,
 
     NULL
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e1..7d576cccbb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3297,10 +3297,17 @@
 #     false, the buffer is left unchanged.
 #     (default: false; since: 4.1)
 #
+# @read-pattern: if set, reads from the device produce the specified
+#     pattern; if unset, the buffer is left unchanged.
+#     (since: 10.1)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNull',
-  'data': { '*size': 'int', '*latency-ns': 'uint64', '*read-zeroes': 'bool' } }
+  'data': { '*size': 'int',
+            '*latency-ns': 'uint64',
+            '*read-zeroes': 'bool',
+            '*read-pattern': 'int' } }
 
 ##
 # @BlockdevOptionsNVMe:
-- 
2.39.5 (Apple Git-154)


