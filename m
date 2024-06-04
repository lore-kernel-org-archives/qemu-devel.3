Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AD7C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENZb-0007EU-Vq; Tue, 04 Jun 2024 02:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sENZa-0007C8-8o
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sENZY-0006hg-K2
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717482183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J+ovs+ClrjmIKL1rj7dPkx6BFhvtiS+7s0voHfgRLgY=;
 b=BTeQmwAa42OR7VgKFJugKm36kWfQu+VW24oaAzaXNiHWn0u36xRtKbYqK/DPnI8b3iD9Dk
 FY4y30UFYfPpef/5bN3nkwCJGBKEXoeLMtYaBm85ZKe7IBT9FrO4PG6jkKYg99yg9/T66V
 W1T0n8xkszmSz89qAnpvBndYje0fxVw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-Z3ak5kjaP22wBTLcZqm5Mg-1; Tue, 04 Jun 2024 02:21:52 -0400
X-MC-Unique: Z3ak5kjaP22wBTLcZqm5Mg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c1e953176cso3348346a91.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717482111; x=1718086911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J+ovs+ClrjmIKL1rj7dPkx6BFhvtiS+7s0voHfgRLgY=;
 b=sn9deYbt4l2gVQPxopiYHSAzWtfnypyMTqMexZ/8I4giLG+e4Cy5ZSCElHo/4pguv4
 DLyIl4V7giHphOf/zlYogfgwr5srawEWiDYfw6Cyoyc2Ao2dqRbJSacpRvuvjcKlvsxi
 qbqUHTx7j8yK8P0atcJB5RTEIpd/Ej23dh2TB+f+nTXwvGBxClYxEI/MwSLGBIIjkMM6
 u6md2XvgTznQHhUz3s8yuTxG3zQxUbpzJbhkaXFMAqbtvxlFNZJKOOrE+hWB9SXkV8so
 pgOH8NFgsLam+niW6eJabFlecSAdEyzP8vPzcwZOi/G0vP8ALasnl2zFRHV/lf2dvKTs
 wFFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGWNuTmJOygsFT0L/0LmuUdoZCccZPOVrvuAeql8F247CV66EPeJg4NuBDIXncD1b6UAvms6vja4ACxFEvp72gEYBA5oo=
X-Gm-Message-State: AOJu0YyPzQQnaoHNPVWrVc5efzmU6Gyf6xZ4YsER5p/jLAkE67oh5Yoi
 bzsB8Q/k9BLgedtH4UQO2XvuHvBZIFufjJTbSJv0AzMsRSAWOwEKRi5zqJ6hW0ceda7/37t/M8a
 ORogf3Vt5MbdDMqhyfxWoSI8WCZnyG1wXzOZ4KBs15BcReYiTrsaZ
X-Received: by 2002:a17:90a:4942:b0:2c1:9e9d:b9b5 with SMTP id
 98e67ed59e1d1-2c1dc57513fmr10587222a91.15.1717482111527; 
 Mon, 03 Jun 2024 23:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmFc5rcpZWlDf+G2xM7RA718gsPhiOJT1tgmOMvY0SJVixYuPDIKpAXotIhrTpC/eBU6RApw==
X-Received: by 2002:a17:90a:4942:b0:2c1:9e9d:b9b5 with SMTP id
 98e67ed59e1d1-2c1dc57513fmr10587203a91.15.1717482111060; 
 Mon, 03 Jun 2024 23:21:51 -0700 (PDT)
Received: from localhost.localdomain ([115.96.138.219])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2c1c27ad277sm7717987a91.6.2024.06.03.23.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:21:50 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] qtest/x86/numa-test: do not use the obsolete 'pentium' cpu
Date: Tue,  4 Jun 2024 11:51:33 +0530
Message-ID: <20240604062133.40637-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'pentium' cpu is old and obsolete and should be avoided for running tests if
its not strictly needed. Use 'max' cpu instead for generic non-cpu specific
numa test.

CC: thuth@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/numa-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 7aa262dbb9..f01f19592d 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -125,7 +125,8 @@ static void pc_numa_cpu(const void *data)
     QTestState *qts;
     g_autofree char *cli = NULL;
 
-    cli = make_cli(data, "-cpu pentium -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
+    cli = make_cli(data,
+        "-cpu max -machine smp.cpus=8,smp.sockets=2,smp.cores=2,smp.threads=2 "
         "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
-- 
2.42.0


