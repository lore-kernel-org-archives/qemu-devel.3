Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A557AEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpAT0-0002S9-0V; Sun, 08 Feb 2026 14:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARA-0000dT-7d
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-00005a-QN
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:15 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-662fca4503cso2010616eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578802; x=1771183602;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FM0asZzRfcZSuoL2zhvQiwI0BK9oHDjIY0P5lpYm254=;
 b=B54f68KVX2O3fjVGTTyUFpEK2564sqSNVWJgjuB1W6PoWdSoX1NhvvZ7UeoTsWyU5t
 GrpFbRRmbw7qVDK5xArMQZHT0G3UioOUDrn49SHPYISuEfECt12EOKxJL9LJYynVS1tO
 9rFUdedVw1MCKOve97A/38zYpLmqtPU/CxS4zmmqY1ZqNIgS3kG1ToTfeIIVYowP3JGv
 XT6zOVjG7kBABurpZ/Ehffa08OnX0rVSV7QYdnnqFk8jk8jELwRmxnTxgOBQrCNKWn49
 +uFjjpgCG2G3E8vdqHtAEWbhz5mS+lUaf7X234ndrkR8sqR/G6wrx6OSf87dByYcdgWX
 IpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578802; x=1771183602;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FM0asZzRfcZSuoL2zhvQiwI0BK9oHDjIY0P5lpYm254=;
 b=NAiYvH3m50Fp6Zf8ReuE1tvO+NlzOxNRX/IUGEziK+CHtnHvxz2imwfC6go+MNPbI5
 8BWKWylasAhBJezCMzlftp+NmcQ7PqjvwUuWn+Mfip4hBhYKsAL3wVXGMFnUWE4FQqhK
 gHONN8jphgpo1EIVEZ0d5EAGD6G4Efrrt+TPHAs/amsyqgfE3o9YXDUm2f6S7OHkO+bv
 R1N277CUUFcyz3r/c0CftRoH62alAetWamKzCQuUPs/p7vC6MTnexbgNtUm4JmXBx8lm
 YUf6T+nTxrXdNQGi3+/SC2sSFjgj+EpsPsPRS/1w4u4+irCENQOPKWM45CLnlyZVs9mc
 W9oQ==
X-Gm-Message-State: AOJu0YxSHAsTGX+M/2UfQfdwu0uWbYNsFo/KR1AHRP9Pn65mPSad+AdS
 2Dx9qqs6+d2tC4bFXKnuB4GqqtnySVfK+Srcjwp6YMgQTg1gNjEcqNCJgJBDgg/JWog=
X-Gm-Gg: AZuq6aKDXcIjY72Y5Y9FL4Sf77ThIZ3YhCbS1nyLdduvZDg96kvzclhohL+q5HkIhax
 qtc889E/c4Cg5Vg4kuxnBlqPSN+FsjECvaD5UXXK3CpPMOX4emmMegnpTrkC9/L4MtfaAihh2JM
 V4ozTio/kt/Z8k/Xtfv9lUBWBRaxx5q963Qvf+Ai6n7iGlMQd0EWvW613wVPIwMzXFkeUz7tsce
 +usMlDwjHjoN3JzOzHJhg6C+2t+A5AOQ2Gzhphr4azfOihd+tO/3AGdOUW9BF/WKGUYj3lgaD7L
 he85Q132JLE+aBue77jA8kaQMl+BsUcc0k9bHoMpGkp2peBo3Vpu6GipgmW2W8BsHcHuQxJWD2f
 WiNb+3L/pRQVafHXxRhK/a7gz3uyQAyyP+NoucmiTJyAY1MIVbcNkWeLpL4PTPo6K3COWDdytfQ
 ==
X-Received: by 2002:a05:6820:1843:b0:662:f90e:ce02 with SMTP id
 006d021491bc7-66d09cabfd3mr4628206eaf.14.1770578802014; 
 Sun, 08 Feb 2026 11:26:42 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:41 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:22 -0700
Subject: [PATCH v2 13/24] bsd-user: Add semaphore operation constants and
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-13-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=aq4J1NbSDe3bY6QqDo8Po9Ls3EHts8O0TzcGhj34zGM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgEFHO+wYpCGTInmeXU8XZupVa22C63xeyC
 W+0cBsSTESJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 ADDvD/9/dtHTJmfTWFza2fXC5G+J2PjZTH6lvZEVqo8bZcVJRCsMVrL437x5J3OjjXaxnPgndYG
 WUPTgtPgIFxU3rFTBnWuHjfua3SNFohUptw5dTUGqFLmR2VLiL7HMA8wMa/MN9pWoZ/x1UO5FJK
 OirnNOF88/cXqkAEpwIS8Ax0SeOWovbP6jBS84t2d/iwwBSm+SVv9zmk6wP5R5tD+g2fVPqZvul
 DRD9UUULbmN+3nCOO5RsBIJQpuRm/E3huv1erxq5tDaS6lk81w40Ex/xGCOkqMM1rXj8c0ESHyU
 kd7WBM2qAsRz9ERvVo+ZU+0fk1RHtjRQmNPknF4AC3t2zb7OV5eN89EK5LCMmXcbululUuo5Etz
 7BXntpgmYu4OkUxyg9vHHmLiNKsZrUFQfkTpGx0tnpX5vvy8ssUYUwk0tSbgzAA9itthLPMTSGs
 HgxN6PI/jM4u/G+uRq1n8Wq2H89mhB7N5/8b/Kn0+apCUPK0Q/0t3JZpMyd/QVQimJqVH8t6yHH
 v6tYgEvLrONud5gTgYR5VC2HAJjLJqu3FUx8NGXr6UKJr1HCQxEaOvEjBFkeK6UpN9hrj2Xf+BA
 qxr5epKet+xY+o7bLgEQ/8034rrC6CBkKBi2A5DdQy7gmnbBjLKP1UzrgmifKsvzAgEPcKfeiVV
 fbo5oDbTVHzr6dg==
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

Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, etc.)
and the target_sembuf and target_semun structures needed for semop(2) and
semctl(2) syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 972bcc425e..6a789b2a29 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -95,6 +95,26 @@ struct bsd_shm_regions {
 /*
  * sys/sem.h
  */
+#define TARGET_GETNCNT  3   /* Return the value of semncnt {READ} */
+#define TARGET_GETPID   4   /* Return the value of sempid {READ} */
+#define TARGET_GETVAL   5   /* Return the value of semval {READ} */
+#define TARGET_GETALL   6   /* Return semvals into arg.array {READ} */
+#define TARGET_GETZCNT  7   /* Return the value of semzcnt {READ} */
+#define TARGET_SETVAL   8   /* Set the value of semval to arg.val {ALTER} */
+#define TARGET_SETALL   9   /* Set semvals from arg.array {ALTER} */
+
+struct target_sembuf {
+    abi_ushort      sem_num;        /* semaphore # */
+    abi_short       sem_op;         /* semaphore operation */
+    abi_short       sem_flg;        /* operation flags */
+};
+
+union target_semun {
+    abi_int     val;        /* value for SETVAL */
+    abi_ulong   buf;        /* buffer for IPC_STAT & IPC_SET */
+    abi_ulong   array;      /* array for GETALL & SETALL */
+};
+
 struct target_semid_ds {
     struct target_ipc_perm sem_perm; /* operation permission struct */
     abi_ptr     sem_base;   /* pointer to first semaphore in set */

-- 
2.52.0


