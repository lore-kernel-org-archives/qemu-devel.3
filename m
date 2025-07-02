Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927C6C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hV-0008Eg-EI; Wed, 02 Jul 2025 15:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hR-00083H-IY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hL-0003ba-Ca
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso4090564f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482845; x=1752087645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYnKEElTC5IwOmZPbnF1VDHeVLYo+K3YiqWHHRzMLu0=;
 b=aKBHvSxnZ4xMgBfm0aP4GgvHbuqE1AGVNE2e25MJ8kfxIwnVZK59dC+0zlh6pBILk6
 w8TBdhn+13G79PQhghNURrG9YWCgA/Th1yjelmdL98gIuOR6RuHAiDZk6TsSp0FwiOi3
 9z+nLhE6/88/KLMXNYvE6K9XUinPGAT+8L420hQ9GMP3Om5GmMKXw5+oS0MqkWL64Gyb
 l7cGXN5eMd+DeFpWl8IYD0hmz4XfFxG7emv3e0EiWKScbPSNyhyKEf4cc486wm7nEQog
 RewophVvFSA/0n6PF8L75rTf5ngKS0I7gXtdsKjQmB5XpRLZd9IAwAaPfJ/1vMHC4x4h
 PnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482845; x=1752087645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYnKEElTC5IwOmZPbnF1VDHeVLYo+K3YiqWHHRzMLu0=;
 b=SAO/i0UrUQxJ/GsPo6Z6Ngip/lPHjoy+7w1fFy8WI5Ovli21nCzaiiEEiF6SShp/xj
 77jIYSwjdaMgUjL8vGMIYTbostCc9K7+0oFiFbqbN0A6siWWomXcMfhLc55acE3mqvcA
 T7Q4y0XZPrX7nU2mmvaWrLWB37rDumIZz5QSTexd1yBiJM/o72hXHdoQbj/viyb+8KuQ
 KvEwb5KTyW1+CrAJ1+rM0i2XzHwo9OwhuFP9I5cejI7H+h5l46v7oct6u7mvDG96KZs1
 qA3Faw9bC0IRwCCPDOzRF7aPxCUvuD/8Edwi8cQzIxJEd4VL4SLJanvwP6I564cZgF/M
 9isg==
X-Gm-Message-State: AOJu0Ywwh1thJ1CqPCadvON5zcNyXM27iF+alp1iS5wEwL89GqpwWfW+
 G8GZClYxECTKp/PvPcoTW+mMHsIkoVab/nRzzmoFOMnVj8RDmTVGzwaZdgGSATYWZ/pqfPH6NRY
 vh181
X-Gm-Gg: ASbGncsotsT6jR82jBZc7far4TI9UgvWN6YyLJlx+dTt8BCF0U2uTMmyz34+GTbi0Rm
 Til23/+tOinvtWud82tlQT3Xcw0OqUr8M2f1PZTXQfBd2TxzRy+AzKG8a2XC2pWSAvTtNiyFEyc
 aATxz9Ib/3xaHRPHe25Gv5yR6xld+L+G6RCtVnB8waokBIWMG9GYwGa5aVIPU5kpb49muwzxehx
 xluRtwhrgKVCfNg5NgrhuGqYhVRMvfU6Exq0DukfUNYtHg0Qeo81lvahKsaJZ1Ll327bYCN7Y/a
 9ApCZqR3k/E3U0phMXrW+KK5pWq82cOxRkVJSrKWflGrNziaOXRbrIP/U77wozEkGd0LI2epJ6J
 kK/5dUgVRbzl3lsLLbIeZsrlbas47MbJr4ICi
X-Google-Smtp-Source: AGHT+IGKS+fDIJupo/KC1RryZ5jJ3g7nFOzKnC1CQOMqfMNU0PCTbPY7XIRhZuUQGX35tmNF81IYig==
X-Received: by 2002:a05:6000:310b:b0:3a6:e2d5:f14c with SMTP id
 ffacd0b85a97d-3b20048e696mr2986640f8f.30.1751482845129; 
 Wed, 02 Jul 2025 12:00:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcf35csm5521045e9.20.2025.07.02.12.00.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 64/65] accel/tcg: Clear exit_request once in tcg_cpu_exec()
Date: Wed,  2 Jul 2025 20:53:26 +0200
Message-ID: <20250702185332.43650-65-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 1 -
 accel/tcg/tcg-accel-ops.c       | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 6f2a992efad..543c4effa0e 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -112,7 +112,6 @@ void *mttcg_cpu_thread_routine(void *arg)
             }
         }
 
-        qatomic_set_mb(&cpu->exit_request, 0);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6823f31d8ad..c5784f420f0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -96,6 +96,9 @@ int tcg_cpu_exec(CPUState *cpu)
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
+
+    qatomic_set_mb(&cpu->exit_request, 0);
+
     return ret;
 }
 
-- 
2.49.0


