Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D93D58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunH-00015j-JT; Sun, 01 Mar 2026 23:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunG-00015Y-K5
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:06 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunF-0006sl-1R
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:06 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c85307b2so2882586a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425323; x=1773030123;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaqWwcrZ93FDjWVSE7/eOvpbeQyiYSTVc+iw8x38+d0=;
 b=dzItuMj69YdFtQjKlck64O6dIFTv2UqhgAukUIVF6/912xjh2A0aDZg+k8GiDIjVhP
 iJbfwIQYXV2o58lIw0HMjT1tYxe04IMqimYfMh0ocK+KoV9nuvzE/YHapQKzR2sJc/4n
 4c/J621imu6Syy2hrLD4vcpUfOKZhmn+f0+TjiS0uw+XIsGcclEK4WSwJWzhlv+WDEzw
 LoV3YFK66yLduPJBsrORifTJnMUaJJ2dABMpKrmELzrGKTvOr4ekNyEzhjFXqmzBIXv2
 PcEdXX5321+wDUyyybeqEGmDY4zM98AJxzuetZvfJRLC4sE5G6bQGGDF72AKJUSV7zcG
 WgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425323; x=1773030123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xaqWwcrZ93FDjWVSE7/eOvpbeQyiYSTVc+iw8x38+d0=;
 b=AU6a+voHEOop2MEoluJqZM/2m/ILba6K63ZtIH6k4ytbv5n7UG8aoqQUYwkXBKPFpd
 DSVO4GjokRMcjG1pKDxH7XPowXjGx4m1O8wdgt+HaPUnTYvoVcItgOoc3lXbKhZowQvG
 RUn0zCCkmSEI5hDEJ8gtps3ZGUmjB57Ug9QEFQn+OH9vG1ARPbs8lkpXnQT5j5ryF4Ga
 BzTKZ2yPXvkL29f+bzhyPlUE7mkFcQVJkerOW9WpkMyt5+/KEqTQ41ugQuk2BeISFSBT
 VqKo2FHKP/Wb0/uEa5nxpxKM+YRpOJyE8gl4wYXfQvR3WU22+E3WEDACijats3Fs2RzS
 VVZw==
X-Gm-Message-State: AOJu0Ywfabe5MXpeGqUP87qry0GslNEo+bUbTM2sXZgRbwHgQ58KOPLi
 ALXmVhP26e8dFEgn3JengqSOO/9xqeo0YY5SCsbBRKj1Q9KjCWnZD7uiU6Dgt8VwEAjUMPPtuQ8
 z8Qtx
X-Gm-Gg: ATEYQzyxYZ2jwb0tj9TVzMNxRJHyQINbijv1iOqZVNW8rK4ykZWat8sfBgyd27U+C0i
 dT+LmdKYUKzDMZsfJ2TC/f69FmpGdQvbQRc1SNCa94a5knr98hmlIn93F6wjs6R+2HyG/uqbvnJ
 v9YXB01TtYL5V0gr9OT9PIfPNrnQdfIsWKKuMSON0KrPdDYLcWPGlrIMMCcb3q5Wq+K7P8HgD2R
 +m9M9s7kJezELk0rtetSUqHoQgyyEpTvcfDrUMf9e/iW5ouNpaBVIPikoPN5H59jbEKanNvbegk
 PmempW9PoWOyggFxi32xtTAABGd3LXqHZxFTuimfcaKNzBVNmmvnNQ0lRnX6Y7H5PcoTFMi8CQ5
 7L/Tcik0iIh5lNrJ6FKiQaenY+pHXxpLGtkM3n+tD145XbekeEQ8/mQocs/VVXIwF/bv4sPcG8c
 zvQ/+0wJKU4Usz4m0AkFo0
X-Received: by 2002:a05:6870:1588:b0:40a:5e90:e0c3 with SMTP id
 586e51a60fabf-41627108c01mr5332493fac.55.1772425323568; 
 Sun, 01 Mar 2026 20:22:03 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:03 -0800 (PST)
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
Subject: [PULL 20/27] bsd-user: Add do_bsd___semctl implementation
Date: Sun,  1 Mar 2026 21:21:08 -0700
Message-ID: <20260302042115.83410-21-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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

Add implementation of __semctl(2) syscall for System V semaphore control
operations. Handles command translation, endianness conversion for GETVAL/
SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC_SET.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 114 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index e1e552b58f..2397ca460b 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -99,6 +99,120 @@ static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
     return semop(semid, sops, nsops);
 }
 
+/* __semctl(2) */
+static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
+                                       abi_ptr un_ptr)
+{
+    void *target_un;
+    union semun arg;
+    struct semid_ds dsarg;
+    unsigned short *array = NULL;
+    int host_cmd;
+    abi_long ret = 0;
+    abi_ulong target_array, target_buffer;
+
+    switch (target_cmd) {
+    case TARGET_GETVAL:
+        host_cmd = GETVAL;
+        break;
+
+    case TARGET_SETVAL:
+        host_cmd = SETVAL;
+        break;
+
+    case TARGET_GETALL:
+        host_cmd = GETALL;
+        break;
+
+    case TARGET_SETALL:
+        host_cmd = SETALL;
+        break;
+
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
+    case TARGET_GETPID:
+        host_cmd = GETPID;
+        break;
+
+    case TARGET_GETNCNT:
+        host_cmd = GETNCNT;
+        break;
+
+    case TARGET_GETZCNT:
+        host_cmd = GETZCNT;
+        break;
+
+    default:
+        return -TARGET_EINVAL;
+    }
+
+    /*
+     * Unlike Linux and the semctl system call, we take a pointer
+     * to the union arg here.
+     */
+    target_un = lock_user(VERIFY_READ, un_ptr, sizeof(union target_semun), 1);
+
+    switch (host_cmd) {
+    case GETVAL:
+    case SETVAL:
+        __get_user(arg.val, (abi_int *)target_un);
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        break;
+
+    case GETALL:
+    case SETALL:
+        __get_user(target_array, (abi_ulong *)target_un);
+        ret = target_to_host_semarray(semid, &array, target_array);
+        if (is_error(ret)) {
+            goto out;
+        }
+        arg.array = array;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        if (!is_error(ret)) {
+            ret = host_to_target_semarray(semid, target_array, &array);
+        }
+        break;
+
+    case IPC_STAT:
+    case IPC_SET:
+        __get_user(target_buffer, (abi_ulong *)target_un);
+        ret = target_to_host_semid_ds(&dsarg, target_buffer);
+        if (is_error(ret)) {
+            goto out;
+        }
+        arg.buf = &dsarg;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        if (!is_error(ret)) {
+            ret = host_to_target_semid_ds(target_buffer, &dsarg);
+        }
+        break;
+
+    case IPC_RMID:
+    case GETPID:
+    case GETNCNT:
+    case GETZCNT:
+        ret = get_errno(semctl(semid, semnum, host_cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+out:
+    unlock_user(target_un, un_ptr, 1);
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {
-- 
2.52.0


