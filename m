Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F066CA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 17:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up9NG-0007Er-Gw; Thu, 21 Aug 2025 13:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1up9NF-0007E3-59
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 13:46:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1up9ND-0003me-C3
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 13:46:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so862380f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755798409; x=1756403209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ou2WNmGRU4pI7jg2sZGzfLbvp3JIANekT3jVlYK4v6w=;
 b=Ob8daiaU6DugtVC9eAK0nk3jFNA3CI9bsl+s2YFwvzH8uWq2mS8nBqq9XCRftgYsC6
 jGYPCyiGr0D6gCcLarqWUxai1ArC4M8tyYFZKYgIk6akrg1lbv27M+hlNw+S/i95uqer
 bPS38SPTS46sY6cv/MMIgZfgZbAOl/XhytD0jTs5TsKOv/sNYrhkMq/eUuHYGx/Byt74
 Ou3IWJbx2Yv4x+ci53TxXMZExhQ19i77MA1ZfGXBAEibqr6qowURbTLFSNqva46BSifY
 a2/8QBoB16KovJ/J/WgUCFI1tKxb9o2E1JI1v/zcYVPL9GCYRFj8o6lBIOYxp/h6YgCF
 adww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755798409; x=1756403209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ou2WNmGRU4pI7jg2sZGzfLbvp3JIANekT3jVlYK4v6w=;
 b=btBIOCcNZgfdCA5Y5tdfIsBLTcB0QEB301VgRzwKXQxNhriOKXmR8UkoHo2YZELdc+
 1m+GD6gfyQhxbyFGE69CAcaIWoJImIRJ/erOCwD65XYgG9RfdT94xWid+n0WDZaDb0+t
 ugdj7ouSNwRvlYBiSIfmR6xMSAMPZEKX/xGgRjUL9e2LYDyKoQor2QiVzrIlkNbt7rCi
 DDacUVYYOEmZv+47dKOUAqsdIoAChqNSpnrHCvm/+yWilT6wAoJziNTuLQbxSx4z4dtr
 /T0Tp2S7Go3yFNA6WLetivQkqQJ7SCYZrletDtvcl8jDKpbtGAgny82w/VYks57mMBAR
 BVNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVBx8ou2enexNBESQo58WfNJsV5VC9/W43gC515c8nYTAX2bMJhF0v0uv6kY1yilmcxKYA1feFJ8DN@nongnu.org
X-Gm-Message-State: AOJu0YxjA9KHDqTDrj1q5SIbptAfyGwJou+M2JTZa/HVAaZ5/Pk3WgVQ
 VA4PmF022Y86GShU66Ktapqq5zW2spn+y1yGVQZ5VzU/iQHw3YmRoEq0
X-Gm-Gg: ASbGnctFgcS9f5vNp84zVvYLYJ8h9PiKD/HK3zh9nVOSO0m13LEHJkhBY1VF2iQLxVQ
 uiod9T7HVHLAH5CPtdksZdbKzYUx4WQOSw/uuZmzF2lq/1c0SyKcXOzjxEOJb7jFtoIIyk4luSg
 vo9Loz1zOizdBAlR7aRx0fC1S7EVtd7kAFjEJ2HTS7KUKtu8XmfSVPplCR/gWRgAV7aeZiDYNy6
 a3LBI6oCPpcQqndEykuE4PrQn46ySHRtdWAFQ0/Hx557+MhzjkfZJa69/gzmDdZ8y2y1z9iDqpK
 8xujt4y4Ma+t7psouH2sT727tZoNnbdTW11kLNv4XzE4+QD/fnBDSbkLbf9pLXcgxA+ldbQ3leZ
 I5I0CZkfMFmOrFjsQ5tj8kC6F99vez3YXFoTvZfAZYo7o6qwu/PaUMIvzHgw9Mky+6PaVUnFyCi
 E=
X-Google-Smtp-Source: AGHT+IHXwSonZhHY2rvnSb8PNEHQI7YTbATyMM6KEMsCPaQHeQ9ZMf90jSVz0H0vL+XvaLb90dH1VQ==
X-Received: by 2002:a5d:6381:0:b0:3b8:f8e6:867b with SMTP id
 ffacd0b85a97d-3c496f92c82mr2195541f8f.31.1755798409309; 
 Thu, 21 Aug 2025 10:46:49 -0700 (PDT)
Received: from localhost.localdomain (46-116-237-160.bb.netvision.net.il.
 [46.116.237.160]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879f5fsm12485360f8f.4.2025.08.21.10.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 10:46:48 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] hw/acpi: Increase the number of possible ACPI
 interrupts
Date: Thu, 21 Aug 2025 20:45:49 +0300
Message-ID: <20250821174554.40607-2-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821174554.40607-1-lb.workbox@gmail.com>
References: <20250821174554.40607-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=lb.workbox@gmail.com; helo=mail-wr1-x435.google.com
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

Increase the number of possible ACPI interrupts from 8, to the maximum
available: 64 by default.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 hw/acpi/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 58f8964e13..447ff07878 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -729,19 +729,32 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
                          AcpiEventStatusBits status)
 {
-    ar->gpe.sts[0] |= status;
+    int i;
+
+    AcpiEventStatusBits st = status;
+    for (i = 0; i < ar->gpe.len / 2; i++) {
+        ar->gpe.sts[i] |= st;
+        st >>= (sizeof(ar->gpe.sts[0]) * CHAR_BIT);
+    }
+
     acpi_update_sci(ar, irq);
 }
 
 void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
 {
     int sci_level, pm1a_sts;
+    uint64_t gpe_sci = 0;
+    int i;
 
     pm1a_sts = acpi_pm1_evt_get_sts(regs);
 
+    for (i = 0; i < regs->gpe.len / 2; i++) {
+        gpe_sci |= (regs->gpe.sts[i] & regs->gpe.en[i]);
+    }
+
     sci_level = ((pm1a_sts &
                   regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) != 0) ||
-                ((regs->gpe.sts[0] & regs->gpe.en[0]) != 0);
+                (gpe_sci != 0);
 
     qemu_set_irq(irq, sci_level);
 
-- 
2.50.1


