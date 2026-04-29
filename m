Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1999DFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6CG-0005C3-Il; Wed, 29 Apr 2026 10:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C9-0004qM-9j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:21 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C4-0004fz-8z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:17 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dea1272943so943393a34.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474035; x=1778078835;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIEcMXAa7oyuBcQ1J23D6kVpY/4XNgxRO50EvsP93+M=;
 b=l0OD4eOGXTsvfRqxJ9Y0Axz7LOJ34L+Jf4Xu1e51qQn9Z6DoMdY6XPjltTkqfPX5K5
 SpjfPW+G5FhKrcm7DSkXLvea/mvD8kc2Z7wYy5BIxuFHwlyaNDWzLWlMm/JVHxG5VLZp
 68WSYmbUWDGf5E9TqzT4xdnOpMyK1fRia3/y1HnB9iaOhC9Nx+7OhtwLpWEoTI20UAKN
 NzgfWbp3KS8zDWQtK5g9Cpsy5cSLjU4eKcCdPTFEsP+6uG0tLvAVGqycw0T6lW/IDrQR
 gJpHXnAVAuf64c2Sg61dWVUueSTABGVP9EbhU6X+o4ltP9gIdngJUNc1HzHPpFsRZ6tw
 acbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474035; x=1778078835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BIEcMXAa7oyuBcQ1J23D6kVpY/4XNgxRO50EvsP93+M=;
 b=URVgyCcd3kYFOeWAAhzY9fua/kpStosNn+8q0FiemuxPe3FClCBZQhB2OEoddv932N
 bykkBNJXmXuwJLz7h0HS1c77RDCyTW30WgNQ2Do5E3UuC5xUc7/ZsOZw9/NrJAw2JyEa
 AIeOJTtaf1kndVbG1QWtfXyI7TinwIlOLzRmQjEqe+CawK+CevNfiovN2H7bfXY/P8hl
 uH1PBiwgnKT1ZakELJAXj0hyRvLQxFwldpz9W+O7pQ0nxbWZYnxfKQ5f2QIixF3HpEPT
 hhkZpX8KroViDPbXK9g6ez0jetQnCUSAVNLzOvhtBsY5uQX9dBlyQTtyJjaagsUsDjrF
 7oRg==
X-Gm-Message-State: AOJu0YwKvGKO67YZ4iIKfaQuhWyT/kXO11Ql2sbHn0tl+6bLmDJ1izoG
 ctLiZso00GLrqjV6CyTGC30deiOywNQvwa6WmVpp35/02BOa69o+fk6qdQt/BlMvdRw=
X-Gm-Gg: AeBDieuhQblR58j9tWefynWbiKVSrw0bMfLbrU5vV1Y5xa6hvt1iphNXrobm/vvE7LJ
 ozekIkmUMi7urEomrxK11Q6sw6My9CmxdwW+HsjDqeCPkc5pmOnaQTedkkierZUoyREmQOflUyb
 BM3hm0WLO1Pojnfz8XqznHhGYnH7a83eYLufVJ/8j01v6lm65o9FwpHkzvVWiUPfrOb9RArEmZk
 cBuYKWlvpmeUqFXtA8ODyVRNLXBoSX8uq2LbEgvmR2pjD6Yh+FKjlgVuQU/4ZWg2Xl9J0U0zytO
 pNFvQ1FjMJ2nWPM2qGg6cj1kM7vLfOVSGG+qjLN0Vrgn5uc7sT2sE/mA5pqTn8Hhd0ZVr0fuZ+d
 UQDWSl9dYYUS+ieltn6n9884xHQqX6IdT2tD2+Jd82ZZld4lCFdA7tmQuxydJ8f/6i4QGa7iLRw
 OAldNt+33Lwn2BIH7sVpRH
X-Received: by 2002:a4a:e904:0:b0:695:818c:e552 with SMTP id
 006d021491bc7-6965cbeee7fmr4135050eaf.55.1777474035001; 
 Wed, 29 Apr 2026 07:47:15 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:14 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:22 -0600
