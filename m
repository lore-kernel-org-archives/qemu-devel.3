Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67F410ED679
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67W2-0000Uj-9f; Fri, 27 Mar 2026 09:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w67Vn-0007Qc-Hd
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w67Vj-0006g6-09
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774619161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozMMMbc5i4osCd27yTtYVpRq0NefVxtoYxUcTIpyOtQ=;
 b=P/DSxC+hv/nZsj5qmhWgDQncxgnem8E9O+QLkqpX+ZsS+Wq0hK1MrqyYBHGG996C+z9t9x
 TUnrfbigMB9Z/Fp+ApOk1TghE7CFkC0rkQaSVWfYQ+4dgMRhsJfZZNMvvRrBBGLxj/jwzw
 pYdxeC21GKh1rHzHPHUrJkmHCybo+74=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-Oq34NabwP6-24Tg-o-cfLg-1; Fri,
 27 Mar 2026 09:45:57 -0400
X-MC-Unique: Oq34NabwP6-24Tg-o-cfLg-1
X-Mimecast-MFC-AGG-ID: Oq34NabwP6-24Tg-o-cfLg_1774619155
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A42818005B0; Fri, 27 Mar 2026 13:45:55 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7719A1800673; Fri, 27 Mar 2026 13:45:48 +0000 (UTC)
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
Subject: [PATCH v2 14/15] storage-daemon: use same link arguments as other
 tools
Date: Fri, 27 Mar 2026 15:44:00 +0200
Message-ID: <20260327134401.270186-15-kkostiuk@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  8 ++++----
 storage-daemon/meson.build | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 1087e8c106..4a3fc306b7 100644
--- a/meson.build
+++ b/meson.build
@@ -4507,15 +4507,15 @@ if xkbcommon.found()
 endif
 
 if have_tools
-  link_args = enable_modules ? ['@block.syms'] : []
+  tools_link_args = enable_modules ? ['@block.syms'] : []
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
-               link_args: link_args, link_depends: block_syms,
+               link_args: tools_link_args, link_depends: block_syms,
                dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 5e61a9d1bd..fc088cbea7 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -1,14 +1,14 @@
+assert(have_tools)
+
 qsd_ss = ss.source_set()
 qsd_ss.add(files('qemu-storage-daemon.c'))
 qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
 
 subdir('qapi')
 
-if have_tools
-  qsd_ss = qsd_ss.apply({})
-  qsd = executable('qemu-storage-daemon',
-                   qsd_ss.sources(),
-                   link_args: '@block.syms', link_depends: block_syms,
-                   dependencies: qsd_ss.dependencies(),
-                   install: true)
-endif
+qsd_ss = qsd_ss.apply({})
+qsd = executable('qemu-storage-daemon',
+                 qsd_ss.sources(),
+                 link_args: tools_link_args, link_depends: block_syms,
+                 dependencies: qsd_ss.dependencies(),
+                 install: true)
-- 
2.52.0


