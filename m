Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91C2C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyCs-00007U-EO; Mon, 17 Aug 2026 10:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCp-000060-PR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCo-0002fe-At
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpjpCejkLojUCVc87ev/0WjmuneloovioFsqiimDyY4=;
 b=ZCrAlsUMSoX8pO2KWkOu/Ix8/eJ68rKcfJPlyoNxgDTK5sk3wqYE3qCbX4mtcTgLg/lofm
 cZTwXbZkvASa6TreJlTE/iR6vTyAbGWooYwfA2azWNFet757Q8Wzinbr9MlxtzNvs3wFKJ
 a0CRCxZLLfDLBOIOWUPxbm58shQ35AE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-N4vwCYuUM3mECkS2xE750g-1; Mon, 17 Aug 2026 10:20:47 -0400
X-MC-Unique: N4vwCYuUM3mECkS2xE750g-1
X-Mimecast-MFC-AGG-ID: N4vwCYuUM3mECkS2xE750g_1786976446
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso53548375ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976446; x=1787581246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rpjpCejkLojUCVc87ev/0WjmuneloovioFsqiimDyY4=;
 b=s3XB9jzgUez0mMvKrUXwo0eBasYS7TlKtU/Y8qlA8WP6Qu1NTkHy79sYmGSAK+FqFR
 ChQVjmG4ihETV3Gmfa9PFSGWfddmyjXn7f88//hcyzmrvRvqWgS/DgjGrosr1wce9nOY
 qh7NqLw8ifJGKQPpjtB/ex1jMXTU3wXkw+3w/26cZuAY1tR1ViN+hTqdeCiF2TLxPs/x
 lNrE/k3lrHK4GEbZSgWESpZD588gUY4Bj/Y9h0rf5+EtHYjzkeVdSWI7/4EUM0kv8oXX
 684N5J+jwVhUZ8ixTVolvbYr7N0WYY+YOPmDoALsKacOh48+6Cs1cLR7esJkbNe8Ib9F
 34hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976446; x=1787581246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rpjpCejkLojUCVc87ev/0WjmuneloovioFsqiimDyY4=;
 b=A+3f9NHieOxSkYah74IHsMW3gHssPmjW1KVe7i4sJarM4ysE3luhE/ePiukNTkQZ87
 ymbxikQlMvrPyWfkm4b0R2rk5dq/J6pHBHZaMUjOazzJ2xXyiGpZG9vNwuZbpDz7LPLF
 67AJfcvkGAIeDi2lDloCSqovfU6WBkzruWSNAuZ1BHJHWDLYkiJCb2orxPbQVYnIfB+9
 3+cFdxwSsnFbvpn3hlyjuqJ9Byb7Qi9wVqJ2xAUgtOeyvid157tXekrzhvyCOxDho1ry
 OalS3Xh0CT71PqywswtJhLNDN91aTJEQ3fuiE6FyYGvgu1tCRnhnMwynRbxhL05cLinI
 rIvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhFTCV+SIfeoegT96kOB0ZMNR5wpxsL46nVkotQGgq+6ckrFbeoRDNoPg0tS3WINR4REFLWeSN0ylp@nongnu.org
X-Gm-Message-State: AOJu0YzsK8hxuK0ASVnUM58avs5fZB6NVpI8lCzpSNPmpYZxlQTrFT3G
 vuf90Ff/xbsJiYv+fkxh5jxK38qX1YbvN1z8QHmT6u75UT2F2yAlMjvGyRpME1xGUV+MRoebAwh
 Oqn3QXgFQ43hI3iwMeULmEVW1rEiRl+/NDFMoal+nvdkTRFYXG+8lG22+
X-Gm-Gg: AR+sD10cqaM8qbeEKKRmceggjKpgtRPeaNIZ7gJQQJDE5uAVNcDsjY/heWdxtu0p7nH
 ckbhdPivwCnLS/Iuo2z3PCop1wMx5lMQQwStwcQi80C0o/Gl/JKhpgfXPaalq3kpiOUJmpEjycR
 O74v0iIhkZpOb0NNh2X3U7nrELecoh3Sg4zvzuqWl8puvs1g3Pg5Pw63IG6M2Kiz76j9e2l5GsH
 y0PuhB5083vMI5dsc3jQQ8m8QykLgieRDKAgCTeV2iMZo6wSPiP5wvgjf0pnKCO7yTQFkwaozqY
 18cs0EhefzYAYj3dENLF7llGqOe52lF3nMatbJvDXmdgqwgbxxu9kkrXufWAxVpHpOEJTZRCyNO
 rp7cMqbutxw4p/2SLXl4ucQszFee1UPOcxA==
X-Received: by 2002:a17:903:384c:b0:2ce:7563:70a5 with SMTP id
 d9443c01a7336-2d3b0d1254emr287477545ad.6.1786976446198; 
 Mon, 17 Aug 2026 07:20:46 -0700 (PDT)
X-Received: by 2002:a17:903:384c:b0:2ce:7563:70a5 with SMTP id
 d9443c01a7336-2d3b0d1254emr287476955ad.6.1786976445742; 
 Mon, 17 Aug 2026 07:20:45 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:20:44 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Ani Sinha <anisinha@redhat.com>, ani@anisinha.ca, agraf@csgraf.de,
 graf@amazon.com, qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v6 04/11] system/memory: add a tracepoint for
 memory_region_finalize
Date: Mon, 17 Aug 2026 19:49:59 +0530
Message-ID: <20260817142010.80693-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

cosmetic: add a tracepoint to track when memory regions are getting freed.
Useful for debugging and tracking all freed memory regions.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/memory.c     | 1 +
 system/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index 5fc36708ec..9485ba316f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1730,6 +1730,7 @@ static void memory_region_finalize(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
 
+    trace_memory_region_finalize(mr->name);
     /*
      * Each memory region (that can be freed) must have an owner, and it
      * always has the same lifecycle of its owner.  It means when reaching
diff --git a/system/trace-events b/system/trace-events
index 51b4a4679a..0e1a4c5865 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -27,6 +27,7 @@ flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
+memory_region_finalize(const char* name) "mr %s"
 
 # physmem.c
 address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t attrs) "as:%p addr 0x%"PRIx64":%"PRIx64" write:%d attrs:0x%x"
-- 
2.42.0


