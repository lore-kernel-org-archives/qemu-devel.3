Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F84C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeN0-0004gZ-9G; Fri, 04 Jul 2025 07:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMQ-0002sm-7u
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:46 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMK-0003jX-LS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23c8a505177so2113745ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627613; x=1752232413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNxj/pkRvngZiOvYp/rjInzIaNJOI6+DtF9M/sZjMSA=;
 b=Eu5R1c6Ux3hhcOdvJ5KGug+AGj9xDLjv7298mSEKNeNgfqHKEW/e75sEvDPzSh8gmF
 krHlDhXyBoZc2tK/oErVt163vh6Rx1JfBjYzpA2OiZzOkt19eTYQ0lRvDfK8aVlAiOk5
 hhPOTHw3iLOuX74KZtAlPGo12iHAJ9sFFrrUuWq+lZG6mvR7CocQjbAX2tP46b5L16Vw
 6Hiac4s2wo8Ct9kYr6RWmVH6pGN9aoN38bp+RpWR6c7gCzxaNlLNXUzYXZpphYsbFHtg
 7aknxX65iofjjr3RuKLHfA26U0gXqczHXtiLQVmZRYilDELxten/fTmhjwhQDG6y04aL
 B4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627613; x=1752232413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNxj/pkRvngZiOvYp/rjInzIaNJOI6+DtF9M/sZjMSA=;
 b=mR2SchVJgQMqNlHH6JXsvpnw2RPCjy0Orcq4uJ7+PoZ1X/hUpy6ie86eFE+wRB1eye
 9tX9iLhElSyFlWiVuyH/oewC28Nu/yoyoufZ4C0QCMZYaIV5KWkwSs7/41BuFRW8w58o
 FviDXEvoIrIIAWpaHkwdOockAyBS1K+Nd0MyGOPH24bUkTeWf1sJ1N6a4v2DEj43noHa
 1tYis5QtFLrLYuKHsFMNNMz+Ue/8C/Z5JIKl1UfpDtblHNd9lcSyxROIMa5sUON5rloS
 YKSdSCOSdPyFP9RnpO87ABEgVIcmu0ywqrzBauTgSZ5iWM1he2aGhfGQB9mjzLFbIkmf
 UEpw==
X-Gm-Message-State: AOJu0YwPu293EMMmilPe8Xm2H97zuNhOJ0I0Y1ErLSLOLiJxvaIBVUkA
 VMUrAA95pnL7AjVVQ2KuJnzv8ObYDQytQno3yNU2ALPMzQtYxaiXgeua8biFZw==
X-Gm-Gg: ASbGncvbxY1889zgkS5979kcqhCeMaxwCStIvtBinMDLVBSrcBodlPuW9W4fIbbbyMu
 NJsKwLBy150ulyq1zA14FXg+zyhZ5wZs9ktSt0ERYfViZYjP8dhcjgngPLDG38UVFCQRjgSnfsA
 bQJiNh4oiJsbyQo8HbTjnf4uy22bk/RuvSFfVtdS+nnIzLlXQfwNDRAfBxXK9xS7YCT9pa7hhRB
 6DxeveNPJVxOEDxn6O1Fk/4e7bJPnjvmmNTSIsy13OuO5ZTe5c6li2JL84Qwx2PuRnZdXgjaa2e
 syxsjbMJPlo4H/2V1VyY1j3tNu1obqE3GGsbCdEGfDcl9OXhLjFnElKKe5B9V3+hJWm3rFvtiId
 W2DX7A13mOdEGDrOE7LF9/H9nMpejKrf7VfAgRDOW6S/ig703f2OpYXKAYD93H0YBNGY=
X-Google-Smtp-Source: AGHT+IEaHt3khMZ3JOuAj2ibdnVkH08VfoBv6h6Sdt/VljpDq6JzKq4S7CwY9vTPnFQPiqa7AwZtKA==
X-Received: by 2002:a17:903:13ce:b0:234:f6ba:e681 with SMTP id
 d9443c01a7336-23c8606b87emr37682875ad.5.1751627613031; 
 Fri, 04 Jul 2025 04:13:33 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/40] hw/riscv/virt: Fix clint base address type
Date: Fri,  4 Jul 2025 21:11:48 +1000
Message-ID: <20250704111207.591994-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

The address is a hardware address, so use hwaddr for consistency with
the rest of the machine.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-2-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cf280a92e5..875eb7155a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -324,7 +324,7 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
     int cpu;
     g_autofree char *clint_name = NULL;
     g_autofree uint32_t *clint_cells = NULL;
-    unsigned long clint_addr;
+    hwaddr clint_addr;
     MachineState *ms = MACHINE(s);
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
@@ -340,8 +340,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
     }
 
     clint_addr = s->memmap[VIRT_CLINT].base +
-                 (s->memmap[VIRT_CLINT].size * socket);
-    clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+                 s->memmap[VIRT_CLINT].size * socket;
+    clint_name = g_strdup_printf("/soc/clint@%"HWADDR_PRIx, clint_addr);
     qemu_fdt_add_subnode(ms->fdt, clint_name);
     qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
                                   (char **)&clint_compat,
-- 
2.50.0


