Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F3AF3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbK-0000wl-Sn; Tue, 24 Feb 2026 09:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb6-0000Zf-Kf
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:14 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb2-0001K9-Hi
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:11 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d513bc15c7so4146693a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944066; x=1772548866;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MWlWLkCyAjgDpoeWrYwlC6tNQgfyWaX1gtR/Bl4NTak=;
 b=ANyZ9oSHjp1vcKRP+5vAeJ/aiwya5FTZNZ8GE6JN4vFCEyH1Uy3jd92dU9fiCA8Xj2
 QueF0ZBUZw/o1k3wWMc2ccDY2T8pz17nztDiPh7qNNVl40InS2nPOKAWcCHeYcxhZCfw
 7xoVFISTZX/zAZXZQzrX93D0Ag+FohlIww3/qZaN/FTgmSuNQTcWam6iTp8eNEIlGhft
 ASHNXjgIfdGFVgFAMb9DB4ukFoFFX42DZXbwgPv9QZRiLaevXjMK9XThkpjydGANQM1c
 R9VKSAihMh3NnzcOj+zgqAuG6Z0ufGBSBxG9iwLLsy2Xlf31utNbwjVI9zDgZa5I1IZE
 HVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944066; x=1772548866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MWlWLkCyAjgDpoeWrYwlC6tNQgfyWaX1gtR/Bl4NTak=;
 b=J4kbv56klN7HIWMML6q+kJa/B8rkCz1cOdaQoFo2N2d2ULmdtkZEFuKJkKtvDMzxGR
 3mKVy6/SwRqgajwhqixId53zBwHUq2z24HFKr+agrEVPD6eF2KSn+th16dHhvZdexgN7
 FjM70dI6lCzkJ26FiCRGTla/N3k+PUKQd+b9WRmDCkoTFRN4C1rNjokCfIh9sSQUik70
 NUYzDeAmb+ahHR60hMai71819nkMNI+BQx1Nb19d75KqhG4wVRNmEkHw9jp4UbOA2hmi
 Ns4qTQ6qDS299wF6U1d8MgiO24Ww4W99hGIcmDf+gEIieTkbSyeQqsQWCxNH8C1TrSh2
 p/YA==
X-Gm-Message-State: AOJu0YxYz55cme3c/m4BcppOAjj82xg40wNT6KXtk9mx8i8KYgwlP5TD
 vI+i4aofOoHSFvnfog3XTeKBuSi1CiSPyIZhO0+aNyP3MdDEnSvPQzx3CPdA/Lfyt6mux6qQPYL
 2Lcu7t7Q=
X-Gm-Gg: AZuq6aKFvcXIbFVci4oMy4CqHqn4rK43UilQuiFMeNNAi7pZ/48D5LEBR+3/WucSYIE
 18dB1tnNmTuU5qrs5gYO6z2uBW/1uauBrsbysTxeRzDczGX7iWTRmofjtBKGvMufAzz/PkljiYT
 uPs6Di8iXjUBEzXjGkdPQH0Mjhx100NtJNDEJxbhmDkRtH37rE6R8TLrvalbIOwsr/6xo36k8oM
 HJpETXekhy7f7vSW7Zu2xhTxZZgi0wAnxvc9xHhOcB8iBKL0z8zH85hXlu7MQtPPAUHcib0pkZ2
 c8ZF2NVAEF4C8VloynsNze8pU9gXhdEoZ5JAlyM0T0aBHIwyUQWRzrYfCoFezRD6rXzreCPNMpQ
 nimI38pN8E1N1WGrJRO0mwpDij3gbxUm8xHjAbaq2gST0uyLmJKi50BE84WEuzv6UYxD1BDYdUD
 niOPQ5FC1JjsAoeNcwxQQA
X-Received: by 2002:a05:6830:f94:b0:7d4:4af4:b7d4 with SMTP id
 46e09a7af769-7d52be03d5emr6756447a34.1.1771944065797; 
 Tue, 24 Feb 2026 06:41:05 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:05 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:44 -0700
