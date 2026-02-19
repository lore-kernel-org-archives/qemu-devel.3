Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E480E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVH-0002qB-CP; Thu, 19 Feb 2026 00:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVF-0002p0-Gl
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:05 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVE-00023y-2m
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:05 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6775a46c6dfso199513eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478583; x=1772083383;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ba0fc+vFZQLW2W/fT023p6dnZS4A9WeVPyc5ClTZS7c=;
 b=2pv6yFjnJSbrAv9nTL/SOhw42irtt2Gh+kLlaC5rFo73FkwBxcel09FbZx7V/NtroH
 t20TrGHYm/PKAoiVX1PiOjBmdkQ4BQASRVgPgtmqxhILfO6BqGip3z3PmTvcnGTDV+xC
 OyDOrcF6eyjap+DKEyFAQpj5TW6ZsP6Rhxl1HglXjRK1W+9FKw2fOs4YavVsAeywoCeZ
 X99Ikw+qTmjYpVuFwu0p8hk74A7Ft+smtA9wrIThgG0S6yQM6UxnnGcDT5+NXNAjKbtn
 L3OubemMrxb7pw+B7N6MgOwLCNDrvowj3JQucRs1dOQ3Si/IzQdNUBcn7J5nEtEio/uc
 mXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478583; x=1772083383;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ba0fc+vFZQLW2W/fT023p6dnZS4A9WeVPyc5ClTZS7c=;
 b=mbzXKl1q4mqvBafZUU39fIRq5xqC2tDZlj3CoLmMoyZKgj1i2VhWpdLbaYf6INItoE
 2ZaNdYmC4OfoNBRv3fhcOdGCnCVdk23i+/Db4iMkNfLn+PTRaf8UTAopW7zTCt++OA2k
 O0gELJFWx2CP2Bxc5qMjnNZRXntmMOlPabmAonX+aFVEntNztztMGw9Shy7R/2MA8ifj
 qS8NEROAYOt8AGPayJ2gt3KKBzSc85jM1ijAifYD5cHUvw4XzBQWvG5BHnUHp/aie+O8
 2OdVSRm4WLyQumgPHkBReZTM+W4E8mxTgZpgkiB1HSyQe3VNZphBQzwsBYc698WcQHC7
 B1LA==
X-Gm-Message-State: AOJu0YypsT4zqz0oG082YRiLAUPTayNvdgBRN6Nyk4+RM7oBeAbmret+
 PnjmHJPJwWNuFyr4pIerZLUo2eTxJBCzsBhJFWp8yX0yhG07kOB5IYjF5W3Na7hw8II=
X-Gm-Gg: AZuq6aIzOGRzMfedzUdNZoPP6wZUZ4UrRYxQapHfx0aTz9WhaYhMysqYVaWDAude2Ek
 sDUqn0bonDty1ABZV5QpVLG0BZ8/9onB3E7v5/+WgRzRZoOkFkdaHVMdbVbAthst5i2jkJb1dGO
 CbU1mL2iepQqdcHDRwdQhXLy8DAu4zGZqzZfzjo4nyNZkih5WBaHrsd9beqYl6nYp3nnakock/x
 4PsUvwiejuZLl4b+0M9Bn/FyHvQ1zUDdH5KrGBhrtrqYIlGItbKUzZY/lDeQu4L8NAdGajukyqJ
 dgU622mQgli8JXwU+zUBlSii4gfbq67U/v99/bpi28sMyWDF/iaS+ZZiAZEL6AGfVlSrLUKCoI8
 S3UCsplnfg3WV6ca2qxgjXU0M8EdgKCyLBYNvZj08MYkkYkVNgiyUfIu1W0UJSx4pYqEtCpO+Ki
 M88gz6TrRdaA==
X-Received: by 2002:a05:6820:2906:b0:674:3230:ff1c with SMTP id
 006d021491bc7-6785c51090fmr8661861eaf.80.1771478582997; 
 Wed, 18 Feb 2026 21:23:02 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:23:02 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:42 -0700
Subject: [PATCH v3 19/24] bsd-user: Add do_bsd_msgctl implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-19-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=okBI/sJ4WMOUDdSL4AVt/peow+uZhI6wE8r0EzJWOnY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4sdp9mEzu9ViI5QTCno5g0fyqpL38IPeq1F
 e8RaY1wP3uJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AA2RD/wI6/sV4lavFGbry3DOGy6ByEkkbEM+sDUdRzEXmNqleNGXK/yHZKNWekUwhJl4xI1gpMj
 5R/GkqisReFqOaAowLXJI4CmbuV2K01rqwiJEDlMC8zdo+1TxMn1PN/xtrmE4msuyWTylDa90F1
 e1FuWL8aQk9IVFluAlJFN39zZnsbOpw6wVKCOrIYztZQmwsGhS9JyJezS5dteNNd6vdspXJZ/B+
 58HHtE4/iF5OF1X3pD64cNqQQWOaclk9uLRnTeDCqHmCBrglVqgil5AIXL1cPkF8mybbrHgYyWJ
 Dl3SEl6fsav3Zg0i54YgfWgeu4LpWM5khcwyS4Z5ky8I28S83XMtMZW6hOG92oqn4rXfn64kpzz
 kgzHlHijqNxf/tOmkoZ3hhH1noXHiujOJ7/BGpRPrBONxpXa3WWYVVL88VPtnSyoBv3FdNQHtq1
 k72XAOv5aqir2lRPuRblO8dUPDYKUrF9JxLsjlbsdbRAtvwqkqt3hy0FqV5O1CX4id8OnzYV6Sa
 qa1noT88v2pMpIqk5dzaykIuz3U3v4PePV1ziGIdfg9FR+FgCxNDZE4+/1SgZED2DfEMkdKPvyU
 TeK4OyKjMBcHiEcHY1y9Xkm1/FrtZ92aTfrMC/rWJN4nWi4fbwnJPiyv40v0TUbZmf6lYAzikYW
 S2Nw0/YG81mdMKA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc29.google.com
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
index cb7fe1d6d0..9837b9654c 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -215,6 +215,53 @@ static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
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


