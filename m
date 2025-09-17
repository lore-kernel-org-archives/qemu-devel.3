Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCACACAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqiv-0004gl-39; Wed, 17 Sep 2025 07:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqhy-000359-PO
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyqhv-0003kA-Nt
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758109935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3HMLCacnb+v7Wzq9HTZD6Gukh/9NburV3fnXhNL514=;
 b=Tj/zfSMb2KX69y+FrSJ7ezI6wo6eehcDu4/3Oi9rxYaWOy0mRo0UrqNvO1vrSq+IsHwFPj
 DX+hSfub0I2RHJIq2t3epzlRh/hpQtC5ljEdL1zR81myKsojuX//w+do5ZHelA8cGVfuSK
 KysZ9TLtjuscXwRu6cuK5t8Uw+Q+how=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-DQxYahe1O1awA9yEU4tlXw-1; Wed,
 17 Sep 2025 07:52:11 -0400
X-MC-Unique: DQxYahe1O1awA9yEU4tlXw-1
X-Mimecast-MFC-AGG-ID: DQxYahe1O1awA9yEU4tlXw_1758109931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB706180057D; Wed, 17 Sep 2025 11:52:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 013181800447; Wed, 17 Sep 2025 11:52:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3774E21E6924; Wed, 17 Sep 2025 13:52:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 01/12] monitor: Clean up HMP gdbserver error reporting
Date: Wed, 17 Sep 2025 13:51:56 +0200
Message-ID: <20250917115207.1730186-2-armbru@redhat.com>
In-Reply-To: <20250917115207.1730186-1-armbru@redhat.com>
References: <20250917115207.1730186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

HMP command gdbserver used to emit two error messages for certain
errors.  For instance, with -M none:

    (qemu) gdbserver
    gdbstub: meaningless to attach gdb to a machine without any CPU.
    Could not open gdbserver on device 'tcp::1234'

The first message is the specific error, and the second one a generic
additional message that feels superfluous to me.

Commit c0e6b8b798b (system: propagate Error to gdbserver_start (and
other device setups)) turned the first message into a warning:

    warning: gdbstub: meaningless to attach gdb to a machine without any CPU.
    Could not open gdbserver on device 'tcp::1234'

This is arguably worse.

hmp_gdbserver() passes &error_warn to gdbserver_start(), so that
failure gets reported as warning, and then additionally emits the
generic error on failure.  This is a misuse of &error_warn.

Instead, receive the error in &err and report it, as usual.  With
this, gdbserver reports just the error:

    gdbstub: meaningless to attach gdb to a machine without any CPU.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/exec/gdbstub.h | 3 ---
 monitor/hmp-cmds.c     | 7 ++++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index a16c0051ce..bd7182c4d3 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -55,9 +55,6 @@ void gdb_unregister_coprocessor_all(CPUState *cpu);
  * system emulation you can use a full chardev spec for your gdbserver
  * port.
  *
- * The error handle should be either &error_fatal (for start-up) or
- * &error_warn (for QMP/HMP initiated sessions).
- *
  * Returns true when server successfully started.
  */
 bool gdbserver_start(const char *port_or_device, Error **errp);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 74a0f56566..33a88ce205 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -280,14 +280,15 @@ void hmp_log(Monitor *mon, const QDict *qdict)
 
 void hmp_gdbserver(Monitor *mon, const QDict *qdict)
 {
+    Error *err = NULL;
     const char *device = qdict_get_try_str(qdict, "device");
+
     if (!device) {
         device = "tcp::" DEFAULT_GDBSTUB_PORT;
     }
 
-    if (!gdbserver_start(device, &error_warn)) {
-        monitor_printf(mon, "Could not open gdbserver on device '%s'\n",
-                       device);
+    if (!gdbserver_start(device, &err)) {
+        error_report_err(err);
     } else if (strcmp(device, "none") == 0) {
         monitor_printf(mon, "Disabled gdbserver\n");
     } else {
-- 
2.49.0


