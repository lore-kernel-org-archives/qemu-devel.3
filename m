Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AF2C54F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wok7B-0002dw-TC; Tue, 28 Jul 2026 11:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok79-0002cS-TL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok78-0005dg-6L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785253985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXeiGT0Gtel66vemhZKpUjZ8zu7N7BIdzUq9Sor0hbE=;
 b=bIfmbBlaQioUSsZClBv3b5Fjx/nLHfYwYvfHVx2m/IxZ90f7fAxxBnnT/SPJZvf0stS7fa
 eUG1nPRdZDj0JfrGg3Dz9L94FH42LQCqvbYBtSsbHHKQuFKKGKrWrTWG6LyAjE3sQoDGF2
 USIs6g7oO5UBBEqOoI+1I61WdgkEQm0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-zw60VBUcMKSIC8usMVW0Dg-1; Tue, 28 Jul 2026 11:53:03 -0400
X-MC-Unique: zw60VBUcMKSIC8usMVW0Dg-1
X-Mimecast-MFC-AGG-ID: zw60VBUcMKSIC8usMVW0Dg_1785253983
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5276aa86d00so49000601cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785253983; x=1785858783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tXeiGT0Gtel66vemhZKpUjZ8zu7N7BIdzUq9Sor0hbE=;
 b=C57Hl6wPCaTwF2x39jJRLpCWWyzfJ37ICGuXIWtMy2v56RImao6jRjLP9D8szAkmKe
 K9ShYRdTB9VcfwMnUHJ8RBu4YH9BPaCyqBnl8KcLOL5ApjiefxW0+xJHcDT8bPR4sUtH
 Zy8Ns8qeurq+bWWgqI1iO9NopuDKdb//9Q/RvdHUavxStqzFFXnshBogkfRxBKuucW3c
 OXtYXdYzRxPA808CV90FBpNHDzULiWoXnrl3v5yzzF9hfMjfx/4b4qMLsdGD1hM8aF3g
 qV4vMcnudAfjZNG1e71pFIgYFI2vvrV4+eoAQ5UNnQBSlbhX4DDCYncu7cZGlj9m+QU0
 6nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253983; x=1785858783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tXeiGT0Gtel66vemhZKpUjZ8zu7N7BIdzUq9Sor0hbE=;
 b=sJJjXZW42lJPWBL9iFwnyCdz2DKfby+RnOf8lHX7jObhyTusJ1byNCDqslph8ixKc4
 axwCkA1tTmzmzGvMx9EvRwQ7cvRddhZeK/yNhVn84ex/wC/retUNEMzC4ChS3S3y/y1h
 sHIqA5D6JQewFMtxcWu6Cjlp35YZ+k9+iri2Nsbps8U+Nq7OfMMQNSMNu5woP0cdwzYc
 IzV3Jc23UEwV1eP/5m0WRJWPXEI2kq1sHRPAJ1tPb3YIpAGBvGUoUp6xMC59PAdzVxvi
 y89Vf8d2QK3FK+Qn3TONmfhXtXhdpGHBG5ITYGgjO540plHbhlHNF0pYsdqPq57cE+8i
 G5fQ==
X-Gm-Message-State: AOJu0YxYClHOjE/4AwxfQYmfpizoxXFTnNmqsyrviUVgqPOcGvsusljv
 sG3h9SOCUj95C15cphU3EO+xKYhkvsS96OaZhV7T+/Eqx/BCakxp81GCYA1K52IsawoCZGy1OK5
 5lXc+XjHOBAfwSFvmxsTsv+FlJmHPpSWE9OwyJYHGU5KDCRcuqfPwTWpifg+PVck92DzkIGISOM
 XtvlOz+/G2xbv44MEJjRXYBptZsiLHA4aHnEjlJw==
X-Gm-Gg: AR+sD10i8kJafROELK6P49IyMqiAt03iaw3OfWHskCz04pY1rhU2n91nfyFZANlJcbp
 idu4neaijnXcIJkUqq7R1vfoWx2JV/Vd+y5j/71jEHtNHaTEhklpaZDhFkINliOEb5Ozn1COcbd
 NrwJPl9S5hpYVe0Y4ocTD3/RhNdnIboQ+ycoimzbv1CJmNOaFMEfQzSYLZ+r4ZLMEoagHZvIEj1
 fZ7/sQAiYWDou0MXjbjU0BGvRtKZ5X29fTrTVKx3E6U+uFjjgtkyP7Jyz/htLuGTkAFxkC9RHdg
 aHNqwYBLyhbVVcMDOxmayj3fL4rrVxxdRhP/oXtOEYXOde8gvYqatQdZwMRHMwjUFw==
X-Received: by 2002:a05:622a:1444:b0:517:8711:d466 with SMTP id
 d75a77b69052e-529d71034aemr26841121cf.56.1785253982912; 
 Tue, 28 Jul 2026 08:53:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1444:b0:517:8711:d466 with SMTP id
 d75a77b69052e-529d71034aemr26840491cf.56.1785253982099; 
 Tue, 28 Jul 2026 08:53:02 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2dd54dbsm492481cf.23.2026.07.28.08.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:53:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, xlabai <xlabai@tencent.com>,
 Jules Denardou <jules.denardou@datadoghq.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PATCH 2/5] migration/multifd: Validate next_packet_size in zlib/zstd
 recv
Date: Tue, 28 Jul 2026 11:52:44 -0400
Message-ID: <20260728155247.1894355-3-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728155247.1894355-1-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
meanwhile assert() stops working with release builds.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3737
Reported-by: xlabai <xlabai@tencent.com>
Reported-by: Jules Denardou <jules.denardou@datadoghq.com>
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Reported-by: david korczynski (@david1766)
Reported-by: huntr bubble (@bubblehuntr)
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>
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


