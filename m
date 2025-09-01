Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E011CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2eW-0000MK-F9; Mon, 01 Sep 2025 07:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eP-0000Iw-Al
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ut2eJ-0006Ai-Ah
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756725874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGvG/LGRqC2htS89N6HiSrot7Fa5WLiu5iEYx6qvNzE=;
 b=SH/1Va9/F0hyllZBirWF77TgTuGogyq106i0a5CYjzvSBRCafs9QADD0t24eKjLKPxwgYn
 GkhmEfUdhjOUL2IuhGwyXCRDZJeQ/T7DSV6AmeDoeuNy7z3jUjtEO8M5moG1TTESHnnzrB
 QX21LK9cgnopk7sRYo49YkoKCDXp4L4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-dHT-a_PYMUOrMPT_th2QTA-1; Mon,
 01 Sep 2025 07:24:33 -0400
X-MC-Unique: dHT-a_PYMUOrMPT_th2QTA-1
X-Mimecast-MFC-AGG-ID: dHT-a_PYMUOrMPT_th2QTA_1756725872
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A022195C27B; Mon,  1 Sep 2025 11:24:32 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 670221800446; Mon,  1 Sep 2025 11:24:29 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 6/9] qga: ignore channel_init() fail if 'retry_path' is set
Date: Mon,  1 Sep 2025 14:24:10 +0300
Message-ID: <20250901112413.114314-7-kkostiuk@redhat.com>
In-Reply-To: <20250901112413.114314-1-kkostiuk@redhat.com>
References: <20250901112413.114314-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Windows, we run QGA with `-d --retry-path` options by default,
and expect that QGA will start even without the vioserial driver
and will wait for communication forever.

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250825140549.146617-3-kkostiuk@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index a1bf8f53ac..dd1c216f9a 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1512,8 +1512,12 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
 
     if (!channel_init(s, s->config->method, s->config->channel_path,
                       s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {
-        g_critical("failed to initialize guest agent channel");
-        return NULL;
+        if (s->config->retry_path) {
+            g_info("failed to initialize guest agent channel, will retry");
+        } else {
+            g_critical("failed to initialize guest agent channel");
+            return NULL;
+        }
     }
 
     if (config->daemonize) {
-- 
2.50.1


