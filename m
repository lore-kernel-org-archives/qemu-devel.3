Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386ADF3C982
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutak-0000Hr-Ss; Tue, 24 Feb 2026 09:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutai-0000H5-0n
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:48 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutag-0001GD-EU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:47 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c7d04890so5169539a34.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944045; x=1772548845;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+t1iHUqtREGyGrJCLj2fqTNeBuRk/na2OctX3Jzxbs=;
 b=KZs4pf88QgloqSDiQbkwA4+TsgfrypwtxwPUliXI9YA1G7n5calfDUrZA5Hx+sme+t
 jrYK81rXhJock2YN8QhL8T8JgxgyPze968tGfCnhjDwIYUt44mDG9lg/VIi64sGusnvx
 dn1KPU3f6r0srYfE/4KV9+tERlsPxGWGsE4KWlPUlmrYSXR2ZiSI6TO3LIwrSV1mspgO
 TtX2g9He+Fz37mt5tPuRCTa5vTekbpu8AzVAdQiIrDMg8AK3X94wtAnslU2G0eG49Dg8
 uBGutOf3CaNvFGLjrqlmflwvtbF3SxuOhknjTyfcWYAyNjBhdDZ3Xq7N0lHr8zMPCbHS
 BlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944045; x=1772548845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d+t1iHUqtREGyGrJCLj2fqTNeBuRk/na2OctX3Jzxbs=;
 b=X6AUNpgWXCE+xSLXzSYF470yHLBMvumeHmUnozZ/CUnJR8Q0nKIhjMiS4IryavoqJO
 F3CIJxmAFnWUuJO2w2oFk/kV85sXLKDNXsYmLrV7sHKttzO+nK1zMKUCx6t8xQpR2AS/
 0JmoZRTLCSQwtTU9s0avYBKTRZ2zml5duMT+2vXA2Avpei5L4wvHWKAk/uhZoLkXndDA
 Hr9AWaABy3KeANsi+qKu3E46PeBh4mP6JqRNMhm7hWz8d9WxjeyDMCKzEKe/ptBfe3HW
 AOvzz9Ghzt0gCSpBKXqg5g1szvxr97BwYF229NIVFsYJZYhG6VmhARh0Swa1T1cbwVcr
 UMNQ==
X-Gm-Message-State: AOJu0YyiD0TQIbWSqZXXX172vJcoIHUMmq9FGHml+RxaQR4Kw5eEjE89
 nroj6TppMtIHu9p6SFNsBjI7R33fpihkIcHbPt80fYHF1P5rENPjCEKTMXMtBisjkKAFd1IyKIp
 m0sNmbS0=
X-Gm-Gg: AZuq6aLkT3ZUSqilLGU0dlTa27NDAslrNmN75C2utyzYpkM/pPH/sNrAaqTShIbFv4s
 aTPhVJTJ+5mQfJkKBhP1EO1MmmZtdg8HxQ/tbqbTnMiAKNTjDhLkYrx/cVQ4qzyCRlmQBJZxfu4
 mHjH+7XtbT18v6hVvDIG5ppc4iCIniePKFSk8IXwFLzA1/Q/lnmMVX72Y47mnjuXVkPukpdAnmF
 UmHupnbcapspi90wMIO7VufiIjCNh1aFvPi2YFfhK5yFmjIX72r2i/hxM6Vq6ijv43VtGoVYN8y
 /utotnkTIfdfYZtRTNajopBLUMJHh/tfNC/6t8/mWAVaHxM9hx6igMYccBgr16amVlV4cRwModX
 zxD+Fvvq/JIWX8crMwl8Fp0LzZiTzJPzppCnMu1KSo6u9eKcwYh8RGQQHjMoo1rq21JKPMvnBzi
 hsr7xAMzYl8Q==
X-Received: by 2002:a05:6830:4c08:b0:7cf:d4b2:d64e with SMTP id
 46e09a7af769-7d52beadfbdmr6580201a34.3.1771944044895; 
 Tue, 24 Feb 2026 06:40:44 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:44 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:26 -0700
Subject: [PATCH v4 02/24] common-user: Drop __linux__ around
 .note.GNU-stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260224-bsd-user-claude-v4-2-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8f1kgvOYIoToweJ4bia5M92ZB5KgOcRUK3PIe6pRhak=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhmeq2+jNitXs8ni6+hWu+ucwNK8eJU8yJr+
 Thd4EtlAq+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZgAKCRBsHNEofbAR
 AIZTEACk8eUcKclqjyyTHbdZ2n6PZXLo5URk+q4qAOqFWjs5FIQkilItNjThxWy2yGeVdw0321+
 3TQ7XOVVQZD03aPqtG2gkt7y4LGy+LraoECKR3QaMNeGUlRsm3C3KR8igcMfU2lHTTCcGV/Fcf/
 TCUAO7DhbU7O06n/jlC+82LUkKGXmKcua0uy8sePepZynGKDmOQYOHIu6zzFlLG94pGuMKhMcqW
 L7mNDhqMeOacsm6Z0wLD7P0qsMcpo4b0SburczaxMqOrQUZwyWAhxALugyOOPaYj7ZRgqDXFrNf
 yjBV5Vxv5Evq/GdFCO3r893dpbs8FDJ/oBvvHVnCn1FcYeC2ZKeOQeZ0Ykxrhoq17dFrEw/qIDC
 OF6tujcZNoyojtOA+OjhFsx8fec8x0Xdje6Q0eJ9wkHMBVSpHFk0ZwdYs7otrZ5HSTdqXvSYYQ0
 6+8Y86ID9FSOka5VvJm/7Q8LakYkuRCIS+SgQUFuduGRWaW6dcanaGi0if9yP3F0XiYuSwk/KXm
 +ery9MF8swQMMIcgARVGciqvRvibaL1dXZAsc8Iu4caE7YJmH7Dl0lcMgmxeUeLQcUzlhGLoJT1
 E4Z/dR3nk8+e6PCpiCFDPErciGhvpby3EeYLUXj4kYLB/gmyO+gB9vr/mWOBHkorSwhD5P1Xysp
 QO5oykp66tEuyUQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

GNU-stack tagging is a toolchain issue, not an OS issue. All the
toolchains require this for ELF.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 common-user/safe-syscall.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common-user/safe-syscall.S b/common-user/safe-syscall.S
index 74f7e35694..2f714cfbe8 100644
--- a/common-user/safe-syscall.S
+++ b/common-user/safe-syscall.S
@@ -22,6 +22,6 @@
  * assembly needs an executable stack and the whole QEMU binary will
  * needlessly end up with one. This should be the last thing in this file.
  */
-#if defined(__linux__) && defined(__ELF__)
+#if defined(__ELF__)
 .section        .note.GNU-stack, "", %progbits
 #endif

-- 
2.52.0


