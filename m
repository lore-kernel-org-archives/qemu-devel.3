Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA7EF3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutbV-0001FZ-4F; Tue, 24 Feb 2026 09:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb4-0000UQ-PU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:12 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb0-0001Jz-C2
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:09 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c85307b2so3521426a34.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944064; x=1772548864;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6RTbgEs3c5V4D8CxEt1k02IFsk7HyZp1718RRC3UOWw=;
 b=LVBgUS8CuTgDZG7OdrO1kYpGucFMWwz/7f+/wFf/knvxdRHk8Ux0yAR99YJg6As4zx
 5P+h0crtiiIbULvfit5CFZ+qnMaGY8ESpsvLy+lHtIXjDOiTDIIwrtM5vR/G+/lxLlGD
 9C9CC9fSpSSaOt9xBG0eok1pKVVGAhah/9ycUaw6o8uG7Q5LaEmZT5Y7Khg6mfGSxNcM
 8glyG8CCnna50+nIFdytsNC5iMjypfS0sVacWMPUMWISyS8wBmLjHF30hTYlubLme9Lf
 dFUsSLlkrE/Wzl3Gi9hWqyh5giTU2V2s5VBTKZEdpDMQB5VTUsjvcnyaTTN4ciTgDMt2
 pvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944064; x=1772548864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6RTbgEs3c5V4D8CxEt1k02IFsk7HyZp1718RRC3UOWw=;
 b=qNPtkaB0r9C20nYxLpiZx/QYel1SsbDAQrtu49cpuQ8KlnJTMCKGAOprP3MGliUOz7
 vmqbe4ATMYJv7Y/9BvxgY3Ty5ZN3cru+0XtwdQdum0Q1tImWFTcm8ZRBkExjl/hq0VDD
 KdcPchf9h0hDz4+gf+GbiAX48rwi2otGjnYdyGJypa2NxM9lkgLbUtZh+c43OopaGrqa
 J5EzsL+PIul5tBHoO7SnxIlRLzYM2agq9v4zE8L1xsaurYHrojzliaw8zfPjj54qILcO
 uyjheqzYrfFHMJMIy8X4n26X3GFo+tQ/9qk4eo8JOkMqPWaXHZnKzVsk40CmOawqB79o
 D8TQ==
X-Gm-Message-State: AOJu0Yyi3kqwUcP79aU3TKGLw6fP0Rb5N0z/tXoqGQ6c7fQC48nsqOWS
 GPwZ8Rp86czUxp/MRhi7ftV+OMrOILPREJeirnoW2A2hbT2xaFfs8JX5oWYfMlLP0IVXg5KCaCa
 VztnhxE4=
X-Gm-Gg: AZuq6aItdoPjxhusBNelarFpDOWlV2mkN0HU7udl6j3xz5Q2InrqkKx/zL7vpobrR7T
 vJsvOF7/xP8CHWyRQRz5DkBg1msxSkPFQnRNDGnCaieTwdvv1Lo66uMzRUZp77RDCOjTInt7Wp2
 LYquBF35lnMmCzofIQqMoDXo0vgKtZq+oBBShd1Yd2izPRxwZQ2mY2T4gniZuWWgVLeAt7RCqDT
 mpRQje4zQU62dlUozvfDQ37JsBYHL0LBznnFyGX+LvtIKmXYWXNSfgzJsmbbANcFbVySR5gscas
 EEhfZBdSELdwn6AwixNf8FqQw+jUK4M4M7ypUXadszhZN0QTMGokhDTLJ7hfIROm7zwS2LhUyDU
 J1lRYNg7NLi+A+ruEXGcn/ZrHfJCvHIZKkkMfvpMA91cChCNfUwbfh0vpazG1u+kc3NR9AEsub0
 vEvRUw+28BVg==
X-Received: by 2002:a05:6830:310f:b0:7cf:d14f:a4aa with SMTP id
 46e09a7af769-7d52bf53565mr6380021a34.20.1771944064596; 
 Tue, 24 Feb 2026 06:41:04 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:04 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:43 -0700
Subject: [PATCH v4 19/24] bsd-user: Add do_bsd_msgctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-19-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=+aPWXFlolcJgREkhCBhuuvqaTVfoCu3VHmTRqGie1KA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbho/+zDiyyH7c3C60WR+MF3HuDxnL15STa0q
 AZ1qfLCez2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 AC9vD/0Y1l7Mn+7lXbm08foLLpR6WlHwc9QUlZKMOd/TtLf4eKtU71jQI6OZPoiEm32R5F1ceBG
 S8TTXIco2RniUMhwX9cgUX/Fygu0C9aGabx1BhDdZMahIfWheH6E0+dsGDqwRjZLOH3zeWS/ozC
 SUeD3RowCBiaP6Qwpn98+0Onr3/CJulxjzYMrbQZnGflguJovtr/emDze22UVlHhGzl9R3CqQ0V
 BJ9ll0HqCTPpAKBlRIWcjz4ZafjENEDrpUqiUP7Nh45Pb0KIQMdC/j8s5/tdgvM75uv2YC3IcnZ
 J1p9wr0oIRPxgogp+bAWHNPeaPGGJFEDSTGKID7G4AcheIRQnESr2Ap4n0EYxQmeE/Fpx5TPy09
 dIyqQXgxqWZ1JYTcn0mnO2wlnpC9MC1srHl4IioPZMO3wNC6F1Ey4qr/jEhsEBUKQezeIRFUe+Y
 DG5xyb4CofVZPp0ft/21dm9srGMtLIbREmpygUnVTtYXhpa6dULfFhdsC0yFVGo3Q4WzmMf8IPF
 XB4x20ixmLyaRpXcDFu2hIzvePlmIhlUh3LpEOZnMotuxu+T5XX8AW0v0+/s8MeCAwA/ngmAK71
 Z0Uc2pdr0+5xOG+gIXSnduSRXFKMrE8fS5Sr3SF9wE5I9LaRcQI+rng46RWbkhbR+THU//JGGAf
 eqXkiCZ6wl81zbg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

Add implementation of msgctl(2) syscall for System V message queue control
operations. Handles command translation and structure conversions for
IPC_STAT/IPC_SET/IPC_RMID operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 72b3db0b74..2e9de50ef9 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -210,6 +210,53 @@ out:
     return ret;
 }
 
+/* msgctl(2) */
+static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
+{
+    struct msqid_ds dsarg;
+    abi_long ret = -TARGET_EINVAL;
+    int host_cmd;
+
+    switch (target_cmd) {
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
+    default:
+        return -TARGET_EINVAL;
+    }
+
+    switch (host_cmd) {
+    case IPC_STAT:
+    case IPC_SET:
+        if (target_to_host_msqid_ds(&dsarg, ptr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(msgctl(msgid, host_cmd, &dsarg));
+        if (host_to_target_msqid_ds(ptr, &dsarg)) {
+            return -TARGET_EFAULT;
+        }
+        break;
+
+    case IPC_RMID:
+        ret = get_errno(msgctl(msgid, host_cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


