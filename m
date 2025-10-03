Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE52CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTE-000799-MY; Thu, 02 Oct 2025 23:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTC-00077d-2M
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WT7-0001FC-Ll
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7811a5ec5b6so2299532b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462101; x=1760066901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmlTMGL89aspc2tklgzVhhV32vk6hh7OAN16dHETuH0=;
 b=gEaK6OHTnd+X0LVC5gf6cL767b01FgNCyRqwSo8LTFLWr4qwSnHDudLcOgHWVZ79Pt
 nS76Ws2ty6+wX3jryVXbSRQHABV7jYnvck0vQMQ6zXvrpWJu5rYgbotk2dufaTknp/qY
 x1n+vH9rL97+EGOVQJz3ZrUP5pXpIkHGQ2nWx/cHkNvMEcrJ1w0v2qUst9KXchDAQZJX
 UvzWr+nRQWflnErZYXaNLHZc7qR8ERBYgJDyevRmmT/Ek8iDHVRabkv6MDgLdS+hnZLG
 UOFFiZUBYUj5qYmniij4+ghj4nILcRcjdLqiW2gWmZUyb9dQD1eyCD6lOhWYdh+AY6zx
 FWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462101; x=1760066901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmlTMGL89aspc2tklgzVhhV32vk6hh7OAN16dHETuH0=;
 b=MNt/YSUe7O6WSSFV/sv+ozGNYl819Q8sM7zM3Abfnxkv0ATmW3h915y+ilgpb+9KU8
 9krmETQlpOTqxBsLzjG9hdkVGpqy/aOANUwATLAGlzY9Oct5CxEm96mykKFZbUSRR8er
 LGdzUDhEkzB7DvNeArIgRTRE9SviSfsmU8p2p6yPMLq/TyKXUTsBnDqNrIYJZ92xXNLk
 fJgUKRp7BYn2p8ib91eLMwMga8ittzN74gmuXQHUOM5UH/LsiEm1x0q0uOsZ3+/pMGGw
 8cmS+SmEa1gSZJ7VrtB4T75tsAqDg7Z7TOjdAR1wG9KH37gbXWOW4NMl/txE/yPjIAnr
 IkBA==
X-Gm-Message-State: AOJu0YwkV7SgT7LKuZdrQXsQkL1A3ysjt6DP2DFaF2amp0mQqWMFhW76
 pr0TjvpA/mxpQyw42rPnSOMKTRWNSr7uoRA+HH8UnbaAsxKIVtnSEvQm3v3pWA==
X-Gm-Gg: ASbGncvJr8J3E0RoUpD/Wnlaa8SnmEWfKHXDqYBNimwVIetyKdlTm4EP6eM1JR+aQyF
 OK3J9AVgJbTv+jpKVVnyHiX9Y121XRVTyDeWvcmoxS7Msjptc7Y9rDlVXivE+DXfE2qKm8r7Dfk
 aSukl2cHXVMxOS1NeorFWemJstMOEf9yEvRCyLdsCAzR8pPg8GfLKBkjSFS8GzvXZ041G40OFsq
 EkGe/L8JE3cDMpqgUyJFIjky7HjNykg8QSACOeWyEJ0BDgyfGNH5cKg4zK2hbDRyIPitJbPeFPd
 av3f5iX7N6pFTnMb2J4ydUT0UW6ZxzBgNxvWZRd08+UswopNZWSt32D40qAru4r8XZ77+ismoOo
 XLwiDlDV2cAwkqcCHJXIqk2T3osyiDOFxokRDKFyQOj9WVPSuXjtQYB7ilW2tTz+C0C83SBg2jo
 AecTGRBqgFiMmfyaLi+tNcSIQM8sSJ4plsIE82f/8rTLkbTkwgzm3L
X-Google-Smtp-Source: AGHT+IGBMR4mXTu+hlV6iw1FWz8/WIqXoBjtfplG1zn+CltN/LnzrSY+tCw4H6oi/JJIH0JEuAM+KQ==
X-Received: by 2002:a05:6a21:998b:b0:240:1e4a:64cc with SMTP id
 adf61e73a8af0-32a1f7276e2mr7975747637.12.1759462100960; 
 Thu, 02 Oct 2025 20:28:20 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/26] target/riscv: Save stimer and vstimer in CPU vmstate
Date: Fri,  3 Oct 2025 13:27:05 +1000
Message-ID: <20251003032718.1324734-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

vmstate_riscv_cpu was missing env.stimer and env.vstimer.
Without migrating these QEMUTimer fields, active S/VS-mode
timer events are lost after snapshot or migration.

Add VMSTATE_TIMER_PTR() entries to save and restore them.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911-timers-v3-4-60508f640050@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1600ec44f0..51e0567ed3 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -400,6 +400,30 @@ static const VMStateDescription vmstate_ssp = {
     }
 };
 
+static bool sstc_timer_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    if (!cpu->cfg.ext_sstc) {
+        return false;
+    }
+
+    return env->stimer != NULL || env->vstimer != NULL;
+}
+
+static const VMStateDescription vmstate_sstc = {
+    .name = "cpu/timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sstc_timer_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(env.stimer, RISCVCPU),
+        VMSTATE_TIMER_PTR(env.vstimer, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
@@ -476,6 +500,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_elp,
         &vmstate_ssp,
         &vmstate_ctr,
+        &vmstate_sstc,
         NULL
     }
 };
-- 
2.51.0


