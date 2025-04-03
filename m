Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86992C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 11:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Iue-0001Ip-He; Thu, 03 Apr 2025 07:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0Iub-0001Hz-LW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:39:09 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0IuX-000266-Ps
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 07:39:08 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso140783166b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743680333; x=1744285133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJiPGMS/ezMF5hUTLHHBE+eQxT1L7eRi92q9CWbEi/g=;
 b=mm5WbfHh5fkqG2TA6JpOZlmMR2OH9D224u/gbjkQ2NlLmWe7PIV77hwQfU6TZ+H+Rk
 XP/5vOV8ULW0+38FdobhOvsJNeXpfBOBDKXp+gIMW3k+CjXZuOS7630B4YG7hElgD6g3
 LRVquxJvOX0017aKtNZiGssA+rem38Q8u/8mBXBsTa780VLVHxnS1+yfvObs/HhYI0GV
 MAIT5SQ12UDngMnaarAwY+EpZiMBAFJlRzHjboUX+qzL9o3a4TFJqd8/0veLpCkwDZlI
 Rtu2GZ2005zv6/u8zfbqfLlL2n4bUJ1ZKHDoJ01U9+OVH8Ng9W6sIUVPY2/jdFZaqRpu
 rMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743680333; x=1744285133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJiPGMS/ezMF5hUTLHHBE+eQxT1L7eRi92q9CWbEi/g=;
 b=cb1Gn/OZiR0EVjNAWquIAGJ00GjbQOW5xxfhfFOtY6Y0Kznkl0kysxlnQYfFkTl0vY
 Rd2SANDFzjtrcA8Xfw4ND+4Cm0IQLF7Jc0hIN/5shpHwX8RAsCdpuBplL9brzF9jRZWZ
 dFXMHGzz6vfX++JPPTn/9nigXVNcZgNwwRuroAlJE7CLXPhguwRJs/b+JLA4PwNcZ6zi
 fKwC+eymYowGuqqkT6uFQcC8zwI//4clF83jjsxiyJ6U4gifRuFO4zIrasgP4j5OtOCn
 OrofARobdGM3qoINhFWsICrglQmMNAjySuIschwJVG8SRWbP4b55ZXhSg8bliPo+DdLK
 xECA==
X-Gm-Message-State: AOJu0YwkEM2LkqQGNtbv3Yk/ZFSk+6lyyrqg1CdZBjrCQ+Tx/swKvTCE
 B4z+nWH6/INKF8m+TixhudqRndriPwPDuFKP9ejlNXfvNQ0jZT2vngCaWjea/9U=
X-Gm-Gg: ASbGncubI1ncp18X4yNfkB11aDBhtY+lT+opNzKVq4c2YiBwalQverPJejQXHGs0iBj
 iMVDQTByVikWhhmVQbUSqCZUT/3xBQ9ryO46WG/DZvascRm27dRTtVe25y1sKGIXUYDPQTDbeUP
 TanhPIjNrjxLM8k+CEWTGhO8zdm5hTdzzOMCmChW7ODmGaoPUmGzRCZYeRFw3EvoGYypJX01lsY
 Y+o/vs7MTtnUeD4MeBl2lXM0glrkOZMZi5LwnnQXYpla3ZUQ9D/DSDteTUMuGjHfgzoGElDVStp
 kvPqLv4HMFMQFUtBIn0nS9E3J2j4DMS/YLMbEqIE4IhRI7M=
X-Google-Smtp-Source: AGHT+IGJVmFKY9ybOm1KpEUjlthyw1ywJubaHPFDKABCa5bAcmTly3OR3DairGNwsDmiuWdFjtjb8w==
X-Received: by 2002:a17:906:d550:b0:ac2:2ba5:5471 with SMTP id
 a640c23a62f3a-ac7c091daa7mr143720866b.24.1743680333174; 
 Thu, 03 Apr 2025 04:38:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c0186973sm78626366b.154.2025.04.03.04.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 04:38:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 800995F901;
 Thu,  3 Apr 2025 12:38:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 1/2] accel/tcg: add get_virtual_clock for TCG
Date: Thu,  3 Apr 2025 12:38:50 +0100
Message-Id: <20250403113851.4182190-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403113851.4182190-1-alex.bennee@linaro.org>
References: <20250403113851.4182190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Rather than allowing cpus_get_virtual_clock() to fall through to
cpu_get_clock() introduce a TCG handler so it can make a decision
about what time it is.

Initially this just calls cpu_get_clock() as before but this will
change in later commits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index d9b662efe3..1432d1c5b1 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -197,6 +197,11 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 
+static int64_t tcg_get_virtual_clock(void)
+{
+    return cpu_get_clock();
+}
+
 static void tcg_accel_ops_init(AccelOpsClass *ops)
 {
     if (qemu_tcg_mttcg_enabled()) {
@@ -212,6 +217,7 @@ static void tcg_accel_ops_init(AccelOpsClass *ops)
             ops->get_virtual_clock = icount_get;
             ops->get_elapsed_ticks = icount_get;
         } else {
+            ops->get_virtual_clock = tcg_get_virtual_clock;
             ops->handle_interrupt = tcg_handle_interrupt;
         }
     }
-- 
2.39.5


