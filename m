Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D8BC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9d6f-0000wU-NW; Tue, 29 Apr 2025 01:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d57-0007o4-MY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:35 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9d54-00062n-CI
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:00:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224341bbc1dso59548915ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745902828; x=1746507628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihSbjG4MVG/rPWJxnirZVcYWQR5uI9SkbcEMwpHCSZo=;
 b=VpVb/4AZ/vtUdpFDGf3OhCWDxVX34HjdFscz9GftXYLqQFgApJh+SV8dvSXip60eAP
 uAvNgFRVOXKwpl0FrvZLSFTKdcX9vesINlyOIeC/x+cOkNmDeyCFQf+1qm3feXtMIt12
 xcIzBLzoS/dXfILZOAyNdxHXDOkI0lZVlZ6CoMfL0UFZCShus9J1sRAz0H9BuUMxdLV8
 kdgFOQkF7qJoxpcQNLYf3M4LBwY77c7q3LMWAPly287PRrCyFEtsbojEFkvtF6SgPYEg
 uDUSEsuLTbQFoogCwfgK2tsrYYIQshf/ox9f/1y6sknE50rTJSLc7XpspITb0PLju4ZY
 KScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745902828; x=1746507628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihSbjG4MVG/rPWJxnirZVcYWQR5uI9SkbcEMwpHCSZo=;
 b=AQ9omwqDQpgHsy9IPIeH57zsRomXnW47BJdPOPR0VFuEe2KhMcIgEcqhpsvLMPAr1g
 MfQJLQLhgTkPtcxr90aSwNf9MFe+yEs/EwvF1vKEeo4tjGAOJ82Q3NhNMUQfJB954P59
 vyHfIfra+ESWdM6U73oKehSliWuF6xm+BIHj20mcxVfg0z6dv2N3bSwxE43o+tzVIvKw
 /wl3jsyjllj5vkGuuyVpeQJ2n+K4Yzu69POBeU6PTNZjdmQ1qJ3WOZrprIX4kA3JB47Q
 Fgkn5FEEoqh/2VXekLz9qAV5GA5zL9oXvJjOcyZqpxKghIsWWmQrVzxoEXdjQbogPlKJ
 iKrA==
X-Gm-Message-State: AOJu0YxwQU4cBlmVfmbqrrlPjk2U/Wn3KwSaA3A0DuYMwleiNkiIGLhw
 6t9oyvbVFRdqDHKIbPv8vrgeotz4K8lZuLF8NWBnr+5tHAgmCr3umlfAvd6PcjG8mOkd7aAaEdm
 h
X-Gm-Gg: ASbGnctUd7ls+5MREuUzSOEaBqv0U0rmCZtVVZjDhcOQW806XXKr2qsZRR1oS+oDTKz
 lQA2jhd6eES2BH6h3SHJvqEujCQBB6IeGC/V0821SyI7uWTLua8YhlZXFdXULv2gjFpNfsgK4J/
 4p6WXtHVQtAvXQI0r/NEIS/mT9NGoVLvYieJap7Z2F9OW6M7oZSliNmuxMe0l3ZkVUNx/lpka1r
 rRy4hRlq7IGW5nKTSigyDejwRo4fZ+v8cazVd1GSdSaBSuZpGWIGlCtxr7lwpFuu2IKN+hsO0Gz
 QhdO2JsZKNNHz7eaoYYPqQ/PNzQEJiJsL2He8vPX
X-Google-Smtp-Source: AGHT+IEKl36/YxFSXyEEI7I6vw/C5AE7dte38/aDWx18O4SHf3AWwMBIzGuoDNMnlOWkHNEFDjArGA==
X-Received: by 2002:a17:902:cec7:b0:210:fce4:11ec with SMTP id
 d9443c01a7336-22de700725emr25054985ad.1.1745902827904; 
 Mon, 28 Apr 2025 22:00:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd6f7sm93004015ad.76.2025.04.28.22.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 22:00:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 13/13] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Mon, 28 Apr 2025 22:00:10 -0700
Message-ID: <20250429050010.971128-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

It could be squashed with commit introducing it, but I would prefer to
introduce target/arm/cpu.c first.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 89e305eb56a..de214fe5d56 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,13 +11,9 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64',
-  if_true: files(
-    'cpu64.c',
-    'gdbstub64.c'),
-  if_false: files(
-    'cpu32-stubs.c'),
-)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c'))
 
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
@@ -32,8 +28,12 @@ arm_system_ss.add(files(
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 subdir('hvf')
 
-- 
2.47.2


