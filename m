Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74269E937EB
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIH-0006Xc-As; Sun, 12 Apr 2026 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxI1-0006Rx-6K
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:04 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHz-0004Xn-1Z
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:00 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67c250805ccso1183309eaf.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009834; x=1776614634;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIEcMXAa7oyuBcQ1J23D6kVpY/4XNgxRO50EvsP93+M=;
 b=RK8lJwj73nQsd2tuVFCLxAIEGBG8Eogg/wD/pjIbgbuxl6TfN46GNXdbtmXvx5y8m5
 lxg5bSej+mituFeDIL5KtKRizdC4VQL79hkrOIBi37fCZ8bV4PVB33PV3ZV7Ve5OFDRc
 pKcwpxgReAJDv5U8+tM5t/j3Pk+ITaxeVz4/Z1b6YyOABXLr94CEBVI3iAUG8cYo3cSX
 tuXY1GLArp01jep436Bnx9GT3pwYeLiU7yBEcon/dl6FNgqWUMhjzsWxIlDvwltQQXkY
 coVZo+Vv5v2FZ5YP0rkyck4ylb2iUxxjXQz6vf0sEe7IbZpp+xi9xNLvFO6GEjvWbe+r
 pvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009834; x=1776614634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BIEcMXAa7oyuBcQ1J23D6kVpY/4XNgxRO50EvsP93+M=;
 b=lWfXTpDj/q6Kz1OZxgBniQwP/Ox59oedScTfPCcwQ77/YOwa1L3DTZtc17ZL0/y0vq
 Pyf196iCHIire7+XyoegoBDv4gd7SxUx5YGPrfm1R4fqfQejnhFbTV1zQgFW8N5y9pdG
 QN843b7utt81KGZJMF2f55UBkn7RE7idsgi0/0/KLF0pu0F+JOx1UhI2lyPGQGSAXxMP
 UZUnxI9zCnbCFOvzv3UlLuE+zLdbE4BJ2Kt/mecbnTYvN6QjwxKYMXru2/Pt03LJWNfJ
 QaoJZEvx7ZM8bSe7xVa/XMqeiKSmb0w/vjdA7pHSEBvKlELPuu3FxRF678U8Trl+DFP/
 i70w==
X-Gm-Message-State: AOJu0YxzEaISqcmR08bKIQUVFWkaOHlGymRAmDGX5CvF1Stiidh2ye46
 ahHIgrLzqA/LTp6yeJF1H0fwmaguCCZRbglcxxfYethPIYk4D1aTN027uGUFZw/c0lO06qpzNke
 M41SrkyY=
X-Gm-Gg: AeBDiesAhuxz8tpHV+2kyH8plgfkPkUJcHZJrGfw3ovzjx6nZcdploYcN99xk9/t4dF
 wuhYg350gWRaDChaOsIPlo43hzTbmQ0wYqxfiHSUS5/9JNIeCVFVnX33phomCcnQkQucEtaWK4O
 sv58wB7a8oWiPNiUo1sRMfqvG66/O1Htcu05hv/Y6NKFMZLrZ5Kuw98v+SAYxNRc3fV6TRMqCtl
 xnpJhUsSMQSvo/hvV/5rWxvscwXVJ2404HaSvBisOvl0oUiHWqZLBFbuAaIkuucC8Xe6vEH0xZE
 7R5i6FEpKaZRIUACm8FvvaIjk8/1R7f3YPNUXsTeZwMBszvcmgf4zybShZbp0JVVMr2uYjauadG
 WpqSGa0960KjtoQ5UVopbGITQwmA6T8khfOb9uQzQjTv8sP23nkDv3fWlKNsPoSFvNltC+LMPU6
 GUSgdxm9my5Q==
X-Received: by 2002:a05:6820:2e83:b0:67f:c06c:a5f0 with SMTP id
 006d021491bc7-68be7de42cdmr3645688eaf.35.1776009834336; 
 Sun, 12 Apr 2026 09:03:54 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:39 -0600
Subject: [PATCH 16/17] bsd-user: Add do_bsd_ioctl main function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-16-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3864; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ocknaMBKcFWF+U0DHJKsIdFpogAJcD7isOX+33qY5G8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IhHUkBoyDFzbO2lOco3V8FQv16713r/rc7J
 H9WPM0sOwqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIQAKCRBsHNEofbAR
 ABygD/9wMlcksw+1NQMBkZiGmx49UoshOnoxqLoVi8U1UHrg6hX7sZyqVsdR0KusixoVCyJ1U/Z
 7YSb8Pben0xF8spqMQLpa6FqlWeWEyc6++zJffO7Tji0P4qGbPHmdsrVil6BfltdCQvAa2J2jyF
 x2O7uX2iHcxqEvFQJ75sn3pu+9PlBYiJ/StGbRem7P9AOkNGaES460T/qNzHQCynb9xgREDwH8b
 EShVk2HgQ4H4kor4P2KN5oVWGz+ZkRHeP77hX98S/oyXliIXYrT0B4FZv9ZC6XEv3cU68YrNX1u
 qHgRSux86Dn6/ThV3OwoCqQKzZhFcPl9y8B+WcvEqUVMaIAG+FUy3mYMFSo4OQhatQq7caxzYiq
 3UpXPHiPUVWfFgw1m42Qk9FbD1BcEP5Q40lN0nqAfopxD/JWKN4dEkBSdrzVT6JT8w0SQrsf2uv
 kSM6aswJGPYQs4u2mUkYwdTIbIVamf0Q+dMUPgEbDgVTzqV2AbuShpbPXf4io7vFuP1L3jgvxRI
 on/UPqUAAst16HL1NKy8E0vBAW5wPjuleUVuZxCxNC31mapUgRYvMz/Znn7ajyHeeI5zHl/8//p
 BRubmXGp0h6sPXCfmS76bfXTAiiNhzBhn8WEbb8knVIYKMTJbPU8mMACb3AgpqeRIzaWyGoLAfK
 HZzqJWiXSKOjbeg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc33.google.com
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


