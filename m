Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4A5F3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbN-00010j-66; Tue, 24 Feb 2026 09:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb4-0000UR-PU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:12 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutay-0001Jj-Q9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:07 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d196a2334fso4672853a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944063; x=1772548863;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zS7J+qqJPcQ7cLVuNEOG2Jh7oLn/8Y9sYx416nFLD3w=;
 b=1XB82pTYixnnPWPb0Rzo2gzuCJDUR6rmpUr0j77y6y2bjAUL1FnsP3LrAwZuoa/J7N
 Eq/Z+XHVsNmtD5X6l4GOSxwrw1BnYAJoJP4uZGhjNrNSbW3H18s/h4ddJiAcnH2AmWiN
 Y1bgATz+g6e3Q6M//M9+pUnv9EMqba1On0/B9O7i07LOvtGw6jjYjzO/xHeTR+ZEeFyy
 RttNe/XGg1xiowsYTp0XSmreE/7PTYqIM9J8H1rDYhnADTFSMVxckG7m9hGw6lPC99wq
 9uAwN9PS894+tNYZiCYnjLu287wLPlA+5Z22iKPQrN6iHWOYAQMGE+sokTggDK7uuy+3
 f9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944063; x=1772548863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zS7J+qqJPcQ7cLVuNEOG2Jh7oLn/8Y9sYx416nFLD3w=;
 b=vOTMiIYeVVcaGHgksB1kXMkhPRcNP8zsWuoSAnnJyxvTEiwCHe7yQ0uDQdcFfFz7Ku
 I/PtAAKSJlDy49DLbk5bsr9oepz5MpGOQndcNknxUpC5wH8ouX4XTQPyRRAyEIguXnFG
 Dloke8hXmUC8S354ulGJRFCM0RWEWQlQLvMbLW83UcpmkM/m0AXiw/RANLk5EdUbDwRr
 oiNm7aPvMLP0h/JN8bsqlQH4f5VjCWZ2lM+1ABGW0XzcA4riOwBn58HRZmxQATlQJlgE
 +ZufLS17pcpYvVbYOhwXP7DmkAf/fe9a69FmI7OXxIh8gGGbPULjvMvVrWixs0WuLdkx
 2ldw==
X-Gm-Message-State: AOJu0Yy+o2pbnJ4WG67Sv5qi74syJnpOFEfovqyeIlV08k40EVyl2oi7
 edZ6NLMttnuAAD//Oblw0tSs1FTfYn6JGlvg1BTSGMl0MDZSi0gioalkI93eqXxr5YHaWs7vDdN
 jaCQOmRc=
X-Gm-Gg: AZuq6aIppZ3ImbaZJm96OZdWsiLcPqh7GzfxCF2QvmTcIhQumcsYqrQQKnwayXPGnRQ
 7M4y0D1lUYo4Hh/WAmDickzo44W3VfQQKJHSopmJhHuYobBC3UA/lSdhgEm5dqD9gJL4uBAASXM
 fzMIc1GY1Skyk6Imam74KZ8puPmy7/o8BR3lg7EorbSgVmR3HokgPugRCuPIaF3uTiVYXimMzgm
 wIg8K4YpBq0KjRcezNxF+o/Fcnb1/6BbH3277NjRU7a+4avYhijpr4P6/RQi0Xa4vGIhYrxhU8r
 t0ZF2KNFtfJGcjdloSY6cCZ4xxVpW7p4tt9GE60qa2i8D8d/N0OlQ3sXLihsUaBmZTd7ZWyjUop
 a6wwZf7T3aq+H5aCxJo+PWil8YiBQQOwZxwz3kb0os4POWb/4Fjrc7Nsx53AQ6z4jIXnaRzc1wW
 Ee2bZj7WyiXQ==
X-Received: by 2002:a05:6830:3784:b0:7cf:d784:5d6 with SMTP id
 46e09a7af769-7d572f2182fmr108801a34.5.1771944063422; 
 Tue, 24 Feb 2026 06:41:03 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:02 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:42 -0700
Subject: [PATCH v4 18/24] bsd-user: Add do_bsd___semctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-18-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8NJRFkWVenCmCN9fl4wq9vrAx8yM1ZCHS2RCnfg5uZg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbho5XQLshfZIPyK4DKp1R18fs3eg6ItrCTV3
 zLB0mAo1h2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 AB7pD/wOyC8MGj+K2ejx49igBJYYi6uuHRzk1tLFo/OqQrgO03PHraErx7uffwMdhL8Plgi1kYp
 iRb2NnzGaV9USt3Ft0/ET/G6ogxZUJ+XFsytr2yDKI2Nc6CIBKpDq7GfBbalD2dlY9sctIgzMUS
 QV/NsAA4Og22BHdq6Ei4zMd1ZpBonOhU6nO1e2vNeP6x2MH43tUeOSxQlVcteYhzsgSAt1uVkZN
 MqHex8fp0x74eBnhwWES1FYs2Y9Iwlsi7opTCpmd6fwZRJp9oCD5l/3t++PoKm9AZzQi1cuzp4g
 D1pdLIGaVdVzSKZyoOXnd3Fo22KDyqwOWG2jNjfAyoO8Fa+48YfDqmQZzyxg/INFu00wCsxMeTk
 irSc9Xb9lU434FbBfkcoUnuPvTFyGsbW3XvzjzRSs5CHuOcCm58MT4Fk2IsYldeRhvKYgbScTRn
 2JoN5GRJtf0ur4ATVgEmMub2UWnweLR1JtSjqtgOrA/yEfTLdWSbq+UPWftRcRZ7/1CmwFtsAi/
 BlVI6cllQExL3x7acRcygKhd8U8qtrKC7OMlVFmhtz4F3XH9nEMTZ7NLmCPOm/PnybUTaFPKAT0
 ZFcXYBG/HtO/qvhy9DRnquZ64hAvTOZtAub7ZkLP9doPUDd78avcBvZgqlocidmt/EKtZRDiZuW
 eUDvJ/d2dO1eBGQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index e1e552b58f..72b3db0b74 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -99,6 +99,117 @@ static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
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
+    abi_long err;
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
+        err = target_to_host_semarray(semid, &array, target_array);
+        if (is_error(err)) {
+            goto out;
+        }
+        arg.array = array;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        err = host_to_target_semarray(semid, target_array, &array);
+        break;
+
+    case IPC_STAT:
+    case IPC_SET:
+        __get_user(target_buffer, (abi_ulong *)target_un);
+        err = target_to_host_semid_ds(&dsarg, target_buffer);
+        if (is_error(err)) {
+            goto out;
+        }
+        arg.buf = &dsarg;
+        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
+        err = host_to_target_semid_ds(target_buffer, &dsarg);
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


