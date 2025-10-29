Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B72CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6DY-0008VZ-6m; Wed, 29 Oct 2025 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vE6DW-0008VI-7Y
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:27:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vE6DK-0000Au-Cn
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:27:57 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CE5133FB53
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761744458;
 bh=/K2wrfbvBInugKUiCSifNvqsZdkRVrhlMDJ9TFXboxQ=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=KDYxeg5wLiLnfSEoHeD5trKqiPFvbh8aqzopehv5Z8klHQ3dA0IMtxSljDT9r1IVf
 Q81Z+Iq8isSwQ4fpOAbRdYk2OZoMzU7ZSL9j+ktDfBktN3MSQ5/KDhl+bxJ0Lk9xPg
 QG3MqzmdqFyA43KmF1Su5wDTVQsZVT1KXadEhfbuorIjnKkAcx1bWuNOO02X2Wq20Z
 wyuSRYaAJtO+LIkO+0ZyLERbbG0KGp75Svtrl5U0i0/rb291j3I03mErNylNP4xjuX
 O9nx5KjyucO54s9jATrTg+N0Vb4qUQfi7hWy/UuKFki2SUxz6UqnoddehFpFILKNa/
 GNJVRFNSCANySjt66TnR/runms/72n8E0Up1gGyMgIbluW9F7gipoGrlu9zf3hTlcL
 WPxTRLngt8eHBKF3Sn6p7oet1Q1xhGXn/h47aRUm7N1GK30KpuppFS29JXYHfYct5R
 Xg7rM2kgoOS6nx+P69fXSlDuAjBEqtU09oblseu+7FAFmWS2eSOPF265bvP2vGb/VT
 Cn7KF8Pgs4znlXujvRtJyyDjyC4oES1iGLjh2BxVuCo+hdH4/qH9IKOJ/9h/XdtGmg
 KR+UvgkdU0UNCx6S/mz0Z/ju21UR8MOM47YJHDKnG4C+rJ0Ds3oCAYL8anN6StiC2W
 r68fFpme71tTCoLE36w4OE7U=
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-430da49fb0aso200260695ab.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761744456; x=1762349256;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/K2wrfbvBInugKUiCSifNvqsZdkRVrhlMDJ9TFXboxQ=;
 b=OHRcoTFnzd/fLqQlxRhmfFCU8Bkc/MZ4UPhSDakBXxiheatlWC+CflYfCP4Cfz4uIN
 8wOVeM+6ZzCJMjTo7A6jmiu5F1Zl7uvECRq1arIa/QqATWD920A6RxlTJSUz3syTef3s
 kZR0c4fLNIlL3YM/8I+gjeviyxsX7MDriy3sZFy9cQAF8wvLABmnwW8f7KfSV7eV6rxv
 eRnfWcAXGcXrBJJyNEAJjNpRFx9YTysowmA6hkJp1u5ujK/D8ZOj8Q3wIvvViSTbqxO4
 s434jdcmoQuh9+D45aE38gAQL+6uoqsP17mmpSCfVuHKkdwoxJrJzJ4FHtuzc7keazXw
 AP/A==
X-Gm-Message-State: AOJu0YxlAihumxj+E1hZmvq0zhvA7Nmj7BcuKDpihZC3XXmRRwME7NK+
 44mqUJZyAljaSfpTC6xKiOFhBKVv1clIKoyDq7H8vKqw3iJddQ3hfUqZ1SJHTcpK+xQP8md1hu4
 qtPxV7+/hd7LP71ufMjaYRsY+1ZiTkT4xgKh3hOPr6DUEN+UEN9HAXCUcR2ezmjdCgr2ij4KUR1
 1RH83yyyQ=
