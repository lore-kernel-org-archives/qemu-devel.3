Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784C8CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcTu-0001HZ-1s; Tue, 13 Oct 2026 09:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTr-0001HF-20
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTp-0004f4-Ja
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XufLaf7X6ekMcjLtVZHuo5NIsJyviS1Pez1efhVtyQ=;
 b=Bp3zWa02QrX/vIZFiO8bQg6PA+49R3VNEiU7ODx7C7c3RMz8sluk1aT1+cAxo4i4goSeoJ
 C0dqcXE41Tg6Ojr48J81JzPKprKdGTyrS4rDxTmxqLjoZJVjQMMezHPnxTv75ErBWE6g0k
 TG9cRTDLNnfzuKcPSPSJ5ENvb9X3+Ro=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-F81U4WASPAS3G8QiTD2CaQ-1; Tue,
 13 Oct 2026 13:23:40 +0000
X-MC-Unique: F81U4WASPAS3G8QiTD2CaQ-1
X-Mimecast-MFC-AGG-ID: F81U4WASPAS3G8QiTD2CaQ_1791897819
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978081828BA7; Tue, 13 Oct 2026 13:23:39 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98F4E418; Tue, 13 Oct 2026 13:23:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:02 +0400
Subject: [GIT PULL 05/40] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-5-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O1QrZ/zreJ1eR6/EU08j8vkiNPFj0nogEbCLLsC1g0E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCc4CBqxaze3mego1VRtdrZ0tggWCCReZ1Y
 ipKRjiv1kuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5TmnD/wI5ZVKs88hrXBIgMEHWTGtUB0awJ3l24xuRWaOpI84e4m5qtrH+vby3M2ib0w5suKyvKl
 cJK7o13LhsTovhybgMrDPNHMFUpwxdE/88FYtgcEohhjfHA5MfyXmCY3UCQ19mNsc7eBeS0P8cX
 8HTuoIKVEdLJupwuAfbzV66pYOhbfre/kvOmsdddX5wDUY7VG8sKa+qojlU67iEGG0d+RAG36nx
 DC8HcEc/EbT7Azg+5uuxKqygjoLQsPk+gUH0NIPqz2ppyoIutWl+CuxpCFt90yl7tqs5KhUHRHZ
 7tQNxzLNsQXbeBOXcL/BTBPbPa7heEZE70m0neHY64vuq7QhjkvA8juunY7ndZAbXQa7h6Fra4g
 KHTJDQJKhaWGMGZ/xTF9WdK9HmxORQAIpDVKgLS7k+9QX42UMUQW79Rg5+ETPFLSVPV8gAkgtXH
 gOSP11Y7KzAh42y4iR0PyvZM6iYbufbJ3Qt3r/dJiRti/kzRS4AeSt2Wd3vIhqEfzQw+/MU4nSI
 q8vLMfbWx3VgIge0kFvfgO0QjmmvTwr1bxGE2t7X5oO3CBwvohFimeRdOLNGJLIUUN9guFwSlq6
 hn3uMrZ+gMolgDpwj7GAs4B0AM8v5W63iJgIgmefyZ1yF9CtefNELLpJts977NNkBlCa8uTOj8y
 sz9DCsp1yyqvK4A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Szymon Lukasz <noh4hss@gmail.com>

The terminal size of a mux chardev should be the same as the real
chardev, so listen for CHR_EVENT_RESIZE to be up to date.

We forward CHR_EVENT_RESIZE only to the focused frontend. This means
frontends should update their view of the terminal size on
receiving CHR_EVENT_MUX_IN.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-4-2c3b10d829b3@gmail.com>
---
 chardev/char-mux.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 881443d869d8..5a90f0221b48 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -264,9 +264,24 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
     }
 }
 
+static void mux_update_winsize(Chardev *chr)
+{
+    MuxChardev *d = MUX_CHARDEV(chr);
+    uint16_t cols, rows;
+
+    qemu_chr_fe_get_winsize(&d->chr, &cols, &rows);
+    qemu_chr_resize(chr, cols, rows);
+}
+
 static void mux_chr_event(void *opaque, QEMUChrEvent event)
 {
-    mux_chr_send_all_event(CHARDEV(opaque), event);
+    Chardev *chr = CHARDEV(opaque);
+
+    if (event == CHR_EVENT_RESIZE) {
+        mux_update_winsize(chr);
+    } else {
+        mux_chr_send_all_event(chr, event);
+    }
 }
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
@@ -378,6 +393,8 @@ static bool mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
+    mux_update_winsize(chr);
+
     /*
      * Only move to opened state if we've realized
      * the initial set of muxes:

-- 
2.56.0.116.g6de20f6092dc


