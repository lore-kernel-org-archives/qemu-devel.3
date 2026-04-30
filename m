Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729BFCD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7b-0006Pf-FU; Thu, 30 Apr 2026 13:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7T-0005v5-Pe
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7S-0004oA-7V
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Sxy4IfqrTJDQwmLrBFdy0PFZDId0Axm5A2Zset0dYk=;
 b=VGiSYMZVmHfnKdO6pimz7MuRBhtWypsUEk4U4stYUVHOjwrAwwfKNp4cBwLA4BBsbyja7M
 1YV3WOoAvMN61REWGSMsToxrafY/G3br45d7u7/sXhJnzZUlW4R93vNk/syk52PqTdRndj
 J112gptJMdYCF4Z30ZC4fAjAtRYvuKw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-UsnnnB6yN3i4GEiaikY9_Q-1; Thu, 30 Apr 2026 13:24:08 -0400
X-MC-Unique: UsnnnB6yN3i4GEiaikY9_Q-1
X-Mimecast-MFC-AGG-ID: UsnnnB6yN3i4GEiaikY9_Q_1777569848
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b49424ad88so14851976d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569846; x=1778174646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Sxy4IfqrTJDQwmLrBFdy0PFZDId0Axm5A2Zset0dYk=;
 b=jnnydPUTJBikYCRd04W/S+VKl94Em3vDuk72R1dtpPh4TOgKq3go7pQm37sFnnNML9
 rtfrMqTsp+ICXSKE0oR1PZXB2fG9sq9bNdrVAiFUqEOJzlBpMBe8BzH3yRNr7y0rFmX+
 3DQQlE5ZoWDtYP4PO5V53IJsPH0Qb2qt9EMn8c0vraMvOPAGfnCZFqhPQewXnpG+I+EJ
 aJkJ2mfKFqHWUKxplRMHzdz5SRi9PCmW3j1Mw8cd1vliCAT7l9oQeVvBWCl3vyBOMBdg
 QFphuGF1sEpA+bRyC8i/Xfb+W0oMApSXLcYs9dDvKr3bfcE0hLIuRWJ8HiLkJZDE7Qjp
 bDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569846; x=1778174646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Sxy4IfqrTJDQwmLrBFdy0PFZDId0Axm5A2Zset0dYk=;
 b=sgyNdCEZSukJxGumAxMG/oMNH8zLHEevJQh0iAwwVX6gQcqDKROk0N3nR/1m8VrPKj
 TMJqWKf8YJw7EzENYZy81bfKfDzitcnVacOx8Qoyac1q/BHVEwegD/Nb84ylYqiREyu2
 5zDrUOrhabLwJ4i2SQxXqp65/25Xeb+P3Cx9P/W5091fZPI0htvt4fwphK1BYB4rWKsk
 tJ+YViGwRJLMtQu40JNGr+JpLYcJOJ31/4ZG02RpNYKpWUuhnS/3Q3+tM9tKtQTuUXZe
 KF7Y3F3HyrRDk9RYo+VGvKI+176Qt+jviN4mmqcXUwKcjChHYcCqF0iwEICgFFrwqZP0
 IEdQ==
X-Gm-Message-State: AOJu0YyKz7yQK58PRAu2vDkDODPdzS1H2CZJ6pEyEAJY920KUTPZim9M
 XlXfwLWrpUYDdmDgLzN7GWmTLiintdQRj8wh9mkTbqif+4cw2wSNAp1DfHgb/DDf0jprYRo33s3
 1WEL7GeKDn07ljjmRRMiSVTBoCLxJ7GHDIt7yIOLZFGE+y2bpwolLRo2AtzVX/2JZN3saCSVYDd
 P08wvjbdsvVWWQzAncnnjODk/kial6XFbzbzzL2Y9Z
X-Gm-Gg: AeBDiet4FYNGVVBdfeP7P+HPM5m3whRvEmu2EAbX9NqGoQBPniw7fafShvirG1pcnBR
 0J8SU7fudz7Z1GMJHfDQmlFMBug0pGP3XSRNlotyXdbhdl3Md62xxmo1fzMjuIZmZU9dRYpdeqm
 Nd4PL2FP5HKnE34LC8hRHoW1gqTurzvY8jf2Bl8tOyH93WY+4hh44jB4+MT4RxZ07SsrV2ZJzNK
 ytIGoSa0OViC+NUSUGbCnL93bQgQDIrbHhpbZrLBW9uJDsNHz8jiYKgamYlq4ibRot8Y6qohzZu
 D8QcB89anIZp9BLdtIZzliElSr3yx5mXAmJ8zlUzw5fpAdMv+YRZKKrlzMP0sgT6hJREM/5rE/a
 oVRJkjzoyBueqxJTM+xF3ugM4XA5i/kRouVi08RI5bGeR85trZbKwrruoCSN4SNPuEQbP5sOGY+
 Db11OxfIDskg6+C0lmaWqXQppm3Y72yAPR2iw=
X-Received: by 2002:a05:6214:766:b0:89a:9ef:1922 with SMTP id
 6a1803df08f44-8b3fecd8d5dmr60619436d6.40.1777569846401; 
 Thu, 30 Apr 2026 10:24:06 -0700 (PDT)
X-Received: by 2002:a05:6214:766:b0:89a:9ef:1922 with SMTP id
 6a1803df08f44-8b3fecd8d5dmr60618826d6.40.1777569845961; 
 Thu, 30 Apr 2026 10:24:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff43aa8asm25411126d6.30.2026.04.30.10.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 38/58] whpx: i386: set apicbase value only on success
Date: Thu, 30 Apr 2026 19:21:44 +0200
Message-ID: <20260430172204.1006673-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-17-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b0556445801..3426811c482 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2086,8 +2086,9 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    } else {
+                        whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
-                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                 }
             }
 
-- 
2.54.0


