Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0950FCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gu-0002vZ-FA; Sun, 21 Jun 2026 00:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gp-0002tQ-2t
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:47 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gm-000525-WE
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:46 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6a0eb19ff49so819878eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015703; x=1782620503;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rVFgNUzEgNeXkvcwrYEMpHw8aucEjPJtMHF3BkvZjGY=;
 b=F+Kc2km4omhlGdWceNMgYkap63XO/jt7MzdD4D+GFLW9mvOmrC06jHQ2+Qttya1IlC
 xwMSGw7QeHL6flxEs09Dhdnu8SAWrNXbLgmawQiqaxbIEsoi5PiRcUYH3g26+LjPeV5D
 OKq/cZ8x4Ygdwwi0NAU4w2ZOVe0QlPDzZ7RVHiRrNtj6fBaCncJlazVMLvGSfusXOtbv
 NlzbnTuAzYof90LNcUJ3Kf+XeePYBibpBcZg/JTYTzVOheq0Emu+6Ff9c/HDXmuIPpS9
 ON27S2rgjZJ9mFvX9G4cqi+D4BDSVua0JOJFFHGNzv/3Ks7Zoh+LICJUNQ6XNKGi0X9w
 UPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015703; x=1782620503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rVFgNUzEgNeXkvcwrYEMpHw8aucEjPJtMHF3BkvZjGY=;
 b=mvgxT+NsjIdLgqCljilq/UlX7ZIZfZ+2Sk4ZctXo4lMibCJxoF6ShucmU+isRsnI1J
 z6hlGsXFsKtCXqX+r9LpR2aaRMIc+yqIGGJ1mz80gDRwqKOQPTy6PAY3cgqv5LQVaCeq
 /ge0xsv2l8jMSpua0R12ySzhyqi1PCT0QDEX44Fxk8P5Ct3B97xwHZdFmkP7V6B6hsyg
 aOcge+DgHbMuTTlaMzutJFcJfDg9xGyzv25qzwxeWkexJRC1vX9QELkjqnNz3KpUHc0a
 dhq5dP/YqtQRZ4xpOODLciFFx8/kX9Jk0iS/FUm0mUF3YsdqxMEUBntRZcB/zmSmjw8l
 bh1A==
X-Gm-Message-State: AOJu0Yws2M81KXXpwdhSSkQXPC0h/mXH03o2kIEL+I9zP2cbTVWGQ7CK
 EXZ/sjFrVjGnmkXrKYl1n+TPnGw9AkguEyqzNCJsx7kyTXR1KBzorbgubayYbWSu4e4=
X-Gm-Gg: AfdE7clw7ICa2vREkC8PF/NMomX7ouhKJtD3a2cJLu0hL+I/Ie5EjBwIRMgMEIBAXA7
 JrePRFHRBwRo49aJgxVvsJikl6t+r/XErjfo3cocp4AWSeW87iA1LwyfRRGJGVHVgAw/3nIELdE
 TObJEAsUKJ3d6P3TDIxEDhf0TIfMFLuKvmmrlkokikFDPUgDejDnBdUqJwZYHnh3UuC7iDk4Boy
 I0WTqt0q8K0y5NsNEUsi9QjmW8zh+PxokyzAB5tZ8PfLqaELbjq0APlFf9KpBq3FbcnQYtabiOv
 TkNhJ+gY3AaSMxL7vBFK9JV/bTmx52v8FjrSKO+CfX3jugxna6u6HWL1+mrzIkDSsoPa87RrLyN
 3pqgVR/kojkOB4z+Psfdv1gBnUswbUKsYNUp74DOBnDP0eP6C8kpcZgl4DMwW+gZD3t+rlG+ngh
 g=
X-Received: by 2002:a05:6820:200a:b0:6a0:f2b9:c318 with SMTP id
 006d021491bc7-6a0f2b9cef0mr3474199eaf.7.1782015703160; 
 Sat, 20 Jun 2026 21:21:43 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:51 -0600
