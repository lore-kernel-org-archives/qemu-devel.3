Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E93C25B77
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57am-0001kC-Sd; Thu, 09 May 2024 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57ad-0001i4-TN
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:58 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57ac-0003b8-0t
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:55 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51f0602bc58so2101675e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715275790; x=1715880590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=egInwuwc8iANCxt9Pxn/Reboy0K9pBqKLA2deO8KHzBrx7Z3dt0ag+3EmjPqJR/I3j
 ue3hFLnE3DfpccV+OiNHoor/nfsaF1mNevyoakY6xY1QJ8NBtuuIifPM2ljpZts3IB3g
 1vyYGRpliB5o0r94VTiQxBamBI8GlTYSUVen8IPaec5XOM8tPcYA+ZGQ2kKX//x7kjO2
 QH6aDydBdCbq/IflaK1oxi3F0IxO/kkEWUelKNdWKFlLutHBImvcSZ4Q7kE9Y80zMerE
 qNz44nyRvPD9REz7m3O1+c6PsD+66MvA2os/1wmJ40h1daWEs94OU8a2LKPq/X/L5Hf2
 1zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715275790; x=1715880590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=VhLIb48ibOuySbo9obRVKr3KsVcETKG1KAvdg/WumvzvDGf6MRSn/5B1BpWI9Nqiny
 xH17zfAsyPX9ByPkLogBrNo+THtMLC4NLHJIOONEylYy6x9tVJNa8cpg07uUoprY02SU
 shtBZObVAPxVP0PXGn/70pTWaewQBSeADSz96kNUTHATb7JoFCp4Obl0RX2hOUTzbOeP
 yppGoBZbQ0DQDFz7jqFbB8kd9q/SVO54QFC+Y+4NAOvShi3hfTZZ19nVpCcHGoDskDiy
 TAn33TLbNbiRJW9oc4MKL9qDd3CDP0T6W8R8Y1X7YbeM509SfqORkwLvm8J+UrnchYjm
 Useg==
X-Gm-Message-State: AOJu0YzB5xix53wPIEkGw2YfYjhtqhdqNWTOvsuobCJHhUsJeMvszkFu
 2FLG66HGQMm90BpziAMvtAs7umE2rxtRHwwqBMZg3LEjs/hmoBXtAguPYsF8
X-Google-Smtp-Source: AGHT+IE3429+Ctid+D4EtDpgneRZV++HVd+uIfkCNO9kCmImtP+ysIxcQpHU7yrc/kJeI1cp4rrEpg==
X-Received: by 2002:a05:6512:4027:b0:51d:866d:8cf2 with SMTP id
 2adb3069b0e04-5220e27a334mr125318e87.6.1715275790078; 
 Thu, 09 May 2024 10:29:50 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f38d3445sm369206e87.176.2024.05.09.10.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:29:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v5 2/8] xen: mapcache: Unmap first entries in buckets
Date: Fri,  3 May 2024 03:44:43 +0200
Message-Id: <20240503014449.1046238-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

When invalidating memory ranges, if we happen to hit the first
entry in a bucket we were never unmapping it. This was harmless
for foreign mappings but now that we're looking to reuse the
mapcache for transient grant mappings, we must unmap entries
when invalidated.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index bc860f4373..ec95445696 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -491,18 +491,23 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         return;
     }
     entry->lock--;
-    if (entry->lock > 0 || pentry == NULL) {
+    if (entry->lock > 0) {
         return;
     }
 
-    pentry->next = entry->next;
     ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
     if (munmap(entry->vaddr_base, entry->size) != 0) {
         perror("unmap fails");
         exit(-1);
     }
+
     g_free(entry->valid_mapping);
-    g_free(entry);
+    if (pentry) {
+        pentry->next = entry->next;
+        g_free(entry);
+    } else {
+        memset(entry, 0, sizeof *entry);
+    }
 }
 
 typedef struct XenMapCacheData {
-- 
2.40.1


