Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A826F104891C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5ZG-0007GA-TQ; Fri, 27 Feb 2026 16:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ZF-0007Fq-Ee
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:13 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ZD-0001aE-6t
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:13 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so2330562f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228409; x=1772833209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKn4WA063WKCUt7qQnEGcQWpweHLdAfliYY9ZUygSL8=;
 b=eaJ6gc0tDfEpENHp7aHf6goDbfCjr+OURmoYyls57QQk/x6nQwYQgvY8UpcCUZjC6O
 Vm+nX+rB0klKCG5UNETNucPLqVXgv/sSz/KPRn0YAOm6JH9PefVwCMvUCB4K8gKupFVh
 2VuQzbm0leXiHg4xA1fKrMa5unVtF+0Wxevm6uX6KmsCWORskritXjHUGe9uNDBtqQqO
 QrVwYJXZkTRotrC7+ATEJXYLjX4RD4nls1jkom7dg43Aj8bOaYyu2QZFlJP+5FJjIGet
 lUaBnkRIxJLyIpVGHbuHzQ2CvsWVC9WJEYlQhu815Axls69cLzPk+KrzRaMhBaFaDn1k
 JdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228409; x=1772833209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JKn4WA063WKCUt7qQnEGcQWpweHLdAfliYY9ZUygSL8=;
 b=WEEQO9iNm5fziz9WZmEJpEr8S3hT9juAFAWJQR2FhWKRpzuMHsD60dMasXUt7hfBF2
 pFXbZDOag8jAN3XElomxRvsaMtjKqWYp4WErIeHF1PO6sMkyAFuSUqzZQ7BQB3xp8qa+
 MQHD7UAlcqe61F522eU3U+0mVX6b1wElC58qgpOeXb96BL8hb20mmucs22nmE1m6Ib43
 zD60QdJ4Gipov1eUPbi4HMuiNiyHh51jGM2m52dZ9RHC8HA3EaXUOLlFT6T20f9vNKzL
 pW0kuI2z6UjxNO22Ibh0fO1ON6U5o13VYEqZFBpBj3JmuzJ+TNX1Iq6KlpV4Ur6hGltQ
 u3NQ==
X-Gm-Message-State: AOJu0YxhoCP1bzYMNs9R/w/+n2oaCBsP2ArY1mHTIe4yCpqRZJjNkw50
 WVR4h32QnvugvQ6JMigWG/2uMrHKX6Q+hJjTFYW4/j+COj4TFc7+Lh4Rfts/0zYcjOov+M5OE4i
 nlv3sp8E=
X-Gm-Gg: ATEYQzxpfazgzC45KV0GXM2FSEAjmWXduxsqJVNkymJGsYoMP62ea4wsHT+wGawX9kv
 8oaOeTSHvdK9JkFcgNOduohzIwcDAxkwE3bizo4dIKgA6z3+hFKK5HAKrciYSQSm9VN18Omgc+x
 /ZW4ymOLqzs9kQ7Gn7k6Xvm3MMMG+5D4uIb5uMbqBKOCpIBSPTdS2hII72HQO1ddB19Ax/BoJJP
 pt2Uj5gLOfepU2izSsbUjJFylRWYDAuVkhuOt1ePrqrmWzY9zXeZO1jBFeeYsM0C0bRWlFndhXA
 MB26oWAoSX8uJOcu4t3xD78yKx8AfkEBC0TPqBjWen55M/58VmRnSHXXr5P3JEZOy3UDTsq0C7+
 vwxQYykXs5A2UVD9SMUID6EsZBzaWbtcX/OAKAhSUkTAiUpHE9u9ODBURxE5/grRG3Io48V2uyg
 64HDR+U1Ea/rESemTgVGpiFMtDVHrG8lp9dCxfxToTsPYq7CkkEMuQV+fwAWLbUfhIA/crMHW5
X-Received: by 2002:a05:6000:144c:b0:439:909f:c594 with SMTP id
 ffacd0b85a97d-439971ae7f0mr17403327f8f.10.1772228408954; 
 Fri, 27 Feb 2026 13:40:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70ff6esm14927330f8f.12.2026.02.27.13.40.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 13:40:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH 1/4] gdbstub: Have scripts/feature_to_c.py generate more
 verbose output
Date: Fri, 27 Feb 2026 22:39:55 +0100
Message-ID: <20260227213958.21170-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227213958.21170-1-philmd@linaro.org>
References: <20260227213958.21170-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Make the structure field names explicit, so it is easier
to figure what is what when reviewing multiple entries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/feature_to_c.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 3aa62fb895f..1329695ad04 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -85,13 +85,16 @@ def writeliteral(indent, bytes):
     num_regs = max(regnums) - base_reg + 1 if len(regnums) else 0
 
     sys.stdout.write('    {\n')
-    writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
+    sys.stdout.write('        .xmlname = ')
+    writeliteral(0, bytes(os.path.basename(input), 'utf-8'))
     sys.stdout.write(',\n')
-    writeliteral(8, read)
+    sys.stdout.write('        .xml = \n')
+    writeliteral(12, read)
     sys.stdout.write(',\n')
-    writeliteral(8, bytes(feature_name, 'utf-8'))
+    sys.stdout.write('        .name = ')
+    writeliteral(0, bytes(feature_name, 'utf-8'))
     sys.stdout.write(',\n')
-    sys.stdout.write(f'        (const char * const [{num_regs}]) {{\n')
+    sys.stdout.write(f'        .regs = (const char * const [{num_regs}]) {{\n')
 
     for index, regname in enumerate(regnames):
         sys.stdout.write(f'            [{regnums[index] - base_reg}] =\n')
@@ -99,7 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
-    sys.stdout.write(f'        {num_regs},\n')
+    sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
 sys.stdout.write('    { NULL }\n};\n')
-- 
2.52.0