Subject: [PATCH v2 16/17] bsd-user: Add do_bsd_ioctl main function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-16-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3864; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ocknaMBKcFWF+U0DHJKsIdFpogAJcD7isOX+33qY5G8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl+T5MS7QGyCrTdd/e8EOU0/EhE9fdp8NC8q
 EaFfljwq36JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfgAKCRBsHNEofbAR
 AHuFD/9Ba1XITWHq0F2MbIDryw7QpfwERJZE5CZeEX60wtNXxhL4wmuBNTLSFgf5fza+PKlJtEK
 TWJ3tD40N1nCOElkrDLfgFENYWVnm2HvN8i3+EvYAnqvLpdcH9rKrFLe5iejFm8nKZH7vMD83sh
 dc1pvoBfVB6oAWGIpMA37IDE1ZqgStRqVgVeCW6z0s/iDuUYmr2X5SqBTMnLfzLKSbO+opkiZRN
 gfvoyVrk7rgrcj6yBGk7SW7NCeMZAYyIi7n2XM+sHVkYsNb/lswRNoc4w+bE7H/zOYJKAUQAIao
 x8octjvT8qu/+CX1PeDErtgBx3jwKYWylhHPe9hKdpft/eIqyxf/Do/mSE7e03Sydeun/LArYNb
 h++cXQ5URSlSbb3ucybzKfw8kl3pwUY6bqpiB0n42hnqH3JH9OmQMTYOafBd+FHO2IFbNL/DxIq
 XICBSQ1PJYxuH56vMXomlGx8SM2g2OejGeY6khXOkmt693aXk8czRDUJr7mj1oGRE2lpbSnFNL8
 Ux+SqaAu2R5p2gT8bdAfhR3Nqi4298kqxFLPT9WtkdpWpiCu0Q7iFNkTP0R4AOgr+OEXWvfUGFq
 5jfBJrRan0TwUFCBxjm9w+Pf+HjcSg0dkBzMJhWtMttW0+2idDEWTVNItl4a9rYzjbcH8I9eGdT
 +ilq0acqEMFMQtg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Add main ioctl emulation dispatcher that handles table-driven
ioctl translation with thunk-based structure conversion. Supports
TYPE_NULL, TYPE_INT, and TYPE_PTR argument types with read, write,
and read-write access modes.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index aa0153bbaa..ae3ac7ae24 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -294,3 +294,103 @@ static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
 
     return ret;
 }
+
+abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg)
+{
+    const IOCTLEntry *ie;
+    const argtype *arg_type;
+    abi_long ret;
+    uint8_t buf_temp[MAX_STRUCT_SIZE];
+    int target_size;
+    void *argptr;
+
+    ie = ioctl_entries;
+    for (;;) {
+        if (ie->target_cmd == 0) {
+            gemu_log("QEMU unsupported ioctl: ");
+            log_unsupported_ioctl(cmd);
+            return -TARGET_ENOSYS;
+        }
+        if (ie->target_cmd == cmd) {
+            break;
+        }
+        ie++;
+    }
+    arg_type = ie->arg_type;
+#if defined(DEBUG)
+    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
+#endif
+    if (ie->do_ioctl) {
+        return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
+    }
+
+    switch (arg_type[0]) {
+    case TYPE_NULL:
+        /* no argument */
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd));
+        break;
+
+    case TYPE_PTRVOID:
+    case TYPE_INT:
+        /* int argument */
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
+        break;
+
+    case TYPE_PTR:
+        arg_type++;
+        target_size = thunk_type_size(arg_type, 0);
+        switch (ie->access) {
+        case IOC_R:
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg,
+                    target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type,
+                    THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+
+        case IOC_W:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            break;
+
+        case IOC_RW:
+            /* fallthrough */
+        default:
+            argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, arg, 0);
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
+                unlock_user(argptr, arg, target_size);
+            }
+            break;
+        }
+        break;
+
+    default:
+        gemu_log("QEMU unknown ioctl: type=%d ", arg_type[0]);
+        log_unsupported_ioctl(cmd);
+        ret = -TARGET_ENOSYS;
+        break;
+    }
+    return ret;
+}

-- 
2.52.0


