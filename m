Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88548CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Ya-0004Z6-7H; Tue, 23 Jun 2026 08:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YY-0004YD-H9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YW-00071N-Kq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24x9ENDYcEXyW0GKNdB3tM4NZHVw1V9yuGNfVyt1HX4=;
 b=Gx85a84uajaVJTuni+yU8mIzfOUjrTvEMUJiz1T0RwSjd/ROfBij3F3Jdki0UgYrnkX4d1
 dybvdtF8Dt+9H+daR4YPtaTDb5OO73xF3bq7IB792DXKHvMlhWBwaKOHHmT4f0qgCL0Qec
 b5ZSm97vQkLqnZS5H2tEyLyBc5XlZMw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ASSCnXDhNzuGG9uqK0egWQ-1; Tue, 23 Jun 2026 08:48:36 -0400
X-MC-Unique: ASSCnXDhNzuGG9uqK0egWQ-1
X-Mimecast-MFC-AGG-ID: ASSCnXDhNzuGG9uqK0egWQ_1782218915
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-519e4aaec80so82368041cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218915; x=1782823715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24x9ENDYcEXyW0GKNdB3tM4NZHVw1V9yuGNfVyt1HX4=;
 b=gYg06P4bF3FqKIS75c77VtAJsfLa256SxRrdfYmCbVNq0WibI9B4L4eYNs72iNE3ll
 Zd/BGDic+dhb4o4XSVKxYtZ+HYeq09FyIsg4ysHyvrHfjrM2cM/tIfse8kk9kUvIMzI+
 xx1y2O53ZMbx1SLTywtcysLCuJS45c4+j9rD1kFT+KjNFeYX6jBx2TE2FaV/mDkeoN2u
 SHniw6A1u8jjW6R+SBPRXV4fJLQuBke4epyRY9t6KdymePyKx+fARRwjqPIRR0xqoTEp
 3gRfuHrqDtusZa3PHKK2v4yllfk1aCX8WRff8v6qE2g7bKAtHJlMyvBuZjoTE3Tf9ZlB
 4xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218915; x=1782823715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24x9ENDYcEXyW0GKNdB3tM4NZHVw1V9yuGNfVyt1HX4=;
 b=TTkCjTpa5ctXuGEpmnV0N/ig/Cf2oUu7QxMpbWi1sPAbAWZLJFkYca0JaI13eITTtb
 uEl3Y3BnuG3Lr7rsvrVwEmo5k6zUYPi7tq9fgl24ZrKlnvQ2H7cygqNUm7RBq7FEprA7
 UzuOWvnQgrkjVJi2KQmhaiaPzSPAtriMGq9RIdFeno5oysra0+NoQDoSRJTGcEMQVPuy
 F+iayvAB08PuQmwmvskcGGoJC37Q0RJeTl4iBniIoH6Vlr1pusaMFnF7j+5RyokmY1v1
 TqXEsXXrUk0BDl7709DzZ5Ajj+iY7HgZJsbYobyzT/Wgt2+P1XPHwaah6S1qx9F7XUIM
 jNNQ==
X-Gm-Message-State: AOJu0Yw619Wt+5+EJF4Crsc1z48tjD4GjB0A/n+nzL0YIWnC1T7tyj3/
 /DNsIcb6JP1Lfn4KUZ26AQc9SlhtK5uPxT8fKki1Ces06Ago1xDnZsZtcPMHqC3ZYY3ryjBdTpX
 Ef4N47TARC4NMPlVlFT9QiA+ByW643eKxf1UhMxTd3v731SmdmX/ADFeddFjWYGrSa2XXiiJzHf
 n8c3ANNr76Cjn7d+P68EzYA2lZ3V48CU+VAZ2ikA==
X-Gm-Gg: AfdE7ckLNCieSUR9JQazQHPTXVKywMDWiKH0bxSiXKKWgHiFWHcmjRBsJYjSvLA2jtJ
 fomZISdyoi+eKImw+QXwkRSXr5LEDb7QIlxz9h3dMDbP7bOMXA8g/NRAinLN4l1JoHOJBbWTQEd
 d6Yyha6i98MKndMzvivc4niyYiUznGTqxWopVhzwfoLLC9Gfk0ykf+1Y9JRFVKA4bA8G84Z4bxO
 Xigy6hzqqnkiQkKQOonjFxuYle+sZKZCynebTINnaZ6pajkF6KYIcoiZJo3n+sC1iibR+865hkZ
 1JJm+ROjditaxqx5owx29gBYnT2yWr0LoosrdGzfw0Xa0vzNlr1Zv6Y2tL/WX7DpjwSNLJturt1
 Dkg==
X-Received: by 2002:a05:622a:4289:b0:517:9d3f:8f3 with SMTP id
 d75a77b69052e-519e49158c4mr276850271cf.5.1782218915289; 
 Tue, 23 Jun 2026 05:48:35 -0700 (PDT)
