Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF75E937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxID-0006V1-3G; Sun, 12 Apr 2026 12:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHq-0006Pu-QG
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:52 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHl-0004VJ-GM
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:48 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-470145d7df5so2288727b6e.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009821; x=1776614621;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aXHvbfwqhCila++e6qHrBf6an4295SAF04kURxuYrWg=;
 b=y0rQSHRTI/RPQswCzq5leg/2xxB0I2vGo4idpgGTDwdy1trLU/trxLf8h4VpiKLxlY
 54/zM0TRheNRANLEc08l384qXFKU/Ze35dICrdjwYXRSNa47n1Vez4vOLRk5MYahqPqO
 oZp3aP9hXDbqG3lvgmlCY+akAIBQVajGnP1cOfXtQHQ0SC+VtuDnXh2A9E4NcMzPhejN
 H3y+ThyyZhpr154226sWAQOyIQnbfXuHYwe6YQTlSXnsHrcS2XpNPp+LH29E7BgB0o9K
 CckKioGYOS5NC4Af4UUbEuGx/mWj16vvEUlGY1thsMClOpBnqRqGwSSwNScWs0iawhtp
 MkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009821; x=1776614621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aXHvbfwqhCila++e6qHrBf6an4295SAF04kURxuYrWg=;
 b=Mkfgmbf84qxSBvtHO6viP+9eGIlpqzjb7PXXYWehH/nMpQKLG7DeXePu2dSQONKBUV
 7EfJvUiyLDcipezMFqZdQoNJgGCtQA2rt8essDkY9EZO+rREa2FvHM97nBURdlJdEzMO
 4Bj6zux71vDVSY0qJ75Y1cdUZiX5ax7izXuylsFiSlnOBaISWGbgxNHWQYcsba5PNDBb
 3LotP/zY9OcFPum+6jD+Df5BaHABKXNkck7m/wQHefM4Gtb/NjdBdhenWmfIG+FujTX9
 OKV0kRVNwdNBqcTjleHQQQWU3JKcELxHDXmhVfcgBpJlwqCki1ymuqGQ4bLfzKbtDwMh
 Toog==
X-Gm-Message-State: AOJu0YyXY+GOAEOQ2QMhBiJeUgUPJ0RIQCz/kF+rCuRpwdlPv8ngDoM7
 z5m7a4PLx3V7IixVJn60bE0cAsY6ds/uMJjZGrB7tAn6zmOjB3u9bfBIFQC/Brmz0R9UqI05j9p
 PHx7xv/U=
X-Gm-Gg: AeBDietD+u8Cf7j8c5YvOV27ih7419T+D/HP+BnkNMLwoj4zGbN5Qh1G6P0stBcV1tP
 x8SrpN9QybDP2bmvnUk2C8Hom0XWNMih65Z2qgB+EnhRNBg/WcNftevNrIKo+j8usFyKvBeRBRK
 TMdu7ubGPzpMHMB7dbfEXqtQVow5meQlyEfgCYv3z8ZAsYnyeNnawwtziGFa7J99xxpPBiR6BM/
 URbcOXGfNza8amPDZl9xNZtuUEh/m+Dtoxs+QjAl+jm0k8LoXrWmTRwHeljegE0p+OLMF9omt2V
 JZn9W6NP142LbChfQHm5enJB/Q5RuXiwPA9xRdAt/+E0UrRk53tESi3UL7ZFkfMrJFHIP1403z3
 sBgR/fN+rWGlLeeB4qNMu3cES1M2AB6R7tJNa0VKQWfcsFnyw4sxsybIvomKuYyk9y9gZ73zJMQ
 7WOviEgSFDeO7lG5MCGYma
X-Received: by 2002:a05:6808:1796:b0:45e:f0ef:382c with SMTP id
 5614622812f47-4789f8fc6c0mr5389348b6e.44.1776009821004; 
 Sun, 12 Apr 2026 09:03:41 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:30 -0600
Subject: [PATCH 07/17] bsd-user: Add FreeBSD ioctl type definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-7-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8sPigRwG0vQFguN7CSo9z0cJsJ/owqmYKQDTqdJ4kxg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28Ig05Sr6hl62UV+iB0OF4ZAhU33IIVvPzDIW
 Zhv61sHZVaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIAAKCRBsHNEofbAR
 AIhXEACXV7NwkZBq23OdoufSnE96xlcRQt4tu5j5M2L40Jajzt6lZBYIsgKo9sejir7r5cXY5eJ
 oKiSFrkQtXeozE5pjeKlN5y3LCBj2D3WNzfGsd1jkRDW4AbpVMn5wFL7dcc6kXWlOneyWXLm+xQ
 GZcirDpkdkvtIPYidF/L3FDTNGs82fOIon1MWyqL8QxGHkaGTPU+yKqaJSykM2g8GnX2MxWNanS
 0HKZHVQH5KhTw3scKdAlxQK0a+Q9MvioJPkEmlJxpGzK+pnrHzyEbV4CDcaVqFAv1cIdItT/4ff
 tZdkOW/dn9nEL4tZOfRBoswU5Y+sq6hJbik42XDpAX9/96PzKP6cCYOz0GbcE6v9iouwz/mU/DL
 9olq5RLih3IwoZ4X9F1kT4MAvBFePU/TqaVvQOoEvgbDqf457TIEjTx+oWDVbDwALwO+Nr1o4v9
 zP4XYmD1/SYpgdVyw4nrXIzLRLTLMfOmmplajMEY6rQNkf5qumF9SF7dHMtaioO9Ld+KJuuun2I
 wX+WT8JSKPU/UfxWiLNcISHQVByGAk8MTGqpuXtTNkDkN9K07vq2y2zaWMWQCInzrX5rOAkJFcg
 3YnQ1XrkFbfckYGfSBrWNZvLkaumsHxtAjLrmwTEV0SETzereJSIDaIW59guFlYECEtHmrbvAs1
 QEnxhgFAQsEEAPQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
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


