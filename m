Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF65FC2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD6A-0001JS-A3; Fri, 07 Aug 2026 01:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD68-0001Ih-M7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD67-0000jX-68
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVssbzUbpvLTVz7xt0szQXifgQ+BXIOB+VK+MJR+TkA=;
 b=KUdLl6CHvyI+uRPRSweLUEVO1GygBZY/+pKC/KpktAz7bulQ0Xhdf6tD0vTCB8bpaFCrxX
 oOu2pSEh5VIlzh92/x4fXD9y5xr5O/2QvDHbbCsHz/uoPOcTXbt+cb7G25qoENL/WL4uHs
 YH8CpD3x86HopPv+p/PyT5ZLBiJ74RU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-B_XGDl_KNF2imii93bq1rw-1; Fri, 07 Aug 2026 01:26:20 -0400
X-MC-Unique: B_XGDl_KNF2imii93bq1rw-1
X-Mimecast-MFC-AGG-ID: B_XGDl_KNF2imii93bq1rw_1786080380
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ce7fabf76so4788963a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080380; x=1786685180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sVssbzUbpvLTVz7xt0szQXifgQ+BXIOB+VK+MJR+TkA=;
 b=qYSA1uinvxC3XoUZG/S6gEMeYJIITOgaO+VM1fB/xk34x8+VJnjPX6fD2F46RMy69O
 0NAsd2jOoz0Cu0kArI/U6quR2YIYb5Cw61YQc+G6RxVzZofXjcOegY77MdWaWcKAVKAB
 eo2Y7Ki6b03aSSWu/0i+ohVrbNwatfdeQDewHsv6R7Hld0scZfWtWDeIS209AqMRKftO
 DGW9uIwVGotl0zXO8eeR6+ln1PmbwVDQYFdcTPjy41dXrEBmZrhZIRoAmbCPlc1F6LhJ
 tQMFJZco3uaP4e8XmCLoXVPc5W4KJGvnD5s9MVilHrzKfQci6zK8fBkjUnHkPbfh3ugc
 2e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080380; x=1786685180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sVssbzUbpvLTVz7xt0szQXifgQ+BXIOB+VK+MJR+TkA=;
 b=QX5ooaW1Oo/pRlpSUp7L0Y1YgWrhQh5WqYqQgY6rmMrCt6Wm9QuyoLoXanztD83dxT
 vtZ+qWrUX0YyP/vAmv2Utfmz/sNSd5ICR6934FFc90d3jbEyuBWDf7Jrr4Hziq6Ny8AT
 rb1yPxmq49ER/L6+YKR51UAx/G1RfSQaW683uAF++hRbNGMnLqC0Yxx7z0XFEcyM3LtJ
 9oae3SnqFpeScfTMhS6uieko0pzUxy26UdTLbzsXLx/3W6YWWZ9CtPzWqz1/CU6Z4DVd
 YFiQsySwj4xolSpbgqaxOUxMZQdHQUSsNRbsuuM7zwKiLqZfNdhSpCfiDB/ag3cVta1m
 qwoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7A06E5mz2ucjxOI7e9TgWoukAPMpqiP6h1ORgtLecOB3daZ3vXMKH4OenM84eCbn2ldleArbYKoUl@nongnu.org
X-Gm-Message-State: AOJu0YyqNtnOmoxJsBkK+/O90KnJ7HCD2L9ZWZt36W18Y/AWT0Pi6PM4
 WVtZ0ST7CY8/n/890NzhsP83w0WOn+3FQBEETQ7kPb73UDmhCIsXscBUPKE6KqHcsSW+3DBFxMN
 ADBqe5LgnJ7FOSFhMnP/qo+BDj5YKyHtNYv1ITb+N6CksQ8PVgA5doYUW
X-Gm-Gg: AR+sD10wxeTtfk5TnNeqDnLX8QBvm7HBbNK0W09ukAo1jNQrcbmNDkrjHCtw1HzggKX
 pWLbJWpUzj3aYxL2I/4zRLCB+2BJ4oyIySkih7aNsw+HU5iHFezffrjAx/mhUru3bc6o/T1achm
 PcJNHTRiMGOz2hvEMBXUlPuk7O8mGEgYL8oqopl1qroTV2nOVY54KLr5beW0ZuxJxRidQ/mC96v
 BLOgVQ6hRJS6POj9YPB+XsDzYiH9ddEvWOON5bu1rsIAAsUCYHPyGhhO109m4b0m2mTUVtdjolB
 1mzONLGM8+ekK6iruwLEllbm0oxwOIaZ0HsPgEoTY8Zx9RYLRymek1Ytyo9v7a5Ntj2rgkKFPJY
 /o9JOqj6LO+ace4dgZW9wsm6fFTcHbqGrKw==
X-Received: by 2002:a17:90b:2785:b0:37f:e1af:df22 with SMTP id
 98e67ed59e1d1-3903c5f03a0mr22754839a91.17.1786080379766; 
 Thu, 06 Aug 2026 22:26:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2785:b0:37f:e1af:df22 with SMTP id
 98e67ed59e1d1-3903c5f03a0mr22754798a91.17.1786080379366; 
 Thu, 06 Aug 2026 22:26:19 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:19 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Ani Sinha <anisinha@redhat.com>, agraf@csgraf.de, graf@amazon.com,
 qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v4 04/11] system/memory: add a tracepoint for
 memory_region_finalize
Date: Fri,  7 Aug 2026 10:55:46 +0530
Message-ID: <20260807052559.50643-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260807052559.50643-1-anisinha@redhat.com>
References: <20260807052559.50643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

cosmetic: add a tracepoint to track when memory regions are getting freed.
Useful for debugging and tracking all freed memory regions.

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


