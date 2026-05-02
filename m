Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A4BCD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsU-0007uB-Th; Sat, 02 May 2026 13:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsQ-0007tN-LJ
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:38 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsO-0007E6-Nv
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:38 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4be94eeacso3210386a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741895; x=1778346695;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2QBmwjvaav499uBiNQkZ4uLoZRRkEdivASGuKNAftSo=;
 b=p9e66/wzF1MZGMTVqMlEQ/l83fp4lnaiTsOCZuk4Vpwz3XBdDo0TA/fG2+PO4XOtHq
 TFS1nDMqla2ysJdmaRtBaNdMpG/6SVECJAxd3QJ5vHvyKmtW4imbvMoquh0C7eohTW1d
 tExpkpGAIExRN6DhXtO4Q0wCw0X+JmEKzzdXKq4Un4fjToWk6AhTXNmw5mG951VWTWgY
 ArYGvrexJJbLTmFWdMUOjKO1k4OYg8A1RzR8/rO8LRLYEdLGBElbTmVc70PQkOUXAY9p
 FlwbyMpLUtqid3BY0errwPPx/wEBcX6C0SsGruIjtRWrlQUBpgGIED6zAG0FmZwMDFsR
 BOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741895; x=1778346695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2QBmwjvaav499uBiNQkZ4uLoZRRkEdivASGuKNAftSo=;
 b=hSHu5HzW3XknlERQlrnqX/CyGAHLAxPW+VepETK7AxMO/AuPcHCOKlYaYYpyvKkk8k
 mXmPtuKp3nuOFj2NQiRA+jXW4oOAQmwDQ8nZcc/9c5XlbVmsE0AOl9d6SM4FFSX0BtOk
 Uo+poEP8CIL06gA2s5OhqxhUU1co4IKPv4M6WOGYA5UNjZnL2N1aI0r1sLgg5Kphro/m
 dGgS7VTwxHnY4uOCh5w8JsDI6snZ27nYfjeKTOAD6MddEhTJPz2bnJ+6W/lx2mNnd41C
 VTah6hbdyVt9Gc6lgPzhOdF7H5erpKlcDRx8nat48WqHauQPTj8fv1sHRl4ljo+gcica
 u2wA==
X-Gm-Message-State: AOJu0YyZByhmWamGZZEg2MDK4v85lB/j1IUyb+xhBhLbswic6N9ZPcm8
 VmanQB5bvBH87xJ6n2O7EKF8LrdCw/h8mCkua2NJcPymOlkoqF/6vRwZrdIO0Xv7kF1qndmX8/y
 /JYP3uSY=
X-Gm-Gg: AeBDietByatSAhlz11zPp33sOS446QUgmATUjpR3rm2wKpKOLvHnOUFysIAZB5LFlDC
 he/+/pJ32Uk/0tjU7YPOJYfxEKe24jB7F7oX9oZMcYaA9MEd8nxHel9zjYuG+15h4zoQM1YTKkh
 UQgrWAuc3tWXWvnhppTZ6Gzs4FU33apfmFQpLHqLN6DyiG+aVRhXjCQ0gz4J3IzDRnWpPkmN+X9
 KTleDvR5bxPGlXnMOFB38Jm8hRWUY5SjC1cApDKbNgVeg2WtvgRALBPp3j8XL2ScTjuls2jBlra
 eUkib/LnLA+NsakMUt7vc+bWU2ngIdmyyPwvP/r2S4a2HOQPUZDVSW9x6yFOZMgaFiWH9gt378z
 nFwiuo49fLNRiq0yf7Jr7BPHj1N5Dm6e5y7z0+7LGm7bXGEDIi/3eEtDV+5XFL3YySxs/qG79ZF
 TQBIIxqtBAKMVVDHKV6Sw6
X-Received: by 2002:a05:6830:81eb:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7dee13c17c5mr2396554a34.17.1777741895355; 
 Sat, 02 May 2026 10:11:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:38 -0600
Subject: [PATCH v3 17/19] bsd-user: Add do_bsd_ioctl main function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-17-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xguMmeeOWqzWWh1TUfAOdmnx9WUC5A613/gvNUKKM1I=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/RXHs2r0ZF3gUUKBSzAtxA32QJZJ4oizlcu
 GMWKPkcfceJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYv0QAKCRBsHNEofbAR
 AAuvD/0fmT1d/SKwYpHsG7ONoPBz8riszqyJDD/9R+7Vunj9HAxqqwNnlmv+KTuIX6s5eM4eDBn
 yFixD/OH+Qr5HltHUAIRBPVV6PPSpqnyWrf49A3ShnCRoey+Zgica6vS9NxNZ9Fh6SDqWKXREN3
 GmO0+Q9h4Q3Qi7ChIiPl9Nn4mA9FcpzeKxuAUqyaBgkRl/NuUKptDSxhcLPd11nxlqofZl9v8D8
 18KTs4SVrOcX0bHroDLxHaj5UaVfBB722r+drBzFHzI4CUmiW6sQXwTVhI4Mtv3QevShnfzfzJ/
 AqmnR4XVk2EYVB6tUuxgzdMR9zDEEmn+UXmtPWsYiVCM4MXonbhsslonv28jqKBgPzuZAjGbyGt
 IL/PRZ67mSMicgMzbS+GcMQyxAxkxB8+HKHl8ldGL0aWNva/pIVE+Pc29uaLzqwegIruGYSde9D
 HgQrLKINfNPh8Lxwxelkh8carziGSkghLD3wb/S/eB5HB4OMOWQL0p37ADsrTQMBGoIbnNkXZqe
 XT3k0VT/vo1UxMiYqz5iduOgh06xJmA3ajXUo69k3NUpRfCWKwoXQPhOF7NgFp4V3DQzg9fARwJ
 pzpMPCzeZCH+wAc4eAMi+5X95O6/dhk2YgJmkinu175jDwyGr1wnA7tfR5+4RnNEZnuNuIP32Zq
 QO8hkvAhIH3HS3Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x330.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 8d25d84dbe..3940a69260 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -292,3 +292,103 @@ static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
 
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


