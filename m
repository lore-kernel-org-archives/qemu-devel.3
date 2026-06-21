Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F97DCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hd-0003Bj-QG; Sun, 21 Jun 2026 00:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9ha-0003AM-Ko
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:35 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hZ-0005P2-2S
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:34 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69dead44101so2845179eaf.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015752; x=1782620552;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=07NCnQNKcY2tu2P/671mwrwbXA8HIGbGh2vpGFWag8s=;
 b=N0xuUT8TSp5ygQqtaAKWKPBsoizQCZngOYBet+nT3Wg764g6sGZQP/giOrj9k7Nr+b
 R+m9b5UEHoxIqxUFedE9tAL+qRx5+nyyjxpdp9YMt2ofKoQNNsPWUihmHyDsJtuz+B58
 OlusCb5CTV5YWQnoAT+coq/VCW7Q/fR5QoQNAmCHtysbt/fMKwjj3KLbCKil/EWnbJr/
 Rne/8+JcswbKZ9rep2c0Kccyd1RRDrFqDCYhNqnGzI9i0RrKvbhG6duzfE56oKRVn0Ic
 glyqz6QtfBSv1Rtd+2Voa56CbyRAPxIRIIkJrXAK6WL0FNs9VJkQVXaGEMeLYkPcOaB3
 6DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015752; x=1782620552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=07NCnQNKcY2tu2P/671mwrwbXA8HIGbGh2vpGFWag8s=;
 b=n1nkVSZ1rfcLmCDEzZ/icH4YtqQyo6EPxdkzXEeBtiaMnLJbIClMOc2xhvCplcbWuc
 E0PsnWSn4BNpFCtY3ESsJLu4OYdmAsSf8QTho5vGC9p5al7hEr2LBhm2VHrDY1e3zLey
 HBYQrxLHZrX8HbsXDbJ0dOa9Mj3fR1eu0lVWQOTHp0eMf7u6NEsdX97tyXn7H4n55XQm
 MqXGMQGVdcHfP9ImgZ2SNe32e91hcqWgWhi/UBYoCi4X+/KzS6VeUUNtSxYiDOlN0Nkx
 7Fc39uV/LJKSV58fc3DiUSlDjwDFZgE18d6Nunj/aTCcaQrH50jKyk8LDSazoMdSa1au
 kXaQ==
X-Gm-Message-State: AOJu0YxjYYG8vi4JSKwDyP3LRF8hu9Ndd8ylTABfaCBKO1E861ZFvenb
 eEjsfjDGAaJQugJ7ZHlp0zo+J0kLzl5r5c4AeHFGrgfFIDHj/X7w36v9BS8XJ4r2l6uZ0sgzPS5
 x3JDev7TOEg==
X-Gm-Gg: AfdE7clBCsE7A71aFAdpSN85ncCk1ObKvUgntzpOtzhmBerUjFS8TIh5lW10Lm72jJ6
 fVKci+3sgwJSO6vWqB2/zul4JyMOc1khlYchdehvIofJOHsNnnIynJgbLtIxg+8gmURwIQkwtA4
 daO5lJHFdNphJumfL6HsboS/gw3aHq7DEdGPQ/0WWJfKqUR+a176JxhdsLb/C/+P60R24j5qxy/
 /5kiTypZwHW0ntRRpS07mPICcgDwbhwZjQzEFBBGBTwyPxwjW9JwpKDg73RGcbUhuQW9KxzRHBe
 X/K9nx+GFcutdSNVq5dpzMM1zlYHjZVb+janVVhV3YiOEKLtths6qZafhgK/X2PbaXItXEan9If
 KRvG7Q6GonurzrXZFBoKbf9ADTcNPTiYgIHqgvbVTj7tH/WtmFEBbeHhZHRI43yljWJRNSOpvTA
 U=
X-Received: by 2002:a05:6820:1c96:b0:6a0:b429:443d with SMTP id
 006d021491bc7-6a0d886f688mr8123269eaf.12.1782015752027; 
 Sat, 20 Jun 2026 21:22:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:22 -0600
