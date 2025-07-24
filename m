Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58E3C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 14:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uexDi-0004k0-Bz; Thu, 24 Jul 2025 10:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uexDf-0004iC-Mv
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uexDd-0000vp-1u
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753368408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixVsMPMZyzR/pKXOD06jLvYP0rEnecrsu0z9A4Vrn3s=;
 b=H/MC+jdC3IRKARQHslR4puie0m+czltky26/buRpMRJahi7AYmMjW3oiKeIAyKlgn/ueRn
 cGpSn6zF2XRFHzUrDIpr0v7G177Nd/zRpW6Ni6rfk6+HCjsTVdb/4PS000xpnfUskNo1Uz
 4yHhKHRW2exyNoHJHvUfoUeHEbSxGTY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-_YlW5EupOaGdN55cYNJ7BQ-1; Thu,
 24 Jul 2025 10:46:44 -0400
X-MC-Unique: _YlW5EupOaGdN55cYNJ7BQ-1
X-Mimecast-MFC-AGG-ID: _YlW5EupOaGdN55cYNJ7BQ_1753368403
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E03B21800772; Thu, 24 Jul 2025 14:46:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 066521956089; Thu, 24 Jul 2025 14:46:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 1/1] log: make '-msg timestamp=on' apply to all qemu_log usage
Date: Thu, 24 Jul 2025 10:46:36 -0400
Message-ID: <20250724144636.107828-2-stefanha@redhat.com>
In-Reply-To: <20250724144636.107828-1-stefanha@redhat.com>
References: <20250724144636.107828-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Currently the tracing 'log' back emits special code to add timestamps
to trace points sent via qemu_log(). This current impl is a bad design
for a number of reasons.

 * It changes the QEMU headers, such that 'error-report.h' content
   is visible to all files using tracing, but only when the 'log'
   backend is enabled. This has led to build failure bugs as devs
   rarely test without the (default) 'log' backend enabled, and
   CI can't cover every scenario for every trace backend.

 * It bloats the trace points definitions which are inlined into
   every probe location due to repeated inlining of timestamp
   formatting code, adding MBs of overhead to QEMU.

 * The tracing subsystem should not be treated any differently
   from other users of qemu_log. They all would benefit from
   having timestamps present.

 * The timestamp emitted with the tracepoints is in a needlessly
   different format to that used by error_report() in response
   to '-msg timestamp=on'.

This fixes all these issues simply by moving timestamp formatting
into qemu_log, using the same approach as for error_report.

The code before:

  static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
  {
      if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
          if (message_with_timestamp) {
              struct timeval _now;
              gettimeofday(&_now, NULL);
              qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n",
                       qemu_get_thread_id(),
                       (size_t)_now.tv_sec, (size_t)_now.tv_usec
                       , creds, filename, path);
          } else {
              qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
          }
      }
  }

and after:

  static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
  {
      if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
          qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
      }
  }

The log and error messages before:

  $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
  2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55d925bd9490 dir=/var/home/berrange/tls
  2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path creds=0x55d925bd9490 filename=ca-cert.pem path=<none>
  2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory

and after:

  $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
  2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55bf5bf12380 dir=/var/home/berrange/tls
  2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path creds=0x55bf5bf12380 filename=ca-cert.pem path=<none>
  2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory

The binary size before:

  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
  $ strip qemu-system-x86_64
  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64

and after:

  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
  $ strip qemu-system-x86_64
  $ ls -alh qemu-system-x86_64
  -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-id: 20250721185452.3016488-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/log.c                       | 20 +++++++++++++++++++-
 scripts/tracetool/backend/log.py | 14 +-------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/util/log.c b/util/log.c
index 58d24de48a..abdcb6b311 100644
--- a/util/log.c
+++ b/util/log.c
@@ -145,10 +145,28 @@ void qemu_log_unlock(FILE *logfile)
 
 void qemu_log(const char *fmt, ...)
 {
-    FILE *f = qemu_log_trylock();
+    FILE *f;
+    g_autofree const char *timestr = NULL;
+
+    /*
+     * Prepare the timestamp *outside* the logging
+     * lock so it better reflects when the message
+     * was emitted if we are delayed acquiring the
+     * mutex
+     */
+    if (message_with_timestamp) {
+        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
+        timestr = g_date_time_format_iso8601(dt);
+    }
+
+    f = qemu_log_trylock();
     if (f) {
         va_list ap;
 
+        if (timestr) {
+            fprintf(f, "%s ", timestr);
+        }
+
         va_start(ap, fmt);
         vfprintf(f, fmt, ap);
         va_end(ap);
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 5c9d09dd11..eb50ceea34 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -20,7 +20,6 @@
 
 def generate_h_begin(events, group):
     out('#include "qemu/log-for-trace.h"',
-        '#include "qemu/error-report.h"',
         '')
 
 
@@ -32,20 +31,9 @@ def generate_h(event, group):
     cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
-        '        if (message_with_timestamp) {',
-        '            struct timeval _now;',
-        '            gettimeofday(&_now, NULL);',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
-        '                     qemu_get_thread_id(),',
-        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
-        '                     %(argnames)s);',
+        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        } else {',
-        '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
-        '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        }',
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-- 
2.50.1


