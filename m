Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ABFFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6Bz-0004bb-2f; Wed, 29 Apr 2026 10:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bq-0004Uf-55
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:02 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bn-0004ZP-L0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:01 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6966d16b978so273298eaf.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474018; x=1778078818;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aXHvbfwqhCila++e6qHrBf6an4295SAF04kURxuYrWg=;
 b=nV+n8wTYC2cM5ce2mZ+W1Nyh4W81rpke225Xp1ucmcTRiKF400ICsaKtG8LjbFyCjt
 7kMdrFV7qkSnbflzu+1mqJmy2/IsN/7ilKB2rT0m0BiohjRpK+wID273D82Y900OYNSU
 ezCfmExPPPLJywEftmVHRMGTuJDInK+G6lgHx2XYWJ3S3ROW64oWgVJv+fYBtfNHbH5U
 XNg2UsURTtlQ1WBL6dJ2YfQj6umq+u/6LfGMrB2IXZXYKmjFEH7xzt4qaiJvcQODpTwi
 9zTOkYNTB/ItgnUNkUSytq75/JxCrmg6DEL5VaKZ407Nn92nf2na8M4qki6f5RXALXPN
 gG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474018; x=1778078818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aXHvbfwqhCila++e6qHrBf6an4295SAF04kURxuYrWg=;
 b=pJZfPUtcaT67ztsOzYMU1uJlwmzsbc+R5IMbZyOvBeZBI5QJ/92hdKjYY2MoVTNeVg
 ZAv6JG/nvpNmwvKbSrwtCg6SusCt1VYyZPyjugj2o+mCDkzyb8WWMV3plsMaYRdBnGe5
 hB2TVnLzJzwLSOcT5i5RuRZuLeSVNMjyMfDzqLjgAsBuNDyoQ0+H5/APmPzEGKq949tw
 iaQYYAfOZ92CxU/wT4Ap24vCKAu+llVu6ecKaEUkv2PnuFQGo7BlONGWaAcRVzx63oeq
 raznZlDjre5lhTkmTAR+MMQDEOLRXZJSjdSrVcO41U3Ir0liVRxG7egrR+e8xP0cTmei
 JPLw==
X-Gm-Message-State: AOJu0YyONazkEZv0XqP0uTbQfJLA/D4OuqlUzSwBuhJ1fZFMWWkRJmFT
 dghE0G7YFM4rpa9UpR3h8s+eBXD4XR5EcQtbVd6a0oO4sMIuLHQ+RwG9XbqGih9rASs=
X-Gm-Gg: AeBDies8h+iOPHcNJvSjYI2FQ80uyJMsq6cLkj4OVHTwYOtvpJhua+4W8s3g+IvJIer
 /dEY/hK3WJVcfODvmIVdrgBW0ABEDlh8upZfgC4ZgMLe0fL6xDqPUZqgYFDQzFpWcf1lc8t0eO+
 Y7kX23qt32MyJ3M1rhYGqh6WSOk6Ofugn27gU5vbpNoQFD37OafKj98wPB9qaCjcadKPTZfHI2k
 sq3lTmb9BO2ivzk4ng3FL2tIpWFqIm/kDKpD2UffqCRhCWImjEU+V8mgQunXEQ2ZNPzkenQFqsE
 QEJsV6fzNtg3+d80Row8gvJgFFapDQC9SJQN2Q/Z/tGeU2U7+vup6baLOpDPFzE6qh1BUvk95gB
 3HboV0xWECLDW8o9wD79LOKi/LWvG0AVUEaV0erY20L1xoX+gCCqnwyNfqfLM3/IMvMchU9nMnI
 sVtMdz9O9BncIksZewTJhp
X-Received: by 2002:a05:6820:3088:b0:685:d435:1471 with SMTP id
 006d021491bc7-6965ca51435mr3783962eaf.10.1777474018463; 
 Wed, 29 Apr 2026 07:46:58 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:57 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:13 -0600
