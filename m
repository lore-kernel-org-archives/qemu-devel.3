Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF4CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VV-0000T2-DB; Mon, 18 May 2026 17:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VT-0000SX-M6
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:11 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VR-0000TG-8Z
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:10 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so3022604a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139688; x=1779744488;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIZZ3MoLaByazBW5BUbMYe7Y/3osI58B02Q2ofvFBtk=;
 b=CdKG89BcY1bv6IUO+WS1Y9Biwy9eWBoixCkh8wQ0YJZFc7QLixD2OB+1aHPt00CwVg
 R+fBwMxihwWA7cDJe/T/f/YYs26/WII1gnGD1c+e4O77KEq9TvXA8ExJRqgAnYGlAbkg
 xHp9/G9oi35RomO4tVsFTSo51Q9Xxoyvu21G1P/G7Wx/twhNcemd/RUmPkWitGk67i87
 8Bu5qRysbK2Cho4ioAsJFlpCYLMSsspdLFQRpbB/wmx9vnbGM3X36B/OVI4Ec8ddKbTX
 ZLOinR40qAyQmv3ILV6Syat5+DVKsdgJRCX5Is/nycGpo7I2e5PDLgi4jtFnRE5rbMaS
 /KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139688; x=1779744488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BIZZ3MoLaByazBW5BUbMYe7Y/3osI58B02Q2ofvFBtk=;
 b=CMU7TtlihOFxw2/XQG5pbvtkCAYM5U96MuHg8DNvOx7AmOLbPVpuiWZkMOXUvu+foE
 KWrQekaGYzhJKpRikjUoajr3wFgQptNZrieC7PB4qc26vnO8Np8qLW0xUdD6WyoktzRh
 8XWQc0wSZgwlB/brgmGrmpkwzTX5mcSRstVyFhPbgklsm9Nyt+nxf1tBrkXatMvx2w+5
 QlsdbDBuKx67efN5gwi3PlQrx0nCFnzXqjAPLpm3nvpQWs4zmoNoG4bvm9u8P49IFR4c
 Z68guRxv8TWL66JrkLR84xF9QqS8EbB3PAFa0di3Ys/JHinQW5krOulEv2WRj+KcwOYt
 R/Yg==
X-Gm-Message-State: AOJu0YwDiTUu3eiDj38mL+Cx7/iZlE9ys4y9gShATwDoTJOXC9pyje0C
 jCLUPPWLKsHohslpcmi9aeCWF8/RS7p8baak+/uuA9gPb3VgHJ841JWx408nBy6zF2I=
X-Gm-Gg: Acq92OHq0kA9c/zADuGlnFH/2B8AEkiudxuBFKBSHbUybYtFkFFaUnWwdtq7mOwzt3C
 rObYJUkM57qk3FFkey81/F9TD0PTHq/zNWKqdeEHb8yR2Lqo/+TODrAtgMWwba8P/vsvvaH3Gde
 4Y9lIo/AE4xHjgsc2PqIe+i2Wnx3WOrZq9J8FFbaWbnLKXmAxrIH3gPRNj7X7Gdq+VXECQi5aIo
 +aj+HRzl5dKkD5F5ecWnD7acipycNz2Icuv2uUZnu7YDTslKuj2fepfZIP9WgxKqE+plCZj6scx
 I6Qd4LWftQmXUybKeHCPTFH1AAuGBTq6UNu8ed0ZnZ98WsNd2PADsltP6eHTPvsZ4Mm6yRyStPO
 Ft0S1T9IckmyPDI9i8BKmKP0kDypmf46qwUFDsbPGMdkYIAun2rkISmPPykrgNPeMM/Tnddby3c
 gM/extZfoMa5xPRQSqd8Fr
X-Received: by 2002:a05:6830:3902:b0:7dc:cd0b:58ac with SMTP id
 46e09a7af769-7e4f2a448a3mr11846523a34.9.1779139688069; 
 Mon, 18 May 2026 14:28:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:34 -0600
