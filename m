Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7744CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPm-0006NZ-E8; Wed, 06 May 2026 22:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPk-0006FX-NB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:36 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPj-0007eU-2Q
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:36 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-66ee7b9af94so134887eaf.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120674; x=1778725474;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XaSml2dtAsMaM0n+gsWmiN67y1iciKC5NnWPliXUBY=;
 b=MZKjWjVSOz/9NaPA1sPxAppUYj1K7bvHM+/jyEI9hpk8WuybmpmzhpWBkt4Lc9W4QP
 6FKhxzKYpuafDPNa61DiGSGBS+aqP4cB2IThqCUooOFQ6A37hAW1tiB7TwFZGn2f8AAB
 /jbYIoKJwzWy36OME6gnPXNUTVfqJ0atYl2Cs0+Ff36JceTctMMWc3SiTWNtka6JeV/X
 CFkM+RRAvFVXUoB2D7i4rRyNk0c1zVAY6CoYkwDdwJqF3VQ9D19AFJG6GloTRR7pAR/e
 wdU2Rfeagp7gmYU5KHyrkmqSEiYxobLRoeDCw5iZFReAj9XHc6jE6b01bRbCttcpLbvP
 /gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120674; x=1778725474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5XaSml2dtAsMaM0n+gsWmiN67y1iciKC5NnWPliXUBY=;
 b=GYezq1KsktI92cgDr5to7gEszqHTt5eUXkDgURwDWL57Zq1sM41gRhwaomAxR6lEgS
 O6GxkVoIYbup48d25dO0asN87/UUqiT/k/0Jxqe+rYW1a2EzAhOaL9ty1ZUeb3wOC+DM
 x2cs86pyoxuS22J7N27xIUvMGNbBmQurCu1a1EEOjZNegeiO+iKCNl7q2SHnf9ymtCwJ
 dqa/sqnx0cxkX4AD+1pKkYjoUx6NgvtR/Be4f24xTdKAXDbRSmeNqHiXUtofEnNZHClc
 LhSTHQ4yNU52qnB07j0ZgigiyDmn743AaLgA+IwNKMp5m+cKdwYo9jOIrBFSPcFi19Q9
 ISvw==
X-Gm-Message-State: AOJu0YwO5DWjC2de7FAxvEcvCP8AmWqRb0fzyNDH1m25UBAXgABLw3sq
 aqBLfuB9umge7WIfKb/8mB19V7QlcLtSFD5PyzcA6t+vhIX9bMtQ0RUgtToXEs+NO1X5h0MTcAG
 9JuHkgMs=
X-Gm-Gg: AeBDievERXyO1F1nLTRUlH0XnmhjC+kYxEufY8UGZ1cB+DJ4Z0AAzOW/NvbqGjb3lfM
 BckAlHyWMd4DSj84zzHlpOARQPiVNVsWs9ciGZDdKmqs5KqPXyR1/Q17hP4HF1m1g1AQaWCgvvs
 aYar7Rsa6mUPpHB3dGcGds3EI2Ahtr2fCK1svkm4LpVgGsgvnI5CCAbalboTYLzujSqxpB5P1Fm
 3lnH5zjsrRNjP1G+1RK0l+r35YZwGTzjnXAFAnbyZWF8mJpure+DAq/8AJacN2hQqrgnVDEyjwQ
 RKW8ACL9umxjx6LbXpGaYfw/GeA5DldoSMTCG+6ilZA3QuSP4eK4GJqktTkeKVJ8FsJmZnICHW1
 q3+fLvGh/y6R/8DhqzN7Xh+tDDWBX94q/o014lLykM4rC0Tm4Ho6CfmOqVTxGSp8SGWSc0Dfi57
 tEhVNN6J1w4PqHwiiDLqT0gts+z4392Aw=
