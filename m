Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EC9C3ABC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJaG-0007Zk-Aq; Sun, 11 May 2025 23:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaD-0007Sq-Ax; Sun, 11 May 2025 23:12:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaB-0006nS-IF; Sun, 11 May 2025 23:12:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso1283350b3a.2; 
 Sun, 11 May 2025 20:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019517; x=1747624317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISN7y/vry9bP1IceJzCajBa0/0ofVkz8PXjutvKFblA=;
 b=jQJ8LOjXyqUvzMurtTkst7sgx0hBy7P1OSM1hsnEloQCvCY9sV+ujbwhjplZZcCtHC
 xCkkikkkm4+/AMGI5wYG4XSVb4G3fDX9lQaXxJU6vswu2+obeympa6vszRgtR4ni2xOZ
 db6gShgBpzu7zo1XZNxYIp0ucbrtyJMBRC7cnx7Aj9r8X+694Eduh+1/hgq1/hVwWMvq
 I/CpHQh36rBR+2KufOvByMF4QqM2ar1T9fUQh7RrwRHqvJtIXisA4qrSt75XNwiGuQDB
 uRd87T2vi46MZS6z3t9LH6hNiU4jo+IXTHvCl8a2hMgvsD23VErL07UObbp1JCEzKLfg
 nrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019517; x=1747624317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISN7y/vry9bP1IceJzCajBa0/0ofVkz8PXjutvKFblA=;
 b=N2olph6JpJhRmDnna8pnNgYqbaEmUto6WpugqIx1bf0bTjhRNHcTtKolGAk92Due1C
 L4x54Vx1+RUBPTfChPimx2VBkVgU/FYKkgBYemD7a4dF8RmKbDIRfSR2hXjGtNongV3S
 ScOP3wvADL0KdVAjjK9awjodOarrjyxYZFNXRCJ6in9nYeF20//Y5zcTUsX4jO3ZwZL8
 IpMey67wjDrgbGgKlL+nI0jxyGYgcD694Kq3LV3+uClgOMZN95NfVIVklu8O1Yc974w8
 MmW+46rdnZ1WnTon5qoju1o2Jjafm0aMQCi0DCKYsYEb6nnay6vbIIpk++f2eKIM8mz5
 eFpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPDo2YSeM2CMru0ZqV5SwOV4UMU+SKKXlptGwlH4X4g2cAxY5MnP9hF0j20kcm30tX5Lz++avg05uH@nongnu.org
X-Gm-Message-State: AOJu0Ywc7fMbrL46dkqdJCJVMHOR/aFnr4AlbLsggpPucTW+UL0XZOlN
 6UAUaYp7EYfeAMm4C+3vAEfCJPmZtuQ53krll6v9vccvTHwM6U9HKuxNOA==
X-Gm-Gg: ASbGncv+8tacogEnY9DxshGrVeJNmXljYxX8i/haOpcD7lB9mfdUgTlfJawSbyGCsFB
 c+EmYHfkJQI7vzcpx5QH+J5ifQLAjApa+wFLMqtbS4fNQk26LLJTs7YYCQObhkiEtSGgGMvtabp
 74g8bbQLCLhzt51ab0WvKEsWX8dZz9iRWJSV6A7FwbPt8/llDV4EO4BbSYzGervY+Z/w41tB7Hg
 5SANW9Ld9i0M3nIyAM13YtoZJSmyEIcUqSt0Jf1DMdC+yHbeomJ5pUo9zvmrJ9nqYKcK7hb5oay
 kjN0FLOh3kfuQw9rqilEt3iB7c02PKhqQNSM3OSWOWQnUkPgkoQrXbfkKg==
X-Google-Smtp-Source: AGHT+IGTQ0Hn6bUO6i1Kd+zG/5pZz28WuE083amP3juZJExMz2x6uv55Y8IaJkzFzhC78CdlCnnQiA==
X-Received: by 2002:a05:6a20:e617:b0:206:a9bd:ad7f with SMTP id
 adf61e73a8af0-215ababd7f4mr17314560637.6.1747019517278; 
 Sun, 11 May 2025 20:11:57 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 13/50] ppc/xive: tctx_notify should clear the precluded
 interrupt
Date: Mon, 12 May 2025 13:10:22 +1000
Message-ID: <20250512031100.439842-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

If CPPR is lowered to preclude the pending interrupt, NSR should be
cleared and the qemu_irq should be lowered. This avoids some cases
of supurious interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index cebe409a1a..6293ea4361 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -110,6 +110,9 @@ void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
                                regs[TM_IPB], alt_regs[TM_PIPR],
                                alt_regs[TM_CPPR], alt_regs[TM_NSR]);
         qemu_irq_raise(xive_tctx_output(tctx, ring));
+    } else {
+        alt_regs[TM_NSR] = 0;
+        qemu_irq_lower(xive_tctx_output(tctx, ring));
     }
 }
 
-- 
2.47.1


