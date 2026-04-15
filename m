Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7635FF419B9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0ca-0007Bw-DJ; Wed, 15 Apr 2026 09:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wD0cV-00077d-H1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:49:31 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wD0cP-0001XW-Mp
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:49:28 -0400
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50d9436f2adso78374671cf.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776260962; x=1776865762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=06bWpmeGNzELxEsB1mejdwF0z+sQCt1wkIrogQp5NPo=;
 b=igUL1L5X9sMthkUE7gApQ0AvCTfoWAReRxl5AAZvcPgRvQXRCAI9IOomw2ilGSEYEP
 WYvRdReNgvoQVswVBkI5sK0tfeuExYyevQ3DwnUsQfNahfE5xqVU0/7xKbGVhKhwgeEE
 +/iPJ7YnmqBk8FhoHjJp3mlvgihy+EQFIGI6xvMtAVu3XtapCfTG/4nuRnsal1iBCI1T
 1VgyijkwrS0cPJdYQdcWTXKeD5VSmCoDv7JSMMEtsbWPbEf7bvaoXCehw9ql2X5z+ETt
 xWJtAZdrzzVL2Fq/wNSJKQMGcbaUcavMVX60A3we7uHSvoMgf6K2tglie7UNht3NYs80
 a6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776260962; x=1776865762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06bWpmeGNzELxEsB1mejdwF0z+sQCt1wkIrogQp5NPo=;
 b=HcGaLhHGqW4nUeLyuY4dV8izl7TWcfAVy4NxqibAWC5uFvFyBScnd+IqA6VkDg0fSe
 gdtIrdACTBsGYcSV1nU7ChydrPsPty3FAFxfA1ssMFjZrlDl+xhj0XdqA5Gz5z2SYWom
 Mheq6P0nwvdB92COZSDvGsXuFVDyCA7Tcw6L2fD7H1BOiYe1N2VULZuunhXm7bjtWKz9
 V0Jic83tvrn2sQ2NJWqr15YvOuAb7q6rt6YcqIaStpv0fTVB3DC1wvt+hWV79TrvK60I
 Ysfqjq2zgqwKRZgr0WHxwUmrO4hdK+BolGJ2vNfxuqYPL++wwN+gwD/QKcj7rwoeiIiO
 jfpQ==
X-Gm-Message-State: AOJu0Yxzfee1CXTbev20aGYC27bWLwLvLzWp+JupbUoeGOW0tTBaDeTe
 veqLHEgtaddbro0MQX/UDrkqnf6xzfH7+5MCazAV84/m79v90NkzIO3h
X-Gm-Gg: AeBDieudXy1uHW4ulRTWHcfKBS6eWYF3ghPBk/sVD60+jyU5WA+E6PomyJ8yZ5XkKFp
 /TUnUs3DfftTy9sE4fIxEt0LNIg7VVmlWv8ky5mn5ZVLNt1vJjvcrcCQQJESF53CaYc/CuNKxsK
 Ly1nA771xgdZTcsanw7FpNJBTSgkxAOQKxomILcfu5j81I9M1bzmf7uO9RHeMxtdXm3BJIz+Ygg
 nbNExSs1j3xjx+9w9Ya5Mv4suT7FpO11Y+LJMkx7/Ge5X1zCG0YmzXDrwBzbXx9IAKEk/Uqo1jv
 wmIk6ZWlCDLQsGX2P1FNklELMQwDTCt4rZ+SduP9q5nhZXSqSyxq947/x80eIgJVrbnu72Wj2D1
 HVEKunnC4t3tT92mHlkkbjjiYJ00VJVE9rQXo/CNz4yZNeTx2fzzOS4Z2Ak4s2YmBMD5gkUZsKs
 STOdbJRcpi8BnSH50BSnkQSTHYVIr3ZrB1kT5wljUAHA4oyBVdTrB89iYW+/cY1sDuRCjE
X-Received: by 2002:a05:622a:598a:b0:50b:506d:736b with SMTP id
 d75a77b69052e-50dd5c12825mr303069371cf.47.1776260961647; 
 Wed, 15 Apr 2026 06:49:21 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e1afdd385sm13104721cf.25.2026.04.15.06.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 06:49:20 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/char/riscv_htif: Fix format specifier for uint64_t
Date: Wed, 15 Apr 2026 21:48:26 +0800
Message-ID: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x841.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use PRIx64 instead of %llx for uint64_t arguments to avoid
-Werror=format warnings on platforms where uint64_t is not
long long.

This fixes the cross-riscv64-system CI failure:

  ../hw/char/riscv_htif.c: In function 'htif_handle_tohost_write':
  ../hw/char/riscv_htif.c:175:38: error: format '%llx' expects argument
  of type 'long long unsigned int', but argument 2 has type 'uint64_t'
  {aka 'long unsigned int'} [-Werror=format=]

Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (end <= begin)")
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/char/riscv_htif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 65ddea3fc8..a53d2ace02 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -172,8 +172,9 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                  */
                 if (sig_file && begin_sig_addr && end_sig_addr) {
                     if (end_sig_addr <= begin_sig_addr) {
-                        error_report("Invalid HTIF signature range: begin=0x%llx end=0x%llx",
-                                    begin_sig_addr, end_sig_addr);
+                        error_report("Invalid HTIF signature range:"
+                                     " begin=0x%" PRIx64 " end=0x%" PRIx64,
+                                     begin_sig_addr, end_sig_addr);
                         return;
                     }
                     uint64_t sig_len = end_sig_addr - begin_sig_addr;
-- 
2.53.0


