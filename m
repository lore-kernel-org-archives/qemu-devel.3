Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0752CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxb-0002KH-1l; Fri, 15 May 2026 17:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxY-0002D1-NT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:40 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxW-00033U-Mb
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:40 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbe437b072so150477a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880037; x=1779484837;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sSzVC6h9YW49+ZfM5l/6+Z7F9FLLQN1G4shYKdPjNRs=;
 b=OxkR31njgr6xxgLBy8uYSNl7lr+J/UWYY+2DTv9PX/Uo0vAYxkILPtYkOaShHP7o7+
 GJu+hkizaL6Eb/lbmjUzCVXgk8tEXqIIHLU+wfhpYPIWWFNWlUyfRvs9i0xA9ip3HTtO
 9YxEXt0loHUvbPg/t0GpZstk2z2CJ9S+0GQj6x+d9HsYooztThV3tyBQVJdcAEdzArRD
 EjW/jIRqczBJ2Wf3q0lsgYfkXriy2QWfWIpfLwUoUgDR4vkvM3Lzbv+RuEjREl1C8BjH
 2EP5k7cUO9LxagMEjxSpGMzFCjKuqkSaE4bTPzjy6ukK+J/8NPl8l67CAkJSKyLsi/Ir
 3JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880037; x=1779484837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sSzVC6h9YW49+ZfM5l/6+Z7F9FLLQN1G4shYKdPjNRs=;
 b=DZhQnUKYztRopl8Oh6CCW3wdXuYk7YYFemm9Oe9MyFHTClgfxY6hKh+esv649LZ0Lm
 fWZutfv3L/uM6CrQQ3rhcyJ1cV0uLlnvoTeM0rGozQf+MX+CFkPOxMeQZHVusc0c1IbT
 d+FQNzuj8L8fNy1hHwziER7WThQPV/AtScEt1gecjtIo/eWUUOIiagQ60fSP5h5GCNLa
 4fSYMEA5+6rZuYGLATkDLc8N7ntZPMQheLoXHDhCru9+TeFCEauSDHDd+fkSz1jEiJYQ
 idzCvJj7zN6LTVfYy7hvPIEQYiAtYwa0TZ/KZX0amtLKWiwzswhoSW+06hqeFiNhZhH5
 aL6A==
X-Gm-Message-State: AOJu0Yw9P6+Imd4o7VV9XrnHF+qgHcVIp6XWvp11ob0kMOe4bdDh0zyb
 GhDsTZs9c8eSyMAdyB5U64ylj0YvjJWHFb3CmCkl7hWAfXd13R/z/hNyS9cucMqqY3+G8shADVJ
 4TIaxtDw=
X-Gm-Gg: Acq92OFWB6+Y5DaOYd3cA/HRo4w3sBnmzw+9gZtqF8ZhfoiyWYUwmIJPyLGgsGmufqs
 xSWjJjqNSol0yozX3LaTTei9Dj9pRcNUuviFxWRBDtHszL3NoFSOHGX9fwF5LaxXANCfjh/zn2b
 GIz9mfYD446kz4n+EbRGrlhMYPwSrTcBIK0xCM8clUxdQ6sWjC8cnRHxc2zrJUMrD9Gdp7ix2aM
 C320ZzUzA7JPg3iUU/vxrYOvCzzNTenpJHZyzaJ1hVRNQM4EZiMideGGczrGICHGNhkK+YbMl4f
 pNg6J8pGJMzQ2HLDm0fD+QcJiffTEdY6DIlLDkvkVJBcm0bfGZEETBjrR3ThAup/LThheBFUR36
 ePiDqdEarA18jpUPMgN1hiI2y4yc/mJLdlYOsIneEAAxebtjiyFnQDgy/HyJIo38XU5QFc9y+/6
 /PjFoS40PnGq6A4f0LKV1D
X-Received: by 2002:a05:6830:6187:b0:7d7:e6cb:836f with SMTP id
 46e09a7af769-7e4f2bad231mr3607094a34.19.1778880037546; 
 Fri, 15 May 2026 14:20:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:33 -0600
Subject: [PATCH 34/66] bsd-user: Add extended attribute and ACL system call
 dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-34-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5002; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=hz3iLr6GJQnPMw6JXtduOv2rNv9Bqx6Ov86pywyJ/KM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43lGRR2fkxZdmMvitUnb1MOLegFRjMHCDP/f
 nM8jWVHKyaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5QAKCRBsHNEofbAR
 AO4KD/9Wkh1SzGrlfrMVV/NJAXuOHCxG69h1JoqD9o6FgYMboHQMMMy9IhRPqVxajGTaj40yU0/
 kBYoYNUwWdSxRoPGxyb512n7pSpXPvguteUNNEV1uZpvng2DCWUpzk3/xeTrpSM9F5l8cB1U5Fo
 JOR0V3bslXjtateuH3RX9kAD/tqkL2aHgd5tp0jelV+EqshKlaAhWP7MyBcr8ezPGRDzYzw0T/x
 KdMTQYc+rZVsCU8ZwYvNWi0tLzuj9Pm2QbyhdPq7jeNR4zvS/KGDIxOFdJ4WIJIIElJ8EdFOjCr
 XmIR6yn7NX3vvqyE7YrjkSGRSokeIp0YAtSU5ruJI/oJQX/BnZ0VONtbkSOccEPp6y2aCLdgOiL
 qsZnkB02PMxZyuAyo2vMBITIKA9BwJlxDc30RCytPhA2G2TVpRebgNYUOCpMG5DOvSGxVotPbN5
 PHW8cTeHZjo+MK/8hURqrFK4i5eA/1H6AugoobtlBka6rOvqyzWeeJ0dhjboNvjVAS4Ez09v56t
 OMjySmWR8NnascnX8ARq76X9cCDdo8DGXPAap5Fs9AE64BduD3M3zLhZaPI5X+1XLkA/8IcgPN1
 04bT5IUxj0iPQS1YQyXe8znjSbYwF3IKJatb4EoEt3VV3wqIHcGz2dtiUQlZ8yTbq+wImE5R/2E
 FOuBJz+AVFfw3Gw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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
index f385034a53..7825e042b0 100644
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
+        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_get_file: /* extattr_get_file(2) */
+        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg4);
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
+        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_extattr_set_link: /* extattr_set_link(2) */
+        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg4);
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
+        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3,  arg4);
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
+        ret =  do_freebsd__acl_get_fd(arg1, arg2, arg3);
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
+    case TARGET_FREEBSD_NR___acl_set_fd: /* __acl_get_fd() */
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


