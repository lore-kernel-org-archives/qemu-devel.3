Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E534CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWA-0008KX-RU; Thu, 14 Aug 2025 13:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbW9-0008Jp-1u
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbW6-0001ny-Oo
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so6342465e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191607; x=1755796407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTW8JUKYJrzyjOYJQzVwpdJf42zS48hJmAThckQDc8A=;
 b=O6X4IK5XeyPBUIXSF9Ov6gcgNFMr4/JcP3lK6PuftB6ibp6NF5K7bx8OWozioL9nFK
 ApgPryMmId0Kjfm9ME62NEgBzZIXGUUkdjl76WvteXrg+uWZD9Xy0xssQhq81p7Skp16
 Wdmy5A8HttAzsch4e053Cf4w4dbtrEivD16SeckoNI6Wjn7se6O0Bs9zswHww2j5tOLD
 T1AIfjsSqKg6DEq8ZLak4bdWyHVTt9ne5TELTzmmG1a6t0sylLGTmI1tgcgaprcNYs5M
 73+3/qwPY9SoshgBojajRIBLBhwBNZKUhorC7/8IR4r4OLOIftHoy1i5HHavcGaQ39WP
 V68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191607; x=1755796407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTW8JUKYJrzyjOYJQzVwpdJf42zS48hJmAThckQDc8A=;
 b=RBra4F1aVC0i4FzGB7/2cBbg7FFwFRUdZhZY9Lh69N+lirMtbd/yokzKaCDpTzI5xM
 7L79QE0lYMcLpSyMXLHiVxr/8jN2QtznvkYnkDolPVOWpgMurJdi27IbLXXv7GfYWFKz
 KRsOI93F/7ioFI2vVm7NkzSEPzpG5CMATAYdLqzfYMYCaOIjCs0Oq29+w6Q/lLzODE/P
 wUIIqJHa9HnslGL/tPQ6DdLVAU03R8iEwEOsT0vizy/jHr/nBplyKjzO/vS1hFHVF+Lo
 7iNhGI65juexYIWTOaUKI5Ars6qwzpqPNcidXlbUoK5Z5XoR00yietujPFJSOBtKjvvL
 o0KA==
X-Gm-Message-State: AOJu0YyDzU2gSL8W4XfEJH080mtNccD9U0KeXgVRpMfREnaY+6ktIaFN
 KRVH92M5FO7EOY9gBlDErNf4z85PKnm2TcrH+Q814Q1+H1MyQ71riFjLKpCXhsWDlFwb8HG52um
 VTJGB
X-Gm-Gg: ASbGncteeG1cwoI1kdTRyaZ/YuXF14K96HCrlYVMP66wi66JftmdTzscGNCVv2aSq/L
 PwGT0GUIYwzJnQYKZpY5bGtUVMhzHDDAzmLrvInioeddYu+3txqBSUi7RgZUXWnyHuUjgR2bUFO
 fI/iYN1s+hnNZGgIyC3N+N9ynud47UTTMJ0Tm1FCGHUVkBIMcOQ/oC/FBWPxn4lW/WKG5Ud82Mt
 2cwa4Q8JMXTqw1UiUzdp61UscZ1HTAg0Ut54G+IwPY+QuD7AAddbR+Cxx7dyVH7nzyVZ0Eg4TgF
 gta9WFLPJdw9DUX6O1PfuatrcP5CKKbPxmx937Zgv9jQVdSLk3TRDlUKbrfg5qyy0Rxkr9wrvki
 Pld0xIsBKUto8SJho58ehClDJjknw
X-Google-Smtp-Source: AGHT+IGSYI/ZYJNVuLFZVuG7TzXgclSacAgto5mgDCp5Qd/MD/u//hHKjkBeRBwcocHrRDQkDS3N2A==
X-Received: by 2002:a05:600c:1c1b:b0:453:5c30:a1fd with SMTP id
 5b1f17b1804b1-45a1b61e3a5mr28262765e9.8.1755191607227; 
 Thu, 14 Aug 2025 10:13:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 1/8] docs/sphinx/kerneldoc.py: Handle new LINENO
 syntax
Date: Thu, 14 Aug 2025 18:13:16 +0100
Message-ID: <20250814171324.1614516-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The new upstream kernel-doc that we plan to update to uses a different
syntax for the LINENO directives that the Sphinx extension parses:
instead of
  #define LINENO 86
it has
  .. LINENO 86

Update the kerneldoc.py extension to handle both syntaxes, so
that it will work with both the old and the new kernel-doc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/sphinx/kerneldoc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 3aa972f2e89..30bb3431983 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -127,7 +127,7 @@ def run(self):
             result = ViewList()
 
             lineoffset = 0;
-            line_regex = re.compile("^#define LINENO ([0-9]+)$")
+            line_regex = re.compile(r"^(?:\.\.|#define) LINENO ([0-9]+)$")
             for line in lines:
                 match = line_regex.search(line)
                 if match:
-- 
2.43.0


