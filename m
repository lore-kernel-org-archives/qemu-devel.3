Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE61FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSHg-0000lj-5A; Mon, 29 Jul 2024 11:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHe-0000eu-OW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHW-0008EQ-PF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso1595973f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266844; x=1722871644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/zGXteK/S9WGQeoxuzITGtgb8/HqBY0j6sCJN6VEFg=;
 b=QCo2B7Oi6xdE7zx21FU/Dw32TRmz2ehtb5pJiXgmy7iZbAPBcY/w63qPbdP+Hc6fA2
 sqXTfA12R5m1tUIxKtw2gMIfjro4lZ/0ewv9YCQRcuof/nd4CJybuczpsAuDCOi7g9ua
 c/oJgI0pUP8R4Wu6gDXXEx2luN2tBmgKy3OqK6Ly0HQOlkKKK4Gr+i0n+NXRDzBp3nbw
 DIkmqjIKFU8oFYzem8s9XaF+QIFqBMXgaB2KfcMzrQ5H8CAooyEUnAUQpNUrBT4FNZjL
 9/aHkzMgJOJ7rSmOlS+h0IQ0HRu2n2fByOYzXONxP8va6S6ZTOLEEtaT62yp3V6CskdC
 67tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266844; x=1722871644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/zGXteK/S9WGQeoxuzITGtgb8/HqBY0j6sCJN6VEFg=;
 b=uGpdrYaKv/TiEmL9YBoMUSl44bEj9tF257/ZJfs6CTfBeGopkIz8IypRraE77W45Jf
 Lx26+yUb7AxgP9nLOQ5bEKvZprrerhwX+zophDSIr+c8g900kTWhuYEV1fUghKAlHn+q
 OoMQFYhJ2Sh+a/yEwXVjAYS5OBFySdhEE/qsz60FDtCPBNP1Bvc91N/8EZFYnFu3dNRy
 b+fvExiX2/aHLAzxKGypKkbaCQ504YaoOEHlAm6vBHDOs1I+zcTz2gpVfJLNnPz0Udv/
 4Q4MJQU6evZ4FTElbHr3y/kp3Fh6zsX1ETZvKtzz4pqKswEqozlaw4Y34kLSNDHzyPhH
 Wdqg==
X-Gm-Message-State: AOJu0Yx7BZlOPuN428n5UeiG9sqNnV2QLeYblQzgbkBiCcTMy5IIYBba
 CkTm12ZWsy9C7e+Gd6szs3Eaz1YcesyBsD7Ca7ozB0J6rfuI+cPe4+nagKruAwG1S7qL+4vME/6
 o
X-Google-Smtp-Source: AGHT+IEY5U06Nbncn74cXiGryAK1OTD3/9JAvuPg1ZZjEcZCbaTsmrglveXEKlGjk2DmsGQyJx1Yww==
X-Received: by 2002:a05:6000:bc3:b0:368:7fca:9040 with SMTP id
 ffacd0b85a97d-36b5d0ace36mr5431917f8f.39.1722266843611; 
 Mon, 29 Jul 2024 08:27:23 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730bd0sm185399465e9.10.2024.07.29.08.27.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:27:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/14] docs: add test for firmware.json QAPI
Date: Mon, 29 Jul 2024 17:27:01 +0200
Message-ID: <20240729152714.10225-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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


