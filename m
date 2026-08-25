Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C32EC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYq-0006jF-Cv; Tue, 25 Aug 2026 15:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYo-0006ZB-91
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYm-0004IP-L6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7e/G6ayjlLmnAt1YsI88wroV6wkiLiRxEzd6nwAmg4=;
 b=atLtannK2zFTufedenVZfRPFgE0RUW00X57a0LbgYMQVESzLKlOgj1qT5N5GwbYEGDe1xM
 pJ9uBFVqH5+nUmIh/SwTd8PTlPBMtusB4wGg88icuvKVml8fbRi1RMyNMIaD6mJVjVEql4
 uG5eA8Ybtpwu1fSSipBVltCzsOg98hk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-O9W1MKHGO6aTg68cHuHF6A-1; Tue,
 25 Aug 2026 15:11:42 -0400
X-MC-Unique: O9W1MKHGO6aTg68cHuHF6A-1
X-Mimecast-MFC-AGG-ID: O9W1MKHGO6aTg68cHuHF6A_1787685100
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DA8F188FEC9; Tue, 25 Aug 2026 19:11:40 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FBC27D6; Tue, 25 Aug 2026 19:11:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:33 +0400
Subject: [PATCH v4 26/49] monitor: reject readline monitor when HMP is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-26-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7DtJbbNtCV+GK9xsiSCtjJEnA3E/Kj94gj9UFrCvS8c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHIJ5xdn+jNX6HAMQoA4GZn/XMUkJMOPFl+
 X1p1RCT2mSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5VQCD/9GFRwYtN3GbGhXrxFQ31vCBicu985vP/c9ZlDLUZDEBgLO5WSr6SBBWccW4e2ZnH/yGia
 Cmc0b2Ev9VAA8GnCWN/1tD/CpYPvfT4YPs+S0oJTUSRnDXaDC1CMlCOcXCNfX/hjZXDEcxnY/Sa
 vTKgHZrIfy1Sa2yDT3O3OT0Iis9NGY/+nfLP0JwYZB+kznBs8DaL4muSNToek5vRr2ZhNR0IdQX
 AWnhIH6oIpkYqliK/5DergJaajc34ayIA+UBM0b6nM/B+yBxnDlexEXoxNPzTxXMHH0Ily/OUM2
 BW25vlq00xJGwVID5PJ81jRhSXNWCHcgH63dJyImtOdTaP7/iQusw7EzZsGm2CwMfNE1g8XoZrv
 2d+q+Zplp7CJkMrkGoZxKSk1wa8CCZlPW1RYYqg222RzKMFt9hgSP58l+2/Lr0ottiMfGoDH6s4
 fEEtxqr/eRuGuaIWwpmcRl8DbMGZy83amJtRDMy74g4iwH6Ata4x6mFFTnG002afAwLnGjUWsGU
 Ss01UDa4SEhIp35u9u/INqMj4V9pM6xPTtdNvt1OsRA2oJGWeO7UbE/n4TC7xcuLxWIlob4BaJ+
 8qALsikcG/thGxALHBmlFw1EJunOM8A/3utmJOZF+Pjo07gvVwY+N8CZLUufEfSo8BFvnLpah3t
 ++bBa/BIT8WZNqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

When QEMU is built without HMP support, reject '-monitor' (which
requests readline/HMP mode) early in monitor_new_opts() with a
clear error message directing users to '-qmp' instead.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
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


