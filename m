Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D60C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCs-0002ay-AQ; Tue, 11 Mar 2025 08:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCp-0002Me-LP; Tue, 11 Mar 2025 08:59:35 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCm-0007zb-UQ; Tue, 11 Mar 2025 08:59:35 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so9002926a91.2; 
 Tue, 11 Mar 2025 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697971; x=1742302771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8Jod93+icdv8DpO8jgqQJRsTJBpt3ebVNZMdW9CDpM=;
 b=FOqGKn5ZTMB6LtxA2elPNehgwIwZ2DKVFlrxF0MLK3ytnJt2pZxQWwhkfM2ddicQck
 +/UgyRtnuWiuxUTdAZxaWPDSjsAzZyo3j8FetMS8N/HQcGF3r8YrtFFvCY4HrawQS+oP
 pzf30hhmy1k0NU/VLcfyUXk+0SI/iJRAyIaHl/My9kJoaZhDiXq+vCtc+UQS9UgggCQp
 FxLLtpf4jy0JM6IpLl5AaKkM3HFIfh4bGkK1osHQGmcCg//pWmnZzFOTXDY8KZ2yjuGr
 PGPsYXyF5eAoL8oNfxbQJ6SR17+iY3hzi0fEE2gmCYXg1nBmEdq9+GMCQIa8dW3mVXXn
 NLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697971; x=1742302771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8Jod93+icdv8DpO8jgqQJRsTJBpt3ebVNZMdW9CDpM=;
 b=MnRRUATcCz1WwXMlZimADK3xuPQeV7a69kIHhZ1btvxJ/AJdqrKMCcRtqAt7CqwqE5
 WH8bUctId4rjyR3FVp6VNbfqKxE01mMeDebd1RoQRR/Hw+fBK+zm1R2m332l19F1sNOs
 G0wQH313+sEtanXvyGtCnf5/nCaEDW3TisYrtNJ/SV/3MO4UFWihUqgHILhCgya4+UC1
 1z+Sid8Nn4fKdIbhxEh6icRKBtm1Wf/6UTMQeHzrDxSod4U14AQUEMNPr7A6XtzKDE6w
 NlhX8wAbJHw3k0yAmlutar4JBmjylkDP9EbmOaJG1nSDlQ8hCgYdROzcA05enFm+xC/j
 +HZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNbDdxa/PpPCemZWrBSFlkkMkN9bYfvMC6Ynr+V13DEnl1I29ZwMvwYos8RP6m5KJ9PbLEwm/RLA==@nongnu.org
X-Gm-Message-State: AOJu0Yw9qB3eP02wEqgCN9n5d1ze1G4TC4xVDn1HPtn1VjPcqF+2w4sZ
 KTT1ur3Pr+mFKFHtyc1YgtnfhlQY+mhKbKRMOhpX/WkVj9OlsWzAFMk8Cg==
X-Gm-Gg: ASbGnctwd8dpVsU7yBofkZJEcSjJfM7sQdVUTkfn+JVTQ9Os9fQkicCcuzYCRHiXQmh
 GptwbUg+Vl1LoUjRjDWupq15avtcyooWybCtz/mXipIuU38YU0Hpeg8CwYj8tlzbb/HEU7AkFbT
 7IHHT3KQmcfvfanzrR0rPWWWiCYptv8jT3GhhTBe0XDcSVzlshD+VphBmelmxfAJdv3CA/99uwL
 N8PKLNsS9/qFB9/1egc32Zgw+fzNMzP/QPVrJlXAu56qhEyf0/VNCSu5TRDu9WuP4xNeTGpOkBm
 QCdrtyOgvJw5Gju1Qo6019pmqLsuI4/zm+7EjSUymJn7g3Why2o=
X-Google-Smtp-Source: AGHT+IFai/yXZpdJFENUX4ZlQiWu7uBV1XuOa5w5Wuj2R2Iud8fxrRxjN9JaeR87R9XhpZ+WRNJ6OA==
X-Received: by 2002:a17:90a:d44c:b0:2ff:6488:e026 with SMTP id
 98e67ed59e1d1-2ff7cf26d18mr24494146a91.30.1741697970645; 
 Tue, 11 Mar 2025 05:59:30 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 20/72] ppc/pnv: Move PNOR to offset 0 in the ISA FW space
Date: Tue, 11 Mar 2025 22:57:14 +1000
Message-ID: <20250311125815.903177-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

skiboot has a bug that does not handle ISA FW access correctly for IDSEL
devices > 0, and the current PNOR default address and size puts 64MB in
device 0 and 64MB in device 1, which causes skiboot to hit this bug and
breaks PNOR accesses.

Move the PNOR address down to 0 for now, so a 256MB PNOR can be accessed
via device 0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_pnor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index 2e37ac88bf..19c2d642e8 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -13,9 +13,11 @@
 #include "hw/sysbus.h"
 
 /*
- * PNOR offset on the LPC FW address space
+ * PNOR offset on the LPC FW address space. For now this should be 0 because
+ * skiboot 7.1 has a bug where IDSEL > 0 (LPC FW address > 256MB) access is
+ * not performed correctly.
  */
-#define PNOR_SPI_OFFSET         0x0c000000UL
+#define PNOR_SPI_OFFSET         0x00000000UL
 
 #define TYPE_PNV_PNOR  "pnv-pnor"
 OBJECT_DECLARE_SIMPLE_TYPE(PnvPnor, PNV_PNOR)
-- 
2.47.1


