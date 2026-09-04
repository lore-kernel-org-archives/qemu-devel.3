Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5E3C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLt-00066r-D4; Fri, 04 Sep 2026 01:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLr-0005xy-Tu
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:35 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLq-0001HH-9K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:35 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc1cb472b76so678898a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499228; x=1789104028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I1MwYbmA9AWHCSzq2DdT87gBKuDwXbb7AOs2ODg6G4A=;
 b=YZW8kR88BzjaoiVdOFD6Ax7Aq2ghTLwvMLakUT9WXl2WCIrJJGDIH5l7iVBwBURax9
 xipJigMOUxJgsywb2VCd8Yhxmziunp91gFbam+wrO1rB6A+9f/ueHt5gk9mZ/76GIHZX
 3Nsa7WCN06mcvq0ybY1gSG9I+P/zb/z7m1npzpomN12pq15uX6EykR8/lOVj+u5VPWhz
 oq7jMq3TRXTlG0vKo5Dl9ZQ4FY4DRD/1vvev2lnapquBO82LLr1IdKtujIArr1SfMgWE
 yM+ZgKzVxJO1ai844DwgRHeyZ26O+R7eoRkgGVpIYVEdV3DXFPbUgB6wOVwPIOUhryRT
 fmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499228; x=1789104028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I1MwYbmA9AWHCSzq2DdT87gBKuDwXbb7AOs2ODg6G4A=;
 b=lo9Q01mM2Q2XebcdcNIl5knlU6Nv6F9ck6QdMmeZHKWeEJC9zcKNXtCtuuPO4i31De
 STsbKHoO6ccN2Bk0Sbvhsd1nGYU6wKLWms0WvqABIr8uc0pQyT1fAk34w75R8AfOkBxD
 uyIBLQuvphanFdH3BXH6U2gZJqSEHt3SHklgo1mmbvJbEGid1gmDb86vtJVhvkwah1at
 11C5+cgVDlPw7drGnZXtwHmq4U9OWKKZirzZE7g9WWUlsNZvPbF4+C+DwlEWPxHmvhWt
 bEILZ/48BKWCpxNpeeydGMd7kd83XSBOeTulE1ioeIE5Qzk8c8bDof4r3sY3xpi2af10
 7f+w==
X-Gm-Message-State: AFuF++kchfGEiUx7tGe/vNdVz6tvgFW1k9e5ReVbCZg8zOo91H4kf8qW
 ciOpuIrerg0Wv/USPmD1zA7bBA0ity83PlSHqlUaPGg50fdNaKlCdNl92dxm7w==
X-Gm-Gg: AYBFou0ZrX+8VhxVoaHaUkqM+lcZ1q3DnMdel1+fpM/M7I0Qamz060BohbQpeAtTzyR
 0CXTAzmNN9ofgJZJUHS5FZX2QoWC0v3Aeqlm4rlkzesDxDxDLe4yCkR5TzYK0wAh0f+A/VicqZE
 E4YpXosMGf7wlNGVfRzUQ1QlktnYhaCuo8nqaP5P9D6RqczDjgEgD/wSKl93xUhNFSCgGcYdwsF
 +snlLrtzXVVMOAMtIshtjRQqcw6CnzdT7ENUvjiPgYYcc/HQVSnIp3qD0hff2r4uXeu2G3G6w5r
 Nx1Fxo72ICgPFmMR5oAUJy1/D6p/MBkGxz8lS7bVphuj5KtBcssSStYDjxtlZWHJ1LDwHkHofRP
 nFJ2oAfFVv4ViypvncAvpJo4Jr+cGb4Q4q4XLcVyiGvIOhIdeChoP2TWKSHpTyNb7uevK8QEM0y
 0EP5u224oMoh91ysyvukgjsvmb1kJMQEDW8RuvA4nv/SivR2ZDCXsbNyC+18gDyf5UigCKqHDc5
 flGsg==
X-Received: by 2002:a05:6a20:12c8:b0:3d3:ae40:51e7 with SMTP id
 adf61e73a8af0-3da3a102710mr5156263637.27.1788499228034; 
 Thu, 03 Sep 2026 22:20:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PULL 11/47] hw/riscv/aia: Check for invalid IMSIC configs
Date: Fri,  4 Sep 2026 15:19:07 +1000
Message-ID: <20260904051943.799041-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Assert that the IMSIC layout will be valid before creating the devices.

aia_guests is a command line parameter but the machines that allows it
to be set (currently only virt) should be passing the correct stride for
a given number of guests. The assert helps catch bugs in future changes
and shouldn't be triggerable by an invalid user config.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>
Message-ID: <20260824030509.18078-3-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c33a3b32bd..c1a5982856 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -43,6 +43,10 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
     /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
     g_assert(num_sources <= 1023);
 
+    /* Prevent IMSIC MMIO regions from silently overlapping */
+    g_assert(s_imsic_stride >= IMSIC_HART_SIZE(imsic_num_bits(1 + aia_guests)));
+    g_assert(m_imsic_stride >= IMSIC_HART_SIZE(0));
+
     if (msimode) {
         if (!kvm_enabled()) {
             /* Per-socket M-level IMSICs */
-- 
2.55.0