Subject: [PATCH v2 16/37] bsd-user: Add socket system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-16-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=TZhqz7LKdkYXM01TJu9w2X05NnhTh/MQLP6Gzmk/xUk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RH3/4buRW2HOb8yg9TUO/UuVrTcoDpg2CSA
 zcNFPUpghaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERwAKCRBsHNEofbAR
 AE/FEAChm0qy3FHZZEzRgjPT+LggpycTGOsaQSYn2QBNmkcc6xBflPnC29ojYFLo7f2aBMJ+16J
 gW8rNz7Q9yLf1ZZNOR+/JEeosJGLSBF0PLYsj7cXZ7F1YSbRJEKbKTCraDpQjsxv3P2LmtMbn5p
 VZ7swUvHaXXVoUBU5wHp9gqq2eSFDg7hW4ED0fREtfCPKuD5cFud608J/kURQDvR66c8fypKU5F
 Yhjp/sJfMsIF7gd1VtxEBs+PTbYE73BaxhHfaUb15TTminU8E4k5PJlxAud+zGpt/A27h4DMuyQ
 tKJ23KS7lhVRr8ge2FxaZU0XBJYdfYwSd01/sRtbZG50BPcnZojMexCH5PbDB/kgD8julkXJOXG
 TRnW09qLsXz3whAZAgldFF47MBOmIwdF97IEzHAi+xtmNetHSor1pLBVe0BlVR3ZPf6LXkl+V9W
 9U3NrOhgKZm5Q6+GugKOUWUISjbkzrD4i3oGgpagspvoWd5scTRoIvAuJ4MdTrBSkesPmznAFAo
 7A9w+ThROeV9p/RhYTAVp3oYvld0Nos/E1KttD8Mq8jMsNbtbwWcVCRCsW0ApgFvvqQUW+cN+LZ
 2riDInSvjhAvUhsVgOnLy9Sn6lGR3yGArAqWHyMq4tJtWCzzaDBci4TB5vEtjmO3ayIRZZ6ntdn
 8y/Ety/5L7vqW5g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

Wire up socket-related system calls in the FreeBSD syscall dispatcher:
accept, accept4, bind, bindat, connect, connectat, getpeername,
getsockname, getsockopt, setsockopt, listen, recvfrom, recvmsg,
sendmsg, sendto, socket, socketpair, shutdown, and setfib.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 46fee46336..5d3a66e360 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1073,6 +1073,85 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_pdkill(arg1, arg2);
         break;
 
+        /*
+         * socket related system calls
+         */
+    case TARGET_FREEBSD_NR_accept: /* accept(2) */
+        ret = do_bsd_accept(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_accept4: /* accept4(2) */
+        ret = do_freebsd_accept4(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_bind: /* bind(2) */
+        ret = do_bsd_bind(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_bindat: /* bindat(2) */
+        ret = do_freebsd_bindat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_connect: /* connect(2) */
+        ret = do_bsd_connect(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_connectat: /* connectat(2) */
+        ret = do_freebsd_connectat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_getpeername: /* getpeername(2) */
+        ret = do_bsd_getpeername(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsockname: /* getsockname(2) */
+        ret = do_bsd_getsockname(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsockopt: /* getsockopt(2) */
+        ret = do_bsd_getsockopt(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_setsockopt: /* setsockopt(2) */
+        ret = do_bsd_setsockopt(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_listen: /* listen(2) */
+        ret = get_errno(listen(arg1, arg2));
+        break;
+
+    case TARGET_FREEBSD_NR_recvfrom: /* recvfrom(2) */
+        ret = do_bsd_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_recvmsg: /* recvmsg(2) */
+        ret = do_sendrecvmsg(arg1, arg2, arg3, 0);
+        break;
+
+    case TARGET_FREEBSD_NR_sendmsg: /* sendmsg(2) */
+        ret = do_sendrecvmsg(arg1, arg2, arg3, 1);
+        break;
+
+    case TARGET_FREEBSD_NR_sendto: /* sendto(2) */
+        ret = do_bsd_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_socket: /* socket(2) */
+        ret = do_bsd_socket(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_socketpair: /* socketpair(2) */
+        ret = do_bsd_socketpair(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_shutdown: /* shutdown(2) */
+        ret = do_bsd_shutdown(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setfib: /* setfib(2) */
+        ret = do_freebsd_setfib(arg1);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


