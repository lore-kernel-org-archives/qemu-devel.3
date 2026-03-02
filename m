Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1EBD58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunG-00015Z-ME; Sun, 01 Mar 2026 23:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunF-00014u-3U
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:05 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunD-0006sY-Mk
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:04 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d55b97f358so3545963a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425322; x=1773030122;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yo8ODZIvQDghts3qEkJthejsOv/c5ojeKmbD2EqQf9w=;
 b=DiQRUv0YNty6TB7/81CMD4llb3kmQ6zDUyC7fNXFACZIJkbfgQGuaoqMAolk17WHEh
 zjaXkoPhscGTwdUIqB1WIuSjs4hclnfT380ja5iE6ijF0TUoMvtv1K1p/kd1y7hclpH2
 kC5UBuZtxq+Xgbv0PQltYmLLdDnOJJrZnN7ER9dkInW3UFdAO8wBtYSZOwkYEG0rtb+Y
 NFRSWCxOYiskoUzgt0uRqCLsLwEVf03qseRDFm1XvpZnSFOa2oNgY9GVukJqN6QvKzIG
 cDXi92dvEFOmCNUa5ad4Q4bLogI3+db561I8Fues3DnL0zxKdKnleKwRSIwoA1xbEgYi
 A3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425322; x=1773030122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yo8ODZIvQDghts3qEkJthejsOv/c5ojeKmbD2EqQf9w=;
 b=Y0YyJh72uOgSNDp4P8Ptc41OEUzM7947YY30J3wUm3tg1F9ShSefMv85M1ujrCExhM
 Uld5BsxlXO9FF13PyftmqI1aTdOmIRe5hoKDNau157VccJprQ20E63PdaVCDrYdhMnWB
 7288n8JpUfCiRVWbF46BJLUT7v8hORFwmGVv1zMVq0B6zlQQwRRCR/aW/no335CjSHNY
 X2jRkR733MBAq0a1UzptydWV3N5nRb5/O5yXBuK/REJDjbgvXWLKKnvj9SogEqnrAjkS
 N2D7QEp1kxu9Tj8x42W/H3iDxvNDP703fNDr1+ZCHZLlu0rO6NU1QMS0rHsyypFlir/F
 sfuA==
X-Gm-Message-State: AOJu0YxYKzmMSSwFpZ7cBDnUGEXqi2fpD01Leyua94eKFVjix75q1aTf
 96Ic79qOE4woSpKMiie3FT9qq/mBuB2Mrj18f5CR1i8RsR7nAuUO4ePh1pfCfBgLO7ugfKdd7Dl
 HSDodpao=
X-Gm-Gg: ATEYQzw2Ha+4iwjSFCNvvYJxpgbr3cLek/Mlh/gIQnvkamzZ2a0rmi4j6Pg5SLRk9iX
 rofTn2Y1GEy4QDBhpmhQ6ljrj19TOZcE1fAAd2b+0RvB5fsVQoCk8AuMuM//sfaoT48VdFTlFn6
 LbyeEW+PCYCqxcZyoNRqUTM7ALPVSH/F+5GmYoLb58YLVeTbZnLCQ3Qj4f6Jw5C8VZrS9bXnVJ3
 3C+805hkyFHbx4NE1uis1bGwp/voE3YrvVExiz7iX/Zyr0WXlC9aWTR0lUbUkONnao+EMai5bAA
 PDcwJ2zlVFrdtaaA1ua7u5Yb00Aqgdd9cIlYvgjFzsbsQI8UdOgFRfBvp0sJlBrGtOwQ0+m8jdU
 uetqua7IrNY9Op8lDvmH2Y+J4TkygJrHdhNe+7SZNfMkJALzP/qgQMYtTtS+Fs0VDovnaRkI11R
 tlFWCyhquLlg==
X-Received: by 2002:a05:6871:788:b0:409:a4d3:a30e with SMTP id
 586e51a60fabf-41626d64c98mr6287138fac.2.1772425322160; 
 Sun, 01 Mar 2026 20:22:02 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:01 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/27] bsd-user: Add do_bsd_semop implementation
Date: Sun,  1 Mar 2026 21:21:07 -0700
Message-ID: <20260302042115.83410-20-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
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

Add implementation of semop(2) syscall to perform System V semaphore
operations. Converts target sembuf array to host format and executes
operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 3dffb977a5..e1e552b58f 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -77,6 +77,28 @@ static inline abi_long do_bsd_semget(abi_long key, int nsems,
                 target_to_host_bitmask(target_flags, ipc_flags_tbl)));
 }
 
+/* semop(2) */
+static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
+{
+    g_autofree struct sembuf *sops = g_malloc(nsops * sizeof(struct sembuf));
+    struct target_sembuf *target_sembuf;
+    int i;
+
+    target_sembuf = lock_user(VERIFY_READ, ptr,
+            nsops * sizeof(struct target_sembuf), 1);
+    if (target_sembuf == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsops; i++) {
+        __get_user(sops[i].sem_num, &target_sembuf[i].sem_num);
+        __get_user(sops[i].sem_op, &target_sembuf[i].sem_op);
+        __get_user(sops[i].sem_flg, &target_sembuf[i].sem_flg);
+    }
+    unlock_user(target_sembuf, ptr, 0);
+
+    return semop(semid, sops, nsops);
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {
-- 
2.52.0


