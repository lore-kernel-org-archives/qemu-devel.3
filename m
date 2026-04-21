Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC043F588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3k1-0000Y0-2W; Tue, 21 Apr 2026 01:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jz-0000XD-6c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:43 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jx-0004SZ-MV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so2359580a91.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749620; x=1777354420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2q0G8FN7I4cT2MFC0mi2tKNSJeFLTR85NiFHhp78wA4=;
 b=erismwWSrOUSGlbdl2AvdShDpsLOOEYdY3NJ5w7Xm/k7zHEm7rxKB1fOmADgID0nbn
 8s9NMQ6pX4FnSzWV0+RthaeJNkVzfunNVFU/26avykHtRHhQVdPwpSTmJxaL0XzAgicl
 OsynoQgeUWzWoDlPr1Q4L09LxIDTcb9UpXoReNwa2zCZUaDiiT2S9l7PLjTc+UZ1nHdQ
 14MjqYzFQhiASa6guD+jIZnG104n+x4PET4JOlcA7cn+ZD9ryHnaOHXJLbmt0FwWTDcR
 4T/Hyz8psgaKlKkKfnH6G0EWwY/ylLNEm/2Tp3WhyZ0Csb7uFZ7EpMtbIYY01bfNy9EC
 78mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749620; x=1777354420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2q0G8FN7I4cT2MFC0mi2tKNSJeFLTR85NiFHhp78wA4=;
 b=ZQyQYWu9oiyjngBauWYmX0p3ueSZCrBYXhS9zXVXE7hkpdsOg/e9UUUL94Wi/q8I4b
 hnbmyVAqRAeW7km4jGkGwOH7P6JeqZ4/O7OuUbJnXChHNdh7cQvg6f9zc5VqTmk3owix
 1bquEZ6+TjzMajUu3D3IPqnA2E0ftLURIsyA4HZNp9qPxF7wa6yy8LZlKOCZBME4iCmT
 f2IVROYkHhojLmKks1wTVVUzerKvyak/02rSUSIQSRRUin+htQ8XE9l8cRf34tHnCRSq
 NBGo8tg1Yi0WwB1VQaJRNBBcJXHd65xd1Zup6IPIpgBnsCJaJnPnI9R6Z+E+Y93QVLwu
 npUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Qqky4n8ejohbtyc00xJHWG+95tptpTIOjb9TEbHlbmT5YJfSJRbK6NBLgTcIV5QEx2ogQ2YcltXWC@nongnu.org
X-Gm-Message-State: AOJu0YxPppJ1LPtKPgBvN1/frkCPTZJL/ChKUXs4VO/SKvKqFYc4JqTg
 UCUApHut+dfHJ+CKxwMhIukVOqndU5y3hgPqfIjopNl0soqoWSU155Ej7xrWhA==
X-Gm-Gg: AeBDiesHIbrlYGcNwmCSclPNMnxRJL9rpZ7BHG1KTwAnpntVF7Li6dpwxqUwSYvIapJ
 xjxwDjNxTIa8uoALAkKLDGjHkd1F6IGnms9jg49gP5yf0w/M7qN39yxOnX49PCNgT5aSXJFUZC/
 VAhVxxUpAoN5urd6QhNcdmPBzWQcxXq4ghIRBdyTpMZoRSlHmk0+QxuNLm7EKt4GHsS9yzIqSBx
 l0y35FkYEXEzQCVmaXqP1i6lCWPaWHY7H71XWk1Fxslh+h2GUX190yYPRIiorHFDIw/ypfmMOKw
 JooMivacPdIG5gwkcPIR4/FR3RdJCIQnvnetlLyOPBqwLhQHjuNbL0SOSAM60QukrGkTLJsTyFW
 ZbeYZcU80+jeLXWNBFGPI1nUb+L6UJc08ayIkcQJuZ55J/qaJ4l6FeLxkWrsLLqHnhGgqxqYJtN
 Cb7T2sn2xYbOKIp3NoJzX/4DB4wKt7gbO1iO7mougoB1Vj2HG+WFYd/yq0LgnfoGitmAGpFd0qV
 Yzu6ECnTY1XDPKryCO3T5avXovRjjHcfM5glQ==
X-Received: by 2002:a17:90b:5286:b0:35f:9ab2:a5a6 with SMTP id
 98e67ed59e1d1-361403d5b55mr15467475a91.2.1776749620509; 
 Mon, 20 Apr 2026 22:33:40 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:39 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 08/13] target/riscv: tt-ascalon: Add Svadu extension
Date: Tue, 21 Apr 2026 15:31:33 +1000
Message-ID: <20260421053140.752059-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Svadu (hardware A/D bit updates).

QEMU makes Svadu and Svade mutually exclusive, remove Svade so
Ascalon comes up with Svadu working.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index df01a729bc6d..0997bd3324b1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3203,7 +3203,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_ssaia = true,
         .cfg.ext_sscofpmf = true,
         .cfg.ext_sstc = true,
-        .cfg.ext_svade = true,
         .cfg.ext_svinval = true,
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
-- 
2.47.3


