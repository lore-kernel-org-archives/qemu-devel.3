Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F09CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP4z-0001cS-JU; Wed, 07 Oct 2026 06:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <39f9fb4e48dfd08ed6d05519be5a28898a3bf872@kylie.crudebyte.com>)
 id 1xEP4k-0001ZU-PE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:40:45 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <39f9fb4e48dfd08ed6d05519be5a28898a3bf872@kylie.crudebyte.com>)
 id 1xEP4i-0008JI-9Q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=3zV0SyuLfl4cXCeKgbw25ksaRvw9cRl5Y4iT4sduGCs=; b=TYNqD
 j21w4+z6XgeMmODnhYm3Q3stAiZ4d3RsbJez6pesZ8/EDrJ5QZD4EDnS7ZKeCEhcLfNcy7us4gM2a
 0mtx1DidfRWjWVF6/20oixis4eSc4gPCg9iRaVSYAIFLVB6XUlct9l4esHivgJA3hEnwK2Y9yOoJR
 c2JQzcUdlk5CKKAW1tqO9VhifQpbm7XFRtzRCDhtc/VJA/VIpk67DkxpWrA7Mz0qNbvzkmsNI9UV7
 dg7m+gXMRM7nSFF7Lpbj2yjREQ5m4Yq/9lJs9FZAhMWb7KoE9mzOBT4YWm6scObjulIkC2G6zEZ/a
 Wo9fe/osmluugrMIYdA1REQOSgCN7b1jw0J1Ss8EvWFGCUp3nZp7gAsWhXTO/chOMkfL5aU9j4FRL
 GeWqhuiepHjfihrRUqQuC/5Oc5zjSaPa9tOA9ShcXfeEOFlTmZIHeXEqm2I8//U8VdN7gXiPQ8AIs
 C6EmXx1wmDxM3QVi2qw+Ox8tQ88iMQRJtexBywmJ8NoeM7cwsF3dD09hLE97qcxp05tW8Btlyhszt
 v3OeiQyGJ8uOezeeIpGWPodKHlzeaPQcsLX5ychvSS8pfs7CSKssgDrJMxFMriRAxAqLlPlGwVPZQ
 LbZd8o9M0zYt/+N12CL6+lPAOSoE+DlKwV2paah5gUKXnKTZdw2JG2EYf3xDQQ=;
Message-ID: <39f9fb4e48dfd08ed6d05519be5a28898a3bf872.1791368962.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1791368962.git.qemu_oss@crudebyte.com>
References: <cover.1791368962.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 7 Oct 2026 12:28:15 +0200
Subject: [PATCH v2 9/9] tests/9p-race: add Tread-on-dir race test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=39f9fb4e48dfd08ed6d05519be5a28898a3bf872@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add "race/tread-dir" test, a test racing legacy (9p2000.u)
Tread requests against each other on the same directory FID.

