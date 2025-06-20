Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8F7C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfM9-0003hN-Oa; Fri, 20 Jun 2025 13:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfL5-000205-R8
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfL4-0004XY-BV
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso23782445e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439740; x=1751044540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVr4JXpO/vEaM8nZYk1gjf3yGhaUhPxgdusdwabzBq4=;
 b=VRhDE+G8ihCQYuk7PBr8g7YXhGLBjpWXs5YBKqTU5ELo8Bfb5J7nX5UCr94guNeC1R
 PAiGhDzCm1proU9fhmJrJ09y4I+01VxXIQ2AagPtIgHdztjlmuRSEA+qYcsLshTdoW4I
 N0mp4ONLorh6reww2J42upBw+BdyjOij7M7WFop5Mro5XWg9Ow4RBQlSailmu5U3CqGe
 qI3oqYqEGWmfXk648zhRXa9JnKQ8Wvsj8VArnuQZwfX32XESGWz8I5fYC1ancAX7cGja
 gULXCTNobt0kb1CvO0HKAoBPD5k9GeK3bpa/Q0iZgBnCXH2BO/NHmIDsvld7BOuzo5f9
 A9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439740; x=1751044540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVr4JXpO/vEaM8nZYk1gjf3yGhaUhPxgdusdwabzBq4=;
 b=btKsJGIlb9hlGx/7FufDhFUxpx8Iw0XpHtpHUYjGfxv++VFsFXmovs4Ut+jz/0Y41d
 vAT3BXZZG+Gqn9pCNIYb7PrSvShwW+Tp7JWcbvgnHORwnnok0qArsG7K7RY+cR0YsaDR
 66k4AY6UrjsC3+uqzzLrlJCDbLza0MsiSi0J7LK5ArF+NiwoPeCIzPGDsV5+40JdSfPs
 vckhD0qhRmiE6qxWdvRRQiRfdJgtqtlmRxh6sZWXsUx7NqupuSoFH64i3H4mzP9AenFu
 QAk4YkGhHW77EdXlauRXyedh/xvBfJj/ZQFJ4tLOkqwGnSUwbBzynjHplCsk3kbJJPXR
 TePA==
X-Gm-Message-State: AOJu0YwOglZwE2vCd+MGjIJ43VCTm8D1+RhLlfTBzKwLtIZltp7Qo1Ie
 7+vuCJNBNUe0xLmpwjLhICOMqokW6POLKVS5TtGbn8Da/4bt7f3qPUOG7i0qJNS3Cw2PxBpf9r7
 5q8ABN1s=
X-Gm-Gg: ASbGncsFQGN78YtOOxy22oNB0gvm1b+KDxOwKHKm0Iq7nMLBLf6H5ygE7hea6nRJV3/
 uYNr3lILx9SiihXgnsNzIU2TOSB6LTiWHbBazLEgEst+KAlR/1w+9ly4T1et3HexbLDBqKc0q4v
 bI2oFu9adlC66p+ITrckeH6Fk0TW+N01SfEYQe/PwAViOQop9OnrkZTwv84ZBwThqI/jIKpxvIR
 zpDBEQ1p1OEtIZkgt7EE8ZLP6XE/WnQybzLQaUNq3pd1GZB0wYAjzTbVvyiq+sWbxL0uWOGa1jA
 vp3o5pbCkh9XdrqnVI/9JzQIRJdxcFXL3yLV1r4dpRApg5+QBJdm9FXcjoP+tHOCgF2BiybVG/4
 Hv8Zup1E/gSd3Tt+UzEGjw9hXlxhPsdPbByrA
X-Google-Smtp-Source: AGHT+IEnE3Yx+p465LBDZot+TE7Xg3xVftRKi5tB8eds0huwtSg58aQGuZkHqo1AEmjUDISEADdFvw==
X-Received: by 2002:a05:600c:1c98:b0:450:cf00:20f5 with SMTP id
 5b1f17b1804b1-45367067893mr33800055e9.9.1750439740492; 
 Fri, 20 Jun 2025 10:15:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8edbsm65058695e9.24.2025.06.20.10.15.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 24/48] accel/kvm: Remove kvm_cpu_synchronize_state()
 stub
Date: Fri, 20 Jun 2025 19:13:17 +0200
Message-ID: <20250620171342.92678-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_cpu_synchronize_state() stub is not
necessary.

Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/stubs/kvm-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b9b4427c919..68cd33ba973 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
 
-void kvm_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
 bool kvm_has_sync_mmu(void)
 {
     return false;
-- 
2.49.0


