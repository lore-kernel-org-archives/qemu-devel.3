Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C593C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4p-0001Rd-Sp; Fri, 20 Jun 2025 18:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZ9-0007QM-9v
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZ6-0006Fc-Nh
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so23696445e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440611; x=1751045411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x26Ja5RQCnAY1hEIDv7vNclsw2LYbQKCmLd8vUwxwiU=;
 b=KWEQzTKKVdRyGwKGHAld21qmcTq5QsOe8rCNCI8BLYk1SDBAXuhBkNYPxY7x/CRJEh
 uoBa2Df9hHlbLjRBR0r8Bk0t/fhYDp3h22eIrabd5psFI7GtXe91+TGfA3GDc+XOXNgc
 aJ2L5AUnmacXiDrsN0Iy4ye7toCfzCEKI1roUaDeWeHiseaBpqP36SOoAlmC1DYykECK
 r0yVNcVsK0U2w9sY2tIe/zarl/VDHcim5R3b4liTF9/FU5NwTu4H/nE2+yl0mAILz+c2
 G5l/04v80F/Ln4Whko7RZ3YOLY79Yzp70n/UmzTBD8Dtm7zYU2syWVLEQLJ4hgqE+7bK
 DQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440611; x=1751045411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x26Ja5RQCnAY1hEIDv7vNclsw2LYbQKCmLd8vUwxwiU=;
 b=lsr/aVhsA0DFnIcngbK4SbchqF1ZG+xzcPHqzHL2+HO5idWKa5wVsVBOZ3tD31JVOn
 vSi/vk4SjBuGNPSNYjEIEe/cDmLA9v57DWig+GD8T9ta88lkgJgP8HBN5U38w+z5tOxr
 S/WPNQhVxJ2reKXO3t0hBDYlvSK1ulC3KGXot/uX0dMuKEVnn32U9EbNPIQhMbEJKrWR
 X38RzSubEKaRipQsfm1A5tAFu+hcq3on2knO/ljbsvGDkDKjeg9HTQIoNfTh0WcEIutj
 0dO2HPvtMSKb5kL8rwzKh1H9oA2Vyt/wB+pzbF2qLC0Gw0dbSO3LpOxi1fCOdo2+AcuM
 9haw==
X-Gm-Message-State: AOJu0Yykd7c2RYEi0h1WEfo/tlo5HVnGi4NuL5/alT4W4hVFNQLXIS5O
 BRaxGkJdBNLw9kfXoBNHbGHiTkb1TL2RVvI9eMHua/A4Lb6XyyopDW4J6OuGrHqj9n9KRdQl2hT
 nzKCVdizd5w==
X-Gm-Gg: ASbGnctF6RYrEeFu4A6gWMoqHt/p3q4frnia75mEfGkh5zfhCVEFj29snqYJPczPdQr
 3pzwp/h8KE7tiDJYBBYRJjGAOj4JoBgM7H3BIBEILSkM+HoPX7JDBEszypNYWCNuqt97iwsW1TU
 1KmdUCMp5cDnVjyG12TLyuDxUb3AfXkNT1n440uDDfLpcCFVe3agaQuVwTBhgdh+chA+7LphIoH
 vTIKZtXj2p1EYSVi0g6mBMCxyp5vS+f0l4A3lLxU6dRB91/P0PGbBxkzIPK3RcQyh7r47UNFjNw
 LVPKfYb5+6ZyC8CGZNQXQASDbdgSAVYzKTFMBSHRtwX5qVy6hVVW0IbJBeB48tF3aAQec7WzxXR
 l5JTFR++NN8WpYYM4cfVQXjSyEcFMbmJbIQLmFTp/R8JUOI+URkFtLkamKXdjdjFaZ5c=
X-Google-Smtp-Source: AGHT+IEw1dCyAaK8fb6nitxK9mryaq3BMVp8U+UVzkibHfBdCmmuzCjn0eHTWIK3AsKEaabGEvvSLw==
X-Received: by 2002:a05:600c:37c5:b0:453:5c30:a1d0 with SMTP id
 5b1f17b1804b1-453659dcd62mr33154205e9.21.1750440610770; 
 Fri, 20 Jun 2025 10:30:10 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535a14221csm60602445e9.1.2025.06.20.10.30.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:30:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 17/42] accel/split: Implement
 synchronize_post_reset()
Date: Fri, 20 Jun 2025 19:27:25 +0200
Message-ID: <20250620172751.94231-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 accel/split/split-accel-ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 80efbd82091..91ed0af2746 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -146,7 +146,16 @@ static bool split_cpu_thread_is_idle(CPUState *cpu)
 
 static void split_synchronize_post_reset(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    if (hwc->ops->synchronize_post_reset) {
+        hwc->ops->synchronize_post_reset(cpu);
+    }
+    if (swc->ops->synchronize_post_reset) {
+        swc->ops->synchronize_post_reset(cpu);
+    }
 }
 
 static void split_synchronize_post_init(CPUState *cpu)
-- 
2.49.0


