Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F614ECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38H-0004Xl-NY; Thu, 05 Feb 2026 12:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38A-0004RZ-Kh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo387-0001QQ-Nf
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d122733808so498997a34.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312415; x=1770917215;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CuWeOQks+fvw1zbKzfGy/qHCTSMXEJG4lNxOvfDbm7E=;
 b=RTSex5sqFprvx4bMS8dpxc4bJk3/IRO2L851chUWWKV4Uxjzi2DaEVbLqns8kuf+4Z
 SdM/qdAjdsCHqm8WzYVpTtwj40VA8IcB65FB/8gf3NOi7fjYUkxcXG4c2qOHMti61vkQ
 GFk8ZLONrCwgnN6BjMwbhiMojYYhclniQe7HnXWTMApjBrqPfv/gAnionVny58N63flF
 ziLlQz3X7l0UnPWVpt+jO6sKE+FLojGe3qwRJuVH0r6g3n5rNWOnKXMKOVfX43vSRcCs
 ArsF4KJ3Ydk8VT1UXf+KWyCuMQQmG/sOmxJEUkiTrk+PGjXA7Rd+4YvVAV71Sd14q2Dj
 ihPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312415; x=1770917215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CuWeOQks+fvw1zbKzfGy/qHCTSMXEJG4lNxOvfDbm7E=;
 b=RtNeiiFe8qE0mY7ovQi40//nzk+9EGj39o1MylcSVSd40vW5YdEJ6ooPCTB9V7s8wW
 CQdl3p1XHH6eRSW1huw2nTR1WV+22vClxY86Y2XOKZb+SD+OWAmGxGp6IupldLR3FyMy
 0YT7SvOlLR0PUsnP1DKNrO+pEzWK8A4C9pE6iTzuL1BIJDVO37o+6XIDH3bXL2trSdqU
 T91V5ueE3mSR1PmknAMVx+FKhtaq3+OLOSjsVryqMITFXGHfKkWGiTM+EppeUzK146t3
 rcy1iaBL7+fIwbmPe1RX3TSkn3/nmKIqwZ5710PeLUj9KS9snLopZBSct79hDU2E/O1i
 udOw==
X-Gm-Message-State: AOJu0Yxl7Ab2XK9blAy7/Gc9bT32N9zIxO0sNOuHxdezEFwjG6Twxexe
 qxn28s7awE4AGuFGP/HR7kHjswxR8yMTZowb6k7Gm7xe74XaV/WdwqSTTSJQvS1L/6s=
X-Gm-Gg: AZuq6aKQhrRrPivLOcj2mtU3EeeXBohmzhl0yXZy2g0TUIk2JNLsLN25Sd8V9xIvG7c
 7azjxwjaPo9tSLZHDQZb7VfEEVVQ8gAwTl+dQCzjjzUKxhEqhdGFpeJZBdLFMaJBwzCrxfmVIqx
 HKhu3gq0O5JmCmYX6id5GaS0EJDXisbxe5PGBAu2BMeQQ8XGRGRMxiySZ0iQzHjP+yHgqBh0/3e
 zmq5VlPwJp8zziESaE2fdr5X0/AwbtlowX/vMrRULJ1BqpS0jN/NHJ03ndKW7mIcl57lRXfWRJP
 GOy0D0e25FQ3yr+BJjO0r/UGv/uZt80GN3gGqbCsIA37vSmLtNfMzNrFxy2jPPSEEaEb2/enVys
 HVehoG+8mkH94hfwRsW2prB8DEpywV86ESb9bNBCr4cUogOYVRaEuJPVSZhvYi40VXlyNULAOcA
 ==
X-Received: by 2002:a05:6830:6f90:b0:7c5:3c7d:7e65 with SMTP id
 46e09a7af769-7d4489fb23bmr5045560a34.16.1770312415290; 
 Thu, 05 Feb 2026 09:26:55 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:54 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:46 -0700
Subject: [PATCH 13/24] bsd-user: Add semaphore operation constants and
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-13-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=BJ0cbUw5AoSzyBQpV3kLfCVovrwVpPTWaScAW7OfjBI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLasZ8N7Fv0e6s5aPV3e9euBRVpQ2WxeLYr7
 vnggSf6yjuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 APJQEADJUN1zCYfUtzZw6C0k1H75zIxIw1x1/0X37PttTqI6JGbLVT1fU+/olqASq0q119zoTpr
 40FC46RRVqei7e+gU8W8JpTviN7udKLevdJtXKIgAx+NxuaflneArnmeLe3A4Wu5R+CoCpue0X9
 GmYHYOHJlEHqtEZRznGCEFSBXgLUmo25sLnsQAFv9dq2csISu9lUd2DoxBN/fx3lmbX+225fw76
 PJizeMWDGCU+fHgz9E6SgHpcC/t73nck85/AIWfGetR+Ke+FG2KDZkX1DZZeXjswie5nxVIjQFe
 D40ibT5vaAV2I3X9oPUAuBPeTQyNVAZLqFu9tRdZ9+9FjwAlRO4rSKXvtJTdIloscK/yt7vL50r
 QCz0Sb1T/QLcAOblIBq2SbXJVTsqSmH1L6L7RD6B2OAAedMlO88Daw7KYT3E0Ljg3EiUPqncy+B
 3I62gLY8DSi4/grhxGCXDYNCvc45C/7cj07Zy+2cbtNTkEqch8bCG4az0BRiynNaImXVF/AsoMk
 EPg9/aiNppke7fCujWxtyA20R4FsaukJCeenfRBGF4N9m+qyXItQxpE3fSVRGP5SMlhHRYVu1nf
 5T7Yis7cP+H+gZ/sHZJaa2bRVCUPSMO+XsnjW54StpThK+D4/IHnOntzXlgrBr1Qz3dxSiP/7fC
 KiCdZBDPNjC0zVg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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
index 62b9bc752b..becd04efb4 100644
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
+    unsigned short  sem_num;    /* semaphore # */
+    short       sem_op;         /* semaphore operation */
+    short       sem_flg;        /* operation flags */
+};
+
+union target_semun {
+    int     val;        /* value for SETVAL */
+    abi_ulong   buf;        /* buffer for IPC_STAT & IPC_SET */
+    abi_ulong   array;      /* array for GETALL & SETALL */
+};
+
 struct target_semid_ds {
     struct target_ipc_perm sem_perm; /* operation permission struct */
     abi_ulong   sem_base;   /* pointer to first semaphore in set */

-- 
2.52.0


