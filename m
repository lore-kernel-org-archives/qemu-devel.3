Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739B4C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ4-0000bO-GT; Wed, 07 May 2025 19:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPn-0008Ri-QP
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPl-0002WR-D4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22e16234307so5430895ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661380; x=1747266180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=ppwYyxQQg87cGTiCiCms5ApMZ+EQ6JApgAxV63NCc4aaPDWYS1t4c9r8MtNgZpN+WT
 AU2n28NRGHYWC2Jy3go2Do8SmKK9wGhzLzlSBhJmoJQ7zg1B/6r9br7A5oMwo8m+d1Nb
 clS5PC8UvWNQ6TIU7z4vqY9PePTsVgkxFS5BwSSVQXzxHix14bHt+yIIsb5O2ikWzYTj
 Bsb8Jpi1CqnBPIsH8cfg1sezhnARE639BfXRvfwRRCRA5Qq0FNzivwI5wA2UXhj2oFVo
 jOEe0UyduDxh6bDeX0mPU7yeH0kCRdoPWrMwV5+QDgh5YDs2sbSepfgoeg9M7nI3r1v0
 2B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661380; x=1747266180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=qeKEOq+PoXS1TV8RXbWXqbxU0rs1Cm+SPKlHxerYOgIkf81JodI3+3UcEiR4n3SYMy
 cEu+h3PZX9kmRrkJj/K6afAZH2XlM6wwUB8b1x3vUQYsi4mFdZaZhSEy8Cfj94gJXndK
 b+dBvCIJuVB8QSGxuA4yq4Z7JxpynQHi0ftQe0FQD5gm0I9z5rfoCNUl1kokRgUfNWOn
 Y/3BB+sb8gLVNgsIjxeHidAK1zlSSkvhgsL5qKQL4X4kwaFk5eEdBeWiHGwTvZ2cI6CX
 qXVaBAxt09+S872WUJS7S9plPmm1fNvX9II+uZX0HufCQZ9p0H+e/WoEkPKJzUtxqVxe
 VWYQ==
X-Gm-Message-State: AOJu0YzCDLMuZN3jCAgV5xKJmhkiu/FvtyFZ7NpYP3KIxlEddUCzqLUa
 +R+JopO3mE0Con3jIspgfKsJ2BGESlZF1LdmRi9G0tj0Ma9wRhciQUVXu7dO6moTVjUJuFxsgBr
 WKxlT+g==
X-Gm-Gg: ASbGncvtQ/2vueuvpKp1J6TapGQkBqreXp3MZ01FWEoTYboADHyl5SljcdaPsCyMPVB
 WcLRJSEe+r1nyeen9BzDNk8K8VdkLdttOm64xG3L4atH7Kc1LS1pvvZrOxwVq3ucNJw62tdAG3I
 GNXTHQPhFMNs/LXT2B0XT/qxt/krdvIKBw9QjvQVW0NN4duX59yJP6lVidsKVZ1EPrqnG8T8hu8
 /IAAuqeruj/EYSeZWSl4vBRO8cF52znFklnyRbc4DwhRIoiP5qYXKAiRbHnrtMNQqSDSJc3PqKG
 IoVj2jV0Q0Ki0MfGheSZKM3pwskZFJb8qB1pWA68
X-Google-Smtp-Source: AGHT+IFr6AonYuZbiOdyHtNzMRkQACG1nPGT85mHzH8LSDoJ9GfVu4Ipl9+GAoDhcc3RgvKKndBmow==
X-Received: by 2002:a17:902:e5c1:b0:215:58be:334e with SMTP id
 d9443c01a7336-22e846e735dmr20084035ad.10.1746661379975; 
 Wed, 07 May 2025 16:42:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 19/49] target/arm/debug_helper: compile file twice (user,
 system)
Date: Wed,  7 May 2025 16:42:10 -0700
Message-ID: <20250507234241.957746-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index de214fe5d56..48a6bf59353 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
   'vfp_fpscr.c',
@@ -29,11 +28,18 @@ arm_system_ss.add(files(
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
+  'cpu32-stubs.c',
+))
+arm_user_ss.add(files(
+  'debug_helper.c',
+))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(files(
+  'debug_helper.c',
+))
 
 subdir('hvf')
 
-- 
2.47.2


