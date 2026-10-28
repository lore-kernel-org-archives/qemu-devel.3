Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E81606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaVmHYpF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCRW-0001tv-AR; Wed, 28 Oct 2026 18:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRV-0001tP-2J
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:25 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRT-0007cn-LJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:24 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F57140C1F;
 Wed, 28 Oct 2026 22:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF531F01828;
 Wed, 28 Oct 2026 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793227702;
 bh=0yiUY2Z9qQHK+/rTlkffNQL8k1/sn9HIstSC9OkeCc0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZaVmHYpFM5pgd3Q007lMKsHusEtsu+Xx/zqrv3/CBhlFEtDkzvsWN278xLCaykZF4
 t65Zr9A0KOYY8REFnwZbLE3NYDSB2ajP7/ZuSDudeRp4hiA5b/Ctzwx6Y8jF7bg8a7
 Y+qDm2I+kp7JGSBzwhNxtlAJfapbV2vB2IgTVODAkLhg5LQJN0B5VQYkQRcsEzQyk+
 kdXmWykJL8InIcRjahjt1loOtwUl4iC3ydsTNldQlvMY7FvyBoR5RRivWq4n23akyS
 IEoSUfL8n9F1kENz70uB7cIdWcrfqQtUIg3ClzyVL8kU8rnrOjB/gzFo7S/1fY8lwr
 Ddg9JDZce9q4w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 2/4] hw/audio: Wire up the harmony driver in meson and Kconfig
Date: Wed, 28 Oct 2026 23:48:13 +0100
Message-ID: <20261028224815.32502-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028224815.32502-1-deller@kernel.org>
References: <20261028224815.32502-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Signed-off-by: Keith Monahan <keith@techtravels.org
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/audio/Kconfig     | 3 +++
 hw/audio/meson.build | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index ed93fa2698..ba6f66342e 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -51,3 +51,6 @@ config VIRTIO_SND
     bool
     default y
     depends on VIRTIO
+
+config HARMONY
+    bool
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
index 3312bcec10..f440324cdf 100644
--- a/hw/audio/meson.build
+++ b/hw/audio/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_CS4231', if_true: files('cs4231.c'))
 system_ss.add(when: 'CONFIG_CS4231A', if_true: files('cs4231a.c'))
 system_ss.add(when: 'CONFIG_ES1370', if_true: files('es1370.c'))
 system_ss.add(when: 'CONFIG_GUS', if_true: files('gus.c', 'gusemu_hal.c', 'gusemu_mixer.c'))
+system_ss.add(when: 'CONFIG_HARMONY', if_true: files('harmony.c'))
 system_ss.add(when: 'CONFIG_HDA', if_true: files('intel-hda.c', 'hda-codec.c'))
 system_ss.add(when: 'CONFIG_PCSPK', if_true: files('pcspk.c'))
 system_ss.add(when: 'CONFIG_PL041', if_true: files('pl041.c', 'lm4549.c'))
-- 
2.54.0


