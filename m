Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02924C61DDA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvMI-0002FN-QS; Fri, 28 Aug 2026 08:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvM7-0001nU-7Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvM5-00033V-Tm
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7e/G6ayjlLmnAt1YsI88wroV6wkiLiRxEzd6nwAmg4=;
 b=fjaKmVhjgovahCXf8n1ekUe1LLMLVFVMdf6Ohc57tt825WXb2U4Z3BJN1eXOFM9xuYbbkC
 4Z3WhZrfCZm2k2EaDTlswIcVysqM4ygtbor2P1r961XqKzNC61pWdRpOOM9Hgdjx3utKNh
 wKeviDeJBTGiGe3HcZo9+1iOmFIS5zw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-4y8I2Ag5O3eZkWwqxw6Zaw-1; Fri,
 28 Aug 2026 08:06:40 -0400
X-MC-Unique: 4y8I2Ag5O3eZkWwqxw6Zaw-1
X-Mimecast-MFC-AGG-ID: 4y8I2Ag5O3eZkWwqxw6Zaw_1787918799
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89B0C19775D7; Fri, 28 Aug 2026 12:06:39 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B50A31956049; Fri, 28 Aug 2026 12:06:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:24 +0400
Subject: [PATCH v5 27/50] monitor: reject readline monitor when HMP is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-27-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7DtJbbNtCV+GK9xsiSCtjJEnA3E/Kj94gj9UFrCvS8c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk5DA+WJPSDZtEr0/8pKwcsNfq4NRU+otAgV
 vMZKy2LAZSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5RVkD/9fPzdii+Br4au3vXn0p5oNG/3lF1FfMjlUFUqpK67tHFD8kMhfRVL1P99djJ3ZmNMFVmM
 Kt2Ak4rH51d2532X+oLA0pRozZFeQPqNJDDSH+1swvBNG3jpVVBKflraq13iLXuQ9luiV8z3Or3
 YHcDxZcVkqXyuTs4E5qGd2Ye8AAOW0Kem9Sut9ZxgPmK6+5JA6QAopqrPxs4kutiaCMe/PhwXBR
 cDtVr32/QCriMFwPPDXyT1Z+VD57VVLGGzVMumilHtHAKSoLehMoGznX55oUS9+Hif0y6tJP6/a
 5egfr+pD0u9BKULExXaQ0RmfZVTCCZtyL4izVfby/0yeJKJEPDc8DTqP/PFMOUkCZFLNdtf9OTn
 Sdh6woD/XKwtaGGVBMbGy0aVrWOCh3LTllT4ctON1GKfXRPjjpH1PbpCxJ2VVEB92tC7aJUgySS
 NNJ8a0QoBakfDAU4YGUyCyPyIFczYQVDmzQnmUq77w1Lhw6oMFhOpJ6Lux0a9nhwVPbOCltPfrw
 qCX8Slf755UmKPI0O/hU329LkfrRksW2okeeXNl4DwM6zvWEUVDReqOcEOYpRO7CcBnX2BRS/rd
 AoRdBtAwSlIRe5q51L2T0QuBgB85xsbjOMqOb/MnLn+tvSpSotbEexDpvkkueddkDllAXNw1Wj0
 BhOkgcVhzQu18AQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


