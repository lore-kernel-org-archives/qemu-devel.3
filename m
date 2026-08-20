Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E308AC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjN-0000vB-24; Wed, 19 Aug 2026 23:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjJ-0000t1-SX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjI-00042L-DS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:13 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso319034a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197571; x=1787802371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K7jyUxpCMyWmPG7deRl8ThJ1u0ATYoDtwpi499af0mc=;
 b=UCphYrCXkdYWcRoh+ctkOp2TvNJQkzoFA3+xpt0te5RPwZ60cMOBkDlFMTwDCzQHUD
 B4VK2YYwNihV0C+506YEq3gl7NhQfueytD/fu7mpUFP/zSC4gvqWNFk2YeI9vkFGNf5L
 Qm+RJ9SyeEnELz9C0zL4DC5J7f2DqKO11VUYSTuWZVuy7/vcV90NBxY6DoXh0N3EtXQ6
 jR87cyXvJfu/3EfLFdjAL3h0rivBI+hs8R8ynBVh6lFvWdZwohs0BU0fZFMjmGZmsOY1
 oCeLIrEsdqXPNOwAwh5XStIkGkejb+xoExo7YYIRGclIknieNYakYuBOUWJ/Xg3Lk2hy
 VLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197571; x=1787802371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K7jyUxpCMyWmPG7deRl8ThJ1u0ATYoDtwpi499af0mc=;
 b=izas54o0JFLB2Y65vHAN5SDH2sNVw9p4p/z1q2UhZr/Yo5WeHzjFIscM6FAJZFtvPu
 MHelR8d0LVC6Inyy5HP1/4xYOuoz85YE34WyauiIUq9BrJ9CPRSYtY0xXfF4l+OEkzW3
 fqq0KcKhwfDLWg3XFnqggEq9zAzQGAHEuoELG2gXPr1j5FczIbQcCrcn/Ua/z7M7i75N
 LWzf/wugXG/wxg3tzDj/Iing5fHrfGty+UdWhXUEh5Tn1x2yLaapZ1xirMSHifoTYFFv
 dmqn4zgNslVO1xIHpfTVTOlaGO3c6Qo4nlWWqmAH0EvVYY5L8XTSuO1i+cYOGC4tfVZy
 cP8g==
X-Gm-Message-State: AFuF++lZ7DLgF7bw8hNNeu9NyHuIdbHPk7aSENb+hA4DmTV3d0MlwpYn
 +/1citwAQT7uDL1BrZRmXy2mln4WsR/wOkM9SShZzJVbhx1ZgPHN8+mWkOhzcw==
X-Gm-Gg: AR+sD12/xMzaM1rCPEPlgsDh8SibkZBZDnDPmq/obsLSkY+zjh2gf8hblX/XjOFr3VF
 iialjFoAanFG0y6NrcYkxUq8EET+jbtmlDz0MgKY2X8ZQBZCOwWKW1GrdyuXhD1aoZl2p3+Qmb5
 srRftYZY1Aeaqw0P9afw0QyTOliIaa0PGJnGGicbXicLhr/49bDdjQhuBbAlmjlD4Rz8P24lDQA
 WWCLrLuuZBsw1AqyI/4ciXx8PyJa85tRJlg6oopv8fAEh/anZI9flCdmdy8IpKQ1T3wZLgZzt5k
 dGW29nLXrazEM3J5FUJrAI18si3fH6HuPqjIo+Eu0lBwdEZbZAt5A3UwHLc57YDRXzv2IILNGru
 drtFOp0nWtBQL1TChYwmZSHKTld557nptTQfYNkDI48rr+Ei1w4k08YLPrO6rIKNuo/GUSJlmB8
 NkfbNAxhB9vQ+13c1YcPtBHggPOQZnSiqomxB/yhZe1KahuvncJSVKa/THt3bztdwCok8i45tFO
 rRGJFo=
X-Received: by 2002:a17:90a:d883:b0:38e:7e9b:5fbc with SMTP id
 98e67ed59e1d1-395a04e402emr4553795a91.7.1787197570989; 
 Wed, 19 Aug 2026 20:46:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/93] disas/riscv: Fix th.srri decoding
Date: Thu, 20 Aug 2026 13:43:26 +1000
Message-ID: <20260820034430.1186695-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

target/riscv/xthead.decode defines th.srri as funct6=000100 in
bits 31:26, with the 6-bit immediate in bits 25:20.

decode_xtheadbb() switches on bits 31:25, i.e. funct6 plus imm[5].
Therefore valid th.srri encodings are 0001000 and 0001001. The
current 0000100 and 0000101 cases use the wrong funct6 value and
decode valid th.srri instructions as illegal.

Fix the cases to match funct6=000100 with both imm[5] values.

Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-1-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xthead.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index fcca326d1c..2f2ddb8dd9 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -315,8 +315,10 @@ void decode_xtheadbb(rv_decode *dec, rv_isa isa)
                         op = rv_op_th_revw;
                     }
                     break;
-                case 0b0000100:
-                case 0b0000101: op = rv_op_th_srri; break;
+                case 0b0001000:
+                case 0b0001001:
+                    op = rv_op_th_srri;
+                    break;
                 }
                 break;
             case 2: op = rv_op_th_ext; break;
-- 
2.54.0


