Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F332CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDa-00010w-I1; Sun, 14 Jun 2026 15:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDY-0000wn-Vk
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDX-0002lq-Cw
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jYAcvS/4tP50eAPxRPeklkaj31Ip6dr75MhaJLz1/xQ=;
 b=aGelc79ek2pVlSXsVDpB0d+KyeJH+GSpRBWDE7pLJZvEs00FUX32oTmizs2BgtvAEWFAll
 ljZTts1lkkXB3TrFOPZB+ybiK1v0tcrMEz+s3nj+ODSxC7vc4MBUvNFi9Yf7vtdDsKsMZL
 ckc5iIVrlxVvcfCTyARfu+8MdeYlsak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-xv-TlYolPPWKBpXtvmgj5w-1; Sun, 14 Jun 2026 15:09:57 -0400
X-MC-Unique: xv-TlYolPPWKBpXtvmgj5w-1
X-Mimecast-MFC-AGG-ID: xv-TlYolPPWKBpXtvmgj5w_1781464196
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b37e1f47so18568765e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464196; x=1782068996; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jYAcvS/4tP50eAPxRPeklkaj31Ip6dr75MhaJLz1/xQ=;
 b=jUJGFFOdpGN0uGBI2YsRAa94lotZ3nbDf2SBZhzNuX1MoAnMmT716TzHW5lccxNVRK
 0pgUh8QYrE5nsFXlNcfoINjlCquYvTjAgwK8Ljk9ZMFE5sxGE+/mlxTuVMPXJcipJqnF
 wLlnxEjX9aqpud8HMC6xQ8lurfvo+RkhI7qseC9PzWdJjxwZlXLbE6woVOAN4OyaZl4c
 kSeLgESpqtc4NqFPRTUZVEIpEQuxgH2K6D97+Whj48M72Q2ymGOBuq/yF0OAD24v+lEl
 u5QOrVh7MKuX1WAqFN3kgcvVPtOIPt8OBoXWLo6mI3W7xGj7iIyl28JsBCVc55KaYLHt
 /9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464196; x=1782068996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYAcvS/4tP50eAPxRPeklkaj31Ip6dr75MhaJLz1/xQ=;
 b=MVupI2y1WdSEYeRZSY7BvMtqPPGHXNO+Isit5Z3VqcVm5Mbxrbj05jg+EmzP0mTzNl
 /hDKYsdW9re24l4qbWf4g7oO/HU9ynlV7Y+rynoMWlXSBO744RDDif7rb8enCzg7IkoS
 B3FNMGoSu6h0LZkVoKzzCyKYzhaabesre9UJIDs4ydFu6Jy29QEhXF8aXmsrgUYP71cU
 /Tv46ijrlgPAHMA7HyOO7SICD3mxAd0cvQ4a5DdoNg++cJ5htZVxIi5f4GlkAr47qre/
 zN4TpFJ+7M/T3eRXnk7/WHxPRfbOwo+aWBHrAzt6LH6APNrCl+LClSwLnl2S+B4G6pFy
 rAZQ==
X-Gm-Message-State: AOJu0YxoKnLFsr6iUgS2ezHU7Smw6wIMi+TATZ4OU0dmPr9vFefd8F0A
 TFWSeYkGsSMbyApOz6Bev9nv+JecaPvufhigTJarmRaukeUR3oEGHi0/A9N6JXp5xD5tdk7LZmK
 DiKSWQVnPttrOGnRkIKiAUbaVI+2H6Fr9vV46x5N1skruNeeXJxYj3iln2PUHzPpoVa8nqq7mrX
 PSqebZP6oZmWuCqzB73yZa3yU//246G4goYg==
X-Gm-Gg: Acq92OEA9bhu1cgE2XZsB81WK65+6to6Wu2lT4FjpZWP6Kg3uDuIkjYROD1NMZNkhxp
 EglUxWed+jBkXBd7qjfGP/ToSThmlCpPIwkrdPUjUXE425HbWczz4dooTc6ok+/bzeaOmhdxcKN
 mrIhTM+YuZE+sntDnCggrwMksteShIL9aw81pvHy5NGWJv78fBjzrWKKcB214VMkBwOX0Z5dL4u
 2JSu9cctFPkFHFV/5AtZ+HGwKags6VmmnedJbDeMNDBAZxcBULdJP9Ie2VThdxWrPH3eF2EXShg
 fCNjX5LULSx3tLp1Ud58xhokxOmQw7Q8AdNoztL3dTxWkXKekkxKn9nurT2tVGUsnxrsgxazJly
 KHYpPGXHl+jHhf57UNV4Xoni+dAHQysGgqsxh8hAfIZo=
X-Received: by 2002:a05:600c:6214:b0:490:8fd1:72a with SMTP id
 5b1f17b1804b1-49220086792mr86942585e9.3.1781464196189; 
 Sun, 14 Jun 2026 12:09:56 -0700 (PDT)
X-Received: by 2002:a05:600c:6214:b0:490:8fd1:72a with SMTP id
 5b1f17b1804b1-49220086792mr86942285e9.3.1781464195722; 
 Sun, 14 Jun 2026 12:09:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922031b7d2sm197662505e9.5.2026.06.14.12.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:55 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 101/106] hw/cxl/events: Fix handling of component ID in event
 records generation to not assume it is a string
Message-ID: <bae67e770aab251a9604ef8b81c67e6fe877baa3.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Shiju Jose <shiju.jose@huawei.com>

Fix handling of component ID in event records generation to not assume it
is a string. Component ID in CXL events is 16 bytes data, but event record
generation copy 15 bytes only from the qmp "component-id" field using
strncpy. Replace strncpy with memcpy and copy the entire component ID
data.

Fixes: ea9b6d647f2f("hw/cxl/events: Add injection of General Media Events")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260306101423.986-4-shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3cb1096e16..03a5d1751f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1895,8 +1895,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)gem.component_id, component_id,
-                sizeof(gem.component_id) - 1);
+        memcpy(gem.component_id, component_id, sizeof(gem.component_id));
         valid_flags |= CXL_GMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
@@ -2066,8 +2065,7 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)dram.component_id, component_id,
-                sizeof(dram.component_id) - 1);
+        memcpy(dram.component_id, component_id, sizeof(dram.component_id));
         valid_flags |= CXL_DRAM_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
@@ -2185,8 +2183,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
              corrected_persist_error_count);
 
     if (component_id) {
-        strncpy((char *)module.component_id, component_id,
-                sizeof(module.component_id) - 1);
+        memcpy(module.component_id, component_id, sizeof(module.component_id));
         valid_flags |= CXL_MMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
-- 
MST


