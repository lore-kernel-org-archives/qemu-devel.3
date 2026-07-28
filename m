Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B9C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wooyw-0004XS-7f; Tue, 28 Jul 2026 17:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyb-0004UE-OF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wooyZ-0003j3-LP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785272675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FT8OgjVcYPi7/KqauWOXOjhtabKrcCzvRSC05e9FEY=;
 b=LxAusN11SuYnNIgKzZR56xe4TZql9rbfLUhmse2Pb4p6wRC2ZtGfFUoiOmN3hs8pbxQKYF
 uYSPFQFIZyAjIIvmZ0JrwLrw807sx99mbr+uvbZOytKAlEgxmewxkQXKDsa3WHkA9LPGhd
 vSFbnCdY2jvYdcOOhtq/CsevloDIVk4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-JFne_50zMGeLv_PvboYa1Q-1; Tue, 28 Jul 2026 17:04:33 -0400
X-MC-Unique: JFne_50zMGeLv_PvboYa1Q-1
X-Mimecast-MFC-AGG-ID: JFne_50zMGeLv_PvboYa1Q_1785272673
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91931144870so42738185a.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785272673; x=1785877473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6FT8OgjVcYPi7/KqauWOXOjhtabKrcCzvRSC05e9FEY=;
 b=iA8oaYGYHjvCyjpd/sa1JSZ8p2WRw1rxEwybopzFDqvxcEBkyq582ijiU0V4EDqAwV
 ildpTbGL/f3SqdlN1OZEmKRP5JdAuctm8YbgUYLA7zttjC8iiuXrIvXA9ncTfaXZq1C+
 vkboAQKAThsicercCFLekqygMHGm2N/hsNTxYBG/3Gap5lrI6LAwnBkW866nyDqA/2hX
 0Obq5p0IKIb3t6lnj0B/bCzP3n07/4XiFLIC8JQosAGrkp9orj6jsmANdwVjED+tVPqc
 bIcV48TyE0L4QNiRMpPgUCuXrhAsOtKAuqY9n1fF8aJC7/1xbZExgbPWYFjCazfi25/J
 ycCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785272673; x=1785877473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6FT8OgjVcYPi7/KqauWOXOjhtabKrcCzvRSC05e9FEY=;
 b=AzN8OjNeQoR+FWCajuDhqctj/8cW3QJLfA0n8U4o/uDdrW4GQ5l1/qz1AGMAg9XqVw
 Veh8W+wLj4M6EKaH4CFnHNdzorkKk0e7R/y4XTHqAcBsy9Vv3t1v8jFalDwPPd1GVUYz
 33PwOC1A8rC7+7N8taW8xFfeE7E10ZNQFM1mLa9olnUe301SnajGYhyM3oCKYecfdmpr
 F4P2XeRhxCxk8oeUQ8ORbI8I76r2jMxEtFzfKvjPcEeYrIggSAKuhFMyKJLxXyd1Fz92
 NyEO77ubhMbfUBmCjVWmBIHdm1TtXo7ZymDeY7uF4EPsqwBLc/7lYKtpJ+dE9TYwPR7C
 wYaw==
X-Gm-Message-State: AOJu0YxKFcOxch7uv82bQ+4+U92EAZnvH7tW4Q+zJYGwLjc+/T6FlH6Z
 0q/PTqOKhKKEOZ4ImK4GFE9yor1WB0undYT1QXt/0ogL2OCHtRHZdo6DgQoereaZ85PFpfdJmKL
 DJdw1sk1dTGCnNwzKSi4SjQdOOezwowypWunQWJd73s9BimZS5kzQDkD3why4iBfbX2D3HNoONw
 /0nlWtkhcHQmTa1mgNQcUfhaf+RUqw+TC+OQXJpg==
X-Gm-Gg: AR+sD11YVwKAl+E1TQZ6pEmlIsgs4xXVlgG0OBUHw4dtLYOVIbMuMudEUeH3XqG0vMT
 x++TSUFZhL9Cnmr8ZMCxZDSIs01fjnj1l5Th1nmeaK1JY4KT8WAT7HwOuBaTZSwYH8W+pHwJ3Cp
 aZrRV+Ci/iAtY+ltxIei7mH3sQIeA9wykQnPXvMaxfExwXgU1ZzBqIwwEDIAGY+LTzvVynfmpW7
 FGQQ7Kt/LpuJbLWuhIfuuiSUJoNNacPMSl1FbAoCMv5tfxHAwIJfwnA77hTl6kEoA+az2tfO0Ie
 yZXyjcoKjN3zA2kKqH0A0+0fA9BzGfuNVU/gwWAFrffAvTQjDTMyMX8CLW+kuzddtRxgfR7Kqru
 aIQDE1qFLuSypgtTkz0oUDXOWj5KMDF7pROoR12dQ1g26gYPEExTsZx9+
X-Received: by 2002:a05:620a:7006:b0:92e:c117:5ed6 with SMTP id
 af79cd13be357-933027b20fbmr440073685a.86.1785272672999; 
 Tue, 28 Jul 2026 14:04:32 -0700 (PDT)
X-Received: by 2002:a05:620a:7006:b0:92e:c117:5ed6 with SMTP id
 af79cd13be357-933027b20fbmr440068185a.86.1785272672299; 
 Tue, 28 Jul 2026 14:04:32 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3227707sm21277985a.6.2026.07.28.14.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:04:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 5/5] migration/ram: Check for RAMBlock size mismatch when
 parsing
Date: Tue, 28 Jul 2026 17:04:17 -0400
Message-ID: <20260728210417.1925078-6-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728210417.1925078-1-peterx@redhat.com>
References: <20260728210417.1925078-1-peterx@redhat.com>
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

Add an underflow check for the subtract of total RAMBlock size to make sure
it won't underflow.  It should not happen in production systems but only if
the migration stream was hijacked, which is not a real concern since
migration channel is trusted.  Still protect against it.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4013
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8918b2f03b..85feff578c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4268,7 +4268,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
     int ret = 0;
 
     /* Synchronize RAM block list */
-    while (!ret && total_ram_bytes) {
+    while (total_ram_bytes) {
         RAMBlock *block;
         char id[256];
         ram_addr_t length;
@@ -4285,8 +4285,15 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
             error_report("Unknown ramblock \"%s\", cannot accept "
                          "migration", id);
             ret = -EINVAL;
+            break;
+        }
+
+        if (usub64_overflow(total_ram_bytes, length, &total_ram_bytes)) {
+            error_report("%s: RAMBlock '%s' size underflow total RAM size",
+                         __func__, block->idstr);
+            ret = -EFAULT;
+            break;
         }
-        total_ram_bytes -= length;
     }
 
     return ret;
-- 
2.54.0


