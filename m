Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6503C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMc-0003ya-IO; Sat, 22 Aug 2026 17:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMb-0003yR-0o
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:53 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMZ-0000mB-Id
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:52 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-395ea741d07so404385a91.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434490; x=1788039290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p88Xj8tRAR4HkpKYHo7ZuvFAB+eWTcwDzyO0qx9JXvI=;
 b=RBJS6WzUfn9f40m59NweReP+SiHb4errSrobttSMDx8ugyNkfj0+0a7tEaEHH0h/i0
 BJ0kLkN2JT32bTZ/iiEonI/zNxKkRL+9z9IcHfteZj5+PdKs6mmlWyrXQ9UM501lpmnu
 kA7ap/fvQP+gBlSqX9n3CEsdlCgOINe8vHLGAgYY1HJYf6Is1aAYRRgMJTsCuzAzAqk0
 TrqGxM2Iv2ddBmaUq8QHLAqGj7XZ/gomPriJrJXrdXxiBh2lqHuAcQue0+u/yAWj7Szg
 4CWAiO2RaqgItDDQsb9c4mms3XeIXYeZv/JEf7shiW9fzIfSvimgTNikGh3afxvn2cw9
 LYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434490; x=1788039290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p88Xj8tRAR4HkpKYHo7ZuvFAB+eWTcwDzyO0qx9JXvI=;
 b=rIQzz0NjmTLLs2Cz0ggSQ+ZNFszmdPXMKtKpryeD+Cfzpwo7PXX0GN5Pp5qZrWbblb
 bfH9GpqQSZqIIqMBPYuOwbkf+pUcLbiA/CNKpJ2onIlYp38srVXhcMsokd6YjcSt8ZwN
 66xInQptqUYxNtR+/RFR9Tb/88vEq/3YDU2UlfBMLNSpuSMkigB6GrQOHtM5JewK7R4N
 WlVez/iroy2TFZRo7usI7Qj+x8J1Bd6HOrrj9OJFslIM/0/F6/U0qOKg0WeF1y97muvm
 q/w7aIU1QW3lNkwka8BTQbOhindLNupFlHIoyJeuzx97x1GSNZpyknqN8tc/hlSlttPA
 UvNQ==
X-Gm-Message-State: AFuF++kE/vz0G2NldHfxIPoLSYipzJXTxqESA88oUmyq52BBBVMPa+8y
 aU/gnKjeF/JfpydF/sN/cSAffiO1zADW2s6En5r/Py8kYkuqpd0i4V4dXNnLwc12so6FCnb9
X-Gm-Gg: AR+sD13igap4vyy9E2YViQidtvx0cHceWkLIRHcMPF3Or4e3KcFUR/GXoMH2Y9w46dK
 Q/Z3H2NY5n6FfFy95zjh1g44MDJHVM3lyls8GPjieTJBeHpwSDHsd/oBmaTsbDCequqjKefPBiT
 U5JAhpEST7aTnFO0nkwf5OjlqmB8C2YewfpAW88V8ZpzVgJ7bA3o2P6stO1DIO4M4h2Rm30KEoQ
 TscNHmFkyPdZngbbV0KPWZyuttfPnPzlbllUDT+NWCMGE6nnU86vTfaZRg/lZclgHoz18SnwSMd
 Rs8fGHBWftxCIdZ7xVJGscGP7w8xF144ZkZyIJSQyUsdNQcQ+ThqwfzDLc+jq7f3cqE1BVNGpHG
 dzhQsk7g5QqNDGcHwjNV7Hup+eQbV7B2zOj8/K9g1ufgMDL+rSwPcON7Gvuz/6vhSck3v/RvYrd
 BObSsCIZSMuN+OMqal+Mvuu9UBS2GNaJpn4V2EXP6auZooGqS4blR6Yw1ID8fgYSrrxL8vvJHFc
 umhEXPuv339O5Bxo3M=
X-Received: by 2002:a17:90b:3bc6:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-395c354da4fmr29061745a91.10.1787434490207; 
 Sat, 22 Aug 2026 14:34:50 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:49 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 13/15] monitor/hmp: display IOThread holders
Date: Sun, 23 Aug 2026 05:33:36 +0800
Message-ID: <20260822213343.661939-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Display holder information in info iothreads to aid manual debugging.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/hmp-cmds.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e9fb8d827a..87839a653f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -240,11 +240,31 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  holders=");
+        for (h = value->holders; h; h = h->next) {
+            IOThreadHolder *holder = h->value;
+
+            switch (holder->type) {
+            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+                monitor_printf(mon, "[block-export: %s]",
+                               holder->u.block_export.export_id);
+                break;
+            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                monitor_printf(mon, "[qom-path: %s]",
+                               holder->u.qom_object.qom_path);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        monitor_printf(mon, "\n");
+
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
-- 
2.55.0


