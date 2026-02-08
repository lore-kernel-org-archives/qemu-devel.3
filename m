Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F38DEF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASx-000247-6Q; Sun, 08 Feb 2026 14:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARE-0000e5-Q8
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR9-00006E-Tz
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:20 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-668fdb244c4so789876eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578805; x=1771183605;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ohMnK5LzT28KXvxRFz5qd37y2Zk3Enib5GhbLKbsl/E=;
 b=j9tzRcDepThSDeb33mkSFShhDiUH7AJemgh/VvXcIaf2HTviZSGA0E4LAG2CRRHGkb
 hwNvMdXNWExVkHfuBQ8WwKEHEo3mvcGeqUxdrB8ok4GYvWk48i+FQEXCd0Q/nL45HlvB
 PKLESKRxwsKTbvXyqPJrneF78qhsEgMxP42XTpC3aBCjWrNL/1LPNUwf5pJm9xw6j3rv
 Dri4GmWNXHOW9kxZdJ0v9OhJsChbafkHObHzF/O1NbPLQc+lHV8Cs1LScOVKNLFcsXHi
 RNxQzroMCN90pXqQxLI7BQ4+njh5aJcZXlA3434zX5W7WXkmnt0mKdOqplpuaoVUkwrf
 Bi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578805; x=1771183605;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohMnK5LzT28KXvxRFz5qd37y2Zk3Enib5GhbLKbsl/E=;
 b=BPpQuSN+D9xvp6RUyuD2mNRL78PN8owvupLQB7RGvwubZOfbNCJ4+G9+KeQ1Y/+WPy
 Nw5KJarF0bouu9OTbovbPQGzFrOx28HzfnizDSddOHCfR1quOKpxwGrs9FlEJUFiZGdD
 l6JJFyYLBVsmZ9cQSpwLChxgDRMMVWN3VvzeWPYLKLSJ3Grj/7kN/zZvcw0dnn9nJAd/
 gFiw4TopfWMJqTwi4QyjXaejIBt1FD3LIIOold9Nd5sqwnhbL1HmGx5gboh3bgLtcex4
 +37SWFX+5X34eFU6tZjrHvhNbOIvyYRbZ4wo6qrGjWqWZficf0vRODr1HfR5yVE3EBR+
 GvFw==
X-Gm-Message-State: AOJu0YwMp+qzUz300poYNGTouB22XfDPofD36CBkezHFgdfkb9m0mNTb
 8zApYBf3g+9DwN29MJz9KGw8KaIHAcZt4j6vaSypQb1EUQO7FWFZf5Ga5Ha3shZE35A=
X-Gm-Gg: AZuq6aI6KsFtLgAcGBaYa5qMeDxlNon0eKg1TWSKjkmf84iJ8Q+x4FgE5hfzgw0qoUe
 94cVeNah1WJxJRCqgkZDCrZz0mCk8bozHqYo9uPUO6PhJ2dtKFHml7GIXo0b3AjQNc8+R2okxoC
 HPbM5z8UUq2t6r8uleYgNlHMSE0xPTmzZa0wcnfZLAxg8GN/ejoUedatiunDiljKSLMer2OGLp/
 /puaAaf5S23sUwEpcfSNyBKq0cb8yDA609xZvG60QK+lq9c73BOO1zbwkuzxRaURvxoS/vKAFXe
 +wj9TEp3GeqRBs5QpTwKGSdZKe0s8gIMF90ghKmUnkHCbt0X4LaAKrC6brLe/zEiHaAzjHvQUDz
 aLE91sW79pGbuG59EgmJJx9IuCSvNNb8xN7vqLHKID9o45PH13QmyqLK8pj1vSIifBgQVSG3yqw
 ==
X-Received: by 2002:a05:6820:2d42:b0:65c:f019:ccca with SMTP id
 006d021491bc7-66d0a37cedamr4599197eaf.21.1770578805067; 
 Sun, 08 Feb 2026 11:26:45 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:44 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:24 -0700
Subject: [PATCH v2 15/24] bsd-user: Add do_bsd_uuidgen implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-15-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=OACJcVk0PIJj32f3OKrkTVqXKRk+FbnJmNhphhCILB0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhCyKf3E3Kngh0YlzLS2VtMMEnWZK84UeBB
 uExjcxAjVeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 AAnWEADtKnQAscZrKxQAV/GJ5Yx0md6SoDVauOYXYKC5FP5tjHUtM0sMD9KqZCIE67FZ+6DXFiU
 DaRBgtyhJPq8KX+Ur1u+sP35iygw7u4HnLYxAbT+50TaMeXPPVMEfRLuPKG2RKuZsbnTOs4PA1s
 ep7sbX50Llg4j0ehmYHbAm8Wg7VHjLHOgXAUQwEnOsNqIJimjzLMqiKPHJtLgqYIQHn5cV9RfpN
 n3gKjEbXkPjufqpqSghXYrEqOu3/Gw9f6y15Vr/JbgsDFw5wEEKow/uot5XKnUyfpYXDd2MGGKL
 P5c3X9FXXjCeaf2w/tbj4hzdQpyf3LmLQKn0iIGiuzg1abTi9qES9iwLg7ndj++gPUVJj8Hj44Y
 aH6MQsFav/yhEoG1KxJCuSaxxvPNoVqsZdJXq+hx/QMmNAiXR6CZNWFhwSj0Z/tLZrwLiDQd4fZ
 plmmQ8V7gN1MTOneZGjTZYse8f1M9kJVno0CQMAXKu+iJ9epF3Z3pWrBtP2p3raY0e4tSDdV4GS
 Vi6btzmGBECsl6Pg53+0TBfzoR1jDTcNKb9NCnM2Vd8y9jMJ6sK2HbZGZaExXpF8ryS8mvFioQO
 ZR13kL6QH0R4qHtuxlGZMzWsWe+Ph0FxBjGSPCzJLngUn0xS3yKinvl3YXVYK3IfQQtDIo/Rd6v
 QNPwn8Spw3q9MJw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc30.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index d81b4fbaef..ad248c3b79 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -43,6 +43,35 @@ static inline abi_long do_bsd_reboot(abi_long how)
     return -TARGET_ENOSYS;
 }
 
+/* uuidgen(2) */
+static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count)
+{
+    int i;
+    abi_long ret;
+    g_autofree struct uuid *host_uuid;
+
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
+            goto out;
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


