Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06078C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 16:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRCTe-0003Ll-6h; Mon, 16 Jun 2025 12:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tiwai@suse.de>) id 1uRCTc-0003LZ-Ig
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 12:14:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tiwai@suse.de>) id 1uRCTa-0008Hd-Hc
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 12:14:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0433211B3;
 Mon, 16 Jun 2025 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750090458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xAZ1pS7ZVkemVnWAlaPyAiw28HCsnl//HdEVKNU0pFM=;
 b=byUvZqoKcvNI4OtYtUETdKqbjIubMAECBN8ZQz1MBOUQJOBCMkh0Pgh4NToKdzHNbYPBB9
 YMBidXI1ViENS8HSC1YmGn21+stZzHo+0zt9ILiepxfV1x3OuhEAMR4MfLXVL9j2Eqe9rz
 THzDve4Pc0McO/0VO/FQ7oEVWTb4TSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750090458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xAZ1pS7ZVkemVnWAlaPyAiw28HCsnl//HdEVKNU0pFM=;
 b=wx12I/IIGB2p+cRkCCdtA/UsWRoRB9eeHcdM8JHsImKlwPBYpGJADlgDj41aBc53MVd5or
 F+b6jK9BtVdwP2Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750090452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xAZ1pS7ZVkemVnWAlaPyAiw28HCsnl//HdEVKNU0pFM=;
 b=BNkb4E1fKWvOXyfEO1NJh8Uet284lPoICAjAWCaf1AobT0AhkayLxZbPh8dVGYpQyCRscP
 IiSb0Xqdz42BU7XWz2upe87DIgP9Z2hdhYWGZTuaP9FOukoT6yf4T8EMr+A8hP7jyeSE1V
 H4Fgc4tDSyVLkAC0twGV57Sxqm5lBJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750090452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xAZ1pS7ZVkemVnWAlaPyAiw28HCsnl//HdEVKNU0pFM=;
 b=PuiVYcCT33LVz8d+IlYcJkGVaORZ6zUzoeZKOrk7WA+odiczzCOXlf7FwMHH/l1pKDGEP8
 0X/vR4qP3zCjCcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B812013A6B;
 Mon, 16 Jun 2025 16:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K3cvK9RCUGgTcwAAD6G6ig
 (envelope-from <tiwai@suse.de>); Mon, 16 Jun 2025 16:14:12 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Gabriel Somlo <somlo@cmu.edu>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Fabian Vogt <fvogt@suse.de>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH RESEND] firmware: qemu_fw_cfg: Do not hard depend on
 CONFIG_HAS_IOPORT_MAP
Date: Mon, 16 Jun 2025 18:14:06 +0200
Message-ID: <20250616161408.26748-1-tiwai@suse.de>
X-Mailer: git-send-email 2.49.0
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=tiwai@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Fabian Vogt <fvogt@suse.de>

Some platforms require CONFIG_NO_IOPORT_MAP=y but would also support
qemu_fw_cfg over MMIO. Currently the qemu_fw_cfg module can't be built for
those as it needs HAS_IOPORT_MAP=y for ioport remapping.

This patch allows to build the qemu_fw_cfg in those cases. If
CONFIG_HAS_IOPORT_MAP=n, qemu_fw_cfg is built without support for ioport
based access.

Signed-off-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Resent, as the original submission seems overlooked:
 https://lore.kernel.org/2294036.ElGaqSPkdT@linux-e202.suse.de/
The patch has been on openSUSE / SUSE kernels already for years.

 drivers/firmware/Kconfig       | 1 -
 drivers/firmware/qemu_fw_cfg.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..91442f85f0f0 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -122,7 +122,6 @@ config RASPBERRYPI_FIRMWARE
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
 	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
-	depends on HAS_IOPORT_MAP
 	default n
 	help
 	  Say Y or M here to enable the exporting of the QEMU firmware
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 2615fb780e3c..e15116f84a70 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -258,6 +258,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			return -EFAULT;
 		}
 	} else {
+#ifdef CONFIG_HAS_IOPORT_MAP
 		if (!request_region(fw_cfg_p_base,
 				    fw_cfg_p_size, "fw_cfg_io"))
 			return -EBUSY;
@@ -266,6 +267,10 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			release_region(fw_cfg_p_base, fw_cfg_p_size);
 			return -EFAULT;
 		}
+#else
+		dev_err(&pdev->dev, "IO region given but CONFIG_HAS_IOPORT_MAP=n");
+		return -EINVAL;
+#endif
 	}
 
 	/* were custom register offsets provided (e.g. on the command line)? */
-- 
2.49.0