Subject: [PATCH v4 20/24] bsd-user: Add message queue implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-20-8ee5ae17056f@bsdimp.com>
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
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3717; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=psbAT/x07gXS5csd7AXzIGP340rMO3kOZGPxyBQXkc0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhofChIRqM/lgb9Hv556yVAVOkmDdKLQjhpg
 OWCcGNcpmKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 AMjfEADmwvn9somFgOm8IPn2J4w/y59OCQSW9N4uNkx9AcWudf3UO9SrEvECoKzR619tgK+lNQR
 4lr3cH14q9mazHoLszZSgBxntrfCznYng6+JSXALLxBBRigGrtz3zWdhOMp3wkR/bOwqj5xxtgR
 AaCS5j7vvtsIblkI8YIlp60n+lhMUbL18/Mi086Rz3wSep1en3YKLMEwUItkIRfDdbu7KXeiJ1b
 Q8ToCqdJzKWbbR46QDOTR941nZDT03teSgdRYHm3O2weN7ZNWYMKWMkCIEKJTa8kOZSoHhBFrPn
 trIOcWOBcdJplEsfnLUwlR6xXWtLzCGRl3lcUZurPBwigPEvEPbO2vsUiOc82a91k9XXBnWHQPU
 mOrPDehPLGeLRhlrcT2NAcJDdOnFRqUxycmU6R5s/uZAK06uokFwUjb2EdM9SXwX8pl0HfddR0q
 S6X8upkGlkF18KjXj6cqAeW4ymm6PugPL1hFjEgVMQ2PQbM/iewif+S2hJGUl2XM2kaTUe2OJ3k
 7twQ+Nf3vR1FCabAkBIzaMk3QP2o4uLBVYfJVE9C9gVNCsgiiBfjZ3keTsMAOwlGKfUIVr6naqN
 PumMOo/jPbSbKVpUbddltyiVYiKjSoufEHuc8gGi741ktHjArU1MOWOszat+8lujzigNTjS5IHu
 Lb7Hw/y2ESbNf7Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Add implementations for:
- msgsnd(2): Send message to queue with size validation
- msgget(2): Get message queue identifier
- msgrcv(2): Receive message from queue with size validation

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 2e9de50ef9..a25965598f 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -17,6 +17,8 @@
 
 #include "qemu-bsd.h"
 
+static int bsd_msgmax;
+
 /* quotactl(2) */
 static inline abi_long do_bsd_quotactl(abi_ulong path, abi_long cmd,
         __unused abi_ulong target_addr)
@@ -257,6 +259,101 @@ static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
     return ret;
 }
 
+struct kern_mymsg {
+    long mtype;
+    char mtext[1];
+};
+
+static inline abi_long bsd_validate_msgsz(abi_ulong msgsz)
+{
+    /* Fetch msgmax the first time we need it. */
+    if (bsd_msgmax == 0) {
+        size_t len = sizeof(bsd_msgmax);
+
+        if (sysctlbyname("kern.ipc.msgmax", &bsd_msgmax, &len, NULL, 0) == -1) {
+            return -TARGET_EINVAL;
+        }
+    }
+
+    if (msgsz > bsd_msgmax) {
+        return -TARGET_EINVAL;
+    }
+    return 0;
+}
+
+/* msgsnd(2) */
+static inline abi_long do_bsd_msgsnd(int msqid, abi_long msgp,
+        abi_ulong msgsz, int msgflg)
+{
+    struct target_msgbuf *target_mb;
+    struct kern_mymsg *host_mb;
+    abi_long ret;
+
+    ret = bsd_validate_msgsz(msgsz);
+    if (is_error(ret)) {
+        return ret;
+    }
+    if (!lock_user_struct(VERIFY_READ, target_mb, msgp, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_mb = g_malloc(msgsz + sizeof(long));
+    host_mb->mtype = (abi_long) tswapal(target_mb->mtype);
+    memcpy(host_mb->mtext, target_mb->mtext, msgsz);
+    ret = get_errno(msgsnd(msqid, host_mb, msgsz, msgflg));
+    g_free(host_mb);
+    unlock_user_struct(target_mb, msgp, 0);
+
+    return ret;
+}
+
+/* msgget(2) */
+static inline abi_long do_bsd_msgget(abi_long key, abi_long msgflag)
+{
+    abi_long ret;
+
+    ret = get_errno(msgget(key, msgflag));
+    return ret;
+}
+
+/* msgrcv(2) */
+static inline abi_long do_bsd_msgrcv(int msqid, abi_long msgp,
+        abi_ulong msgsz, abi_long msgtyp, int msgflg)
+{
+    struct target_msgbuf *target_mb = NULL;
+    char *target_mtext;
+    struct kern_mymsg *host_mb;
+    abi_long ret = 0;
+
+    ret = bsd_validate_msgsz(msgsz);
+    if (is_error(ret)) {
+        return ret;
+    }
+    if (!lock_user_struct(VERIFY_WRITE, target_mb, msgp, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_mb = g_malloc(msgsz + sizeof(long));
+    ret = get_errno(msgrcv(msqid, host_mb, msgsz, tswapal(msgtyp), msgflg));
+    if (ret > 0) {
+        abi_ulong target_mtext_addr = msgp + sizeof(abi_ulong);
+        target_mtext = lock_user(VERIFY_WRITE, target_mtext_addr, ret, 0);
+        if (target_mtext == NULL) {
+            ret = -TARGET_EFAULT;
+            goto end;
+        }
+        memcpy(target_mb->mtext, host_mb->mtext, ret);
+        unlock_user(target_mtext, target_mtext_addr, ret);
+    }
+    if (!is_error(ret)) {
+        target_mb->mtype = tswapal(host_mb->mtype);
+    }
+end:
+    if (target_mb != NULL) {
+        unlock_user_struct(target_mb, msgp, 1);
+    }
+    g_free(host_mb);
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