Subject: [PATCH v3 04/40] bsd-user: Remove accidentally duplicated prototypes.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-4-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=O9RD8iWIp9DwL2VmoJ/fbF+Rwdx/qNLPhxiZGhqs58k=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z9WGUJUwB/ANnvmF6iwDUUSHO5T7tZVRbpP
 n4rfam86ZGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 AMQKD/9ucmhVrDT2EAdE0eE1UqhbbmXlOD02Vs7ah5SoXh30utQ3cRdGaF6cFL+G31RXJIp7xE7
 ImHCCR3cuCHb1JSFivrG9V6yRnmQyd2kCUoOuty2Znc5icaGi+yElTU2FOPnZp1sPlZiFl+Wgm7
 P9idwy6vP9jp6Bs1uC5GFAZFe9sWBSmYx/wlbtivSrig7JZNOFQLyLw88W4S0QFK8DFgxYDW3IK
 FLbBDcGiMXSheIrIVP7xOfw3h9onPswIcQDvWHySpzhPwuZzsj4laUjkJsGRLrGO+lzgifn8Bjz
 jdbBcKxAZYYoL1OgG8hUjCJ93v76HB+ludxu8cF5unXzYJIEA0hyjRJqWS7D2s8FJKA/pjEvFW1
 I1HH0yAg6xc7cykieLkNKa/XDAs/CMy6BkWCBCFyJh9IHsjCCONZMheCIhLc1hBJCMunvv3CVIb
 5OS78EwlWi1QfM5kIO8tB+Sc8d8uK2JCWXqw6mtNGWMYhvz8H19XAnRIJqckTw/Juu9NCvpOrpz
 rJnSejwys/5XTL88n+RC1w4lk/m4xsmy12CyJ9S+8M0gjx95OLEYbf6j5M9or4EiHPWDbfE2q56
 NK5UzuStBG2nKBTod1Yoc7IxSmR3kAb5koc8V+5wBdT63dQkHNGulxIv8XiDIDxWkUlkM+8EGDm
 4oBQm6iCwvNgx9w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc30.google.com
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

Now sure how we mismerged these, but we have two sets of
prototypes. Remove one.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index f7c8338213..cdd27b44b4 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -50,29 +50,40 @@ abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
 abi_long host_to_target_msqid_ds(abi_ulong target_addr,
         struct msqid_ds *host_md);
 
-/* bsd-mem.c */
-void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
-        struct target_ipc_perm *target_ip);
-void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
-        struct ipc_perm *host_ip);
-abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
-        abi_ulong target_addr);
-abi_long host_to_target_shmid_ds(abi_ulong target_addr,
-        struct shmid_ds *host_sd);
+/* bsd-socket.c */
+abi_long target_to_host_sockaddr(struct sockaddr *addr, abi_ulong target_addr,
+        socklen_t len);
+abi_long host_to_target_sockaddr(abi_ulong target_addr, struct sockaddr *addr,
+        socklen_t len);
+abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn, abi_ulong target_addr,
+        socklen_t len);
 
 /* bsd-misc.c */
 abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+
 abi_long target_to_host_semarray(int semid, unsigned short **host_array,
         abi_ulong target_addr);
 abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
         unsigned short **host_array);
+
 abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
         abi_ulong target_addr);
 abi_long host_to_target_semid_ds(abi_ulong target_addr,
         struct semid_ds *host_sd);
+
 abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
         abi_ulong target_addr);
 abi_long host_to_target_msqid_ds(abi_ulong target_addr,
         struct msqid_ds *host_md);
 
+/* bsd-mem.c */
+void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
+        struct target_ipc_perm *target_ip);
+void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
+        struct ipc_perm *host_ip);
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,
+        struct shmid_ds *host_sd);
+
 #endif /* QEMU_BSD_H */

-- 
2.52.0


