Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03631CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNFX-0006Sx-GT; Sat, 30 Aug 2025 11:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urwyF-00004q-4G
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urwyC-0001j8-VF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 07:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756465715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGvG/LGRqC2htS89N6HiSrot7Fa5WLiu5iEYx6qvNzE=;
 b=JbLQ5TxjY/88CNw39AgLr0tJUiV7gTVLDNcB/PIqhMOEkKjuHyD5PActzrJwkPmn6o8oSt
 aTLTgT/8/C9uNn1OxpFgAMTdLGAer5UukFvfqE7VHQVkJe1/OWpzWFqFuXtpxCMn3Uqvjf
 k5cVFAm9UXvCgx4oaSq8w8gJpU5i60M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-PR4zvEojM8O3YlsnkE_wkQ-1; Fri,
 29 Aug 2025 07:08:32 -0400
X-MC-Unique: PR4zvEojM8O3YlsnkE_wkQ-1
X-Mimecast-MFC-AGG-ID: PR4zvEojM8O3YlsnkE_wkQ_1756465711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17278195C27E; Fri, 29 Aug 2025 11:08:31 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8349E30001B5; Fri, 29 Aug 2025 11:08:29 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 6/9] qga: ignore channel_init() fail if 'retry_path' is set
Date: Fri, 29 Aug 2025 14:08:10 +0300
Message-ID: <20250829110813.50286-7-kkostiuk@redhat.com>
In-Reply-To: <20250829110813.50286-1-kkostiuk@redhat.com>
References: <20250829110813.50286-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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


