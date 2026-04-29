Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8202FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6C9-0004ry-Rz; Wed, 29 Apr 2026 10:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bs-0004VD-EA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:06 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bp-0004Zf-Ss
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:04 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso9848527a34.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474020; x=1778078820;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BKC2bjWi/SrtpYK3J2TKDXq3sEnsuUf9zoPfckC3H0A=;
 b=HLzElVufIzTpXirk0VUUF3uTPnxqhPN0ndLBAu70pW7AOD5Htrq+nh1rSOBPv2wa0D
 MyXIT2oD7bZG0uZKOuEvj52vWPjWYf+W+JITdeHOMblyUV3vsSZ8N6ak2sN3MpIpzZOE
 Em8FOc2FaLDm57bALEnqeZB6SSBxUAcBGVgcGrg0qHS2jbFtoEXiW3f79xum8PFwOEAC
 wJ2SCCjH93F6XKMUQeimPeR5yuKR699KXb6MYHEkkNPgFGBM2mMZC5yGDd2rlMdtJIl4
 NU1NoIwGgmMG/yvfXZxcQ9Y8N7hn0r+gWjBEIDHh+ZZDAbDu1RT8SHb0qIW2YKZ9poxj
 KA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474020; x=1778078820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BKC2bjWi/SrtpYK3J2TKDXq3sEnsuUf9zoPfckC3H0A=;
 b=eSI3zpCtdsiXnyohMy6MP3KLFiAfhbhU3h3LlX6XNi6voNhsg5PsktFMwNteAv9gRa
 AmD5jlc017b16NgEWx+LKF7RkJGj5q5mEaO9vUmecqCUU9eRQHlgg+5mSfqzmQsBM4p9
 aLNmZ4dczJjO037gYYkVdPzpm0Oy4ZETQPsID0S+BBa+Er6LEVR7Y5d2AuyyulNWTtq9
 Hqu9HP6E+gMVJtCv9TQ7aFzGJl8VkVavFRHHr6stpyZwN7BsyMluyIzmVlr4KWROInZN
 g91a7BDIZwA+Z4dxBPu4jRBARYSuYZAOYlURWOYI4+X1O7jMgcnxPSvUxzzXwuU45XwJ
 SXRw==
X-Gm-Message-State: AOJu0Yz1RziieAsB9McaLDZwqFX5GNyX9/p9/6CSmnIk3ddRtTKGe9BT
 8SgeU0mDhgwyY4MLzNJSjlpAEeclC2ofNCIY51fDECWT0jTPrPA4yJdBoMy7wLkgE68=
X-Gm-Gg: AeBDietCGPRbWeLSs3csSiBy0SE9a+NB3fimOWDqEbEEbPZhafV5h+DfHkMeD1iy92Z
 G5IcyRGvQzBC8BrMuKhOL8Ci1YtXQA4Bia7OYUrnqg4x4kiUShCtDYCxF2wnFmT3iVnqOtbnTAs
 4n+G2YZgfU9wLhr1SJ2TqZmuSinWCjDPZ02Qrj4DK1Ig9hJgeoY4eJsZbIWU1cRRmiSdx2ZpElK
 rV4SwIOjN982O+S2Qu9D06QH3iLOXEB0twAKArvz7V/NYaHzeGwxw+Iw7kHTds+Xig2ZCh0GS6P
 gMPnFd7RY5tHEkhVcCyZn7ayDxdchLnnChhbxeJsbMlzo6bsgBq4z0g1WivRv8P/At9fVajUJOY
 1LZ2BhmqFtNPn5dFcYrwwvEpFnZD56FQQ8ny5e2YtQV8JSj8yfmlmMTMzUK8i48FXUzX+ytKzb+
 0+6S4dPNEz1KrlTK7qXDyt
X-Received: by 2002:a05:6820:1886:b0:67e:160c:36ba with SMTP id
 006d021491bc7-6965cb7f189mr4184371eaf.48.1777474019766; 
 Wed, 29 Apr 2026 07:46:59 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:14 -0600
Subject: [PATCH v2 08/17] bsd-user: Add FreeBSD ioctl command table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-8-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>, 
 Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6990; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=NmJqk3FSVLIKDs2qsRfZvQlgCcX5khfFeERHrIqG7cM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl9qrjhVui8SBbbbR+nMEWkWB5CVAma2l+7s
 6muIUcuLxGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfQAKCRBsHNEofbAR
 ALLoD/9Ov4nOOz2T3A2N3DcEVTpQoQv72bpaDYsXISWSaKVQL3FYvHXQxCQ4AD45yOBm10I96wa
 DZADT+AdqU6XTln5QesYg7Ma5lTH9RpEXZVcogmoE6AHJebz6vq413kyROG3fu9FO0yl9S1ZZYd
 DyfulXe3I3LbCMa6MfCzb6D9nVrWCW6GdMrlil6SGCtlYTb7NWW3/C9EYS+XIJWewN9q8O58Nus
 0fGIus5E1nqs+Sop4VJmrhc2bWVlVMLNSwuXiqbkn3CGxqnI1JPzCLRkKpv7pGYJARir2Xkcy9k
 viIXjSxKsKT7GnC0AOJBj5IFAzcBfRZl7JlZ5tKapSZ/S5S9LVK2g+RIN11ePljxPmW1+t18fcQ
 V69aIo9SmPru0PnL50eEF/KucdOyLYQjzVst3ZaTSe8eIMn4nO6ubr04AYC6tYro01Ndi+iMngi
 8dmzheUMWP1GuGdnIEFuvYRu5rWe0OCdAhl2JuoXKGu89DH4JWQC4IBzhy24TxfJhiDbEkgqXnI
 rgx5B7tcIcXmTBtuNL18s+867+a7iBSPXP50hT3aTleUrR5CrAFcvw/ZWAY25ymmmWnOaadIlvn
 Al+cHRiMHUu3o8YRAjz6OybjsundbuTd7StnsmgA2Mk0qU5n821NL/yPO43jiVa19ELlue8iL0T
 0KIhyVU5qwSVDxA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-cmds.h containing the complete ioctl command table
mapping TARGET_* ioctl commands to their handlers. Uses IOCTL and
IOCTL_SPECIAL macros for table generation.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-cmds.h | 151 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-cmds.h b/bsd-user/freebsd/os-ioctl-cmds.h
new file mode 100644
index 0000000000..359e0dbe08
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-cmds.h
@@ -0,0 +1,151 @@
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
+IOCTL_SPECIAL_UNIMPL(CRIOGET, IOC_RW, do_ioctl_unsupported, TYPE_INT)
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
+

-- 
2.52.0


