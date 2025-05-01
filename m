Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D82C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLm-0005j8-62; Thu, 01 May 2025 02:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0005EV-Sr
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLA-0007FY-Rz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso542066b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080647; x=1746685447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qzuf536sTBCPBJh4XYxjRVhgJRgFP2T69wvlX9E/0Ys=;
 b=CHnmYtKP/Am1tFzFLaYs6e1cfgD8U0qcq0S67MDsiHje7QNtxx1vL/+apssnYksKD/
 B/59VLLZzTbptwb2axw09ri6Ayqr80ycViMqupaBsZ8G4xunNU9W5SRsD2K1vXShSxaF
 xdHFytLOmmF/K/ylNQbBOvbGazDGs6OawSRIDpvqws0LUHSBhj/62piK0lxyH/a/jpfR
 lkSFeqM5rpIzFYmh3KPlXkGSz3La3H4S4nbE6djN7S7QyO+CO97J9U7OTpcrm8WZs+AT
 57CitH8GRWaxGpDXHwHxoQ5kgOHhg/gMQwoBRprlB2dwqjTaw5vai7zVCDf9gT+LLtgY
 48cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080647; x=1746685447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qzuf536sTBCPBJh4XYxjRVhgJRgFP2T69wvlX9E/0Ys=;
 b=twgkT3h7F/pDfPzOqcSKQXFXH2C95IlqLqU8lcSYLUqPDDhdmr2/v/oxo0JF2I7KiG
 xAWIUVgZb8ASMI313FuT7kFe6jeMmQxL6oo9PdRwhujXcRE3TWl3Gm9+LrT4KZAkbvH5
 2S+RhTNvD+MZcTgwTJQ3OQkfzS6ylZxA2vJ5doGOTeFil1OjhHK9ew1M99D2yV9f1Emh
 UWByf6ZfPZ8MLtdXiabw3aeF90i1B2KdgIanWZCmj4ghxG5X1+AqTV+JIFz1XzAr5JqB
 SAVj51mwi48wsvVGvhuQYtlxFon58PQndtgKSOzNvqif+bsXzR4ECGsNOrN8u0zSe5ft
 pplQ==
X-Gm-Message-State: AOJu0Yw+XlL8fedjzpDQ0ACzsIobsKshlMRhBSPNx/jQihoxCKyjs+yY
 LgsbsWWtDTXTl3cm0wA1EaTwU1iKllu+2ec0e3Ycd+h4Uo1AU/DBQuTrFNOd+MnTDl1unqRSH9q
 H
X-Gm-Gg: ASbGncsWud5klGluB9wnxpob8DJopveoYAzRJd1yBFJXuNc1/+54rLDmFw6WgcnIdP5
 2FraB4a0y9T9j12f6xs3qB7NIVlSKS3gBePXUgnJFHZv3qunAgwaTInSjzafLP7ofb7XmMJsWMS
 m/Di3/eg1t4qSXpWahIXEybM0Q+RlJx8VjiXGRqWrD9Xhj3VgS2mtmqq8tFsYoYIoviREgxw8fk
 lJc2FdXeIFX7PP9Zc9Y6b0aI2Kq8evEd2P3NARvR7npE0zQE0A/BLa2EsMIzoTB8lgMZHJEU4+S
 07IM9F7RjqRPKakWQAm4b2mxv7dFZGTp1Ix7RmN/
X-Google-Smtp-Source: AGHT+IH60rvhXzsLotyuJD4D+gAsur7uGwYqaWIbCE5FyrkEs2z+VtwB0w2/b05zf6FPVjJahWsiMA==
X-Received: by 2002:a05:6a00:38c9:b0:73e:356:98b0 with SMTP id
 d2e1a72fcca58-7404923d1d4mr1814773b3a.8.1746080647585; 
 Wed, 30 Apr 2025 23:24:07 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 18/33] target/arm/debug_helper: compile file twice (user,
 system)
Date: Wed, 30 Apr 2025 23:23:29 -0700
Message-ID: <20250501062344.2526061-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index de214fe5d56..48a6bf59353 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
   'vfp_fpscr.c',
@@ -29,11 +28,18 @@ arm_system_ss.add(files(
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
+  'cpu32-stubs.c',
+))
+arm_user_ss.add(files(
+  'debug_helper.c',
+))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(files(
+  'debug_helper.c',
+))
 
 subdir('hvf')
 
-- 
2.47.2


