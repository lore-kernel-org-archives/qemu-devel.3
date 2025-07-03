Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EA6C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHeb-00064e-LF; Thu, 03 Jul 2025 06:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcu-0004Rj-Dy
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcm-0001WV-9y
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4537fdec39fso18651445e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540221; x=1752145021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEXuTiZx4NBtgct91pluD9hB6GRxEbVAf5qByawcXe8=;
 b=xz31EHxbh5ik0H98EZCo1nKCnXESKjyCuZNzgvYzk3EZnlc8l79KtjlGtUuNtjhaLs
 6p96/un03IqnWule5vbP8s54Ps3jcbjckFrbBbjqJ0iXLjk4iVHHViHz4lCoT4W3cseh
 8j8edEDfbCnZmz0Sd5mCKGImxqFq1j6uct4g5g4BVOrLUWIZqX6d/9bdbbUzmrBVfU1B
 E/x9OHo69mwZx5nDJ4dTLcKAMZfhXJUw2YHkbBIRsI3a29eRh1klVdMhli75wUsHzJ2N
 hgI8Tn1BkXjPWMhlCHLn6lHUONZEWsJeyCePntMTMHvKhjuhCtbUztoylVEh+vmToK1I
 ap4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540221; x=1752145021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEXuTiZx4NBtgct91pluD9hB6GRxEbVAf5qByawcXe8=;
 b=ZeBf11bc8mjcv61AqpaqjXakIcg9NDeg5yjGYPv34pay9qT+ozYSP13ktKqAWf/z+/
 zOGEENz1uG4bpuiirqtiopfVi3HkuXbriHr1vUP2jcjHsOr8VqRERtmPLziBFZ2ApUKW
 2bwH59nQod02V6GtsciBT2A4KN7BNeHYfv39G1HCJU23/HyQOZpAvVcwAkPi74LUwjs4
 DFFvJSk5/+ffbOmBmdRwA4ICZZH8VMSmHSDCvnNtL6dyqmA2wLnOEu0f1bWntNoT5LYI
 QCMMSe1B1uCY2QTQkOk8YrSHG2hHJSixftAYtbW4dptdxwjUv6L9eXH1QbpldR+bNk0D
 IDLw==
X-Gm-Message-State: AOJu0Yz7AQYXL/0kHvcU952VjtLoupJ9+k0JLwbql9WXM0TChil8SVLl
 6CK5+fF+SVPwQ+TEkgvTxxMCg7KRCvVTQL4TDH8NyDcdFR0gUXQpVJIBF35dd6cyODneIy+RTKu
 qdtHNPg0=
X-Gm-Gg: ASbGnctN2KqmP4gIZsQ2FJes072YNKbQ/wa9zI8pGj7MNmMYjYfUaDxmqCGrOFRIG2g
 TKf+/8ZwpRUFxCsXDoMeseW676IOiN5wewNVDOoj6x5SxuLWOsDQR+tRUvvn6xHiLHmMMfc0Jk0
 47j/13UNdmPTnLRqqulplFjBHaRdMHXJzsXBE198SqD9REEbRet5gJ7EPq2Qe1uaIMMA/iAfZ4T
 ng6xbXZqWLtIgMbv9cXnOisJOmErLq1KToZKUGIo+KCPP0fxtrTPXJTFrE4woIN9BdXO8G2stKy
 c2cndfvoqg1QhBILryKorqHsKg1+xNVfuHQRHE5Kkbj303Pq+Nr6IbdTJ9RlcrSKWwFVpNtlEqY
 hu8T5+7DsdgQ=
X-Google-Smtp-Source: AGHT+IFNM5ZpiX2WKqQdPL7BOWUOxixS1vmuU5TwVG3w0N1duZ8jC9VD+EDPeCfYp4SAphhNgUesZw==
X-Received: by 2002:a05:6000:2307:b0:3b3:bd27:f2ab with SMTP id
 ffacd0b85a97d-3b3bd27faa0mr1140102f8f.5.1751540221194; 
 Thu, 03 Jul 2025 03:57:01 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454aa3d7455sm20870755e9.5.2025.07.03.03.57.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 15/69] accel/kvm: Directly pass KVMState argument to
 do_kvm_create_vm()
Date: Thu,  3 Jul 2025 12:54:41 +0200
Message-ID: <20250703105540.67664-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f641de34646..6f6f9ef69ba 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2470,13 +2470,10 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
-static int do_kvm_create_vm(MachineState *ms, int type)
+static int do_kvm_create_vm(KVMState *s, int type)
 {
-    KVMState *s;
     int ret;
 
-    s = KVM_STATE(ms->accelerator);
-
     do {
         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
     } while (ret == -EINTR);
@@ -2646,7 +2643,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         goto err;
     }
 
-    ret = do_kvm_create_vm(ms, type);
+    ret = do_kvm_create_vm(s, type);
     if (ret < 0) {
         goto err;
     }
-- 
2.49.0


