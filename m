Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A2BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1v-0000eo-EY; Wed, 01 Jul 2026 06:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1s-0000am-Ja
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:52 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1q-0004hn-J7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:52 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-13986d61b4fso569985c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901129; x=1783505929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k84FWXRS7Lajzej72StGfyo2q1XvyUBIRB/lVrbIaBc=;
 b=fxBND4W40gEgwtO08HoNAOlbl29HaFEnb1tVuSVkfhWzQPTAtUD47RjZZuvKY7FZrd
 jvyhWhBYAOS+UF/kax1/eYw9fGO4NcS4olN0GMRvSqCE2lWrFFMd4xnd5MPU9+mSdQ98
 jN0xQvXvaI1o/jqDS9/mz56wFsovRjuoWi2UMZY0czTgS3du5S5kLOi2BU6spwK38wph
 r/bKQmyXbEMqWaX7yienvPgpC4nT//w1jSowEg5KFoECc2ZZiI7b2qKjXekQwsFy/6HL
 Q2XHbVgoVTjq8VxBp9pNzfS3TdXaEUJye0dG1+pD9VcqrmEICFz1pAhmtwpnYTQqWJQx
 fmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901129; x=1783505929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k84FWXRS7Lajzej72StGfyo2q1XvyUBIRB/lVrbIaBc=;
 b=lphl06Vn3MlQZ9JRMePiL8GdHSlqyZqcm37BnkTrVm34UureWsRjeGdzC2iTdVegQ3
 NczBwbwyf+lMWjS6mQdUAtJyOkLvOdgnSTkhV4Mv5tXb2uQicg7rtLv1gTjyPks6yq0p
 Xfr/sBAKbrHmQPy++DdC7DE3qCOyG1rkYuTVv1taom65qRiRlIP8JnYlNwnMkBM2oxvD
 Ux21hqIp0Lh7gxkN4KPsm2fd9TelyuIoSHFNxUEhzJx99A6unZZo8kC+jTm11auPAPxo
 ca75JZw/6y1E8kRdYJahvFvK3EGzjojh4fpZSL8SKU320lB12zRnydsKSg9At7YYhuDB
 9B8w==
X-Gm-Message-State: AOJu0Yx8Zzt1gIDCBcKtReipyU7QfVtqedUrEGau44j5X7/V950GJf5T
 VeNvfeTjWw6h9nYOvR4BbOpaEGCzREDVAgBKsEvTvkG4Ak89l140n7ncfkGpPg==
X-Gm-Gg: AfdE7cn76GbEWEtwUD0hBlf7xBHA/6ZuHPVeB5W188vZfvor1JP2BmYQa8mUH4xJqmV
 SfI9u5/NvLWUPXN/+cw/vb9Hgr+/4joY5vmcIkV3B1Ox3IhrADqvBbDnaRqO+ucuH6l4796cCdB
 qwZeKDwgkuZwWRuotuNPiN3agYaGooQMG3QfCPjm/7Nsz3q2gsC+USLx91IVb5H4gDEaAVYzF4C
 vu0T0E0AoC/nBHpZ/2FRdnTvtfbeZWx5u3X2anEwxkBk3Rcly+wnKTPpI4zCNdJef+B7oa0DBki
 /h4SIW51ZPbl1Rl2pPXbzO22GlKWMHCBtjDM61GBMJ3EMyqf+If1lmMfA7FwnLOwQ6yepfDDJe9
 6zFKpZVo8rR3bpXPec8YdpTw3HT26fbxXjCyILDKjW3/MQ2x/DsKLWsQAU4x7MUzTBQFQJi4/JX
 pyceiS4jm6noa9IaniohZhZEt9r+3htqc=
X-Received: by 2002:a05:7022:ec88:b0:139:ed5c:7690 with SMTP id
 a92af1059eb24-13b36e03ab9mr1099322c88.41.1782901129052; 
 Wed, 01 Jul 2026 03:18:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/39] hw/riscv/sifive_u.c: remove unneeded
 qemu_fdt_get_phandle() call
Date: Wed,  1 Jul 2026 20:17:26 +1000
Message-ID: <20260701101752.2522962-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1231.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

create_fdt() has the following code sequence:

    plic_phandle = phandle++;
    (...)
    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);

What this is doing is assigning a value to plic_phandle, then use that
as phandle of "nodename", and then fetching the phandle of "nodename"
again in the same variable that already had the right phandle val.

Here's how it looks like in gdb:

Thread 1 "qemu-system-ris" hit Breakpoint 1, create_fdt
     (s=0xaaaaac162a30, memmap=0xaaaaab8f70c8 <sifive_u_memmap>,
      is_32_bit=false) at ../hw/riscv/sifive_u.c:199
199         plic_phandle = phandle++;
(gdb) n
200         cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
(gdb) p plic_phandle
$3 = 12
(gdb) c
Continuing.

Thread 1 "qemu-system-ris" hit Breakpoint 2, create_fdt
    (s=0xaaaaac162a30, memmap=0xaaaaab8f70c8 <sifive_u_memmap>,
     is_32_bit=false) at ../hw/riscv/sifive_u.c:232
232         plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
(gdb) n
233         g_free(cells);
(gdb) p plic_phandle
$4 = 12
(gdb)

Remove the extra qemu_fdt_get_phandle() call.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260616235939.1358663-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0c6e4204cb..fda9a09f06 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -229,7 +229,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev",
                           SIFIVE_U_PLIC_NUM_SOURCES - 1);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
-    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
 
-- 
2.54.0


