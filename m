Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E6AC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyR-000595-Bf; Sun, 26 Jan 2025 02:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyG-00053W-UN
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:17 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyF-0004I6-74
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:16 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-29fe7ff65e6so1189348fac.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876134; x=1738480934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+smqj6hYDDDrzjm4GxtEQwSjZgHAIk2Z3L68pTCDUWg=;
 b=MzPbAK8aEGlGlrhnqJoxDimQdTUwvS3NEptFRdnUcsCBhZDRQxVvpZoJbVAnTCtUFA
 xa4HqQmsqN2Vxd2Sb2CO+l8mZb/O9Wqj3jsTxCqQmK7xTUIw29nxwtU03+YGGHob4Mlb
 GZdMSC5fdlnZPOZYTkSTF21CA5ITp+VebVmp/oqQ1KD+HE8r+iLbbNZX7S/4SWIG9eDk
 vdh/VbmhXmdE9Fo4zBXGvlsrjNr8FILLZMWwT5FkNOujKJoWlVDC5PYaSRRGw+INvPh0
 SXaTizmTXMOG+xQowxrxEqQrxAAvDSx3NaYKgE1hI4GiLu/HlwqlZdB6pmNrwEkpp2tU
 fVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876134; x=1738480934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+smqj6hYDDDrzjm4GxtEQwSjZgHAIk2Z3L68pTCDUWg=;
 b=HX6tmKxd547ysHtzl6kux7Fd5LExA9NLg9GYSSwG9JnkPKUxieGbHuUDKoKVy0MjpE
 Ovv9gCbdf7BRfuEFl5KDE4uc/byg2Uc2MAYJe90Oax9/kgkEIyxADwZn6P6vbZOybkIC
 m1ruw7uIhqt4CQQ4s0dGEWCakOc6miYuPX9jykltdFhN74tzVtkmDxmHBoU6mO9A+e9v
 jY2CgNddUEIXlfIziLfFa56AygAzNEvu7/P/HVkO14nO9ZzWzjC2EYgwLtDmTxu3xN0X
 ToXdmg4Bg0y0bCunM2wTKcEqRbuN6NtlyXCZqaq8rXn7iX1+YC/E0v8i1ecJUoZd7KCx
 MKog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm6av6J3BWe2ppzMck9jilt6kIOI7BpkQPbmsICW24uNw3Jb0TrnVdt+7zyRPlWH7f0vVGYH7MEEZ8@nongnu.org
X-Gm-Message-State: AOJu0YzIsM32y/U+IQU8q/QqQlnokuFr8J358bGybgKV2KpT0eoj6eXS
 iF9P/D53YKi78w0Wn8Y6a9bOcQpem0U9Ic+98F7dKEwsq8jRwYrzJNrueIihGjG2Q30kVOyfXFf
 PdqmZAw==
X-Gm-Gg: ASbGncuzTYR6Lgx5JRPBHDsVkW04raEcwirmXlgsAYgikrgXbWs9nu0YPhoiBPWQ0i9
 DSxIYL1pqxK8t99QvgWY6Mcyf7Rpc9K5W2NV+W6t4UoIHBzFnMdio9fLfzlSLnWrSUmvomwRtzq
 qNQSRqdtl6OwsflaaKVDdRTN95kWXNSVBI0epVVxRXERRRM1a0Bq7Z+/zGjCI9SpXyXhncPsuBW
 AylxDBaAz7VZg3mxOXqRGvv3Ek8yd+osWUCNk4gtkYM/tbJbT819S8Op3X9NHoZug+ja51tAhMP
 DPCR36aNZ4YopmmkqRStEYT4Dxwm5kcc35fN8wc=
X-Google-Smtp-Source: AGHT+IHr+XUaqBNZRwMPH8gM5DY/G1NCWelGpQolmMa5+SOYyiAtFM/3JK/XpixZSy9g6W2XJk4Paw==
X-Received: by 2002:a05:6870:6981:b0:29f:f1cc:12a5 with SMTP id
 586e51a60fabf-2b1c0c025c8mr21889251fac.31.1737876134110; 
 Sat, 25 Jan 2025 23:22:14 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:13 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 05/12] target/riscv: handle vslide1down.vx form mask and
 source overlap
Date: Sun, 26 Jan 2025 07:20:49 +0000
Message-Id: <20250126072056.4004912-6-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index f5ba1c4280..a873536eea 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -609,6 +609,7 @@ static bool vext_check_slide(DisasContext *s, int vd, int vs2,
 {
     bool ret = require_align(vs2, s->lmul) &&
                require_align(vd, s->lmul) &&
+               require_vm(vm, vs2) &&
                require_vm(vm, vd);
     if (is_over) {
         ret &= (vd != vs2);
-- 
2.34.1


