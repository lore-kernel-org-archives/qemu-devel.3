Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF343CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Yd-0004av-3i; Tue, 23 Jun 2026 08:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0Yb-0004a4-An
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YZ-00073B-MB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6j9IIN1re0pi/37Fxh9v0POSNlaYsqAG3daLdzi7VU=;
 b=Cnfh5sncQRjStSbWzDZdEpVjwyDQkgtS+trxf8SLJgYDlhPpkhJc5Vagfbp4EFwVvc2snr
 QfQvoQlZr5oODfMaFL4RRpy672QTXctnHLSdQS9Z5lxuh9/Ax6FObhC9DXq3l47n2BIykc
 tbpZtMGts50NxikrIsFFlBEDZ0/Uyjo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-MkINQp9QOGSc9JK3RO5DuQ-1; Tue, 23 Jun 2026 08:48:45 -0400
X-MC-Unique: MkINQp9QOGSc9JK3RO5DuQ-1
X-Mimecast-MFC-AGG-ID: MkINQp9QOGSc9JK3RO5DuQ_1782218925
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a19f736a1so57297571cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218925; x=1782823725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6j9IIN1re0pi/37Fxh9v0POSNlaYsqAG3daLdzi7VU=;
 b=smVxq8fQQWpYE0+azqHnHLlVFIzTx1lc2x4WEPtlEDUPQX0b6d7FYdPOq+5HbxA6J3
 yQklDojYZBfEtdxs54zOKY6Kb2SGpmro76lGzNXtmSAaAdC4NB45gdKeE4ThT2iQlAY4
 v0DeRHI/byR54HIe8vYZ6O8q8edc6Em12Dfol1vifD6MyJfkrPVwUwQipr/IhzMp8er6
 4DcOcs57kCxNGlL+QeWqYVd/7Rzt9wOw7Ht6Ulrrhejex9p7RyWd9q3PU+S6xg7HkENI
 1ozfcqBTjO20i3piKg5JkQsFPv94/lwGREDENQl6oz23a7aWWsFezcxI7BnB3vgeJ99p
 I4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218925; x=1782823725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o6j9IIN1re0pi/37Fxh9v0POSNlaYsqAG3daLdzi7VU=;
 b=blE8MtSXDcIwlLQUt0wjjPMa2m2lbTvSgQzalSAeQWt6R+do3WfVmxiYMU1UmHdSXA
 0eVYX5qyjsvSc28bJ+0hguXvbmFJbk8JFxbH9ehhLu5fEnwPJUcpOFq+ep+/zZrPbl5z
 CiSY5a4FQIlMbIXqi1VqGMiyuuIrQmRFUOFr1V8HWy7r/jlTN8KBthtPUtMfY5oQl2/j
 j6RBhSQL+JHaRihc3b58YLN4A3zT1TMUgyjKobdV78xPQ7CX3PoqkKBtZYfDU37zmMCQ
 7YN7HVCCZ/ydVBmG0EjtNaT7s3+KkkAJvfXW+GW+OFeSi7MYWwAJOX89whqJ2qaEZXNo
 +uKQ==
X-Gm-Message-State: AOJu0YxKcGM159mHJp5yfA7acmPItzFnBAeqznXodGpGmtdQb3UQEMTs
 9xNJCWvzB66DJpZTo6WCKxFxW2/KoMYjtnOHQjEdIO7fVmtej7UYtJypW+ZrmZBWPf3oqoFDwnq
 6UAVESG8gHA2XvDeuii3GKRdqqtX2uEXvt8PeZsyQGI2qgOjJmbP0XXuvZ+AaV8rpPtOuzDwVVH
 X5dq0+KYZSKRAlvB63Ybb+gpDDF3LXw2F7ivED3A==
X-Gm-Gg: AfdE7cn2oCqhXU9mQ01Mze2IfSLBnVcC15cG143AXN/3zUy3T+uo8RGXp1o+tICUc9r
 OLbqkBXGwI0weJFa43gxtaIb7OAfQ6iJjA3j55zTbQSl95SBrHaxFKp7YQkzsru3pMJLOi3rxAz
 +DJ/gdaIC4bDuSjeuDUMCuXqtlFIPPSTtRmFjZ0/BgAJ0JCTTQzdiEkcPC7Ak7mMxU1ByfzxK4s
 sXTJ60ZWr/u8dw6tjCLyWsN2r6nTl+GMZJcuUQYqo/ClK0GRsbW/pIjQ+z8nRe1Ejin8Zf7Z08L
 QcDVOjgZEel8EAlsxxaEB+8WKShQinr/CCWpHFHbenPG5ZuFb4b7/LHq2V1ZVY7ksECVjTJUBVQ
 wkQ==
X-Received: by 2002:a05:622a:ca:b0:516:d73d:2a34 with SMTP id
 d75a77b69052e-51a545b4a4amr43467631cf.5.1782218924779; 
 Tue, 23 Jun 2026 05:48:44 -0700 (PDT)
X-Received: by 2002:a05:622a:ca:b0:516:d73d:2a34 with SMTP id
 d75a77b69052e-51a545b4a4amr43466991cf.5.1782218924043; 
 Tue, 23 Jun 2026 05:48:44 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 16/18] system/memory: add RamDiscardManager reference counting
 and cleanup
Date: Tue, 23 Jun 2026 08:47:57 -0400
Message-ID: <20260623124759.125399-17-peterx@redhat.com>
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

Listeners now hold a reference to the RamDiscardManager, ensuring it
stays alive while listeners are registered. The RDM is eagerly freed
when the last source and listener are removed, and also unreffed during
MemoryRegion finalization as a safety net.

This completes the TODO left in the previous commit and prevents both
use-after-free and memory leaks of the RamDiscardManager.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260604-rdm5-v5-9-5768e6a0943d@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c              | 14 +++++++++++---
 system/ram-discard-manager.c |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 119fee0d34..5fc36708ec 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1771,6 +1771,7 @@ static void memory_region_finalize(Object *obj)
     memory_region_clear_coalescing(mr);
     g_free((char *)mr->name);
     g_free(mr->ioeventfds);
+    object_unref(mr->rdm);
 }
 
 Object *memory_region_owner(const MemoryRegion *mr)
@@ -2084,11 +2085,18 @@ int memory_region_add_ram_discard_source(MemoryRegion *mr,
 int memory_region_del_ram_discard_source(MemoryRegion *mr,
                                           RamDiscardSource *source)
 {
+    int ret;
     g_assert(mr->rdm);
 
-    return ram_discard_manager_del_source(mr->rdm, source);
-
-    /* if there is no source and no listener left, we could free rdm */
+    ret = ram_discard_manager_del_source(mr->rdm, source);
+    if (ret != 0) {
+        return ret;
+    }
+    if (QLIST_EMPTY(&mr->rdm->source_list) && QLIST_EMPTY(&mr->rdm->rdl_list)) {
+        object_unref(mr->rdm);
+        mr->rdm = NULL;
+    }
+    return 0;
 }
 
 /* Called with rcu_read_lock held.  */
diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 7da91bf648..4e8816e5a2 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -549,6 +549,7 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
 
     g_assert(section->mr == rdm->mr);
 
+    object_ref(rdm);
     rdl->section = memory_region_section_new_copy(section);
     QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
 
@@ -570,6 +571,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
     memory_region_section_free_copy(rdl->section);
     rdl->section = NULL;
     QLIST_REMOVE(rdl, next);
+    object_unref(rdm);
 }
 
 int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)
-- 
2.54.0


