Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15523C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14SX-00032Y-Jd; Mon, 31 Aug 2026 12:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SV-0002vY-NZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:02:07 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x14SU-0001iI-6A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:02:07 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso2933885a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788192125; x=1788796925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p1erpzxKuw30oc89FICNKXtNCzj0wppAW28NB6qgVRY=;
 b=PpLpV3eNgOATSpj/b0KxaBsAHMbqwE3YWnUsinuyN53YIgtB0qhjXoAAQdHPj+O9nN
 fIjTkfFyedKZAHmm5qGTbzJcmQGONg7SXkuzDVGYaghrUCjkjA5nNWzOLJUQhGqrNnWU
 79UALZIf/w3Vgto5FaY5P9bS2N1l0awY14Y0/Bxk28tGB1VxSLrOV/AWlUnbjaKYMqvw
 g3u+s9LfQuii/kS+JYhQTxVn6f5lUZXK/JWVas+eo8jeOcU5YSjmPkRgFw5SBbFf3Te3
 n1FtKNZ3n1nnGPfZtxGTy59C5zQpwvO3Q6IyujdBaI2O7VC4qIDjRMZdThiFRcLM/VVw
 qQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192125; x=1788796925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p1erpzxKuw30oc89FICNKXtNCzj0wppAW28NB6qgVRY=;
 b=oQzmqbOg1q+75x2BvalZDS5dzDMWrWyzthJiArCeAtGPuQ0zhUXQXL4R2EWTAMwrpe
 AsWNAwA+fUqp24y2MUPpgLK/gzcKUWmVF46ovK5K5xxmBtepuj3QLXP5s0N8r4g+EmK3
 BcxbZ4fwplvJR8cjLryw542HEaA8DMF974ENq4L2GJRCfSYOzeUAhYCV5/ZKSE6ohT1a
 DPr3zWuxjG3w437ANn8gOpnnTKRPKto7/M/DjJuwqll7nW/WcRsRnkLOHtk8qjG7+/lu
 JI2qL/8IJ9+uZjjDg65052Tbow9GP3wp4lsfwupEMpAONKYnE+I6+W+nwysmEfGCUjaI
 n3DQ==
X-Gm-Message-State: AFuF++nCiCvnSAB1Ps6QfGkXRuQbYKtGc5NIGO5+y3AntiRaeknkY0vP
 L3ohoLi6J/Qs1NG9DxZx3uJrI4A6csqsuG7qBxQe+0wIfg7ImLaPYQ7hvDCvC+WbdgzzbhOf
X-Gm-Gg: AYBFou2EwJ/TuriNs/1edZqEf6qEnJCmwTYoVEIyz0l7jAMSxAtFm91nk/keck2Xu1Q
 ZHg+x7R7TXX23jJ+3S6qWRvggYAbXLno0Hh6eu8hKK19ucPyZf3Tktg5foeFSASTB2w91Wzdyfd
 5pFzsDbYZBAVc1RkzMM1bjMT8agRMy0Qqz0dzCM3aHCtkyEdM/6qix3HPtTFYkPw07esWtyQKcF
 7q7XuzLJVhaCqZNoBVaZOKmady/ME1DEQnsHE+yJsX63rpVIrmBNtU+0OrOe7QbhuyebpyVJiYT
 nDvF2kcztf6vNpXq1q41fdqwQ3uYaePaOuT39bSHCe4WX9fEhQUcdnxn3936KveVz1o8x8iGVS5
 47bslpOa+LeYAxdannhe6TGLVkHizqPQlz7tWhY6SnZmsZoFcpTKKZuLoNYXflPujb7xTWR5XqJ
 HIWVFr/mEJgWRIozVV0MWjNO3jjG3QybwIdL9TgESS0Zn9/3Q23bIrnYM+ub0s0BXDNMV9QEoqb
 9MgiFm/
X-Received: by 2002:a17:90b:28cd:b0:398:9c00:29ee with SMTP id
 98e67ed59e1d1-3989c003c08mr28238108a91.22.1788192124491; 
 Mon, 31 Aug 2026 09:02:04 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b28ab0571sm22689520eec.4.2026.08.31.09.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:02:03 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V14 13/15] monitor/hmp: display IOThread holders
Date: Tue,  1 Sep 2026 00:00:34 +0800
Message-ID: <20260831160038.221776-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831160038.221776-1-zhangckid@gmail.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/hmp-cmds.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 4e8d996dbb..0e64af349c 100644
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


