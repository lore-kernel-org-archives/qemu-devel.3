Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AB8CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmGQ-0007mX-MN; Tue, 28 Oct 2025 12:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDmFt-0007gv-9C
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:09:05 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vDmFm-0008B6-46
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:09:05 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9EB4446657
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761667732;
 bh=mCoONKxHaPrOpR0ms/9YaPzZKQu8xNXbFPAQ6ZmgPnw=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=CdrQL7dZiZG7BiWL4f8uIfAIs8P7hoXZCGKGGOw8+/4GZ4HysOQwoVQktUUwrSZlA
 yF9DMIwxLZkd35TuDxP6h3ovk+KnmcYqIGiM3ln1U0ljOwmhC4znU7XAq+H8SUpads
 gDmq3BoEocSXsLJ5+Ks/xo582xLlWcC5izpRzUD56t/KtBwwGOyvzPGBv+1Jaxcc9l
 p1RpeuA474w77RQhbRl5wrpk9Apa8qHjSh+/IrLoHIiAF8UMS+47DgF+eFgFC9AMDo
 tRdwe2RDJtzIRAGBv8a3AYSsHPWo6ERdRSSlCcAx0kObypP/oCFxsW9hntktCy5Byp
 SjfthUruMTOd1xyoil8ABFGodsxq6kk8Pw3QTg8ydzTA/sfGGoV0nURhJu7USgen9m
 hVy4lQdkJOjdJW+uHMP7byTOvNBHswOvNte7hM2WyhG+KQf6mpd4OUDqCaCQMH7YJy
 k79g0HnqtkEFYFeOMHFXXx6Spntgy5bCEzX0vQ/dzujGJmmhqAKK56A/vYyKZUfw87
 qqCCBKtP4u7zUHXpIk70Rl/K1tL0hgpWvXpUgBUHQXsXgrLpTW3zTMAq7ciQ5Jb1Dm
 8k2UsKdXs3ltoZLQiNFLGkYv/ClztnFyXwhx7qxK+SOTNJuBZ0CL/0z+sA4cW6ePQi
 83bUSFqRwy9g7kdSRwWqu5bQ=
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-9435917adb9so409182839f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761667731; x=1762272531;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCoONKxHaPrOpR0ms/9YaPzZKQu8xNXbFPAQ6ZmgPnw=;
 b=jMdLA75putzI9CuNj2wFegtNKl8zxTAF6o6DPzNTvKr3MNGh6JmoVCfh3LzLM8Fosq
 xNFXvpMSlwqnRKSvX+4uJekfymezRaW3IFW+tBqUO65/3NgJxVLyMqPrVLGmL4LZ/hHr
 vH2nnxTM+9Qcrg20y2xJ664ZimQhJt+29+rqwXT8E7sLbOwldkfPprlqE3xv3sIbQu6I
 m+76DF2C9smyPrfhPVQH/ANfdiZEHF7TEwKy189oj/x21oNS5q//cOxzO98OnVxhN+ry
 Jilc3w6TStK/+ZbzdTMr5VcPMoguEleHosp5wrSXus7p3kGc+gR6P8edRt8K/au458l4
 kMlQ==
X-Gm-Message-State: AOJu0YzD0tBwEXftldRC8taTRUUviKiSV9o6YkthBhM1RHttjRMZPuvN
 hT8nmVspG12fZBPaDo7q7TEYBTLOrdoONLhvLP7melYuj6MiZgvfxcd5t0PYJDg81BG2y+zV1Ox
 Jr/XrCz66EgZfBLxcjicGYD5SULm/+BqcSbpY1NGJ815sQwLEyz0yYS2N7JeovnqlEUOHqfM4OU
 KE4+WS
X-Gm-Gg: ASbGncsUGqy82M1cZXiIQ7yGnY6rKC0GMYSvocqHNE0Q+/OAdT8kMh1HBenwx79mnQp
 +32ox+wBxZ4O1JHJB8jrUyXXSjVNBP2dcS0RiM6ZVG/UMgRlXjcP23Yv/IR6AyGmf5ZBEUXUn3E
 rX1j43I+FxbKskiH+XfvAKTLNh4bV2sBxjOwZTCTmvPlGjGWdGa6yka1E8VzfLTIa/oWQM1f9J7
 8EV6X/TvT6IFLjSxgPHwVj9A/LDW3k/mfclmN+qAG5FyH31uQe7OJPpGUGYQ2aJDG/bCRPBoIb+
 PYvXxV9ubEziZpWDbbppaWtfdh6mYml2CrQ5Q2ra269ftxP14qeYm/oD8JxRxzG2YEm+NJxx5eG
 8YUYD24sx89tyOyvY
X-Received: by 2002:a05:6e02:32c2:b0:430:aec5:9bee with SMTP id
 e9e14a558f8ab-432f82b290emr3939315ab.7.1761667730965; 
 Tue, 28 Oct 2025 09:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGELV5/+ENFWpyN2Q9MEx9mVpLSi1Lj0tQEuO4WAP0w8ACWF4X/i6HSWKztAN1hpStbcd8IbQ==
X-Received: by 2002:a05:6e02:32c2:b0:430:aec5:9bee with SMTP id
 e9e14a558f8ab-432f82b290emr3938845ab.7.1761667730468; 
 Tue, 28 Oct 2025 09:08:50 -0700 (PDT)
Received: from resolute.lxd ([147.219.77.79]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5aea9e35c4asm4558721173.56.2025.10.28.09.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:08:50 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 28 Oct 2025 11:08:22 -0500
Subject: [PATCH 2/2] block: Drop detach_subchain for bdrv_replace_node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-third-fix-3149-v1-2-bf3c712d2439@canonical.com>
References: <20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com>
In-Reply-To: <20251028-third-fix-3149-v1-0-bf3c712d2439@canonical.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6542;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=9eBLH8aGQtXfNtDxWk75CE0rE3PCBA1PsgSymL7wga8=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBpAOqOvh1v9nMDo3BIZK7A3K3n8U9xcfcSIWYFO
 jfYdhGgUJiJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCaQDqjgAKCRD5KICs4jod
 uU/pC/wK2qtcP+VY+hXE/9a522VEc4IIG4pezsw+/vjlNxWbOJauiA0E+NZcObTKsJOpt8yCi0U
 KZLh8zlma7WrxRMY2iLwQRfr1Mrlc8ZskyRVey4W+tv/dR5gozJT1g/fEbAxXFkV/t9tAnEy+9Z
 n0laPPviDsPmWcycYksZbpZiDQZjfn7u1Iv0LRoB177xDsqjfQqDtGTjiAOptgf8MX6AJImRmiV
 O73fkJH/s6uK5RkgLj8tIkanKVmykX4ECdxlCcr9Lp++U+vRCNqcuGHOoCGSOFyxYbvVj9LjO7T
 J4OxEHsPdsClhWrkGiyAUvZ1Kvpl+15LysZwnvk4cqVbz6QPfbZcUILfJZ/S8Tqn49VVUL7qVbN
 u2K1iSIAdvTM914ky9kyboUNHeFOhwME+kZWF+2DiRoz90dZbFrwmPlbc/YMw8OovSPkmAGHDag
 ains6tk30uY3BR5iJc+xDjHNGEJnfpbLe4ssInq2ke/h5H6aoZFOT5ODnsO2RoMZ3t5rY=
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 block.c | 38 ++++----------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

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

-- 
2.51.0


