Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D0DCD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPp-0006Wg-8y; Wed, 06 May 2026 22:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPn-0006SS-IK
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:39 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPl-0007g2-Kr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:39 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so126546fac.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120675; x=1778725475;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYyYxQHuQ+EIvqcxSP+nEzWUdVWHC00GlU/UPZ5RCnw=;
 b=vrI76oDz23IT8Tzj/8ZCJOwz6c4L+7lxdegmPojHYDopRyJM87Bvs7xYAxPGd8sJh4
 0UmI7F4pfdr9/IZFqDbwpcf28XtoBBPzehgScDvBwz87euuzvBCIezzPDEiL2cLzY9wX
 QkL31a950mlORPxDp+yi7nOzAId+zciIU47O86UxkXObr5i9IKSREMzN3zR/ShKaoHH9
 XnzLmJadOS+W/KIXvTdVSQJ+UD1RGknw0E0tA1+yMTc4TEvWLfBYEtz3MPEodCBDQnly
 DpiHaiWs1ATdNLjX4rDvvFmMgvW0/gwZEE3E0Wx7wPJHmG65YRf6O6ktHu29OHTmPW+B
 pkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120675; x=1778725475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYyYxQHuQ+EIvqcxSP+nEzWUdVWHC00GlU/UPZ5RCnw=;
 b=Foz2SL4W62fJjGWa4I2DfrjMt8k4tMKuvXg9tq3ZcO9R/LY1IEDboXzk7+q1b8O895
 xF/m4ur5x48wid1Tmq6SqVEYu1hMLn9AvNSvlH+4igj3VsG6yUv2bNoeMgRCuKVn57RX
 mEEK/y5iybT9j73HkOG16U3/5IYtwmGS9UXGmLLYK21EDNjIQbVHeiAlhHt3PVlA+1Qk
 D3IxLWZQi3AlFvM7gDJz640gIOwONTCZNxaWbanuK2N+suKp2v0CqAHHOe9G7OkrVkdg
 lZcy/h+Qdwpx0F4KKW7CqktNlEQBdJ2tAZsuFjnIol02p0OAKZJAa5WOO0khtLT3Lb/m
 XVYA==
X-Gm-Message-State: AOJu0YziccPJbDfX2ydToNd/FY8eandagkU3+ksoqpnplWczQvwAlZob
 /V0tFUq2E3w8i0ZHPyI51/wURyF0jSqPeFZNvyCCtW6y1lNpTT+g3bKv1RSdIwzVW1XAJbaN7vp
 ONGnz/sk=
X-Gm-Gg: AeBDievHDTc0X1BT87jqUYguhAvF0HBB+jl+Je/J2dxGj6XwbddR6s6YU7q0TbWAceN
 HyUehdW0aJ8/y3VzXxMQMQKR1aK9iBQopgH5Jovl4jOVlJtVRac83wn5SLr/WuELzYUJdmw47C4
 K2idIpShlCz/38NBE/4uP5bYNkZ6hWmugJLUA6pcXBdDqorxhBpazRY06ASiSHpDPyOIZhi/j+g
 AClbYmBol3covWezyH8RZTMtuH48R2aqd5kXZP802FgiijUxXojw378tmjMUJ/gJFZciobqXz6v
 bzm5aeXo/d+WCjRN3Jm07nn3TP8tkm57rjk1w/MAEvhovralmYOTfKbFqdDKzhc10x0Vy9HkAiN
 Bo7u/pdbP6XD5zNRNUns2tIOG/P+GRX+FBnhNbuTQjGIjlWryxnJ6MYsWF9/DLl2+qkg302UOY7
 Zqve3/3W8na2Bnj4PsV+4TVUvST0m5MJU=
X-Received: by 2002:a05:6820:81d6:b0:694:96ff:d4b with SMTP id
 006d021491bc7-69998ce4321mr3338640eaf.26.1778120675350; 
 Wed, 06 May 2026 19:24:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Alexander Kabaev <kan@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 15/25] bsd-user: Add FreeBSD ioctl command table
Date: Wed,  6 May 2026 20:22:09 -0600
Message-ID: <20260507022219.44171-16-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add os-ioctl-cmds.h containing the complete ioctl command table
mapping TARGET_* ioctl commands to their handlers. Uses IOCTL and
IOCTL_SPECIAL macros for table generation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-cmds.h | 149 +++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-cmds.h

