Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C47CFC28A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 11:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0fg6-0003uO-V8; Tue, 15 Oct 2024 07:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0fg4-0003u4-NL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t0fg3-0003ik-An
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728991520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tQdK+iBnHlWAIObBnXerPmjnVulnI5k55VzkpB5LaYs=;
 b=PeRD3CA4W3x+YbUj6fjie3a9bb+x7to4GFbT9BbtMTBWkH5OB4f+JZc5+Kex2LqwBcuN07
 W+nQmTVCw4krKKjXZyKDT8ZJqEQK4+ei6MLWBuu0i4pIW8XMSO2srMYP194KNGVeSlPL/B
 QwZTqJ/+cntPQzVaxo1RDUctM16LKoQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-AUC2wp2ANommfCjQk84bbA-1; Tue,
 15 Oct 2024 07:25:16 -0400
X-MC-Unique: AUC2wp2ANommfCjQk84bbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DC2E1955D72; Tue, 15 Oct 2024 11:25:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F28431955E8F; Tue, 15 Oct 2024 11:25:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] ui/console-vc: Silence warning about sprintf() on OpenBSD
Date: Tue, 15 Oct 2024 13:25:10 +0200
Message-ID: <20241015112510.412471-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The linker on OpenBSD complains:

 ld: warning: console-vc.c:824 (../src/ui/console-vc.c:824)([...]):
 warning: sprintf() is often misused, please use snprintf()

Using g_strdup_printf() is certainly better here, so let's switch
to that function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use g_strdup_printf() instead of snprintf()

 ui/console-vc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 8393d532e7..53fcee88f4 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -648,7 +648,7 @@ static void vc_putchar(VCChardev *vc, int ch)
     QemuTextConsole *s = vc->console;
     int i;
     int x, y;
-    char response[40];
+    g_autofree char *response = NULL;
 
     switch(vc->state) {
     case TTY_STATE_NORM:
@@ -821,7 +821,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 6:
                     /* report cursor position */
-                    sprintf(response, "\033[%d;%dR",
+                    response = g_strdup_printf("\033[%d;%dR",
                            (s->y_base + s->y) % s->total_height + 1,
                             s->x + 1);
                     vc_respond_str(vc, response);
-- 
2.47.0


