Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870D9E937EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIG-0006XU-S5; Sun, 12 Apr 2026 12:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHx-0006RX-Cg
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:01 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHn-0004VR-AG
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:50 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-42321c8b8f5so2952576fac.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009823; x=1776614623;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BKC2bjWi/SrtpYK3J2TKDXq3sEnsuUf9zoPfckC3H0A=;
 b=Qj7ZT6D0yLEpNUrYdd2qK95H635Nc1O+hUYtJMlbQt/GeQFPu9eP0xCE20QpsCZJZh
 S5cCD4hsxj34MUS9tYfSECBNmQ4wQgNYOBjSItSJn6Nk+wZnq+G8Wy4dzGIGPnalCded
 +K1ZQkmM4mvGBGQ6fO6edsOrWU/qf9ii3CkJrm0tpu4fwkegoaX5Rj82uNguV2flXZGQ
 6Uo45ZEgRkyiFaVLcLKHr50Cn2aUobuHtOmmKt8RCop22coe1yuDz2fJ6hhyx/11b1Xi
 BvsATcOvrSZ4QNrn6ITa+wgzl3jCSE2Opx8l0axNRjq+fXpnjCb6BSIEEcNnbznkG4sg
 06cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009823; x=1776614623;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BKC2bjWi/SrtpYK3J2TKDXq3sEnsuUf9zoPfckC3H0A=;
 b=q5NipzovG7OQC/zQbMriXYy18nW+npGl3HZ7i0uy8qdkxiBQaQwp2r5vP/gtHFIbt2
 tBhZRy52Q0y/7Py2b658bqbsAsuE3SfBXiK78APTZclZMina408GZAIFxGRM5RpnR59g
 faN/QnMY/bxmBLiUXxi99roYkUm/CqoKUIixVYaKnVHYbtDNHuyysRJJvJXjhQjUNhi2
 uYvhNQU/1Z6irwyQ8IuSuQbWjn/IFlT36IROFOlMwhJJ52wWeJUZC0TJtNIEj04189Ii
 IblZn1K0rsTp1DHHvAMy1/2KAPvHuINCZYAsdZC1uv+Vqbx2pCQeiU1flinYpmuGyjdo
 FZ+Q==
X-Gm-Message-State: AOJu0Yxh7U9lDl9QFmR3hINOeXHiDgkmO3nPssXgPHucDAEKBYJQWhD6
 VZcsqgMvdr3Q/x4yt65NyymlYxBsIdz3UoKe7MkGQo5JlSDPD2mw6QE3oGX7c22W5pwQ9yWEuRw
 NdC9G4fg=
X-Gm-Gg: AeBDievOAB1JJC9SaHoUg9cGIDKaM7n00sPx03eRWNBcK0IKegUTDHn8s3dOg7pz3/B
 ZOI2M32OMpdwrmhdcAf7IXDGOnDLHpE6sXCQusQc3tRu4P+p8YETMkST1Qax6StcjmfBwMrTy3G
 aZBmBwQaFuWVF+AN2RYgXXJhhTPaKHXI1hczWpbHCww0O3RaUMgKqXTLmbTH4RCDfOkhu9FgAPW
 QBxWjRiBykhjf5xSnZ0UJKCKExV9XwMTYRUbnxePtRLPXShbFlJ9xg+3W8kifLswatJ5UY2t6GN
 0XzRD1ooQp16xNW4NYaFQR4FKa14ZZadS3Q7jJA0KuHIaPPwbMqQ7kTcBo4LKCKD7vNTkeD3/Ge
 8GwtSbtcU56kHY8w+miOlPSnyqhSTgyncfHH6UD/y/mqJghJw6OppgCfgLTL5Pa+NSHEn0fyVfM
 apOsJGN+alSQ==
X-Received: by 2002:a05:6871:c967:b0:423:4260:2e0d with SMTP id
 586e51a60fabf-423bccab0aamr6989832fac.8.1776009822895; 
 Sun, 12 Apr 2026 09:03:42 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:31 -0600
Subject: [PATCH 08/17] bsd-user: Add FreeBSD ioctl command table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-8-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6990; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=NmJqk3FSVLIKDs2qsRfZvQlgCcX5khfFeERHrIqG7cM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IgJpkAr7ZJ9f6xkm8QpLbT2GCuxvgDr9VTz
 ELZZOQ3Q9qJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 ALM1D/9eJZs2oDESxJiMVlyEGEv5oHY8eNyCBLJQPQKtkth2oZngzJPe0jZb17+eqIUdDg/grdq
 xA1/2fT2QWBatujIOfRKiJF6+PKugCFeXv+Vihe6bf9xpZWXCmSRNGfN+s2KcdGWigX3WarV2cd
 3KwzFIEgLBG8IYUyEzIVRZYHRQrA+32nbCBgcccCUUjRDOvNbO5ewjxI/mlrDlojvm5BmWgywZP
 UPp+UHAwyJiJDhaTiQ+F8nVJVVZyyNe4DJdAbQhdIiiGTk1u+DkmoqQ8oD1XN8Krutzn7JYvDC/
 dbapzWdVY3VuS7LEbbdCMJ7ot9Qe2mEmuAMdXnepsEPRVc1aBZwfnIQWNg6q3FS2nmOBa5xG8yA
 XBQ1NCvuKhyc2ji1HslIskgvygWzZbT7P6v70NogpuykKlffuxZPYhpRCQ8+I+Fz6Rdij6WMVRX
 Gg9e52i9NV5M07q9xjAi5DRjIufGIyEDjhBU+qmy96beDL+CTt5YzebyrE35NwJA0WzU2awzXi8
 AQAEAFcLccQCEjG4kEb7/OXrFW/DiReLN09VZd4B0avL8l0ZRlYyg25NUkyR++YOf/iCGyCOToL
 Q2UKdZJz9sNyC8sny+Z5KkFvIUkPMkLzaAe0ExLcqpxk9q937lubJy0F7QyYw0ngxLu+hey+vJW
 geX9j7hUmzYlwfg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
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


