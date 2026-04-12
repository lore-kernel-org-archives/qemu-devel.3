Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C873E937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxID-0006Vb-GE; Sun, 12 Apr 2026 12:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHz-0006Rl-9k
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:02 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHv-0004XD-Sa
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:58 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso3163462a34.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009830; x=1776614630;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ydItN197xR3dfX4ljekOGS/5kkStQ6bZhyq8u2u6ke0=;
 b=LWst7y0vE/e0sdspR4UyjpQj01Tt0h5VcE13CGzISwXrdyxSr0Ndl020GVDbfRNtiB
 gUJJnRKbGHByyVgSCED7cHk8BNrhc2pqheis9ZOFtcJbL6JHaIV6oJjqfNL6PCEwaEId
 DdP4OICVnUFJJXMitfl4H2Vlm1ZMvMqx2j7+PQrqKkmuUOWOv7Nv6lh/2YahKCF39I14
 JzMelHgYMz/f7fmb5P4cVj5ECaaDviGnzNOj5OSvKaBJzvJHtgW6OCJDRELN53d1OzDA
 62Gk4kfU8d33B9x74FXCXxwP8Hs8sRYEGzqzjVSk58k0wLJzUcWW4IiO7KJEGkXgo4/b
 qb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009830; x=1776614630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ydItN197xR3dfX4ljekOGS/5kkStQ6bZhyq8u2u6ke0=;
 b=jYFiLUnJsS09iua9i1eq+g5NCMbtybH2YkCDbp95oSl5JNENqVu536bXWaLkDd2wGn
 knRK6lAOCmznddvAUocfvgeOk7F8YoHsN1wuUSvyW2PAHZj/nFmbmOwyYTzDe3Ud6+w8
 lb+3yckDWjb0p/p9WY4EUIx0FOQTkHhkrmhvRi01dKgPFGmIhxnZ401y/lUPdHI3uakY
 bGMBTcC+Lqb/D1UpRpoUjtQ5n1s8+ahThy6+19/QweWqkFRq6RNW0VvAi1njFjLrKlgy
 TqZIaB+COrogvpkAb46rVl7oEsSMZWLtljzQqsBPsL3srnF4c3CBddwtC6mxC/WJ63iQ
 0D0Q==
X-Gm-Message-State: AOJu0Yy5MZeIMC/YTgAYcazTxikkxgS5SqL6sPSipCQy2oN9TztuXIed
 btzd6aRazl7Lnc2qA7EGRdBBnInIpmp3gutfE11p2D8y71tZ0PKeLDOD2eAf6c14l21/8xKTMdV
 WZjmKIi8=
X-Gm-Gg: AeBDietbedDAn2mC9iQGfYn+n7D7c4CwbM1mRFi4gmaM+/CtL/XzyD1mDrpcDO2gHAk
 t+X5CBs9zgVnxK2c/ZPTkezZ/KIMPbUWDk7wHEHp4u6sXRb+IjuitYzjS0ipPVC6r1UJvOztI0X
 HXInWaGj3WPLLuu1jzCfJqCjPsae3CY1hY/vuKTqYyanXoKrlnulB65rQ2CLAKdqZYiyUFRcw/3
 8V9T1PecV+SthYaZm+RWRPNWtd8JHJ0kxSWsAFDEKSTZvknqj5VKtBGZqusOuGIzHy8sa4zlNN3
 K0c/YUj2Xs9te2ehLYwgO/0DnOJdXdHYabHYabyVuzepVArqrhl3DR9ZdAycRQmhjT0yXWQsV2H
 1GUNP83CPURPiH3FGqyUEvI9tK0RVv+4A4pn0coe+EZB40a97nyI4lFwavxf7mefARyLRJqz8TR
 YKBQISMWz8hxtpLonHXjJX
X-Received: by 2002:a05:6820:750d:b0:67c:27a7:8c4b with SMTP id
 006d021491bc7-68be8bde8f8mr3440355eaf.54.1776009829908; 
 Sun, 12 Apr 2026 09:03:49 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:36 -0600
Subject: [PATCH 13/17] bsd-user: Add do_ioctl_unsupported function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-13-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=z3kSXcpgHWSbT8rO0VakkW+JCopL97J9zLmtTQWWN9s=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IguIj6e5nY7zrUm6SWZYSkTQ1OVs/H/mVFS
 FzmQplGZKaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 ABcSEADgD1E1hgHs6QKKQE99A8KqhNDN+tZQ/apmQMiMegU6hilCf3MyqTxHuocD6/fTig8tqD0
 n7sfDJfu/gl+muuVMOuQwnZeMCkO12KCyWNO4bb7zVXKNSNWFG/TANqbAoOhzrwESHrYSm+THjM
 VYdM2snkPwpGga0U7dEMHvTvgM9Q8jWUOn4z1gchr46tBheuoyxTbPx9JutcR/dibB/5IhsfC2Z
 cD3nA8Bq8kqzJTmm4CC3WcvGs84nTZnNZ6DVDLcRmEoqvV9OHTEBa8UJBd/Hnj/08ChfmE8C26p
 PMlgONKHHEbruzHIHi8byEkpNlBUfrF1r5zsMaaCRbduSxKXrVBuncM3PWBki0v+7EJlmSzTQFI
 lZhbqYysDwHOnz0u3jCt3Ay3eiVYKvX8lnrE9j4QRJG6OU2f73PRaWtf8xzZygFsj5w1HxOeXyE
 yIRk0ePDRG86NELoXP968YVj4qDe9DhBhPOhR610EKlOIaVCc5/IRHvq0x7WAahgDpriVIBb1qy
 af/k+uZ6oCa2VvlS8FChvvoUfPuCpRsuF3xqMgRoWCr9AdS0t6anH4eQAFMShUxeX06aHnicsGt
 93iBDbWpMstesQvdiwUfGMFb12IbARLGW0lnkha7E2TXBgMi3nm8TVzEKmhLzks9zuKxQY8KIdr
 t0PLDwq8qqvyudQ==
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

Add handler function for unsupported ioctl commands that returns
TARGET_ENXIO.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 049188e5e1..41f310c734 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -243,3 +243,11 @@ static void log_unsupported_ioctl(unsigned long cmd)
     gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
              IOCPARM_LEN(cmd));
 }
+
+static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
+                                     __unused uint8_t *buf_temp,
+                                     __unused int fd, __unused abi_long cmd,
+                                     __unused abi_long arg)
+{
+    return -TARGET_ENXIO;
+}

-- 
2.52.0