diff --git a/bsd-user/freebsd/os-ioctl-cmds.h b/bsd-user/freebsd/os-ioctl-cmds.h
new file mode 100644
index 0000000000..5f138fb3b0
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-cmds.h
@@ -0,0 +1,149 @@
+/*
+ * FreeBSD file related system call shims and definitions
+ *
+ * Copyright (c) 2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* sys/ttycom.h tty(4) */
+IOCTL(TIOCSETD, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCGETD, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCSBRK, IOC_, TYPE_NULL)
+IOCTL(TIOCCBRK, IOC_, TYPE_NULL)
+IOCTL(TIOCSDTR, IOC_, TYPE_NULL)
+IOCTL(TIOCCDTR, IOC_, TYPE_NULL)
+IOCTL(TIOCGPGRP, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCSPGRP, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCGETA, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCSETA, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCSETAW, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCSETAF, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
+IOCTL(TIOCPTMASTER, IOC_, TYPE_NULL)
+IOCTL(TIOCOUTQ, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCSTI, IOC_W, MK_PTR(TYPE_CHAR))
+IOCTL(TIOCNOTTY, IOC_, TYPE_NULL)
+IOCTL(TIOCSTOP, IOC_, TYPE_NULL)
+IOCTL(TIOCSTART, IOC_, TYPE_NULL)
+IOCTL(TIOCPKT, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCSCTTY, IOC_, TYPE_NULL)
+IOCTL(TIOCDRAIN, IOC_, TYPE_NULL)
+IOCTL(TIOCEXCL, IOC_, TYPE_NULL)
+IOCTL(TIOCNXCL, IOC_, TYPE_NULL)
+IOCTL(TIOCFLUSH, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCGWINSZ, IOC_R, MK_PTR(MK_STRUCT(STRUCT_winsize)))
+IOCTL(TIOCSWINSZ, IOC_W, MK_PTR(MK_STRUCT(STRUCT_winsize)))
+IOCTL(TIOCCONS, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCMSET, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCMGET, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(TIOCMBIS, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(TIOCMBIC, IOC_W, MK_PTR(TYPE_INT))
+
+/* sys/filio.h */
+IOCTL(FIOCLEX, IOC_, TYPE_NULL)
+IOCTL(FIONCLEX, IOC_, TYPE_NULL)
+IOCTL(FIONREAD, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIONBIO, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(FIOASYNC, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(FIOSETOWN, IOC_W, MK_PTR(TYPE_INT))
+IOCTL(FIOGETOWN, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIODTYPE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIOGETLBA, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIODGNAME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_fiodgname_arg)))
+IOCTL(FIONWRITE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIONSPACE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(FIOSEEKDATA, IOC_RW, MK_PTR(TYPE_ULONG))
+IOCTL(FIOSEEKHOLE, IOC_RW, MK_PTR(TYPE_ULONG))
+
+/* crypto/cryptodev.h */
+IOCTL_SPECIAL(CIOCGSESSION, IOC_RW, do_ioctl_unsupported, TYPE_INT)
+
+/* netinet6/in6_var.h */
+IOCTL_SPECIAL(SIOCGIFAFLAG_IN6, IOC_RW, do_ioctl_in6_ifreq_sockaddr_int,
+    MK_PTR(MK_STRUCT(STRUCT_in6_ifreq_int)))
+IOCTL_SPECIAL(SIOCGIFALIFETIME_IN6, IOC_RW, do_ioctl_in6_ifreq_sockaddr_int,
+    MK_PTR(MK_STRUCT(STRUCT_in6_ifreq_int)))
+IOCTL(SIOCGIFPSRCADDR_IN6, IOC_RW,
+    MK_PTR(MK_STRUCT(STRUCT_in6_ifreq_sockaddr_in6)))
+IOCTL(SIOCGIFINFO_IN6, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_in6_ndireq)))
+IOCTL(SIOCGDEFIFACE_IN6, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_in6_ndifreq)))
+
+/* sys/disk.h */
+IOCTL(DIOCGSECTORSIZE, IOC_R, MK_PTR(TYPE_INT))
+IOCTL(DIOCGMEDIASIZE, IOC_R, MK_PTR(TYPE_LONGLONG))
+
+/* sys/sockio.h */
+IOCTL_SPECIAL(SIOCGIFMAC, IOC_RW, do_ioctl_unsupported,
+    MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+
+IOCTL(SIOCGIFCONF, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_ifconf)))
+
+IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_short)))
+IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_short)))
+
+IOCTL(SIOCGIFMETRIC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCSIFMETRIC, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCGIFMTU, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCSIFMTU, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCGIFINDEX, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+IOCTL(SIOCGIFFIB, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+#ifdef SIOCGTUNFIB
+IOCTL(SIOCGTUNFIB, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_int)))
+#endif
+
+IOCTL(SIOCGIFCAP, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_cap)))
+
+IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFADDR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFBRDADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFBRDADDR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFDSTADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFDSTADDR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFNETMASK, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCSIFNETMASK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCADDMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCDELMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+IOCTL(SIOCGIFPSRCADDR, IOC_W | IOC_R,
+    MK_PTR(MK_STRUCT(STRUCT_ifreq_sockaddr)))
+
+IOCTL(SIOCGIFGENERIC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+
+IOCTL(SIOCGIFDESCR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_buf)))
+
+IOCTL(SIOCGDRVSPEC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifdrv)))
+
+IOCTL(SIOCGIFGROUP, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifgroupreq_ptr)))
+
+IOCTL(SIOCGIFMEDIA, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifmediareq)))
+#ifdef SIOCGIFXMEDIA
+IOCTL(SIOCGIFXMEDIA, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifmediareq)))
+#endif
+
+IOCTL(SIOCGIFSTATUS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifstat)))
+
+/* net/if_gre.h */
+IOCTL(GREGKEY, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+#ifdef GREGOPTS
+IOCTL(GREGOPTS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+#endif
+
+/* net/if_gif.h */
+IOCTL(GIFGOPTS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+
+/* net/if_pfsync.h */
+#ifdef SIOCGETPFSYNC
+IOCTL(SIOCGETPFSYNC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ifreq_ptr)))
+#endif
+
+/* net80211/ieee80211_ioctl.h */
+IOCTL(SIOCG80211, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_ieee80211req)))
+
+/* net/if_lagg.h */
+IOCTL(SIOCGLAGGPORT, IOC_W | IOC_R,
+    MK_PTR(MK_STRUCT(STRUCT_lagg_reqport_lacp_opreq)))
+IOCTL(SIOCGLAGG, IOC_W | IOC_R,
+    MK_PTR(MK_STRUCT(STRUCT_lagg_reqall_lacp_opreq)))
+IOCTL(SIOCGLAGGFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_lagg_reqflags)))
+#ifdef SIOCGLAGGOPTS
+IOCTL(SIOCGLAGGOPTS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_lagg_reqopts)))
+#endif
-- 
2.52.0


