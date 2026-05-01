Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9894ACD3425
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIku0-0003wS-Qq; Fri, 01 May 2026 06:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktu-0003uR-Uf
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktt-0008HU-8w
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891f625344so19352075e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630511; x=1778235311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CDst0IXYQnDF21W1Eul66jWjgyL41RzGLPKADSYQjbA=;
 b=KqjscGX6z7rirV7FFFNL3MDBqdW4LBG7ohr1ngSEt38A9rWUsRw9vEfHGppfI/Hc2E
 845APHs36ZQphdReOV+VeTf4be41mpjADQ65T5TizUQkJ+F1k991mfTSKy1m0MTqyYvt
 clioL8YTa7OY/wyWOSBfsvQz1PQw1Lo5JYaH0TjNz0mOmxY4NgtRw+/21crjYAk4nKzD
 7WKYIcBjfuc5m8d//ZFTpoJLyIhR2Geuah567Gpy20nItijN9XPDsQV+PlzhPVsKhSWZ
 Mk+20cWLpvRUCDULoynr5btm8oQIBh+VnxPj+g6Mdbi6mIFMEUrZVL1IOyQ8a7Oc5Wo4
 Z2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630511; x=1778235311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CDst0IXYQnDF21W1Eul66jWjgyL41RzGLPKADSYQjbA=;
 b=DfK4NuMNEleSvF3fLa5pLaH8Wvei3C3pjyb8xnkSnHKBLqIFtxiNjF3lJSiYKZR6+G
 LIUvCcB0qKkI2cv9VA4e8WdJSDDG4QVcxJY59MVguk5m10DVbxcw9ONnEeiuw1wqAfvU
 1XOGWLCxpyWqa5vVKxuVZTPK5srQ5IZAJUGxogjFt4bM+EhRmhsKwYCeWNT95HUetOUa
 SJgKsN0Abm5jSc8EtSgz9pDk3LQkhcpw6MhIddwVTSF0hOWaJdYLSNif8fbPMuJdHWUG
 78lu1X4VPMuAYDbpi1Makez2IMaJJwv351sgiV31krTjlGpHzK9gr/s33xXZUZ0AVN8A
 ci/Q==
X-Gm-Message-State: AOJu0YxwQteejgrmlKor9cg3x/vSXhhd/en9AFK4N8J5HmXaVfbylXPZ
 q1pSTTaoK9BF7P84PlFTF+pqnn/cdiM/WhIEnQHRFgh0jOaNyCUIsjEbwPSaEQREqCQ4pJZbK+J
 P+sVr
X-Gm-Gg: AeBDiesKz4cGUWJckOQXrw3EUD7ZQYlcCMQ+F9xl00h5WgEAJ7kI8v1Fe/S8SWbhu5/
 a0BGd1TDpPhiCgHqUHNySmr70X8kATiPixI4iw1/+9EPQ1xV6mV5oXQ/S5F0clbeaD238skM0SV
 d7nt45jZxeUES560Bw5GW0XZYYTYLP8mvuXzbvph5cUzMh9iRD7tv8YcTqek2N7lwpywk2sDrQA
 2UqCroESpqoNuVMhForlG8d6r8SOb9L/HQIzLnS4e3dssDLXh/rJtvN9d05hexKSJBsajG0gT6z
 fOgbz+YUKLx2xNj5K7giTEEm/RiDzHljrDoR5T9j6V6ZSKUF+noYzSmpJAnecelfexJWvk38V8r
 GAqePkwUo6LBvRxniRIn0fmsnKmcTc7O5H5k4t/XFx44yEUNA5Ngm1NPvK15Iru0DBSk4bSxI5t
 PjwCukKk96sVqwgn48YY9Erlt7ucdwvTborSixMaUFub+e1XP581hMfkkv1krgcYDRxCnTB2/+R
 OCf2Um1G455df8XK3wFVi2PV3ifD0korQMAIHw5dQ==
X-Received: by 2002:a05:600c:6291:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48a85e75173mr98983315e9.7.1777630511543; 
 Fri, 01 May 2026 03:15:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/28] linux-user/arm: Restrict regpairs_aligned
Date: Fri,  1 May 2026 11:14:41 +0100
Message-ID: <20260501101505.3485916-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The function regpairs_aligned is for extracting a 64-bit
quantity from a pair of 32-bit registers and does not
apply to AArch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260409035015.132370-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/user-internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 24d35998f0..e65373b204 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -136,7 +136,7 @@ void print_termios2(void *arg);
 #endif
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
 static inline int regpairs_aligned(CPUArchState *cpu_env, int num)
 {
     return cpu_env->eabi;
-- 
2.43.0


