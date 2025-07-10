Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74034C83F1F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZonG-0002Az-15; Thu, 10 Jul 2025 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomf-0001r6-Ua
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomZ-00077k-T5
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so516570f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144335; x=1752749135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY0xSCtlYykrPT/bsa3C5YwiSVl8pnKIhGQiapGCENk=;
 b=Y/LCwqRG5jDmqlKP0SQPqgQ2eW9dQ5r404TYtCbAfP1GW12KEbP3EBDafMIflRPCHQ
 xLtvPkfggWNq2g5S95B93c4SZ2u7Gyj04+1RCn6enZs3HykylNg1Fkljlvt78nhSldFF
 S7aPzEsMjlWB61QIzJx6nNl0yl/UrctrcGq9QE85ojwk55KJug3+HiHmuCOIx3cRkCRO
 GMAnKheRds1/6ArOAotjvTWYp8I2sa4ZTbCuVmUBY7TDXVJtfjA7EnTXhE+d6tNqLvrp
 t+U+PMuwIdFZDcfVbwvdOoiXepw4roPnsgFs3IziRLIJCg0neLX7MT/Lem0KxHyeoRxD
 km1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144335; x=1752749135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dY0xSCtlYykrPT/bsa3C5YwiSVl8pnKIhGQiapGCENk=;
 b=R8ZnCorXKQTO3RLADFqfvDIsuXbGHnwffzUfPpsgc4Xl5OCVrHYzZ5Ff6Q4hMkQGpf
 UWf2C/gsZTE6a3Oax/jFeDC3Ix2vl9dgQHrWKuhEf+GBTNoQnl67ZXSVm/fUUw7YEfjF
 pnqK2LaWZopG1DmVCQsJqXAmkTIZzfRThgEXdqvFyp8yE3jz+6hmHRV8S9HrUIL3sv0W
 1GPy7pNZM1SRSG1INZ0U7wVwngwDPhwnwYQxXs5zB94v4D/Bj87xrq2ZrawW7lt2vjB8
 6iL5ka8eTgPfn6IxNTbJqIrkOJmASsGg7SkemSTwTSmZaNAD+a5bzL6vQ+zfMmF/zjGY
 R+tg==
X-Gm-Message-State: AOJu0YyJshW8y5SOlkUVstx1q0xfGCFYFgay7pjBEb8XS75NEn4+pGiR
 a+WlZsMEUePz2PQre3z5zjVwmffHWid7ASNauLAaHARnilByVId7jWraI0UT7mDj/Ho=
X-Gm-Gg: ASbGncsUIXkiTv3ZD1vDlxBz6GuOHqzF9/lkBJa7avR7CDFKUs5WGG2KgkH1+manlPc
 iijc4Ko+Db20HPGNUxtk7mOU1Htf00ijK2dzMWZUoMOZMWats3rRONJ1YQLjI2mXVZ7tQQiucOL
 uFQMgwPpKt7ODrjnptmZ25S4OHBGxH0+wqYKMRX59+NT0bDPNvboK1a5BbGvzuZ1u/bg2EDxm+D
 /c6fpfcF0Imu74lKc3beCT9p+vb3qYo8ee2pktj/2+F2fmv/ohr54e9Qufe5lRMkm+WcJUurK/x
 +R8f3CZALLL7kT+DlQa4zDWZuoS8+g/SRrTRxZ9LtnNFYdc/x13yQ7BJO67+xHY=
X-Google-Smtp-Source: AGHT+IHkqr6+7PyYad91sLUrKzIYWh13JyYkVR7p0TIc8S4wO+wniM9MOH6i/s7312Kn5fncGTuHLQ==
X-Received: by 2002:adf:b60b:0:b0:3a4:dfc2:bb60 with SMTP id
 ffacd0b85a97d-3b5e8680f1amr1474851f8f.26.1752144334634; 
 Thu, 10 Jul 2025 03:45:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd18a2sm1529540f8f.20.2025.07.10.03.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 679695F834;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/7] gitlab: add -n option to check_units
Date: Thu, 10 Jul 2025 11:45:25 +0100
Message-ID: <20250710104531.3099313-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710104531.3099313-1-alex.bennee@linaro.org>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mostly a developer aid for those who want to look at the full backlog
of multiple build units.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/check-units.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/check-units.py b/.gitlab-ci.d/check-units.py
index cdc62ae5ee..cebef0e8be 100755
--- a/.gitlab-ci.d/check-units.py
+++ b/.gitlab-ci.d/check-units.py
@@ -30,7 +30,7 @@ def extract_build_units(cc_path):
     return build_units
 
 
-def analyse_units(build_units):
+def analyse_units(build_units, top_n):
     """
     Analyse the build units and report stats and the top 10 rebuilds
     """
@@ -44,7 +44,7 @@ def analyse_units(build_units):
                                 reverse=True)
 
     print("Most rebuilt units:")
-    for unit, count in sorted_build_units[:20]:
+    for unit, count in sorted_build_units[:top_n]:
         print(f"  {unit} built {count} times")
 
     print("Least rebuilt units:")
@@ -57,12 +57,14 @@ def analyse_units(build_units):
         description="analyse number of build units in compile_commands.json")
     parser.add_argument("cc_path", type=Path, default=None,
                         help="Path to compile_commands.json")
+    parser.add_argument("-n", type=int, default=20,
+                        help="Dump the top <n> entries")
 
     args = parser.parse_args()
 
     if path.isfile(args.cc_path) and access(args.cc_path, R_OK):
         units = extract_build_units(args.cc_path)
-        analyse_units(units)
+        analyse_units(units, args.n)
         exit(0)
     else:
         print(f"{args.cc_path} doesn't exist or isn't readable")
-- 
2.47.2


