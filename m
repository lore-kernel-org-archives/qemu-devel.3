Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE86CC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZE-00015D-Fp; Fri, 14 Jun 2024 13:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZD-00013K-5o
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:23 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZB-00043m-H8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 50E41339FB;
 Fri, 14 Jun 2024 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oUUxkja25yKI5x3Xf7VoUaogDWc4vwbKUzr6RmUlPM=;
 b=Mrq+fztzuP/4wlaDaI32hQUxIyMvXFsMNALoHNlRBSBBmS2enOoAV3zmk85eu5D/TzK9db
 WOdyHV3pdW3CHj3vXg2Lbiv/WnShu5TVDwHRijma+XIuiseMedYrvRIa3Y2f9g/WY303eS
 WJ2bnHUp/okUhgaCO6tMtUdZyMXJ51I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oUUxkja25yKI5x3Xf7VoUaogDWc4vwbKUzr6RmUlPM=;
 b=j7Ph3lAEQdAeAjA6c9I/V1dhgQ1uM+Z/6gOZ1NiLdON168p4Ayvlj/cFelUPLm1nUnFAvs
 4cO5uR3sfvux1oDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mrq+fztz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j7Ph3lAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oUUxkja25yKI5x3Xf7VoUaogDWc4vwbKUzr6RmUlPM=;
 b=Mrq+fztzuP/4wlaDaI32hQUxIyMvXFsMNALoHNlRBSBBmS2enOoAV3zmk85eu5D/TzK9db
 WOdyHV3pdW3CHj3vXg2Lbiv/WnShu5TVDwHRijma+XIuiseMedYrvRIa3Y2f9g/WY303eS
 WJ2bnHUp/okUhgaCO6tMtUdZyMXJ51I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oUUxkja25yKI5x3Xf7VoUaogDWc4vwbKUzr6RmUlPM=;
 b=j7Ph3lAEQdAeAjA6c9I/V1dhgQ1uM+Z/6gOZ1NiLdON168p4Ayvlj/cFelUPLm1nUnFAvs
 4cO5uR3sfvux1oDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF46413AB1;
 Fri, 14 Jun 2024 17:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLpWHVp7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yuan Liu <yuan1.liu@intel.com>, Nanhai Zou <nanhai.zou@intel.com>
Subject: [PULL 07/18] configure: add --enable-qpl build option
Date: Fri, 14 Jun 2024 14:17:51 -0300
Message-Id: <20240614171802.28451-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50E41339FB
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yuan Liu <yuan1.liu@intel.com>

add --enable-qpl and --disable-qpl options to enable and disable
the QPL compression method for multifd migration.

The Query Processing Library (QPL) is an open-source library
that supports data compression and decompression features. It
is based on the deflate compression algorithm and use Intel
In-Memory Analytics Accelerator(IAA) hardware for compression
and decompression acceleration.

For more live migration with IAA, please refer to the document
docs/devel/migration/qpl-compression.rst

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 meson.build                   | 8 ++++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/meson.build b/meson.build
index 3a2f126490..c16574710c 100644
--- a/meson.build
+++ b/meson.build
@@ -1201,6 +1201,12 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+qpl = not_found
+if not get_option('qpl').auto() or have_system
+  qpl = dependency('qpl', version: '>=1.5.0',
+                    required: get_option('qpl'),
+                    method: 'pkg-config')
+endif
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2333,6 +2339,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4446,6 +4453,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'Query Processing Library support': qpl}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 4c1583eb40..dd680a5faf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -259,6 +259,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
+option('qpl', type : 'feature', value : 'auto',
+       description: 'Query Processing Library support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6ce5a8b72a..73ae8cedfc 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -220,6 +220,7 @@ meson_options_help() {
   printf "%s\n" '                  Xen PCI passthrough support'
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
+  printf "%s\n" '  qpl             Query Processing Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -558,6 +559,8 @@ _meson_option_parse() {
     --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
     --enable-zstd) printf "%s" -Dzstd=enabled ;;
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
+    --enable-qpl) printf "%s" -Dqpl=enabled ;;
+    --disable-qpl) printf "%s" -Dqpl=disabled ;;
     *) return 1 ;;
   esac
 }
-- 
2.35.3