This test guards the previous fix patch ("hw/9pfs: fix dirent
stream protection for legacy (9p2000.u) Tread").

In each round a configurable number (V9FS_RACE_NCONCURRENT) of
concurrent Tread requests are issued against each other, verifying
that every Tread response lists the same (leading) directory entries
as a reference directory entry list taken before the actual
concurrent Tread request sequence starts.

A vulnerable server would return directory entries either with
corrupted entry names, or entries in varying order, or even crash
the QEMU process due to garbage dirent seek targets.

This test is explicitly using a 9p2000.u session, as Tread on
directories is not a 9p2000.L feature (the latter uses Treaddir
instead).

This test is registered as slow test (i.e. skipped by default) and
therefore requires -m slow to run.

On my test machine a full run of 20000 rounds took around 5 minutes
to complete.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-race-test.c | 410 ++++++++++++++++++++++++++++--
 1 file changed, 393 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/virtio-9p-race-test.c b/tests/qtest/virtio-9p-race-test.c
index d2b76bf075..9d3c9f0a23 100644
--- a/tests/qtest/virtio-9p-race-test.c
+++ b/tests/qtest/virtio-9p-race-test.c
@@ -270,28 +270,52 @@ static void v9p_race_create_subdir_chain(QVirtio9P *v9p)
 
     for (i = 1; i <= V9P_RACE_DIR_DEPTH; ++i) {
         char dir[8];
-        char *wnames[] = { dir };
         uint16_t newfid =
             (i == 1) ? V9P_RACE_D1_FID
                      : (i == 2) ? V9P_RACE_D2_FID : V9P_RACE_D3_FID;
 
         snprintf(dir, sizeof(dir), "d%d", i);
-        v9fs_tmkdir((TMkdirOpt) {
-            .client = v9p,
-            .dfid = dfid,
-            .name = dir,
-            .mode = 0755,
-            .gid = 0,
-            .tag = v9p_race_new_tag(),
-        });
-        v9fs_twalk((TWalkOpt) {
-            .client = v9p,
-            .fid = dfid,
-            .newfid = newfid,
-            .nwname = 1,
-            .wnames = wnames,
-            .tag = v9p_race_new_tag(),
-        });
+        if (v9p->proto_version == V9FS_PROTO_2000L) {
+            char *wnames[] = { dir };
+
+            v9fs_tmkdir((TMkdirOpt) {
+                .client = v9p,
+                .dfid = dfid,
+                .name = dir,
+                .mode = 0755,
+                .gid = 0,
+                .tag = v9p_race_new_tag(),
+            });
+            v9fs_twalk((TWalkOpt) {
+                .client = v9p,
+                .fid = dfid,
+                .newfid = newfid,
+                .nwname = 1,
+                .wnames = wnames,
+                .tag = v9p_race_new_tag(),
+            });
+        } else {
+            /*
+             * clone dfid for Tcreate
+             *
+             * The legacy 9p2000(.u) Tcreate re-points the supplied FID to the
+             * created (in this case) directory and requires it to be unopened.
+             */
+            v9fs_twalk((TWalkOpt) {
+                .client = v9p,
+                .fid = dfid,
+                .newfid = newfid,
+                .nwname = 0, /* 0 -> clone FID */
+                .tag = v9p_race_new_tag(),
+            });
+            v9fs_tcreate((TCreateOpt) {
+                .client = v9p,
+                .fid = newfid,
+                .name = dir,
+                .perm = P9_CREATE_PERM_DMDIR | 0755,
+                .tag = v9p_race_new_tag(),
+            });
+        }
         dfid = newfid;
     }
 }
@@ -629,6 +653,357 @@ static void v9p_race_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
     fflush(stdout);
 }
 
