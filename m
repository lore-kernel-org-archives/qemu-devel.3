Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07609CD98E6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRAc-0008RI-Lv; Fri, 19 Jun 2026 00:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRAY-0008Pa-QC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:31 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRAV-0005SV-SE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:30 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c8857a27041so798155a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781844566; x=1782449366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUuEtyKtFhfXIoCph6bUYAge9pOaOKkGGobDBDNgwZk=;
 b=EzXHAZcL4JuGYFfgI7igb1+gN7CARIGHZLpT/EjgDqZTm6tTXNejsWjzEtBPe/HZCh
 6i/rF9UHO8fb28RQUTzBncbZjWDrG7POB2gr4fLIS4B2q+wT0MStC2qI3KhO3cd11gOe
 cnax4VCcEPNSRR8Y4/ukjrP+HBSmxsaA+2L5BXzsIB9UKP9nxMsEUs8Wl2zDJqooCrGU
 YFhZ4ompQRdL1GP1UpVNFezWKQZXzE4H/k1YVMAIAB6x0cIiul1FwbzGfaFVtANeTcxG
 dugBaw6UKGrQPfj0HfJkl+b62/1d3wTVSnESaZhZurJEOD3ggMUwOwvk1oS50ObY5ZWT
 zQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781844566; x=1782449366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KUuEtyKtFhfXIoCph6bUYAge9pOaOKkGGobDBDNgwZk=;
 b=Xyy1Um7SouGkmoM4i4Pk/zkffMW1U1ZxMgbC8xcQAxm9R+TNIGBL3WIQuc0Xal0R0v
 x9zZ/LkrLbnbjb9tG4n3z9Pwtu66IpoGOkMqWphtR8Hp+6OFaAo61q5DRyh2h3KILXrG
 uD30msG4C7HP1YmtKvfHjhgpj8DWPTzSWTiR7k9bjcHQ2P2r2kOkiAZJvxW8US/NNpm8
 Sbku8I+CcPZeoiQjN8g64gEKluKEMJxDRQgtbiLN8t+1eEnhJPx3HgfimZ8I9owpxlko
 D58bB2uUARbgEIOm3RBI+uSLJ39hm4v54952Jg/Fq4Wj4I6Mtn0Bm23m2/ORJV4KHH52
 uRXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9prF2FlqiO9J0p/x8BFeqJWcNhr69pqQGmBd694ud2xBvhAvA/6asyTmuhaRkkqrsIxU8Rot0I9k0L@nongnu.org
X-Gm-Message-State: AOJu0Yxw8kJiOp1Es7ydcNvl0NpjLn+d/9JD+h/a5Ht+BItanbyBvEdp
 TpFdfjwavszOviCH3h35TVnj6i5avMdwq6WeBXyFRiNijpmyldBljAWz
X-Gm-Gg: AfdE7claoMPJh94NxfeB1HO2oV/pYpxxqkZbYll2MYAIyX+0TlCq7OWVIu8N2EvbNHD
 wOAiajkSgFGR73rzTWiTuheO3R9HwVnpbvO8wqxY98a6P1DTqOKwX2/GBcCs8BCMSTPwLU1Zb32
 m/Ca+KvncDskQJ643E5XH+8+LRruzM0hz1scrZb770RxOwsiptnvuwILB4VRDsHqkmhfque4kW6
 WRKdI66bVqsh5C7HIlAltOw9FZqa9wTUdGvXs1MzNOS9cCKqlzTceq7anaO1eX8ZaoIypkZVXzA
 hjO4hng1CvwJfnGL2c97qrg/DFz6gOrhME8V45JKjiz3VHapyUmvl7CGzBRT/ERrx6fCi/mmKq5
 REXXQ0oi7IDl+/cjVbo0S6EbCauTcn9S/eGo65XbjtlRRiZonjomCB9RmT8gXwy78g76et12XWT
 ePswZ2NxCmOiRHGvhZMsjLD/l9vmlga3N+J0RUUCk7iJUOXtFcFA0TFmQsds3DgrUJn843VTJ+m
 V7QRy2JVZijDawlxPXw78iA+IoR0QBi+Aqx2dHhzHowcx32NniZ
X-Received: by 2002:a05:6a00:339a:b0:842:83d1:ee6d with SMTP id
 d2e1a72fcca58-84550aff364mr2034918b3a.45.1781844565863; 
 Thu, 18 Jun 2026 21:49:25 -0700 (PDT)
Received: from donnager-debian.. ([144.6.172.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455363da44sm870141b3a.8.2026.06.18.21.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:49:25 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v9 05/12] hw/riscv/aia: Configure stride for the M-mode IMSIC
Date: Fri, 19 Jun 2026 14:18:29 +0930
Message-ID: <20260619044838.1054677-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619044838.1054677-1-joel@jms.id.au>
References: <20260619044838.1054677-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

riscv_create_aia() currently hard-codes the M-IMSIC at one 4 KiB page
per hart and gives callers no way to widen it.

Add an m_imsic_stride parameter that supplies the per hart byte
stride directly. The virt machine passes IMSIC_HART_SIZE(0)
(= 4 KiB), preserving its existing compact layout.

The parameter only changes how the slots are spaced, with the rest of
each slot reserved. This allows future platforms that have different
layouts to control the stride.

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h  | 1 +
 hw/riscv/aia.c  | 3 ++-
 hw/riscv/virt.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 5ad0a902be0d..565f91accc09 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -14,6 +14,7 @@
 uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 82ea9d48ea75..ed8916002945 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
@@ -47,7 +48,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
+                riscv_imsic_create(addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b62864559f57..b10f347a5cbf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1418,6 +1418,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             IMSIC_HART_SIZE(0),
                                              s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
-- 
2.47.3


