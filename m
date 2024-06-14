Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F04C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZU-00019j-3A; Fri, 14 Jun 2024 13:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZQ-00018G-Ro
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:37 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZO-00047K-PN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A65D620726;
 Fri, 14 Jun 2024 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB7SLOs6gcfqpQZjc/YzZDAovxQaY2aowoNpB52Z6PU=;
 b=uelrg4jwjHZhDixuP4vudq4N0m6Qn63BWdVT1J6jdy5Jf6BpO3QdWqD3cEeQ4m2PrVrI4g
 kW1p8eoHpV4kc+bgZxvf1wUciNyQ6BMTSFmXFRsFNEIBfFeXm2ItXTe1bYMOh3BH/iMlWY
 BAHyGRMQ8Aumdpg1+RIIU3rq9V9agXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB7SLOs6gcfqpQZjc/YzZDAovxQaY2aowoNpB52Z6PU=;
 b=IyritM7CsEKBjXggskb9LRu/r9XRsBpSjFvuwOoVKs3K/+QqHzR4l6mMuqV1tTK5yKTXpy
 vFamTWQo4+t4PLCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB7SLOs6gcfqpQZjc/YzZDAovxQaY2aowoNpB52Z6PU=;
 b=qaShqWFY9jOO3hNSR2zZFAVny71n70hnbbkYbSzxB68axfKcymobMOidYAvBx7qhxFf73L
 vPQXyBCiM9SgcCwS+gaX0kdtnEng5k92x/MNxn/Igssb18YluTUNGhTNTLlyojWXwAx3xD
 xUQl7Wfz5A/uRBbh1m1KFASKJ+HQdHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB7SLOs6gcfqpQZjc/YzZDAovxQaY2aowoNpB52Z6PU=;
 b=nHGBm5z2Mkgcxzj1Mazj9SY63NBR3gqnbx4UhSyQvXyinwNGuLG1Ew/RhddmyfsYl9C09I
 F45k17BO9sokjZDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A8813AB1;
 Fri, 14 Jun 2024 17:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WIc5MmZ7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PULL 13/18] configure: Add uadk option
Date: Fri, 14 Jun 2024 14:17:57 -0300
Message-Id: <20240614171802.28451-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Add --enable-uadk and --disable-uadk options to enable and disable
UADK compression accelerator. This is for using UADK based hardware
accelerators for live migration.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index c16574710c..97e00d6f59 100644
--- a/meson.build
+++ b/meson.build
@@ -1207,6 +1207,18 @@ if not get_option('qpl').auto() or have_system
                     required: get_option('qpl'),
                     method: 'pkg-config')
 endif
+uadk = not_found
+if not get_option('uadk').auto() or have_system
+  libwd = dependency('libwd', version: '>=2.6',
+                      required: get_option('uadk'),
+                      method: 'pkg-config')
+  libwd_comp = dependency('libwd_comp', version: '>=2.6',
+                           required: get_option('uadk'),
+                           method: 'pkg-config')
+  if libwd.found() and libwd_comp.found()
+     uadk = declare_dependency(dependencies: [libwd, libwd_comp])
+  endif
+endif
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2340,6 +2352,7 @@ config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
+config_host_data.set('CONFIG_UADK', uadk.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4454,6 +4467,7 @@ summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'Query Processing Library support': qpl}
+summary_info += {'UADK Library support': uadk}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index dd680a5faf..7a79dd8970 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -261,6 +261,8 @@ option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
 option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
+option('uadk', type : 'feature', value : 'auto',
+       description: 'UADK Library support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 73ae8cedfc..58d49a447d 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -221,6 +221,7 @@ meson_options_help() {
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
   printf "%s\n" '  qpl             Query Processing Library support'
+  printf "%s\n" '  uadk            UADK Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -561,6 +562,8 @@ _meson_option_parse() {
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
     --enable-qpl) printf "%s" -Dqpl=enabled ;;
     --disable-qpl) printf "%s" -Dqpl=disabled ;;
+    --enable-uadk) printf "%s" -Duadk=enabled ;;
+    --disable-uadk) printf "%s" -Duadk=disabled ;;
     *) return 1 ;;
   esac
 }
-- 
2.35.3


