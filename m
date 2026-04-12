Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F9F3ED6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 01:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBjYX-0004JG-GO; Sat, 11 Apr 2026 21:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBjYW-0004J0-SV
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 21:24:08 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBjYV-00079s-8t
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 21:24:08 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8c9f6b78ca4so387748285a.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 18:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775957045; x=1776561845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gzxvyg9DAiaJCfwiPoi4wC/1aA5w3LQq6pswVaNHAgg=;
 b=T/FTd0cD5SMgewfzor4BjBDRQ7pjuDJ9/7/wgNRT/laJ/Z4/QqbTjxQ1dP1PzgsZ7p
 LNDRvq2WjzDjdlgUrf2RhRTQEOCTRn+DAEwu5aUv9lhkxnlphU85PiP5NA6Z1dBu626E
 AGwcAkpDmQxWvVXiNdKpICvMGG/LedbubDX3toHu9lluJP0R2uiHGbgbBiGrg3WHPSok
 ZYjvR2NgN72//rnreUTY4CnD6EOC3SBSe3xZZ8b4daHZRb+RnD343PKP3RJ2DPClRCDw
 bi1phOE+6QkJIMz2KPVC1VSCScMVjrNLxIQMNeMI4hXRqY5sQ377uOsTdGEDF8lfDoF0
 vbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957045; x=1776561845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzxvyg9DAiaJCfwiPoi4wC/1aA5w3LQq6pswVaNHAgg=;
 b=Vc60ROQov18v8LkNRI9CWGbPt7jc6AhvcbJs2TVDCAn2apPSKwSzNQ0Llr4r6nnxHC
 EDi+5+Oj4YRde2xmD/T9vTKxNIyBQCfjdU5HPhxaHFlweVSpcfnjHIrksr4n8W8cwF0j
 IkkWljq2Y0pYM2gqPCOvU0YP4X9zOyJ3DX1E2T7jKQ3/v1S10qfD1RAahGeRun+BsNNg
 8sP8wXyppIwHoFe7GNpdSQEX3yE+iYPmkPIXz6pk1Ox+2OEeDX757pfLOB6JLba1K/H1
 X81pFgz9c5VhJGNHbatRHuRkO/NdlPjFBNVp0vwt0ayoAKFCCPdCVm8ZKQcRd1VP6LjP
 hifA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW+SCMUT0JT5+Btrypy6L9zz6nf7rzyGSMd3CzEKwku64rOnesx+CRYYRbo3Napyjq9jayo927zigs@nongnu.org
X-Gm-Message-State: AOJu0YxggBN3ouglLCXeNwBrDLFGw32vzjU7iUf9jWHBtQPNXSd9jT8k
 vCwLH5DYHcOh385AJFYns4Px86YyzLKBZQsvsKX5evxYsANjpbKokniL
X-Gm-Gg: AeBDievGAO3x46NgHudUytIJ0T/sULenBf3BflDSpnSlt+MZYYzAcuySROQu54cFTeT
 nQ4Lh6jCXriP06h3rpGaH+hWnhymPAiwz1eujqErHKrtll/DSi0U0q6+v1hVlBtWl7HKH4mbnhd
 PAs31BfvKDmxjaArg4uxpWXKsZN7VYKlwFkZDz3m++3nEm8TephAVYzdthgepqMXGt0wNMwYM5S
 y3YEt3rWEVppuZKGa9MSKuY61JLdCUVkyU/bWnjHfDc4gkpHPHVXD0Q+0uEWwCRsAQDlMfLCu7O
 E56HiaLmMH5CVlfeph/SlVKMqKz8vvFpE9Rc30E3JBgnvvrj/79J/kpV91giSIHB/3mcc6D0K7o
 uYoI+leTGssp9ypNkyiu0GqciEYVxBJcDN2EvuGRJ4R5dGygEYu2ygJYt+UITkLDIk2m2jNZTZ3
 67VNwRz1CWUJir/1JtDDTou0DrwS02KUkNoMZw6KSszgAX0WP95LDIF1MtGttqHjBjVce0
X-Received: by 2002:a05:620a:c43:b0:8cf:d6f8:5983 with SMTP id
 af79cd13be357-8ddcf6b69b6mr1253159485a.55.1775957045374; 
 Sat, 11 Apr 2026 18:24:05 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb9833c6asm562381385a.42.2026.04.11.18.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:24:03 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v1] hw/char/riscv_htif: Fix format specifier for uint64_t
Date: Sun, 12 Apr 2026 09:23:23 +0800
Message-ID: <20260412012323.1807856-1-chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x742.google.com
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
  https://gitlab.com/TaoTang/qemu/-/jobs/13878406521

Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (end <= begin)")
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
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


