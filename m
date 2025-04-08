Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB2EC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26Nj-0005H3-In; Tue, 08 Apr 2025 06:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26ND-00056s-PU
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NB-0008AF-2Q
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7359aca7ef2so7335380b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108802; x=1744713602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPGCnMvFd+LYWp0JkHcVpmNOMboFHrFoP/WFEwnOqXY=;
 b=Hx2h3XeSmD/CcLazwoAPLDcMDcFMgrR+4kMhwognQTxlavMzhfw1ulcn+cj5dX6PWc
 lrqGQg2qG+adpTQJnRVRDsQSPYvwcV7cD16XkAFllpvfKJ6WHZLCW75jW1aEJlBwWNEi
 7b2UPqPBd09gnQzRdb5Yg9RA7iRMD5bi/1v9afLX1q08rS8SileQi5A8NtZxhm5htYmt
 eHR5gUPWSYIjd8YY20w2Cf7EK3XhDKjk2MOp1rsc9Wn7Ko4NYh4q0MW6WswXTD7c6gIU
 tAdFJI8barUr6puiuLBRa0c90ygdzTbE+mcEL7vakLZwqQ2lwkSEBYeGDTs1sooINdib
 ki5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108802; x=1744713602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPGCnMvFd+LYWp0JkHcVpmNOMboFHrFoP/WFEwnOqXY=;
 b=Vs/z1ajP739L3Dg7LNsUoUW5RQ9Zjz3umVZp1tsTbA9PuoETOZXaUl9wyU+HbOe6Wf
 RYMyod4nYj1U56Dv97bTeoTUuMgg/vxsy2B80xoYXE8wRIZDU7/RehhvlO+xZYgM7TMP
 U8wDmDkECV3gMowaQmsrEdQx4i2ixfK2SlIqCKPw7NGpiUbPCC6bgttwmJ5HrW4Urg6H
 xt+exSpP6KbB99Xfyk0LERk8QcNlUr4thw7yv7VHBsEiZXOkrPlN3DHjVqtyO2hJcFao
 Bqu1Gel/AiHHWE/YnXScVOIBbW4EID0qradbIh6ZUsZDLtO9EbwCLwWQwBf/Io8KTXbl
 0jNw==
X-Gm-Message-State: AOJu0YywfQF431KOgMCqwjF3EVq5YZhdjEEwZ8z8ttX/ZsZe91Ztw5ao
 xh7JJMs1MSjPQ8Jy3G0gUzzvupjSs7cwxN68ikQtmhLyu2cV7BmG+gzvtMsxwQ3fxo2tU1uNdEA
 RRt8A6UR3WqsqvOQuMkKHyxZftalTuqyYttMvrV8KXcJPSvk6FThIozbrNvRhD1CMUBqkSiHvEQ
 akBklvBCgTODNhE+7188zNRTSmudHh/ta6iCkcTa+z
X-Gm-Gg: ASbGnct1EG29rMB1Qekg7vNibCVJ0bNs8Zam6EPc64zJBiM+SAmJBRftpGbLQNqRyPc
 oHDGQjJgncPO88wTmKuC4Om84IDeNCicKcl2JQQEIi6k8s6xjQ40CCcmB3FLIugGQgzU5EeeUF2
 rIqjXtpmBPRnbUGTRODArH3V/OzUKb3L+TnBmKvCsmMHVETj84vrlWgt/Zmli/JR4Xuo5FAszec
 5uTfF0YRLdn1F4QWaCCHW6tYvVP6ULv8vNIiqwcOnmzSsxQoi4W3qcyxOjLghCKs7lExq/Gz1Yd
 espouU4xsVxgWzf7jru0Je644V96Z/InjGALEqx7KxpJz72zFwoS3JaVaocrMAsHTGo2YGt7v4l
 /uQaLguxOcX1+Y4iLT2MpUgaO
X-Google-Smtp-Source: AGHT+IEboZ9SAyDiYA1hoNqYj7+yI+U+oZH8Joj3pADiX1DBpke6XYVERBar9a5/+c5T4RHDs9TJ/A==
X-Received: by 2002:a05:6a00:1941:b0:736:562b:9a9c with SMTP id
 d2e1a72fcca58-739e711367fmr19288794b3a.18.1744108802129; 
 Tue, 08 Apr 2025 03:40:02 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:40:01 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 04/10] target/riscv: rvv: Apply vext_check_input_eew to
 OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
Date: Tue,  8 Apr 2025 18:39:32 +0800
Message-ID: <20250408103938.3623486-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408103938.3623486-1-max.chou@sifive.com>
References: <20250408103938.3623486-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4a0c9fbeff3..e8197f779e0 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -412,7 +412,8 @@ static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 {
     return require_vm(vm, vd) &&
            require_align(vd, s->lmul) &&
-           require_align(vs, s->lmul);
+           require_align(vs, s->lmul) &&
+           vext_check_input_eew(s, vs, s->sew, -1, s->sew, vm);
 }
 
 /*
-- 
2.43.0


