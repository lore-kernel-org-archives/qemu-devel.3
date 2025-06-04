Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93269C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIg-0002Ap-Ta; Tue, 03 Jun 2025 22:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIe-00029x-Ip; Tue, 03 Jun 2025 22:56:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeId-0000Px-6D; Tue, 03 Jun 2025 22:56:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23228b9d684so67468255ad.1; 
 Tue, 03 Jun 2025 19:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005777; x=1749610577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0AiQvQjk6NtB61sWMHYFKwjwNvToRms+mkQ+N4dhTg=;
 b=jxL9eZgU0EjKrHNHijYOlAqgmKW0zBtwYruMQTMTjxocLlQ7pyzFpG0roQt5mTRLrw
 izCYvsCjzudZBlbiUiXih1bgQi3dNX3k3/fiNpoClY45q7jSDBaRgy75Cd4UJnhQMO9z
 HF3VmBnR09KDSQ7udw3FYxsTBkJPmci6xpnJq+pHwZqQ6gubBXwqqy0/+wfee4PNvdD1
 R9/oHruCz0vs6jJoOJwbhiIUrrAT3y+lpSHOd5+DrjauJjsiv3zLue8wTFV1IONvY5ga
 TGaMPqBb9NqxTm/8OPkrV5NSSmNEyqFWVCCI/xZL9WNgWoegyIFxaDCBrGEkNCp8NObD
 Sw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005777; x=1749610577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X0AiQvQjk6NtB61sWMHYFKwjwNvToRms+mkQ+N4dhTg=;
 b=hLGuSAfcCatqF9P6CQvp9ZaZlcFIEKRXHOow78K+ggSfdgZeleY225jQeOR2y1+/qu
 c+pmSts2Tbjy9UDgIsjYxCTJoEyeyFq+YBrjXzeFdWXtpfV3hXU1tsuc0EA2VhkN/mPm
 feQLLxSMDd7wjwZ3wtBHj+bQ+lEIZWkPEtamnH3DG0uzV9RZgSleQ5+O+4DQK6KQroiC
 vFVqNjTJbc/xdKTcdsg+3QcjxBeoRmuswoGtlnapGRR+UP41tWrln+tcJLhDlNWYfkyN
 x8Y+LQOw2BehLwYUycmk9l9BCoKR/U/mgDERmmMkzaeOUA7oZ1ThKe9B+JCCG5V4Zy9n
 gAxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnzCggkaHefQsF6cEtEAv9/BL5CK3CmyOhzELvuEfYW7K8F/U5SpiQNm3DrQkCCXlI6kqJWyjExmRx@nongnu.org
X-Gm-Message-State: AOJu0Ywk7Q9r4KJHCPCZVrCd4LZ0L3IX2NUKvtvFlS/PRongpfZT8EyG
 zYVBKzue7sAw9CAQEkTfSdqZPl/G6VfMXWh+rIDkWUyAQYt5E9J22HmG
X-Gm-Gg: ASbGnct7wdmcB+lK2DX7BGs/EGo3Ks8rJWpznxwmQtiEKsfkySNnM+Eam8qxwMiJNGp
 aMEv7JFNKfBnSsIdEZ8KdkPdFli35apA33TpTKQQtOjeW2bIaorkMsy037uaIKsauh7sfsD5Iyr
 +1Gsxc/xoMKqj+YdRe3O3fRTogOqCgTiDrErhuksgFD1rv2ePCs6S0hYLcq/eMN0Y/zWdnjyNme
 9VqYxkkoVZM5klYUNKy/BUhBq9Fd5qvEcCZok1jMqXTOv1f8pI88QuXzmjPn1p/cad7QQ2H7DIQ
 h/1ml/hvKBmfhjq94j2dp+ORX4714hbZEg8oTEsxS6qDCe3Op6BirMYvafN7QQ==
X-Google-Smtp-Source: AGHT+IFNYdzFhsGKQPt/a3jc4vaH2cKMfikVRHrO3Drs04si8+HkPuRQ5VkakR0VtYnYx3OBWHmv6Q==
X-Received: by 2002:a17:903:1245:b0:234:8ec1:4aec with SMTP id
 d9443c01a7336-235e1126f3dmr12473215ad.6.1749005777310; 
 Tue, 03 Jun 2025 19:56:17 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:16 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/12] hw/riscv/virt: Use setprop_sized_cells for reset
Date: Wed,  4 Jun 2025 12:24:44 +0930
Message-ID: <20250604025450.85327-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 851c7cc82ad5..b59f10dabe19 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -932,8 +932,9 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
         qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
                                       (char **)&compat, ARRAY_SIZE(compat));
     }
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_TEST].base, 0x0, s->memmap[VIRT_TEST].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_TEST].base,
+                                 2, s->memmap[VIRT_TEST].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
     test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
     g_free(name);
-- 
2.47.2