+/* number of files created for "race/tread-dir" test */
+#define V9P_RACE_TREAD_DIR_NFILES 40
+
+/* returns true if @name is one of the dir entries known to exist in d3 */
+static bool v9p_race_tread_dir_entry_name_valid(const char *name)
+{
+    int n;
+
+    if (!strcmp(name, ".") || !strcmp(name, "..")) {
+        return true;
+    }
+    if (name[0] != 'f' || strlen(name) != 3) {
+        return false;
+    }
+    /*
+     * atoi() returns 0 on error, therefore the files created for this test
+     * start with 1, not zero.
+     */
+    n = atoi(&name[1]);
+    return n >= 1 && n <= V9P_RACE_TREAD_DIR_NFILES;
+}
+
+/*
+ * Read one directory entry (as v9stat struct) from Rread response.
+ *
+ * Only the directory entry's name is returned
+ * (in @name, at most @name_size - 1 chars).
+ *
+ * Returns the number of response body bytes consumed for this entry.
+ */
+static size_t v9p_race_tread_dir_next_entry(P9Req *req, char *name,
+                                            size_t name_size)
+{
+    /*
+     * Each directory entry within Tread response is (with 9p2000.u):
+     *
+     * size[2] type[2] dev[4] qid[13] mode[4] atime[4] mtime[4] length[8]
+     * name[s] uid[s] gid[s] muid[s] ext[s] n_uid[4] n_gid[4] n_muid[4]
+     */
+    uint16_t len = 0;
+    size_t consumed = 2 + 2 + 4 + 13 + 4 + 4 + 4 + 8;
+    int s;
+
+    /* fast forward to name[s] */
+    v9fs_memskip(req, consumed);
+
+    /* read name[s] */
+    v9fs_uint16_read(req, &len);
+    g_assert_cmpint(len, <, name_size);
+    v9fs_memread(req, name, len);
+    name[len] = '\0';
+    consumed += 2 + len;
+
+    /* consume the rest of this entry */
+    for (s = 0; s < 4; s++) { /* uid, gid, muid, ext */
+        v9fs_string_read(req, &len, NULL);
+        consumed += 2 + len;
+    }
+    v9fs_memskip(req, 4 + 4 + 4); /* n_uid, n_gid, n_muid */
+    consumed += 4 + 4 + 4;
+
+    return consumed;
+}
+
+/*
+ * Parse and verify an Rread response.
+ *
+ * We have created V9P_RACE_TREAD_DIR_NFILES number of files in directory d3,
+ * so we already know the file name scheme to verify for individual entries.
+ *
+ * Additionally, compare the returned directory entries with the passed
+ * reference list of entries. They must always match exactly in name and order.
+ */
+static void v9p_race_tread_dir_verify_rread(P9Req *req,
+                                            const char *const *ref_names,
+                                            int n_ref_names)
+{
+    uint32_t count = 0, consumed = 0;
+    char name[64];
+    int ientry;
+
+    v9fs_uint32_read(req, &count);
+
+    for (ientry = 0; consumed < count; ientry++) {
+        consumed += v9p_race_tread_dir_next_entry(req, name, sizeof(name));
+        if (!v9p_race_tread_dir_entry_name_valid(name)) {
+            g_printerr("invalid dirent name: %.16s\n", name);
+            fflush(stderr);
+            g_assert_not_reached();
+        }
+        if (ref_names && ientry < n_ref_names) {
+            if (strcmp(name, ref_names[ientry]) != 0) {
+                g_printerr("entry-order mismatch at #%d: got '%s' expected "
+                           "'%s'\n", ientry, name, ref_names[ientry]);
+                fflush(stderr);
+                g_assert_not_reached();
+            }
+        }
+    }
+    /*
+     * an empty Rread body means the dirent stream was corrupted
+     * (e.g. by a garbage seek)
+     */
+    g_assert_cmpint(ientry, >, 0);
+}
+
+/*
+ * Wait for response for @req, then verify if response is an Rread response
+ * with expected tag, then verify all directory entries.
+ */
+static void v9p_race_tread_dir_collect(QVirtio9P *v9p, P9Req *req,
+                                       const char *const *ref_names,
+                                       int n_ref_names)
+{
+    uint32_t len;
+    P9MsgHeader hdr;
+
+    v9p_race_req_wait(v9p, req, &len);
+    v9fs_memread(req, &hdr, sizeof(hdr));
+    g_assert_cmpint(hdr.tag_le, ==, req->tag);
+    if (hdr.id != P9_RREAD) {
+        uint32_t ecode = 0;
+
+        if (hdr.id == P9_RERROR) {
+            v9fs_string_read(req, NULL, NULL); /* skip error string */
+        }
+        if (hdr.id == P9_RLERROR || hdr.id == P9_RERROR) {
+            v9fs_uint32_read(req, &ecode);
+        }
+        g_error("Tread on dir FID returned ID %d (ecode %u, %s)", hdr.id,
+                ecode, strerror(ecode));
+    }
+    g_assert_cmpint(hdr.size_le, >=, 11);
+    v9p_race_tread_dir_verify_rread(req, ref_names, n_ref_names);
+    v9fs_req_free(req);
+}
+
+/*
+ * Race legacy (9p2000.u) Tread requests against each other on the same
+ * directory FID.
+ *
+ * This test creates V9P_RACE_TREAD_DIR_NFILES number of files under directory
+ * d3 and verifies that (a portion of) these files are always returned by
+ * server in a stable manner (i.e. always exact same entry names, and in exact
+ * same order) for each Tread request sent on the same directory FID.
+ *
+ * We actually read less directory entries than we created files, just to keep
+ * things simple. A small amount of dir entries retrieval is still enough to
+ * detect corrupted Rread responses.
+ */
+static void v9p_race_tread_dir(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    if (v9p_race_skip()) {
+        return;
+    }
+
+    QVirtio9P *v9p = obj;
+    uint32_t rounds = v9p_race_rounds();
+    uint32_t i = 0, n;
+
+    /* max. Rread bytes requested per Tread request */
+    const uint32_t tread_size = 512;
+
+    /*
+     * Max. amount of reference directory entries taken for verification
+     * (kept small enough to fit into one tread_size Rread response)
+     */
+    const uint32_t ref_max = 8;
+
+    v9fs_set_allocator(t_alloc);
+
+    /*
+     * Need to set this session to legacy 9P2000.u dialect, because Tread on
+     * directories is only valid there (9p2000.L provides Treaddir instead).
+     */
+    v9fs_tversion((TVersionOpt) {
+        .client = v9p,
+        .version = "9P2000.u",
+        .tag = v9p_race_new_tag(),
+    });
+    v9fs_tattach((TAttachOpt) {
+        .client = v9p,
+        .fid = V9P_RACE_ROOT_FID,
+        .tag = v9p_race_new_tag(),
+    });
+
+    /* create d1/d2/d3 directory chain */
+    v9p_race_create_subdir_chain(v9p);
+
+    /* populate d3 with known directory entries */
+    for (n = 0; n < V9P_RACE_TREAD_DIR_NFILES; n++) {
+        char fname[8];
+
+        /*
+         * use a new FID for each file created, just to be sure
+         * (probably not really needed as we clunk it at the end of the loop)
+         */
+        uint16_t fid = 60 + (n % 32);
+
+        /* no in-flight requests, good to reset virtio descriptor pool */
+        v9p_race_reset_pool(v9p);
+
+        /*
+         * starting to create files by 1, not zero
+         * (see v9p_race_tread_dir_entry_name_valid() why)
+         */
+        snprintf(fname, sizeof(fname), "f%02d", n + 1);
+
+        /*
+         * clone d3 FID for Tcreate
+         *
+         * The legacy 9p2000(.u) Tcreate re-points the supplied FID to the
+         * created (in this case) file and requires it to be unopened.
+         */
+        v9fs_twalk((TWalkOpt) {
+            .client = v9p,
+            .fid = V9P_RACE_D3_FID,
+            .newfid = fid,
+            .nwname = 0, /* 0 -> clone FID */
+            .tag = v9p_race_new_tag(),
+        });
+        /* create the file */
+        v9fs_tcreate((TCreateOpt) {
+            .client = v9p,
+            .fid = fid,
+            .name = fname,
+            .tag = v9p_race_new_tag(),
+        });
+        v9p_race_clunk_relaxed(v9p, fid);
+    }
+
+    /* start the actual Tread-dir race test ... */
+    {
+        g_autofree char **ref_storage = g_new0(char *, ref_max);
+        g_autofree const char **ref_names = g_new0(const char *, ref_max);
+        uint32_t len = 0, count = 0, consumed = 0;
+        int idx = 0;
+        int ref_count = 0;
+        g_autofree P9Req **reqs = NULL;
+        int nreq, r;
+
+        /* no in-flight requests, good to reset virtio descriptor pool */
+        v9p_race_reset_pool(v9p);
+
+        /*
+         * Send and collect the initial "reference" Tread.
+         *
+         * One fundamental verification mechanism of this race test is to
+         * verify the order of the individual directory entries returned by
+         * server to be clean and stable. However the order is fs
+         * implementation specific, so we cannot simply assume the same order
+         * in which we created the files.
+         *
+         * Instead we first send out one safe (no race) Tread and use its
+         * entries returned as THE reference list of directory entries.
+         *
+         * Then in the concurrent Tread loop below, we compare the subsequently
+         * collected follow-up Tread responses to always exactly match those
+         * reference directory entries.
+         *
+         * One caveat: POSIX does not guarantee order of entries to be stable,
+         * however in practice for non-modified directories it is actually
+         * stable. Let's not overcomplicate things (exotic systems) as this
+         * test is not run by default anyway.
+         */
+        P9Req *req = v9fs_tread((TReadOpt) {
+            .client = v9p,
+            .fid = V9P_RACE_D3_FID,
+            .count = tread_size,
+            .tag = v9p_race_new_tag(),
+            .requestOnly = true,
+        }).req;
+        v9p_race_req_wait(v9p, req, &len);
+        {
+            P9MsgHeader hdr;
+
+            v9fs_memread(req, &hdr, sizeof(hdr));
+            g_assert_cmpint(hdr.id, ==, P9_RREAD);
+        }
+        v9fs_uint32_read(req, &count);
+
+        /* collect reference directory entries */
+        for (consumed = 0; consumed < count && idx < ref_max; idx++) {
+            char nbuf[64];
+
+            consumed += v9p_race_tread_dir_next_entry(req, nbuf, sizeof(nbuf));
+            g_assert(v9p_race_tread_dir_entry_name_valid(nbuf));
+            ref_storage[idx] = g_strdup(nbuf);
+            ref_names[idx] = ref_storage[idx];
+        }
+        v9fs_req_free(req);
+        ref_count = idx;
+        g_assert_cmpint(ref_count, >=, 2);
+
+        /* dump the reference list of entries */
+        g_print("race/tread-dir: reference listing: %d entries (as follows):\n",
+                ref_count);
+        for (i = 0; i < ref_count; i++) {
+            g_print("race/tread-dir: reference entry #%u: '%s'\n",
+                    i, ref_storage[i]);
+        }
+        fflush(stdout);
+
+        nreq = v9p_race_nconcurrent();
+        /*
+         * Limit the number of concurrent Tread requests to the descriptor pool
+         * size.
+         */
+        if (nreq > v9p->vq->size / 2) {
+            g_error("V9FS_RACE_NCONCURRENT: %d concurrent requests "
+                    "exceeds the queue's max. request amount of %d",
+                    nreq, v9p->vq->size / 2);
+        }
+        reqs = g_new0(P9Req *, nreq);
+
+        /* run the requested number of test rounds */
+        for (i = 0; i < rounds; i++) {
+            if (i % 2000 == 0) {
+                g_print("race/tread-dir: %u/%u rounds\n", i, rounds);
+                fflush(stdout);
+            }
+
+            /* no in-flight requests, good to reset virtio descriptor pool */
+            v9p_race_reset_pool(v9p);
+
+            /* send the actual concurrent Tread requests */
+            for (r = 0; r < nreq; r++) {
+                reqs[r] = v9fs_tread((TReadOpt) {
+                    .client = v9p,
+                    .fid = V9P_RACE_D3_FID,
+                    .count = tread_size,
+                    .tag = v9p_race_new_tag(),
+                    .requestOnly = true,
+                }).req;
+            }
+
+            /* collect and verify all responses */
+            for (r = 0; r < nreq; r++) {
+                v9p_race_tread_dir_collect(v9p, reqs[r], ref_names, ref_count);
+            }
+        }
+
+        for (i = 0; i < ref_max; i++) {
+            g_free(ref_storage[i]);
+        }
+    }
+
+    g_print("race/tread-dir: %u rounds done\n", rounds);
+    fflush(stdout);
+}
+
 /* setup and cleanup for race tests using the 9p 'local' fs driver */
 static void *v9p_race_local_driver(GString *cmd_line, void *arg)
 {
@@ -654,6 +1029,7 @@ static void v9p_race_register_tests(void)
 
     qos_add_test("race/fid-path", "virtio-9p", v9p_race_fid_path, &opts);
     qos_add_test("race/readdir", "virtio-9p", v9p_race_readdir, &opts);
+    qos_add_test("race/tread-dir", "virtio-9p", v9p_race_tread_dir, &opts);
 }
 
 libqos_init(v9p_race_register_tests);
-- 
2.47.3


