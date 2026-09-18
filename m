Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E5AC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAL-0005Yt-9W; Fri, 18 Sep 2026 00:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAI-0005Xs-Dh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:34 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAG-0004NG-Q9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:34 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7fccd4c3f36so183330a34.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705532; x=1790310332;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DfGCwdPIzmnH06tk/5wQEIrHfRFlBEUm1L70dd0gAsc=;
 b=WcryqteyfNEihd7XDBPW+1NBLJGAWC+fN5NK3mDigxG7/UFFBviJWJroENI+d+zb/l
 JT9ISSx8TZ3QF21hn/ZkjDihvsTBYoypUlJAfcduUeVED6o9NK027UqUIt1xxiA9p2fb
 W1lRlrJ5UhIBPS6lsjmseUV4ofzavxhNZBR9JLviOWFNsSvwEBYY+zrGRSAbpnOFJLM1
 RtqtjFW+1VhDUSw4/zJ8S+4+SYYccI/tJ5opDBO5B1ZSQPlZns8RfdNfPbv5eAo5mH+v
 6gTl6Gd1tJS4A2kSiP74dGDR4VK1rSl1bNQGZo4SJkDjbOJIUFQW77acP4GxYXI8iOwd
 /6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705532; x=1790310332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DfGCwdPIzmnH06tk/5wQEIrHfRFlBEUm1L70dd0gAsc=;
 b=EpeZxfJSA+xlSfVpeNhKR+ZwJtx1aoN7QLSLXrjwjd2sMQhkZHjWmHCQ0bBIyb/4Wx
 5EnFtVfxWv3OhAi14b2kNOIKIn+9mf64uaDW7ZkGd4Rm6UW5bzZxdIklCka1GsfeEoRZ
 +bRWmnX8OEsTrLi6+JsrgAU+CYddul4HYunhj16fcU8VAdB69u8Ak2uTaN2wmAb7pGie
 gbX71zpKMAK+NKopToGA80cB9hnH42GKpGdF95ELSGefkTAJSe+OT1WOwq5+GjmmuV6+
 x4Z95SJkvz480eMeMyXA4+mN4Le8uC/p/VLhlQvMQ6ZbX9tiro7bIwJBqo/c91RnZ80L
 4IPA==
X-Gm-Message-State: AFuF++nzl9a/T0YXaADBh6EsREER7gJkSzNnRwZYzh0EkS+BZ1f5l5qt
 jB+LkzNsGT4CA5eNZduyVWkiGHyNT8a0dBQ5y02d2D6pLAkUqOPGcOIF0cuKq27+L2+1OekFcyK
 rdtvCi1A=
X-Gm-Gg: AYBFou3S5tN7/c0TOcp4JPtrV2XFWIB0zi+wQc4EzsuXH29sUfT+MO+RxADPeHbczIg
 ohHaL2V4kuPWcF4JrMffC49cNpqrcZNGRHZS6AOTglK6jR99MFueJ/3IBQtffdBCR+NJpPs6zh5
 y4cFJG1LZJYOLZ+YUHceItUKvFMVP34aDRZ28XFDpZBOEWvrYzBukgB3/qfrzOaQZ86Sja5C/ix
 u0rGv5k9qFv0bYshEaR/U+21CZ3IfF9EyYc0jYLCHci+O/FTVw8K6YtsWjLIeGTJ5H/e2By+w3a
 oN/mbk7vXFemlaT8ASpzVIc1uVWs2svFz6vy/AtF2Afa371WgzW7VDLBzgflVI0IdHrDn/TATvz
 zpIlQhb4VzT+k4C7ApVoAToCG75OQN8cRG8KrJXV9pF3PSsP9GOkbTwFkemyVVXRardHSYI+3OI
 WeJ1zJAnnonINNSyHinQBN670jz1zTRUwERD5MYIgadW0TyGYwUecvHaAcJ1Cc6Isn4WN+
X-Received: by 2002:a05:6830:2708:b0:805:7395:3db4 with SMTP id
 46e09a7af769-80de0b5c54emr1607706a34.12.1789705531821; 
 Thu, 17 Sep 2026 21:25:31 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/41] bsd-user: Add socket system call dispatch
Date: Thu, 17 Sep 2026 22:24:02 -0600
Message-ID: <20260918042422.38713-22-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 79 +++++++++++++++++++++++++++++++++++
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
2.55.0


