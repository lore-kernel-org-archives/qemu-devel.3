Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54CCCD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vr-0000kO-7L; Mon, 18 May 2026 17:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vm-0000Xu-5p
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:30 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vk-0000ff-Hd
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:29 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso2129121a34.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139707; x=1779744507;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sSzVC6h9YW49+ZfM5l/6+Z7F9FLLQN1G4shYKdPjNRs=;
 b=UmWmteDHRzTiIMdZGishd7CkL/t6qlbIWeyOrOH5z2hQOJxi/ff9SBTcADqQsWdnrF
 Citl8o20cD3ay9EfqN4NH0aw8u0URaGzt+Xu5jgDylIoF6Y17ActLQ3d8ym2wUS8PuSu
 V2ZiHFyMvpZ1t9SVzV4TiPZmdxxJvlDk/lOPgv1wzbkNcV0hNNKAEaeoq37FBbUhnH7d
 qx3R9U+QxilTr21nEp9J7lmWFQpMk1ZY93gkVpAR+BMbmIq9ztEIuNS4Ow0FJEIT9A7l
 JUPy+KNjWUimN2vZGnmQrdTF1yFAAHOPG255jH9uvpdY3/iAcQSQIyIdT54OGZvnKdq8
 t2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139707; x=1779744507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sSzVC6h9YW49+ZfM5l/6+Z7F9FLLQN1G4shYKdPjNRs=;
 b=Tjy8s42/rQ7fyCu73a1wb78bgDd/qNxAEVhnX/gDl6GMEO2MRi2ZzIzcuSl+XV/jSW
 RFlnk88SbPDzLSI9J2nERJ29bqOEMID+KTpS9a5l67OncPgsCbdtjXtA+gQ0f12nuiwy
 IRNhi8PDORSnmNd7Nms+lClVZ8lHGVshJ7AYuz354dyR3rqkRvQ0IWvuPsy98EiOTY/G
 mK34ibsXx2Fs6EQwnsgsj+a8jPEiEczgDtRHLmtVoE8945PMeAnkfepxm1mjRaIytLBa
 A3chT/6492qsdnjdedsfd7+HDwEp562tYXkB/sEtFZ30nyWD6x8jVNHZv/sg91I2hJs0
 Y9sQ==
X-Gm-Message-State: AOJu0YxpDFSgiVyDfXguE9armOB66alrvhF9ecrDwoiPd2vPeF1JHnEy
 uxd5TxLFW/vdDAVtQRUopuYmr6NbeDYeGXx35TMy+5QAmZdxstcZzpyLwWhgsKp3+1A=
X-Gm-Gg: Acq92OHBJo8rC6k4s/odPJqZEGruq3ToCxSmgral8tC0ItwOT/RLHtqDNj3M5qldjZK
 o/UZ0ObM+5WoZ4TzZ5OQwJIXKJ0jLcAO/gTQIXGcaZRbpHuRYcHb9fPbdtI3/eXY/JfkE81/G6O
 CMymruGfiT2YuMVTefVcjWdXwueTLt90GRvjrz8IoX9Syy/T5vrALFSbLUrJcNwg7exCYPwC1Do
 trhYLe0g3XCtb8IJ8v4OpI0obH0YT0oH3RAnvKRK2GCn9yEMFe0E0SRriKWuqxhycNcdV/jztyF
 QEJvtV8dIQUdUTdGvs347e82/yHtrYutONQt3isXLCvVPAynU0gtgEQWaEBLOQZDjcfKpWz8mi5
 kWDVhCh8+R2a5TVErPnKw6kaTZH+qbxMHuDIDu/P181I1N5RrhIhNVLKDbuunCPy60zK8/byTIj
 kqDmwRBlPqRjEBZxinVcng
X-Received: by 2002:a05:6830:4387:b0:7dc:db3c:1d82 with SMTP id
 46e09a7af769-7e4ea17e2dbmr13699259a34.10.1779139706828; 
 Mon, 18 May 2026 14:28:26 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:52 -0600
Subject: [PATCH v2 34/37] bsd-user: Add extended attribute and ACL system
 call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-34-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5002; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=hz3iLr6GJQnPMw6JXtduOv2rNv9Bqx6Ov86pywyJ/KM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RJbbs6F8VFZyi4Y2XK+weRMj0zBYN5ZriiA
 XMaZ+cdMg2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESQAKCRBsHNEofbAR
 AB55D/9elkp97qRuCGzw3VcJFZS9mpB2KO4H//7ypoBznkmCTbi0xzjrlUlvA6IFQFk/X9LAOIq
 XokuK7nDt7MJRhtK2VOQfEi8HWV2GHQBdve5Zhtn5d5fvO7YQHCualMxMTRrLO9kw1pLSqzOJHS
 e3S2DNn3QWvDYjPXLyYpQOHkpMQdKhkA/rG7UbGSW20LTLXgRnlwzJIZjQMD+ksoi2cR7QVMtlR
 miig4tAOVTUaOF+cHr+lB38BXPsfvfPivI3I4wD/IDbvgRnDuBjhOlpTw3wCtSogbLO4tWRNS3u
 hM0EhEuid5CnTFtCm+68oCeLFbjeDT2TU1nrtBWyxRCt5XtZ7AGaPms8zlOWEHy8dhKnnk2Sz3q
 lulXldagDzIFrPSLAtlKazbJ0bzKHvE+25ZqC3c1Z7B48A4cdfS6YP5LoSwD4+xMyZhXZlEOCNM
 3jeVclHYEYyrNwTjwvenZeB9z4cSGHbvkUElRPNFf3OGFx8LLpBRqYnrOgZ+as5rzj/Nwe9uUqC
 /hsQQpGSa4Xxnnz7CvLfuVooeAtX1nKFb/L9GYzLUfr8XgT+dMDtZGItxhVO+6ggdp6pVCS/rbM
 /x2xnWN/ocT60EtS6jMhkqdH94NGXx5ZfNV+XzS7W0uJhezkI6WO6xtHTjyi7a8eVyNwek1vTrF
 MVAns2hVZCu5btg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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


