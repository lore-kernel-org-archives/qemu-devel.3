Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB63BD1CA19
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ATX-0002be-FQ; Mon, 04 Nov 2024 22:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATV-0002au-I1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:25 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATT-0000zz-PX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:25 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a6ad7c5827so15387255ab.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 19:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730778202; x=1731383002;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxupo8oFWODoy3tJk0gzDbcDaAczcX8zGzXaJjAP0cI=;
 b=UDa/0pnwXA3cMOQhz7N1A7goXY6J6jE5YcK7PRvmvY69/inAlLVXTbofTTygfRABYx
 gaRCP9rrYNWCXBwHhFgWsntG2oSg6x8gA1OvD77IrpEQlNArY1rS4HVIVrpJXVDupdS7
 IXf1y7LKsNMxpfuQV7opQtR3jDcms7u6ujx+/miw2+Gy7QcftVKK8fx6MMRk/h84pEef
 eDR3BKRH0YVYvE/pwMA7e8pPw0Z/V5u4vpj0zpzT1VsTuTrEYuWGk0Mka8qDygMq5Fbi
 yzGvlBXSQ/sAksQO4DLFObTbHfMO3Z0Ci4G07IqMDgtnaJfTlJCDCzJPABzb+lbIFMlT
 YtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730778202; x=1731383002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxupo8oFWODoy3tJk0gzDbcDaAczcX8zGzXaJjAP0cI=;
 b=fMG+ti+tIOcEIS2PrTweE7OPxwbnEWhZQGuiCnD1Rdm2llC1z7zdRjfHyy2hSnU7z3
 MeWvOkjScCpGEMYJyhHeU+pQ+GKZR2m9hFavgGHWJUSFP1pCOnRQyxWr+/iqukkNSJw+
 sAB1NWQaOgLdq9eEeR3ejatPLExpjigey7Din5z1JRnJr8LkFH6uZarafu4BU3YGsVEL
 4qfA+WL6xPArW6w4Uuol4rCusSihCzh0Y1yibLE4aW/LmuulGrz7XwvQLp7jSK2oFzV1
 zFZ59rtTmdhe178XW3lAs5TVX7BXBVKOElwTm6+/YrnN/H6fqfqXIpNS1o/SWlSgcUxS
 MRTA==
X-Gm-Message-State: AOJu0YzdmPbz/AQVXKIgEd+Fqfm1uE1Cov/JNQecaGPsLWRy9qD6h4qs
 O/5wZjNBbUGFCoZb6SfpeOJLBizGhhil84agQ0MJ5smb9G1RSiybvAKjL3/gYV/WtBCnPl81Vba
 6yi0jHQ==
X-Google-Smtp-Source: AGHT+IG4IVy0HfrBY+gYmPrRTeKxg/rQWyud+UCaPvy/I2jdAEnPWhDH9NmtkGB6vS6iUjnjisYEDA==
X-Received: by 2002:a05:6e02:12ce:b0:3a4:ec4b:92f0 with SMTP id
 e9e14a558f8ab-3a6b031c94cmr156516725ab.19.1730778201964; 
 Mon, 04 Nov 2024 19:43:21 -0800 (PST)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6bddcdcd8sm17162665ab.37.2024.11.04.19.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 19:43:20 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/3] bsd-user/x86_64/target_arch_thread.h: Align stack
Date: Mon,  4 Nov 2024 20:40:37 -0700
Message-ID: <20241105034039.31143-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105034039.31143-1-imp@bsdimp.com>
References: <20241105034039.31143-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

bsd-user qemu-x86_64 almost immediately dies with:

    qemu: 0x4002201a68: unhandled CPU exception 0xd - aborting

on FreeBSD 14.1-RELEASE. This is an instruction that requires
alignment:

    (gdb) x/i 0x4002201a68
       0x4002201a68:        movaps %xmm0,-0x40(%rbp)

and the argument is not aligned:

    (gdb) p/x env->regs[5]
    $1 = 0x822443b58

A quick experiment shows that the userspace entry point expects
misaligned rsp:

    (gdb) starti
    (gdb) p/x $rsp
    $1 = 0x7fffffffeaa8

Emulate this behavior in bsd-user.

[[ applied Richard's suggestion ]]

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/x86_64/target_arch_thread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/x86_64/target_arch_thread.h b/bsd-user/x86_64/target_arch_thread.h
index 52c28906d6d..7739bb2154b 100644
--- a/bsd-user/x86_64/target_arch_thread.h
+++ b/bsd-user/x86_64/target_arch_thread.h
@@ -31,7 +31,7 @@ static inline void target_thread_init(struct target_pt_regs *regs,
     struct image_info *infop)
 {
     regs->rax = 0;
-    regs->rsp = infop->start_stack;
+    regs->rsp = ((infop->start_stack - 8) & ~0xfUL) + 8;
     regs->rip = infop->entry;
     regs->rdi = infop->start_stack;
 }
-- 
2.46.1


