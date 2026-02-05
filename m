Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1952BECD993
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38E-0004WB-NV; Thu, 05 Feb 2026 12:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38A-0004RJ-Gb
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo386-0001Pu-Ov
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:00 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-409470ad5bbso567175fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312412; x=1770917212;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PPiWVS3AOvW47VBZ3usD38SgR5GcGtr7rlvn0WKH7+8=;
 b=xyo0w8mN5AsnHBTWho3qKmxY/o7/nC/MCe/dP4+IBttDK7/JmeBcRg7lgum898hzWA
 2XJpNalKRwKhdOY4SzFflnUaIt8z/VW4iNOLhNmDnLfkWeCJ4aoToPlWB55sU4ERebrH
 2NdyQxKEnJqqSX2/wdPx2hpUb9/9969OgHjvNTWev+TBixutnLOBd6eDPlPaRL+E4HL/
 f39uNkomFJ5IBtYZ5ID84o2pHXLdSOfqQju51JNLsEYqASRUzODZMQkpgYWTiwgT5Gbt
 uJoRf+MFEJdCe8QMPALDsB8oAZM+qlGhzYgE9gmPM/fKL2uBoXOu33+lepHzt1gYnCC6
 AW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312412; x=1770917212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PPiWVS3AOvW47VBZ3usD38SgR5GcGtr7rlvn0WKH7+8=;
 b=Y9caK1MZmYN4cCpNSvrB7I3McCK4OYGFKaNV2156cCKO/+fbgvP5TOSXVd2mCv1tew
 xyI+Z0CKIDfESst/TAf4PrVOgxM+PRBb/b+BzKvXS+ZCn/wm01PDSi0IARDIsZAp89Bx
 0UZEUfaVPRFdph8uIAhX6XkZhG1BnbF6GhxXy7pQqxD1gj/6vZ9dZk9ltZ8YT33PhAyt
 ZeaJLNAFL098YNDkWGnvt31LRzmPUP+Xy8SbJwb5eY+B6sXJMCmbr/VGIFVmQaK8Xkjx
 OFEfkjntj2O4EI6/nIKuBkXxLtdec7jVonRKxlsoB9GjaY5ofdR6/INgK9v+za+G0MsY
 hqtw==
X-Gm-Message-State: AOJu0YwX2/4qH5Upz8+eSK8UpTbzWcoW+Bo5BX2KV8iEmnYt9VPba+1b
 iPa9WO8W2Jh7Zg31d6/30iadDJ2JTro4D4S4YstP6UV32/lsnGyqO6tC3ZG8R7dJc6M=
X-Gm-Gg: AZuq6aKJF2iZaRG3mJ6x08Cc9BsEwpyJ370p0DQZCvxac2YLEHB4G7UX2cD40OF/DB1
 M5PnBEijRhZSEg0J04Ebe7T5velecPhr2sS46q1M56lK9wwyhYSqOHkmlBW+6Nrp5aXnPp4PiJj
 b+rQBO21+uzzs0Fz5hu4+yJGL4CBpdplh3vfkC8MjdOzvNjw8fCeGm83FP8V+ip/Grt5EBkoWQ3
 LLTFEm6em5uAXAlHSOhchZ6uEsW54BVJtBQfLs39Fy1U58b5a3c9rH5lL1fq2Cayi3/krC2FdDn
 +QSxwLBcRDJH5dxZEg6yFY2Q7pfIdIU9Nl3JD7vxYULlNa+IxxTaS3nCX/cWh+x2VEgGO7YavgU
 oFqMFlWXbiVxHi+fHptbtOO8ORAWu5eVJcBbsm+1z9QJESOLw9ksr/g3O5+EQJGU1eAnu3TCwSQ
 ==
X-Received: by 2002:a05:6870:56a8:b0:404:3cff:5153 with SMTP id
 586e51a60fabf-40a96c554d0mr21406fac.6.1770312412079; 
 Thu, 05 Feb 2026 09:26:52 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:51 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:44 -0700