Subject: [PATCH v2 07/17] bsd-user: Add FreeBSD ioctl type definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-7-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8sPigRwG0vQFguN7CSo9z0cJsJ/owqmYKQDTqdJ4kxg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl9+A3bXi/5bM7u7LvcT65cenB2ARMb0ixoX
 auVmvl9e8qJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfQAKCRBsHNEofbAR
 AD27D/40qE6e/tYjOcCoHtkdCb8uZ+XH6dJokt7yT4QxAuhC4tYAJgZri/hnIJ+SM29W0tnm3ow
 pqaUYjOWrvVn6/QZGLHe99dg5e2sX39NxgAUZc/6fAMW8hAKpFGxr2HH2aV5MLnDBSrSCDB5HAJ
 yxE8qePq4XjCOrV8wNYjoVqufuuSUn4NKB09THg0bp53YUO93ibZllQJXFkcegezgAf4lumr72z
 nAeuIVWmEbFs56MePmLVTaLJEgDlLpx5YmyroDOlB2anXr7B3hfU3cMR6XGpdaOf9QUDlOnRZdU
 TtfoNlk080PBLffQ2wRCUScsXMPg6IPgpp3X5TWAM+/wH5qIr0e7OllniSw9/hsj37XaHjqYydI
 h7WR78a+2pQxUy5NujP3W7IQMDrlFFbRg/kxIrcDjhuooAJ8TNGKejor4nMLybWKYewBzrh4UPQ
 1ulfqm0Yr1ka0J9RNc0qGkS+l++ylq+MDa9p4CaCdsQ296EhqnqmUe2Hn16xsHkBTyQmz/T5P4Y
 xqrldM/EaaH2ni578Fln7Qqg24woIvAhAkV6Z/ftHsAvNz6hb3viTng27hoLw+6r8XEr56t/UH9
 Osg60i6Pgbt9jw4Zec5VZBWKsJrv52O93yp7LTlu9Yt/cSxu/dAdeq5fSzNCPB8HXtqUD6ZEedP
 c+RE1upgYIqhPJw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2c.google.com
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

Add os-ioctl-types.h with STRUCT macro definitions for ioctl type
registration. This header uses multiple inclusion with different
STRUCT macro definitions to generate both enums and type definitions.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-types.h | 104 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-types.h b/bsd-user/freebsd/os-ioctl-types.h
new file mode 100644
index 0000000000..ea0a7b7d92
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-types.h
@@ -0,0 +1,104 @@
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
+        TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT)
+
+STRUCT(fiodgname_arg,
+        TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifconf,
+        TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(sockaddr,
+        TYPE_SHORT, MK_ARRAY(TYPE_CHAR, 14))
+
+STRUCT(_ifreq_buffer,
+        TYPE_PTRVOID, TYPE_PTRVOID)
+
+STRUCT(ifreq_char,
+        MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_CHAR)
+
+STRUCT(ifreq_short,
+        MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_SHORT)
+
+STRUCT(ifreq_int,
+        MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT)
+
+STRUCT(ifreq_ptr,
+        MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_PTRVOID)
+
+STRUCT(ifreq_cap,
+        MK_ARRAY(TYPE_CHAR, IFNAMSIZ), MK_ARRAY(TYPE_INT, 2))
+
+STRUCT(ifreq_sockaddr,
+        MK_ARRAY(TYPE_CHAR, IFNAMSIZ), MK_STRUCT(STRUCT_sockaddr))
+
+STRUCT(ifreq_buf,
+        MK_ARRAY(TYPE_CHAR, IFNAMSIZ), MK_STRUCT(STRUCT__ifreq_buffer))
+
+STRUCT(ifdrv,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_PTRVOID, TYPE_PTRVOID, TYPE_PTRVOID)
+
+STRUCT(ifgroupreq_ptr,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifmediareq,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(ifstat,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), MK_ARRAY(TYPE_CHAR, IFSTATMAX))
+
+STRUCT(ieee80211req,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT, TYPE_INT, TYPE_INT, TYPE_PTRVOID)
+
+STRUCT(lagg_reqport_lacp_opreq,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT,
+    TYPE_INT,
+    /* struct lacp_opreq */
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR,
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR)
+
+STRUCT(lagg_reqall_lacp_opreq,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT, TYPE_PTRVOID, TYPE_PTRVOID,
+    TYPE_INT,
+    /* struct lacp_opreq */
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR,
+    TYPE_SHORT, TYPE_CHAR, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_CHAR)
+
+STRUCT(lagg_reqflags,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT)
+
+STRUCT(lagg_reqopts,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_INT)
+
+STRUCT(in6_ifreq_int,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_INT)
+
+STRUCT(in6_ifreq_ptr,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_PTRVOID)
+
+STRUCT(in6_ifreq_sockaddr_in6,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ),
+    /* struct sockaddr_in6 */
+    TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_INT, MK_ARRAY(TYPE_CHAR, 16),
+    TYPE_INT)
+
+STRUCT(in6_ndireq,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ),
+    /* struct nd_ifinfo */
+    TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_INT,
+    TYPE_CHAR, TYPE_CHAR, MK_ARRAY(TYPE_CHAR, 8), MK_ARRAY(TYPE_CHAR, 8),
+    MK_ARRAY(TYPE_CHAR, 8))
+
+STRUCT(in6_ndifreq,
+    MK_ARRAY(TYPE_CHAR, IFNAMSIZ), TYPE_PTRVOID)

-- 
2.52.0


