Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71772E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVE-0002oa-AT; Thu, 19 Feb 2026 00:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVA-0002ms-A9
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:00 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV8-0001uq-SE
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:00 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso508301a34.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478577; x=1772083377;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZcdFKXh7Mp3mBr6VStUin5m7ydMrhtwhgvYBvlO+dqY=;
 b=WJLCb0zw/qkFIsk5cyQRa3qt4yT1BUVpnenHBItIuy4yobx33xiUel1TmB5msxzJWw
 Rt3m+u+geR6oiE70p2mD5DG7RqZG9WwWyDLBisLm4NslMFfBxJfP/a2AvPdJxZ9nu0tv
 mdjdfMTKhJeHBxVvvL7eo+OJtw+RSDC7sv/0UxwOxuteX6X1w+mAU5ep/wOWup4wgKLx
 yM695Dk1malJNcfSdWUd/DX9mln4qfjUtBrZ2IbgxCRXpVDrobg5AeMH3SErHy0b3J7S
 P7ZgWIf3nE6TryCJuzIp0sseKkFzPgTSdldXJXgDHmGjRoF2QyGRmzeHE3mf0rYdF7b7
 aNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478577; x=1772083377;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZcdFKXh7Mp3mBr6VStUin5m7ydMrhtwhgvYBvlO+dqY=;
 b=Stltv77RV+zpqcnQb9kB4dPM981wZhXHbJBvXBLMN2skx0izi6nX9EMGfRwnCVjV5a
 xEwgN8aMbsxjQRDFPwr2RZyixQsTUs7Vg7ZtZW/TQgNqizXLIHiEByMaU/Hm2gPrAu2j
 kkeXSLpTit5V48GhdOTkxc6zL8aZ4zPZTRiwPJEhZWSstPbvZgR6oO2s2aSRp3GrmWNw
 hTz66wkwKhCAPLnSm/ZlQiLPG5rTQe7EFAU059DIzKSkGC4Ks7yFxPiIXYuh6nzp+QL4
 cf6RbxgxEZXfatS/0jYZCcPznJKo6c2B2MGFuPeXn+bCCgOl0md12WNya9Bw9SjFWhqm
 Z9MA==
X-Gm-Message-State: AOJu0YwRio3HxkAIe2gKs6yJfZK/wR7b4fbGUvcmVhPTlsmq+jhQ4JTU
 D+THfzR9fF6kNFH7n3ttUkVY5zYmsGrZPEo+QaIIcL4xNZDE0VjM7ABybrNkR9eUyog=
X-Gm-Gg: AZuq6aJ05pzDkAey6UXI1fDgRpoEIfQxcGh7/qu/m5z9EEg9Rcf4wvsqIEMX/FUbRaR
 X6DMhF377v03KLdu1PDSd21qwUQfADLh681jy55rzKyx/4ywS+q9B43NC6/wQwwnaSy3vRk6QLN
 /ogT9Nwf/zZ8f8G707Jv9G32NayNykYT6cB4sGNguStY0UjS+/8VyhpEu/i+O2F7HWN8jdkbGXs
 Z4IJrTXrpjGy8X9FZOfYItYx85SmhJTJxQFv07oVLRYNzfnNQjf8SyAcmszmvnuYycdrZsfpWUg
 GhPZraJ1PTdmB/3BC4deqaSlK7tC4196nzXcTwx07Cfhsa+cPnwoVQ+Tb9zGlGehBnJrs66F0Jm
 K7dNMfMUdFA996zNKnPA4rb+KPqIJ1JEWUXTYQd9c3jRUBz7KyY1fTd1Br6qfZIM/ZJLjO05O0Y
 FOnWnpUJKvYQ==
X-Received: by 2002:a4a:ee08:0:b0:662:c017:b5d2 with SMTP id
 006d021491bc7-679aef37038mr976727eaf.71.1771478577242; 
 Wed, 18 Feb 2026 21:22:57 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:56 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:38 -0700
Subject: [PATCH v3 15/24] bsd-user: Add do_bsd_uuidgen implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-15-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=W0h/ckLL8HRG2fEUx/lvkJ4dQKArGZV15k7SeMRigIo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4sF6ocJTMoHLFJcvdmTZeRNRlagLUGK5oLD
 mmDLxJ/zBaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AJDDD/sEa4k5G6M8UVhkeetbAyBaFsFvuMDR4FXn3L+FeCMJhCGZe+VACd2/GgUN5RKIqKusiJx
 cmtSmt1e3QmrxM/4p6G8I0WgMLDOjhF4k8Jkh1xn5jxjfF2KI9KegxmwAeZdHHX0LQa3Vyj/GHm
 /u3R6VQZart1ub7yzOWF7/QJL1D9yKvIHEGHZ2333mW/LXkwlq8cskN6C4HYXO7ZvnmH3F3U8Wg
 KgyENoDAJLpJyv04ihXnzw5DtpAhPmInOJUmfK8XxIECdmuT2RfWAip0VIaqzqrmYDf0Y5Ngvua
 PElWqp+DGFcDmZbmvnfLzvNtSdbzsfWLU6o0gipvX7gqzPKe0wj4ca1cimadqByS6MwaXEeI2o7
 G6TB5b1Q11j9z4sG+DPiG24JfnVUfSHGtUxdTrvMusIKgianK4E/eo8OcquKGeSK4f8BUTzDqxk
 lM8LvoKhFKG5zpuumwkb4vVpavzBeB4Z/PugrpJY4LdJQ2+13IiSa9jfHouGqhgUtk2+za5+oMb
 UbXW/H5/6ilDzaFfmM8kGjKvVMWSlmlEEtSx7rWgrcdcKZK+NGDHCa0D87P8OSQcgGlRgZTEleS
 w6/nqIzEM7ib8V1p/FRjne4FRIGJf+fpq+6035Pr3eUnFFPTPB1DOEFl7lyRXxOon631WnC5WMK
 SgIdYiVj5I0chPw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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


