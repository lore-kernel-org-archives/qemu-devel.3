Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB9BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTgV-0001dw-TB; Wed, 13 Mar 2024 14:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTgR-0001br-BG
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTgO-0004FI-Uc
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-413eb7cf7dfso1645725e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710355831; x=1710960631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X17Ya2bvpA+4v4TFaE60WLvpjjO6zpu/JP88j5/yX/w=;
 b=f9EtNz/ZHx+4BCXzeEHkXEpAhnaN8ZnZyFxpL5FjMAdnfsbQ/1Of/RbL9xShaJUS5F
 yULqqs6v5sOFcH77Ogc+/+BcentQA1brFuEVqO0jZSaI/w8BWyiNaePKU6m+6lyC+4SG
 eBUJlmYMULvB5pCyz/ZXFFOnWBOpT+yGUZqMiR97+gMTTYUpsmxgxgavA+bixsaOhJEZ
 6c+xmKvmEQj8NFBWccqKjFfWjAN5d+WU8VBrg6khXE2W5ZCRIGRVKf96Z4nxiMiWHRfG
 kWtMAJBh8s60PS/HxeeN/NQhV/2UQil+32yGgpCrq7U3twnBCvqxrubLvuRQWmJeIt6z
 Cb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710355831; x=1710960631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X17Ya2bvpA+4v4TFaE60WLvpjjO6zpu/JP88j5/yX/w=;
 b=rXXYulfN0XlJEmOTpUD9lj9MJvQgaE0qRLjGbJzjrFoHkwB1yWpp8y5GZn/v1XTe9h
 XYum2YyPZezdWhYxIQ7XtqoN1WOmwR6pjbfx+MimGy0jMDwWx2k/HPbooBlGeZ5IRerA
 5PoKUUWcPgjnmW/EtLUDswRN4rPnydXlwivwiI+8JFrKUDewfR1PfHy0s33mb2SFacaZ
 RMQPlsO/dWPolurB2jEGUo/MIEEk5e2ScAw66cE5wSBkxBqQLEafOEp0zEoa3WcyOoeq
 oYSPP2LWWLljt/n0xy4vKrd5POCA22tG4mWWB6vt6JykLJ6BWroGH6LBdLnX4rPz0jDG
 A/0w==
X-Gm-Message-State: AOJu0Yw2zEvY6BxKgqYP72EkwA1BfPqHcfbyViaeGh1ym7NJUwz5oiLZ
 uB0ghkkGy9QPs2asfXYTP1sRkVSt7+/92Lb+9kaUVeQOE3OI8lVfpoHuoWalfEq+Qk78nrsvzsz
 z
X-Google-Smtp-Source: AGHT+IGsvzdgN7ucAIoiomxDKoaZWax6gBU734zZCqWs/3xAkyQ7rw8GWiUctzeOxTFbc1yXyiTzdA==
X-Received: by 2002:a05:600c:1910:b0:413:1ee4:692e with SMTP id
 j16-20020a05600c191000b004131ee4692emr631218wmq.9.1710355831312; 
 Wed, 13 Mar 2024 11:50:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 fj14-20020a05600c0c8e00b00413385ec7e6sm3088148wmb.47.2024.03.13.11.50.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 11:50:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 3/4] qtest/libqos: Un-inline size_to_prdtl()
Date: Wed, 13 Mar 2024 19:49:53 +0100
Message-ID: <20240313184954.42513-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313184954.42513-1-philmd@linaro.org>
References: <20240313184954.42513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
functions with external linkage") for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqos/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index a2c94c6e06..135b23ffd9 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -662,7 +662,7 @@ unsigned ahci_pick_cmd(AHCIQState *ahci, uint8_t port)
     g_assert_not_reached();
 }
 
-inline unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
+unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
 {
     /* Each PRD can describe up to 4MiB */
     g_assert_cmphex(bytes_per_prd, <=, 4096 * 1024);
-- 
2.41.0


