Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEECC3ABA4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eE0-0003Se-St; Tue, 29 Apr 2025 02:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDk-0002hq-UY; Tue, 29 Apr 2025 02:13:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDj-0005SJ-1J; Tue, 29 Apr 2025 02:13:32 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso66176325ad.3; 
 Mon, 28 Apr 2025 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907209; x=1746512009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tu+TdgkyipnRFzu83KfGnUiONb88PJrh8832DmQzyXc=;
 b=bdKi6sc75/5aCoU/YuiL3SZPFaQ/RJUIxmGztiIVDIkci/xIXAyt2/3/NOnbgsLeuS
 KQnkMwRU4Yf7qtejG8gf7c4znsZb95svtmJ2dLdGl1NUjHS7LAFfLI2tAtWb8v684PcT
 7oGZOOEDBDVkcrPlGRXvvHSvhfVdRllJwnmjGPBiKc+kN7HgZ0fvtyuDzi7Ny316xmVT
 HD7YGxJnVnZMKWkaQ6S9rE9rWPeR9va7SMCDIM/B6+XrvdUO+2yi9w5+81B4SuoONkdD
 vzPo7MWMtX8JB8qPA7xcKaIa3ljvw6frpvm0xJgIehHxIHlacxKTKEgdIx5DLO02w6CO
 ruGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907209; x=1746512009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tu+TdgkyipnRFzu83KfGnUiONb88PJrh8832DmQzyXc=;
 b=vhHAf8SELhDkZR6KUAltchOwY6x3WxsJRI7n0264TpDuKL0WNhZ9Nxd8B3Fnfx4cE4
 DVs4e5M/74S/FdnCmaZT4QqA70bc+YOpPvgzmWtpURsou+rnuc0kvfJ7QXUVGOc5Bu2D
 XvP2K6I+W4pODRrkzjZvirdr5eunfENe2YPUy+E4fMyHXvSfUUlqONksKfKDVjY9QPZ4
 1wNM9eqmjPHSdj8pEVxUgdAG+OH6rBcVlGDikhZEjjm6d6L2uhol8zJ6mrj9Hp7WykoD
 ipaaBj18u8s2DXkaFalwp+5CwvnuDPZDh8KYhSTaUcZNAbP6tIy8Zjcuh/P+6Lcjd6Fm
 SbDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw5Swiy5FXgvfHlSoa/B8ofUUi1OUFDLV8H68O2UafzId8MhGKukez4OVS0tY6AnDRCmR1ip+cL7OC@nongnu.org
X-Gm-Message-State: AOJu0Yz7fSf/tNpWmlAKTliEMhRAqwFzexJUsWhVgW7QUBvDs7zlwVsI
 eWQRAF65Swgz6LcrOAZK8IS9haFDDicySZ6vhnADB/dzlBnViwcXNQZBaA==
X-Gm-Gg: ASbGncs5NvpM3BQ2LOXjCpQ5ggRD02QqS+Y8j/jnyrO2WFqyldWzB1E2opuyB/aGZaV
 kILjpJJdn8e0ZGPnxicBIrCTDyH9iA/04eLAY8fyUYJW1oUjWXVrQ/fYqelIKYImYFEf65gVakj
 eTliSR5ntPTvAwzzdtR4FhkFkVacex5MP7rOaZSvJ19eVe1yhuvq/HtpO9tjQAqVu41MkZAfz0m
 ZOQOziMzmlvO8CXyta0DZprFknrw1Zloj0DNy23TdAE9iYUXmcBwZLZ8hXWb9nuh1+X3Kz8W3oP
 uUboNxPvUOAYQcGZv+DERMkMYtzyagxMtDh7CNXzJgnJp+bpme0=
