Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB18D58E4F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwun6-000122-9S; Sun, 01 Mar 2026 23:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun5-00011f-Ln
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:55 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwun4-0006r6-8q
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:55 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d598f4b6fdso870803a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425313; x=1773030113;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyUAw8FArOkUosseE9o8OBZbtt7tOfnmZ7Uy7wbJ8aM=;
 b=1FBA6oZhtLOTd6Z5mUsE/nsBriX6C/JbSfw6ldiYkhKiFiMO4idrGVSZkARLq4HmqT
 wLqRaWpcIf3/7JtvAcxaEjgX0jlTV2SgPxhWPdCp1JfOmvdCMN4s9YaYORZzKsp8GjHN
 UCfjK4vYe6YC7ixLPclbB57KN6pZUX+kQ2M3/4bmn29eb3YzpmlS7PkjJz9i+67AvQ3C
 H6lXDx2OTioAkxbllZFw79IGbocRa3bGp3xze9EvFxytYqwakk8GtXR0canTEzkDS4mj
 +42day5iUcb3r6fd4+8xoorMJXLtGUJg8mgjI6F1eQRaGBVDG/gTR3G2cmN3L1P8Y/Vh
 0Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425313; x=1773030113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DyUAw8FArOkUosseE9o8OBZbtt7tOfnmZ7Uy7wbJ8aM=;
 b=OqUDYM7AXWIPmQoRzkuCfLx4vitGGy76XcSlDGqUdQHh5qDY02hRc8rU6SCszFrg41
 ZCEd/JbWj9B8KlfSe9sYADOYu2d7NTGFQg7zrS629pjgV6os/QR6porMOyEzynupCJQV
 dYPZeExxIfZDbKuzJaUUiTPlY6vibp9VQKeeHiy/ImH63pGyP1aiFpyB9Y6n1ORpYxQZ
 3XlKW/Ssuwib0YigGxnauZYa4cw/Z3qSH4uZ3zmhfMwVManVt00VDDdPbFXq9HQfvJvm
 wdaHEaoJ5PGu18OyYmDmvmQbq0gcvxhAU3lpci6PVMeNhyfREDcaZDTNiDZgjvlif+OL
 4nNg==
X-Gm-Message-State: AOJu0YxqngrqwbgzZQgsxw9tgYXEK5k6qgs/73+AG3YdowJTbe5cDiFb
 u1PxQwRbQhZfP+hOZCuVHCcPY3rqlNYhzgDH4QatIEz6/fUf5oPDhUHSTAMi8WG7HCk6GvEPVgp
 s2RkPsrw=
X-Gm-Gg: ATEYQzz2HOAaB0NCeigIAsft+I5+qtpr9hhOVKQnnQAbQCF6Zk3AqdwWCNarPSQ9I0Z
 IYoKDs9lKIXb5oXTbFhaTAFTKcYseEh+F9vXTLX+wgqNwGRcqDJJ4NmteK4y63/owZGwxZXUTC1
 +Ygjt6pPnJYhuG45pAGQHvRQQ0wJLTRVGW3W5hq19QBRl8KzCGY92GCKkP7bpYFGRtEQ2SbuiZ5
 HyMrmIRjNqXCls7WAq3jimwj1ol9uguEW4Jt0dZUKmDXdg63336Q4HFcRe3PhIk6Y+pDW2VALo5
 HsJSqg9bMQgYByxdZaBZFCyR/hnDw1Fxo8VBe00Tn0mqgBhBRX1WDwcZvYtFv+cU8ZQxp1rUYih
 D+fXIz2kgglyff5xYykIhckehFpCRXTbrrirLypieul+JJuauYm1uqTZcbhc1M0RTpLz+TMFr0n
 QM5ya9oCWHEQ==
X-Received: by 2002:a05:6871:4727:b0:403:fde8:ee9d with SMTP id
 586e51a60fabf-41626e884dcmr5378771fac.17.1772425312782; 
 Sun, 01 Mar 2026 20:21:52 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:52 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@FreeBSD.org>,
 Mikael Urankar <mikael.urankar@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/27] bsd-user: Add target_to_host_msqid_ds for msgctl(2)
Date: Sun,  1 Mar 2026 21:21:01 -0700
Message-ID: <20260302042115.83410-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

Add target_to_host_msqid_ds() to convert target struct msqid_ds to host
format for msgctl(2) IPC_SET operations. Uses memset to zero the struct
rather than directly accessing kernel-only members. Handles FreeBSD
64-bit time_t except on i386.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 5b02006313..5e5a590227 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -136,3 +136,30 @@ abi_long host_to_target_semid_ds(abi_ulong target_addr,
 
     return 0;
 }
+
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_READ, target_md, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(host_md, 0, sizeof(struct msqid_ds));
+    target_to_host_ipc_perm__locked(&host_md->msg_perm,
+                                    &target_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    __get_user(host_md->msg_cbytes, &target_md->msg_cbytes);
+    __get_user(host_md->msg_qnum, &target_md->msg_qnum);
+    __get_user(host_md->msg_qbytes, &target_md->msg_qbytes);
+    __get_user(host_md->msg_lspid, &target_md->msg_lspid);
+    __get_user(host_md->msg_lrpid, &target_md->msg_lrpid);
+    __get_user(host_md->msg_stime, &target_md->msg_stime);
+    __get_user(host_md->msg_rtime, &target_md->msg_rtime);
+    __get_user(host_md->msg_ctime, &target_md->msg_ctime);
+    unlock_user_struct(target_md, target_addr, 0);
+
+    return 0;
+}
-- 
2.52.0


