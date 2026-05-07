Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC54ECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWO-00088H-DD; Wed, 06 May 2026 22:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVb-0007Ty-3k
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:42 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVZ-0000Y0-Dp
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:38 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso311507a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121036; x=1778725836;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYyYxQHuQ+EIvqcxSP+nEzWUdVWHC00GlU/UPZ5RCnw=;
 b=snU7xqMKzf41daK1neZQAJ2jqk93dW6BlTw7qrps5P0fvozARGt4a4r4cwn0J//QG8
 i5yM70ol2nmFiRz6iGAXqn0b/KEKHul5P5e9JCSpmAtS1GQa1DIyOtCHK3Ci7qQlUipm
 amfRPMXsDrUkbQXk/qVDSW5TDhiFRiktWCpT0rvrnYAwzd1mLfAvyLUZL3Kmf2DcDM7Y
 EBoZSj+zWsafHAynIAF89rMxCo1LoYfmWo5vaerBANbA+2IfsO8RyYnp0uM4LqVoEGi/
 42vCXEgARn0jv1q30fXhQ/b3uLjliGalmMAEMnY9iDkGlmThaFD89gXqJOR0zpAbKsrQ
 tbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121036; x=1778725836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYyYxQHuQ+EIvqcxSP+nEzWUdVWHC00GlU/UPZ5RCnw=;
 b=eC8fFCKjWrxEr+5x04kZ35dBq7EkfwOHkHcybwo6eT7oUbKXNC4iFDrbMsV7QVGYN9
 UqjQ1uJom2nZHjmLctG79GJPEo74OhAF1n7BAeVUnkvSbwuyYEuikrFZ2Z9cJYqEVS5X
 iBvCU3mBux8BLYyYh7K+ZP0BEMDuQnO+9oOq+kbP2koicgVIVZbxyKY5eznWyFHXgwvi
 yQU9v0lTrpcX+NJB2GLVdRm/KDPEjlvJpZRQXi46nNZVhk/+KM8G69UW0vn4/U+C6Vbb
 2EvCZXKBPsFh9qaf79aMFO2J0h7pkl3BY9UfzXGr11K8Uq2fijFuwbXquR33QWZbCuMY
 LYXA==
X-Gm-Message-State: AOJu0Ywj8FnmpmSaUfbh1Hl4z6DszYNHtnnZGuPIVsusWRTm6kXbgEb4
 1dPzfVtElEgxx0JuayAyekQ399TMWm8/+hwAm8RA66W8nhviZD6fqbOIUMmJsEgG8eu/vDim2tP
 DvN8Xnl8=
X-Gm-Gg: AeBDieu2bipQcWz+EbpnhZkMWqZBOE2CvCCdxMpCZ2apVbGbZEm+qgZBbEK3j7M2tAT
 pF7bXtWQ/owQKpQVDVWwXWJ0WrbA2Rl9WKK+0V/WsMViI14Yz1qb4dDF8lQ65QZyMGuVSpyT551
 j1O9ligyYfuC2q7W5sJvasKxvzTjHKT5lFJRLGGLkm6FM+tjsK145CX6WHROp4UY8eB+le9qoxw
 qJdN58QtI9MYuvHgHI1tLgKnm7BvfrzjWe1k37gsfD2+DWX1G0x8NZrf798bGi/1pe8CiML4IRd
 M2M6jZfEfiLh+XfnvO++IJ+CEpTDZTIadVwEE3J8T0vZIKbYahp4Y3iQwNsu/1rUqF7GzI7qLGf
 cLPWa1jcNIWTp7sqPqO9hU1THq9WXyVdbB2dWQycGBgSAywBtuCgpXNehRsaAWKjg6DC1I37EUG
 VkaOF08ElwtTPQikAsd/QWwX8+tWqmZmg=
X-Received: by 2002:a05:6830:6101:b0:7db:f286:18ee with SMTP id
 46e09a7af769-7e1fcbf7eb0mr780701a34.4.1778121036173; 
 Wed, 06 May 2026 19:30:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Alexander Kabaev <kan@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 15/25] bsd-user: Add FreeBSD ioctl command table
Date: Wed,  6 May 2026 20:28:17 -0600
Message-ID: <20260507022827.44499-16-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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


