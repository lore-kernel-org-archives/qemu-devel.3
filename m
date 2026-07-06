Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852B9C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjsV-0006Vx-CL; Mon, 06 Jul 2026 10:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjsS-0006Gw-1p
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjsQ-0002Lj-5L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783346449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVWDFsDKYcR/h0WiYYSlXW8s55Ug8vhotJgDDaWSaVA=;
 b=OytacIp19KGaEDnFoY7RN9tPqjsV+lDDHKXMerdmI5unIqX6PSWxyKDoklifNeKHZUvqs8
 f/9uYv58DfPKwq6oysNVjsyKvpFIfBja+6qd+sUjm5H+rkgWjgFlfsKdzC48eGDW5lCDTm
 Zbuz3JEL/kyq9/2xAbRY7s4wvexNJnE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-R7Eb-QfTMwSWEOWv2JCDtg-1; Mon,
 06 Jul 2026 10:00:45 -0400
X-MC-Unique: R7Eb-QfTMwSWEOWv2JCDtg-1
X-Mimecast-MFC-AGG-ID: R7Eb-QfTMwSWEOWv2JCDtg_1783346444
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8C921955F3B; Mon,  6 Jul 2026 14:00:43 +0000 (UTC)
Received: from berrange.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2D133000B4E; Mon,  6 Jul 2026 14:00:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v7 34/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
Date: Mon,  6 Jul 2026 14:58:22 +0100
Message-ID: <20260706135824.2623960-35-berrange@redhat.com>
In-Reply-To: <20260706135824.2623960-1-berrange@redhat.com>
References: <20260706135824.2623960-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
options, updating `-mon` to state that it is legacy syntax sugar
for the new `-object` args.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-options.hx | 61 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e44b47de68..fe76c18c81 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4955,6 +4955,11 @@ SRST
     port). The default device is ``vc`` in graphical mode and ``stdio``
     in non graphical mode. Use ``-monitor none`` to disable the default
     monitor.
+
+    The use of ``-monitor dev`` is syntactic sugar for creating a character
+    device from ``dev`` and pairing it with ``-object monitor-hmp``.
+    Both the character device and monitor object will be given an ID
+    ``compat_monitorNNN`` where ``NNN`` is a counter starting from 0.
 ERST
 DEF("qmp", HAS_ARG, QEMU_OPTION_qmp, \
     "-qmp dev        like -monitor but opens in 'control' mode\n",
@@ -4966,9 +4971,10 @@ SRST
 
         -qmp tcp:localhost:4444,server=on,wait=off
 
-    Not all options are configurable via this syntax; for maximum
-    flexibility use the ``-mon`` option and an accompanying ``-chardev``.
-
+    The use of ``-qmp dev`` is syntactic sugar for creating a character
+    device from ``dev`` and pairing it with ``-object monitor-qmp``.
+    Both the character device and monitor object will be given an ID
+    ``compat_monitorNNN`` where ``NNN`` is a counter starting from 0.
 ERST
 DEF("qmp-pretty", HAS_ARG, QEMU_OPTION_qmp_pretty, \
     "-qmp-pretty dev like -qmp but uses pretty JSON formatting\n",
@@ -4997,6 +5003,16 @@ SRST
       -mon chardev=mon1,mode=control,pretty=on
 
     enables the QMP monitor on localhost port 4444 with pretty-printing.
+
+    The use of ``-mon mode=readline`` is syntactic sugar
+    for the new ``-object monitor-hmp`` option, each use of which
+    creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
+    a counter starting from 0.
+
+    The use of ``-mon mode=control`` is syntactic sugar
+    for the new ``-object monitor-qmp`` option, each use of which
+    creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
+    a counter starting from 0.
 ERST
 
 DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
@@ -5747,6 +5763,45 @@ SRST
     they are specified. Note that the 'id' property must be set. These
     objects are placed in the '/objects' path.
 
+    ``-object monitor-hmp,id=id,chardev=chardev_id,readline=on|off``
+        Set up a monitor running the Human Monitor Protocol,
+        connected to the chardev ``chardev_id``.
+
+        The ``id`` parameter is a unique ID that can be used
+        to dynamically delete the monitor at runtime. Note
+        that monitors created using the historical syntax
+        will be allocated IDs following the pattern ``compat_monmitorNNN``.
+        Mixing ``-object`` with ``-monitor`` and ``-mon`` syntax is
+        discouraged.
+
+        The ``readline`` parameter, which defaults to ``on``,
+        controls whether the monitor provides line editing.
+
+    ``-object monitor-qmp,id=id,chardev=chardev_id,pretty=on|off,close-action=none|delete``
+        Set up a monitor running the QEMU Monitor Protocol,
+        connected to the chardev ``chardev_id``.
+
+        The ``id`` parameter is a unique ID that can be used
+        to dynamically delete the monitor at runtime. Note
+        that monitors created using the historical syntax
+        will be allocated IDs following the pattern ``compat_monitorNNN``.
+        Mixing ``-object`` with ``-qmp``, ``-qmp-pretty`` and
+        ``-mon`` syntax is discouraged.
+
+        The ``pretty`` parameter, which defaults to ``off``,
+        controls whether the monitor responses are pretty
+        printed as multi-line indented JSON, as opposed to
+        constrained to a single line without extraneous
+        whitespace.
+
+        The ``close-action`` parameter, which defaults to ``none``,
+        controls what happens when the connection to the monitor
+        is terminated by the user. If set to ``delete``, then the
+        ``monitor-qmp`` object and its associated character
+        device are both immediately deleted. This can be useful
+        if an extra monitor was hotplugged for a specific task
+        and should be unplugged when completed.
+
     ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
         Creates a memory file backend object, which can be used to back
         the guest RAM with huge pages.
-- 
2.55.0


