Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4105C61DDA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvOi-0000Gg-DE; Fri, 28 Aug 2026 08:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvOL-0007Zi-Uq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvOJ-00043n-Dj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSmGlFfDgm+HyFoKIfpAObVWasfTYjRZnIs3K/RyDls=;
 b=M+Gd4EDF2IB1SAmr94hg8s83n+ds5/hw7fyAR/T5XLgid4uP3ztzol8QxjBTmAFSvGXkKO
 E9PKxIqzL07gOKj1eEtW55Iu2tYKX2uk6vW9HUlVicnPgna1mgGPi29MZeXG+QBdao5YZ2
 j4p8o8jxf4Ix98H36C3WMfkNEcs+smo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-yPnAHtTJP_S-Lwm82GCYnQ-1; Fri,
 28 Aug 2026 08:08:52 -0400
X-MC-Unique: yPnAHtTJP_S-Lwm82GCYnQ-1
X-Mimecast-MFC-AGG-ID: yPnAHtTJP_S-Lwm82GCYnQ_1787918931
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81FB618009EA; Fri, 28 Aug 2026 12:08:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B32BA1955F05; Fri, 28 Aug 2026 12:08:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:46 +0400
Subject: [PATCH v5 49/50] build-sys: add 'hmp' option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-49-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DLK1RtIEVsfGHkCcmDDSawvnMR7eyKfceqbddAXsWwE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk6C/4SAUGevJbmiUbJrENYPWe1Xb44Aobni
 n1pRpKXP2eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OgAKCRDa6OEJdZac
 5cEoEACrKEaEC6JniHq+7iQAVJzKR06tGWne2wK5JMj6huSBZEfOuAD/OAWHBdNkU83qbThRkLf
 ZSVekDGQjGvoGMpSBgPAC5P7TLXEBfqonjw8qbKCkMG8/PxXaytz0VWQ7O9zaa1nl0uMULmYTho
 +vItrmI89v4kz4N/7KcI8qNghpS/YSGvtAY2csyt8x5p9wSajIcwRZlzB3ZWr/c4i9hXRrCxB7U
 WduVuug5OH9WUX5LBkVV9zsx7sYSB0EZts3gcd64ny0OfoBKXynntYYjuDfIev/WqxLKVdsqBYq
 AtO8cGjcj9YJr0hJjHwIW+YffTpFKSk7jFZbwb/iGZqUSrTdJ0n/TJ+6AHcKCZx6dCxzaYTq3V7
 0U+87PhCMn7UPJkAhfqBAhNUZoaqaFMH/Ny06rYUIGS3GXzuMPvSJnmec0W75YjaLKbs9XLueEu
 wQ5z5CAQx7SZUZeuiaLMf6mkI3xyfabZ0UdsDeXd1FDrmclNCoPMY0+QPmhvFSpzUvhLFfF0ljt
 4N8xf3VuXzMkMmozNQu/2fXPM3jEtoAT6ahtCNmn7ditayhjD10J+fc0O+UeXQZFU9f6Av3p2VN
 p6kSyNrzcF16L3uMUXO0PXWLwkHCg2apfiImtlbA3pqbs+UbTn1IE5323/V7KlfrvOHbVsRae0c
 SUACyCrCD2oqS3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


