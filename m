Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A553AD6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2uQ-0007IT-IX; Thu, 22 Jan 2026 17:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2uO-0007DO-Ga
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:08 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2uM-0003T0-Sp
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so13424795e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119925; x=1769724725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZixBBXw9pW9Lb2/N+W+Mo89Bf4jJ5ucu9PIzWSFCxg=;
 b=KA2OLR2rabwpZv4XJgrz6PnxNMeMUlH/PBVD8kPeeI9TZJ19G35zzmf2UZzIAw0fVw
 mZR8r2lDzTvKce4DW0ZtNo1BpGPLKsBw75NA9CZz1HjKjR8geL5Te456q+jPCqC7Wzjo
 T+s5vI53+0B2vhOdeshof5QupPIexy/06GpwwMHGOXB5G++/sEG7ltoI9dwJ+0ysVMm7
 E7nGvl/1yQdfZ9BgEGPUaOeBI9fSlp7/9pytsY1OZ1TgYo8ZBTcaqm/MDqhUZlj8z6/2
 oLTUUhK3Ei54DB796AnP7xfuLNZqqzZucqaMnNlJAVggLe2+O2KL5aTWjf6Euf9KxQt/
 7+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119925; x=1769724725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZixBBXw9pW9Lb2/N+W+Mo89Bf4jJ5ucu9PIzWSFCxg=;
 b=CebCVxg3XLzSuKOXHE7X0tA9lBkiWz8Wg3zAppg+PlnjzL9vM5jU9xE7JYfMcb4kJj
 faFW8mE3kCH6bIefBiytQIIIlGs9T2TZIuZKwRROYzG1+GWhNLRqmituohX4T0DWs6FW
 lmEsY/DsoSVCyent7DL1kiV76V3ruCZbB0feSPS5KjVhdCttMAHqrTGN+AqRzFTr6iqm
 dPX4/dtYTUzwP1/L49ngwdeZazh4r1iFAmvawwbNiQgfG0IYgkI4AwBXsPcLFegaOKYu
 2GcClsOUxtgC2FdgZWULUV6RfBH5ivjSPParvHS8cHnkyhUaSu/i5rbMm0ZU5+PIAish
 rJpQ==
X-Gm-Message-State: AOJu0YzxyciVqzK3UBFm/8hchIUPZFCYWxPwNZh95077Mwp/poPLpGe0
 7uPMQWcmilPKzjbmYJeSZDJYfcThQnAkTtO/UFZPBqRccljed5xZ3/19+Hngz3BMaDQ1VUnrrWd
 dy4N/WEKRoA==
X-Gm-Gg: AZuq6aLulHzLyF8o7wXgLA/kNOR8jYNE/b7qvkMPUhBOXLJ4ISFE7ViAqD368QUdBhd
 yeNN7989yNwpZtjAy4+cNsR2wqrOP/GRWEEUzwVtosemsQJX9GxAGRqpITghJPdK6Ru+U8a8W6v
 jJi1EjY3Phl5ceMt7pu2eqyYBXHAHqS+ciA2T35EJvP4yA3m/xFwC2mlg36ixb/JqZJQ0afnqe+
 LiMx6WqoPqOqeta17T/uwfgR2F2LxQ6zfZPvOOY8r+ZmQQBM1DYcNNJXrSoDJPO4gkeM0Tf7j2j
 z2K8JC7rMdllUqQbDRGTZXItpSNtGRx/PPOn4yjl/NrChD9PpIUl53gADp/LdoPqmYi1VgO/Mwd
 uM/uoTMFhBBHteeROwP8R6LjOy8VIr56X8KkK3JOEGY6/X4WtN0ShUr6iiVWJhoHqIuh6o2aPNK
 bnlx5Jjo59xwNFtUTDIFuIczJ2wVZ8jPgQzENSwOunN20mjOiziR/flJXc0Fxp4+AuISN9BoA=
X-Received: by 2002:a05:600c:8717:b0:47e:de23:dd6f with SMTP id
 5b1f17b1804b1-4804c954c70mr16942925e9.12.1769119924623; 
 Thu, 22 Jan 2026 14:12:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8bebfasm11749535e9.14.2026.01.22.14.12.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:12:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 08/11] target/ppc: Check endianness via env in
 ppc_disas_set_info()
Date: Thu, 22 Jan 2026 23:11:02 +0100
Message-ID: <20260122221106.57184-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

disas_set_info() shouldn't bother with env->hflags,
access env->msr directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 58816c51a74..0808284b722 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7456,7 +7456,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     CPUPPCState *env = cpu_env(cs);
 
-    if ((env->hflags >> MSR_LE) & 1) {
+    if ((env->msr >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
     } else {
         info->endian = BFD_ENDIAN_BIG;
-- 
2.52.0


