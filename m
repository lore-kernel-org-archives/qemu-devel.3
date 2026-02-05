Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9B0ECD993
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38M-0004cl-FL; Thu, 05 Feb 2026 12:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38J-0004Z1-0P
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:11 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38H-0001Td-IC
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:10 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-409440b98b5so802980fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312426; x=1770917226;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2rpHDSNu5leTElrjGUICTpkN8ZQ4AoS0Od6Vy6deJvw=;
 b=0ujis8Y2rAaXbPxSzQAb1aaC8TclRF/r51gL9X83t64KK1ln1jGR2QxjFE3DR/dGky
 +xMIEbbFm+wtJVNPnGd2BN6afCf35IHsIy8vAqDWXo2S+ZR/OugJJMhFBMKw8+VRejnk
 LBMQsBuiifGb5q3+trpjlnkCQo1A9OQ3WqYLw8Zoc2upVdPYaNAmAuUGPLiTvmXlajgm
 1PgGgN+PobQiaPh+PxO1NOM4ARMFvoa1fH9d1wmiQKfNAiIqKABd1NdfSsY84VvyvRlW
 +jb/1FEkBQVaOazKYAehiu0KHu5BrjRxZJohLHz5WvU4kyMdIhiUNDfIdIYFTwQFbTdI
 GW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312426; x=1770917226;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2rpHDSNu5leTElrjGUICTpkN8ZQ4AoS0Od6Vy6deJvw=;
 b=RnKWEI7pciZNoBEOv9v2u0iJq1vWtuNzay15VfuKWmgMKsi1fTv9W4M0ACRgICJN0O
 2aHBw1x9IiQg4eUOQnx/rj4rnYCkymEVPiV+DKHX2Y4dqa0rlaonc+Lbo9afJt4uWOI3
 RB05LSBpcXsqK431RvDy07mdVJlroa0odtjvFQajzb4m70mteOZlAkbZ2KcEQ9/OLc30
 eyhBzAlufNF8SjoNekI0Hu5IzzrR9J6rgDJGsFJsGes18Cs9P1dJG9mLqafyiDBYIg/H
 OrJv12SeZCqhuUtY3+A7HwC9XXElC82LWWm4veFSlaueJOpVtj7dqngiaw9Sx2mlt04y
 dz9A==
X-Gm-Message-State: AOJu0YwZZCwvuvuePCQ/AIGd9Y2Hs9HhnnHDlfGbjGaoDxnJXgTjcMF+
 AtE2NOX2fZGvIb8TgxPdB0909i1cl7hSTZr1leBwnqo0rd9VEF5dn8+AQ1x19/rIt8U=
X-Gm-Gg: AZuq6aJIF0IFSkAU9Bh7t4pGWl/O3InqKBfIQ8tpryfsbwM6mup7SIpGfAJjy6y9gIn
 3ZrnpHYWm7HMMspSSHW8WlsxB5qaXC0FdK9a+8KSUjrUkVdrsw9G3Mt/8ShRKZ+XQAgzAzsyl66
 rBBIW4D0aOJO2H0mzLTNl99sG/RYsSviZ4CTGNJDNbhfqKN1xaLbjDx8ty7Eph8RkYlw2sfDNTa
 TaoQFcanCwqKYXvEDVFv2V2I6v47IfPWm0XePU6VSAy1MgsxbSoeradPiGM1SXkCsfrion3ymx5
 2fSA5BhoPTJi34RV9mO8BC5r3M0bRVqHf9LPeCvfpsy5T13NzyizxNqcdqWpdTurtjf64tGH7ZO
 sjY/mPLOuKZeMxP5856LdlMd8kqPriucUFv/DafI5sDtEPWQfrzToy0/c9Q8nojXPPG0qBj7ixA
 ==
X-Received: by 2002:a05:6870:350a:b0:3e8:8e56:6751 with SMTP id
 586e51a60fabf-40a540e5957mr3884202fac.53.1770312426031; 
 Thu, 05 Feb 2026 09:27:06 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:27:05 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:56 -0700
Subject: [PATCH 23/24] bsd-user: Add System V message queue syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-23-8d8ff0035372@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=L9cV/LWPDJD7nJ+y482YXUjq4xWctehdv0NdTYhcuWc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbmIKcEy+OgbGOR7aLWVgLbqPC5rvx7JxlW
 xafNs/TJqiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 ADgfD/4v4C3uTDnCibMn+ee17nulYhRZdX9sfeCSVsD6LMbg9dIQ/tepDOpejviWZec7bu/PcKB
 gZo2kIsi1/kEug4LRkRdg+vOBlDDsoS1uv6bfxhYf8R/WAy8P2dN2ffT5W3urA16nnKIfAjjvC7
 qusTpRKesm32wn7e3d+AguAuhqQSJq0GR0oh/HRwSf6m2Beayj1TWQCNhACZY2aX43hZT6U92X0
 bZcHECf1uGBBbMTPzAxA99R8DXkHBePXjtyfS1ZW22Y6xPaZ2tZ9Tuozp2kL0IiP9Gl6Ln/FHTU
 3lUl52CLTlqOTu3yiMyySbJCEr5H+nZ+oZXe19kq+4cPO2FQ2eseKjmadIQITu8Qf3by598p7GD
 n6rJfu0SvgsJbpGDfH3yuHR+1VP2tCw6MZCz9Jd2q8Ik58UQqajbQuCWj/J6sP2hqourMo65FvF
 Ch1aZnUtwQh3oYnMFWuGFOOKSScIGiTKBUR6U5zlbwGqxiC0gcB5727UvoZ5E/KONPlKJjHsShP
 aShL2E9/Ivn5skfahu2ELrGU598cbciXCp4EdosC2/KnpbSkjdJhTJqJ4CG821gshvOzCbulO+G
 A+R1wCy1JGk88r4a+LyrsIRaqDMHwOUAKXSeqkyJU2slvFPfujszw0OaTejfevAYGexZXwofdJ+
 IReT5f6zvui+brQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2f.google.com
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

Connect the System V IPC message queue syscalls:
- msgctl(2): Message queue control
- msgget(2): Get message queue identifier
- msgsnd(2): Send message to queue
- msgrcv(2): Receive message from queue

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 6e38007bdd..c9b2fadd55 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -902,6 +902,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
                 (union target_semun)(abi_ulong) atptr);
         break;
     }
+
+        /*
+         * System V Messages
+         */
+    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
+        ret = do_bsd_msgctl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
+        ret = do_bsd_msgget(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
+        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
+        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
+        break;
+
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;

-- 
2.52.0


