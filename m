Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375FDCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrXS-0008IV-Lj; Thu, 25 Jun 2026 17:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrXR-0008D0-0M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrXP-00048k-DF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t80BfEWkfSGFH37H9VOynd9pfUSEwTWajT3v7BkCWk8=;
 b=fMsOS2e/b7pKp+7eJU5Q6dA4Eui27BFYTHVlCamH5Sf07vqa02CVql8+XfmHWPAUv+hCdh
 maukEbp1s8c8jq/jRsCGJosJKLKHPrB5D8KSsB1YHU7hWD3Z/g37nYJag8zGX86KnIeIo+
 p8wRGDhRd5lSHk2nDS04UkGXKyMDqFk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-7Fej8yNOOjm3Voa4CyR4oQ-1; Thu,
 25 Jun 2026 17:23:03 -0400
X-MC-Unique: 7Fej8yNOOjm3Voa4CyR4oQ-1
X-Mimecast-MFC-AGG-ID: 7Fej8yNOOjm3Voa4CyR4oQ_1782422582
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7504F1873C12; Thu, 25 Jun 2026 21:23:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CF82195608D; Thu, 25 Jun 2026 21:23:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:40 +0400
Subject: [PATCH v2 39/39] monitor: guard HMP monitor API with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-qemu-no-hmp-v2-39-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BaSExTs++36GT2j1R0szz6+T1BCUasqyW+Wnzi0jGlI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtep+bmJC85TeMfyIvXA1oVaUC2gKnkqcuYk
 uQ1SlC14M+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXgAKCRDa6OEJdZac
 5WNpEACRTk7iwPlFLTY4fVGDHfe4twkM0TTME7eQT/cjo0hnhzAdCSvEHrYOHSAhQgc6GafreRS
 kL5eUhD4fk9Ui8Is6fst/4tBzwmhNSGKqIp4lYtKIqSN7E+XV1iApldp9ym4UUuoEESS7O84Aa2
 POUbdUla944ZWJlPWqDE8JUl+7NA5WsCQAP4LeZQW80T2ReHXHtcC2aXj0RRjNQUpOguKxAq8Lc
 TghnaSNqrFxB2hZE9u1kJAUqlDsyRvd0KEXAWp8Aj7drNlMZ+drqZT1bjGC3GpwCqmt+Y/KqZ33
 uo7MlKUGLnTZdn7LEGMHpDcustY1A3DPeebC9vTUJqRuLl1QQG1xLEbw2GAbirbqC0HOPHsAqiY
 ekohYupbgcwF7hVopeY+bDpANyaTTHc7XwIMx1ybIDTbKqlFYtJ1tccm5+gOOIqVVyLvimttXit
 RyVPb3+02MOzn0lsAwc2wrBdhGJ1hfMVXY3UoyBgjdggPilGnzWG9EFfWKaV/R8hidKNS0RZJiy
 Am7zWcopp/16hcmofRpD+2d5rTg9ux1KdR1xm9v6jkqBtFAhYVDN+iCapDoaS6NQADooUGa2GrA
 ZiLw5Yh/5097W0BHDERbvcTZnGJKZerQ1gfYLlhZPYirhtpM+lm4hwT+vpqhQbGGXJ+FMfgujJu
 1f4k+OBJB8ywpqw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that all callers of HMP-specific monitor APIs have been guarded
by prior patches, wrap the public declarations and their definitions
with CONFIG_HMP:

- monitor.h: guard monitor_vprintf/printf/printc,
  monitor_init_hmp, monitor_read_command/password, and
  monitor_register_hmp*
- monitor.c: guard monitor_vprintf/printf/printc definitions
- stubs/monitor-core.c: guard monitor_vprintf stub
- stubs/monitor-internal.c: guard monitor_init_hmp stub

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h | 11 +++++++++++
 monitor/monitor.c         |  2 ++
 stubs/monitor-core.c      |  2 ++
 stubs/monitor-internal.c  |  2 ++
 4 files changed, 17 insertions(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 17182e626a7..3457f4a7f88 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -20,7 +20,9 @@ bool monitor_cur_is_qmp(void);
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
+#ifdef CONFIG_HMP
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
+#endif
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_init_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
@@ -32,28 +34,37 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 
 int monitor_puts(Monitor *mon, const char *str);
+
+#ifdef CONFIG_HMP
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
 int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 void monitor_printc(Monitor *mon, int ch);
+#endif
+
 void monitor_flush(Monitor *mon);
 int monitor_get_cpu_index(Monitor *mon);
 
 int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
 
+
+#ifdef CONFIG_HMP
 void monitor_read_command(MonitorHMP *mon, int show_prompt);
 int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
                           void *opaque);
+#endif
 
 AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
                                 const char *opaque, Error **errp);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 
+#ifdef CONFIG_HMP
 void monitor_register_hmp(const char *name, bool info,
                           void (*cmd)(Monitor *mon, const QDict *qdict));
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp));
+#endif
 
 #endif /* MONITOR_H */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c8207af57ec..8ea1bafd99e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -218,6 +218,7 @@ int monitor_puts(Monitor *mon, const char *str)
     return monitor_puts_locked(mon, str);
 }
 
+#ifdef CONFIG_HMP
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     char *buf;
@@ -274,6 +275,7 @@ void monitor_printc(Monitor *mon, int c)
     }
     monitor_printf(mon, "'");
 }
+#endif
 
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 078a5012e9b..b4a4de41aa2 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -21,6 +21,7 @@ void qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
 }
 
+#ifdef CONFIG_HMP
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     /*
@@ -37,3 +38,4 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     }
     return -1;
 }
+#endif
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 4fece49d531..29274bd2b4a 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -8,6 +8,8 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
+#ifdef CONFIG_HMP
 void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
 }
+#endif

-- 
2.54.0


