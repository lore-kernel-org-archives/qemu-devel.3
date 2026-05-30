Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71806CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 10:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTGov-0005l2-Vy; Sat, 30 May 2026 06:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wTGot-0005kt-HF
 for qemu-devel@nongnu.org; Sat, 30 May 2026 06:21:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wTGos-00044T-2T
 for qemu-devel@nongnu.org; Sat, 30 May 2026 06:21:31 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8353c9f24d2so7446545b3a.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780136488; x=1780741288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KGXs0zklixupHui+lUe2OoB4NdpP2UqJjahJ3jAoXkY=;
 b=LoaLEkwx50GdB2VoWDU76/ViLB1jtA/r2acFDCsD5wUfciOJPdCNDaYCAvhvk3ULET
 TewpX5BM2IXAOwrazJMwn+0MKo2kh6n10blXMV/QBTLphGYsTqlqA1yPfbblFki9pY2C
 bmJPaacoBUG/XDxeg2b8cmXUQHR7znoc6pCaDBadfDkmANZfrnq2y5VBWRS9WuX3L3Z8
 ZG8lybpDSanfshrzINb7Ntl3KFFqYWKMjtVkC8prNax2fgU0p2fz82sPlZ44tSQA6mX1
 5YSxbFD6w84JN285ipJy158Z+seObP17HR/NrCt0PKUhIbwg9kQlhkHrMUV2Jm5HQVs1
 lTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780136488; x=1780741288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGXs0zklixupHui+lUe2OoB4NdpP2UqJjahJ3jAoXkY=;
 b=ZqYxG3tBZIMqrHeBupSHVe2U4glfg4uHqnhuicsCN7DnqLAV3wDA+LYrGeK2bQQU+9
 fA8YqRFRrItPLYmOB1EhujrbKC4KVuIpWrJoNUzzh3pfs1RAM1ulK5AdnE8FnfZ9delT
 plhJZf9cYUFYV7VKXebw8kRECG2hPFR3m9z8XcUep2Ux1SsRlUjPk0sl4saEEuJsllvB
 8nE6d1YwWZVZzbNgy7X3+tJ5wNhxLfV/WdG8N+/9Cp6LgDZ9jh5HCkvB77dzJSou3hfp
 DgxtXiJSPMuUd2I7Dc6Yn+lZbESuShyBcksgyPdKu0O06dQlm2YOYDvt91egBWy9xfVj
 IjfQ==
X-Gm-Message-State: AOJu0Yy6iHXRBUxiHymrpq1k8onMsx2LJoyf/J6E90TVh6JODoE1Xk0A
 vA8yp0cUV0BMq1c9OLcj7N1m7e3SR5aYXizx43Z48ntL/KEfHcQ80X5Gs/9/pg==
X-Gm-Gg: Acq92OHuHPbnfnQ/h/36+/tm9Ii9B7/l+/jplsqLNfanYaXqGzUTUtAz8JUFzA4/dq+
 aQYb6m0AX5qgL2v2WmhUkI/0C3j7o2FF17j2XZUEDowIT4KjEFiq2tNBL/c+5od7IQiOAJwkmMt
 s44lVUnoUOA146nmc+1dTSyUqGmPURR3kdqotNm9C2NeEpNjpe9AvcB+g2vCjcRnRpWqdJaSpb0
 qUrIW61N4LMbdabsIpQpDV+QIxDzt1HzIg162F+e0ZBK56Kfhh3AaGRXvQZIw/YlxNMCoaejgPH
 YtVATUgmQa9USBDypvSXNkXX5FSNflg811F5iwtzso6VuO1LveTi2LDYtLHvCMT3hloL0y6vwGw
 axJ5txX+VkJPQTsyxHpAfvETmpYxUDXJVVf/M084D1QQIbkl1GN+Go4KJotus6ZaaQMQSEBfPQS
 CU2EJWccEMXBKPzxXj0JzG8be5s+KhZAY=
X-Received: by 2002:a05:6a00:6f50:b0:842:2ae0:968d with SMTP id
 d2e1a72fcca58-8422ae09a48mr1844918b3a.32.1780136488439; 
 Sat, 30 May 2026 03:21:28 -0700 (PDT)
Received: from arch ([112.133.246.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214c92fc6sm4364229b3a.36.2026.05.30.03.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 03:21:27 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH v2] target/riscv: mask vxrm csrw write to the low 2 bits
Date: Sat, 30 May 2026 15:51:00 +0530
Message-ID: <20260530102100.78150-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Citing the RISC-V specification:

    "The vector fixed-point rounding-mode register holds a two-bit
    read-write rounding-mode field in the least-significant bits
    (vxrm[1:0]). The upper bits, vxrm[XLEN-1:2], should be written as
    zeros."

QEMU wrote full value into env->vxrm causing read of upper bits too.
Used existing macros for bit-masking. Previous had a hard-coded value.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3470
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f45..7b98d66db 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -977,7 +977,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    env->vxrm = val;
+    env->vxrm = val & (VCSR_VXRM >> VCSR_VXRM_SHIFT);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.54.0


