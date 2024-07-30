Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF21FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvCU-0005OT-3U; Tue, 30 Jul 2024 18:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCS-0005GW-FK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCQ-0006hd-DY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3687fd09251so2547751f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378004; x=1722982804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/zGXteK/S9WGQeoxuzITGtgb8/HqBY0j6sCJN6VEFg=;
 b=UOLN2kkGPXYZVvydsiw5j9Hy5mzQ6srPmk8FRLd3TmN2lqHHFAucFquWGMLnZRjLcW
 A+o1O4bkfJhxkgfsJrI/OQXfate7/8s6woITO4MKAWdFF10ZTgfJaVh5yAmCXE/NEgCi
 GMuLni+UC7nZ4hHwOGy2gjvOQHNZ1SbCW4lxAYF4qXcFN9Zl3PjSOtdz5f6asmnO59J8
 urmpiWczvA5DHqlXn+9sHL41zjjKQaSC+OR8mItzmKp1zdhriidf5nkQT+/jyQmuuZ/n
 +TMTvh8ZYdnjKDAXaaDVGCfwdNV/A0dADddB0dswcBO/bENRPzbzhPz+mGfYKc4p/Kdg
 qUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378004; x=1722982804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/zGXteK/S9WGQeoxuzITGtgb8/HqBY0j6sCJN6VEFg=;
 b=LuNg4Q/iFtIyc9IUgkIMRHRV4sPl9CBXCM3HT4vQZbEqyMOIhJrkvoWkxTALnT61UE
 PRkqQuAD+jRkYP4WbkFyhexooMwTbPiTgZflYjY2hedsrtcwFhjTW1TkhZKMRSdsmNKG
 X5DBIhrlhWxPYOAyucoleQjiibLZR91Yt99PTIKqddzSj1W0IAZTketKdMZHvFw5MX5S
 F9tziQI3oy4v27RIZ6jDJfhE1C4P7c3SRKgbh/owSKI/IGb2CZdMLD8IgQeNI2K5Wu+R
 QG/EiRTR46Z2/837v8Wsd7suGkSEt5oFFvNhZL6VdNW+RM75kHuKCMsrdfED3OqKG71Y
 ojKw==
X-Gm-Message-State: AOJu0Yxo/QcjKIqTSXRFin8fDx09eY4DZCQmfGdvmAizDNhSlPs++dcx
 vWWhPHQoMRZ75TQIEaeJmkXVb+jNaX64X4mmpLZTa1OxvuUnmkhj7ibZsdLPRr5CUBAQkzbFacT
 gRys=
X-Google-Smtp-Source: AGHT+IFMOX/9DgZ3N7tiFdyS/61xh9NPA9wvdFEaV8UojlFkua53BL/Ozb3jTJhrSPMwoEarH1EMng==
X-Received: by 2002:a05:6000:156c:b0:369:b7e3:497b with SMTP id
 ffacd0b85a97d-36b5cee2f89mr8744490f8f.12.1722378004227; 
 Tue, 30 Jul 2024 15:20:04 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0338sm15798405f8f.1.2024.07.30.15.20.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 15:20:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/6] docs: add test for firmware.json QAPI
Date: Wed, 31 Jul 2024 00:19:52 +0200
Message-ID: <20240730221957.34533-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730221957.34533-1-philmd@linaro.org>
References: <20240730221957.34533-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

To make sure that the QAPI description stays valid, add a testcase.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724-qapi-firmware-json-v7-1-12341f7e362d@linutronix.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index 9040f860ae..322452c877 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -99,3 +99,8 @@ if build_docs
   alias_target('html', sphinxdocs)
   alias_target('man', sphinxmans)
 endif
+
+test('QAPI firmware.json regression tests', qapi_gen,
+     args: ['-o', meson.current_build_dir() / 'qapi',
+            meson.current_source_dir() / 'interop/firmware.json'],
+     suite: ['qapi-schema', 'qapi-interop'])
-- 
2.45.2


