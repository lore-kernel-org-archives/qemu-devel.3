Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD8C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcvt-0000np-Ma; Thu, 01 May 2025 19:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvZ-0000VW-6a
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:51 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvX-0002Of-7s
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:48 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8616987c261so49680039f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746140565; x=1746745365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLFAH/NqarXgrsQtC/1/f6gfkvP7AQL3VQJbCki7bDU=;
 b=sU1J6FoOAdwpyd7OLhODtuj+ddzkCojbru6gQF1X/qgCuiGV/lJGvJOef+AT5xQaEd
 tnxfR1p6LGfu+WBRnnYy7Q9MgShkqyi5Q4gDtOmwmBL8M6WO0m2yK9/EQ+uy45eUg5Eu
 zgSPROfW4AmxLfh/HoQ+3Jj4FlG7gvF9Iu63pmBis3L5ygAnr0lx68DhvMwgtuXip8Ba
 rE2IM9Ov0KStJnFCFb8QLffLQNGOwuUl4TwOgx9Y1/oztA16TOWl3JygkHO2tQOvhbZj
 OCC+2sIElkAG8a6UKaD9lh3TyqLx+RDmhHdv1pjipnx811w5uFGocZx3ZFT9xKXWwbhJ
 cXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140565; x=1746745365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLFAH/NqarXgrsQtC/1/f6gfkvP7AQL3VQJbCki7bDU=;
 b=IYCCJjgWn5a0XFUUsNvbQ0eiT9nCSYESfGfmpK95tCLdXJWOU9mDxV93ZehZDJyW79
 xbWg/UDp01su6RLhkor3eURtCp0LQjG90SBJdIMe4XUK3pTDjAIhTju4SngK02YUbGO4
 GiQnTItPVseu+UuUw0VrSTgV7841FcDKY81W9Bv1QmuYg1JNGPykoNqooIRYGK9Icham
 +IZNu0BKO+qpI+xAFmnAyguXzVKNd5ORZ99xuH4hAbXu1wnYYbHQlcnav0+2rHJVJuNH
 XR7lXN7vwksaQgsJP6TOqeaGwEfmvMpLjrCrjRW4zDzSuk4DtQ5vZzO/vsxd75OiWpae
 WUKQ==
X-Gm-Message-State: AOJu0YxG/K1hIgc6+0pGN8dyj53vLnvBIZ0iUk3DNN4LDZ1QCL/yfPXY
 cZX9tseYvuICZa4GdjUOcgNxqri4gIyOOSAqSEqB3znyXM3z+gmwMmE6Bfc6pbpMUNBukw2vaGF
 U
X-Gm-Gg: ASbGncuyL2cWPjuVgK7CpJEeYOPPfmdRpeHlvbYDt2+veVXo2WwJ8VKqnXxbay20Zg5
 AvZ+TJzBdEXIfzUX0UqkwSLHzZ8YNmSwgybgrhrQWiIok50DP5PAtIIhusL08WY5iVKL/X9kv8u
 L0Lv8M6e9Dh3goD+AWfLYhMo8AOTpmCj8a+X9oR1Kny3pPHG0dwkF4rY6RSWo2BZLWJV7HUWZyV
 CloRYRnfgseTJ+YKw2GUG0de6IgspZ9JzzK5hIBmgGSBzRkQw/f+gOqRRt4Me5bQrWJb/eFnQFi
 aZ/7JpLbFha7sxtEK37Gik0zuMsqO7BN3+PiOkv6XjaenvQtl/yKRfwQzIgTzZXU1OfiRTYj/5p
 vVWmFlzKlFyA12dTZoMLi
X-Google-Smtp-Source: AGHT+IGgmmWM99UmpdckW34tyYCcbd+15JXp+EoyTz4gVfJS06+YjsFeNkK+u13num76/hcXoFpoqg==
X-Received: by 2002:a05:6602:750a:b0:85d:a235:e90e with SMTP id
 ca18e2360f4ac-866b43fb92dmr104507039f.13.1746140565268; 
 Thu, 01 May 2025 16:02:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa584729sm28140539f.45.2025.05.01.16.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 16:02:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 08/10] hw/core/machine: Remove hw_compat_2_12[] array
Date: Fri,  2 May 2025 01:01:26 +0200
Message-ID: <20250501230129.2596-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501230129.2596-1-philmd@linaro.org>
References: <20250501230129.2596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd30.google.com
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

The hw_compat_2_12[] array was only used by the pc-q35-2.12,
pc-i440fx-2.12 and s390-ccw-virtio-2.12 machines, which got
removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 16cef33beae..7b3f7878625 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -823,7 +823,4 @@ extern const size_t hw_compat_3_1_len;
 extern GlobalProperty hw_compat_3_0[];
 extern const size_t hw_compat_3_0_len;
 
-extern GlobalProperty hw_compat_2_12[];
-extern const size_t hw_compat_2_12_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8f1b44b70f7..4ebefaab819 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -221,15 +221,6 @@ const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
 GlobalProperty hw_compat_3_0[] = {};
 const size_t hw_compat_3_0_len = G_N_ELEMENTS(hw_compat_3_0);
 
-GlobalProperty hw_compat_2_12[] = {
-    { "hda-audio", "use-timer", "false" },
-    { "cirrus-vga", "global-vmstate", "true" },
-    { "VGA", "global-vmstate", "true" },
-    { "vmware-svga", "global-vmstate", "true" },
-    { "qxl-vga", "global-vmstate", "true" },
-};
-const size_t hw_compat_2_12_len = G_N_ELEMENTS(hw_compat_2_12);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


