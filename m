Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73635E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMtN-0007pe-Bi; Thu, 02 Jan 2025 10:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMtK-0007oZ-Mj
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:42 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMtI-0006dn-JZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:42 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so7129239f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830818; x=1736435618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W41W/Tl402O4BPcR7bbkn9vt12o0/ypJh/X89Ny0z9A=;
 b=uXV7posbXSM7jD0jdFdmG0DPGzUUIeFdHx/6s4BwfoWyNz14s7TubHd5MEhawbYvYd
 2YANSNCmSTK/NMJiY4uKpDr4oUgDqHCxVkUdcZY5cKSi/lr37AFpLA7+/9d3R5SabOY1
 LaWo1eN1C/o6MdrBET4qOsU2D7GS7LtOvH0opwY2080vf/4LA65SgsHfVQ8PmnyCXpOh
 1QTJR9kvrYCMm5aZajd8W2zI9A0jAUE+4h8Necy/TQOVdlXUZAW8ySCoc+ouRZGp7Zti
 0UTD6EDTdBWYXwVDfmA1+9aUfqP6Tt0veLNGXrHIAxzi8BKGBCgywHsWDsBEVaGzEp5R
 N4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830818; x=1736435618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W41W/Tl402O4BPcR7bbkn9vt12o0/ypJh/X89Ny0z9A=;
 b=Mh2sCdPdul1cRuWAIUARis9YdRd05ITi8QuJHjeXeRgkoeu+ocWZ1bgoo1OPja8p1a
 RMZaay8y/z9s18q7Le/O2y8SYQqLo2TQ+UzSEIzPpe+VYfWHxThPnFD4BLPYTbjzeQRb
 OMBg6Sd9CiSoYalDoZGC3W8lvPEVeY0aXS35oIbwQ5ea0aUFh7XboQZBx2yPESB/NMSS
 iKbP7BfngWY0dPaXvBD7pGPN5t3X8iZVZbF+m8PRRtS++iop5cSM+DexHknylp6Agb2O
 g9jJoxmYvogJBdssvNPLK+lQX28OH3BABvOPEk4OWOwq1N9WTDdT6bcAL5p4kJFUKPwq
 3i0w==
X-Gm-Message-State: AOJu0Yy1nIUdze3uOWC8xnku8hk5P92ToSL1LSTN+IPqEewIYsJUAmnq
 YZmgVnxyoSqwzUc3aAOl3Xcu3m6jRYwCCokLS8xJ/ocaEd09S8I95e154kMw6aWZOLkCJaJwoa0
 nkim/ig==
X-Gm-Gg: ASbGnctUWG8ZaMu8u0NHQjGoto8ki8woVkfM0vGckdbmdRvQyEV/gFvkwL5bCiQFHmD
 X3N3vVMp5H//dKzziaxoL1HpbW/sm7u5ej9LXuc7kSPf4cDJnjSUz7E/CFDJoyzdM210Xq/PvoH
 40xZ/7BJjuV3PTdC5oWhuSiyuVdVILZBXZGda0zswMx91MO1q9WJplZLFxKOs7Eto/+kb9Qvis7
 770JF9arjwFUlLY4C4AYqCcdx+aJBGCPHRqCQtkIFltEzm8ORQJz070jeeL+c9nJvJw/20H1x9D
 Hi58Iv5p2m5d2zxHvEZL9fU3u8Yg2kA=
X-Google-Smtp-Source: AGHT+IE1nRk07c+J0yGcgvsxpMlz7dkCVcaPszQPEbHZPG2NLpSenZnu5t2YzeEb9DHfNK9SawTOEg==
X-Received: by 2002:a05:6000:178d:b0:386:37f8:451c with SMTP id
 ffacd0b85a97d-38a1a1f74e2mr38158314f8f.1.1735830818553; 
 Thu, 02 Jan 2025 07:13:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c829235sm37735173f8f.15.2025.01.02.07.13.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/10] qdev: Inline machine_containers[] in
 qemu_create_machine_containers()
Date: Thu,  2 Jan 2025 16:12:44 +0100
Message-ID: <20250102151244.59357-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Only qemu_create_machine_containers() uses the
machine_containers[] array, restrict the scope
to this single user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 933ad83a935..58e68b98d87 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2114,17 +2114,15 @@ static void parse_memory_options(void)
     loc_pop(&loc);
 }
 
-static const char *const machine_containers[] = {
-    "unattached",
-    "peripheral",
-    "peripheral-anon"
-};
-
 static void qemu_create_machine_containers(Object *machine)
 {
-    int i;
+    static const char *const machine_containers[] = {
+        "unattached",
+        "peripheral",
+        "peripheral-anon"
+    };
 
-    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
+    for (unsigned i = 0; i < ARRAY_SIZE(machine_containers); i++) {
         object_property_add_new_container(machine, machine_containers[i]);
     }
 }
-- 
2.47.1


