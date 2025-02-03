Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87058C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyp-00082Y-Mu; Sun, 02 Feb 2025 22:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temym-00080V-Mx
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyl-0002fh-2K
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:32 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216281bc30fso85004985ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552709; x=1739157509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOiNmgCG27GGUfQ2A+akEblYYk9R7T+pJq3Iu4mV5EA=;
 b=Lp8MYQt8PpyKcS/nWukh/AlcdL6co8wyjswUErJLYDePCFOexsWk1lXJ4vhJPGNef+
 H+ezSglBgOGKyitjthaoFviuhLiYrkrSCNiV7lOq2B9GBF5u/x9niaVGV0kzMOSPT1Dh
 QEK+9GK/U7ByQgk0r8st+GyP3GXPlHRpiusOjOtRbnUObeSLCHXH0J4ryjGxDRct5ytR
 MdO+eItq6JVBNPvSc6ZuxbhHA7+2wk368LNk0wL63jkbrG0vyl7AUUdBYPe0X4KsArkU
 c9GwUiG7pAlxEk2h17x9X5d/sjgqCOIlY/OKaF0Vgkp80mJhz8OnjCbhZWLQl6Ly28WA
 bx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552709; x=1739157509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOiNmgCG27GGUfQ2A+akEblYYk9R7T+pJq3Iu4mV5EA=;
 b=sTZ4Skx8OHnDgJiygRPw1AoxC7P7cRALHR2xyZx9MHwpTEJBmeU5viW5coCbfDKAwS
 TECs6ZMyPm5GjToJ3cRkOKZNGo6PQd4vuIo5yS2SPmX9feqXNA3K16ooHnkmSjCbpRBP
 kvdi1BbMQOo8q6bOwnwsL+tyhY92ggxF/6Wkd1Ib8NlDbIrYcOmBVPifz0OQjDtvLqDT
 Yup7lJF8nC5QIaF3WDUkrrtskqun8+MYnJmlLqze5zWdzosBcBZtkD0nexjZ5GySFFtv
 xkP16Fg7IdG3SA1EpEcsSUEile8A0UG9ZuyvJWE51vnfnRrvM7nBIO/4z2L67SRqazHW
 8skw==
X-Gm-Message-State: AOJu0YxvGrX2oDl7g3kQ/aHbiw6oPaf6Wu3FuSEo29Yk4zp5ye6XHbhC
 /YSxstSglOq3QozgILvSJq3Kp6/qY1+QLfVJBur0rhO3Qsk5YNzfChv6hWV2Rfrko08eFSIALqj
 5
X-Gm-Gg: ASbGncs66oR0nFYheoOjCz1/XOf+e1H0z4fv9uv2vL/3B/WHRznB4ve2WW8jAcHrufk
 nZmFPjKTQn5yCdanC6QRLdvWL58O455A0Tdbc//wM/AF4zsqHvhoggQOCO1MLoEyAm+Cuknv5oS
 eVjk6FYklzDF9MW8ruuCnLCk4A53BdmeQD2mqjzBaERGZhHfck172kIc/BsyjvIfQeK5LRBgxPL
 swqO9k8Fo+DlCenDiAvvqbGRB2K5+JzvQPe96LrX9qWcyh2PyrgRXSQhQTkmyPxfKkMfsGYQK78
 cTfuLPN4YS4fzrSSP0Pr8Wb+pnRCHZgA8Aj/pwX6rsSiQ8o=
X-Google-Smtp-Source: AGHT+IFNiC/vwV48hmHMWXV2+a9mE8Gm2cfj9YRPyTTLurcNzPpdQVpCCxNkVsZh5UGIpUkX79C19g==
X-Received: by 2002:a17:902:c941:b0:215:5ea2:654b with SMTP id
 d9443c01a7336-21dd7c49718mr319441735ad.1.1738552709583; 
 Sun, 02 Feb 2025 19:18:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 08/14] target/mips: Protect objects with CONFIG_TCG
Date: Sun,  2 Feb 2025 19:18:15 -0800
Message-ID: <20250203031821.741477-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Hack around mips32 host allowing kvm acceleration
of mips64 guest, but tcg is disabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/meson.build        | 4 ++--
 target/mips/tcg/system/meson.build | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index fff9cd6c7f..e5574f177b 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -10,7 +10,7 @@ gen = [
 ]
 
 mips_ss.add(gen)
-mips_ss.add(files(
+mips_ss.add(when: 'CONFIG_TCG', if_true: files(
   'dsp_helper.c',
   'exception.c',
   'fpu_helper.c',
@@ -26,7 +26,7 @@ mips_ss.add(files(
   'vr54xx_helper.c',
   'vr54xx_translate.c',
 ))
-mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
+mips_ss.add(when: ['CONFIG_TCG', 'TARGET_MIPS64'], if_true: files(
   'tx79_translate.c',
   'octeon_translate.c',
   'lcsr_translate.c',
diff --git a/target/mips/tcg/system/meson.build b/target/mips/tcg/system/meson.build
index 911341ac37..606ccacebc 100644
--- a/target/mips/tcg/system/meson.build
+++ b/target/mips/tcg/system/meson.build
@@ -1,12 +1,12 @@
-mips_system_ss.add(files(
+mips_system_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cp0_helper.c',
   'special_helper.c',
   'tlb_helper.c',
 ))
-mips_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
+mips_system_ss.add(when: ['CONFIG_TCG', 'CONFIG_SEMIHOSTING'],
   if_true: files('mips-semi.c'),
   if_false: files('semihosting-stub.c')
 )
-mips_system_ss.add(when: 'TARGET_MIPS64', if_true: files(
+mips_system_ss.add(when: ['CONFIG_TCG', 'TARGET_MIPS64'], if_true: files(
   'lcsr_helper.c',
 ))
-- 
2.43.0


