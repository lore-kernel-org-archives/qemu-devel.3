Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1803EC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2xM-0006h7-3R; Mon, 17 Mar 2025 01:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xK-0006gB-87; Mon, 17 Mar 2025 01:24:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xI-0007o5-L7; Mon, 17 Mar 2025 01:24:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223a7065ff8so26316685ad.0; 
 Sun, 16 Mar 2025 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742189042; x=1742793842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkPaY1ymYYgtxcx8c4vM0EvVZxyRLrUg4YxSDzdPJ34=;
 b=btVGsgSmIwrBgs3ElJmrXDRRqQvVWb5pM5LluIWPvLbusBmhfajfo3LGOk7j1xdO2H
 KiMzwo/Em4MIpm7X7NSIDZlUUbRN0cwz1QzsMJX0uMJ6sXLTxDgwmYuFpH3kPnzOFwUv
 Pl1R8mBktk4ZldzporWITXDX+ox0TYV2KacH1m1Ud08tvicBBHObzlITzR9x/+cla4BC
 dnG/4XSkmFiL+X32JviC6Fm+o06bTxSDy/I9NZ4dQnAkR5tfcZhgwKLWMxjRRtUBoYaT
 FtbqK0GjPEkJFuHrXzanGbRRf+o8uOja/OwdRq80FOFcef3mX8jQL3O+1L2Tfqkmz+LZ
 yn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742189042; x=1742793842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkPaY1ymYYgtxcx8c4vM0EvVZxyRLrUg4YxSDzdPJ34=;
 b=HBvFhmlH1cKaW2Irax5H/dzoE+1mPHglJ525vik5uciblEVmwa8R/XH4Zr8ao6WnsA
 fu+kPVbJeYGmA97CkH2MVV7I1vlkWiom4XLZqWglTdrFTTIIO+evZvwlM5YWU3ibb+Np
 HJJS7Z5woWUbiKSIZJ2l5yP53aVkQK2Vf8PQP1Oqz1SqFYYpY/tZmlYd/R6Zhmj57wkH
 a0w/pJ4CzvfZBBHtzbusIA6eeFqQhCQFuBRkl9SREMpjsE1LF8ZvCzT+Dp7NfekSWEXZ
 1Cw7eOy4j5jwb2qjTf/QfDum4ESRdrO62q6eUEfeTWPNkB70wK57W7saPHDWImV5IrhU
 m7sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxL5+PNpYnRbUQrWjBHHlZe2NJXUI7bqybhHUQ0lfdUjPipgzs9glH8Qd0aXLSuVkXZZuotpG9+Q==@nongnu.org
X-Gm-Message-State: AOJu0YzjQrXv0HP5gGoqIRgBwsTqrCH9Qwo6NaqzyyZv5Dd0GRHmOFvW
 jDqaoS6xyuLy3nmpGvELHFwa4cKx6OoiYZRDkwY/TMYODMdOOaAdpZbfkg==
X-Gm-Gg: ASbGncubscPy0uBcmRHn/0Q5a1dUQJ1a3Qb3/tjr4Nh77CQe26NfHVvWA4X46oyW78j
 HLSoRmiSTPUF4H34Vt5tB6jJXmV0ygxms6/gvYkYXP6lswcgU1o4fq2K4UzqgiORZZoPbv1np9A
 D+gAbi5jk9UDqq9k57NR0RWwDwFtYDHp6EljPatwITsIO7nhRvLu2GWrqA/sYufdzZOfqAm1CX7
 s8RD7Hb/71m9qlp4Q76vMkp/e6PmtpuudTi8q8YgiMd1uFvi9qgO8xJmM1a5cD7UCMTLWaTobJc
 D3E0ffswgqaftSA5tBokBrsZrIWHfRDUJ0iqfCPWhk7Y5sx1yw==
X-Google-Smtp-Source: AGHT+IGp5wvGM6WpWDTIDW43gLrf+bawLzKgIakpCyz2nXIT2c2cSKlPxSDkYg1/Tb9e78mO22LDtQ==
X-Received: by 2002:a05:6a00:228e:b0:735:d89c:4b8e with SMTP id
 d2e1a72fcca58-7372236c644mr11966743b3a.5.1742189042351; 
 Sun, 16 Mar 2025 22:24:02 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm6879495b3a.148.2025.03.16.22.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:24:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/6] ppc/spapr: Fix possible pa_features memory overflow
Date: Mon, 17 Mar 2025 15:23:36 +1000
Message-ID: <20250317052339.1108322-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317052339.1108322-1-npiggin@gmail.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

Coverity reports a possible memory overflow in spapr_dt_pa_features().
This should not be a true bug since DAWR1 cap is only be true for
CPU_POWERPC_LOGICAL_3_10. Add an assertion to ensure any bug there is
caught.

Resolves: Coverity CID 1593722
Fixes: 5f361ea187ba ("ppc: spapr: Enable 2nd DAWR on Power10 pSeries machine")
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a415e51d077..9865d7147ff 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -296,6 +296,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         pa_features[40 + 2] &= ~0x80; /* Radix MMU */
     }
     if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
+        g_assert(pa_size > 66);
         pa_features[66] |= 0x80;
     }
 
-- 
2.47.1