X-Received: by 2002:a05:622a:4289:b0:517:9d3f:8f3 with SMTP id
 d75a77b69052e-519e49158c4mr276849661cf.5.1782218914729; 
 Tue, 23 Jun 2026 05:48:34 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 11/18] system/ram-discard-manager: implement replay via
 is_populated iteration
Date: Tue, 23 Jun 2026 08:47:52 -0400
Message-ID: <20260623124759.125399-12-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace the source-level replay wrappers with a new
replay_by_populated_state() helper that iterates the section at
min-granularity, calls is_populated() for each chunk, and aggregates
consecutive chunks of the same state before invoking the callback.

This moves the iteration logic from individual sources into the manager,
preparing for multi-source aggregation where the manager must combine
state from multiple sources anyway.

The replay_populated/replay_discarded vtable entries in
RamDiscardSourceClass are no longer called but remain in the interface
for now; they will be removed in follow-up commits along with the
now-dead source implementations.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
Link: https://lore.kernel.org/r/20260604-rdm5-v5-4-5768e6a0943d@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ram-discard-manager.c | 85 ++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 1c9ff7fda5..a907ddf370 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -27,26 +27,65 @@ static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
     return rdsc->is_populated(rds, section);
 }
 
-static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
-                                               const MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
+/*
+ * Iterate the section at source granularity, aggregating consecutive chunks
+ * with matching populated state, and call replay_fn for each run.
+ */
+static int replay_by_populated_state(const RamDiscardManager *rdm,
+                                     const MemoryRegionSection *section,
+                                     bool replay_populated,
+                                     ReplayRamDiscardState replay_fn,
+                                     void *opaque)
 {
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+    uint64_t granularity, offset, size, end, pos, run_start = 0;
+    bool in_run = false;
+    int ret = 0;
 
-    g_assert(rdsc->replay_populated);
-    return rdsc->replay_populated(rds, section, replay_fn, opaque);
-}
+    granularity = ram_discard_source_get_min_granularity(rdm->rds, rdm->mr);
+    offset = section->offset_within_region;
+    size = int128_get64(section->size);
+    end = offset + size;
+
+    /* Align iteration to granularity boundaries */
+    pos = QEMU_ALIGN_DOWN(offset, granularity);
+
+    for (; pos < end; pos += granularity) {
+        MemoryRegionSection chunk = {
+            .mr = section->mr,
+            .offset_within_region = pos,
+            .size = int128_make64(granularity),
+        };
+        bool populated = ram_discard_source_is_populated(rdm->rds, &chunk);
+
+        if (populated == replay_populated) {
+            if (!in_run) {
+                run_start = pos;
+                in_run = true;
+            }
+        } else if (in_run) {
+            MemoryRegionSection tmp = *section;
+
+            if (memory_region_section_intersect_range(&tmp, run_start,
+                                                      pos - run_start)) {
+                ret = replay_fn(&tmp, opaque);
+                if (ret) {
+                    return ret;
+                }
+            }
+            in_run = false;
+        }
+    }
 
-static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
-                                               const MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
-{
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+    if (in_run) {
+        MemoryRegionSection tmp = *section;
 
-    g_assert(rdsc->replay_discarded);
-    return rdsc->replay_discarded(rds, section, replay_fn, opaque);
+        if (memory_region_section_intersect_range(&tmp, run_start,
+                                                  pos - run_start)) {
+            ret = replay_fn(&tmp, opaque);
+        }
+    }
+
+    return ret;
 }
 
 RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
@@ -78,8 +117,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    return ram_discard_source_replay_populated(rdm->rds, section,
-                                               replay_fn, opaque);
+    return replay_by_populated_state(rdm, section, true, replay_fn, opaque);
 }
 
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
@@ -87,8 +125,7 @@ int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    return ram_discard_source_replay_discarded(rdm->rds, section,
-                                               replay_fn, opaque);
+    return replay_by_populated_state(rdm, section, false, replay_fn, opaque);
 }
 
 static void ram_discard_manager_initfn(Object *obj)
@@ -182,8 +219,8 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
     rdl->section = memory_region_section_new_copy(section);
     QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
 
-    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                              rdm_populate_cb, rdl);
+    ret = ram_discard_manager_replay_populated(rdm, rdl->section,
+                                               rdm_populate_cb, rdl);
     if (ret) {
         error_report("%s: Replaying populated ranges failed: %s", __func__,
                      strerror(-ret));
@@ -208,8 +245,8 @@ int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)
     int ret = 0;
 
     QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
-        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                                  rdm_populate_cb, rdl);
+        ret = ram_discard_manager_replay_populated(rdm, rdl->section,
+                                                   rdm_populate_cb, rdl);
         if (ret) {
             break;
         }
-- 
2.54.0