X-Google-Smtp-Source: AGHT+IHz8jP7H2Kwmd1ohVKDKPqm5SoYfmxw2wnZC/XkXJlA4r2ji+xXedVOgfgfvCfOVeEkBrJNNA==
X-Received: by 2002:a17:903:1aaf:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-22de6066eb6mr33913185ad.39.1745907209255; 
 Mon, 28 Apr 2025 23:13:29 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:28 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/13] NOMERGE: virt: Adjust devices so everything is > 4G
Date: Tue, 29 Apr 2025 15:42:22 +0930
Message-ID: <20250429061223.1457166-15-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cd19c266e62a..1162b3a4b71a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -80,27 +80,27 @@ static bool virt_aclint_allowed(void)
 }
 
 static const MemMapEntry virt_memmap[] = {
-    [VIRT_DEBUG] =        {        0x0,         0x100 },
-    [VIRT_MROM] =         {     0x1000,        0xf000 },
-    [VIRT_TEST] =         {   0x100000,        0x1000 },
-    [VIRT_RTC] =          {   0x101000,        0x1000 },
-    [VIRT_CLINT] =        {  0x2000000,       0x10000 },
-    [VIRT_ACLINT_SSWI] =  {  0x2F00000,        0x4000 },
-    [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
-    [VIRT_IOMMU_SYS] =    {  0x3010000,        0x1000 },
-    [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
-    [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
-    [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
-    [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
-    [VIRT_UART0] =        { 0x10000000,         0x100 },
-    [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
-    [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
-    [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
-    [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
-    [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
-    [VIRT_PCIE_ECAM] =    { 0x30000000,    0x10000000 },
-    [VIRT_PCIE_MMIO] =    { 0x40000000,    0x40000000 },
-    [VIRT_DRAM] =         { 0x80000000,           0x0 },
+    [VIRT_DEBUG] =        {        0x0 | BIT(36),         0x100 },
+    [VIRT_MROM] =         {     0x1000 | BIT(36),        0xf000 },
+    [VIRT_TEST] =         {   0x100000 | BIT(36),        0x1000 },
+    [VIRT_RTC] =          {   0x101000 | BIT(36),        0x1000 },
+    [VIRT_CLINT] =        {  0x2000000 | BIT(36),       0x10000 },
+    [VIRT_ACLINT_SSWI] =  {  0x2F00000 | BIT(36),        0x4000 },
+    [VIRT_PCIE_PIO] =     {  0x3000000 | BIT(36),       0x10000 },
+    [VIRT_IOMMU_SYS] =    {  0x3010000 | BIT(36),        0x1000 },
+    [VIRT_PLATFORM_BUS] = {  0x4000000 | BIT(36),     0x2000000 },
+    [VIRT_PLIC] =         {  0xc000000 | BIT(36), VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
+    [VIRT_APLIC_M] =      {  0xc000000 | BIT(36), APLIC_SIZE(VIRT_CPUS_MAX) },
+    [VIRT_APLIC_S] =      {  0xd000000 | BIT(36), APLIC_SIZE(VIRT_CPUS_MAX) },
+    [VIRT_UART0] =        { 0x10000000 | BIT(36),         0x100 },
+    [VIRT_VIRTIO] =       { 0x10001000 | BIT(36),        0x1000 },
+    [VIRT_FW_CFG] =       { 0x10100000 | BIT(36),          0x18 },
+    [VIRT_FLASH] =        { 0x20000000 | BIT(36),     0x4000000 },
+    [VIRT_IMSIC_M] =      { 0x24000000 | BIT(36), VIRT_IMSIC_MAX_SIZE },
+    [VIRT_IMSIC_S] =      { 0x28000000 | BIT(36), VIRT_IMSIC_MAX_SIZE },
+    [VIRT_PCIE_ECAM] =    { 0x30000000 | BIT(36),    0x10000000 },
+    [VIRT_PCIE_MMIO] =    { 0x40000000 | BIT(36),    0x40000000 },
+    [VIRT_DRAM] =         { 0x80000000 | BIT(36),           0x0 },
 };
 
 /* PCIe high mmio is fixed for RV32 */
-- 
2.47.2


