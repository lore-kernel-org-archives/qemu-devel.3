Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877B9D0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L43-0004Fb-2f; Fri, 25 Oct 2024 10:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3z-0004C3-Np
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3r-0007qa-TS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso20415545e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865586; x=1730470386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjOM3QYK37qULOvoMpKikOAGRTQIulU/PhbW7+12E+A=;
 b=CLdBiU/1Fe8HGeL5xo32mAHXZwY5KCAkRLjHEkm3BRA+m/gnZH6OHrvtNw7cziYpaV
 b0cp29vrbJL8opXePKe9Fsqy20IZpfaGVEh8Sosq/1fBUW+Mrrds6xLlARLRBlDFht8k
 LW/2kU35JWF4kHP6tpf4cFzCUlFuGZMCMJfINohy8W18Ry5NBbhJuzpipdgcQW3BPdoP
 uzFxmaPHwuiHNEQjVyUhdQ7OPjS14voWjtPZOMMkX6ZPM4Y/fYMw+2IyaRy2TCiVCUSb
 +EHo2chM0Paf9j1pJbx63PPimIkkwzi6l7Wu2mRGoIpvFonGSbSRnaKb5H2uU/BkXj4z
 fpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865586; x=1730470386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjOM3QYK37qULOvoMpKikOAGRTQIulU/PhbW7+12E+A=;
 b=OiDYAz7qfheGe/MialAtHQN5Z3oQIRM42B2Qd1zPYg9E85AhBASCEWccyXvchpVxFR
 EsqEYr6M9m+ZgGh2c8PdfrV/smAay8tJ5cSNn6j9L9O5MW4FTyz6GTEwSTFBLgKOq3Hp
 D+s934GE9pcJZ9nK98DyMKekQ/yhBYVTxs+4PKfP+tDYPjbcwv9i3ADqLpJyRyJjP+m8
 G/jrN80OYphzA3daWc+nZUzYNtPC4foHK90J2gjlwoMizqUgkZrdOnaQScG4VL6bG3cY
 2t5pFBg5YhAQwpstgpnCVAMQ2LQlionQO02eESHdISr/tqKMMdjsi8wjmBVH65SzXEwn
 NWdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+PCrGbRhb6/SU/oyXd3jdEgBCjOer0liX/AvZmr70u+kJtaDBf108U83I+XLu4JpU4p/ACpe1sHAQ@nongnu.org
X-Gm-Message-State: AOJu0Yy3pifFiUffbmSPimsgarB/OV2JGhoFZKAoBvTfr8dmarvwxu7l
 c9xSu3hNdY9PkNlVHITmQxYrPFShSOIJ7u8jh3hKZm/VSIOXZWrNOQ92T7uB/zs=
X-Google-Smtp-Source: AGHT+IElcpmJ1LU46tPdnbNHuTc3BFBmHYJc+kaPi4JdihFLfSRZx1lONZoPeZB6hUVJoUrQ/Pjf/w==
X-Received: by 2002:a05:600c:5118:b0:431:3a6d:b84a with SMTP id
 5b1f17b1804b1-431841e12cdmr75651695e9.4.1729865585974; 
 Fri, 25 Oct 2024 07:13:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 11/21] target/sparc: Move cpu_put_fsr(env, 0) call to reset
Date: Fri, 25 Oct 2024 15:12:44 +0100
Message-Id: <20241025141254.2141506-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Currently we call cpu_put_fsr(0) in sparc_cpu_realizefn(), which
initializes various fields in the CPU struct:
 * fsr_cexc_ftt
 * fcc[]
 * fsr_qne
 * fsr
It also sets the rounding mode in env->fp_status.

This is largely pointless, because when we later reset the CPU
this will zero out all the fields up until the "end_reset_fields"
label, which includes all of these (but not fp_status!)

Move the cpu_put_fsr(env, 0) call to reset, because that expresses
the logical requirement: we want to reset FSR to 0 on every reset.
This isn't a behaviour change because the fields are all zero anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 54cb269e0af..e7f4068a162 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -76,6 +76,7 @@ static void sparc_cpu_reset_hold(Object *obj, ResetType type)
     env->npc = env->pc + 4;
 #endif
     env->cache_control = 0;
+    cpu_put_fsr(env, 0);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -805,7 +806,6 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     env->version |= env->def.maxtl << 8;
     env->version |= env->def.nwindows - 1;
 #endif
-    cpu_put_fsr(env, 0);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
-- 
2.34.1


