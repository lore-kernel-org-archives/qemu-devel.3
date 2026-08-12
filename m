Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9A0C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAgc-00087a-Uf; Wed, 12 Aug 2026 11:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgF-0007wv-Bk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgD-0007B5-F4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JQ86lSdiu/uKGXruj2u8e/IyYjOzEuT9uWy0Nac8HE=;
 b=eXl5SyPOV+uBSa/zLO9lai05fzLDycsssAHLffWGb5lrrlTWRbTStjHF3n1VRgBukcDSbR
 Gyki7BPFW7dThBiQxiHQe0FclvG29ePsAq+dtJZt5EQAejUVlGEMISqpOexCUhHstNFMt5
 fDW4OWbWx3XEsHcxyD8adaKk/nf1TdY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-9t3_PTG2P2-MZ9Yfu4iDdQ-1; Wed, 12 Aug 2026 11:15:43 -0400
X-MC-Unique: 9t3_PTG2P2-MZ9Yfu4iDdQ-1
X-Mimecast-MFC-AGG-ID: 9t3_PTG2P2-MZ9Yfu4iDdQ_1786547743
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso10745141cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547743; x=1787152543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0JQ86lSdiu/uKGXruj2u8e/IyYjOzEuT9uWy0Nac8HE=;
 b=UWtmeBsU3YhVAfwZpbziAY0nlvXBp0IXZRMXv63Bc4N2JIP8rhkxTK3+5Q24Z/ISsg
 xQgwx6cOQAgD/eCMjaUk0w78bXsAiM8iEy/fxMlUGk25A25Vip56RhNZ0Bj83N1zjUXD
 Hm39y3UZkRiuJN1rUXJ9w/Dx7VM1FLaLYfiwYICU60qmvDsJKjzc9iL0W/oCEzZ4ymLa
 0RVOPormyPwWv5qLojCL5H4zPvn0GTOSkxQzxIWgrdoH2XLg3KW2xgGZHawkROGfFRgx
 dSwaOZVuSaaHH+Kcs8YxAZyiv1Rp1PSWHkwnjFSlRcMva/4OQrvmP6r/yMhJV3nZEUjP
 W85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547743; x=1787152543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0JQ86lSdiu/uKGXruj2u8e/IyYjOzEuT9uWy0Nac8HE=;
 b=p4k/Hdxbq1OL5zNW1h0qJyFJNo9GqslH6G6Vt8RhrSX6Crm3nW+4ZqBWxU2Ye526dS
 wAEHuLrIrmB7cVuErgp5lFIR+bd5dmFwCzOKjGbxSJmGe+DLp3+IK2o66/OLWPCHya43
 IJbK2EI2TgecJ9lu0BPanHT2G33XNKUm132qOtTNeWNS4Z1pgAIMLU1LqMqxj6JgGVjn
 vle0yIfP6xLJebqYL16zz+r0upTiPxqevRSIz+/V1wKP5RHjGxe/KTZwEPiAeVo4YJpR
 CPTICjDG6b8SBPj75iDehSl4ky56Fpi5zI+6g3kcPPaJD9D6E+LaIkYUxSg/IQ/sHq3V
 CfbQ==
X-Gm-Message-State: AOJu0Yz+GV1yp7gnxJbTymtqqmWvk1VfQ/CuDSnHWNt+SSgAQeIC2kLp
 4SPc0fFxnQXa2sXrxRYmYpZe8tvSPrKp6kgz3mShRryHid1wcyBHa5E5ltmiGmorHjc9pLzJh3u
 cN/sl21XdimyHsA8VYEfNq7cpL7qLaszK+/q9Ja2d6IFQMye0RuImUAkxLD6BFwAhnx+5Xg3/8D
 oQAeclqIzvWphKmuWWiD77reis8NHJoMmd4WCgCQ==
X-Gm-Gg: AR+sD104nLSFMZ4Kb4wmZaEv5IV0ilNis7bHkBDRYap7yp3ENUSVK4h7Qj1STYC9GZK
 2GmD47kjH9lLUd4csj0mp/gk3pfIJ0bZ2A1GE9RUdreO7iUU6F3t+QjBbH8Q83N4X0iF78JKi6G
 BkfBtrt/eL9CblnchKYSgDZg/s1mt1vPb2RtCpHS+amsB9AAo6g6sL1cZAhLSOAX3H/1Kc6AL6t
 QGbRNS3Ygri78ZtdQKF/KmtXsbKxocrBWsKAP0orKHxIca8F+p4L14Y/Ixo/s7ysDs5MdPV6CRW
 aI5mJDcKD7u00qFli2BPDZsb3YlpmXfZOLAuJd9urrN22ALsdKikpwSPZAFOP4DIMA==
X-Received: by 2002:ac8:6f1b:0:b0:52d:3d46:bfd6 with SMTP id
 d75a77b69052e-52d64712203mr45475041cf.12.1786547742773; 
 Wed, 12 Aug 2026 08:15:42 -0700 (PDT)
X-Received: by 2002:ac8:6f1b:0:b0:52d:3d46:bfd6 with SMTP id
 d75a77b69052e-52d64712203mr45474001cf.12.1786547742006; 
 Wed, 12 Aug 2026 08:15:42 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, xlabai <xlabai@tencent.com>,
 Jules Denardou <jules.denardou@datadoghq.com>,
 Tristan Madani <tristan@talencesecurity.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 07/10] migration/multifd: Validate next_packet_size in
 zlib/zstd recv
Date: Wed, 12 Aug 2026 11:14:40 -0400
Message-ID: <20260812151444.2611689-8-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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
Link: https://lore.kernel.org/r/20260728210417.1925078-3-peterx@redhat.com
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


