Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA11C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywaL-0004i8-Ui; Tue, 25 Aug 2026 15:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywaG-0004JW-Un
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywaE-0004al-Oa
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSmGlFfDgm+HyFoKIfpAObVWasfTYjRZnIs3K/RyDls=;
 b=LOUT+bHmvVD5/mj0uhfDWMlQKJhoSiuzq05fm7/gAOtm1NkTdhHIFZxjba0yU95CjbO8XB
 mO/JTZ8vsaNO2uvqFOnQPF71aztiU4vu4aHezMVVOORzizQbG4KW63m6nCBO21Xok/FLuC
 +BZwerqI27rybynn6vmEC45pcmENNj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-xS49o_OVN4OkVx3jBmOvrA-1; Tue,
 25 Aug 2026 15:13:14 -0400
X-MC-Unique: xS49o_OVN4OkVx3jBmOvrA-1
X-Mimecast-MFC-AGG-ID: xS49o_OVN4OkVx3jBmOvrA_1787685193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25374195FDCD; Tue, 25 Aug 2026 19:13:13 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45A7C1803A67; Tue, 25 Aug 2026 19:13:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:55 +0400
Subject: [PATCH v4 48/49] build-sys: add 'hmp' option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-48-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiITEwcQ3EcLD2Jl432HDNyDpNceMEUTXYMi
 ymgvaj5T8qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5ZcWEACM4GieP8EPaWvRsWriVyL3zs4CxOmIN2avXnyQwEZCtEinDVeaTj4EpAGld1zW0N0QYew
 nHUCVD1RdBoG8YKgGg2GvDej8E+M7sp8mtv4YM/cqVqub1wsYf/B8xGkuqctKMC2EHCWaFnHC6U
 D9tsnqe1rYf6Ar7UekBL24XrPiO8OfZpOs9itGwQUWhHWHXTf+l9l1O+n2XEpnJWnM9GayNrxW+
 bNQHKKoVN9SnGrHDbp88+ZP4q3FZjuTYzcyc9be13ijKDuo0zMnM32u2nbiTZzIQv6F7MfInjj4
 0GPo06G92EPg35eOFi2lQ2kZaQr+BaDVYjymhvlxDYSxmC8P/mtZgkrHEZxqUwD3ZVcDyoHB3Ah
 S4z+bWAjDqvvEOB3s9gHrtWzJFHzXTBOCHCuCihtkEKei5SitGDLolf6kgPy14+4sV2Xdxz+CkS
 1vbelQZbjEgCOvurK1LPoG7AUSk8NEOrjAKlc9Lv1DQwsYMEUeOHqbIhjv/5drbIkpeP9nQlowS
 LLmo/jRxwc6j8iG4KIsxrxSH/8oCPsQ+0SyyIA8lxqjtShwE1tnkNn0iNqRGXtmZS1wlAIMQNt4
 KIN0wOSl4jVsEttVwpIudh5M+lM6uMpsYQeZmAAd5E1rb3amsZhE1ZcGVDDeQQ80P15GrHIe9QG
 bRwJoHtUVdEP4sA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


