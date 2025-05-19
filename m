Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E0EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrnN-0005DZ-Cw; Mon, 19 May 2025 00:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnK-00058N-SL; Mon, 19 May 2025 00:08:07 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnJ-0004Bb-6N; Mon, 19 May 2025 00:08:06 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b26f5f47ba1so1261486a12.1; 
 Sun, 18 May 2025 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627682; x=1748232482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vp8MYp6bfU3nKiXsdBY8MEFgu8O1kZSwn/lekxA3uRE=;
 b=YZKQSb82owQ475o1sSg9xNHlPUzlbaw/kUbYZgUPq6EIoUZ9bXhqivXyGmP4jft254
 CioMJrFced1qrjXRbTKvL3dJ9yvhr4zSQip+DZqBfzwhyBdV8g0t3D+V1ByYYhMgoYWs
 MRFulGumynUthw6XM+MpQJC+RnKaPJsRGVow8bSFFcTtYJIU/Vk/Vyr8PCR5O8IhlD7E
 RddPQOBz9a3w6/ejqX69CkHMYyegdIeQVRMSHJ7MBHonC/EqI6E7hHhOGMYdqxap9bJZ
 F4dNobE5Iz+JYv/1mWTt0bioIfBqSAgZ01W4Ov5V50KsjcMBmjT5FfdklQByjD1PbuJ4
 SRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627682; x=1748232482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vp8MYp6bfU3nKiXsdBY8MEFgu8O1kZSwn/lekxA3uRE=;
 b=QvCo37WF5WNr3zy0xwwmQarfhkqN94cRLey5om9D5OX476/1YTxqgQSkOYohd812SM
 bnRtX66CjxKpKg1s8u5ZP9L1XoIgnte7PLYdMA2JllqJidwxSYhtMXZYwfe2H2q0g2bI
 vqU2vFzEyAgMEalR2dW9e+/TY84d0wCMl+GKGBFSmL4rqFDYxR/hdohexjcgiPjKGqH3
 tmhZDjaDUB5skXbiUXlgj4/GfAQ1+bXM5DvbJCSj5/3gvTJrPgyNnfVPGa+NyYF4r9Lv
 ZNADT25+7FrGr+yxopOPZY+9Ge85VbKkSrerUHAJgt5bqOBJzkypVnQ5GkTuEPBF6VDF
 vZUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmjdXyBQR9CObtULhyQjI8uWZnzUBIYgfcyjsAzny6ZfzJkI4uqWIFjRWEnj7fGx9sHM9riHKI7cJdag==@nongnu.org
X-Gm-Message-State: AOJu0YwITfRQq0J+lzI6TebyhX2rngXVTNc74y35iEiIGkLhSzvTgjf1
 ikGu+ApwneDVEzW+PLqm09qfDxb/MUjorEEPLaQWo+gGJS6h+cUz4+iLeBrdRg==
X-Gm-Gg: ASbGncvx9j1GkIWVkMW8XWC5kXJ+cqCYzerwr626+D8KVE0zaWMxoZEy4qwaCvdUj3P
 54zp7tX6FtHLNXhqk/nZYiNYNo7o+AOHVUEL30sCaZf9coZ4eoJz/htistmnPoH12kK2Ip/e5lV
 fKK+ItSlgQZJbIsHbb2I1AUVn7f2NxTVflPFluHtqxrVzu8LpWl53LzqnbU95fTM+YACmA+M6Z2
 7Ayjnwv1/aXzAIoe41ogp83xoLDIOYsjXiu0X39bijeDAN4Je0hdCx9IDsb0JfWk208QVUY5DNM
 zyJd8XcPSGrofKW8ahOLYXn8cFbH7M80JY3Nq7qMgs/Mwiy1WjvH3TK1Chxk6aMU9Vh2i8+ZrOj
 Dus3GzIRXRbfXDnNcytTJO4Kgz/ZBHscIlKUO/dGXaN/elOenRo7QELj1yActtVSzdKg=
X-Google-Smtp-Source: AGHT+IFA8PE6NSgLbIfqqJqtl/4eOoUwlicn9jZ09I7Gc5/DDUYGusnGE3Vm6rujaiYhtDAWbUyCgA==
X-Received: by 2002:a17:903:46d0:b0:231:d16c:7f6c with SMTP id
 d9443c01a7336-231de2e95ebmr156262495ad.11.1747627681996; 
 Sun, 18 May 2025 21:08:01 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ziqiao Kong <ziqiaokong@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: [PULL 18/56] target/riscv: fix endless translation loop on big endian
 systems
Date: Mon, 19 May 2025 14:05:15 +1000
Message-ID: <20250519040555.3797167-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Ziqiao Kong <ziqiaokong@gmail.com>

On big endian systems, pte and updated_pte hold big endian host data
while pte_pa points to little endian target data. This means the branch
at cpu_helper.c:1669 will be always satisfied and restart translation,
causing an endless translation loop.

The correctness of this patch can be deduced by:

old_pte will hold value either from cpu_to_le32/64(pte) or
cpu_to_le32/64(updated_pte), both of wich is litte endian. After that,
an in-place conversion by le32/64_to_cpu(old_pte) ensures that old_pte
now is in native endian, same with pte. Therefore, the endianness of the
both side of if (old_pte != pte) is correct.

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250415080254.3667878-2-ziqiaokong@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/cpu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d5039f69a9..2ed69d7c2d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1566,9 +1566,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) == MXL_RV32) {
-                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
+                old_pte = le32_to_cpu(old_pte);
             } else {
-                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
+                old_pte = le64_to_cpu(old_pte);
             }
             if (old_pte != pte) {
                 goto restart;
-- 
2.49.0