Subject: [PATCH v3 35/40] bsd-user: Add extended attribute and ACL system
 call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-35-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5000; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=MTZxyxDjJ7bYe3mkPtrZ1xyzRZYw3H9BwtM2c07H+30=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aBzf9jeP/qx4lHz4KT0zeAXOsRbJEnFY53k
 HqDAUNVmf+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgQAKCRBsHNEofbAR
 ADIFEAC3L/zMTIP4BGaR3FGiflPeQE3OhDvdotzvA6OclMKcAyuchaa5ui5hzilMcPj3TvH/tJr
 hUX5oz/wg2FvpyNhhEnQflFOFelq/0BUkhb28ECwFgqknb6wHd0Is6w+hTwGNOsb09nLWCFg8P0
 LI258F3JTfHF5Gf49Yxt1v/JKrn77LYLkTw/AtxKxmSVs8tBpLCKanzcogyJA66Dg8DUKA/q2m8
 n0drhumTHBcH1t5xLo1o+oWQxpNdhp1zLKoFuYbf4V9tcvoVtGbDQ9O6O/Ux6cRWQ2CCmSJPoTJ
 hoaVulgMY76JAX7fYJD0BiTbH/sUyeXnhhs+kBX1Wdias9G+/O4rdDwTxFY/HhSALJ5OTIRnKxT
 freCOymcYWrscsXzO0nwoBNZ0If5n7AdssITIf+93Ls3OajEOZx8RzyzEtB7NzuIruXdUCyJ0Pn
 mwEZlX/xjc9feXcpVSwtYf7VVCJiXTweAjLiWDX9c5vppCZEZHkSQ5Lcw4l68GhiFy48gSsQjgF
 uNo6O3ihZoi1CvCZCEEs18p+/BumanMOhesmDeMX5MXQnrkWgA/2BuAMVXn4KANMCuySM2GRgu8
 fXjTnUoZ9DnW+8NWSy+UYFbn5faaZwketFnODJt88pJyva8KfAdn9YGVSi/1wzVw7IvRxxXd2OU
 ziKkzoaUVfroFBQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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

Wire up extended attribute and ACL system calls: extattrctl,
extattr_set/get/delete for file, fd, and link variants,
extattr_list for fd, file, and link, and all __acl_* operations
(aclcheck, delete, get, set for fd, file, and link).

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f385034a53..a14efd3fd4 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1365,6 +1365,109 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_sysarch(env, arg1, arg2);
         break;
 
+        /*
+         * extended attributes and ACL system calls
+         */
+    case TARGET_FREEBSD_NR_extattrctl: /* extattrctl() */
+        ret = do_freebsd_extattrctl(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_file: /* extattr_set_file(2) */
+        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_file: /* extattr_get_file(2) */
+        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_file: /* extattr_delete_file(2) */
+        ret = do_freebsd_extattr_delete_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_fd: /* extattr_set_fd(2) */
+        ret = do_freebsd_extattr_set_fd(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_fd: /* extattr_get_fd(2) */
+        ret = do_freebsd_extattr_get_fd(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_fd: /* extattr_delete_fd(2) */
+        ret = do_freebsd_extattr_delete_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_link: /* extattr_get_link(2) */
+        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_link: /* extattr_set_link(2) */
+        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_delete_link: /* extattr_delete_link(2) */
+        ret = do_freebsd_extattr_delete_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_fd: /* extattr_list_fd(2) */
+        ret = do_freebsd_extattr_list_fd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_file: /* extattr_list_file(2) */
+        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_list_link: /* extattr_list_link(2) */
+        ret = do_freebsd_extattr_list_link(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_fd: /* __acl_aclcheck_fd() */
+        ret = do_freebsd__acl_aclcheck_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_file: /* __acl_aclcheck_file() */
+        ret = do_freebsd__acl_aclcheck_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_aclcheck_link: /* __acl_aclcheck_link() */
+        ret = do_freebsd__acl_aclcheck_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_fd: /* __acl_delete_fd() */
+        ret = do_freebsd__acl_delete_fd(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_file: /* __acl_delete_file() */
+        ret = do_freebsd__acl_delete_file(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_delete_link: /* __acl_delete_link() */
+        ret = do_freebsd__acl_delete_link(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_fd: /* __acl_get_fd() */
+        ret = do_freebsd__acl_get_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_file: /* __acl_get_file() */
+        ret = do_freebsd__acl_get_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_get_link: /* __acl_get_link() */
+        ret = do_freebsd__acl_get_link(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_fd: /* __acl_set_fd() */
+        ret = do_freebsd__acl_set_fd(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_file: /* __acl_set_file() */
+        ret = do_freebsd__acl_set_file(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___acl_set_link: /* __acl_set_link() */
+        ret = do_freebsd__acl_set_link(arg1, arg2, arg3);
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         ret = -TARGET_ENOSYS;

-- 
2.52.0


