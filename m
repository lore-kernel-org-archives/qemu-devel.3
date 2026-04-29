Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7943FFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPj-0006QF-AB; Wed, 29 Apr 2026 18:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPh-0006Ae-OM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:49 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPg-0006zk-70
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3591cc98871so90369a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501787; x=1778106587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2roCwG75BquZDnWViQHPJm30lO+W7aYvtS/TzZxQLk=;
 b=CT61HPaswsjubxmt27yUZ+P4hf6YHZZ5Dja7F8M9maJPyN8yK5Eq0+C20JzCVMs1Gh
 pTmlKtd1qRlTsDnL0Wy8mHEXGKIte7E46FhbXCLFfgITRq0d7BFdiaPJOh5IqGuuEDmV
 wYGO1YZixJckN97AN+78xePUS88eKE/kqndEkZY7O+AqV4VoZE3TqvkmtJyyJvNTTTVk
 qmQkp36XHlWk6BHzrI+bGh236ICe0t9n1qf8N664weq5B++81nJFz6gb2z468s+0k2C4
 KT5lgS2nPu7tUAS2Yyj5iYAg3oALFIsYz2AeDxhp+MUBBgZ1HMZl+0mU4VxGRGDS+CrM
 qsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501787; x=1778106587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i2roCwG75BquZDnWViQHPJm30lO+W7aYvtS/TzZxQLk=;
 b=ZReIQ23qlagTd02zgFLRO0K8JTCiYMn7LdX3klKzUoO4PHyjKMKuyTrft0f72gqlrj
 4fBtSJqGmSeMsO1RWD3tNCN4PG4HQC6o9lREVh6f3LJLGQD53YgtjsrfHagBrm0NkP1b
 ojozGK5iZdmAyyqUvBeJ1SOwLEdONmkSzK3qOnd5tbaaEiFkbiZ4NfvXm4/1S4/D94vf
 IGXMjv5Uc6jZgbohU4gk0yOXX0vREgbu3SX81Tv6vlrV9GXc1A5ItAlQus15rZTSMZfa
 42cEKDtUHTKjOwOdff7VlKusHp7dFpQgMIsBFiDT8PED1gdQx383qigT2+igNFBuE2ii
 JSpw==
X-Gm-Message-State: AOJu0YwDEh8z2IFB2VKD/Lv+XAPfzh062Q+eDm+roFmbkTzVJpbHORZZ
 mp9NzjhgVuZBeB0ev+dKapsvfctol5wXLYU/DvPqqq1Jt9T1OvL+/WLmpSUtRxnCPkDMGBuPCvc
 tzmv3L6A=
X-Gm-Gg: AeBDiet0yxq7r4MAsGs0U8pg8PrexDxxJUru8UW8oejtXxaqczNF4lPOz9KV2BUrqiY
 U6WAcCAl7fQ8mGbe+v7JnI65zDTnH4QlVtWupqZPv5rc2FtJrZKypwNi395ohH/68hWZVM9G8BN
 993rb3YXmNm49jlIUjPCWBgycpeMqS+1Q7CGA/xjooU4xF7xntYbuL9fGFa5RnMIG5k3AfZvMdg
 ryRMeouoB3t4vAGUqp5j3H/ASdAI7UpF9gNPVW13acqATwUCFIs6M3mQxbGZoO+Xb0FWuond25b
 oDlodXBsVpmQ6JNw+10W0cx8VHZBktBdByEWZwwgZHfCyUqHI4PjKxDuZ+POV0o2TABkezPji+z
 jfcj4M7RS6wupPp8cub981zZUPR1rVkci831idlQFgQx2XENBfBW1Hq858c1XqK5mV8pojxe9YQ
 usSLYjeVTeTAp+R651QysMB/BE5ReKfkJhdR6OboK6
X-Received: by 2002:a17:90b:3812:b0:35f:b5df:448 with SMTP id
 98e67ed59e1d1-364c30ed945mr173316a91.24.1777501786792; 
 Wed, 29 Apr 2026 15:29:46 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/48] fpu: Inline floatx80_unpack_raw into only caller
Date: Thu, 30 Apr 2026 08:24:41 +1000
Message-ID: <20260429222445.26301-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b3208c1891..5412fd0360 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,16 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
-{
-    *p = (FloatParts128) {
-        .cls = float_class_unclassified,
-        .sign = extract32(f.high, 15, 1),
-        .exp = extract32(f.high, 0, 15),
-        .frac_hi = f.low
-    };
-}
-
 static void QEMU_FLATTEN float128_unpack_raw(FloatParts128 *p, float128 f)
 {
     const int f_size = float128_params.frac_size - 64;
@@ -1626,7 +1616,12 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
         return false;
     }
 
-    floatx80_unpack_raw(p, f);
+    *p = (FloatParts128) {
+        .cls = float_class_unclassified,
+        .sign = extract32(f.high, 15, 1),
+        .exp = extract32(f.high, 0, 15),
+        .frac_hi = f.low
+    };
 
     if (likely(p->exp != floatx80_params[floatx80_precision_x].exp_max)) {
         parts128_canonicalize(p, s, &floatx80_params[floatx80_precision_x]);
-- 
2.43.0