X-Received: by 2002:a05:6820:1743:b0:692:1f42:f1b4 with SMTP id
 006d021491bc7-69998c8d193mr3209337eaf.8.1778120673693; 
 Wed, 06 May 2026 19:24:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 14/25] bsd-user: Add FreeBSD ioctl type definitions
Date: Wed,  6 May 2026 20:22:08 -0600
Message-ID: <20260507022219.44171-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2a.google.com
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

Add os-ioctl-types.h with STRUCT macro definitions for ioctl type
registration. This header uses multiple inclusion with different
STRUCT macro definitions to generate both enums and type definitions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-types.h | 109 ++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-types.h

diff --git a/bsd-user/freebsd/os-ioctl-types.h b/bsd-user/freebsd/os-ioctl-types.h
new file mode 100644
index 0000000000..496d1e991b
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-types.h
@@ -0,0 +1,109 @@
+/*
+ * FreeBSD file related system call shims and definitions
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+STRUCT_SPECIAL(termios)
+
+STRUCT(winsize,
+    TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT)
+
+STRUCT(fiodgname_arg,
+    TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifconf,
+    TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(sockaddr,
+    TYPE_SHORT, MK_ARRAY(TYPE_CHAR, 14))
+
+STRUCT(_ifreq_buffer,
+    TYPE_PTRVOID, TYPE_PTRVOID)
+
+STRUCT(ifreq_char,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_CHAR)
+
+STRUCT(ifreq_short,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_ARRAY(TYPE_SHORT, 2))
+
+STRUCT(ifreq_int,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT)
+
+STRUCT(ifreq_ptr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID)
+
+STRUCT(ifreq_cap,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_ARRAY(TYPE_INT, 2))
+
+STRUCT(ifreq_sockaddr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_STRUCT(STRUCT_sockaddr))
+
+STRUCT(ifreq_buf,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_STRUCT(STRUCT__ifreq_buffer))
+
+STRUCT(ifdrv,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID, TYPE_PTRVOID,
+    TYPE_PTRVOID)
+
+STRUCT(ifgroupreq_ptr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifmediareq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_INT, TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifstat,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    MK_ARRAY(TYPE_CHAR, TARGET_IFSTATMAX + 1))
+
+STRUCT(ieee80211req,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_SHORT, TYPE_SHORT, TYPE_SHORT,
+    TYPE_PTRVOID)
+
+STRUCT(lagg_reqport_lacp_opreq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    TYPE_INT, TYPE_INT,
+    /* struct lacp_opreq */
+    TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN), TYPE_SHORT, TYPE_SHORT,
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN),
+    TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR)
+
+STRUCT(lagg_reqall_lacp_opreq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_PTRVOID, TYPE_PTRVOID,
+    TYPE_INT,
+    /* struct lacp_opreq */
+    TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN), TYPE_SHORT, TYPE_SHORT,
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, MK_ARRAY(TYPE_CHAR, ETHER_ADDR_LEN),
+    TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR)
+
+STRUCT(lagg_reqflags,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT)
+
+STRUCT(lagg_reqopts,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_INT, TYPE_INT, TYPE_INT)
+
+STRUCT(in6_ifreq_int,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_INT)
+
+STRUCT(in6_ifreq_ptr,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID)
+
+STRUCT(in6_ifreq_sockaddr_in6,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    /* struct sockaddr_in6 */
+    TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_INT, MK_ARRAY(TYPE_CHAR, 16),
+    TYPE_INT)
+
+STRUCT(in6_ndireq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ),
+    /* struct nd_ifinfo */
+    TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_CHAR, TYPE_CHAR, MK_ARRAY(TYPE_CHAR, 8), MK_ARRAY(TYPE_CHAR, 8),
+    MK_ARRAY(TYPE_CHAR, 8))
+
+STRUCT(in6_ndifreq,
+    MK_ARRAY(TYPE_CHAR, TARGET_IFNAMSIZ), TYPE_PTRVOID)
-- 
2.52.0


