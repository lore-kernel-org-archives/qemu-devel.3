Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E802ACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs98-0003EN-68; Wed, 17 Jun 2026 11:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs96-00033V-Ha
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs94-0004tq-RL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWibPci18Po7ndhVSlv0NfPsjJ1ks2xSod3h06xAUP4=;
 b=Zqiiyw9XYy8fM1EenCxw3wrY2mteX8M+6caDZzxG4U7jkcr+pxOQ3kxsrimyaMN7rAZ8Dk
 +Poct9xJyqPFGvM9e6VZC3XyrML4cU/f8V3W6qmdVQtfu5x8TfnzecMetpyy87qbuV9WP4
 VlQI/KRDZs8RzvN5QsMDN0e/lxqu790=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-roLOUlhRMOSY2lTLmZdRzA-1; Wed,
 17 Jun 2026 11:25:36 -0400
X-MC-Unique: roLOUlhRMOSY2lTLmZdRzA-1
X-Mimecast-MFC-AGG-ID: roLOUlhRMOSY2lTLmZdRzA_1781709935
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B91171955EA9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:35 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A18E61955BC2; Wed, 17 Jun 2026 15:25:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:21 +0400
Subject: [GIT PULL 24/27] ui/input: Have qemu_input_is_absolute() take a
 const QemuConsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-24-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Z2a0emkl5/QN6sOYSBTNY1lwMv64pBDDtTq841otuEE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpnlzV+NbsThagSghfJK7YHHV8u6R3KQpOG
 8/V0qpPd1iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5SabD/9dTrq07leXW5cHO2VWm7W9yua0KbTNaXX56nOcpigSkltGwXV3hhVdJAWsJhkiURawxg0
 HEgFhP1BKS/iT/UjednNGCnB981AYTE2a20EvUJ4JwuGYMWrym/9O0y9DJmYh03gH9drLAKXMmN
 i+E2HquWJCpR3Apx2XHQDXCASGN7tXWqrCpvH1y/3zOD6lpA2Bx4NxMuHpwtp7M8ESkAy6v2Uvr
 olvKY82Rd69Zc4GiUJVysHcPzftRnWxk6tg3bXnHCBf+GlqFkcCyjv0phjg88CXGmAmiI59r85z
 mAR3jJ66q4eRuDfERcu+ejHcSvAl1oztDJ1dvP53LzRmio3yA72ux7QmQjaLOLMKOtkc9FEDIIg
 1IAEDCP9EKed8t6X7iaN4J7Gr0W+3RDbQKbcDmS3dr2bPiaWq5/2K6hPoMdUChsLKFNj16M/Lq+
 bkg2Qu3VNVzYnhZTGTaV8ztVIkDF4R1llnH40V1phuf1rM1fXcFD+wAQwdAfpy/CxGxBxztG8RI
 T2rHCDYmNIiKn8yfyNYZBlY/+gqpCjL4/hTOwaMlOoPCeGFZzD6jgNUGEeyx3sYkUAmqlHvWmRa
 JgXO8AzL6AWf/SWmIr902h3GCpVf6Ui2NQKh3j5ICWPvLwoKlKblZAnYz505IALpSmje4tut1ZS
 PWfSv8jCAvprOBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

qemu_input_is_absolute() does not update the content of the
QemuConsole structure. Make the argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260611114212.27472-3-philmd@oss.qualcomm.com>
---
 include/ui/input.h     | 2 +-
 tools/qemu-vnc/input.c | 2 +-
 ui/input.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 18088babe2a..a1560cac0f8 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -73,7 +73,7 @@ void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
                                uint32_t button_old, uint32_t button_new);
 
-bool qemu_input_is_absolute(QemuConsole *con);
+bool qemu_input_is_absolute(const QemuConsole *con);
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out);
diff --git a/tools/qemu-vnc/input.c b/tools/qemu-vnc/input.c
index dd6a55ce9e5..a1e9ff00864 100644
--- a/tools/qemu-vnc/input.c
+++ b/tools/qemu-vnc/input.c
@@ -160,7 +160,7 @@ void qemu_input_event_sync(void)
     }
 }
 
-bool qemu_input_is_absolute(QemuConsole *con)
+bool qemu_input_is_absolute(const QemuConsole *con)
 {
     QemuDBusDisplay1Mouse *mouse;
 
diff --git a/ui/input.c b/ui/input.c
index 40a0d507de5..b82622c8645 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -466,7 +466,7 @@ void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
     }
 }
 
-bool qemu_input_is_absolute(QemuConsole *con)
+bool qemu_input_is_absolute(const QemuConsole *con)
 {
     QemuInputHandlerState *s;
 

-- 
2.54.0


