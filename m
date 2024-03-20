Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53789C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxvb-0001SK-8W; Wed, 20 Mar 2024 11:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmxva-0001S6-55
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmxvY-0003e1-1y
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710948746;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4aHTbnsTXpFywzF/tmtSSrxo3opIBRvTXAbJr/WhGw=;
 b=PDWRtyufuDgnU/oG6BcxQ8VkIU2JIsgpaA6TQ+rXoE2z3Gg/AfIAkD43QYmEklQ4vZy5vW
 e6LXpepZBncMYGzyvVi5qrJkmd2PzvrNtxA+MmIojodVE6IPSntwZejTZ04QOyrPe7pLu8
 pznifjTwoJaNAB7LBtftW0fvoLOEWRA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-wy8cMQBwNnuM_xZk0wZPyQ-1; Wed,
 20 Mar 2024 11:32:22 -0400
X-MC-Unique: wy8cMQBwNnuM_xZk0wZPyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 280F52800084;
 Wed, 20 Mar 2024 15:32:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F2CC017A0;
 Wed, 20 Mar 2024 15:32:20 +0000 (UTC)
Date: Wed, 20 Mar 2024 15:32:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, xiaoyao.li@intel.com, alex.bennee@linaro.org,
 philmd@linaro.org
Subject: Re: [PATCH v2] target/i386: Revert monitor_puts() in
 do_inject_x86_mce()
Message-ID: <ZfsBftCB-wFhoAdm@redhat.com>
References: <20240320083640.523287-1-tao1.su@linux.intel.com>
 <Zfreb8-swnvSOMhx@redhat.com>
 <CAFEAcA8t8C8QCeQS-fxvRKNST80g+84Ggh4B_cZAc6vzHL-wmA@mail.gmail.com>
 <87y1adm0os.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1adm0os.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 20, 2024 at 03:34:43PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Wed, 20 Mar 2024 at 13:03, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>
> >> On Wed, Mar 20, 2024 at 04:36:40PM +0800, Tao Su wrote:
> >> > monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
> >> > may have a parameter with NULL monitor pointer. Revert monitor_puts() in
> >> > do_inject_x86_mce() to fix, then the fact that we send the same message to
> >> > monitor and log is again more obvious.
> >>
> >> Yikes, why do we have such a horrible trap-door in our
> >> monitor output APIs.
> >>
> >> Isn't the right fix here to make 'monitor_puts' check for
> >> NULL & be a no-op, in the same way 'monitor_printf' does,
> >> so the APIs have consistent behaviour.
> >
> > The other difference between monitor_puts(mon, s) and
> > monitor_printf(mon, "%s", s)
> > is that the latter will return an error if the monitor is QMP, whereas
> > the former will go ahead and print the message anyway. That one is
> > awkward to resolve, because the mechanism the QMP monitor uses to
> > print the JSON in qmp_send_response() is to call monitor_puts()...
> 
> We need a low-level function to send to a monitor, be it HMP or QMP:
> monitor_puts().
> 
> We need a high-level function to format JSON and send it to QMP:
> qmp_send_response().
> 
> We need a high-level functions to format text and send it to HMP:
> monitor_printf(), ...
> 
> Trouble is the first and the last one are deceptively named.  The names
> suggest monitor_printf() is to monitor_puts() what printf() is to
> puts().  Not true.
> 
> Naming the functions that expect an HMP monitor hmp_FOO() would make
> more sense.  Renaming them now would be quite some churn, though.

How about a simpler alternative.

 * Rename monitor_puts to monitor_puts_internal and it is
   in monitor-internal.h

 * Change low level users (whcih are all inside monitor/)
   to use monitor_puts_internal

 * Introduce a new monitors_puts, which is to monitor_printf
   what puts() is to printf()

Most (all?) usage outside monitor/ appears to be HMP only.

eg this patch:

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 965f5d5450..8e5d0cc71c 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -40,7 +40,6 @@ void monitor_flush(Monitor *mon);
 int monitor_set_cpu(Monitor *mon, int cpu_index);
 int monitor_get_cpu_index(Monitor *mon);
 
-int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
 
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 252de85681..972e7f96d9 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -188,4 +188,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
+int monitor_puts_internal(Monitor *mon, const char *str);
+int monitor_puts_locked(Monitor *mon, const char *str);
+
 #endif
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 01ede1babd..c0ec5bc03e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -206,12 +206,25 @@ int monitor_puts_locked(Monitor *mon, const char *str)
     return i;
 }
 
-int monitor_puts(Monitor *mon, const char *str)
+int monitor_puts_internal(Monitor *mon, const char *str)
 {
     QEMU_LOCK_GUARD(&mon->mon_lock);
     return monitor_puts_locked(mon, str);
 }
 
+int monitor_puts(Monitor *mon, const char *str)
+{
+    if (!mon) {
+        return -1;
+    }
+
+    if (monitor_is_qmp(mon)) {
+        return -1;
+    }
+
+    return monitor_puts_internal(mon, str);
+}
+
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     char *buf;
@@ -226,7 +239,7 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     }
 
     buf = g_strdup_vprintf(fmt, ap);
-    n = monitor_puts(mon, buf);
+    n = monitor_puts_internal(mon, buf);
     g_free(buf);
     return n;
 }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index a239945e8d..4d848ee91c 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -139,7 +139,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
     trace_monitor_qmp_respond(mon, json->str);
 
     g_string_append_c(json, '\n');
-    monitor_puts(&mon->common, json->str);
+    monitor_puts_internal(&mon->common, json->str);
 
     g_string_free(json, true);
 }


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