X-Gm-Gg: ASbGncuKYLAG8kVFAo41ndtH3VjdiJYTjMvCmNQalbGMPglzT2mZ0mG3faRiZYN0IKQ
 +7Ui7KrarcvsRAcV5dBmpNWP4Oi6/C1BAdSTc5qKjDnECTRv1P3UQ50B73Yv3Tl6uSvDYeWWAe/
 3yfoded30TPuPYftvSB5A7a17QfyVKmFTpcWFHfjnw2o9hYTRQECW5yUaiQdne7yoMIUwkdMLJh
 +i5YcVhgIa9FbdOLXBppIorLKAhR6cnAjIncPLYppDcxVCQhkr0QAMeTH9owXMwhdy76CgGI5ZV
 WltlJF7/EDNozJUpOGbDHkVIU7JKYijZcaZ+7ZS1JNx53IScWIk4cUBvW4jxiHYVAWZ9xOicQGN
 duFJWGgKJHEnuTuc+
X-Received: by 2002:a05:6e02:1527:b0:430:cecb:9e77 with SMTP id
 e9e14a558f8ab-432f904c513mr37419405ab.27.1761744455911; 
 Wed, 29 Oct 2025 06:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHQzx1CCB0cD8DlFPspJkurXzHqB79ZHdrQAVvUWFIub15KrGUEUhwVBI9yJX8mfYMDa9Qkw==
X-Received: by 2002:a05:6e02:1527:b0:430:cecb:9e77 with SMTP id
 e9e14a558f8ab-432f904c513mr37418785ab.27.1761744455320; 
 Wed, 29 Oct 2025 06:27:35 -0700 (PDT)
