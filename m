Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33602C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGro4-0006n4-Dn; Mon, 19 May 2025 00:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrno-0006XZ-Bn; Mon, 19 May 2025 00:08:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnk-0004Di-Kr; Mon, 19 May 2025 00:08:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23229fdaff4so9192865ad.1; 
 Sun, 18 May 2025 21:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627710; x=1748232510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JL2MXrdEU5pO23tKkJ3XXY0EA0OwjP7eX65K3PT8UNc=;
 b=fmBJ8oqpELYLdjSCdYsY7PgWUyxjOcNhDurQ/aB+x7daMf8AoUqjBlOzpnQVTKd6qK
 0iBEfbZ2gHZ4gf26h64wP23sxD/P2TlUcClu8+FL18bqL47Ix2gLtyVhxDv8uNJAomI8
 z4AT6Xu93U8ny8JrR14j1DuN0h59JO3kVjipdo6LWFneFHhqoGEBxnQZ7XVPKT043x7s
 ZAo0KbxVfZFzGGgplW8Q8PXDVfytUgQrzQkvtFJGI4inDTs73ySZWeNG1VA9QXNwgBCU
 5WCOr7LyrZ0mYpvA0D/xKJSHOGt0MNPUxBY9qtY8okmByldpsUEsWcvT2Z6rydvV/CNM
 aPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627710; x=1748232510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JL2MXrdEU5pO23tKkJ3XXY0EA0OwjP7eX65K3PT8UNc=;
 b=KMekI/kHhHeZYOnLchd1yMG1addq5VYH21bqgbVNz+nunQSaLrNljlHvse4W9ET1rf
 QM7iFfLWsTpX0PB01o/MwEwboJ9qBl+/OzSWv4H9viK8qzwzW619xGyh+WBYlW6wUarj
 5qq6KccWq/zFdyBv14urRtIeYjIAg4g63kXDWGy/YudGWmC+cIghXECp/ySoo/eZOHzf
 uGTDTaFnUihcE1Wj1LTyWUv8/82Y3Bd0TifwssEddW889y/bFJxNkhmPuDIH2DCbnhwl
 Yh+2y1u1bfoc/reQkulfCYzEIVpn7ETFO58zOHRbHGiES+A0QWU5MbGDoBPEC7DNeDBk
 UFpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8zm4vXvqNue8yGthAkovT1b7il6BNqCAbOtXm3WSaWJ2jxw5fbQV3P/QWjITJ4dtKAq1O0HdPQKg03Q==@nongnu.org
X-Gm-Message-State: AOJu0YxvooqqncnCgPCKeb2m2515d2IapCMf1HqldV7gZ3Qu0044G3Gh
 forz6SKl/KMDO7Yj4hDBrR8afnfxsTi2BRnzkdBZHkMMzJFumztePeBbQKECFQ==
X-Gm-Gg: ASbGnculAJtBaZ3D+BpCzwknOMIWVqLcsUYY+4SI0igFmPX9VlD3IwTh8hnASva9tGr
 1KUKFu25izXKUwvIttj5Q8yxSj9My6SXjl0Qde+4VeF4VXhiedyc9iLbkujkvtCT4gSnWB1V0ZA
 k7UHOW+Pm6WiivPlctUpsy5Kim1TuNIOA/6s2TBtx6PsDI6z/d9t/FWdJ6bF6oDmgCtsNtWMn8z
 9ZOC2f1UtSH2EwdjqkRevUd4T+g61+sNbt2zyrRJOuxrMk/LcnekrH6YTGC4/8CbpO6HG0JypkB
 bMSy/njMy/TXsfyQcSAdkRw4HveBgBNynsiHBw2U7AqUrBa28+VpprUQbS8BgKS+3GH5MsMQg27
 zRc7vLkyzRVU5SuMlB5tAxi246wcb38FXY9nhhjZCbbZFh0dozZJAfxVH
X-Google-Smtp-Source: AGHT+IEBvI77LRt/jqG8YZwghMoi7PG1qTEYSxp3vWaKw7ZqTgXF0hgZlW6jpKP4eLb8DVr7bpu34w==
X-Received: by 2002:a17:903:2345:b0:22e:1a41:a6de with SMTP id
 d9443c01a7336-231d452d109mr176238835ad.32.1747627710514; 
 Sun, 18 May 2025 21:08:30 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 26/56] target/riscv: rvv: Apply vext_check_input_eew to vector
 integer extension instructions(OPMVV)
Date: Mon, 19 May 2025 14:05:23 +1000
Message-ID: <20250519040555.3797167-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Max Chou <max.chou@sifive.com>

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-8-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 841692701c..954f03291b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3943,7 +3943,9 @@ static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
         require_align(a->rd, s->lmul) &&
         require_align(a->rs2, s->lmul - div) &&
         require_vm(a->vm, a->rd) &&
-        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div);
+        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div) &&
+        vext_check_input_eew(s, -1, 0, a->rs2, s->sew, a->vm);
+
     return ret;
 }
 
-- 
2.49.0


