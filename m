Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B7D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHh-0001Wa-7P; Wed, 20 Nov 2024 20:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHf-0001Vf-AC
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:03 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHd-0004WG-FT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=92nCTdq11lbmBeZ/kw31uZpfZQz1CwbJLefAdeyXWco=; b=gIde7BioDXeDDff
 7ENqxxKNMKavjEuuh1qdClGTzOBL3iDN4USMtm7mwj47KEEDhQ6FpLezAJhjMZr+JoviVSta9e7vv
 BKszrb81A0vpM2As20cqJsNeLtefTMP3iyDJu9WE/foNCh3Ycx+cRwzUGi4Ibz94HLfhZ++/Ldypw
 2E=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 01/43] Add option to enable/disable helper-to-tcg
Date: Thu, 21 Nov 2024 02:49:05 +0100
Message-ID: <20241121014947.18666-2-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a meson option for enabling/disabling helper-to-tcg along with a
CONFIG_* definition.

CONFIG_* will in future commits be used to conditionally include the
helper-to-tcg subproject, and to remove unneeded code/memory when
helper-to-tcg is not in use.

Current meson option is limited to Hexagon, as helper-to-tcg will be
included as a subproject from target/hexagon.  This will change in the
future if multiple frontends adopt helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 meson.build                   | 7 +++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/meson.build b/meson.build
index e0b880e4e1..657ebe43f6 100644
--- a/meson.build
+++ b/meson.build
@@ -230,6 +230,7 @@ have_ga = get_option('guest_agent') \
            error_message: 'unsupported OS for QEMU guest agent') \
   .allowed()
 have_block = have_system or have_tools
+helper_to_tcg_enabled = get_option('hexagon_helper_to_tcg')
 
 enable_modules = get_option('modules') \
   .require(host_os != 'windows',
@@ -3245,6 +3246,11 @@ foreach target : target_dirs
       'CONFIG_QEMU_RTSIG_MAP': get_option('rtsig_map'),
     }
   endif
+  if helper_to_tcg_enabled
+    config_target += {
+      'CONFIG_HELPER_TO_TCG': 'y',
+    }
+  endif
 
   target_kconfig = []
   foreach sym: accelerators
@@ -4122,6 +4128,7 @@ foreach target : target_dirs
   if host_os == 'linux'
     target_inc += include_directories('linux-headers', is_system: true)
   endif
+
   if target.endswith('-softmmu')
     target_type='system'
     t = target_system_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/meson_options.txt b/meson_options.txt
index 5eeaf3eee5..0730378305 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -374,6 +374,8 @@ option('qemu_ga_version', type: 'string', value: '',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+option('hexagon_helper_to_tcg', type : 'boolean', value : true,
+       description: 'use the helper-to-tcg translator to automatically generate TCG code for the Hexagon frontend')
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index a8066aab03..19c891a39b 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -13,6 +13,9 @@ meson_options_help() {
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
   printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
+  printf "%s\n" '  --disable-hexagon-helper-to-tcg'
+  printf "%s\n" '                           use the helper-to-tcg translator to automatically'
+  printf "%s\n" '                           generate TCG code for the Hexagon frontend'
   printf "%s\n" '  --disable-hexagon-idef-parser'
   printf "%s\n" '                           use idef-parser to automatically generate TCG'
   printf "%s\n" '                           code for the Hexagon frontend'
@@ -341,6 +344,8 @@ _meson_option_parse() {
     --disable-guest-agent) printf "%s" -Dguest_agent=disabled ;;
     --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=enabled ;;
     --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=disabled ;;
+    --enable-hexagon-helper-to-tcg) printf "%s" -Dhexagon_helper_to_tcg=true ;;
+    --disable-hexagon-helper-to-tcg) printf "%s" -Dhexagon_helper_to_tcg=false ;;
     --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
     --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
     --enable-hv-balloon) printf "%s" -Dhv_balloon=enabled ;;
-- 
2.45.2


