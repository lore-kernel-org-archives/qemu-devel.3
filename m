Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F46CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut301-0000CU-KD; Mon, 01 Sep 2025 07:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zU-0007WW-MH; Mon, 01 Sep 2025 07:46:30 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2zL-0001Mk-Bi; Mon, 01 Sep 2025 07:46:27 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4f7053cc38so828099a12.2; 
 Mon, 01 Sep 2025 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727168; x=1757331968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf80EJqAcxGGTIu8UKFlaemvFTuxkqpoIGk43YfIQag=;
 b=SHgkvCMqBIMg71Eg1hlsZMUwJouBaNKdZyPGToJfxVwpd7awdQDjLSoqkYXl7DXJGp
 362t4xnesIe3n2QNLa3Wt8p9cDUImtKcPAYF8twx9iwqq+GoIevoHQ2V2tDR152ugu0z
 /EVu3+wbV0nDqAKQ1266nzyT0K/fXDHwQPgb1U55VC7y78+2Aqi9fiBVjbkd+RwRCbbg
 cwPnW8Yw4wx8VxPN/8eyvUGtFsT1bSd5A3rPUybMAme/bZwcV06JKf1cZrrfQjN8IaiS
 oTlmg0z/MxU3MsOLPk72sg+31r7mF1yglUGPfzjvjVFEo0NauqTK26YjYbf6S8ZRjcSW
 vR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727168; x=1757331968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sf80EJqAcxGGTIu8UKFlaemvFTuxkqpoIGk43YfIQag=;
 b=mPCmW21/kCCZMnh+ewz+DFdFc6T4v2pBUIrONf8950pyNIDNG96ZxGaNfXkzSUg5B5
 YpOz/0R5h0bkzcW6uAALJYIQb+3YNtnlpTr983XdgAUpyfgot808Bqe0WdvBLYKmyhmt
 j1f/yvuH4aCBTpAQzifJCs6oe1MaSDrWEaKaM18c/XFEG7IZglKJ5ucf365dXWNi30GM
 0CKIIjnK1IFttltI5BaJxQ8O1mP388gK45KHhS/RSb9GoUfadtkInQoip+it5nOfBe8N
 i7QNiNZOTfdKPD7LQTY5FAtBs/C+WxYhuP59766q22EbcwpQnsI9EcEPw/RecxPwB/ge
 ZHJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhJw6MD6b4vllsubdgqzRAjUa41wesUhZaB8j34iJqsFcUjAzWWVjmHS6XVwkwXEjSz/XrC1tYLw==@nongnu.org,
 AJvYcCV6uerWzGJUR5hfBX5zQEuoyttmPderroGKdxU9gO5k3qauo3N1gFOSknrLcpH2E6mWtts9G82FQTYrXw==@nongnu.org
X-Gm-Message-State: AOJu0Yz8nqiB0whQKTVOQpa7kTuLYATaEzUdPpL4xs0RJYrJCUy6XmHf
 9dupekhb3kfDanJdBrWi597W8z4ve2Kux5nOG+pzkH6W89qwkMqGFDg3hXpvJg==
X-Gm-Gg: ASbGncuknGAliXz454XqcCamD2F7G2OPrRPXlenevTwBbXsBUkA0EAXJ6DGPTlxxOef
 87Rta96LintlVHpf9ow3/k9f2VP0wo2gItdYIN0FhDoUnI5xMhnKy6Yw5N2IzPlGTXOFh3IO838
 oPL3WyufwyUQzx1XQN2psPgwY3PDyoKUsAWGADEYu0ZE1a5Z9xxaSK/iPlI9DOmboKkSNqAQMOI
 RR2uYHoJUugoFbrxDAAF2G4XzhZcJY5P4/agm2CTRL5DdyeDHRMUF24yaS9JCsSA9yQ9no6F8eW
 hMV6aC6OHojSNaJH+718M8HisB7l5oJr5gy7yHVKaXVY/xGQZgSdojtxFYifnPFVsRseyQMw1wV
 lRXfZ8n7tE5xih49kBdFpWg==
X-Google-Smtp-Source: AGHT+IGdXU5wRXdOqIhg618Y45uQWMtwucFyOoGbDeA5xtPKGeAEjtsNAssQQYXbjMFYh12qL1tbpQ==
X-Received: by 2002:a17:903:19e8:b0:246:15bb:590b with SMTP id
 d9443c01a7336-24944a1fca0mr91298885ad.17.1756727167977; 
 Mon, 01 Sep 2025 04:46:07 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:46:07 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 08/35] tcg/wasm: Add relocation callbacks
Date: Mon,  1 Sep 2025 20:44:10 +0900
Message-ID: <5baf88bab53be1c51736b8caad24111d386f3f28.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Relocation callbacks are used for the TCI instructions to preserve the
original logic of the TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 0b12c4ea03..4bcb594360 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -88,3 +88,24 @@ static bool tcg_target_const_match(int64_t val, int ct,
 {
     return ct & TCG_CT_CONST;
 }
+
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0, sizeof(*p) * count);
+}
+
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    intptr_t diff = value - (intptr_t)(code_ptr + 4);
+
+    tcg_debug_assert(addend == 0);
+    tcg_debug_assert(type == 20);
+
+    if (diff == sextract32(diff, 0, type)) {
+        tcg_patch32(code_ptr,
+                    deposit32(*(uint32_t *)code_ptr, 32 - type, type, diff));
+        return true;
+    }
+    return false;
+}
-- 
2.43.0


