Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94947C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03QO-0000QA-SB; Fri, 28 Aug 2026 16:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QM-0000Gz-Tj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QJ-00008I-P3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVPrkPp6gs0IB0j0xiU0o5owVlvgiG2b14b9p5/j2Pk=;
 b=FibohBNcp8/7ZQLFkeqkeGRA5D5trWA+Aupe4Y9QkkR+l6cWnHYhCkokkndivv/Goz3KQM
 +gT+q5XNsRaXUp10Z62FMSf4/NeF9rYdEpb3w1wwBBoxyVpdWYOoh1Hi6zavdm2OTDCnYY
 lHLjzetAjl/U1i3Yzl9Ab9ZeQjF5G/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-GA1zKLuyPXKagwUnWNhTJQ-1; Fri,
 28 Aug 2026 16:43:36 -0400
X-MC-Unique: GA1zKLuyPXKagwUnWNhTJQ-1
X-Mimecast-MFC-AGG-ID: GA1zKLuyPXKagwUnWNhTJQ_1787949815
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 652E319091F8; Fri, 28 Aug 2026 20:43:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AC003001D3D; Fri, 28 Aug 2026 20:43:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:06 +0400
Subject: [GIT PULL 27/50] monitor: reject readline monitor when HMP is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-27-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QNxQQy78jELbT7+yM8nfG44cMuZbkNhjHaeOwKj5cOw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUr5kNQVavc+INsF4m4M4Qua5daawbS+n1U
 m7Qr1MpqVqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5fGPD/9hj7Y6CjCxxPenxdWKF3v67sGA/QC+IsNNy4ljMFfNPFvu0dK4WVqLrwksqqqTnnGmYmT
 hVI/SKF/jv+K9yji39rhYXBV1q1hY3cf0ftDz+fOF9zzdhbPNSteT4lD9m6I5cFCxfKNZgrk/u+
 A9+/o3o6T9RZIe3wHBtCUIKMmp3py5iwVtLvfIKzskur5ZlJXACHv73ZRLFxXRWbnZKmw/jqYin
 TtWTJHtHK2zqWyvpkMapwWR9P6kAmeMtaPij1aqgQDRMBfImuf0ns3MY4mt3awlo8+rgveZFiCg
 LGMeB4ACkBKazwPbV1f/XWq3/HbjkWdX+Gg6wA5LSh2488JcZqLDlSDxiCXwEOeeeMZTQmmy3Gx
 5A+f+GTt8FK/NYBW23AvRL/8vGkJX/B5e+iyB2jrpBmuESrOkEFY95TmcPBgAkExIjuy0V8xve+
 /j7Lb1q9deQ7nvOm/NsvaXwb+m9DTxd3SbWYyPkbImb9D0uotCOJAIeIWtPzRLVrZ1B2xNTiSbB
 5gjjnw44pfQZX4R6Uxtjl0Tp7Rhjp6ouKlVPYT4HThJZKG5FAlSQXrKSiXN0x3ad7Dfw298oWEr
 /oL6lAUqNH3aWizFqae+ArOpeNTzK8vrnIvgjAJCRk2jkhrOH60ZLQ+YCBLPrGwgx0ROwUklSRU
 s61NX/HftVNKV5w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20260828-qemu-no-hmp-v5-27-9227de146347@redhat.com>
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


