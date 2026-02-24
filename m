Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EABF3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbM-0000yb-Mg; Tue, 24 Feb 2026 09:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb4-0000UF-OK
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:12 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutay-0001Jb-GZ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:06 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so2348423a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944062; x=1772548862;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TRM3Oispr2CVqNb5Tfdu3Fuz7LopAWJ8TkqPl++2V8Y=;
 b=F7bVSZEF3O8Bl/EfUwDwsJJw1taF7roc99rtOPx/SRGUvU78akd6u7RJtmaXWDSrws
 gDLJpd3KXFug7fwy5+AIl/tE2So9kUJ1CTfynnLxfgscvd3cqS/HCF3lebamG9AQFMcE
 BEqTkdMFCPQAz6kESr4GBkFqS84Ave238N15eEZHU8oOifd6LJY0UHK56wOpjIWfT/jd
 +GRv2PQtI26kJjEH4+FckMa1Heu1RDQ00O9zgbF3vqQZhNW2vvaaCWeRqv7Wh2Onrvm5
 PTcLO6+6e/o5MaQFfFOC1rpD3GV6B7Z2eqLBDg32ZQNgt+gewSexoPc9Q2fPKkPUzcCE
 49tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944062; x=1772548862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TRM3Oispr2CVqNb5Tfdu3Fuz7LopAWJ8TkqPl++2V8Y=;
 b=KUUr2Ypb2s0VNhSZsr1/zyS2pbW53Xm+NG0LDAUXYqPhJSGfsbQTqG91+c8CSQ5U+A
 UWti7o+jB/SPbDOqtiTZ3zg+leId4QWhDNSnw7HHJ9jRE4xiXVdq47w5jyWs3DLvVPux
 23Dx1JLFoHtp/o0oHXD7s1uWk/KKdoUmf43a8s8G5XLlWDPIX9X1IkEYV5I0XJVvfC+7
 lakaol6fm5qVd9wbpz7SIP+v4ybdQhxg/TyJiZXNG1uqMIIT5RBQM0A76NJ6RYIOYwRC
 HLDmHWu11QDB0XVzwklrMCGOlg8Y9gJoFbVNAUyTmAURSfq6V8HbznslMCkAVM2UQ0xL
 tixg==
X-Gm-Message-State: AOJu0YwLjecuI1Qjk7VA17ktwaKhavbUJIuQE0QOhoOQR816+R+RA2Xm
 PXFF/TrNB/pOWadELD5SpBAw67ltmUlTDyHvjEDVg+VDSpkvDy2gLqI+ATO6sfz19mK3lhUSOlS
 JoR5CoK4=
X-Gm-Gg: AZuq6aJegm8jxUugfwEIudnpfwFuK3OYHwWpQ7j/2SyajOgRcnX0GRYjuQNZk8wYnWF
 Z3SpkyjXth43JV+PNq9dqSI3B9wjuyRR5IlrYzosBuH+pkfou4vL90cJ2oJ7rB5+0SbG+RApviZ
 KT9HWGmzFPCV/EFnRKp9glmzDQ+7JfkIevoCFRnV4x16Xq4oIyvyISASdczKNH30SKyvcBqLfKg
 fgROUnoMdfGgda6MSmPJoH23pSn8hxT+W0CzyPnuCj8X6L39XBAsziXf+fXCG87D74EthtgB9rJ
 szK0riAa4DHB1G8UHEjFhCpRytkdZM35wmWExlodUaHLaBVsP3gnYIXvijEPW3H9E0zx+EihsqS
 Z58UFLqeLlowirGwqRglo8NScFV1Pat/2k2jDmP3amPks2A+fps7MTWP0lpeYpVK4/MX+B8xZlD
 ori+dgPOEJjw==
X-Received: by 2002:a05:6830:2aab:b0:7c7:6d15:6ac2 with SMTP id
 46e09a7af769-7d52c1d65dcmr6326681a34.3.1771944062096; 
 Tue, 24 Feb 2026 06:41:02 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:01 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:41 -0700
Subject: [PATCH v4 17/24] bsd-user: Add do_bsd_semop implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-17-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=mBs5Y0mZEl6PwncKqPNyZPiCKdK9StT+eagUv/bboAk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhoqxGXE8bqmn6uZUzg6tyf2MNLpUcPGCEIE
 lJUgbSIafaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 AB+tD/4qkJMhl7YRzn/WrqW8NB34C4Tj7vwOWE/G4BUb3IH3vjTR795/UIUr8JHh7WrI6g7Q11l
 KecX6F7tnysOjg8tvROwPIaKvQUnE1oGZdXPM25V+n3W6D/nzum7Fta1r3SO17vajAfrzWvVg7L
 9o+vk32/pui+cWcYimRM+wOJU9/h3eCGa+dKqypBCcCnuPKQUldJ+5AQqw0ZJVz3kZIP2Seu8Zg
 K99RSrpmhsHUkilQL2gt4GDCydRUBbKhbdOCwIYBMTVHf5+ksMccALT+DRl3+F3jynIAyQ4XMt4
 JRET0dHEjFAMX5n2NHr+CpIPixQYyF3JBK5S7TWkZCc62G00imWTU/i30Q+U8tcijQzNn6fg03o
 9IzIFoeBILhrDkB/oeptj4d0JGPDlVP9g48X0i0FBjqDNchJ7wsR82qo1GGZ4Zx4xWeaoHHvjtd
 XqaRrngax85d65YL3DFZAVL5ybPaMfJIDvVyxX3ApAR4RUxgexcHpi6JWMU9gpAjyqZJ+H+7Qp7
 R4qP5L4Qg7PA7fGliWJl8UIzWL1wu+OCmSTLNH5R5JMGXrPJU6I0YWHW0jFgA5/7QHgO+yr5OzF
 oc7Jy3HQ1JrB2j15zsOyjPSPaPxwDkKWy3Z+sojf8jy2Rqo3osh80QTqJrjkdMgdW0p4Ka2p2N8
 exxWtLpKwe/fVYw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Add implementation of semop(2) syscall to perform System V semaphore
operations. Converts target sembuf array to host format and executes
operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 3dffb977a5..e1e552b58f 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -77,6 +77,28 @@ static inline abi_long do_bsd_semget(abi_long key, int nsems,
                 target_to_host_bitmask(target_flags, ipc_flags_tbl)));
 }
 
+/* semop(2) */
+static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
+{
+    g_autofree struct sembuf *sops = g_malloc(nsops * sizeof(struct sembuf));
+    struct target_sembuf *target_sembuf;
+    int i;
+
+    target_sembuf = lock_user(VERIFY_READ, ptr,
+            nsops * sizeof(struct target_sembuf), 1);
+    if (target_sembuf == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsops; i++) {
+        __get_user(sops[i].sem_num, &target_sembuf[i].sem_num);
+        __get_user(sops[i].sem_op, &target_sembuf[i].sem_op);
+        __get_user(sops[i].sem_flg, &target_sembuf[i].sem_flg);
+    }
+    unlock_user(target_sembuf, ptr, 0);
+
+    return semop(semid, sops, nsops);
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


