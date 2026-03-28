Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424DF10BA424
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 07:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6O26-0006qq-Tm; Sat, 28 Mar 2026 03:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6O25-0006qf-AP
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 03:24:34 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6O23-000101-LV
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 03:24:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so145344a91.0
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774682670; x=1775287470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rkGbqrRIaNoI0eLMZJPokRYI36vWC2mPB9X260ixyX0=;
 b=UvRwweYQsriVH8S93tv9hB0PFDXcl19DQ/Jz71+ka40S8/oGzDrpLkWWslrow5QUqE
 EPCY5i1Y358+UzkZy70D7ncbptdjed1H73hq4lLuSsn3RVaIgT/abDtDp/pkfJLH0XCD
 Z2iBJNe/DhDW+7P8DGrO2QXC54B3ZAg7rU5+cKB5Xt0eToHG6GyC5ELdYLD9OmbW7MsX
 rGKb6ZP3cM1/CpCF1eKXqpZ3tZ6+FLEFtiF1eRuhgXIDLCfrHNeJoV3iAKsc3lOP1L5r
 ZqvKG8WyqIGaHoiIHy2C+bahpyU6Oh8c+PPoWjOJRTVni+201F9cLyuryivZxw4d9qjZ
 ChXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774682670; x=1775287470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkGbqrRIaNoI0eLMZJPokRYI36vWC2mPB9X260ixyX0=;
 b=cDEhW08cqeTB6/88uQKOn1U4KOjvvLef5hLTU9TFutazVbbyW5IxsYOCS8I14nJ+Sd
 d7wYW58Q/4g9G4pabp55mBSzpj2VwpEAbwEj0Gqj82vrsQJFLzD5sU7mlOJ810/I2t1E
 9+GBdqFozTtbOd6pygMSmioLmoO586c5K4nxxSXfTikFqYwLDpEJ2nOwEUm4pbhR0oK/
 VWr80gDGTg0cnmrS2srF16pRu5BBujFQQjF9/r6szzjO1dCe87nknWwsh43Rep6UBiv5
 VYW1I7MPLue7MQddUAvORNedjWruKjFqbCZZAIg4Xa31D9Cib3cMdy8d+YfZhf8SNWAG
 ODew==
X-Gm-Message-State: AOJu0YxuFnjlZ11oNiLUWx9m2gaecFMKnclne8EyLno1we+VW1DpAUKa
 +9kzYCP6AHXs+TgfZZhgr+BOtowjMyiAQACkau+1m2m3Z6bmdMXRGCAIbxBGEIG4
X-Gm-Gg: ATEYQzxRRy76go/NN92M82O8FuRGDhDHzFStzrrah2+KZYk8Fk26ACbew1gEqIR02d/
 Zlf1dwYnLXSC5O42s3OK2TSqwYwkQg2Iujzgq3lspogr2f7cz3ucVx0eLcxLaPWFKMWDi6cVP1j
 gEHyzEavAqWwGU82HVc27gGZDI2WoXN8QaMQ28HCZUSf9JDUyX5KK0aGHV2hllbykeOvoI/NM8i
 MaH1mrKyO8Vy0RIwv7NVMXner4Wf3j5x7az6TV3mK4uZIakyto0i4XOzvk4dP5PtPu1bLIBxeRV
 OAORd/RbNcWwI58udHrtaJGAu/cLOIyAHEHzJy4vO5GB4NaX86z+Mq4H0R4ogbG+b4wCw5qZ0xJ
 5QUDlRN4YzD2HA53zFG/DmtO+rVE2j3Q/PhajbD/QKNCZNXz7dCoHTK2XJRgoEqsLxB5ELGInyb
 j8D7BYfauy2nQTWJ6Qi+7Fg/Oq+B9/S3LSzrKst3JXN8NLNJUbse+6p9dWbqYWD9cERwivjwz7j
 yZsWW/Tmg==
X-Received: by 2002:a17:90a:d406:b0:359:7c55:c166 with SMTP id
 98e67ed59e1d1-35c2ffa80c1mr5192836a91.7.1774682669585; 
 Sat, 28 Mar 2026 00:24:29 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35d9507d505sm1145089a91.10.2026.03.28.00.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 00:24:29 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: validate page_size in mapped-ram header before use
Date: Sat, 28 Mar 2026 16:24:24 +0900
Message-ID: <20260328072424.10611-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

mapped_ram_read_header() reads page_size from the migration stream and
stores it in MappedRamHeader, but does not validate that the value is
non-zero before it is later used in parse_ramblock_mapped_ram():

num_pages = length / header.page_size;

If a corrupted or malformed migration stream provides page_size = 0,
QEMU unexpectedly crashes.

Add validation in mapped_ram_read_header() to reject zero page_size
values early and return an error instead of continuing with an invalid
header.

Steps to reproduce:

Create a migration snapshot with mapped-ram enabled:
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate file:/tmp/qemu-snapshots/snapshot.bin
Modify the snapshot so that MappedRamHeader.page_size becomes 0.
Restore the snapshot:
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate_incoming file:/tmp/qemu-bug-test/snapshot.bin

As-is: qemu crashes immediately
(qemu) Floating point exception (core dumped)
To-be: qemu continue running
(qemu) qemu-system-x86_64: Migration mapped-ram header has invalid
page_size of 0

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 979751f61b..2a7e958e87 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3088,6 +3088,11 @@ static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
     }
 
     header->page_size = be64_to_cpu(header->page_size);
+    if (header->page_size == 0) {
+        error_setg(errp, "Migration mapped-ram header has invalid "
+                   "page_size of 0");
+        return false;
+    }
     header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
     header->pages_offset = be64_to_cpu(header->pages_offset);
 
-- 
2.43.0


