Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D549C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGro4-0006q6-NC; Mon, 19 May 2025 00:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrno-0006Xa-B9; Mon, 19 May 2025 00:08:38 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrni-0004DS-Jk; Mon, 19 May 2025 00:08:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e033a3a07so38419055ad.0; 
 Sun, 18 May 2025 21:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627707; x=1748232507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdzxLn5+6FGynVzbWgDSqtDZ68g9RcZFD6alFggjkaI=;
 b=LLI/Oib5bdN8VgxCdwRD7ObZSLBJGdnkdQzbZDzo1rbqnxHVuf+orEHykn4ZYSvXRw
 4lgavs1rp957obzRtPvdFNe/H6DZyx4evqTrhHVwU9YY0GT2f/b96aZpkIeLGnipF3yx
 XbZPULtFOzTyi58EM4qtfYCx5088cx2kskUWZImhOh3yWlkXaXZ7HzABE4hEC0BKUbCi
 AmxJfY1w9IoeXf9AQrz+l1h/DkKYSwUcKWadMxVn4zuDAaNKViGO9vEEkGmJDRF/WWg2
 2eQRCyq1/WsLmmvP1mt6O1EreoOEYnyeXdct/ynY8mtEVwEhTm+Aq9rqauC9vNX8KdJc
 MZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627707; x=1748232507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdzxLn5+6FGynVzbWgDSqtDZ68g9RcZFD6alFggjkaI=;
 b=wr+R5c5hQfSeKXMatCMCgErQ7YphESyQRwdGW40D+iRnQ/LOz87xdbSbkRZlOm6WzC
 p95tfNqZR3txFnw0QTcRFeIvvgeJkwhq2sSTXp37EIbWnU4Kkb6taVGq5GAn3ebLKxe1
 VqsSpR+xh/soTST+5k81kkmBkFzq6LrOiSOBDB8uClUC0NuEJ2gXf0lBLWG6S0KLy6BS
 BaGaZ0BCdh930tdbBT0oiUm9JJAfUFzmfHRX1wIBi/URBt5Txd6KTevExxzqiJnrPNUR
 aVsUsXrHH1CyRSLBocLS2Ftdsw82hfw5fq6sFd91vJPB7IL91ymrCMt2q9YR8N+NeC7b
 HGmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOb21IccD3plp3MwFXobQMbP3lneacfUTeMZZWGwTIogzT2zAT1Wg3jwmmJdB+P8ZGY8Lq3KdcU8tL4w==@nongnu.org
X-Gm-Message-State: AOJu0YzHZH364pNdHUGbDkiMUPJNI9OqB0kCrx3SAcyRmo7O/oLAU5qY
 /FhO0SgpHvqJR+zQjk9wemitbPTBi3sX8I7v6yF0UKhyiBpARpoc/CL5ViS4cw==
X-Gm-Gg: ASbGncs8YZAms9CZ069FF+c4qQbPG6W/IQuC8qGOKDfo7Kpwrpfc6mio7WU95hB3hjX
 ZQm3KQVDZhQPyU3UjsmAZxRyTPKgqgPbSYddBrk1DPpcJusD3uXffCf/78n+p5SyPax1avv9eVp
 81mGApVOo+Kwd+3X4HV5sPkkbJNYzcbrVmOKsbvaCEXzGDCB/BYsMHndOQIkRhKq9ZkAO8ZLIoo
 JoiODGCHkVroKqeNvPBh721jTV5Lx6Hm9h9o0WjOKKyrNfbwlwoMCuNo90KwKRXcVPJO6IUN7Gj
 GDENGMtCMlBv3ErdVCgPcbuzZJwim8VUJuhayiS7AfCRQO4fZGBzY9jvNLnWQkNKQwUZNnRGuYs
 InnvbkZf5xswiphyoJZngVDYfNBmcOWyZI5fhzjk+rBkG+DAiOyuDlKxQ
X-Google-Smtp-Source: AGHT+IFaAlYUR5VNUmtFEh6kGKZI3OCvKaKoY3ZariiuzuagzlwsC0kwigdDBoBEBZL7y65leV5Z+g==
X-Received: by 2002:a17:903:1a08:b0:224:1d1c:8837 with SMTP id
 d9443c01a7336-231d451214emr169231565ad.19.1747627706904; 
 Sun, 18 May 2025 21:08:26 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 25/56] target/riscv: rvv: Apply vext_check_input_eew to vector
 slide instructions(OPIVI/OPIVX)
Date: Mon, 19 May 2025 14:05:22 +1000
Message-ID: <20250519040555.3797167-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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
Message-ID: <20250408103938.3623486-7-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5de50422c9..841692701c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -638,7 +638,9 @@ static bool vext_check_slide(DisasContext *s, int vd, int vs2,
 {
     bool ret = require_align(vs2, s->lmul) &&
                require_align(vd, s->lmul) &&
-               require_vm(vm, vd);
+               require_vm(vm, vd) &&
+               vext_check_input_eew(s, -1, 0, vs2, s->sew, vm);
+
     if (is_over) {
         ret &= (vd != vs2);
     }
-- 
2.49.0


