Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6BDC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Rq-0007P8-Fo; Fri, 28 Aug 2026 16:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Ro-0007AL-C0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Rm-00015L-HL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WY0qEHeU+RwcHPu8EYIRmNIY8U0l8cuHWeqoDJQ2dEs=;
 b=D+xfolY3jKaTTSmbhEdDbuqfcJhQP+ZDuZ1ICyllWtWKEkMtZucKL7a9IPbSqUCYtBI5MW
 vbP9X/G802CTBFp/n05Z90huXgFEojKK3kZsG5wmE2eBxwISEIG8WpegECtUMTDH55ZkAL
 sbLBCB/ja9qZ/g4I3DNz6uIgAiand/s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-P8GtXmLfPEu9wHzJeRO7TQ-1; Fri,
 28 Aug 2026 16:45:07 -0400
X-MC-Unique: P8GtXmLfPEu9wHzJeRO7TQ-1
X-Mimecast-MFC-AGG-ID: P8GtXmLfPEu9wHzJeRO7TQ_1787949906
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3F618A3C0D; Fri, 28 Aug 2026 20:45:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AF3C1955F43; Fri, 28 Aug 2026 20:45:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:28 +0400
Subject: [GIT PULL 49/50] build-sys: add 'hmp' option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-49-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Z1R9b7P7xYeGUV3lMBKVImoUuEK4as61pIMmcRCfubY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKVlfuNva6oBIOnVzn/gvKS4YXF16j4n6F9r
 3WXHPdjnviJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5Y97D/0fr4Zp1t7bOU8yAnvleEPEXpBz/jJrQY7Fb+Ibfci0ja24DC5ozO5plJkVQLAMccGJy8q
 h6ZZGOxqOcpuV7dh3rOkfSZzlJ9KibWsE4a4lTPWgmlAnT1t89LVZpwJMx3T7CYQ9tPF/HZ5rlQ
 16WfE7sSAjX13WBOGOBF509zT7z3MVOnKTafSNKDoFbJIipfNtRIwuLAXA1/UlDJ/4ywaAgw3vI
 /ITZLH6UeEBxktjjuOmYoeiwQdii1fJhpphJYCtCMZeiPYfb71KqRRW/G02w4KwiBlqRyZ0Pf+N
 o0NrnZH7ZQOoaXmp/Jn5vnoQ7vENJxooIdvADDxzi1FcJGSJHbAHJVsd8NOzLvYmdhqtAYTjaxn
 2Kunut4OAxsIvVIsW551b1/IT7zE8N6hz3TLdSNbRVY/TN7gpz6kWRgf561sPO1xr1ygsl+I/Ai
 FxeoYX32+DmHt+rtd0QXp2QbJ+iuzW+8sDS7fZ1p5+pYM/JwnKApqkJLMwdaijl3rExrF7PBvfv
 l7AM6WRqh7Ll4NomR9JDBo89QoXJ52Fa3OukQdzZ891bQTxGLCAvvr5VmhvwODmxaJSir5XOP/c
 WiWvKfNEv1ejVM/tZyUdoXqqD3o5uscQPdoymvAdBzdnLStGUAsINM7h6jFCJWvqyRl6cvq8yEK
 Vtp67+KPtjNCYkg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Add an option to enable/disable HMP support, default to true. The
following commits are going to make --disable-hmp gradually work.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-49-9227de146347@redhat.com>
---
 meson.build                   | 4 +++-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b10af358f947..5c9de307b081 100644
--- a/meson.build
+++ b/meson.build
@@ -243,7 +243,9 @@ have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_
 
 have_tcg = get_option('tcg').allowed() and (have_system or have_user)
 
-have_hmp = true
+have_hmp = get_option('hmp') \
+  .disable_auto_if(not have_system) \
+  .allowed()
 have_tools = get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35e9..d8f59cf92cae 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -111,6 +111,8 @@ option('cfi', type: 'boolean', value: false,
        description: 'Control-Flow Integrity (CFI)')
 option('cfi_debug', type: 'boolean', value: false,
        description: 'Verbose errors in case of CFI violation')
+option('hmp', type : 'feature', value : 'auto',
+       description: 'HMP monitor support')
 option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
 option('relocatable', type : 'boolean', value : true,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047c0..5a67e59a1671 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -125,6 +125,7 @@ meson_options_help() {
   printf "%s\n" '  gtk             GTK+ user interface'
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
+  printf "%s\n" '  hmp             HMP monitor support'
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
@@ -339,6 +340,8 @@ _meson_option_parse() {
     --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=disabled ;;
     --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
     --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
+    --enable-hmp) printf "%s" -Dhmp=enabled ;;
+    --disable-hmp) printf "%s" -Dhmp=disabled ;;
     --enable-hv-balloon) printf "%s" -Dhv_balloon=enabled ;;
     --disable-hv-balloon) printf "%s" -Dhv_balloon=disabled ;;
     --enable-hvf) printf "%s" -Dhvf=enabled ;;

-- 
2.55.0.543.g5ebe2ebe4ea8


