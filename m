Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F9610ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67W3-0000eg-5g; Fri, 27 Mar 2026 09:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w67Vs-0007gJ-01
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w67Vp-0006i2-IO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774619168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5I4/G72hvVsFtElipL0UZ7WDqmWzfz7Df4ICX/cOls=;
 b=bwm5coTlOMFDWnSKx65JamWD92qTVknNHMhFHbR1y6flostmeoh5La9CaV5/LRYNIBotWf
 8TC3EtFtAKZqTMT/qXVZHcr2QwzEPKEwSfpSAWDPBTxPccEAsQw+4ia7Ta/VBd/pIxbFUe
 akYZ+h9IEx3TZZzJcEysR5eZsbtIwKI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-B3v5Nm5sNkuoJ7zD4fQKiQ-1; Fri,
 27 Mar 2026 09:46:05 -0400
X-MC-Unique: B3v5Nm5sNkuoJ7zD4fQKiQ-1
X-Mimecast-MFC-AGG-ID: B3v5Nm5sNkuoJ7zD4fQKiQ_1774619163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5067195608E; Fri, 27 Mar 2026 13:46:02 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86AA8180075C; Fri, 27 Mar 2026 13:45:55 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 15/15] meson: Don't require nm for non-modular builds
Date: Fri, 27 Mar 2026 15:44:01 +0200
Message-ID: <20260327134401.270186-16-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-1-kkostiuk@redhat.com>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In the MSVC build environment, nm is missing; at the same time,
scripts/undefsym.py exits with code 0 at the beginning
for non-modular builds.

So, this change is harmless because it already didn't do anything
in non-modular builds, but remove the additional tool requirements.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 meson.build | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 4a3fc306b7..cc9e9784e9 100644
--- a/meson.build
+++ b/meson.build
@@ -3908,6 +3908,9 @@ modinfo_generate = find_program('scripts/modinfo-generate.py')
 modinfo_files = []
 audio_modinfo_files = []
 
+block_syms = []
+qemu_syms = []
+
 block_mods = []
 system_mods = []
 emulator_modules = []
@@ -4023,18 +4026,18 @@ if enable_modules
   if emulator_modules.length() > 0
     alias_target('modules', emulator_modules)
   endif
-endif
 
-nm = find_program('nm')
-undefsym = find_program('scripts/undefsym.py')
-block_syms = custom_target('block.syms', output: 'block.syms',
-                             input: [libqemuutil, block_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
-qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
-                             input: [libqemuutil, system_mods],
-                             capture: true,
-                             command: [undefsym, nm, '@INPUT@'])
+  nm = find_program('nm')
+  undefsym = find_program('scripts/undefsym.py')
+  block_syms = custom_target('block.syms', output: 'block.syms',
+                              input: [libqemuutil, block_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+  qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
+                              input: [libqemuutil, system_mods],
+                              capture: true,
+                              command: [undefsym, nm, '@INPUT@'])
+endif
 
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
-- 
2.52.0