Received: from resolute.lxd ([147.219.77.79]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5aea9e38679sm5549750173.63.2025.10.29.06.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 06:27:34 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Wed, 29 Oct 2025 08:27:02 -0500
Subject: [PATCH v2] block: Drop detach_subchain for bdrv_replace_node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-third-fix-3149-v2-1-94932bb404f4@canonical.com>
X-B4-Tracking: v=1; b=H4sIACUWAmkC/12MzQqDMBCEX0X23C1mo0R76nsUD5qfutAmkkhoE
 d+9qdBLLwPfDPNtkGxkm+BSbRBt5sTBF6BTBXoe/d0im8JANbWiJoXrzNGg4xdK0fTYduSMkiW
 nHsppibZsh/A2FJ45rSG+D38W3/an6v5VWWCNk5NaCTLUyP6qRx886/Fx1uEJw77vHyZf82iwA
 AAA
X-Change-ID: 20251027-third-fix-3149-582fd7382fb9
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16410;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=+eb6q16QB0R7zU3M1DXlKgIHjyI+ttcnwpgEHpVPz4o=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBpAhZFlidFIe2ssHsrU+MBSgBOlzJviAMLWWD5h
 8JVBOwj3JyJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCaQIWRQAKCRD5KICs4jod
 uVGODACs0JzE1EKyhjr3X0NqXb7M9Bpmtc++BL0dzza2GSu2Jwgv6pRJIS/1XA1EWUSC/CaQzjT
 KJR+i5phT9OFoZK+4zm+loarfyJnzLYb0LCeKkOfvlA4Yyh+UHNXjR9e3RGzOc9ZR+bRKPVkDBj
 0/jz32s7UGr9a18sNvFSzwwCEm9GhZzk3nEfsOwGj7KLG7HRdHJB5DOrEwGDQ0eJNaoORqNm929
 TxYcEDuiMgTmpaPvA8v6TqmBLcIcPsZriiMnMe8ccoX6P7TONdQly86Ci+47qsEMEH7NPDiygZO
 m+G0BjPS4f2pCeVrA6QSUwX9dt08rg2ESpm+p9OEXHs4iG+3ZFUHlHB+wRn4YJq6Z5pqqwq3cvc
 KZBq+dhiRDLiD3H05qj+MldgPqifgDnhCNJDbX1/mxs9IAGlmhXNMZu7et5tuTafyqqeCv0cCMQ
 bbgN9JWdcJi9H+LGJkEnuKqwRZlS8Kv+t4YviNwjFoOBUvLKwmd/VefPp949XUXc8/Vk8=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Detaching filters using detach_subchain=true can cause segfaults as
described in #3149.

More specifically, this was observed when executing concurrent
block-stream and query-named-block-nodes. block-stream adds a
copy-on-read filter as the main BDS for the blockjob; that filter was
dropped with detach_subchain=true but not unref'd until the the blockjob
was free'd. Because query-named-block-nodes assumes that a filter will
always have exactly one child, it caused a segfault when it observed the
detached filter. Stacktrace:

0  bdrv_refresh_filename (bs=0x5efed72f8350)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
1  0x00005efea73cf9dc in bdrv_block_device_info
    (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
    at block/qapi.c:62
2  0x00005efea7391ed3 in bdrv_named_nodes_list
    (flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
3  0x00005efea7471993 in qmp_query_named_block_nodes
    (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
4  qmp_marshal_query_named_block_nodes
    (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
    at qapi/qapi-commands-block-core.c:553
5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
    at qapi/qmp-dispatch.c:128
6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
    at util/async.c:219
7  0x00005efea74ffdb2 in aio_dispatch (ctx=0x5efed6f3f430)
    at util/aio-posix.c:436
8  0x00005efea7512846 in aio_ctx_dispatch (source=<optimized out>,
    callback=<optimized out>,user_data=<optimized out>)
    at util/async.c:361
9  0x00007f2b77809bfb in ?? ()
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
10 0x00007f2b77809e70 in g_main_context_dispatch ()
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
11 0x00005efea7517228 in glib_pollfds_poll () at util/main-loop.c:287
12 os_host_main_loop_wait (timeout=0) at util/main-loop.c:310
13 main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:589
14 0x00005efea7140482 in qemu_main_loop () at system/runstate.c:905
15 0x00005efea744e4e8 in qemu_default_main (opaque=opaque@entry=0x0)
    at system/main.c:50
16 0x00005efea6e76319 in main
    (argc=<optimized out>, argv=<optimized out>)
    at system/main.c:93

As discussed in 20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com,
a filter should not exist without children in the first place; therefore,
drop the parameter entirely as it is only used for filters.

This is a partial revert of 3108a15cf09865456d499b08fe14e3dbec4ccbb3.

After this change, a blockdev-backup job's copy-before-write filter will
hold references to its children until the filter is unref'd. This causes
an additional flush during bdrv_close, so also update iotest 257.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
Thank you all for the discussion in the previous thread:
20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com

I have verified that this patch resolves the issue from #3149 and passes
the iotests for qcow2/raw/nbd that don't fail on master (for me). Thanks
for the pointers on testing.

I'm committed to finding a solution to this that is adequately
understood and tested; I'm happy to continue to make
adjustments/submissions as needed until we have a solution that is
satisfying.

Please let me know if any adjustments are needed; thanks for your
patience and continued involvement.
---
Changes in v2:
- Merged test changes into the patch
- Link to v1: https://lore.kernel.org/qemu-devel/20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com
---
 block.c                    | 38 ++++----------------------------------
 tests/qemu-iotests/257     |  8 ++++++--
 tests/qemu-iotests/257.out | 14 +++++++-------
 3 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/block.c b/block.c
index 8848e9a7ed665a1bfbde2aba29e2c414f5bbe39b..72261ea1d4b0e5232a429a1c0dcdd5c29cd77452 100644
--- a/block.c
+++ b/block.c
@@ -5386,17 +5386,13 @@ bdrv_replace_node_noperm(BlockDriverState *from,
  *
  * With auto_skip=false the error is returned if from has a parent which should
  * not be updated.
- *
- * With @detach_subchain=true @to must be in a backing chain of @from. In this
- * case backing link of the cow-parent of @to is removed.
  */
 static int GRAPH_WRLOCK
 bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
-                         bool auto_skip, bool detach_subchain, Error **errp)
+                         bool auto_skip, Error **errp)
 {
     Transaction *tran = tran_new();
     g_autoptr(GSList) refresh_list = NULL;
-    BlockDriverState *to_cow_parent = NULL;
     int ret;
 
     GLOBAL_STATE_CODE();
@@ -5405,17 +5401,6 @@ bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
     assert(to->quiesce_counter);
     assert(bdrv_get_aio_context(from) == bdrv_get_aio_context(to));
 
-    if (detach_subchain) {
-        assert(bdrv_chain_contains(from, to));
-        assert(from != to);
-        for (to_cow_parent = from;
-             bdrv_filter_or_cow_bs(to_cow_parent) != to;
-             to_cow_parent = bdrv_filter_or_cow_bs(to_cow_parent))
-        {
-            ;
-        }
-    }
-
     /*
      * Do the replacement without permission update.
      * Replacement may influence the permissions, we should calculate new
@@ -5427,11 +5412,6 @@ bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
         goto out;
     }
 
-    if (detach_subchain) {
-        /* to_cow_parent is already drained because from is drained */
-        bdrv_remove_child(bdrv_filter_or_cow_child(to_cow_parent), tran);
-    }
-
     refresh_list = g_slist_prepend(refresh_list, to);
     refresh_list = g_slist_prepend(refresh_list, from);
 
@@ -5450,7 +5430,7 @@ out:
 int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                       Error **errp)
 {
-    return bdrv_replace_node_common(from, to, true, false, errp);
+    return bdrv_replace_node_common(from, to, true, errp);
 }
 
 int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
@@ -5466,7 +5446,7 @@ int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
 
     bdrv_drained_begin(child_bs);
     bdrv_graph_wrlock();
-    ret = bdrv_replace_node_common(bs, child_bs, true, true, errp);
+    ret = bdrv_replace_node_common(bs, child_bs, true, errp);
     bdrv_graph_wrunlock();
     bdrv_drained_end(child_bs);
 
@@ -5917,17 +5897,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         updated_children = g_slist_prepend(updated_children, c);
     }
 
-    /*
-     * It seems correct to pass detach_subchain=true here, but it triggers
-     * one more yet not fixed bug, when due to nested aio_poll loop we switch to
-     * another drained section, which modify the graph (for example, removing
-     * the child, which we keep in updated_children list). So, it's a TODO.
-     *
-     * Note, bug triggered if pass detach_subchain=true here and run
-     * test-bdrv-drain. test_drop_intermediate_poll() test-case will crash.
-     * That's a FIXME.
-     */
-    bdrv_replace_node_common(top, base, false, false, &local_err);
+    bdrv_replace_node_common(top, base, false, &local_err);
     bdrv_graph_wrunlock();
 
     if (local_err) {
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 7d3720b8e593bbe17a4b49ac0f07e1d209bda820..cd0468aaa1621c195586379b09594a550ce7c18a 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -310,14 +310,18 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                     'state': 1,
                     'new_state': 2
                 }, {
-                    'event': 'read_aio',
+                    'event': 'flush_to_disk',
                     'state': 2,
                     'new_state': 3
+                }, {
+                    'event': "read_aio",
+                    'state': 3,
+                    'new_state': 4
                 }],
                 'inject-error': [{
                     'event': 'read_aio',
                     'errno': 5,
-                    'state': 3,
+                    'state': 4,
                     'immediately': False,
                     'once': True
                 }]
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index c33dd7f3a907fd1212e7624b66d7a0937f37a1c7..fb28333cb2fab0e7f25990b889ae9253abcc40b8 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -272,7 +272,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -1017,7 +1017,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -1762,7 +1762,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -2507,7 +2507,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -3252,7 +3252,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -3997,7 +3997,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -4742,7 +4742,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---

---
base-commit: e090e0312dc9030d94e38e3d98a88718d3561e4e
change-id: 20251027-third-fix-3149-582fd7382fb9

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


