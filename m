Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2177C54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lo-0001ih-PC; Sat, 09 Mar 2024 14:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2L6-0007w8-EZ
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:38 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2L0-0003ZW-Qf
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:26:34 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a449c5411e1so409136966b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012387; x=1710617187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KwrSf6l5lMKRNbxBtTiB9ULE3uG/bpbp4V2erGNe1I=;
 b=xek2MJMLHOBU6xUmmvY9xtDHjOjCIFggKBT7Tpatqn7ltm/hn7/gMJTzWocPOhJwZI
 aDEgn7BIX1LE6+SREZXfUaIGAFgK91pmlcgXXTrRBMcXUGJeRsyJpcm0h4igL5UxFEAr
 Ca3UAD1CSA1mpcrKOum5BVxB7x1ZoE2NiPXQfnpZxlPMk9hhFc0vtKt+/mrPiGjz2L0M
 S9nLKVQk9l/JXlXc1oyt4G7AsvQzHJPcGzKTjgPYE1Pb1/vfmfPTdvquSE+4ZxXhWWd6
 FGJbJ7cz5GSvWnpmBzETcdvDB0Wj5AVUVkmQsymjBL3zA5RqFrWl2vJ99Q1uYDx91PBd
 psWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012387; x=1710617187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KwrSf6l5lMKRNbxBtTiB9ULE3uG/bpbp4V2erGNe1I=;
 b=Xja8apOyv/gj1rMpD7uiV8PDUvw1Nx+h59hu6HFCtvYcWKNLP2eQnsCNrhQefQB8jW
 F46GVJAG8CYY8bTEm0gmKM1EI09CJsu+ad7xt9mtYWvSMhCbbSNS3702VD0hJ8dXUEaF
 BGwx3jpvw4ypilHOsFFZGeXLP63mruy65bWV30naYNo+MPo66MuiufTRgodqptqt4Sms
 q/X3Aj8fAqOBA8cJKGHQfuQgW5onN1I7JjNFKLONT7eFbeUo3KSQRV0NxTSjBnTR7Xon
 OG1Fmxc6rVskQYAERnY2Py3JM6ICoxLCz2VER6c69y0KQ1dtYcywnlzyEr0KCa0qyIYn
 pcNQ==
X-Gm-Message-State: AOJu0Yx3U5kZZ9lqZ6qmUlyUeJHdd9FYtMhhO6ESiwzdsSr2lbxmL9gr
 VrR/u6ET0rCtyLGwheqleL45zuzq43di0Pwlvi4lVYyCFTw9r9TPP3D0fsJHNAF5V6MSyf42swf
 h
X-Google-Smtp-Source: AGHT+IGIElPanJe/Ti8VGRYv0LI2UfeWcMivTBMYYVD03n7ExNVD9uCJSCKKPHlIvMXxCAfFQoWpOg==
X-Received: by 2002:a17:906:b082:b0:a45:c99d:3625 with SMTP id
 x2-20020a170906b08200b00a45c99d3625mr1214493ejy.23.1710012387502; 
 Sat, 09 Mar 2024 11:26:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a1709067ad000b00a4537466591sm1178153ejo.32.2024.03.09.11.26.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:26:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 42/43] tests/unit/test-smp-parse: Test "parameter=0" SMP
 configurations
Date: Sat,  9 Mar 2024 20:22:09 +0100
Message-ID: <20240309192213.23420-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

The support for "parameter=0" SMP configurations is removed, and QEMU
returns error for those cases.

So add the related test cases to ensure parameters can't accept 0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-14-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 92 +++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index d39cfdc19b..8994337e12 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -524,6 +524,91 @@ static const struct SMPTestData data_full_topo_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_zero_topo_invalid[] = {
+    {
+        /*
+         * Test "cpus=0".
+         * config: -smp 0,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(0, 1, 1, 1, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "drawers=0".
+         * config: -smp 1,drawers=0,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 0, 1, 1, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "books=0".
+         * config: -smp 1,drawers=1,books=0,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 0, 1, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "sockets=0".
+         * config: -smp 1,drawers=1,books=1,sockets=0,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 0, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "dies=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=0,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 0, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "clusters=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=0,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 0, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "cores=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=0,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 0, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "threads=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=0,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 0, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "maxcpus=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=0
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 1, 0),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -1173,6 +1258,13 @@ static void test_full_topo(const void *opaque)
         smp_parse_test(ms, &data, false);
     }
 
+    for (i = 0; i < ARRAY_SIZE(data_zero_topo_invalid); i++) {
+        data = data_zero_topo_invalid[i];
+        unsupported_params_init(mc, &data);
+
+        smp_parse_test(ms, &data, false);
+    }
+
     object_unref(obj);
 }
 
-- 
2.41.0


