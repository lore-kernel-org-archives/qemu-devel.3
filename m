Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4753BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEhx-0006B1-Gp; Mon, 31 Mar 2025 08:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEhu-0006Aa-Mg
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEhs-00016c-EV
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:38 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22928d629faso47219305ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743425855; x=1744030655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+8G6QG2KcKfe4Jxyy4G71CERtkbNrZFpS5S8YYW90w=;
 b=TnEeMAt1jH2M/ArICfmZ+DZsyEINkN5va/3DXuZy7dljjS1yp5G0uukNN8AxSJgPEf
 5iNUhNyauupbMvTkk3AsplbDuG7UswT4UBz0ISKIA3PTIs9uk541Hhaa+BtOEST1BVMy
 FIb0fCF7skDAggGzVtRgriuhPtASmRKT+bkmBBONrldY7Y/dVn16KhUsChCj69OKHXra
 5+yQvtGeSgVLWFQqZ0yKSFpW442toY4qJHtnEv4VNEyAlXitbHS872xd0/PckdYCdYR6
 8NDM2Y/fadg1j+JYZM8QJp6C16n+KkjGMB4ZO7zFO71hQ6eqbNaFn+zT/FYjrk+G1A0L
 r9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743425855; x=1744030655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+8G6QG2KcKfe4Jxyy4G71CERtkbNrZFpS5S8YYW90w=;
 b=cRf1ZPB6oN4UOBh9GBR2mVpjtn8rS9Wqj+iyv9HhlnhWTeHkLX2th8EnKAN2gqjT+L
 7z5yKUJW+SZLeHdOhTPZ4tePP5311HZ3r0chiBpNwlybw7YwrRlAI468TbWKRurbvDUu
 IRscR/b4CTQSTAtUs+Iwot0G24+nQrzmqWXWNeJ+lpfVJ3ML9HiqjZAWatfZbxfttQ/a
 /By+vccKMUwAcpVNt2VeDhzQU33dF4sS1+wTYXzzClbkKng0Cfwz4cVWHfevQRuBuLVk
 B99XXfM4yFzyWG1mOSaAvuizWh/b+V2rj/NMxTeWR3jXTSP9v3j9EVo5OZlb6Nt49utx
 GJgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2IOC/5KHZpIiTt99O+LBuow+Os/Ewr25SIyZ/qA+oRb4t++73bZZeRZc58z3s0ti58oHSKkjTRqQW@nongnu.org
X-Gm-Message-State: AOJu0Yw190KnqrJg/WPoFhTROf2QC2L5sZrWEMyImN9sAMvA6oh7/qcW
 2x/opYzxSHd8zvkuFIUI5olXje9IWHQ+52ZVYOMaEWP+mnFiqfnX0hPCkg==
X-Gm-Gg: ASbGncuEScz1H5wY47YCWR9b33SXWJRjqHPXZQ26VkRlTjTjzDVwRQMPZVEx/lkupOW
 HotQFUrlrj/P3vHHNzgVnNfviqukIr3KPWU4EW+xg2kLVkkRii+Oh3FQQG4BK4xOTKTPxAoLwWH
 ZSYZ1BgCska571xgOI5ktS5S6gZE9vP42WsNaSC4Xyk2IIhoM7sVKxEpYGUwmYKk93ovwt9A41O
 nsFOllAAvnwleS6g2ZqEeVZgThvm5G+8VxJ6onjcC04dH75IXFNEBfs7vdfaSwQ4YdQF9W8YgTS
 pCxs0fLM2+WpasUVQhpEkrbAmZ4zBSGOcOYbWUKHbmOUyXE2gw==
X-Google-Smtp-Source: AGHT+IEtJLtRKMgBXEu4HFwWQY9Dv2aCOe6oJKCc+98g+YEb/YVF1EKfZC4wa9rDVMBw8/txht2OkA==
X-Received: by 2002:a05:6a20:9f89:b0:1fe:5921:44f2 with SMTP id
 adf61e73a8af0-2009f632357mr13078934637.20.1743425854977; 
 Mon, 31 Mar 2025 05:57:34 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b67dc0fsm6324016a12.16.2025.03.31.05.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:57:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] ipmi/bmc-sim: implement watchdog dont log flag
Date: Mon, 31 Mar 2025 22:57:22 +1000
Message-ID: <20250331125724.607355-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331125724.607355-1-npiggin@gmail.com>
References: <20250331125724.607355-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

If the dont-log flag is set in the 'timer use' field for the
'set watchdog' command, a watchdog timeout will not get logged as
a timer use expiration.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6157ac71201..32161044c0b 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -733,7 +733,12 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
 
  do_full_expiry:
     ibs->watchdog_running = 0; /* Stop the watchdog on a timeout */
-    ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
+
+    /* Log the expiry if the don't log bit is clear */
+    if (!IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs)) {
+        ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
+    }
+
     switch (IPMI_BMC_WATCHDOG_GET_ACTION(ibs)) {
     case IPMI_BMC_WATCHDOG_ACTION_NONE:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 0, 1,
-- 
2.47.1


