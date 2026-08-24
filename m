Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC57C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNam-0004So-2u; Mon, 24 Aug 2026 01:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZ3-0001u5-N1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:46 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZ1-00024g-Qf
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:45 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-395ea741d07so1002993a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550581; x=1788155381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K7jyUxpCMyWmPG7deRl8ThJ1u0ATYoDtwpi499af0mc=;
 b=f21EnGHiXli5OLmcLrcT0akTYIKJzY7vlTOtkJdZe+ExqyNFS4TipQMK/mlyKcpXKs
 z6xS6EwWcux1ZFn7P/65f7aKwAtDgteXquRpaJakqkXdsAQYTvjHaI9ElTAHvtS+R+8c
 N7tHFuYzI+p+koZufB0C6gccfzka0jcD4J4eDtyxKm7LqmqvZUr73uVlJlqTkuYBv4G+
 rn9EcIxHKv8HjzrYeJkMKkU1KCVJxFBoeWNruNlPY2QqlYKrBZ99DX7HHNhrFZMjWZvb
 70BJYPmE8s6d3BXhgNajXF9VayMtkGp+HsWqqg/OrgCY+y3mee7wWwxqbKCP4IhgHSKI
 OX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550581; x=1788155381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K7jyUxpCMyWmPG7deRl8ThJ1u0ATYoDtwpi499af0mc=;
 b=odxkgeSseJPRS1Aqv5CnlAOVf8RBijGtbAxDfkgOetrHcw9LKsYl95HpCBh/E/3pOh
 HREfzet3dzeHP3xgSJm8VWGyusdi8wIpa2FgYEnzZxvw3Y45lSZNXN+QHkOmgQtx4TpX
 ZhgFZVHS/5wiMv1oerqB+oBUA3xn87qZtVqHgR/bBT8BQslyctAaJzJr7NK20oOWfhAK
 3vryeninHb6zrxrgvtMmLn0hrjlkZSBMsrWLqThwiO89qlJlmUtDcffxwfmCIxJh0kGV
 Pe6IqzFvp1TZ1JVCWmBzpmHCJ/f7r+3wmGIQEqnGZFA3RgKfkvGLdcbbpB83/NmzuJ+5
 60EQ==
X-Gm-Message-State: AFuF++nihOsWy8whHUhlKEqLgSetBagSHq7lLIdB5bIFbxqnkwGw2Jkr
 CVai2H33gW6V7BphN5mr1NbQihiiAV8B4WfuyjzgjxT1wEn7pq1f+jVuXcxXmA==
X-Gm-Gg: AR+sD10Z+w1V2rYqmUTu5rHiS2LJTTDZgCkeYD8hFplC3EV85VxCdNUZ31YK9yURQRk
 r8RptPrWDwJX/FJpgGQU5LvDuZHaOmmnnoejH3mVe0hRnsF2LIaXtUUdqa/mFk2rG5ZHgMJm/zH
 wIe/XmLEwLNVKcTakg3G9LPI4icOmk8ISOf3hiKAwkUzt/GPWPuIGRkYbhLNEDIca8VmvG77+WS
 IIkfYGRvF9U7tLBBADPwMTEEmLVhjmcnFo9L6V2D3kSRu60CZBF9gbUx3kL9KcAiwCzWpQbu/23
 tWQuJwVVp11iJg0fJjT1xMB8VQDWm/xisNCMJ/oA48CxbREUeILO2I1sa5ZjGmoBAnW7IhY84xs
 8PVDzXdJeuNkommd7bfMK7eRDI4J3uJYhAsOsURlreR2Q92fj1wLk32w0egQhwSKwxmhXXwLKFg
 nVrTwa0fXsG/VY1XBSYTFxbZyTO9Tgs+MxEgo1ixYq0F7Rt1ZQUAvAfpPWvdfOn0uD/tSZgB0iL
 8iImA==
X-Received: by 2002:a17:90b:4a81:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-395c33ec558mr39401655a91.7.1787550581422; 
 Sun, 23 Aug 2026 22:49:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 26/96] disas/riscv: Fix th.srri decoding
Date: Mon, 24 Aug 2026 15:46:56 +1000
Message-ID: <20260824054806.2790041-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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


