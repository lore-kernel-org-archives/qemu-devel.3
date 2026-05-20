Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF3CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorK-00086Z-S1; Wed, 20 May 2026 17:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqe-0007Vy-W5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqb-0004xQ-C3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9vkZcvw2HkP52fCwSequJ6rNHWVcsqOc79tJBc0sZ4=;
 b=CuDtGvup5kHO3NNUbUAb60En/UYumxZb6JT2YJdy5NZ4xwEzLge46BLZTECLaAJLlnLCzU
 cENZAs0Zyds6wzPHoHxANqFA83HvHCr3kLLj7sfFzJphfGdywjnuc1OJgt8ewe69TJ25PG
 fw32466S5a6A8XI5TE2Hk/42VN6A3aU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-XxJ9vu7eMau2X4wxhyJmhw-1; Wed,
 20 May 2026 17:52:59 -0400
X-MC-Unique: XxJ9vu7eMau2X4wxhyJmhw-1
X-Mimecast-MFC-AGG-ID: XxJ9vu7eMau2X4wxhyJmhw_1779313978
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FA8D195608F
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:58 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AFA730001A2; Wed, 20 May 2026 21:52:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:30 +0400
Subject: [PATCH 29/40] build-sys: add 'hmp' option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-29-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SSpy2B0WqY0f8zQ5IsoJK0vva9F2lFMbocFOR8o9an8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyEs3btwJSX+8j0SguH/8shOlv7b3saJL6PF
 xcEs2YSzc6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5RHDD/9Cm/fREOzvfeDgz7xtR/MGXE+OznqhfFZhk79LwpF6GGuHJpltLFCK+i35TMieJWKrg/D
 bmnyX3MCLAyoQNH8k3JqjNRdVYbRx7nrcLdwS6ZHMwUfQfKTevbHI8uKr099CxnHfaZwlWKTYGe
 VXCCIvD5sr0kWx+O9DBpWxTLVlZ0PDQ4/Aqa1ta4oNC+7t0RVTvsFSkXLMwe9Nk5zWpy5pcRTYX
 bYgWd24SL+zR3ZPN215SSicU9fN/8diKATMxBauF5bDehd8M2AFhJM7d9RTNLS1DJS7uUlf+1/j
 v5FCUnJsWKH/vi0sZ3sgAltzSwGviewlYrfMWbZLFEZnHL4lZ2V24NKaClq9yLDuXkHZfhpkP1A
 6wQGXnixN/WKI+CYfffusx7hsU85CFnVZGioJN9BYHAq4o818sizJqdZySWhBXN5XS/GItBkiOp
 PxxjrryX0OjLziE9UvRXVBkiE+6xTPw5/K42g/QGSUq8SmQub/oM+Nxk4tVdXhVZIWA7y0Dcb7x
 8TvefyCxoKI0L+5j+3vicghYvZ4MVK1/TDcp7AWxqpE1O/SKNU+Zf8mZ7Q0QgCRZiD60j58kzGB
 F4rqPsAuA7jSBJK9Jc5yPzbGdPj1/IHKH73Y5Cyp40hTKh/HCgt2+y/FWJS3a13oVEzrst2pE/q
 2phCLDx2zG/v5Fg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an option to enable/disable HMP support, default to true. The
following commits are going to make --disable-hmp gradually working.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build                   | 4 ++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index 70613bf4afc..e83cfe56cf3 100644
--- a/meson.build
+++ b/meson.build
@@ -247,6 +247,9 @@ have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_
 
 have_tcg = get_option('tcg').allowed() and (have_system or have_user)
 
+have_hmp = get_option('hmp') \
+  .disable_auto_if(not have_system) \
+  .allowed()
 have_tools = get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
@@ -2256,6 +2259,7 @@ endif
 config_host_data = configuration_data()
 
 config_host_data.set('CONFIG_HAVE_RUST', have_rust)
+config_host_data.set('CONFIG_HMP', have_hmp)
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35e..d8f59cf92ca 100644
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
index c003985047c..5a67e59a167 100644
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
2.54.0


