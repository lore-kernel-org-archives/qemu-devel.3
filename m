Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC474CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJH1-0005QS-QI; Tue, 21 Oct 2025 16:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGx-00059i-DC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGv-00017J-8J
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso3492778f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079675; x=1761684475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ILn6TZC3aXNMH7tywHnGYU/8txkiq+rZxzoji89G1ds=;
 b=NckajO6csHHrGsbglIE18S2GFUm/ISb6tJ3ZUyD9f1uItEzNsSMNnHtbgIzjaJvoQs
 TxFpPebRWAwAGEzMnlKLNv5/+Izy+rxrT8ZjtcYkHyt4D+7QfwklDNZjoBsmYBSjkXA+
 m4dSwnT5ZjhET4dARM5zmuRcwEq1nDGvqrb0uiKgEdmKlENcP5bVO11gYCEoxe0Blld7
 hLYqdYz3yqzC5Nnt0/haAPC7xh200jo9/h8LC1G99j2UjnivG0VxJn43bg/KfjXfvPA5
 rfMVbKBqM/ZZs5OmF+kCJ6R3YfyJ9yZhidZ0mVnCSbL/W7suqhfxrEhlxIygjpPslNKu
 sN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079675; x=1761684475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILn6TZC3aXNMH7tywHnGYU/8txkiq+rZxzoji89G1ds=;
 b=ky2/NQdg00d1TrQSxRHh9Ysb+tHdfF/07OlT9Fc9NvelIm8FsqXCj52D3nJzWq373o
 qORvKwKFbXkeNq7X/eu1TN9pTFhhAfqwD7gUhCuBysYSTb4K048IOCYS2Mf3M5Mdtpp0
 mLeQ2/NUcHwR3+LxPlYVuTiPlEUIZ3t88dxz3VHVBu8gi/rf7NEHFeSakvBxCJMxF5rR
 /F26N+VAKWPQKyJfTtZyyi8xeNmfruBMxyQwEzwga4ForYM/n1XZYixWj2AXRgK6wSZy
 4VyiYiFL69I4t7bvlz3VzOZUefdW6mbpbihnHKhRnCkM07z2PS2gUOtKSy4gEHHcrMLa
 SbZA==
X-Gm-Message-State: AOJu0YzoWFNm36oitKDRQO3793JSM45lI0sLhW/nDdVQfAwM9yVGIUZM
 jghwolHJ3JObWsT2ZSThVA4+Tbcvm2A/t1fFTRUL0eYk2aNcqvLk56KTVSHkkcOnNoJRQOgM5cV
 wJm3qSZs=
X-Gm-Gg: ASbGncv4ninJffiH5AveJ0QWs+TNlviCbh7Lfyb34ZF7wJYpigvfUuAKnnprkK0cgUC
 E/dFSFtITlcivPu4IZIu3Xp/nbMH+GMDbtmiVurqbxkctB+mmjdWd7xAg5oZ5pEwWOrnjoSRCzf
 XlvINEkrk+bmf8oeKNkT7zFMOWdWWgO0t6lVMyks+6SUSamI/7zMbRpFY75QOV2kciXXizweraV
 OM1UX7tBHaLwZ4VCypPz3VIGA62GVr4PZON0BjeXdFd9EOiBk2JzJ3dRypcPaOBaakaU2AdkNpK
 h6Q5nZkEbILtxsTY/b50g1tJcAs/JDDCM6rdoO39frqJU/v7tOP2n+YdIFZZjIOWZzA4HkhYxFZ
 ttuUnrNACdMJHmxqsbPcWbmALDNx/ZvPI6qqV/tQhSTpSfqVuyS46DasvsHbxVas2YnZ+t409yX
 SQzL2Lk+sAJH/9MzhpRDXP9wwglMtZKPeKYkYXfqmgCBaxgRVthg==
X-Google-Smtp-Source: AGHT+IGJ+Gb8liWynGaGYXWWq/DX/bVyMNWhIhlYLkddZzRRzaOhZ8wuAPiLrZCeNAokVY6it5iRBw==
X-Received: by 2002:a05:6000:18a5:b0:428:bb7:1740 with SMTP id
 ffacd0b85a97d-4280bb71efemr8502355f8f.57.1761079674778; 
 Tue, 21 Oct 2025 13:47:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3f7sm10897795e9.1.2025.10.21.13.47.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/45] hw/boards: Extend DEFINE_MACHINE macro to cover more use
 cases
Date: Tue, 21 Oct 2025 22:46:25 +0200
Message-ID: <20251021204700.56072-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
versions with less parameters based on that. This is inspired by how
the OBJECT_DEFINE macros do this in a similar way to allow using the
shortened definition in more complex cases too.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/boards.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a214e3322ad..b2964cf0556 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -506,7 +506,8 @@ struct MachineState {
  *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro, _, tag)
  */
 
-#define DEFINE_MACHINE(namestr, machine_initfn) \
+#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
+                                machine_initfn, ABSTRACT, ...) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -514,8 +515,11 @@ struct MachineState {
     } \
     static const TypeInfo machine_initfn##_typeinfo = { \
         .name       = MACHINE_TYPE_NAME(namestr), \
-        .parent     = TYPE_MACHINE, \
+        .parent     = TYPE_##PARENT_NAME, \
         .class_init = machine_initfn##_class_init, \
+        .instance_size = sizeof(InstanceName), \
+        .abstract = ABSTRACT, \
+        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ }, \
     }; \
     static void machine_initfn##_register_types(void) \
     { \
@@ -523,6 +527,14 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+#define DEFINE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, { })
+
+#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, __VA_ARGS__)
+
 /*
  * Helper for dispatching different macros based on how
  * many __VA_ARGS__ are passed. Supports 1 to 5 variadic
-- 
2.51.0


