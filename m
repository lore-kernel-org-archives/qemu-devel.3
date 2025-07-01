Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621CDC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcFy-0007dc-65; Tue, 01 Jul 2025 10:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFW-0006PF-Me
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFO-0007Uk-Bn
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so23668355e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381167; x=1751985967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESqa0m55dAereTOYbzJ+agFVvi7g8j2c6XA6BfaEz8Y=;
 b=vlQ3PdE2NT6ynVL1MidJvi+5J3h67vJy3Hu4hkSfcUbtakMCA4iNnHZ3ysUW5O4RRA
 aTJzFbVZQCh9A7i/ausLnsk/GMGGez7RK+8KUEGD0CVh2Ehi/0YRM8yQ1/7Ts1DYamru
 ni79nFymrpf1kCdnIuxmnDpNzi06E7lNcUPXOfcS1UY+VEt60DGJ8UFA+5Iz9Wh97CyG
 55xu4PF3f6LGeeyH776C0IAc4vx9NkPQt6AwtSPdGqJvlRyNNgV0bbyhb5it5O8AKNQv
 hbhp1y06InHJJ9jdjbu0fIHIP4cJfT2erqisda4tEqtwN1yo6TF0jiIk3NtzVPyCgFYN
 F1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381167; x=1751985967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESqa0m55dAereTOYbzJ+agFVvi7g8j2c6XA6BfaEz8Y=;
 b=WflmCWlyVUj5AZRENLbOlAeGvutMcv8xjyF09/WlNXLl1h+5U0hFQYY85JSGcc18FL
 WN0GHWzlIl88CR5koQv2pp6pW89vU96UjMD2eteq1RWtBXnEg5p0IBVm7Ey2yBGVHELa
 2Q8NLX8zm6DBL2g7IT3FP06E0l3SfVTiHm/mDHpPOjoR64oZ0W2SEgXzWbepRdXGihiM
 AYu4AyPVAyleK4wNajlJgDxGzDxKYr5m0ipjsBGEjfXO3H1Fs/FfepxOZ1+imesW9cJv
 ZpF2rRnrKFYk3g3R/scxHlhS5Q+upPs2jUCfmOYYS/XfcNgRjrVxs18hiQk3lZwvBdfV
 9Ydg==
X-Gm-Message-State: AOJu0YzLSpoVA/ZJcBaMhDMPXJqeHFKBJuNCGlK4lPUQUkZ8EhhMbDsx
 8nJoXlejLu+zhG8udEnESR8wwvhXa2zbJHazSbDeS2/63aRLXpjgZfTm0eUUciN7NIY8Qi1cX0N
 oDeUx
X-Gm-Gg: ASbGnct20KJr8wLq3rHTHDCL2Z7f9pMMJV+lObd9FkGKwbFE7XXNejKnAYoVbhbFcgk
 PPOt7ioB5bmWaeDc6gfB3Xigr84wfupsx3E+yZg9R/TnghFMUxnMsIfmpV8OUYUKVnmImHlopoK
 bb0iA/FPxqEY704v1zOEY3gXDaUUZ5DhZDrTz8m38Rt+WEifZEaxVS7Ll1OpsRJvCCjKGWRH68M
 BhoeHYL2RlvdhXEj7iYQ7Vt8b9aOg6j6uhxVTQtouQOJGoDhQXAUI9MDJToZx7iXFcbRlXpwBGI
 gi52U2OvpkmcRui4mJk/PMvzVYQQiTX1MMHUlQmfhT4GjnKjGB1pZ61tbNdk/93rFVlQBhNMSi9
 LYqB2jHrGkIMtwo8NV6WigyX2VHbgcxl1jTQt
X-Google-Smtp-Source: AGHT+IE3HOUctfKi3UZTf9Xa53Ikfd1lVylr/WOxcMKIT9GhD1+lGswS3k8gguuUU2Pb0MyFv3T77Q==
X-Received: by 2002:adf:9cc5:0:b0:3a4:eec5:441c with SMTP id
 ffacd0b85a97d-3a9000a8152mr13081493f8f.47.1751381152233; 
 Tue, 01 Jul 2025 07:45:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e598d2sm13372422f8f.76.2025.07.01.07.45.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:45:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 56/68] accel/tcg: Unregister the RCU before exiting RR
 thread
Date: Tue,  1 Jul 2025 16:40:04 +0200
Message-ID: <20250701144017.43487-57-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Although unreachable, still unregister the RCU before exiting
the thread, as documented in "qemu/rcu.h":

 /*
  * Important !
  *
  * Each thread containing read-side critical sections must be registered
  * with rcu_register_thread() before calling rcu_read_lock().
  * rcu_unregister_thread() should be called before the thread exits.
  */

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 9578bc639cb..57a4bcab203 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -304,6 +304,8 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
+    rcu_unregister_thread();
+
     g_assert_not_reached();
 }
 
-- 
2.49.0


