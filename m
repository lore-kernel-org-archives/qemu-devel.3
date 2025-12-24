Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB3DE776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRiW-0008Ji-HN; Wed, 24 Dec 2025 11:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRiP-00083T-Rg
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:28:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRiO-0003ss-BW
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so40403295e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593674; x=1767198474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCWaAKr9HKDQPOGDVeV4ELgBSGxrVu16jLOCiFl1Ing=;
 b=Jy99smcdHIvvGn42gELTjl5hCN2ZXf63ODYW2/Z1eLKaoKF6tlj2IbtAKr2oqgFvMQ
 VjxBVBXbWoSB8U8jFQTe99Vi+jdQu0+Uwu0EZTqPnS2tbC1StMnPfIRMiC/Z8AAHEJVN
 81DdTQJlg/5S7rK8cp/mrsvJZzkE5nu8VIGESJsdQZ6ppZjYRgUMDkwYxavs4TUHcLBt
 TEUDkss6R4kFosyfIo7c3FGeFY2K07+53XdaB6U9HUaA7G3ctoFiNJieU6KRfBy3TpFN
 43Y0V0/DB8L9oyQkHYlt4auoocglk7XQiw6Nt+7LUsmkTybxdFU0xLwBZsPM0UQm5aSO
 1P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593674; x=1767198474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yCWaAKr9HKDQPOGDVeV4ELgBSGxrVu16jLOCiFl1Ing=;
 b=ddFPxaW2ZCWuZCcPSuJD/AYknBkZ8QVV+ytfPISFez/SlNKUadC8G4dIzC162vSRFY
 krKx67/ihRDyhSe3Dd/p975bhwerijJfI8tVNLcUWqnsFCiQoSYEv8CL6s5C/NpTMBKp
 Yt7Cq2J0fNXUAaDt66lii/1AFWOcVKGxVSqHxgbUZt35s4D4AjmBRnolRnEMOAztuDip
 7AZUnTPjrBjwlBbQL2WZI9KrvsolQ4hEjK2xw1phfaMhXrpZKYVB/jCWWQrtxGTodNhX
 ddYiGd7St7rEYxTQd+CATxpYIcvQe2AW/9f/P4DwrwPxIomgwOE7hL0hhhIbj0QmXACh
 LnIw==
X-Gm-Message-State: AOJu0YyXwOk6f1kfmO7T96hqqa/lV7NOfk2pitsIDsxQrrJ74ZTKikP7
 zavNwiO+E2y6MluX9cmIxdis4L8TmpMSDrcEiMaQgy1ENmSsWe49i54P0U5OVMJgHhhibJX4yyl
 eDjLvM0k=
X-Gm-Gg: AY/fxX4PymZ+RxwGbQnrtLcBL9BbvBOkaTlQV4r/KH5vsKi8w6m/dqIrANjVnS3l4JM
 4Cs6QbdM24pHm72GF/NTMjh18ih2eDpVmbf8yyz7tZ1qEWIimAHFft+5OKlMR4SNJ+91Cy3R+sk
 SIPrDDgJmCjh7DzuG+shKJOrUnWLdv8RolzSNdeEX2VWKXnEEMXf52DrIW8KQZWyruXfulnYIEb
 OVF0X71Q8xm3RUmk7iildo+Bk1DpExG7s1y2KGpLuF6HDUz3Oiqw6gquCFMdk52OQou3unG3/So
 CUV9gQNMAy9fnOp7Z2NTbdLm9H40UlkxtYVBqPJK96Jcs71A2TO3Ttu3iOV/8OjKF20pYZkjN57
 3KvbrBpBHoGOqqm408LSbi0RhoVLzC0QrjyQfztdxKfz9FmonRXzffdcDjVNvIMiFP2Q7rye9jo
 P1YpljhmjwJ43hJg+cJE4m8Y45SDXA0dSOpWyR1dMR7Tm8anpuBK+/ozk=
X-Google-Smtp-Source: AGHT+IE7D25jXMwQKrHimj1fqfQKSy/l1W2QPXDK0tVQ14Rir4y+jRlrS0l5TKUvJrvLTcUEv6R6gw==
X-Received: by 2002:a05:600c:1d1d:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47d1958f9c5mr176679325e9.26.1766593674111; 
 Wed, 24 Dec 2025 08:27:54 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27c2260sm344952085e9.15.2025.12.24.08.27.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:27:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 8/9] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
Date: Wed, 24 Dec 2025 17:26:40 +0100
Message-ID: <20251224162642.90857-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rather than ldtul_p() which uses the underlying 'unsigned
long' size, use the ldn() variant, passing the access size
as argument (evaluating TARGET_LONG_BITS / 8).

No need to use #ifdef'ry to check for TARGET_ABI32, since
it is 64-bit:

  $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
  configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=32
  configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
  configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=64
  configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=64
  configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=64

Directly expand to the big-endian variant (with the '_be' suffix)
since we only build the SPARC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/gdbstub.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 134617fb232..d265681f6d2 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
-#if defined(TARGET_ABI32)
-    uint32_t tmp;
-
-    tmp = ldl_p(mem_buf);
-#else
-    target_ulong tmp;
-
-    tmp = ldtul_p(mem_buf);
-#endif
+    uint64_t tmp = ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);
 
     if (n < 8) {
         /* g0..g7 */
@@ -170,7 +162,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #else
     else if (n < 64) {
         /* f0-f31 */
-        tmp = ldl_p(mem_buf);
+        tmp = ldl_be_p(mem_buf);
         if (n & 1) {
             env->fpr[(n - 32) / 2].l.lower = tmp;
         } else {
-- 
2.52.0


