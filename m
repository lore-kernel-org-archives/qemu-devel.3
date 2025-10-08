Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3125CCCD186
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P2D-0002Uu-Bq; Wed, 08 Oct 2025 03:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2B-0002UQ-93
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P29-0004pl-GN
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so70576235e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910183; x=1760514983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kv0MoHrCI6GFVaz4A2TsppIcvITPFe07qfWkKD7Q1I=;
 b=C3otL5ELshJeE7pja7zdIJOPum7JDf4aU9INSk46EL4Dmp7N+RgPu9yg0eeUSX0HX5
 8whlbUdNhTJYeAxj8DgR4/IG2VHJ0mQ56Y0NscnflxktTlOW8vN3FNYKNxxcONF5EgmT
 EUdphbOZsSSg4PYodqKpG01Ir0RkKDP3Cp4cLPNJpUxxqDLowPupp+bZujfpgqgYJpkL
 s7a/ZrLx6O+COTqE5po2zdtw23YqHIEn6JiBynH2ehYnyhc/X4XMpFxLlOaCvE0RGd9K
 NAlKECbrPOSoKJ+IVbnOaNaXz/6++fpm8nJU31H8U8vmz8/R6TDhkm8/dA3FY8nhJUsN
 jCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910183; x=1760514983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kv0MoHrCI6GFVaz4A2TsppIcvITPFe07qfWkKD7Q1I=;
 b=V6NW4wf1wVULCENTUOROoQGgVHpN8yYLm2iZzIwDPlt0scIeDUtoN+8jl9zNnq3MG2
 qZ9ItlYi788w9rJ70c0TjdV3IaGkHj220N9GWxFB0DX8uG+vIiztnKVppd+GfzXgEb6W
 hHhKHyI1tnLl+oBJ/TGcnG2jCPcneKIi6PGbEv5Wh80V2MdLRzB5HOMFCaRgZG/SNboj
 ywoffn2IdoZu0j76uAq6blI2I1CVZEzycxrjbMOadnWFkommH9F2jS4Fw7FC6mfUq0O2
 +6o0g4+t0rx/ZjSBVzT6vI0g5kbrnueNs0kuT2kgj0TBxNC6bvi5eksvDIfAlIu8kNHb
 Y37g==
X-Gm-Message-State: AOJu0YyCvgPoQPmnDdwtUri/mvNEsm9aJivwSR96/TCBuQmlrWMEDUaw
 hdoH8wVUCyRCjRZ4ie+Q53Ud8qngN6a0xLnMtl87dX+6H7LXrWgG/oXMCQ1SW1mgte9qcNxk8CD
 X2yurFJh1Xg==
X-Gm-Gg: ASbGncujFrjlPoy88BIAU6gxh5l3bSJ2B5pVailGjdYn4omCPj2WB4HyFpDptuQ7GBB
 dmLgSXwEP95+LkNBw84Bhx6mMCbXcqewHGyA+b7IArMnD52GZbrQSnNd3O76I1GYcw9z7t2+gdH
 LxuUwYLhUCDxUMCJpX/2PQiP1i2U6Eg0/7pqBDpNkd8haSonitvXmDYtn7IhuYZaI0JW+yWXcBh
 hjBxe8HiDMIfKQSarvjhPlzDJXNz41sujbjoUIy7Mded5DpvqEoyLHPsWL7zXAL/zEyvKk/VpP7
 l7Sq9N8kV8NoyriRbXY6uRvU1ocOfxxN6TDa+abectdufiEaefF7gILVmUzOoCYShLN5PE6OzjZ
 51zSR+V+c4qchKwmd5pu2SEalk9RI8m19Ajg4zHBvIk7vAJEmbIHXlxtf4SGJdBfClWjdDTOM9N
 liEy+UTUPqfGVwWNOhN44vJ/GT
X-Google-Smtp-Source: AGHT+IG3zZPBEttQIYrd2TOwKbvlPFZ/oRwtVU3Z5h9X+HFidvzf7Wqy3PdXUXvDyAOkbji3fIGxKQ==
X-Received: by 2002:a05:600c:3f08:b0:46e:4b42:1dbe with SMTP id
 5b1f17b1804b1-46fa9b075f3mr13266945e9.32.1759910183356; 
 Wed, 08 Oct 2025 00:56:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c22317sm25672895e9.15.2025.10.08.00.56.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] target/openrisc: Do not use target_ulong for @mr in MTSPR
 helper
Date: Wed,  8 Oct 2025 09:56:06 +0200
Message-ID: <20251008075612.94193-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008075612.94193-1-philmd@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

OpenRISCTLBEntry::@mr field is a uint32_t type since its
introduction in commit 726fe045720 ("target-or32: Add MMU support").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b091a9c6685..ad59939db3b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -45,7 +45,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
     CPUState *cs = env_cpu(env);
-    target_ulong mr;
+    uint32_t mr;
     int idx;
 #endif
 
-- 
2.51.0


