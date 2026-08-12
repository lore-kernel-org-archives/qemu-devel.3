Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B670C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFon-0003bb-SN; Wed, 12 Aug 2026 16:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFob-0003US-GP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:46 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoa-0002Ev-4L
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cbeeaac53a9so871381a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567483; x=1787172283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p/0NSBkDolnRnDgnN31JqXgc+8uH1xvhnMEkNLiV4BQ=;
 b=JT9/SbhP0bYmM7THsxS5GeDt3OPjb7BG5trC8z070oucCv7hN/+q6XTQsM/+3DzyHQ
 lE282RmHqkAFCMKfVHgcE2HsuL8WTvSgFiioVuLNydvue7fQVoXVNfPLTms8Ks7duUtU
 wIkyTX8lsIdGR3vvPNI69Z8Ivbyq/aWvLDVqaQPnelbMyFbQ+TQ6CNw3qsCUO1n7nHJz
 DQ1s9fu11YBdFy/CwlU3U3SPMQG0pgsGnmleKpL2Ob9H2s/0OPaiegdRFLVLdpB2uyFt
 Gh3IJg2sAUwMwFdd8HBScJiJT/quum6xyuEMjXWe26K/ASW1rdTi1ApFV7jLWIq5AKzo
 /CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567483; x=1787172283;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p/0NSBkDolnRnDgnN31JqXgc+8uH1xvhnMEkNLiV4BQ=;
 b=nj1F/WHuNQejLYoopEGl0GRnF94uFVrHYqRO7+PC2XzvZAJrx8/lTBgQMpqFAX0QkP
 rAYL5uS8XPpl92mdfofuf/WqQGtaBKr5EhrJYIowfG3n78TDY1konaVxI4xTLfNKDGNe
 DjUW7xWTKkALwgDeKIWxZTSddwnknNKI3MZnd9F8nrURfv0fgFHsV6G079RFBR97h4xt
 vTyMXtdQrbYmRv4V3g3tO6Pgm5rcSYlRd7ABgiT32tpe/Idq7MF2m5oBfG3VhKQO/1o0
 lUV3L9PqL1Jys2qpubsj5DBBRa53H7FH+tDiN8GlPpzRWn080zFZ2VGx23L9nxzNrXzT
 eQOw==
X-Gm-Message-State: AOJu0YxvjCkMMHISwLfJsad2RJY+nGugoTa7MmnD0D9/71hkZ89dWINa
 IW7Sq0CJUijyAzLfYalR3/R4YGewlPVXKr79tgn89gmzDXVf0mAwOdbDYXMtz99xXPvZUyqe9rC
 SYQDz
X-Gm-Gg: AR+sD11J4GvVd8iHmOPJe6OxjVUjZng6Piy0LwEGndorKvGm61UXxirjH2jleigUG4/
 6uFLny3ReJmg00dyKuif11qzchf6yFPTukvVaJfd8T+k9Jsxp5jXih+1GQMSJEiRlYbc4CfnyB+
 xesy8ltsD9i4IITPG9VBSg0z3qfKwhcOKbowxg8qw3cEl9C9HQktUb/Y+lVcINTIYSej5LTyrnL
 l4WU/mPSMSv+FwkRe5OJ9jgJMQvPlwMQNO2xnSwc59Yam6s3/B8icJOW2xTUJ/wGqpqQ9N+zWpd
 2C68zcc0f6QRGepYmNxDo2hWLH+T3d6dqvqkz93Mvq2BrMstQKRoLrajolipheC1IdfLfLfx/dN
 anPwxVTJh6Z/sXlPPhCThExY2qQBcNgtRmJl0TFbeyIsaHqg69nkxAoV3e6+6Rdex+UBneVs5zH
 N4+xzUT9gEzysvEtGQ3PpelowmF4anz5kx8jfK2jb9OqbT9ipZiDMwcqNS9aaWCIcqVqw5ViPTc
 lkY30t3+Wj4x19Luf11
X-Received: by 2002:a05:6a00:3923:b0:84a:2c46:3fdb with SMTP id
 d2e1a72fcca58-84fc6d3f40fmr574403b3a.5.1786567482578; 
 Wed, 12 Aug 2026 13:44:42 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 04/10] target/arm: Sink aarch64_aa32_a57_init into
 aarch64_max_tcg_initfn
Date: Wed, 12 Aug 2026 13:44:29 -0700
Message-ID: <20260812204435.295067-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
References: <20260812204435.295067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-max.c   | 2 +-
 target/arm/tcg/cpu64.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index edb5b9e6c3..93f24114a5 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -206,8 +206,8 @@ static void cpu_max_initfn(Object *obj)
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_aa32_a57_init(cpu, aarch64_enabled);
         if (!aarch64_enabled) {
+            aarch64_aa32_a57_init(cpu, false);
             aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
             /*
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 24f34947ec..5649b853a7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,6 +1167,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    aarch64_aa32_a57_init(cpu, true);
+
     SET_IDREG(isar, CLIDR, 0x8200123);
     /* 64KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
-- 
2.43.0


