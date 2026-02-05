Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB616ECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38I-0004YU-2x; Thu, 05 Feb 2026 12:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38D-0004U3-4h
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:05 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38B-0001Ru-1f
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:04 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-408778a8ec4so1079639fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312422; x=1770917222;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tVJc43R8gJdO7iFb3V8b5dqQ7whhHN3sBkAh0TYTHks=;
 b=zHVJO4p7gvGv28+T8Vw1emjVH2spoxqUJml1mIzSatYd8p+rpyREx97hIQwYFhn8NV
 PzKNFh5LhD9Rznr/eLefuhA+pCNcAK1Cdz+wvZxKRp06KQi5q1Axl2VHfuV7trl7PjUU
 9F7g9tqkzJyhOVDEXSKqnVelfUz5+dWbgcHZRsKzxq3E41Ojpq1NfSUhoiPYSM1j03J8
 yMdyu7sm8Pxt8W+EpXrvFzXPFjgiEyKOoYiEGD6Ze/eWhzd6lsRBRTIy4sQyJdhb2gr0
 MdsHTJWTrSKco4J+M0wZjZ9RA1LuoH3Pz6C6HUvLLWR9I5L+p/9TQGdwqh64NH4a/QCz
 p4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312422; x=1770917222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tVJc43R8gJdO7iFb3V8b5dqQ7whhHN3sBkAh0TYTHks=;
 b=NG1TaLsEyIimX0cWktpt0jUDBHvozB5I4ZDJn7wldirlIjIHR+ybKFQvv2xAhK5GY1
 r3P4diGALIgnW40N6sPo6+qQoxwg8qh2DfmCFJRA5eYsg9Egw1MOYhTQRFO4yJG8s4Ji
 IM9F3pVVRWNSM9TV0AZXaGbBBa5X4v2JXk1ybpJmmiECahkW0FQAHj26VfgjaGcZSueU
 smHk1iSn2YF0qPxgWXrBfKaAfdJS+SB0rscouFXWMJpAGRoz2gMPV0+GZ545aWuk1RDA
 4SRbfSvKp4wfGmX3amAMg+bTuC3CVUt6ME6AW6NPO8w2/Fa1YoRp1pT+nw+/pZkX+ShQ
 lUNA==
X-Gm-Message-State: AOJu0YwnhxgEMOc4HnTEIzeM6o163LzUkIMsXUMaQP6S+SXyY35ql75Z
 +EWo3QJdnF+2GniZoeP8FNIJZ/3cYpqIZ6r6MRm4L/y3Nc9DqkYCdkskJEGP+N5MX5g=
X-Gm-Gg: AZuq6aKGSjloTTlbudv7rMwA63HnQ+yAYN7FRLY3+FJq4gXWxGwMNe0Nmiloyv35yp8
 zv0SumEzOr8nJEXNIkOCiJ3i83WFWmwfyBDoMuiNdfEbxf3/1k3KuwWiSmUeyFT+b6f+cxYR6zo
 L1M0JGkXs5018uUjSj3UGRLTcRwIC9nnWLxfEDpMjuRgfDcL/nR7DKi4wVs0YJgxe0+HsulyWwD
 hkdMFBfKvbFZJKlaxhUwQSR+dCIcygESL3gadCS7ljP7+i7Hccyel5G2awdlYZM3Xqeo9FDsFRt
 cWXeV2wckznFXUpks3lYqvi6lQshtCEcPVlM/fS8h2Ex1nFn2p57cGnV25dX3dT4huIzrlq+Gzi
 IAsVQWxNHxYT90IvPtD96roJG0Dv5F971ei5rd016GJKWzxtT2KAB6wmhlw0gPoOFr2D6WsM1vg
 ==
X-Received: by 2002:a05:6870:8a23:b0:3e8:970e:d4f7 with SMTP id
 586e51a60fabf-40a96c455b2mr24790fac.11.1770312421895; 
 Thu, 05 Feb 2026 09:27:01 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:27:01 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:52 -0700
Subject: [PATCH 19/24] bsd-user: Add do_bsd_msgctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-19-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=4tJJWdQ8fj2evNvz3OTCt/aRpOYoQe282kdYHXwhQsk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbTL9Flc+zhqaIo5IlyYSqGq6sbFx2xrZl0
 YV2BfSqeuGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 AGDMEADSxVy/wWqJ86dzY1EVI3Xp8UjWFyK2dEHnSu4Jsevib6B9hAbiqRa0MfFGMECyBdo2IqD
 QkxoQVGdixvuVpndEdXLXrZ4GWr8xvfJHBk8Q4QX7Jfxtqpq4KO2/bAJt02SPiik27qzrGGffXk
 abSQxr6UCzG+l0FF+T3PciTOhKaIEUiVpVOywjIfP2ZM+WdtEa2VLsR70eTYa3oEHhxv+amE+yl
 JSxHWWv5AILSn3O7oIIBCeXTrgIkDlF7lEMymPX6rwyLKKmxzzVhRBXc0kCZP/8MZ0uaPZnEZrX
 tR5sN4x6LrZcU4ahMsCbUfUhCZ/luiMT8WOmoOLLOM3oCLJSAUkuIoLD0CG1I9j7YXKLK8mvUl4
 jIH2/G9ZBwDiWr2iIPgFASfS47Bv73icPZ2662+vQnK/ZgAhApVPP2g8N+S2v5AElulRUGsfEI8
 FZKnsLnZ7PrV88tpe2Hxj9rbpP/HadwlccaBm7l3oN7Dc3PVHm0UMIYrdXkxbuHt/A6SPplNH1e
 j3izZQqsMS+YQs8UkDKJ/dF94reWcdirNWb7yVG8/AzZ/a99E8Hbg7116BIaiXOPGzsdzpKUqgA
 QvPavJA0mFyfudAxGYCGiXE9iKAld1l+1iIqq1hgZgXN5oJosikjkej82PRgxQzP47LdgDlCvFR
 PxUfn8saLnNHtrA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::34;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x34.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 81fdfd8351..27f4497d76 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -28,6 +28,12 @@
 
 #include "qemu-bsd.h"
 
+#ifdef MSGMAX
+static int bsd_msgmax = MSGMAX;
+#else
+static int bsd_msgmax;
+#endif
+
 /* quotactl(2) */
 static inline abi_long do_bsd_quotactl(abi_ulong path, abi_long cmd,
         __unused abi_ulong target_addr)
@@ -228,6 +234,53 @@ static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
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


