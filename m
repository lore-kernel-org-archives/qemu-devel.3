Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386591125865
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OOn-0004ne-BR; Wed, 11 Mar 2026 14:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOl-0004jE-3C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOj-0000jO-CJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:35:10 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ae43042ea7so3061115ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773254107; x=1773858907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNM/dVkkML5tzgLzxAijspCwne80ByQcKUUWMceF6EY=;
 b=jYImN7sJVtlVRQSUwKisn81gxPApIvvzm694SitsegN8XF/SeOdkRZXeXNWFecyvdh
 Ary4kGtRDQ/WdUfCmZT0/4Nl/rbV/ZZVFL8pfRVSLEVC5JxSgO89q9noFhi4Jh5hFnmT
 R5SbJQ6qFl7B3xVhiIDQ2z/CKRvOAZYKS+wiZE7IKqHahnEBN5R+TifW1G6XUEZrICoV
 ZnzXa5EUxhV2Vye1TgNWZ9d64em+ghs7uO7Rq++gcWuA9ombNdFKv0byyptdIOkHhWr+
 z7tsiuT3ngqMzJdCjzGrYzDOsckkFMQU+cjfYKMi68aXaIeEyrgCWG+Yk05cInJIlzkg
 aloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773254107; x=1773858907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RNM/dVkkML5tzgLzxAijspCwne80ByQcKUUWMceF6EY=;
 b=ZxKI2IWlBY2BDKTjR0P3iNhMYSg1H/YKEWwZZIm8NLhcS2zvJzBdvkHGO1bgt3WdmH
 /Rjdh4Y+nF0roaiLZqab8wBZ0Tp5fl458i3Z1mrnc+ERjbIgXGzHoOU2T33r3Z649LbE
 N0PxDv7Cd6IT6o/DymQDC7vYdB1TbdiUx+oZnlPUAYUbeS3PitEp8d3fwX3OrrjAiyDE
 byMmlQmDoSseemLcri0dnQck9N53Cj0qs6af0IQapmxFr1xXB1EhjrNUljbeO5cpn7dP
 G/KzW4PXZzEWePEwrqJMKgVCs3uT/JBkGzj7cgzlSgTYJksuhcXciKoLa1kFD0SfZUt7
 dsfA==
X-Gm-Message-State: AOJu0YykM4tk8mODMTZUxXzFZmqHUiDzUz+vTK7J/7d2J3C7KzWsW5m4
 WHRRvUIAAKVqxrxcuJEx/OIC56vi4W17gFo2Bdri9O9PpAagmyYZL9DxlWa2m4NYHm3mQg==
X-Gm-Gg: ATEYQzw4CmADQwHPgODfq8yriD2emkz8JvlSQhmd0kdgSwfyKhuY0Nz1iWhHlZ0dNqo
 6DjEk4WH27wDWJQ5NcjyNFXHzLhexaUNUlnDRbZKyO+xAWMu4uChgd2QKrYphRlA0C4xgtERzFC
 J7ncy7qVze3AoeoeCHO4Jp0ZKubuZOwwBmNK9Lif+wQeU6YeE50ZXxmNF8OWQukthELqvqyhP20
 tPZwRMWcLW2tdaxU664WWggt+ve44yq59JTDx9z1q286a9JH/1V0G0pSsDu53OzH7HobMHzxAqQ
 tncas2UhDMUNguRiY0qgw8DsBWgJmkLPSquZZAxFcGaA5kgAJLORtmc7sXd4nkGogo77BwjUcu/
 EZhLWZDVL7h9bASrhRAHbJmh4QitqVpHdvP/swVnLnET5GoDNeOfNzjN+l9iUmzHAJ8hMefngNG
 qC0t64raSQboGX9navYy64B28jBCP9/q76u2IA2tIycuSUcQ==
X-Received: by 2002:a17:902:e80b:b0:2ae:80d5:bfa7 with SMTP id
 d9443c01a7336-2aeae76f5famr37277905ad.7.1773254107247; 
 Wed, 11 Mar 2026 11:35:07 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222e2fsm42124115ad.2.2026.03.11.11.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 11:35:06 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 2/4] hw/core/loader: fix error handling for get_image_size
 callers
Date: Thu, 12 Mar 2026 01:34:28 +0700
Message-ID: <20260311183432.214960-3-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311183432.214960-1-viking4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

Check the return value of get_image_size() and report failures
for non-mandatory files such as BIOS or FRU images.

- Use ret < 0 to detect failures in getting image size.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

---
v2:
- Keep error reporting as it is.
- Remove exit on error since it is not mandatory.
---
 hw/ipmi/ipmi_bmc_sim.c | 2 ++
 hw/sparc/leon3.c       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 012e2ee4fe..fd875491f5 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
             g_free(fru->data);
             fru->data = NULL;
         }
+    } else {
+        error_report("Could not get file size '%s'", fru->filename);
     }
 
 out:
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 9147d56bd4..122366829d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -354,6 +354,10 @@ static void leon3_generic_hw_init(MachineState *machine)
     } else {
         bios_size = -1;
     }
+    if (bios_size < 0) {
+        error_report("could not found or failed to get file size: '%s'",
+                     filename);
+    }
 
     if (bios_size > prom_size) {
         error_report("could not load prom '%s': file too big", filename);
-- 
2.43.0


