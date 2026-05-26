Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC783CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyXU-0000sw-7i; Tue, 26 May 2026 16:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXL-0000kH-Lh
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXJ-0007At-I2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso94951935e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827880; x=1780432680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVB05P7puZs3LFLDZbqNcDYns16Vx3D3vfqn0WFuQ6U=;
 b=oYxdaNJzvBCFlJe2awLzgd6KPZ6Fh6gk+Wut6xXjpRWDSUEhhOLqEjVyD6f3gsxTNW
 oruISzh4JCH8ns3wBQ7pJ13RQOd+ogA44mbPhqz9lswVsm81ZIVkQI3r2x2enttSNuQQ
 6o+gieTjlmCGuAnHvRWnn49XS2X13NegDLdHAm8KGx3N2pET7yUKyhLDofv2vfp1G5kL
 LOwO6i88rRmMC8BYH6+eCKcf1XlXWsc/4JWE73+Y+0cP3Y+K2rcOuTX5plLqWefXX5Yn
 OWFltkjbjrCvYiRvEUGUiiRa21H4yRCay2eAkHAyFLAO+3Im2L7YH7ezycgYbItQ1IqI
 Phcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827880; x=1780432680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aVB05P7puZs3LFLDZbqNcDYns16Vx3D3vfqn0WFuQ6U=;
 b=dnD+565ulmyFgrgJjYfsfvzKhtW5iY/f+IAPoCtqKcBEtnEkh55SdbjWwPla6Ys0Qr
 Mp4d5UYEc8ZfssUZjc5FEh67gHUxnLkqOU0gMkAb3fh3vVeG2pVCCtoPru9W1pgHAQO+
 HXO0E8+isV/EWbtfgsZ79rxe5vePb2fofrwdck2u7o8kLCIBJ8/kujT0slSTM3ZMAnVC
 5FFyhAu1D9On8W00nWh2b5VHbPy0L0TSXn990qmzd63DFtMJWcHKaE8h6r2/bXReAoN5
 ALC0GgvbnplFxV5lGq5NK+pzy40OzoXchJoSt4b06UuAJ4XDmz6Q+d/DYBVeZ0CAeklW
 C3ng==
X-Gm-Message-State: AOJu0Yzizij8MoWvC6yVs+DWqDx4ZBuSD+QQjaYTu3FDnCRtUDjHjfYf
 sEaDcATCk8yMI/6fwPqz/i4YRMvrTBgdd1DWlpGgQPqQq82dwWvTuo37FQ0h680yKqfKZwqXuMt
 8Xp2tRHHQ/A==
X-Gm-Gg: Acq92OFs4APlZ61uome/XvKDO/oin6R7/xRyAIiQHtVIEHMyrXbfzVQT08R/Qb6axR1
 h44TkpKslxvFDi7b7dF+r8zcwf1inzk8FPbCkpu7QTX56anQG2OmYy66xtdj4PHHyx/mm/hbUas
 I5S6K8d5NurUNdMlsVMXCeWMD1jsDjw0ok5YdpOHpIK7IgBH1+reEbCgoL7KxvZHFNl2XBf45/F
 nEwGU3xWRSsSDmIrcSJ8hHZHVwCvYtZsYI7Vs/Pigth5Z8rtTxeENuoTjEypgw1Cwk2Rsk4JKt1
 pIn5hU4LzKWjy7fLv05m/7LCR+JpdUNMik8qUIr7LyMtYCKQeVJLDGyc0DcQwFdEw0P0ob6hwjs
 J5Bui6fQZNX+qQjsKPveJ0QZYO73kZubsXKnD9nBDCcqw3750pha+7ospW97jl49EKFNWv744GO
 uzpTj2LpsmyUgDV1YFg8OtCBRECJ1FItOGrB4XqUGlZ0nhHNhcm8LCn+k9X+UFwwKQtw==
X-Received: by 2002:a05:600c:8599:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-490424acb4cmr269218925e9.8.1779827879962; 
 Tue, 26 May 2026 13:37:59 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809c785asm1379765e9.32.2026.05.26.13.37.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:37:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 05/17] hw/arm/meson: Remove now unused arm_ss[] source set
Date: Tue, 26 May 2026 22:37:10 +0200
Message-ID: <20260526203722.79463-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 22e8ad924a2..8f66a80e10e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,4 +1,3 @@
-arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
@@ -111,5 +110,4 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(files('boot.c'))
 
-hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.53.0


