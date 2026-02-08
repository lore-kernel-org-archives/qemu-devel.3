Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF19CEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASi-0001PF-1t; Sun, 08 Feb 2026 14:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARE-0000e6-Qy
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARA-00007G-4w
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:20 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6611c3b147eso1622027eaf.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578811; x=1771183611;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q5WTlJz1qCf+XYT0IU9mxBdb/U+AXmUjRy97meUtoxk=;
 b=bS5lFCfMr6k8WdEDtOabVmE+3t80Ozlj3zcvvTYvaSs0E/Xf9psYF2n821hWwB3ZfJ
 tG1l4vqOqY6oj7xP0UvBImrLEFKFKCh4BtgPUCdxB9vveOMf8jXJBaIUoX1xyH3v2Aa6
 uQeagskKhDenhs3VmqH7B+7/uzKHLzNKmTK0PxS2R9xVTz/eGNpRptE9PLcxtpkt3dLV
 Az0EV9uU3nIj/lgwKlZmYJtIX00LaIUFnaSmG5/L+HZDs3mdd/oqUB66IRQPsjpS+wxU
 v+4uZsDAaGtjUefrb9tIpJkeM7FZZPHliXhnapkIEgNP8HG364buZxIN9RDw0EvJZrpW
 VW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578811; x=1771183611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q5WTlJz1qCf+XYT0IU9mxBdb/U+AXmUjRy97meUtoxk=;
 b=V7ojieFMwgT29ALMA7uyvoQ0UL67gb0VAfrpNKtVMlgOF+alZUT0xaWTjB1XEHIeig
 mpkKutxCQJt5pJjLzMpYDdvI48DQblH7ezbmncJe30sbJvQf05jTC2XeWZLo+wALdFot
 JMCry+liAUm2p1nn1EJxNBYD998XIr+MctZolsWdFdREtXTgZFCJBI+hjKhpldP1bi4U
 s4XTFos2ezImBMlqB5vb85tPd8U/oe+5oHE/bSUIQL8ZfipHf9b9NZeOJ0RNOGL/6ahe
 yJM9cWHnv7uIzfNqetOxoMHqVjkpHbFDdFIpbN9Q5MesiC8eSL9jEsxxf7/CsH5RlTLw
 hWkQ==
X-Gm-Message-State: AOJu0YxLQ6WSsjYDvxvWHXFN1hyOCrm9MdeeuDPtRA8FGcty3leaGvg6
 R24P+C2LRASiy9QILYwRaPcEJfXB/U8xzYKhNwXATEQHPF+mFauS4vhWF+P/lGXTLaE=
X-Gm-Gg: AZuq6aIBUVXGt+Wibtjpkz5GLFtgfraUCeGb5ExIxlIaiLLRsNoeGbMbBgxKyTZUlTT
 13H5/fQlFeCYStUVKL7NsUamp3KwaQTYFN9FdHhTBS2d2/zVczjV86b/QEeSJaIeXVtSEQ+8pnr
 kEY5ZLQN+bZY8xr8lnAIMk9BEYr94w/0A5WICsPWMR6w5IVC/HLkMeClFd9VyAahQgCdMAnROzw
 c31NNmQTQn++MfHOp8ED4CXd5kUEPHs1H/LTjWmJdRxX5GmUjLduZPBD4/z8vUn4nLZFr83pJLb
 Mhhiiapcx1G4ruzyv6MxkG5XZ5GegO2y9uibrmB0oxsIQ31g9wpWgrWLfoPUTdlrNLy/HDw4HAT
 kq8+Xqpkw0zmi2S8UMLXjIrh778mcYFsVW2E+Pno4/TFTtyrst867TkwjO1vjExDDP++4mlzGow
 ==
X-Received: by 2002:a05:6820:3088:b0:662:f91f:4a98 with SMTP id
 006d021491bc7-66d0c18aba2mr4059777eaf.41.1770578811411; 
 Sun, 08 Feb 2026 11:26:51 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:50 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:28 -0700
Subject: [PATCH v2 19/24] bsd-user: Add do_bsd_msgctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-19-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=vqCCi/gzXNqsKM8T7dejd96Ao9og9YHb3338sylYGIw=;
 b=owEBbAKT/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhbpYMeqnANGVlS8b7cn0A5vEg2OGEF2PWx
 3fLDOiHGGWJAjIEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 ABpkD/jZ6nbaDH1jPcqUKKfBBkQtI+zB6X3qnzIwC1OdRRD2POkVUAVP3FtSECApzeEe1uf6CVy
 KEkgSdRl0Z/2hgTv1k7rBOg7qmHDa+lbV+tDYySiChLKRylLkdVx8XEfyCRXjFzX+zJ4DGYwd+R
 kdVNCqI0GTSvKF0gd/3RB1FzDZkzwg02g7ZxEkIRz0pZ0xRJJ80Wp4aEklGZqojWwnpjW4ZAnVo
 q+EacZ7gQ9+I0xOyCWMAEE8IiKoU3lJROKBpGM/yd9UELO0geI9SzvH+tlJtxURYTeqq9X6ZREz
 o2IpT09CEO+/a+yixsC8mcdctaNFpQcs6kSu6Un1gLFZ2Xy+n3VZ/2ljgbc1Pq2ZGgvgCUv+01R
 iaiaLV4JPGtIrq9RnEBhSBe6O+aZoyG8PGpYMQ5lVcgKAmj8EbdSZXlQSRndCjWMVFKxqffssmC
 jjVz++/Lx6SKZmjtYDwnWl/ynEzhgTdPHCDqU7HgwFLSrCMErwp4C7tTzcKJtepOY2KBk/bxQ8Q
 mxE2ulKuaPInSH/xfX4LRFniHiqlKmV2BwzpWniFJ0NIR/0NdQ9H+5IVdQz1GG6O4Je6lZ98bxl
 gWGigl42yXm7oQ0ILuC3WzTSuoYbCUoJJLqq3Ql0p5a7Kn6Rd5ZlPeflzuzLWabG3ihF1W3TqIb
 SeraNEKVZEI8w
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2a.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add implementation of msgctl(2) syscall for System V message queue control
operations. Handles command translation and structure conversions for
IPC_STAT/IPC_SET/IPC_RMID operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index d3ce01a2a3..a45fe8edb5 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -221,6 +221,53 @@ static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
     return ret;
 }
 
+/* msgctl(2) */
+static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
+{
+    struct msqid_ds dsarg;
+    abi_long ret = -TARGET_EINVAL;
+    int host_cmd;
+
+    switch (target_cmd) {
+    case TARGET_IPC_STAT:
+        host_cmd = IPC_STAT;
+        break;
+
+    case TARGET_IPC_SET:
+        host_cmd = IPC_SET;
+        break;
+
+    case TARGET_IPC_RMID:
+        host_cmd = IPC_RMID;
+        break;
+
+    default:
+        return -TARGET_EINVAL;
+    }
+
+    switch (host_cmd) {
+    case IPC_STAT:
+    case IPC_SET:
+        if (target_to_host_msqid_ds(&dsarg, ptr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(msgctl(msgid, host_cmd, &dsarg));
+        if (host_to_target_msqid_ds(ptr, &dsarg)) {
+            return -TARGET_EFAULT;
+        }
+        break;
+
+    case IPC_RMID:
+        ret = get_errno(msgctl(msgid, host_cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


