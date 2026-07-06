Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909A8C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgh3c-0004R8-8Z; Mon, 06 Jul 2026 07:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wgh3L-0004Qh-5s
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:59:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wgh3J-0000Fe-G7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:59:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493c1950518so19179935e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783335592; x=1783940392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oZDyBugNpW9V/0gKwcrIHrQmiK/JotB4UPTEgdY38Xo=;
 b=jtIcmyuMgRZWwJ3QRJ6CmmlT0ZYJ5oxblO55wcoPsuMSKiZsybVfgklUFFJJV0juH+
 aYZoiYfoXydK64yefWDLb2dsJdkx9yjCxzvtOCPw5f8KRKKJy/CNd7Qj8Gw6CSMXvfZt
 lMGtwBJqvMkDLmjCj97bApZk97CbmDWKXpF67CQJ4eLAeZAaWw0pj9hSFSVUqZGrMQw4
 XewPtgOrIqEaVe5I5p5dA+HLfZi2PKA+sIEFiQIFe+P0aU7ALW5b/lI14Ll5U1OAoWSf
 y92J3zefcN0spVo6/o6RFu9hHa+HtBJOoS3w4eroIMicGSW6WesXh8yON9T9SSjMm2Ds
 caSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783335592; x=1783940392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZDyBugNpW9V/0gKwcrIHrQmiK/JotB4UPTEgdY38Xo=;
 b=LQOuDKrlmEYKpeYdYFl1VALRQPwWk5GWlUjouxjb7Uaw1oHFZngxsRSGQhDFhCIvni
 GnOeMPzpO1GbVt/KbkDdu2KYPpLsd6Rp4VRR06NzuHGi6EtfjGF8sfSFbvLlr2akMDHi
 VfGdiUs3qZ3XUnbCT8ADsDA6taB7Nx58U9q9XQ/lSzfxuqip/uW0ePxS2J2Vxdm5e+qK
 2C64nHhNg/g5LYsFi1tPGG7yr2GuX4vmkgFxm5/vh337cyC7Rc4VWKziZx4k3a2KnwKM
 LkS60LyaM5UwjEICBEja70i/JkZjkCoBsa/Rl1qGAkb9IXQHeystXb2OUjJ5T+1loM3M
 vAng==
X-Gm-Message-State: AOJu0YxhKwLq5VpVrDNlyAOdwhQSx9hus29Rsa27PmOo8YablaGIXcI2
 IMqRC2wE6cP0nz0rrLd9QqUzU0OkBPKc71LZzBupnbkKStWJ4LCdG1/gDT1ulwMfKgk=
X-Gm-Gg: AfdE7ckLsvbkGSoxYaEQbHGpKcrgGoLYyrzTo6rkWsb+sLVH16fiQTIYD8V8XDYMm+X
 zV5OY4ih4mlgyChqlRDugs1kXEPH7uN1NiwIFNDMFpHrDbiZDcy2RFtY2dyOi3ZMlZD4YASUz8n
 PtjPP/EzLG6tYUP03akoaDo7gen68+GaVUWqLYutAzCC3PSnooWr36qUWTXLSsNP3zaTBQ/u6Xr
 w6/bncf+J1jyvplysP9pVxDsKPFXz0qU3HhgusDc7EE4M+RVIoG4Iv9YUM0QPbemLfUgRU29E3B
 lbs41o3JSI4tI9enfTSj7Is9B3BamQZAJN34S0lf+KmAu17/rl7oCmQoonj30bUwnDJNi3B6/8H
 ldyzqN1wmtJtKI1gecZpAxwHRf4Ewr9YkHda0lFIeYf5M3KuI/xAyzqYbLDLJPI7OWW9YW7y4FF
 jTIRQ9MRMDzUPA
X-Received: by 2002:a05:600c:530c:b0:493:b4a3:5ab0 with SMTP id
 5b1f17b1804b1-493dececd3fmr1470525e9.13.1783335591606; 
 Mon, 06 Jul 2026 03:59:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm257399355e9.4.2026.07.06.03.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:59:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB7445F83B;
 Mon, 06 Jul 2026 11:59:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH] target/sparc: remove unused helper_debug
Date: Mon,  6 Jul 2026 11:59:48 +0100
Message-ID: <20260706105948.740881-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

A long time ago we used to check for breakpoints within the target
loops. Since b5cf7428416 (accel/tcg: Remove
TranslatorOps.breakpoint_check) this is not longer required. Remove
the old helper.

Fixes: b5cf7428416 (accel/tcg: Remove TranslatorOps.breakpoint_check)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sparc/helper.h | 1 -
 target/sparc/helper.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 3a7f7dc1296..f943b6f5522 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -25,7 +25,6 @@ DEF_HELPER_FLAGS_2(tick_set_count, TCG_CALL_NO_RWG, void, ptr, i64)
 DEF_HELPER_FLAGS_3(tick_get_count, TCG_CALL_NO_WG, i64, env, ptr, int)
 DEF_HELPER_FLAGS_2(tick_set_limit, TCG_CALL_NO_RWG, void, ptr, i64)
 #endif
-DEF_HELPER_1(debug, void, env)
 DEF_HELPER_1(save, void, env)
 DEF_HELPER_1(restore, void, env)
 DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl, tl)
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 8de261b0e30..57ff395f2b3 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -41,14 +41,6 @@ void helper_raise_exception(CPUSPARCState *env, int tt)
     cpu_loop_exit(cs);
 }
 
-void helper_debug(CPUSPARCState *env)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_DEBUG;
-    cpu_loop_exit(cs);
-}
-
 #ifdef TARGET_SPARC64
 void helper_tick_set_count(void *opaque, uint64_t count)
 {
-- 
2.47.3


