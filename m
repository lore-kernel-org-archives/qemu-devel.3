Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0131ECD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxzS-0004hn-Ls; Tue, 26 May 2026 16:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxzR-0004hJ-21; Tue, 26 May 2026 16:03:01 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxzP-00030K-DE; Tue, 26 May 2026 16:03:00 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D46D41708;
 Tue, 26 May 2026 20:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1411F000E9;
 Tue, 26 May 2026 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779825778;
 bh=E8bOW7It6eBbYAycvmoXErdMpix7xPsPMO3AvIAjmOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BPWhZ+rBUB/m6AHLp1ggykh736Ted4ybZQO5OqvIHDgIZGTk0tle+/t8JgBOVMjHM
 I+3l33BxLp5l2vxbCItweMZo79bPl5nRcVmTLbPvlOMatCuFnH46qAdi1AnzcbK0yP
 AUrEZbE/7BGUEpyIirzLsXW+QJvQEAh81C9v/XA4w0uTcNKvHmiV94uEEMJiPlgmm2
 2wtaRpsUTN8ZVkUhPXHa7Ss/xNyn2ZDeVhcVRNvlDtspE10O0eW5mk8MibvIZNaajA
 PdzOg8h0UGZ9lxJ+IrXmGqK076pM5Ip4bcMg/h9wWJYuma+HAmHxOFE4W2gBpINIqX
 IB/Kim62iKwFQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Cornelia Huck <cohuck@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 12/12] linux-user: Move cpu_copy() to user-internals.h
Date: Tue, 26 May 2026 22:02:07 +0200
Message-ID: <20260526200207.79738-13-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526200207.79738-1-deller@kernel.org>
References: <20260526200207.79738-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

We only use cpu_copy() inside linux-user, so we don't need to have
the prototype in qemu.h available to code outside linux-user; move it
to user-internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/qemu.h           | 3 ---
 linux-user/user-internals.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 474489f046..07fe801628 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -368,7 +368,4 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
 
-/* Clone cpu state */
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #endif /* QEMU_H */
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index fbfd12237f..0380d44fe9 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -209,6 +209,9 @@ static inline void begin_parallel_context(CPUState *cs)
  */
 void init_main_thread(CPUState *cs, struct image_info *info);
 
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
-- 
2.54.0


