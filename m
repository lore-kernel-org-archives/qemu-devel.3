Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69588CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0SZ-0007E8-2i; Mon, 18 May 2026 12:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wP0SU-000772-52
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:04:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wP0SS-0007ds-73
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:04:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so19226625e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779120282; x=1779725082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ufefbwsKMhzpZARdFsQrTqHVtQOsOsH0aXUUe4C0qkg=;
 b=RenoWLfHyBKwIEoQIfqyEexuep41v11BbB4VQv7x37IQsGqv/9lvp6NuD5zO4aKcle
 s6qc0IIHyqz9GR4Nsltcofpd9SXX4XuYRCh0gxCDpVUmZ+vnfOv0vJ8wKUBjhS1GPFFb
 rFwXaGj4b68U/+iFFfaYFlGAgylOl5nKDy70KV+7j79DdPSYwRBiwyt1DXK8ga+c/92A
 VIxq8e6csUKFvICj056aPd0de/B0D5Bz/100p4i3qPK1zcn1iHj2v2FGO28a+Sgtagc8
 c6tZrNDlCR8EgFTLjU2B2IHHcFRq3pklDQr9QJcDTQMUwvWDlN9ChKpqNNsPiMMbnOK4
 of4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120282; x=1779725082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufefbwsKMhzpZARdFsQrTqHVtQOsOsH0aXUUe4C0qkg=;
 b=o0XSjFLJ6Fe3bcEz+FNB/BFO2j2xg89zODW71PnDltZ3ruh0nsCqfjtfsoV8/ZbzzV
 wCLOc/T7l3BTWojBjzXI2zo6cNzbb63sgzoGR6vJ1FxG/XTk6GjfOwycJqIJW6EYXIpq
 jZR6mxr6ZqmyWkEk5peWydSPEmgz9rwOD8Z+JYwZ1/u+P7EkEtY0FH4bEIEVKI7o1LbR
 ncpXMKY8PlTHz1Fz4KTSI2lcFFYIxOmVGSlK4dOg9mkGWvdzExKCdg8gRGkrHroB2Y1B
 Am2dv8mJjwbD0+wZshR7PqN3GRjvaTOVd7sFHcbTZH3JkT9TDQrEkeUzlomCCtYn2E7H
 2uxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wUtnpXkX/SMQQzph/h04GFGk1f3x7igbmiqKDtMni2Iq3gzyNLQgf2TjYCb4hkMCGx05um/AUJnyn@nongnu.org
X-Gm-Message-State: AOJu0YwS7qTT2+deKUOnYUiOiSfRIL0I0c0Jfcu44Y7VlkLJx4pT+bEB
 oRHL9yzJMvbdSNkLPx7TP/o8CPL+BpsvbsCm7n0etBoI+hCedrZYWBtFbMRoHTOiGVU=
X-Gm-Gg: Acq92OGZGu1UhJXI9ZdG8moaUDwmUna73c4ou4wD5fL79wqnD7tq2dgVAV7RvYNy3hM
 XC3sbcN9AxolOEv9GWS8lmhVHgn5WYNxIvpEd2crWkLeyTsVHhooZhLYDolCNSPKFf1e/HnmhHp
 pFYwXyUZbF5zzloP1xRMfqOFARzpjqwe2G2MP6MaJxiC/eo+m1X6maAqnp4pjqUV8l/jl8k9ki9
 sRw0ejemsVdr/a9J/TwWxbERRBisMrzwp+Kso1PYoMzl5cXeZK/2MQixkuHeAwVQ8QeMPZimKJj
 EfP9sXnrMAaYKkN6Jea5olppTIGmjFboRQWZ/FoP4zknur6h7ulAvSP6nkL6GIyJb3KnoNG03tj
 Ak5XxDmTaM+YBrfGzEZ6rZw1lG9OIZOIUryJ9iDJ0yWLOof2SygHxt/pPEl9golP5B8IspXInQH
 3kZaJtINjU2yd8A088wHKeKhR/0c850SAtsckiWGg5JUcIiAkMWpaqKXj5yLVtb7INEI2s2HYu7
 1mfw1n9vU9aLxVkpnHXpGSC7k8B4exooVqPIYfdyQ==
X-Received: by 2002:a05:600c:8599:b0:490:778:4fe8 with SMTP id
 5b1f17b1804b1-4900778509emr84516355e9.25.1779120281864; 
 Mon, 18 May 2026 09:04:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767cb9sm37060577f8f.2.2026.05.18.09.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:04:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/functional/aarch64: Bump up timeout on vbsa
Date: Mon, 18 May 2026 17:04:40 +0100
Message-ID: <20260518160440.1037245-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

On a debug build, the virt_vbsa functional test takes about 2 minutes to
run on my machine, so it tends to time out. Bump the timeout to 4 mins.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 9803f66299..e81afd6c39 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -17,6 +17,7 @@ test_aarch64_timeouts = {
   'tuxrun' : 240,
   'virt' : 360,
   'virt_gpu' : 480,
+  'virt_vbsa' : 240,
 }
 
 tests_aarch64_system_quick = [
-- 
2.43.0


