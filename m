Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACCCCDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWU-0006B6-Qy; Thu, 25 Jun 2026 17:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWT-000620-5r
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWR-0003ut-9Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8MqeA40QOR+nIk2+32wAxE8AqwLWXQRv12gEo1E+W8=;
 b=ZeN4DMV+5+jgA/67PopCrGKCPYPThUKp3f177islpG4/X0ejBlUgrBl8ZZLbdd/ldtBTrl
 mtoluxuO+SCpNLamT2xHCY5XotT5Vfo8POO7gZvhGzmUoyBDQAb04peMzgQCDYk/5S0tqx
 rQDnbe7KFy5lnXbuKe1gKXSISRIUVu0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-UIe2FwMCP_GRLPLQ8LnJZw-1; Thu,
 25 Jun 2026 17:22:05 -0400
X-MC-Unique: UIe2FwMCP_GRLPLQ8LnJZw-1
X-Mimecast-MFC-AGG-ID: UIe2FwMCP_GRLPLQ8LnJZw_1782422524
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73F7A1835E2B; Thu, 25 Jun 2026 21:22:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E1731800661; Thu, 25 Jun 2026 21:22:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:29 +0400
Subject: [PATCH v2 28/39] build-sys: add 'hmp' option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-28-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uCNypvAhoJYTu2L3kXSPIUPn8bgO6jkCWdgE1SDj+5g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdl4aoNK8PvcrV+xc7RC2ONZvdKuuO9cfIx
 JL+atUvniaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5fRBD/0ZtDOjSO+r8zi8Fb2c1JDNYrfs4G6ylfaQH/G+JstmpT5LUksjN7e8XXlX6MMwwqaiOoR
 YSQszUytME0Mi9VfJSoQbPGxFVDvW4Ff18EAjo/FchKJWzD3gQEzkXXUBR7eu10vF7mIuPw5fVr
 Ade/JauuZ0HbfkgsHVgN8CUd+3Npef3CvRBtTISUj4ZpzCftBfSTI5nj1h5ErpYYudMpttQfuE9
 VlitRQmwUxSsZ6Hyaw3LR1N9t0KjRRdS2FRmYL9nZnvE9PiPXJhfQHIxe1AlY+aDZUSFqa4sJ8V
 iZ6nQvObqKfz6DCB6diLeetaRD/aydaW0y0k5v+2S4O+7o7d+vVseQWmsTpHHEyc9vDLOsqVupQ
 h5VWVdvodQrk1C0Du0gkx7v7frYYW3uOZstofjHoqJP7Dcg0yV4XWv2VDb2KfVawo8J9t0wy+oi
 +Hvz0+rtCwX/tmg9ZcfoBApmPkGUe4eFF/C45jqVcoJGSVwj9dyZ4BLXoAqdtGE17X+8Y50dSfq
 a48KLGyXJqficvsH8I7kghLjgr9fcYymOTuy9BN622PSdVC2mbM88Li0joO7RHFWVavUbeJIz9B
 5yOgZZU6sjnymhhWDnX3hgXu2LQl4qvj1Px5T9GviTsJepe9V4dmq+inqtEF+lTmfOXRZtLYzOs
 MySALw/9FKoiNrg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Add an option to enable/disable HMP support, default to true. The
following commits are going to make --disable-hmp gradually working.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build                   | 4 ++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/meson.build b/meson.build
index e026851309e..824ba695801 100644
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
@@ -2254,6 +2257,7 @@ endif
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


