Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADABCFCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPH-0004kk-Sg; Mon, 09 Mar 2026 16:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0004fe-MX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP1-0007hY-Pq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVcTYkmlJ7eP8vLspcRNlyG6cYCjZqhjMZSUsJqQKq0=;
 b=F/wDUFCAuvpxEcvc6ZWxhWVb43cMUIjqErja4vdGCmuSbA8uhAwQFVRgZHR2S6tMNb7Qwz
 iZG+D0m0HgjtIbSkSM7d+BBKtSmuowXY82Hq8+IsBQcVwmgiDuBozaLaM6BiOK19hRzr7y
 hROwFMyTBNtHUf4Yn6TgaQYmI7ECiiU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-K361aXYdOLuLkwNUqnRomA-1; Mon, 09 Mar 2026 16:40:22 -0400
X-MC-Unique: K361aXYdOLuLkwNUqnRomA-1
X-Mimecast-MFC-AGG-ID: K361aXYdOLuLkwNUqnRomA_1773088822
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd85e08fddso1373514185a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088822; x=1773693622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVcTYkmlJ7eP8vLspcRNlyG6cYCjZqhjMZSUsJqQKq0=;
 b=hSHX0PQBL57fQpRN3l4+8G+U9psnsw1tcV55jh2iHSco5MGOem1yFs/E/HM09iXEfs
 l4lYKfxuqfOIZI+jUYVmde1N00h0/EKkgzXdlusijDqcqKpux87PcGCaEXHoUe6AMdb6
 stPr5suhql4uek/jxAPLK3/pWKoD6BJYlgdV+CDEFkdGnBy3AHC4mxVn5WGuoag23KAG
 HKlAe/QXPWEB772XC1TMBvpGRKCN2kfR0ALqy8anxK8P/UPYE/FyDhXd+iLuv4KOpTRW
 lGjf7iTPH4bpNI3sQ+5edZiFbEH7/o9IcF5kfIDqc5eslBI/hTisbdtCCkrFIihxNMdu
 lYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088822; x=1773693622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xVcTYkmlJ7eP8vLspcRNlyG6cYCjZqhjMZSUsJqQKq0=;
 b=RkXwLeQzyp0DEZKnELQtpxu+44RmyBuggajK8huAFhWJFXfeQLCApOlqgZEV9sPc7p
 2aRACdrb3hqZmjK8Nki/V6MV9FIkcUGFKBtWd+ZWP9V2le0fq+K4kMzOVyR1LRFIW+U+
 0RozihvXWra2jE6PxO8mORFc3F/x0SLFL1/0RZxL+PaZWPjroVGEWbyD9l/7oDi+H0F9
 D70I+Vdw60YmJxgnNP+um0HMv+FwQkuAlz4MFoXl5Qe4WmdCJWi6lEa21WvWpilpXvD7
 zDBYemzm6UmBbYNrBKFhjwLoeaL3kOgE3v0u94R2TzxU7fCdrLtEUWs+/Ft+dOvItcz5
 GGmA==
X-Gm-Message-State: AOJu0YwphJmHe4K4sSd5UYR9VAiJTgsdt0AOmlzzuViBI1TGn2HCW7lV
 RTWxUwHiCxOK3W0D9sUngJdA5wKKDPlqZI5lrOOgbYF7hOylH/UJb4OSz6w8+9ezB3lF5jLUHXK
 RMQsIQLATxb+8S1tJUsPrAP2fPO/pW5CcBok/9qQnid5ZDnb+R0Lh4EIo/KxNj8GIZ/1rD4okux
 fnjYIGqrlgshmoS3to2XkmbWhXfews6Ks/tYO49Q==
X-Gm-Gg: ATEYQzywUBM8UlxPjh6EUNZl2NjYCTrMOrMQu0CfzCNzcxyezJTDqjHxYJpxuXZ9Gom
 ij5m9dkO9Hfh+zJH4uyglgHJtpdXsvKXkzY0wGvYWYx6oTGrBhevMY8tZoW8Cdm4+2WoG32g4z+
 O4TV7+4XIry07hb6xuNjBZF4YtpI0n4cnmo8+ojeMGHhGHjtqjOE9MMKptM01dTjnEM/2h4tzXJ
 8298+TegawX7YbwQatxghh/r3eqYnihFg5mrAu2/msV3rdctyRKSRgQ5tK9obQU3v5ZKFJvIiUx
 K6e355htGUAspgByvhMA0147oNImUXHzzGYCjAYhPnHBm0V5Shc95hLkI83xAI08WDT8Ikszgm6
 bIFRVrSxD/mFw5VUrvrmRczBRRO6wewNI4RTVL5o0jKQX0Lt7nGql4BB7BHBHLlhQNOGLuZXOtr
 RZNlZsHw==
X-Received: by 2002:a05:620a:3943:b0:8c9:f996:81f5 with SMTP id
 af79cd13be357-8cd6d3ecd1cmr1672440585a.3.1773088821861; 
 Mon, 09 Mar 2026 13:40:21 -0700 (PDT)
X-Received: by 2002:a05:620a:3943:b0:8c9:f996:81f5 with SMTP id
 af79cd13be357-8cd6d3ecd1cmr1672436085a.3.1773088821345; 
 Mon, 09 Mar 2026 13:40:21 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 04/18] hw/xtensa/xtfpga: Do not use
 memory_region_init_ram_nomigrate()
Date: Mon,  9 Mar 2026 16:39:53 -0400
Message-ID: <20260309204007.1709441-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Convert to use memory_region_init_ram() instead. This breaks migration
but the machines using this device have no migration compatibility
guarantee.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/0a57625ac909c2b005302b9136920cb917427a8b.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/xtensa/xtfpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d427d68e50..ed24720f94 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -50,7 +50,6 @@
 #include "xtensa_memory.h"
 #include "hw/xtensa/mx_pic.h"
 #include "exec/cpu-common.h"
-#include "migration/vmstate.h"
 
 typedef struct XtfpgaFlashDesc {
     hwaddr base;
@@ -163,9 +162,8 @@ static void xtfpga_net_init(MemoryRegion *address_space,
             sysbus_mmio_get_region(s, 1));
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
+    memory_region_init_ram(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
                            &error_fatal);
-    vmstate_register_ram_global(ram);
     memory_region_add_subregion(address_space, buffers, ram);
 }
 
-- 
2.50.1


