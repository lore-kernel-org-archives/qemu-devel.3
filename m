Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F101EEF06E4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARx-0000pP-V4; Sun, 08 Feb 2026 14:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARE-0000e7-Rl
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARA-0008WJ-2w
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:20 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-669287780f5so2381979eaf.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578797; x=1771183597;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jv/Pz4+h+sV5yTF6uW+N0Qa3lKHnOkepLTCl9S0w9L0=;
 b=iRxD/dADQyNJJUEqdDlrEwdSYkES0Xe1goGl7xXl8yIwcDZX+ruGDNQMG2z7ht28hy
 OUzEBkkfwJQJF8CqGh/pBwSHs8jnD1nUw6QbNcoWSqk3X/oJL9oQsS6UM6+lX5U//XL/
 RMOCkW3weqGObk6g/MWw6lLOXpPC+tfFDJwEA2NFW1W7UhdC5pzNdHUCnbAg2Ee9gT5T
 DMBqi0ICA/JIdtDmGu9HmZpXvDwobPfJVJlGx2eIB32GjYV/WwI+fh8VqKGsgI/97D5T
 fjyrySNvNOEp58JVc/LQk4yMMykThkpYysE43moo2QAXb6GCDlcn9BVMJxD0AyghdRma
 uk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578797; x=1771183597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jv/Pz4+h+sV5yTF6uW+N0Qa3lKHnOkepLTCl9S0w9L0=;
 b=n+WrMcZ6S059EbuYBwOuRnRdqjyG033dz+Tb4rLNsGk/Tq2SCU/SCF7mDEkW1lCibr
 hRF9wOw5Cjx7wqNdjMkAKdcVKFnMFSDzgVKIcWWepai51MTZaUFXq4RQgtLm4mNieKUL
 OBPWd7PU8mwY51HCGnbqZhSqD00p2+h1SNTFz7GGWPsMSV1GNSiEict17RMMBM3MmCIg
 ScQVhNyGi/6u9FKWe2cI3LwW1pL2zpp/r0gS3iXxyQa3v5g2tQWlfIWEen7KfUCffy6r
 IgB7ECnYLtYoQg8ZHPoK7lHIi8UUHflHVBKO6YuuOZSXTrN26/Enz/iragMllruTKgSh
 QBsA==
X-Gm-Message-State: AOJu0Yz7wvkGHMqGwHYQ6ds617siKR6dn4GtXsfPRL0VSKbdmnxXoaip
 7r3tmll0g8Eyym49CccFbsRINcpDcmLuse009RwfFOpRWXeKl+B27qH4Zk8dqkJfV7KiT5YccFB
 xRuAa
X-Gm-Gg: AZuq6aLJJjgIOrSyBfUKkH+5ALqZtiBjVuywxGPjKSzx40AW8loWGDwYxjMR9PEUO8h
 9zfhtLeJavMI6p3F5TLcyarXkjTqxAcaWX7dxhBWRMuNcX2rqwOp2f2UVUFLz21TkZ6RKDsSLFi
 2zexRw7KHeOlv2U6owjxzz2WZCk3ED0T1E0lBHYXQt1nTmZD6Odc2LarcUtp1lcotSjZ4vgHQUR
 U/yll/IXblSS/8jL5aqQLPnkLv2loZOvZIlTPvMx3IZUNrU6M0aSdC/iL3/Zf5aUA/Yi3qhB78Q
 JsTnjShzdvGjnicf0T7/SOgCndq8tqHwCygcqDiKDGn38AHDC1alXGkAyfvKdHYd8XIf4JyfxKz
 9CcKd2YAO/ft93X7LwUD7pYLFjYWsV3R+rv7kWPpdFiYZDNAaUJxGUImg6j1iPXLrBxbfPiayZ4
 ACtQR1z1u2
X-Received: by 2002:a05:6820:606:b0:662:8e06:ac5e with SMTP id
 006d021491bc7-66d15c0fcd3mr3801884eaf.39.1770578797196; 
 Sun, 08 Feb 2026 11:26:37 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:36 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:19 -0700
Subject: [PATCH v2 10/24] bsd-user: Add host_to_target_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-10-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=MUQYNL+nOFXyZisTQGEN5eorGSYGJF8F6LnVYlzUDQc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgKdRb9ehG9ndSjDphCOdEY/BwlA5pHVsS3
 GiNDiKm8pqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 ALcqD/42JevE7WyV4RL+dmXXAXk2xK0kfsw+kragJ+HquEYEsG8HYhwGeQIVlZc3yS2AMeERJ1i
 DyS1utDenObD5MjqAopkxSGKGnpHrWvm6MgmTGKN2+dCbNdqmIJpcG/oCRb7iqwqs+JxL2VCwAx
 jH3Xcw8xLki2ja+GOD6xNvAwLo/6dZr8F3RvoB7ACiz/c1RL77YqBMrecZxLMNVYZ/jn0v4J7h9
 O4uk8A3D8kpAKaJcYikrNr6zMFOIm3wkdF+eLCo+H7uoo0vHsiiMYIq2tkRvLLt9aX3cyXjO+zc
 /EghLc1iTBU2sln6q0Y5hIDzJ4pnVHcKJaMrMIcRSRGNlSkV6TolcF7vRCkNVjQBkv1AXRjb4cN
 4HvCezCtxgOqn+TsoGZCcmkmyzcxaCTOJ4WYfdkgVDEwX3eL0d7EOm+ErK2TjxNGd9GvUeDKZHK
 FZlhsQUgBoEARftfTnapk1itHDx2p+gzWvC1gn/7aSQC4kS4erXsF2eVda3I4EA0BN5r4THbMlq
 bmpwCmDoCaBlnvD27+ULdgffa6t+l+i6M2y05IzQRbLyD2HGQIzjzfH/d403owPe1yOwpW9Ue9v
 bYVKQGomhwNyVhWwpf9InpfdTwNGHP4eoY31q/TGXbT8YoFIYy4e4Ao1zOOscsOe7aUNGiSc0Zu
 YZDuMtM/F1yx9YA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
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

Add host_to_target_semid_ds() to convert host struct semid_ds to target
format for semctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 2a7c0520ca..9c47073c5a 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -130,3 +130,23 @@ abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
     unlock_user_struct(target_sd, target_addr, 0);
     return 0;
 }
+
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_to_target_ipc_perm__locked(&target_sd->sem_perm,
+                                    &host_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* target_sd->sem_base = h2g((void *)host_sd->sem_base); */
+    __put_user(target_sd->sem_nsems, &host_sd->sem_nsems);
+    __put_user(target_sd->sem_otime, &host_sd->sem_otime);
+    __put_user(target_sd->sem_ctime, &host_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