Subject: [PATCH 11/24] bsd-user: Add target_to_host_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-11-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Brooks Davis <brooks@one-eyed-alien.net>, 
 Sean Bruno <sbruno@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=zMEfc1Vd7zZ6zBPnPPMcXMiMj1EeOGAXcHxt8CJhQgY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLa0aTxJNVVEvrGcLq6YcU3ZnWmL+8Uehgnj
 Q6Rapo6coWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 ABDZD/9FiBJM+E/yqkCk3/XpUrORAT3RvGesTYpj2Zpx9IjjGztVZCSQ7nzGZntUshzM03QVe2T
 wxBWi8gu7Y2tYZda+/U5k6xTMdSUyVNzKWNMIDHKtS43eHkwUWPX1pgvVV/00Q1JoziI/nE7IrE
 I7pSZZfIw8Hx2fyjSgHmhNGvSIccdkHTuiZHmLaMMmiHkw39xvxcL8D0NeoxwNsdkrSkNQOo8WY
 5fnpxkKcqpUaS609jp3Rv4/PVGS5tdqDYdHr3IZPA5jQD2fRn71GxOXKPz0HWxLo7r5rDx5zL4W
 febGSz2xVdo7Rkcf2oN0HO0KQQfhDquNV99HYhYzYBZhXVDPu0g+42WdvrwSslhF6dCKCayrlCe
 yT5OT1RyH4S3kXvXxEof4hla8RpX5jDDoK+7HoUPLin9FxEmTH+VFQ8epYpfsOrtIarggxId3JB
 wDvD/isTvhJqFMsSHOKn5U6iplwDhEBaRl0jmO6hMVpwsus5hM8Wd2uT3EAhRhFADoe0PpKCpQP
 pezBxbcuSd8PgZYrh0DdT1A0pxG9QHJTa3Z5UdCI/wf1ZGHdhnaFBqNwk24X4pWN2RfzZiiFJq9
 TMYhdS8qaUUgMMydYPaHKLc//nhJMhtuSRqfuYUz+rN36IdCVFVo9Tlnwi+7k1E9GGBtxRXzbXs
 tsb4BCqYctQ+yLw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2e;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2e.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add target_to_host_msqid_ds() to convert target struct msqid_ds to host
format for msgctl(2) IPC_SET operations. Uses memset to zero the struct
rather than directly accessing kernel-only members. Handles FreeBSD
64-bit time_t except on i386.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index f35f682aa4..e7031c5264 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -154,3 +154,36 @@ abi_long host_to_target_semid_ds(abi_ulong target_addr,
 
     return 0;
 }
+
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_READ, target_md, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(host_md, 0, sizeof(struct msqid_ds));
+    target_to_host_ipc_perm__locked(&host_md->msg_perm,
+                                    &target_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    host_md->msg_cbytes = tswapal(target_md->msg_cbytes);
+    host_md->msg_qnum = tswapal(target_md->msg_qnum);
+    host_md->msg_qbytes = tswapal(target_md->msg_qbytes);
+    host_md->msg_lspid = tswapal(target_md->msg_lspid);
+    host_md->msg_lrpid = tswapal(target_md->msg_lrpid);
+#if defined(TARGET_I386)
+    host_md->msg_stime = tswap32(target_md->msg_stime);
+    host_md->msg_rtime = tswap32(target_md->msg_rtime);
+    host_md->msg_ctime = tswap32(target_md->msg_ctime);
+#else
+    host_md->msg_stime = tswap64(target_md->msg_stime);
+    host_md->msg_rtime = tswap64(target_md->msg_rtime);
+    host_md->msg_ctime = tswap64(target_md->msg_ctime);
+#endif
+    unlock_user_struct(target_md, target_addr, 0);
+
+    return 0;
+}

-- 
2.52.0


