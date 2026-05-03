Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D57FF885A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 07:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJROQ-0000v8-OC; Sun, 03 May 2026 03:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJROF-0000CX-4f
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wJROC-0003iL-Ks
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777793839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMHufetHYJa4Ixy40r/OFgQsMVkW7F89Hja91OVyjGc=;
 b=hHiDSFjLSp9KUQVOhH1Urf8hb6QYNCkEwetvydT+5FcIa21NcWIHnc+38WgXxStIFwC+xM
 6fK5q4nsKGd6CNSjr6ELXdTiVOeUw9fkseuV8eQJ57nlMn8pmjwvcmoRHp0+57/BZIjE6F
 U+tpOL379v+P5xnEtwVWVPiyENXp3ak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-5lerwPEpOJC3Mmgt6Vcbuw-1; Sun,
 03 May 2026 03:37:14 -0400
X-MC-Unique: 5lerwPEpOJC3Mmgt6Vcbuw-1
X-Mimecast-MFC-AGG-ID: 5lerwPEpOJC3Mmgt6Vcbuw_1777793832
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD9F51800352; Sun,  3 May 2026 07:37:12 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D62A61800480; Sun,  3 May 2026 07:37:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v4 14/17] target/arm/kvm: Special case ID_AA64ISAR0_EL1 RES0
 [24, 27] bits
Date: Sun,  3 May 2026 09:33:34 +0200
Message-ID: <20260503073541.790215-15-eric.auger@redhat.com>
In-Reply-To: <20260503073541.790215-1-eric.auger@redhat.com>
References: <20260503073541.790215-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

RES0 [24, 27] bits seem to be reported as writable by the kernel.
This corresponds to former TME field that was turned to RES0 after
FEAT_TME removal from the architecture.

See kernel commit d65bf6e317e7b ("KVM: arm64: Remove all traces
of FEAT_TME") for additional info. However the kernel still exposes
it at writable. Until this gets fixed, Let's ignore those bits.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f3aecef35c..18373b0936 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -430,10 +430,13 @@ decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
         char *prop_name;
 
         if (!field) {
-            warn_report("%s bit %d of %s is writable but no named field "
-                        "in target/arm/cpu-sysreg-properties.c",
-                        __func__, i, reg->name);
-            warn_report("%s is target/arm/cpu-sysreg-properties.c up to date?", __func__);
+            if (strcmp(reg->name, "ID_AA64ISAR0_EL1") || i < 24 || i > 27) {
+                warn_report("%s bit %d of %s is writable but no named field "
+                            "in target/arm/cpu-sysreg-properties.c",
+                            __func__, i, reg->name);
+                warn_report("%s is target/arm/cpu-sysreg-properties.c up to date?",
+                            __func__);
+            }
             map =  map & ~BIT_ULL(i);
             i = ctz64(map);
             continue;
-- 
2.53.0


