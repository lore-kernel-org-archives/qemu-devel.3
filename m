Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D50CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqWw-0000cY-3f; Thu, 07 May 2026 00:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWu-0000b8-GN
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWt-00046C-4y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso5056155ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778128806; x=1778733606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHeLtodOnv6pG12WXEAqX2AcLxs6QHtw3TrspFKRS0A=;
 b=sswKK3vYQMkU8qiNW/Hwnu0OvhbvLvbk6FskfMOyIb5SPnvylc29wKt+j2/SDECBsz
 t/hM6Bp47egw9uoekvYASvyWoR/Or5gJ4oqf2glUQcuZisajU/svoou+0LY9HJTxzXTy
 pOUfN3q+hnnOTXLAWE29KuqotaMaq8gELKlxYhRa3F4LgWdwSVlsq+gQ0pn8PgQabURV
 GuLLLB0HOxiJGF7sDxFEW3qfxpsxOH4DWRl4Q7sznlCtJK1lniwL+dPNpy4PhEx9ReeA
 Chqj8GVec9zVVtc99cKrnK2yUcXJ4DKPKBNChtEv64icnOFCBXgIGKMYmmvn9nSfvnIh
 bC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128806; x=1778733606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bHeLtodOnv6pG12WXEAqX2AcLxs6QHtw3TrspFKRS0A=;
 b=HQVmoUfr8FBVED7yeXa78BJ/G/YLHyy7MEKV47r4Tqz69yfamEjT2YMg60CWXQj9cj
 J75489BsApWR6uJA7G7HctWC2JjMO8XFoQkduTZ2tndyNxm//x2AtY2/Z3RJ4t3MDxUd
 /MRIbFjUfXIdjwvW0tuWUdRGv3rRD3fk1TP8aTcv43AVEDhtrqxF0nDWfWOpdjg917Ug
 8YOkTTSTstsK0I+lSfnvwWFObebb2aIl667Q20kC/jcYhden1whay4hAj1l9iGSxdAn6
 POoH+pp1KU6uYcHsNpjo0S2ZeZYmxOhX122nTkvBO3ia6dm71at2GBkbJnVgRhuPQhI+
 42pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dL3vvL1u85AYO8dmUE5AHVumjAJt2f0IZpZ+kuqilgMZZazdJ4s6bsNDzCGuXbG3GvlYo8luMfCVD@nongnu.org
X-Gm-Message-State: AOJu0YzmXXMSTX6+VVHh24DvRsca0thJj77pzY0suQVgh1OBYuzR0+/g
 D2aQRk2YyGJi/8gcoZz/7DFPE7hWaUEeCHQ5/yt5VYZQnM70oLgToTGP
X-Gm-Gg: AeBDieviHTTBOeCF2T98RDwUDmOQu2hQolVaBuZWf9w6rVsp1nsp97dXpcNZdm0W0Y+
 eSnL6A7rMU5cGdyqCk6wkYtyarq9WxOpcSbnGx2jfpwe5JTJkx07EYr+idnQ7ELpMLDTmBVH4C8
 eTte2eUouAYPpEqlmaJ4E/UgH4aC4BoGh2SPrySrxLhvE8NAwJ4dTyyYpFWcP4Dj6nM+kVW4hqn
 B1QFkc7XuaM35xIo7bGRT1QEsBRRQ3TwH8enYjqVdN3jfyKiCWEHkTwVJiZ7JLVuO2hEbkiotr8
 5CnlSJkr69bfQcH0vqLN2GuqZZS3gKjAMpvQeZG8AjApkSaKif952Td2FK0ZWkhrDhpvmivun6q
 Bn+nl1QWwKqL2frpXLGXscSGKcwAUrKBMbJgs7sYU2D6pNpAu2o3+XBkET5GPYBWQ81HBi6k3eC
 xebd134TsvQxqd6Pze14xUq7B5wa/w1z2gUVS99bJvGwO2BMgVzr0WAhCRIDNIYM0n5cuV5MTaP
 b42aZjYLxZTZi6a5pw=
X-Received: by 2002:a17:902:e74b:b0:2ba:5f24:caf8 with SMTP id
 d9443c01a7336-2ba7908c80cmr65596485ad.12.1778128805818; 
 Wed, 06 May 2026 21:40:05 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babaac3111sm9291785ad.12.2026.05.06.21.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:40:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 5/9] target/riscv: tt-ascalon: Enable Zkr extension
Date: Thu,  7 May 2026 14:38:33 +1000
Message-ID: <20260507043838.45652-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507043838.45652-1-npiggin@gmail.com>
References: <20260507043838.45652-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

Ascalon supports Zkr and the SEED CSR.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37..69649462dd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3190,6 +3190,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbs = true,
+        .cfg.ext_zkr = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zvbb = true,
         .cfg.ext_zvbc = true,
-- 
2.53.0


