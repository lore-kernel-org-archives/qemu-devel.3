Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBFAC25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKQ-0005bP-5Z; Wed, 22 May 2024 18:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKO-0005Yn-Kj
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:56 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKN-0003mo-0K
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B42D421C24;
 Wed, 22 May 2024 22:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxoPgeh780guSJuCdJ/NuIvP/e7hv349oFSX5BFg9sA=;
 b=ni7dv4Yag90eeEPyZm4N4tvOtl+L52+6nhMd/s8turk1AVKwx9+MoLXQunk1a1GbXmAxX2
 WllwannEuCkYs/k9oOINgrpdJhoScgbupnA+AfeRVuoSPZO9yYidFLpylV69V5P69VOgVl
 snG8MU896b0K/SqzsxVASx3hN/znSt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxoPgeh780guSJuCdJ/NuIvP/e7hv349oFSX5BFg9sA=;
 b=S3aV3m8yXN8DHaW5a/FN0gAUw3RCyw3//HOLj2Pjf5uboxHfcuvwTdY3T+215FIM+5FxRt
 xpVi2p4o06t8wzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxoPgeh780guSJuCdJ/NuIvP/e7hv349oFSX5BFg9sA=;
 b=ni7dv4Yag90eeEPyZm4N4tvOtl+L52+6nhMd/s8turk1AVKwx9+MoLXQunk1a1GbXmAxX2
 WllwannEuCkYs/k9oOINgrpdJhoScgbupnA+AfeRVuoSPZO9yYidFLpylV69V5P69VOgVl
 snG8MU896b0K/SqzsxVASx3hN/znSt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxoPgeh780guSJuCdJ/NuIvP/e7hv349oFSX5BFg9sA=;
 b=S3aV3m8yXN8DHaW5a/FN0gAUw3RCyw3//HOLj2Pjf5uboxHfcuvwTdY3T+215FIM+5FxRt
 xpVi2p4o06t8wzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 252BB13A6B;
 Wed, 22 May 2024 22:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +OxgN8JvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fiona Ebner <f.ebner@proxmox.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 7/9] hw/core/machine: move compatibility flags for VirtIO-net
 USO to machine 8.1
Date: Wed, 22 May 2024 19:20:32 -0300
Message-Id: <20240522222034.4001-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
References: <20240522222034.4001-1-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
version 8.1 can fail with:

> kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
> kvm: Failed to load virtio-net:virtio
> kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
> kvm: load of migration failed: Operation not permitted

The series

53da8b5a99 virtio-net: Add support for USO features
9da1684954 virtio-net: Add USO flags to vhost support.
f03e0cf63b tap: Add check for USO features
2ab0ec3121 tap: Add USO support to tap device.

only landed in QEMU 8.2, so the compatibility flags should be part of
machine version 8.1.

Moving the flags unfortunately breaks forward migration with machine
version 8.1 from a binary without this patch to a binary with this
patch.

Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/core/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8d6dc69f0e..f5dffea33d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -51,15 +51,15 @@ GlobalProperty hw_compat_8_1[] = {
     { "ramfb", "x-migrate", "off" },
     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
     { "igb", "x-pcie-flr-init", "off" },
+    { TYPE_VIRTIO_NET, "host_uso", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
     { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
-    { TYPE_VIRTIO_NET, "host_uso", "off"},
-    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
-    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
-- 
2.35.3


