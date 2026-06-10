Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EBDCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIA8-0002FP-RZ; Wed, 10 Jun 2026 08:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIA6-00024o-Do
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIA4-0003jK-Bt
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMIxMWlmbrmcCAkb3nAuFYSG9OyohMzp6/A3KmkV0lw=;
 b=f05BAqgPnuAa3lLh1I/ykrpZWEBzCaqKPQPZS1se3OeQsoe3oD/lzW1qssXN5RgdfUER8H
 XtNsRz8DpVrIqLiI/2gSPB2s/78bCcCvMZyXS10eCixPXPpNg1+MDlI45sqKyW1TPTSADf
 seLDbU2oj64jMo2XmUYQVLQqEziP92U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-vQFRtqSMNMe8eFa2T4GZSw-1; Wed,
 10 Jun 2026 08:35:55 -0400
X-MC-Unique: vQFRtqSMNMe8eFa2T4GZSw-1
X-Mimecast-MFC-AGG-ID: vQFRtqSMNMe8eFa2T4GZSw_1781094954
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 071A6180A8C7; Wed, 10 Jun 2026 12:35:54 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F65631D2; Wed, 10 Jun 2026 12:35:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 23/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
Date: Wed, 10 Jun 2026 13:34:03 +0100
Message-ID: <20260610123415.2883603-24-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
options, updating `-mon` to state that it is legacy syntax sugar
for the new `-object` args.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-options.hx | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..031417b79d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4959,6 +4959,16 @@ SRST
       -mon chardev=mon1,mode=control,pretty=on
 
     enables the QMP monitor on localhost port 4444 with pretty-printing.
+
+    The use of ``-mon mode=readline`` is historical syntax sugar
+    for the new ``-object monitor-hmp`` option, each use of which
+    creates an object with the ID ``hmpcompatNNN`` where ``NNN`` is
+    a counter starting from 0.
+
+    The use of ``-mon mode=control`` is historical syntax sugar
+    for the new ``-object monitor-qmp`` option, each use of which
+    creates an object with the ID ``qmpcompatNNN`` where ``NNN`` is
+    a counter starting from 0.
 ERST
 
 DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
@@ -5709,6 +5719,34 @@ SRST
     they are specified. Note that the 'id' property must be set. These
     objects are placed in the '/objects' path.
 
+    ``-object monitor-hmp,id=id,chardev=chardv_id,readline=on|off``
+        Set up a monitor running the Human Monitor Protocol,
+        connected to the chardev ``chrid``.
+
+        The ``id`` parameter is a unique ID that can be used
+        to dynamically delete the monitor at runtime.
+
+        The ``readline`` parameter, which defaults to ``on``,
+        controls whether the monitor provides interactive
+        prompts
+
+    ``-object monitor-qmp,id=id,chardev=chardev_id,pretty=on|off``
+        Set up a monitor running the QEMU Monitor Protocol,
+        connected to the chardev ``chrid``.
+
+        The ``id`` parameter is a unique ID that can be used
+        to dynamically delete the monitor at runtime. Note
+        that monitors created using the historical syntax
+        will be allocated IDs following the pattern ``monNN``.
+        Mixing ``-object`` with the historical monitor syntax is
+        discouraged.
+
+        The ``pretty`` parameter, which defaults to ``off``,
+        controls whether the monitor responses are pretty
+        printed as multi-line indented JSON, as opposed to
+        constrained to a single line without extraneous
+        whitespace.
+
     ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
         Creates a memory file backend object, which can be used to back
         the guest RAM with huge pages.
-- 
2.54.0


