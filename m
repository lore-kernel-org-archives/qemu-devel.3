Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4495BC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJe-0002hd-EQ; Sun, 16 Aug 2026 15:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJc-0002Kc-6Y
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJa-0007gg-Lk
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baVsEQw9XNWf+0jxiSbVi9djuAV9q5Yn/7vuMEEwozQ=;
 b=foV0wsly3wCkJvsR/ou0uT9wU6fUNetICWwL42uX+Wb6kGKzOemF2ZUwoPMk8ExmLN2HUl
 rMYPcq5nTGIiz1PAhDoiyXkN19l4iucnOjDCgDXIoBQQgTyImKCS2np63IrKHxqc96DIvV
 anA4NXfThjMeM3JKVupzEHDNCWSSoXQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-IxB-PREINviZpMRiQDCRlg-1; Sun,
 16 Aug 2026 15:14:36 -0400
X-MC-Unique: IxB-PREINviZpMRiQDCRlg-1
X-Mimecast-MFC-AGG-ID: IxB-PREINviZpMRiQDCRlg_1786907675
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DE4118002C0; Sun, 16 Aug 2026 19:14:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07CE0180034F; Sun, 16 Aug 2026 19:14:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:54 +0400
Subject: [PATCH v3 27/49] monitor: reject readline monitor when HMP is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-qemu-no-hmp-v3-27-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=twX3cnfqvNWtqcuR8yai47663XdB+jAHlsuulV8uGbI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguyhUXwHsI+U35+gFBP27yxm3S6YHBIN10C5
 hsOQooQ9nOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsgAKCRDa6OEJdZac
 5aAFEACnkkhy2GTMRHRMHTkr3kR2N/3wkKbVzDheIkMi0k6k9qPbUvImQiFzpRNlb1q2rYWOC/z
 K51ckyrq7pZGpKQcqesdafapxD5y6SyeKMWC7XwKOwk0K0WgfoSXBw+5DC9TgQuUnSTqShQAZNc
 8BTKBEzTAtJz7dGop15UPNHsuRo8sGkRcZU8v+VvWhp9mHX19yEetgp+5KV37sAncH+QCUAC66w
 BbYUxGLNmiTTKxtctRVmAwU5+bSPXV1VGmuNQuzecOJp+s1oB0gPxu3EzmLHzhBQWJhZ4AmTxh5
 FF9Gt7PG8WgUN+tR2DZ6HKTChdSnEMXPMf+yRLMoSD5In26H60N9zIhynDYAVzOxG2pBQPbQBka
 WeAqM86sY6MCPOjdcAVpVdwonKXt/DorxNjF086V0vk+I11z1dQdlWI5S+2z6W0YAHf/CTVpqUj
 p9Dvi3pPSJTohIUYeN8vP2ndDF6/r3wdLfADlRJzdiN4a77VtbB7ry1xAjXD2/utiYw6umfP6wF
 HL+Rft6XNRfdcTve77diS2JUcDLwplcIfXUlFKcGVXOfJPBhEIdEmrsWo3i6lUfMhQRqefOPOcM
 /c+D977+GIOcsbz7kgENrBAM8A/8RRbE5bQdQTaS+J2iBDqnJsB3th5/872onk3qcruCJ1XBs1s
 rfE9ip4wkZkEeKA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When QEMU is built without HMP support, reject '-monitor' (which
requests readline/HMP mode) early in monitor_new_opts() with a
clear error message directing users to '-qmp' instead.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 monitor/monitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 6d6ffbb0f78a..8528af6f79b8 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -776,6 +776,16 @@ int monitor_new_opts(QemuOpts *opts, Error **errp)
     MonitorOptions *options;
     int ret;
 
+#ifndef CONFIG_HMP
+    const char *mode = qemu_opt_get(opts, "mode");
+    /* readline is HMP..  */
+    if (mode && g_str_equal(mode, "readline")) {
+        error_setg(errp, "HMP monitor is not available,"
+                   " use '-qmp' instead of '-monitor'");
+        return -1;
+    }
+#endif
+
     v = opts_visitor_new(opts);
     visit_type_MonitorOptions(v, NULL, &options, errp);
     visit_free(v);

-- 
2.55.0.543.g5ebe2ebe4ea8


