Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CEDC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 02:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkDXv-0001yq-4h; Mon, 17 Feb 2025 21:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tkDXs-0001yS-NC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:41:12 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tkDXq-0006s5-4u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 21:41:12 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fbffe0254fso9218134a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 18:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739846467; x=1740451267;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1AOeiJdqiiI5aRq2ttuarwBGGm5TOHJs5D4HyEE5s4U=;
 b=HQSWiWDWLU6eXbwQcxBrlx5BMdEf01s1c6u004HoCsin10L491QL0ja0nOAqJ649mO
 OFaLeW+tVlUE2M5GVBl+TMg+EYOOaIcseFFYIFpUNStUCi9LfFPK6KIhAn+0o0EN74kD
 0Q2t9MeO/7pNM5Dl8a4+7XDHeOL+nW7e3rC91fDd2g3Z0XcIJmI0qp44MC/VTTYoFxm+
 4QAedNRa1PkV4qLiS/tGE5hlaPz/WEq7T5ceQqVZ8EBtUVRGTcBV52HjIi6CkRW/SX8u
 0AwikEebP/n1/tMDcX1ccsULYnBu3sz+C8dIdcATiYoSeg5LmK/jq88XUkG0vRxgexIF
 Tcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739846467; x=1740451267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AOeiJdqiiI5aRq2ttuarwBGGm5TOHJs5D4HyEE5s4U=;
 b=U82lbL16SAh7ALHYRxiKWX5Iws3LIg/Obr3vDO5jzZMQlBEgsi/ZcNwXGILR9DHRoR
 63pDecAeXqgEWBldMAtW1zMnZtvc93guZ8bk5Nwq20zz9G+ER03bjjyrwxpk8CI2ovsr
 Sl495GdnDLVW9Ox94xHPAn1REI//+XxzGdV7wJvd5kh029cUKQxh2XsEGyQKGp7n6iBF
 KHonoBCLHAgUk+NgI/m0LlgVsHjIVT9cyCa/HzdsaoISGJzW/zX6d46uO5lpDHEN5DwV
 Ld2+R+9A71TsBVsNsbdPyd4yETK5Tt35nzWIEI5RPs0trormn/ZQOWljwtdhkHuubtyJ
 s/7Q==
X-Gm-Message-State: AOJu0Yxrf8gmln3uKqyKwZylrF0OZlR5gdh4uv01rFDltiOTzouve/13
 veCL4kaz3v/jhgvPZAspJpK8/XbsSqcZtDXBPAIy7V3ktgbcrBhyRK08fi0oaxCV5YjfW2r+vjj
 HEx2Z1g==
X-Gm-Gg: ASbGncs4iyENzQ7kKyBup0QWnhjKrCofrVKyuO2GCKWb6eFiYYdgU2RqdytgqQkDGcI
 UzvLSXISJlNz3g2dGcmQuYLt8E997sKOldjuD+h5LGCCt1vGcmdSc7zbqPtM8A4pA1A0XkfkkOM
 b4JoR2m6GaEMKzXsXWCdSGXKCw9oJ2UXryl7zlEUwrEpLHh94ET+DFVDKGKmtJGc5HmSNdu8Xxe
 EPG3AmoZeg7zSZBPI2MM5ZyNzZJdiiLGjVodykNuY+hnewkBTsssFOkE6kw44Cg//4c2F3QFpAA
 /YJZKm2eV7MQwHJ/rZekEyV2rJFgeAhBg9IKpYJB
X-Google-Smtp-Source: AGHT+IFdh0k3rnhsBaJxSDvpAKnJNaj9CJZTCWV70suzZI6BW3MDRQu6sPQeyms+uUnFYmdJ+glCJQ==
X-Received: by 2002:a17:90a:d44b:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2fc40f22d72mr22170952a91.18.1739846466865; 
 Mon, 17 Feb 2025 18:41:06 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220f8682181sm55625905ad.209.2025.02.17.18.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 18:41:06 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [RFC] migration: Introduce migration throttle event
Date: Tue, 18 Feb 2025 10:39:55 +0800
Message-Id: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hyman Huang <yong.huang@smartx.com>

When the developer is examining the time distribution of
the migration, it is useful to record the migration throttle
timestamp. Consequently, include the migration throttle event.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/ram.c     |  1 +
 qapi/migration.json | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 589b6505eb..725e029927 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -524,6 +524,7 @@ static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
 
     /* We have not started throttling yet. Let's start it. */
     if (!cpu_throttle_active()) {
+        qapi_event_send_migration_throttle();
         cpu_throttle_set(pct_initial);
     } else {
         /* Throttling already on, just increase the rate */
diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c..0495065b5d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1393,6 +1393,21 @@
 { 'event': 'MIGRATION_PASS',
   'data': { 'pass': 'int' } }
 
+##
+# @MIGRATION_THROTTLE:
+#
+# Emitted from the source side of a migration at the start of vCPU throttle
+#
+# Since: 10.0
+#
+# Example:
+#
+# <- { "event": "MIGRATION_THROTTLE",
+#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
+#
+##
+{ 'event': 'MIGRATION_THROTTLE' }
+
 ##
 # @COLOMessage:
 #
-- 
2.27.0


