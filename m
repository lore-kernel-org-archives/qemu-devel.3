Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF03C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yB3-0006sm-L2; Fri, 11 Sep 2026 06:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yB0-0006jR-3L
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAy-0007Km-Fj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:08:09 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so503182a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121287; x=1789726087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l5YVe05pjG97AGrI1ym/t5dZv++HeTZWtnHCxE2pueI=;
 b=FyTSSfKuLPli1mDCawowJgDIq2dAe6+ZCeCu4W+jd0HD+v36tEtk6nH6e9n9EgPOQB
 wU3/rqXvDp64Fypd84pRO8GqqIzE+EUnqRoeD3d88vfWkoxDa4jFbO7t5u0Cihc0nVNv
 5jHLqacfVSITHB7gzCgyjlWJNhiukkvW4/5L22WzOOw1IoqXoML6UguIKZdYtDL+U/dK
 zhiilsPE0MqLiUfJwEmShg6l+F4BkNfpe4cLlgFWIV9q6qStHbhehoW4HyGG8Hyf1lDR
 YDz4B6pUzfVKyxugnay6SPoVmH1CMyqK6oN7+3AHlzZ2WPbINtsfoG+MR33X9CHPhJHD
 y88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121287; x=1789726087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5YVe05pjG97AGrI1ym/t5dZv++HeTZWtnHCxE2pueI=;
 b=pmBmB0G2ez/VlWl+RY8e/cVe8Eg+WUVNhBCwiRCMW5w9GJJgYrUrCNtaPR0qd9jb5P
 O8H0cIIjmWk9MNtisSGFFBppWnLPw3zTmYDJSgoDyL6aAC+FYrWdCk2hB0lZrC2C0ABs
 MjWdO39l8p/j4mtGlim1Fg7rrI5Ju+UYU6F/Sx5GBr2X70G6BfuG+UdZDlw6AbgpkcTT
 vspj3WjfGlP0AzLo2SkxGqoD/2Fz6TuLcgkGPTyi6X09F85krz8juA351YnOYdS0iDEl
 q93cAHaJa3DEGjw92pZFe/X1d234wJ+tUKwNG9mp5FbzW33FodsxXJYDKy/b/k1OFKFn
 sDzA==
X-Gm-Message-State: AFuF++le6m9PeZTjLEdBgQvqAWvvgf2zA2LqsocrntLPlaoK9H1Tf0De
 gFxejJFV8McPuXqtWYYvmjgWElzdncAr56m4GQHj9xHe3pft3GC+tzJcXU3/goxCYJs=
X-Gm-Gg: AYBFou1jR4H1JVW4ygE19c2pdWhoLsGlgxHF+bagwvxv0hLkBE3FAPyL9GywuUROS1I
 Z7Eu2X29lI53nwRKYwnC7MBamV15XnrwOc/Mt5Yi+/dUmxDmF7JGapgQ3FpniE2pIErmnG26amW
 aJljKF3ZhCLk2UOxQAjH6yhFNkxYRKkRMHnMXEVUmWiQCVjksTfudUO34vLmw5vM7PzoObRGA0C
 6idZwxu9ScaUPLUI0aCtos/1s+LCUd7lD3iabrQ9R+clK3QQ6tfP17tXaaOeAgEQE4xgK30CeH6
 Z9NfoK5p08eL5VYAsKy5DNKPj0neXWWSWc0pdUSZ8YAk+Yi5eGc+lGkaISGqP2Nh8rX+T53c0si
 m6ppUSH/I5ik1sF2ziwDJjz1IK0fe5NNHkVKXBLe/5G6I0NtXsw+paBex+52PHiKKuHIX0Up5gJ
 0N4Sl/iAcYNhldx0yF82mG+r0WQIM9e+Zql8Cqnfe8sr9r/KZzieflIjFcAExY/2n5sQU02Jw5t
 aUKPP175AcYBl8m9lU234eFRGM=
X-Received: by 2002:a17:90b:6cc:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-39d9bd8fb3bmr5683632a91.9.1789121286838; 
 Fri, 11 Sep 2026 03:08:06 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:08:06 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 11/13] monitor/hmp: display IOThread holders
Date: Fri, 11 Sep 2026 18:07:07 +0800
Message-ID: <20260911100709.726366-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52d.google.com
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


