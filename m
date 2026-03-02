Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3CBD58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunD-00014Y-LD; Sun, 01 Mar 2026 23:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunC-00014D-9r
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:02 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunA-0006s9-Tr
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:02 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-463967f35d7so3326059b6e.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425319; x=1773030119;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ey4673YM8ktVpT2Ls+nFfhw0N2Sr9yDILIGg4vvNF0=;
 b=S/mGoBOzHKELi14aSEAtJVvUCfaPpwp+KoN331wkdRZHYLYYf91hbxJ8hSZ5trN8j+
 xu7Se4JlBgxBqMbS13o0fFWeLkBA+Vxd07JMhAXqF7rva7RBiMiBo2aBb1vxXMtl0JPO
 dxOCGvkqsiMX7b2Q0EWfxapp2wzmWEO9AclNnMeY4jmFmMV9EbJHq9F5jmY5IpCvnZcE
 BrJKWCYWPhVl5+uo83qUS6KMB0Xc1x91uCGwVcJhjJ764aET8QeJT9ExfBfAhBMkp7aR
 3gISx9i7uXbBdqHZki2pfg8uQN4DQru71fHUZIqQBe2nv+gviA/AT9QGJcyd0z34+8/8
 Lesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425319; x=1773030119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Ey4673YM8ktVpT2Ls+nFfhw0N2Sr9yDILIGg4vvNF0=;
 b=mGDFSjSik3rL9tBvKtvjPxIGPVtyKY+6zvOZBGM82mTIBOvYuQ+BWKHWxe7N4wzKoP
 Zr9/sIMrBf7i/84T2V3gxVvahC1xrCRXzH/+MZimfuXYHOi5qXow3np3YPv9oXPt+KSG
 +LWYhGNpMcbOQKVvhFB4Rysfq7/wfs89PwVlytOTPgUT82pacXUpJCGyUbYJjaWcXrWh
 K+R9Dltubg59s5Q3KlJ3yfdm+0ZBfBmxIQuFbiyr6SIzvpHI5YJQQOQOC1NqPPJ6C+nQ
 daYtrlM8gK4EGlkAQ3iVUYM5w4M0MF7rjfVe9fCVfuUTxKLmesVlOuhg+QxNGXFjMSdX
 WElg==
X-Gm-Message-State: AOJu0YwcwEspc69gWBry5TA2I9fmhrcTwfPE3n2zIdIqVoNX5khzchUN
 LbdvODCp9xMVwiyKgDfgEdKskiqUtx1ptYyGWliE98lkJtdnomwq6NsuexSruuWPQSoCUcUqUIb
 jvQp+3Ds=
X-Gm-Gg: ATEYQzyHG5TmLduSC7PfSMLwP1MUras1FLH9GeFl4Zm1g2/Na/EJfhIu8XfCg5JFQ/Z
 obCFGOJVlQh9BxDhMqUdxHLJJi6VSRJH3KMW6yg7zo1LgJFDBghj3PGyXsmBgSGnm5zO30sUyPE
 YC0JS34feR1zMIqHQ8dhOvmp3vKNK4mHqJFHik+lAWHtoZBoEF1oR2mNpy/gIse3bjs3SavB8h4
 0h2cCfML/aUpBkabtOSxJjg2wuBhU7mJDVK2pRjirApf5PhlxhgWuBJL+IkqwvbCLVsvL/2GG3m
 AGOzSaO4sJT3bEGPvkZYIXM7qeb9Aw6Igc/iZB5dQN+H/P8N2YwcPJSMhtuMrhnwaVOVbx2nkuC
 ae4U+U0E7pqt5+MsyLZruOHo4qpa6LkRietg3EM6nJNv2a8Uu17uASzbQjWiaSIZ4wb57cPSI73
 vGD6lq/6VfEg==
X-Received: by 2002:a05:6808:22a1:b0:463:efb4:f9a2 with SMTP id
 5614622812f47-464be9e59cdmr6282958b6e.28.1772425319241; 
 Sun, 01 Mar 2026 20:21:59 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:58 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 17/27] bsd-user: Add do_bsd_uuidgen implementation
Date: Sun,  1 Mar 2026 21:21:05 -0700
Message-ID: <20260302042115.83410-18-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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

Add implementation of uuidgen(2) syscall that generates UUIDs and
converts them to target ABI format.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 7587ffd605..9f1cc8a0cd 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -32,6 +32,39 @@ static inline abi_long do_bsd_reboot(abi_long how)
     return -TARGET_ENOSYS;
 }
 
+/* uuidgen(2) */
+static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count)
+{
+    int i;
+    abi_long ret;
+    g_autofree struct uuid *host_uuid = NULL;
+
+    /*
+     * 2048 is the kernel limit, but there's no #define for it, nor any sysctl
+     * to query it.
+     */
+    if (count < 1 || count > 2048) {
+        return -TARGET_EINVAL;
+    }
+
+    host_uuid = g_malloc(count * sizeof(struct uuid));
+
+    ret = get_errno(uuidgen(host_uuid, count));
+    if (is_error(ret)) {
+        goto out;
+    }
+    for (i = 0; i < count; i++) {
+        ret = host_to_target_uuid(target_addr +
+            (abi_ulong)(sizeof(struct target_uuid) * i), &host_uuid[i]);
+        if (is_error(ret)) {
+            break;
+        }
+    }
+
+out:
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {
-- 
2.52.0


