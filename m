Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0114C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooz8-0004kY-V1; Tue, 28 Jul 2026 17:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyY-0004U1-Rt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyU-0003hi-M9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785272670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wgod9mpBIeEAPuUI2tKpiE28TzA1mnnfyKCqZ3+xNnc=;
 b=LIQxqypYgUCzpbuqt276TPQK8SLm7leckvG83pAXCt/9OMgh+4ObG/BsbaBBiFwi2PR/1Q
 b81iyG3rJytARfY3fDrvAmZdAwb3CGW1SNVLZtY2iDH8atIYLkCRsNYL+4FIS/7uNj2SSp
 VwO6njeE1Q7tJ/CIX7vZncDSY4TQrxU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-BvA-K2jEPnOySNDx_XA6XA-1; Tue, 28 Jul 2026 17:04:28 -0400
X-MC-Unique: BvA-K2jEPnOySNDx_XA6XA-1
X-Mimecast-MFC-AGG-ID: BvA-K2jEPnOySNDx_XA6XA_1785272668
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90284139cceso14484016d6.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785272668; x=1785877468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wgod9mpBIeEAPuUI2tKpiE28TzA1mnnfyKCqZ3+xNnc=;
 b=SYmCvnjMyVDpC8xTXI4tyqqykqZQoqPdGqJ4Oq6noGLUa6wbLRx36sTW8QIYeOD2rL
 KGqzyzGaMtXgB1xM7aBsTReoTyulIp5Y57oV+MifbnYJYzFvD6x+ziJCxxct6ipj+CPP
 7yS9kB4ByqxEI9hgjzrRP9NtLEIRLexMTWhmxItmZY4XiDAt3bHg6IQwPnlu97CRbDxk
 w+YjvTJE+bbWiHr0q9vYXBVbWy2jmIrHlcKS+uH1oMUvnoI31aFzG1H9iTaoB6t1+wEV
 wvWGPhmjz1cJWflExC/FvwwWdBsOmk5fyoNDqsP0pC7HYAQ2RifY/JCFsWVPklgVoyf/
 IBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785272668; x=1785877468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wgod9mpBIeEAPuUI2tKpiE28TzA1mnnfyKCqZ3+xNnc=;
 b=tPeVA8W28ZLKWyC2uIV29wbr6qp+xNF+ZPnlA+Pxip/VllFvzgpqklPPici0SfU//h
 CE22mrM49amxGCF6Gdg6ZPW1WWP8AJ/0apu/XodK8V5ai/ofBMJhE9JJICUXh7Jz5epH
 JewmDCABoJ2zzuXlyvnmOr+rfiJsOjEc0vmnTojAdRrfJf6r+h0xF4NbcAB+bXsLWGfG
 2kIwn7W5TZrZseQlorOWngyoWT1HXEiYhv+YbduAsWjD17EHPgwgWfup1A2x+iobT3FQ
 +tMh7NFDjJWrG3g7zd/2wYpdWEEg9N1zFTr0wAtuo9cdIrh6vj6towN28UbMM2oKyJ2k
 VSFQ==
X-Gm-Message-State: AOJu0YwIFG+8bFjQuLbS6bl0Sn2jrahIsoySCgwqdhFg/koJt5SV1JjO
 b8yNAgKG3++Oj8ta858YfB5UqtBb/qUR7WGQcsuuI74IkA9rYRexa5FLRYE68O/O2Nn6N42+jzj
 f6acBbv2k/XNe7udJ+pbRIMLqHXIBamt8veENh3kfSlG6KCs6QfjGzmekjgROnGCHLx7sVuUD6X
 /uHdgf2m8o+CqzdDU8APGC8dx9sZJ8wifwcUUoGA==
X-Gm-Gg: AR+sD11XMaT/RCqBabf10d231ILvJjOfAHN0O0byMGh1BxrMvP9Dh+NbC+wm0UTbZyM
 Wn1f+8EG3AaTGTjviipUMHjRFmcDbayJ84B3mOY9eKJixMQID83dFt89skppGitu3YAxgQ4lWlW
 Bugoy6mpKxWAyYgoHYqeYPXXO1cIzhBjVjn9BVgQS8hLORbZA6j9AQWVi3Nk/GneSdyF5AA9hTO
 PteEWHka5gmWqSQiQoIA0ah0qAuAMJ5VjgMJixzW36fRJmCVyz09X4oAm9Bga2/1P5xGTU5Y6w6
 bHdFa0vrcsG6moxtZuqZ0bxmAWieo0KUuCbapufAyr2R2yLB5f91lAWMfo2DNB/P+YLtfOad+DS
 uq4Svat0an1RZ8h69h1MFz+TKWmwYOQgXn8pNY+5WoPNZqdf1z16bAzrJ
X-Received: by 2002:a05:620a:40c2:b0:8cd:d688:7aef with SMTP id
 af79cd13be357-93302640f89mr440567885a.19.1785272667686; 
 Tue, 28 Jul 2026 14:04:27 -0700 (PDT)
X-Received: by 2002:a05:620a:40c2:b0:8cd:d688:7aef with SMTP id
 af79cd13be357-93302640f89mr440563685a.19.1785272667038; 
 Tue, 28 Jul 2026 14:04:27 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3227707sm21277985a.6.2026.07.28.14.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:04:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, xlabai <xlabai@tencent.com>,
 Jules Denardou <jules.denardou@datadoghq.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PATCH v2 2/5] migration/multifd: Validate next_packet_size in
 zlib/zstd recv
Date: Tue, 28 Jul 2026 17:04:14 -0400
Message-ID: <20260728210417.1925078-3-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728210417.1925078-1-peterx@redhat.com>
References: <20260728210417.1925078-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The zlib and zstd multifd compression backends read next_packet_size from
the incoming migration stream and use it directly as the read length into a
fixed-size buffer (MULTIFD_PACKET_SIZE * 2 = 1MB).  A malicious migration
source can set next_packet_size bigger than allocated, causing a heap
buffer overflow write on the destination.

Add a check against zbuff_len before reading, matching what the qatzip
backend already does.  Also replace the assert(in_size == 0) for empty
packets with proper error reporting, since the value is wire-controlled,
meanwhile assert() stops working with -DNDEBUG builds.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3737
Reported-by: xlabai <xlabai@tencent.com>
Reported-by: Jules Denardou <jules.denardou@datadoghq.com>
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Reported-by: david korczynski (@david1766)
Reported-by: huntr bubble (@bubblehuntr)
Cc: qemu-stable <qemu-stable@nongnu.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-zlib.c | 11 ++++++++++-
 migration/multifd-zstd.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 8820b2a787..400146566e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -216,10 +216,19 @@ static int multifd_zlib_recv(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
+    if (in_size > z->zbuff_len) {
+        error_setg(errp, "multifd %u: next_packet_size %"PRIu32
+                   " exceeds allocated %"PRIu32, p->id, in_size, z->zbuff_len);
+        return -1;
+    }
+
     multifd_recv_zero_page_process(p);
 
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 3c2dcf76b0..69ef1a5f38 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -210,10 +210,19 @@ static int multifd_zstd_recv(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
 
+    if (in_size > z->zbuff_len) {
+        error_setg(errp, "multifd %u: next_packet_size %"PRIu32
+                   " exceeds allocated %"PRIu32, p->id, in_size, z->zbuff_len);
+        return -1;
+    }
+
     multifd_recv_zero_page_process(p);
 
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
-- 
2.54.0


