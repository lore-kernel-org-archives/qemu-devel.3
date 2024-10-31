Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB7E68957
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MkV-0005G7-8z; Thu, 31 Oct 2024 00:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MkE-00059R-5H
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:25:17 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MkB-00074F-SM
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:25:13 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53c78ebe580so640575e87.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348710; x=1730953510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pX4OD63TqJEhHTGtF+j18QE21OZi3tgKJV9VJey4GSg=;
 b=AyWeigAcNjTwyVb8nonBaNgUOfffO9E1oJXSY8Ii8YIUA/foq5XA3wv9W7hzBLYmLS
 BE1HT5rIeRK5/b3nzZnNgARwlFtfYBG545IvskeL3xo2xEPYq/30QfmYo8TGxS1K1YMp
 ywEdNxPGpLSbeforjpbeCvMfjY/xhv2kADwFRsWBzqTb8MiaOeaXIS8GsoPvGoUVv6rA
 U4up/NvxzjQSsWFHQZ9I+FncUoKtL9ZFthcdxLzkPhtmm+wOwKpljldrlsDGOkuHjNn0
 IL53daO/Q+YORxa37KdcSgavDkCz2jYM/UyenmVtJSMB5B5nL/LdFJ74lZh2eAR7EuzZ
 DjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348710; x=1730953510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pX4OD63TqJEhHTGtF+j18QE21OZi3tgKJV9VJey4GSg=;
 b=bwO2N6Sl36ciTJfYEur/4GB9QRlk4KVvxrM1DrMDc7Rc1ldE2964YsG/BrVFQluEtl
 p+KR2vN44ge5H/XcSAZr+hXgh0PMjUS3FJXuGZcADXIk8wk51NLINHpNbRwueehJWyC2
 qKj8LgS/FwDXVCy7iXQmmNPnDfVOSvPM5ElHQxJkE7Wf8hPj/GaJVGSrKz5tTVHrb/ZO
 v63h04wkAFMRrL4R30+siDVIyd3CyYEu2d5XpM2der6I2PDFRvg0AyxnqBVXH1I7M8yX
 Sd+9ml4O9AR7CITZz96xcPQQj4V5+cHzmNNZ1mYdlDpvoZYjiCcRT3/5/EYCdn7lKMS5
 d1EQ==
X-Gm-Message-State: AOJu0YxOdwTaiBWMGENfhcuzr0FX8qX380HtEmqyqwymnTrOe6lO0rkL
 c3FegTJCoBVRxVhFCZ574LXBVtKjw7rx90muzH8Hpo3ZnLYPQrNyqltF6+/16e8m+2JDUNt7AT/
 I
X-Google-Smtp-Source: AGHT+IG3/QKA5cS19E9XDTJgjuJZKbnP6l7U3Z3G6UcbonwXgyJZ1DW1n9n/pkgEbLioRP5W30h73w==
X-Received: by 2002:ac2:4a77:0:b0:53b:1ede:9174 with SMTP id
 2adb3069b0e04-53c7bc1cfa7mr232233e87.28.1730348709801; 
 Wed, 30 Oct 2024 21:25:09 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc9589fsm79386e87.32.2024.10.30.21.25.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:25:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/14] target/mips: Remove unused CPUMIPSState::current_fpu
 field
Date: Thu, 31 Oct 2024 01:21:30 -0300
Message-ID: <20241031042130.98450-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

The 'current_fpu' field is unused since commit f01be154589
("Move the active FPU registers into env again, and use more
TCG registers to access them").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241021151253.36443-1-philmd@linaro.org>
---
 target/mips/cpu.h            | 1 -
 target/mips/sysemu/machine.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3dbfbfdb3d3..f6877ece8b4 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -530,7 +530,6 @@ typedef struct CPUArchState {
     CPUMIPSFPUContext active_fpu;
 
     uint32_t current_tc;
-    uint32_t current_fpu;
 
     uint32_t SEGBITS;
     uint32_t PABITS;
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 91cd9f19002..8af11fd896b 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -242,7 +242,7 @@ const VMStateDescription vmstate_mips_cpu = {
 
         /* CPU metastate */
         VMSTATE_UINT32(env.current_tc, MIPSCPU),
-        VMSTATE_UINT32(env.current_fpu, MIPSCPU),
+        VMSTATE_UNUSED(sizeof(uint32_t)), /* was current_fpu */
         VMSTATE_INT32(env.error_code, MIPSCPU),
         VMSTATE_UINTTL(env.btarget, MIPSCPU),
         VMSTATE_UINTTL(env.bcond, MIPSCPU),
-- 
2.45.2


