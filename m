Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9245AD0BB4A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 23:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3l4v-00005C-Gh; Wed, 23 Oct 2024 19:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1t3l4p-0008WU-Bc
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 19:47:43 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1t3l4l-0008Gp-8Y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 19:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1729727256; x=1730332056; i=j.neuschaefer@gmx.net;
 bh=N/icwgj1wIHKiipMX1wTTj2b+NOKOiAykl2bzmdvPFE=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=adV3P4OZHo8INBDXkTr38HqKRI0NKPVYnv6GgU1E+wXl3GSOkV4tPaUsvHfPjJMr
 YMka7HTHW3ZbShjoBnzK06MnWEO5iJsmyjuTRMLFd7hABFP1W5M7pLvrPICfoq6e3
 6WYIxlfaWRvlj3yoOG+/GCr/acld1Y39rZmqvgjX2mtZgDVizMCu8xXy2bLJQgO6C
 LYEFdVWp9RtPw2oT4hgtjXh7BjJbeD8hPSoCBWeLQua4W8fKor9ihLlPsCrh63ERC
 YsLFtKatCRbVq4CPeauyJFtLtt1tsBh2XrPDhzw4C2FTSLkFenlVeZkMxh+pQxqNO
 YsrFYSApEhUOJM22wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.59.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1tDy5n2ql5-00GQmE; Thu, 24
 Oct 2024 01:47:36 +0200
From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Thu, 24 Oct 2024 01:47:31 +0200
Subject: [PATCH] linux-user/strace: show TID instead of PID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241024-strace-v1-1-56c4161431cd@gmx.net>
X-B4-Tracking: v=1; b=H4sIABKLGWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINYtLilKTE7VTTQ1SkqxSDVOMTYwVQIqLihKTcusABsUHVtbCwAobqU
 jWAAAAA==
X-Change-ID: 20241024-strace-a52bd8e3d305
To: Laurent Vivier <laurent@vivier.eu>, 
 All patches CC here <qemu-devel@nongnu.org>
Cc: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729727256; l=1103;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=oJASBexS1f41/ZOdoyGSJ8ExmvSvQ+2iku5nCMQOGXU=;
 b=6oNFf3lUNe477GrDAJ1JkAbaBwlDaVWe6ecFnYk09yOJ2tqTWLfQeycB2+wqDbYmrXKLCBy8x
 U0jD1Uikc8hBNEDHX5qS+AaGkom8IyHrcPYhOlKGlc1Q95L3QcLrBTU
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:LQ/v4ulSuamW1txPkLvnPH/0NfoM1qoMHTIDQyoQfMjpx1JgaxP
 qOsr05slxwZbDQ1q+CgSGJYZftEUNIuMR8a9efaUmwOx53AFaPRQr0+bVxrO4E+ApYm5hLr
 Lr9O66r98CmI90R763mhZlLT1io/YsazKw+z78efnmyRtc00FkCZxxx8za+LNKa50JNHI2P
 sdty3ZupXphV3333Ez1ZQ==
UI-OutboundReport: notjunk:1;M01:P0:cHdfTC7GgW8=;52V1GEkLHZmhqLoVOBwgGd1wU/d
 gsR/Ui59WHl9ZAeKxfCzznD+7gl1EGI+gKKvt5tQ4WlqKTCHDDStainTrwu3lCz+Vf4KN+L2V
 DHhuCR5IMgpp2nieGsFLKw9frtN4X8wCyhl5YJGBHHFkq/UezUGZsoemfBMPXTOCRFmoIeQys
 B5ONjahmHCB+RrdZZ86PzHQJF8s2xAf9JXL8uEGwiIZ1O/T5BUECzI2oXO7sakHV+aE9SdITa
 ftm7Dzl51VKrZr/lJE62UGRTsVaituEc4CdBD+GcTM0+bkpEok7LbtZpFIBVJoQPp4STo0KxU
 2TXzaR2dotpcx3r2SjDdsf4aJTgdiYfWwQjpYgkncGk9nlU1Ip0Yd4YxuEjvReE1YE3jMNwxX
 1KKjqNpMmFfYiwpxbA97SM5dHzmGlC5HU1w2Dlq3dXml576wtZ7S01s4A9gIIalbNc8gYiwOQ
 otePgf5vSgAX10tmekZcNZocxG6yXzgkifHhRhdr8mLL8xkolGIR/hC3553FOfQ1b/GZFALOR
 so2Jve6I8p6FXHZ16sipx7FjmppzA1pK6yT9n/kQkzMVRNR+zDL2RCNJiIwi3b3AoDFNp8hT7
 uzFLAx6Ts2hrht1SmWHUBk5eP0RneqKnmMUIqIkpESi8UW+df9/XrOKmpb1FQxN7KN1TVAgYQ
 AxZVYIkcjw6+nZpfdVbjSPgwWhc8spr0BaiAgYBIb3CoHoYaY/AujKnQPBAAYG6MbgGnx/Hqh
 JlS6z2KIlvcC5mgjTyJAtNfZPhDTH/iRRJuyMO84IyEirs3wndUcMUkCxPMeB5iK64bwfafyq
 kX2MlV1DqVFns43x+dI1uZOw==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=j.neuschaefer@gmx.net;
 helo=mout.gmx.net
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This aligns with strace, and is very useful when tracing multi-threaded
programs. The result is the same in single-threaded programs.

gettid() requires the _GNU_SOURCE feature test macro, so it might be
unavailable in rare cases. I don't expect it to be a problem though,
because it's implemented by both glibc and musl.

Signed-off-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index c3eb3a2706a93fdcaf693b3413b13921a3c97e8e..93e8c73de8a4a307e6e0df5555=
bee4c769e41e64 100644
=2D-- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4337,7 +4337,7 @@ print_syscall(CPUArchState *cpu_env, int num,
     if (!f) {
         return;
     }
-    fprintf(f, "%d ", getpid());
+    fprintf(f, "%d ", gettid());

     for (i =3D 0; i < nsyscalls; i++) {
         if (scnames[i].nr =3D=3D num) {

=2D--
base-commit: 6f625ce2f21d6a1243065d236298277c56f972d5
change-id: 20241024-strace-a52bd8e3d305

Best regards,
=2D-
J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>


