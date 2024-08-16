Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E4BC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 10:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1setua-0000JQ-WB; Fri, 16 Aug 2024 06:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1setuZ-0000IY-82
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:10:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1setuW-000267-OR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:10:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2021537a8e6so559885ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723803019; x=1724407819;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RQfwFUn43XTGvvnAF92vxroN+7TSaI1PGyFGfLRSZUU=;
 b=NYSA32F9yzBXXkIezrdEEuhtKeKB4N3PmXhydl6s93K6Vh81ZlqMfylnoVjC/oGEm+
 P437am5cdLdWZL3n5zmVq5wgXiBpewolW9CfUWVFzmDts9hK+Jb488t/LwaYYz6Lo4kL
 4p8UfkX2M+RqUPI1zCQd0yaAG6gQHNl6hOuVRNS0lFX4Iyd4Ajkly1pVID5DFQJq0625
 3h751p263K4xUcJtNEr6ZytXqJDjRugZ65L8LjTdOyO6tWOxPk7WYCT3zuO8dSSHTnkz
 FYukPFAEnHE1pBAj0On6muUSPd5Zv14JloMQAHXFM5e5nEFPxMcPAIOL0MyVA9reLnYa
 umlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723803019; x=1724407819;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQfwFUn43XTGvvnAF92vxroN+7TSaI1PGyFGfLRSZUU=;
 b=pP27/X3IN37apgVa6XGf+dh6b2DtqAloBjSRRA/onwn8EpL00InjfEOlX4JGAQYjmB
 IT+WnqrdX75ij47oObWp8CqWtCnhcK2w9VZC04UgXKOOncXU68q7/XFQ4t11Zmv5vpSE
 crGLIu6WVvvqEn0F5pOIN8Du8RQvKGqHO0g1kSoIVvSHMLhSGggFL6Jm+JkZd1KdfnBq
 cObMYSpyEllmVW+DpJsoEK6J3qb7PZitJQi4QK1p2h1ifgFUr1Fd5fL8HxNTeK+pcspF
 bLDZN/gPtaWnLDnn6Eu05hFlj5fAaMR/aHTBGo2mnUU92X+egB2GrzwOxPjTT4iul8TZ
 3elA==
X-Gm-Message-State: AOJu0YxEZgA8CkUA/WK9Ispl9k/52vJ14WUL1dA/qKDxcRcGNA4SfuTF
 wKvr9Mjc7dpYxl9HMHx3svXs58wOSv6du73DzR/gE5Pmy9MFUI7Y+SrkWfMfsy4=
X-Google-Smtp-Source: AGHT+IEzoZQz/znQcowjrHs4aUCOomaHLnlOlOkkGdlPNs8zaLg/rNPeIWxbzTEFb5/1BZGbw/qLww==
X-Received: by 2002:a17:902:cec9:b0:202:75a:4184 with SMTP id
 d9443c01a7336-202075a4492mr21845695ad.22.1723803018947; 
 Fri, 16 Aug 2024 03:10:18 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201f0375626sm22711715ad.156.2024.08.16.03.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 03:10:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 16 Aug 2024 19:10:13 +0900
Subject: [PATCH v4] meson: Use -fno-sanitize=function when available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-function-v4-1-9ba0f836318f@daynix.com>
X-B4-Tracking: v=1; b=H4sIAIQlv2YC/23MQQ7CIBQE0KsY1mL4HyrVlfcwLoCCZSE1UEmbp
 neXdmONLmcybyaSbPQ2kfNuItFmn3wXShD7HTGtCndLfVMyQYaCSRDUvYLpy4jKhqORyJXWhpT
 5M1rnh/Xqeiu59anv4rg+Z1jaPycZKFBjUBktQIJWl0aNwQ8H0z3I8pJxI/G0kVhkKUFpqDVn+
 kfyj6zhuJG8SI7OIVa2qpj9kvM8vwHYCm6HFQEAAA==
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
-fno-sanitize=function in the clang-system job") adds
-fno-sanitize=function for the CI but doesn't add the flag in the
other context. Add it to meson.build for such. It is not removed from
.gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
does not affect --extra-cflags due to argument ordering.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Moved -fno-sanitize=function immediately after -fsanitize=undefined
- Link to v3: https://lore.kernel.org/r/20240816-function-v3-1-32ff225e550e@daynix.com

Changes in v3:
- I was not properly dropping the change of .gitlab-ci.d/buildtest.yml
  but only updated the message. v3 fixes this. (Thomas Huth)
- Link to v2: https://lore.kernel.org/r/20240729-function-v2-1-2401ab18b30b@daynix.com

Changes in v2:
- Dropped the change of: .gitlab-ci.d/buildtest.yml
- Link to v1: https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
---
 meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 5613b62a4f42..b7e50358a88a 100644
--- a/meson.build
+++ b/meson.build
@@ -483,8 +483,12 @@ if get_option('sanitizers')
   # Detect static linking issue with ubsan - https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
   if cc.links('int main(int argc, char **argv) { return argc + 1; }',
               args: [qemu_ldflags, '-fsanitize=undefined'])
-    qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
-    qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
+    qemu_cflags = ['-fsanitize=undefined'] + \
+                  cc.get_supported_arguments('-fno-sanitize=function') + \
+                  qemu_cflags
+    qemu_ldflags = ['-fsanitize=undefined'] + \
+                   cc.get_supported_arguments('-fno-sanitize=function') + \
+                   qemu_ldflags
   endif
 endif
 

---
base-commit: 93b799fafd9170da3a79a533ea6f73a18de82e22
change-id: 20240714-function-7d32c723abbc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


