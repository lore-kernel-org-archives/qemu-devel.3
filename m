Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB65F5A8D2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3jw-0000WN-UU; Tue, 21 Apr 2026 01:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jv-0000Vx-1u
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:39 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jt-0004Rt-LY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:38 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so3596809a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749616; x=1777354416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEFNzmQsiyEBdi81S342OEi8MVF55bQv2FFp5njPfbI=;
 b=XZXU6DgnhHZYlufiofrjSjI0Y7pNReyHKxCw2lO80BlgLverjYcDbeb2q/WqOWOx5x
 xJBHMrAdzpVGrCgHT+iiYxHBiP9xw/zJCyuvS8OqVCBLsoxwMZr+rVfiCGDnxsq4HqE6
 O5ABCJTad4aSV5ZSMSRNEttiaM5MHzwKW7rK236YMR4y8ypwX3NdVJv00+fjCLq1jY1l
 IXqbIfz1gXb2kOEDXt2CC629mks5XV+cP648ARNpFl1rw4RNiWf9+D0ltmDo3eJGv2ih
 ToVmwQIz06lRx6NqFB0flesVDpKXjffzAxlDgkCH72Owkiq/80FDb6JtfbD7Xtg0NogN
 RXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749616; x=1777354416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NEFNzmQsiyEBdi81S342OEi8MVF55bQv2FFp5njPfbI=;
 b=Ap4VjRP1Z7BCspxDvt8z7ybDYwbRktbgFIAVF0rHFhIJyHVnBXY/W5NPNT2HU37TAm
 p82J9ATLYbVFoUmhkjgwzpKqOuhLptJzhz26GlrDNIeEfI7SPcu+d6lDKxyYWpKZPNCo
 8qLmnQvJXSxlGe41/vn5MSznr/sZO1naBABF6EuVtM8/GDHpQLzIaUwVnCab5CWFGB2D
 2hB+yFKWMZ0MW9PWWiTANl4RiizgpqWokcmSeKDmCH9o9WAm25wIIu0xzNI1AyTAk7WO
 2b9dlvGGm31qfvKsP94iNy2BIiZzp7p8gkoFLcoFQSNHQbixCrlllZYRp/JSu/BanUfS
 TG0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wjdnPk4BlQeZweJpvqwpE6W8apjIC3SXZWlCjjZHRAOWuC2ExfSIJQf06uYSnNVbvzCuUfIYS76HE@nongnu.org
X-Gm-Message-State: AOJu0YyCdacN/wJo6GoaXTGt7nIGAHNqEbDSaXyO8uUByKudveFy88pr
 bXFp9+GQ9PBcg+2bKE/+M8CDflCoK2wSyO2t588rheZBSuxuPJtyB1W/
X-Gm-Gg: AeBDievvrGJEzGSOS1OEqSavTjn19M0i+35mB3a7WREq+4PJx0MCrY1dxIl+1qHJ4Jj
 HGvrQCscnCEkL7T4ot341aHbdsaRrwFKJ+/FglcFZhpgo0ridEGJ/7bLY8Cm4ttBSy57TlkMump
 wi8Cfw0xGQ2LPjUPxQEM+HF/XxYhR1SUNoRfPaqVw6On/SwHmL8mppqkmiSOb6S1USRjQUPlIrO
 l5F8Domn0SNAvRPD7X1iMcVrPNRjacQWZ9dgsX+VVT4eZ71o8jQZQc9tswQOzGVuxMOf5saqDG+
 bRVOqPb9h39vNW3JES6QslmA1hAkEgrOFnWl/etJ7XSvWccb1ueiyFmG5VWVLtQRPTFJ6BYyEKP
 fKbrzfxt0e77MHCU+rLSCVvYTtiKV6OQqCJmHaGBbuRpTLel4GoNaq7e29ORcaAixKVOR3BTlVy
 6oS5tQZZRDpuUzJYaE9pgpIjHWli2QBbbRqt1cZg0dQxsZ4bj6ut9pqwIRoOt466dkxxQK3B73H
 Fh8A9jewQfRHepFOqqJFerluz4VFHZGeKyQNw==
X-Received: by 2002:a17:90b:1dc2:b0:35f:b306:5d47 with SMTP id
 98e67ed59e1d1-361403af9c4mr17483230a91.1.1776749616289; 
 Mon, 20 Apr 2026 22:33:36 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:35 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 07/13] target/riscv: tt-ascalon: Enable Zkr extension
Date: Tue, 21 Apr 2026 15:31:32 +1000
Message-ID: <20260421053140.752059-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Zkr and the SEED CSR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 72c6f4f0f14b..df01a729bc6d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3189,6 +3189,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbs = true,
+        .cfg.ext_zkr = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zvbb = true,
         .cfg.ext_zvbc = true,
-- 
2.47.3


