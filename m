Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F5FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOA-0006ys-J0; Fri, 04 Jul 2025 07:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMW-0002wh-84
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMR-0003xN-Ts
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2352400344aso8740815ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627622; x=1752232422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3FSXIvxye2ScqCnAEqXzSP6Tfx4AgfCRRJWGmS/vDw=;
 b=IilL+ypPmZHXiO+jgfr5QswjYsOUk8jYiT4Od/4mYhFVCWLeQH9LcAI9H1pzg5PngM
 CMXf699p6qBU2DiW3L84rAIHYKJ/pXFCXED2t1MK6A7BEfWbKATMlFCF8XfJnU2E5Z7r
 ciLJVUl7WkXgTeymD6Qff/QbGCoV/yn/b315Y1UZyslGY005HefU7tRP9KMwPvoPRTlb
 lBvmqfN0vnrq0ZIZ3rLJtup/XrhsmmPm3VeHbDC4y9p3TSDe4DvrHGxSMKxznZfDNHbH
 nnEiwnOfuJGHip0aA3NoENPSZ24lCJCyW8VvOEIBv1TiE+s8Fcg7ytApoAJ3ajjKE0dA
 rTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627622; x=1752232422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3FSXIvxye2ScqCnAEqXzSP6Tfx4AgfCRRJWGmS/vDw=;
 b=g1kIC5tAKkqrV2wNrRKwqjgPPJYhYln6ber0hlNaAr/m5M6z3jYzNZF7SDvPq1W7da
 7e6kmslcx6LMD2APGexTv+whj5qO/8rfnnKjsMoyljFPJX43dlkhIK00/XIsD6sgeMDh
 vcBzrSuTu0EKUubONyfh2Xgy43AD9vmCLn9O6pe+fOGcoOtuIhV826Oh8gIeljx2g97h
 A0/100lrK/PPUtwbGtHUwQJtvKP87WKNQlX0M3DDSvcF1rEXGrAMumUGa9rPx7dFfM/I
 BXEDvXdARGWslVa2fDj7Bri7ZpMJ/SRLp9AuOHmOWuRmwpw4YJ6+4EcuYljXfrs1UqD+
 OW1A==
X-Gm-Message-State: AOJu0YwnC8ftb7kuA7peNs2m9fucINmboZDSUen/dWthn8mMwZLEfD1f
 uKSEqiNMlmz3tYc1S9wlAMDATkqcOeYr8CeRqE8G6XNCsRXPBjdXPU3u1GB/3g==
X-Gm-Gg: ASbGnct2kj2ORja68lLVHLoEq77jcpAPmc58AZOnUA5gFhEK49zoQewA/JdYWQqSGZ1
 jXHixCj1DEsqErjSQoiaNgrW0fAwEaZARI9HXUvliZJZKxOd7mAaTYCxZnv31Ue2NiSy5n/PclH
 YmXqIwli2kml6lmjDJMdbkXYDJ6f1OCLbntW85LuLWxb2WHLsxJBDpfAOLLmLmBJYa9hqRrY268
 rkaQfp8UeKWZYjXS1gefOwp5lAhwDPt04PXJ0HIvndAdRe2/CdWS4KY2EORiZY0GoNQHmuvil0y
 57PNEOVUphW95GdqbAFLkSwHDhoIvp5mTI4lxay3MfXm9VW3b39cvtWak72Zxn+UqExXURrgDd4
 D1yh9OLw5sf3N0iSygnqR9pyW2L7aeWm17gouPu+rCegkonbnGBPRe6RDd6pF4l9nTZo=
X-Google-Smtp-Source: AGHT+IGWcPLnwhvRxtBJfWcvVydY4smpZNL7DFru35gYolkoTmHFFdt0EvtdBZgKUkQH+3UETdXSeQ==
X-Received: by 2002:a17:902:dacb:b0:233:f3df:513d with SMTP id
 d9443c01a7336-23c8629cff1mr36996395ad.35.1751627621922; 
 Fri, 04 Jul 2025 04:13:41 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/40] hw/riscv/virt: Use setprop_sized_cells for aplic
Date: Fri,  4 Jul 2025 21:11:51 +1000
Message-ID: <20250704111207.591994-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Joel Stanley <joel@jms.id.au>

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-5-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e074a29675..205fa6e44f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -655,8 +655,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
     }
 
-    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
-                           0x0, aplic_addr, 0x0, aplic_size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
+                                 2, aplic_addr, 2, aplic_size);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
                           VIRT_IRQCHIP_NUM_SOURCES);
 
-- 
2.50.0


