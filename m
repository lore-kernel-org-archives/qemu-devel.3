Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66A6FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwsO-0005EY-Vf; Wed, 29 Apr 2026 00:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsN-0005DC-1j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsL-0000Qq-CB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:18 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2aaed195901so52976415ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438216; x=1778043016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1DqayjN7Pd/ZfUHF12td1wkfi6fDh2DrvjYRmsYHbg=;
 b=LT8tDNp2ytUqKNNVEYgQUZbopQMgd1f5z6Q9BkM1EpBxZhjet3ATwCbQJutMk/kbcc
 Ld1YOiXAHwm4u8ifpFIEKBobVcyMdlHOhujEXhbSxKEdkWtxCJegBVjyXATzcItnPOYZ
 q9n3cs7CXNtrVRiwGdOV1HyeqbmOrq1kQ2cbw51tJuJ7O3rm/BKR+K36pN+ERd7pL49u
 xwSNxPCY7H77QgixFUhjpwasf7Fglo0lkGqt+MVXDOB26qVOjnp2HVXhbV1yPDeWhoth
 ENty4SLmySOqpcXGOGFicFHSsWrPMmjmaPGoIcLSX5SJAHqSwhchX/2a84Wq2LF4febc
 0m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438216; x=1778043016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1DqayjN7Pd/ZfUHF12td1wkfi6fDh2DrvjYRmsYHbg=;
 b=sJAoR74UEco7UHC8sqvg36WLRGkwvQdRHT90h6pOJkDgsTmg4yMymMED3LjOFo115i
 KPktysajI+S1Rl9uhVP6UdLL6ZI76oUX0jFLZ/q4XomtVg5AZor/nr/pYlM/0M4kHFDZ
 ap7iZ8aN7nv6i80UfG91LUhIV4Zh1+8EtrbzPTJTjokSflstvAi/MzZ8YqsSg053G+T6
 n3I7nmlEsN7ePjcXQ6bsbp8rtvO4T8zdNKZ58O4IggTQwMtX3rTLzvQ6oicOdw3b6Nou
 CIHOmQtkAUOVCZKd2jXjRbAtBZd4+8Nln/D+aseQGK6ebCP4Yy0MIMeKBrnij4+HeTVr
 Bz2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sUTR3QdGul2TeAMbz4jQglLBOsmy9KOJl8DZg2BHD/3Bx+UCkPN5qbeUZ2dILIMmgph21KyaJC+cG@nongnu.org
X-Gm-Message-State: AOJu0YxF1oHxmPyPNTH+/gQ2MyqvbnbZ9BpJHtqq9pnNGtSLv7S+LcBP
 lzaxbmepdhsdpEA94E1gY+SJrPjW+3Ae5DeWQwoa1zVpra3N2RQDAc6Z
X-Gm-Gg: AeBDievzrfCoVKZsWs7SdN+NA4+gaQiRVD5suekew1zP2RrYEgaP6mB7HNn5y8iwyjf
 mrnvaPbDKcz4S1iVvZ8BqZ24QXqFdTY7hGVgfSq/fOFE6IeLz/lEkXnAE6ySR4OXrcZ6HmpgRPr
 dlBLc8iaBaaiOQ3sqI0KQ/RntGlOLYOr5ZF5p6p8kI8iDs0W/jLzuzQ6dlT21xN7pOBHCt8nGcU
 FhE2JNnzp+yej/rtcR2Bk6L/R48weK+msURsO9IYtBu4Qrsi6TM3+qOXnrFWPMw+F7jUzCByCZn
 mhZUGTSCjVGRm+jStmVGbF5Me0mdMVHgGdo/DaPRqQNbWWiVndp+zEihfPjI2xM5KCUjqodxT9q
 8s2I6DH7sGikX+BQsJVKBZmWCrI14QdzFYruC4uav2XwLIG2PYWMxApfpEili7PgNNnP5ngu6Ar
 yH68V+LVA+GMBJKeu66j3i7GVFA5Qh69I3CAoRQ7E7nZtP872Bhr4HHmf9gp3KOI0=
X-Received: by 2002:a17:903:3848:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2b97c03f4d7mr59554155ad.0.1777438216023; 
 Tue, 28 Apr 2026 21:50:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/51] riscv_htif: reject invalid signature ranges (end <=
 begin)
Date: Wed, 29 Apr 2026 14:47:26 +1000
Message-ID: <20260429044752.4176397-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Prevents huge allocations and crashes caused by malformed HTIF signature
addresses.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3205
Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251209085349.61510-1-munkhuu0825@gmail.com>
[ Squashed with following commit to fix build failures
    hw/char/riscv_htif: Fix format specifier for uint64_t

    Message-ID: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
    Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
]
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index e9efab16e9..a53d2ace02 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -171,6 +171,12 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                  * begin/end_signature symbols exist.
                  */
                 if (sig_file && begin_sig_addr && end_sig_addr) {
+                    if (end_sig_addr <= begin_sig_addr) {
+                        error_report("Invalid HTIF signature range:"
+                                     " begin=0x%" PRIx64 " end=0x%" PRIx64,
+                                     begin_sig_addr, end_sig_addr);
+                        return;
+                    }
                     uint64_t sig_len = end_sig_addr - begin_sig_addr;
                     char *sig_data = g_malloc(sig_len);
                     dma_memory_read(&address_space_memory, begin_sig_addr,
-- 
2.53.0


