Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2158CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTS-0007F1-Jn; Thu, 02 Oct 2025 23:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTM-0007Dh-CR
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTC-0001G6-1w
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-782023ca359so1820615b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462108; x=1760066908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2oqIRAe+rhE3OsYBre7zr6/HIqT/lwZR75QlsJ0wAs=;
 b=TAuUUV1YOgnsWAxzVCDgpHEk2Htb8Bf143TydM8mJ/xPrE+ye+a9e+J86TknwuFzO6
 zQV4KnlS1NN7rbsCQ60J/IdtGujI9MOU9BuytVWcTv4SsnahxjVJI6QIQ0jHVuS1xgBB
 NjdNOY0dm0D+I511wL08DC1y4L8gSno6ihtgbdk/yj8xsCb/FIVcmrXar/w7i3MVgurK
 P2/nWNS5OYa9wWwL5Arzn5UJpWvJ5OkqicB83uxwRayv4tMLOIYTESVLA+aOij7anbbS
 skZVatNUgg8iz9A+xyU5ofrEbjpe30YHBS2YQFOBHS2op5rsnJvImPCvNKJuPJF4Bxv3
 DxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462108; x=1760066908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2oqIRAe+rhE3OsYBre7zr6/HIqT/lwZR75QlsJ0wAs=;
 b=bcnHVhd2pFGQHQH0OeLXNqkiOk0rBh2s0dqmFfYl/uv/OLXYiJsIxa8c11gh2iJ2hf
 MWXgS1Y6yD82nZ5jPcU0AIRy0z2wijS6jijRs/KgG+xY/1LmIh4n8JEx1i62YDODS+KS
 mZqTHuargh6x8pIeAYxUhXyRYyl2dUYGPCz+79glQAYa3HkwykkDRKR5gRPFG19KPzfr
 fNbohr10wrKh16VqEV9zxQQJtVyufK5Wk8BruOJUsnIJAk4uOPqAuZtAygBWcMB6AQx0
 e++6LpJGcvAqWM2knOzxAV//CXVOb5iIwWekttk1barvlHJHzoUqzgMZunKmg8cs0bap
 68rg==
X-Gm-Message-State: AOJu0YxWfN4W0vpJs13CDrqY6Vs+xkRo1KSaWRosTQOLGaV5CKacTELb
 ezRV/ibFalXSv/7zVTmzToZ7VlQ6AfP18vP96/bcSpeMgstAnXuctkVuDA7l7Q==
X-Gm-Gg: ASbGncuCaoqG4N8Swxjg7pBR2Kst5BoqAtzw5pbRzo16tkC+UujszcDu8zpGPAtgbtb
 qpZADwnPpzB+HeYz6+GFwExOiGYkJFbxRke2UV9baXvKrksRRBob+YdTL+PtAEDLy7Qc2t9ryXJ
 v5gfpK8nTqKGldZoguNWBhVY2GzyV51fu0mi8Gr8RJGPa0+rGV27IvYWFudC+Tbu+aSiNi7I4Kf
 5hsaT7iuUYh0Y1TE8se+CTM8sk0Xq6BUbm/6A6+byZvKLwYPq4qPzS0APgM4AN3RV1L322e1kvB
 d7uyGdb2z5Uojw1VOUHIAXbwhZJOjsB1Md02X6Lrm5/rToJF7vxjkQhjBwPKbvw0w6lh6XYFFAe
 3fHP40xaR5kdpg2DydssjGgKXEZZ0m48mwYaQ281FQVZ4O4SFiCo/b4jxwZQg+xE+i8rj9Fj5CY
 9+6gwJGfK5qp/QiqSCleBwEoo5NVNbDC39Hx7ScJJEtomZkxhT8RSX
X-Google-Smtp-Source: AGHT+IF+YO5OhIMmX55tnSPy8MhKRNRSRbuFhuQubcxROxeT7h/YzuHirRESvweUSxFEDxMROQkivw==
X-Received: by 2002:a05:6a20:1611:b0:2c9:1323:f800 with SMTP id
 adf61e73a8af0-32b61dee09bmr1571603637.9.1759462107846; 
 Thu, 02 Oct 2025 20:28:27 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, stove <stove@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/26] target/riscv: use riscv_csrr in riscv_csr_read
Date: Fri,  3 Oct 2025 13:27:07 +1000
Message-ID: <20251003032718.1324734-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

From: stove <stove@rivosinc.com>

Commit 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC
writes a read-only CSR") changed the behavior of riscv_csrrw, which
would formerly be treated as read-only if the write mask were set to 0.

Fixes an exception being raised when accessing read-only vector CSRs
like vtype.

Fixes: 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC writes a read-only CSR")

Signed-off-by: stove <stove@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250827203617.79947-1-stove@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 738e68fa6e..2c2266415e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -874,7 +874,7 @@ static inline void riscv_csr_write(CPURISCVState *env, int csrno,
 static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
 {
     target_ulong val = 0;
-    riscv_csrrw(env, csrno, &val, 0, 0, 0);
+    riscv_csrr(env, csrno, &val);
     return val;
 }
 
-- 
2.51.0


