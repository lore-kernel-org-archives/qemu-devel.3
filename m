Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DFEC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6J-0004Ur-MY; Fri, 20 Jun 2025 18:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZk-0007i0-1i
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfZi-0006Km-Ck
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:30:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1091093f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440648; x=1751045448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt0nkCFYj9QpVrDH90VtFImIXX/zUngmRdbXephHzHM=;
 b=YdLdzcq42/R0YlsAibicWTgi6WO+DmjeifsKzIhqoZBov+x7PV7WQm3PaVmGaZyGMU
 7Pmr1jgCr86jxNE/hkBgqRFC5hKVTtcPncykE3z6NdTkIJhgakT4XBhmgvqTtM2/UZIB
 bQFk874qmI6WC8OOgxx0jAuy2YGZj40FYiStNS1OOn+Kz18OgmaAbEQXMzvb0mAE48JN
 5JN1Xyc6eONZLA2/CT54g+KlsZjRG7n4/EjaaX2bMzWPBqkFsLbJw22hCdbS04aJdI5t
 C7zywoYiFJk/nsvYUC9MGvb6DywL/u3cvzDPiM1K1sCQE18jjud+82GLltO2hKdQJ0g9
 mvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440648; x=1751045448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tt0nkCFYj9QpVrDH90VtFImIXX/zUngmRdbXephHzHM=;
 b=b4ElIwlalaTSHYzcWrNHD+DjeNx6vimFewxTcXmePa0+LUgU5JvFMRjqtdo6zJh9EB
 PLOgdroZpp5tZwDzYptaiYnWv2It/1T0Af1gBAD3uoxtB934ud5HhQTJrZv5gdNwY6Wx
 AaxBDtOPJON+QrSjdPaDtQRNPeZPQHJfDg3KoNBdPjvOnir0+dyK9viLAgFOl7fd4qS/
 EDxZMLabu+PcAFXq+3H8ygKAK63a3ij4LDeYB2r+9k5TvPB2tr/KxTtsh7iLFjvH9gkE
 Fngs1NUNkOSZAqm2ake+GyT52N2uuAgGNCx1jtdZW9ftFOD+rpRoVUzirloRyBrQx9za
 SShg==
X-Gm-Message-State: AOJu0YzvXzFbYHW4HSk8Wzzktyn+Tnrib6ak44LNU44OIHahjHYXVuYo
 2EJH1FT5q3D6uvmnm2Az8t9jmDQmaxtUxQxE9pih9t27Z/r6+Db//o/OeVRx/7wlXnLvAVcU0Rp
 0tppRf2B8yg==
X-Gm-Gg: ASbGnctPkfTP/7SS9JckQN4IhRhbGoS38AyU+xsAwcxYh3htOUGOcMCIEM2YV0OQJas
 Jta+3hthDesCDLsmh0D5XD4UtmVt4v/iAMGBpvkKRbl609HrGt7/kU7SCnn4BU62tlQWOz+S4yB
 VxOR06MqmaSXJuHudYEdZBlTuyLystu0U8Qwp2O5RCHy5DbPJD9x5eoH2VF6W2D++9XETpO7T4O
 gzVYxQ+LxD0vDW23QmaG7nSm2XjsNWwCeWQOj4oPka40ep0ZIJFmg5Cl2vcgXUnsuDI2HHXiYHq
 gPpRtixyGwgIaQO4x/YkckMTH6emKnfTYXNXos8LGApHuiZyrQkmizqV2NRn/8FuIsD1A6D+lED
 CEe/sw4uKwWS77NiI+7qN5zNLwmUJv4D3vVY1z/oDOFQkzw+Rdbz9sWwA
X-Google-Smtp-Source: AGHT+IFmojkCddgOmya2udzia2/oVCiwlK5bnJVO2ieLNVgBVeg3f705xpPme7pp7jSO7vhrp1BHcQ==
X-Received: by 2002:a05:6000:65a:b0:3a6:d579:b78e with SMTP id
 ffacd0b85a97d-3a6d579b7f8mr1289126f8f.46.1750440648390; 
 Fri, 20 Jun 2025 10:30:48 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1808bsm2599193f8f.24.2025.06.20.10.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:30:47 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 19/42] accel/split: Implement kick_vcpu_thread()
Date: Fri, 20 Jun 2025 19:27:27 +0200
Message-ID: <20250620172751.94231-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 accel/split/split-accel-ops.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 746a6a2782d..63b6217f3fa 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -136,7 +136,13 @@ static void split_cpu_reset_hold(CPUState *cpu)
 
 static void split_kick_vcpu_thread(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *ac = cpu->accel->use_hw ? ACCEL_GET_CLASS(sas->hw)
+                                        : ACCEL_GET_CLASS(sas->sw);
+
+    if (ac->ops->kick_vcpu_thread) {
+        ac->ops->kick_vcpu_thread(cpu);
+    }
 }
 
 static bool split_cpu_thread_is_idle(CPUState *cpu)
-- 
2.49.0


