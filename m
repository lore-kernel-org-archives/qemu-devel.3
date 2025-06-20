Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33233C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3h-0000ba-9v; Fri, 20 Jun 2025 18:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXM-00075b-6k
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXK-0005tY-MC
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso1695938f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440500; x=1751045300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpBwYq0odJP35hPS/ZHWH0tQMkmHm21aFnqf7WmG/uk=;
 b=PgiLJiiau0R5Lba/XwdP/mzP02cn5O08qAjSryPYbaQzFcLvvmZyYKY0xgMRZcY8Mu
 SNakFzCVGI93jLnlIkPO2vcaaU0MK/cyE7Y6Ds83dDw3lzJMSRG1UjgbvEkZ/dGJKZj3
 96/f9WtuP4sC3BBVP4l8wEzgQnK0qtpL3ZNaAInHd8BcWUDh3E8PoLQ+0ZnHWY8m6QuZ
 ON7RWwNAuP/8Ka7jjk1Uo8zjhoafsoEgG91yEk++dBSLdvAaSyBdeRfwrWAuHGTpWSyq
 kOiTKiVrhTGZfkJEpn49W3XeNRDX6q1Wagby6qAWfyXur4f3bFKL5jp7kwyKYse1BEUO
 T7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440500; x=1751045300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpBwYq0odJP35hPS/ZHWH0tQMkmHm21aFnqf7WmG/uk=;
 b=LMrkwOpRjhDSAMAQDleeVcmJAX3SnIBBec2fPNbY8Lg2QgxDBznxQOFjuyFuC9J7aO
 aXW6M771GfGEcrYRTcCPFyXNsfU5jK3kQCxJtVvy35sfTDN7AduDnF79XvdQUutLJ1OY
 8rUkzRo1DEQke6RHsBycWKArZn/sqnisMC9QsaYfC5iFI/CPvl8JGqKULEYI2CY1rny4
 jDx8KoVQbSt3JgfwDoR0zeRJR7sZB5Zah/1u28OUIKeJDD4MW7Uv5uZI1P09Bigkdlsj
 9L7wBouVD/ii4cQU7/AgM9TFookU9bMu5HB4G12Y2PbwxykRjoViY+k7TUyytDBeqIis
 1Z6A==
X-Gm-Message-State: AOJu0Yyi5MdrzTm+Wq2T+kUliVN8DpPUesYeScp+sLyk8xvx8feoqiDC
 D7B/CQ+cTdlFi35mumHSfZHJGc0v78JzujaAlRzNgu1yWZM674uLLcw9p8aJafRBD0NhwmYv8Ny
 m/ElPrT4LcQ==
X-Gm-Gg: ASbGncuwf1kLF45MepaK6kEsPGrOjIfWIarlprzmg3lKqrFo0HMEna2o9Ep/qBtBMU6
 HuFWSFvpUvOQoiDzwCQiOYsbCtWWEavhAJfxiUhPQ3IyVHQ3HwXVIvhLkaoRDV25Nv7QL04w6fr
 fyqPxtSWehXgbB2KFaXIsf/Hu8fDOTxLXJFSrxdayOGv9mYXXyUKxGbfq0Td3Km0XWfv+w5aZMQ
 NEUlF8luxhcJD6asirrq7Lmr4uH1TfgZv2GD92B/2oqHt4nzt78tu2j3PAQwdwtk+Y5Hg7WHz3E
 2EmIF6krM3plqa794zn2hBVfXe9l4GzlsfF7FHFJRvFWnEhxS/FpcHQvmmcUpf70WVDiCj6gtTf
 xu4u9EPyOmw/z99w7WAy1VcgX8Wt3w3FSB8fjaE9DJUqnAsnoX/Jtq078
X-Google-Smtp-Source: AGHT+IHfjl5nC6ONvJHSmpHcKqdQIh3YAdEPwWXYC3L1nPQmlDsVYoN1UdBfIH1vWi2c968n/F/lFQ==
X-Received: by 2002:a05:6000:26d2:b0:3a5:2cf3:d6ab with SMTP id
 ffacd0b85a97d-3a6d130ef38mr3186512f8f.39.1750440500434; 
 Fri, 20 Jun 2025 10:28:20 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d11881basm2556550f8f.72.2025.06.20.10.28.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:19 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 03/42] accel/split: Implement cpus_are_resettable()
Date: Fri, 20 Jun 2025 19:27:11 +0200
Message-ID: <20250620172751.94231-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
 accel/split/split-all.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index 6bc95c7a7c8..c86d0e8583a 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -30,7 +30,18 @@ static bool split_has_memory(MachineState *ms, AddressSpace *as,
 
 static bool split_cpus_are_resettable(AccelState *as)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+    bool rv = false;
+
+    if (hwc->cpus_are_resettable) {
+        rv |= hwc->cpus_are_resettable(sas->hw);
+    }
+    if (swc->cpus_are_resettable) {
+        rv |= swc->cpus_are_resettable(sas->sw);
+    }
+    return rv;
 }
 
 static bool split_supports_guest_debug(AccelState *as)
-- 
2.49.0


