Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE80C79FA8
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3T01-00061b-Dk; Mon, 07 Sep 2026 02:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szz-000610-L5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:35 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szy-0006AQ-1h
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2caced6038eso30594985ad.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763113; x=1789367913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l5YVe05pjG97AGrI1ym/t5dZv++HeTZWtnHCxE2pueI=;
 b=KUGE5K0HLAK11lqlQagQltcP0s9lxyGJLsQy+uD4xpdOhaW3D4MvNwH7MPybARgluM
 0B9lsSOByDBzacaN6re3DbckJy5WBvht17KRn62oyn9shY1EbxScq8pw+Y93goUfq1Fs
 fYq3YXBe/OXScxKhfMZ+xuhIEEVGf5TL7aQj1nHnJPlBUHhKfac0X/Hwsj6mvzKGml0i
 PVgHHU//M2kMfyJSPHjIlh15+ETzMGte1lL8GLGMMqSCcT8v+ZAtfAL5mtzv6B/up0W8
 iMT2Hnz6etxvxmHqBBDn6je8tA9kgRwQwIjn0281LwY045d90SoGxEBsvHIjh9Wlsqy1
 QFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763113; x=1789367913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5YVe05pjG97AGrI1ym/t5dZv++HeTZWtnHCxE2pueI=;
 b=DM9BKothFBnKu6jSLE5iV6gXhspFb9iIJ7xqCtQZLR9te1XfrjtOjcXGcCFKWhlwAp
 yHaso784Vg7dU5UEvQWTZ4p5bmNHGzsNBBtljxkjx3zcC8dEk1lELbu7i8SFigPQq3rm
 ArAdjCh20x4eUcpMEnrJvXYOMYPJZKRDmJ8PfubOaSuK4oig2OhT1kTxpHpyVrT4cJ+C
 Bizh4cbYGONYEz30I66ERZN82rnLB//RqCYuBjypxxTLmrVTpBpyeArXxTuo34ZoMi0i
 SnjpX5SxELvlEqhvOPA8DFnVwu5GM2Pp8G8nJr7cagFsMnllGbXP9p6hzx5v3+acmxvs
 q2PA==
X-Gm-Message-State: AFuF++mPaR/HdSQVllIfu4QuPqZevtEZqEuOKXY3zouIaoAPcvvChPzr
 JivA+BIzpJzUP53SJ9YZVLL8zF03MHWC5aTVM6Jj7rl9YdxDSkA4D/goqc7tjVC0jtxpag==
X-Gm-Gg: AYBFou3L/VMXLvYrc2/mJSGrGR8KRhOE509SXWxSdblsfqvQeryqFPSQ5d5USv5ktw7
 Gm+hSyVWYwSAe4qljmcrWkpPUYBhtg3suuFfBK+7ZQA+iHW1oaNBgTjtqShEL7zIEfbeI+Y+NYd
 J9eIE9HFxk55AeJxMvHHy5EuGC9NDWAF5W42j9+SS9zYSNyWAUlIDd/ihx9rFXib0rGZAsWVBB3
 DxaGydKPUCn1f3kkjtQEQf5h8IROKj7BHNNyzUwW8UZujpFl+Zspr7UTxj09UzVhw/KORM7QgLV
 5StEIuPijhS6ZS2bJfRR7CZ5wvQpXCMz/VA0nlR/1ENsVmKRqgWhoptNfHZ78qWhd5Roi1cV7up
 XTsH7fK8taFjKgccAH7ogwob0we8QtuJtIQ3YHRvnfMGPolZT8hg7hb666iudqHxD17TGvFP78p
 ++LS5OzoTt65FH5VaTTmd0cxTlqMDfA1KmEIcnoCTOE5xch6EkAGxZs/Hpkl59XSQLv+btO5cRW
 p2VUhlsU8M6J7cPfVn/CK80viQ=
X-Received: by 2002:a17:902:da85:b0:2bd:2c3a:2a36 with SMTP id
 d9443c01a7336-2dafad14a8fmr247945635ad.0.1788763112636; 
 Sun, 06 Sep 2026 23:38:32 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:32 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 12/14] monitor/hmp: display IOThread holders
Date: Mon,  7 Sep 2026 14:37:23 +0800
Message-ID: <20260907063725.626685-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Display holder information in info iothreads to aid manual debugging.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/hmp-cmds.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 91701ddf33..d7dd24d951 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -246,11 +246,31 @@ void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_hmp_printf(hmp, "%s:\n", value->id);
         monitor_hmp_printf(hmp, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_hmp_printf(hmp, "  holders=");
+        for (h = value->holders; h; h = h->next) {
+            IOThreadHolder *holder = h->value;
+
+            switch (holder->type) {
+            case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+                monitor_hmp_printf(hmp, "[block-export: %s]",
+                                   holder->u.block_export.export_id);
+                break;
+            case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                monitor_hmp_printf(hmp, "[qom-path: %s]",
+                                   holder->u.qom_object.qom_path);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        monitor_hmp_printf(hmp, "\n");
+
         monitor_hmp_printf(hmp, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_hmp_printf(hmp, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_hmp_printf(hmp, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
-- 
2.43.0


