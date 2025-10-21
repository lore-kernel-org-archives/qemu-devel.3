Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD12CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEj3-00013k-1x; Tue, 21 Oct 2025 11:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEiq-0000xs-3J
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEin-0007mr-7r
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:27 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-782a77b5ec7so5346473b3a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761062181; x=1761666981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAFt0XM3JNUMXpzfgz5nUHYjB7++JZQOscrYhRrmG8U=;
 b=L+qNtrM2Orv3H6mWBbuZxCn0OM60ElmUZ9y0VDJMW4oxAJYhpqIQGUy6g4R1FMR3Zu
 E7Jx6B5NKyYW18W8rtNF+iWm4NKt9+yqfq912HMPNH5PGfOinQ9ElCGaAhQNJsbfQwX/
 qSJiLbpasCS/2Zt6lnLQ+gfBZy+lPc/kjJaH6G4fIutSCL3DahTTt6UdGdd7qS2cFzak
 /2/6+6JYQReLobqcEF8mh+L5lt/SBK9cLH8V5eTI8eMEl7ikqSfHm2JV35T9S9WB/X7Q
 Xe8gFB/btfdtiPvV/r11AkrSfJEEGHWWujTpSD8aUykHVejiWastG/Uo0T7ZsLKpNCIL
 mCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062181; x=1761666981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAFt0XM3JNUMXpzfgz5nUHYjB7++JZQOscrYhRrmG8U=;
 b=FTx21lDG5s4dIwqORALcrqwVkGZZUM91xekEuwaBNOfxyMb2npvbZe7lIBtFGAD38n
 zYyzdbL1pVaaw5VraqLGbBFXnzc7oCBVQ07xuxGlwxHkTk0s+IAIDtNV7I6sZK5mviCL
 UiciTnstfr1Ikfcdq8uY7TgctthRld5hMZUhJwKafbnE6XPidNpZqc7jrZHZ/kXw9GZu
 sBV0G3RhMqd3MJwrOYfP77myGNpcH7HXV9lvKIT5uzsy8+LT5R6kKkVSVlH0Azt4Vx19
 VWlHjXzwri3AQo7grXq3vUv5EviGGBoUxCTIXkQHRTo08e/nLPXSjfgsaaE46DfSMs9b
 ehiA==
X-Gm-Message-State: AOJu0YzwT/L0/TO5yH5fqCwDhpnLt5vPH12NW+Yxlw+jS5arZUxtHty/
 ehzs9Qdqky4VXDwRjD36zMMZ/64hwRlpX51WPjv0/7+vBChA4dlFc4OKtvV/MvhBO6/ScsHegVO
 Hd7k7zFlX8Sv7IUEk3Kc3OktRNFflfJyL7J0y19dym2ukKfRZs01+K8zktjU/AixFzvDld1HZa+
 IlZsDpZdky1KGWVpkAgo6NGzbp5AVnsH6dPZxaLw==
X-Gm-Gg: ASbGncuxnU0N+WSVif5qp3pCm6+y8CJRFkE6/qqO1fZLHutXZP0yElEbS39l2WwrVc7
 q0WaZAix8Cs10Z+kK9X0cfnUts0IqEr+9j0jd8VDSFRJw/tGsfDcOzAaDduQVt4xxoFLyGtQR3O
 28Jflag+Wsjl8NQTMUovufiieK/YdI4nI9blhJ9j677RSlrqS7vu0zBHJF0/7bETWo9Guj0hHSx
 HC+izJ0ZyJUzxRlVjKVPLwp/VtuVDuOhD4Ibv7gGmrdXsaORsiDVmfWjevOWZIi+ssLF7RBymRJ
 c4294l7/1vNRXzUiLb0zxiz1/9aowgPsjLv6t4E0S0DjUnGubjrOxM7QNikbuBzRQgIXQ+MsCVd
 nSZs915VnH/DRexOwBX/M83t2QPPkPgrOna78IU4SHAKHpH83ylM1OD0X55dnZYfZWlVsdl1qq1
 7CPXFnGKoYfB8tungjg3WMPRlXVYfVL7yT
X-Google-Smtp-Source: AGHT+IG/Ymu0La9V/H/4kILD0yf/r9Yxm6kvaeqrFGmFr0ifIN+gAOunrqLzWFFlHpmxgvl8/uHWHw==
X-Received: by 2002:a17:90b:2d8f:b0:339:f09b:d36f with SMTP id
 98e67ed59e1d1-33bcf8f8ca4mr21616673a91.28.1761062181172; 
 Tue, 21 Oct 2025 08:56:21 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de11392sm11490177a91.7.2025.10.21.08.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:56:20 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 04/18] exec: Add RISC-V WorldGuard WID to MemTxAttrs
Date: Tue, 21 Oct 2025 23:55:34 +0800
Message-ID: <20251021155548.584543-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

RISC-V WorldGuard will add 5-bit world_id (WID) to the each memory
transaction on the bus. The wgChecker in front of RAM or peripherals
MMIO could do the access control based on the WID. It is similar to ARM
TrustZone NS bit, but the WID is 5-bit.

The common implementation of WID is AXI4 AxUSER signal.

Since the '_reserved*' fields in MemTxAttr are for padding the struct
to be 8-byte [1], we change the reserved fields from 3 to 2 bytes when
adding 5-bit world_id field.

[1] Commit 5014e33b1e00d330f13df33c09a3932ac88f8d94
    Link: https://lore.kernel.org/r/20250121151322.171832-2-zhao1.liu@intel.com

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 include/exec/memattrs.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 52ee955249..6bde90d482 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -57,6 +57,11 @@ typedef struct MemTxAttrs {
     /* PCI - IOMMU operations, see PCIAddressType */
     unsigned int address_type:1;
 
+    /*
+     * RISC-V WorldGuard: the 5-bit WID field of memory access.
+     */
+    unsigned int world_id:5;
+
     /*
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
@@ -66,8 +71,7 @@ typedef struct MemTxAttrs {
      */
     bool unspecified;
 
-    uint8_t _reserved1;
-    uint16_t _reserved2;
+    uint16_t _reserved1;
 } MemTxAttrs;
 
 QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
-- 
2.43.0


