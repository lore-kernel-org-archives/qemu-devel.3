Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD8ECCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzU9-00033Q-Nt; Mon, 03 Nov 2025 13:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFzU7-00032I-4v
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:40:55 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFzU1-0008T1-3t
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:40:53 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so4749274b3a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 10:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762195247; x=1762800047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PPFTpvP29eV2o4+yOFXgNrhVKIhmznvuYSsfAv1arc=;
 b=YOHRffBmcUFfQe/Yvn0LDeEoQAYjKlJKgGSaKuogY9RT8gGduBa1eUDjKfpNQaVGWb
 zIqhKL0y5hgQdOvBHKgqCRTR3eeb05iIHXzUjLry4pAFIZxpdBB4qHoBDBHUs3KDjnGq
 BgZBkwzrUTSfKfk4WNXLdcVCcrDQsWlDnyZBHMNM/XcS1eQrYLkQDn1y1EzXcc1KEFgG
 P/At4cboZR2Kq3vpQasYuO6IgSRQ1GGIrfiBe11JCLSOubPL+w0oi4rjLeDCn4ay0AnC
 SNyEy6HrWJA16asDoNXop6NCl/aJi7v7jI7nJHxyMaywDItf+V/Bl5fj0yKnBOW2c4EI
 slYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195247; x=1762800047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PPFTpvP29eV2o4+yOFXgNrhVKIhmznvuYSsfAv1arc=;
 b=TD/ktaxt9hleusSMNDeb3uao2alaUGv7+vAuaLUg79/txtb6ROC9mu+NXnYbDu+06G
 PVRWwS2NxYtQwfjMFWSaBT723VcgNbSe2Awf8QKg+pZe8YYKurYwCHyjufVU3DO+PMAb
 KYrWXQmr4Io5RzqmvrRsHNc7sqkGbpmHBmvu82gxZXrLaYzVM0n1TV7eqhwG0AekFoIw
 YVtcToqFc/osMl0I+I0Prc7vh21jEclQkONttlFqP6qIO9LOeLhW/sekTJCKyhFVWA0R
 X9MFs9NlGbq1nis/uiykxkruQFuoizH9Mw2ytlyTiv4icHJMkXBLnDJup/ye53joccSW
 Cfsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbodQDKdtslCUT0BopKyWdmOZ+GgtfO6cTHFzbEGGOnR0czX+aG01Iu4c3Zvh0fvUaJ+0yBJZ5Urqx@nongnu.org
X-Gm-Message-State: AOJu0YycCWEeYLDiULnI8PNntHQHks82Jd+u71Raaqlxfipm0PNlgUKn
 EK/D4F1iae5DCOLr4OrDuww9u8u85DdsHzCQyWONlHJ7Af+QpV0AoZrrzFgcSo+wnPPj9w==
X-Gm-Gg: ASbGncsjvv99/GBTLRbYksYc+MWmKX9bTm+MpSZfrq+p+jCO6RrA4jEoAUY80/911tj
 yWr3ZtI0cgtFWnu2v91r96dDOQizXtmiAufkvhYtS0tND6y8jQWIGogzsC4z781yPUqUytTT3Oj
 XkpR3fwbj50aXn6Puw7JeBkXxR2pQUAT9zTp3Hi2iJFZht1XkdQ6BW55yYNYyicmc5S/WiOP5EQ
 OpYiZ3asqceRIJOzta8G7qTE0JPAj2uvaVe7UEfWRXJu1r/+aduxeBkrUpGyFdRvkay3PtoZuQw
 +gN8PyoGtItTwTxdtBlxW3k3RVcrye65tpqLzKrLtaas4B/IgKo9FZJec8QMRvcWs0rpTjCtnqd
 +lSJJtmJICxQEGctL4sUjixyQair9MIP9WDxMLDj5jzXAajNzCH8T9m3Oqyq/lITi2xja0Ur8ZW
 lOGBnSoNgq9mhLIbwr6RQddPJcG6MnjfHk+oeWsoN+SJRH1iHqzw==
X-Google-Smtp-Source: AGHT+IHd6zsejcK4AP53rLg0JcZIXBH9C3rw/530rwYwuYaFzZq9Czx853gMiDX/ZWWPLaI4e1/Uig==
X-Received: by 2002:a05:6a00:4614:b0:7a2:7f45:5898 with SMTP id
 d2e1a72fcca58-7acbf0ba05bmr521898b3a.3.1762195246459; 
 Mon, 03 Nov 2025 10:40:46 -0800 (PST)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd634081dsm64255b3a.58.2025.11.03.10.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:46 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de, mark.cave-ayland@ilande.co.uk,
 sarkarsoumyajyoti23@gmail.com, peter.maydell@linaro.org,
 zhaoguohan@kylinos.cn, qemu-devel@nongnu.org, stefanha@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v4 2/2] hw/scsi/ncr53c710.c: Fixing Incorrect expression
 (IDENTICAL_BRANCHES)
Date: Tue,  4 Nov 2025 00:10:31 +0530
Message-ID: <20251103184031.22118-3-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
References: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
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

The issue stems from Sync and Async if-else condition.
The same code is executed when the condition "s->waiting != NCR710_WAIT_NONE" is true or false.
Because the code in the if-then branch and after the if statement is identical
So we can remove the unnecessary condition checking for Sync and Async
cases.
As reported by: Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 871f76c2a2..3de264fde9 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1366,11 +1366,6 @@ again:
         case PHASE_DI:
             s->waiting = NCR710_WAIT_DMA;
             ncr710_do_dma(s, 0);
-            if (s->waiting != NCR710_WAIT_NONE) {
-                /* Async - stop and wait */
-                break;
-            }
-            /* Sync - continue execution */
             break;
         case PHASE_CO:
             ncr710_do_command(s);
-- 
2.49.0


