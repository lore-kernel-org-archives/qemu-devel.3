Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B614C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcv2-00007u-0z; Thu, 01 May 2025 19:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcuz-00005z-VE
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:14 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcux-0002HV-73
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:13 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d5e43e4725so4068335ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746140530; x=1746745330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71cRgUxX/xvkQOIndCsIbPhvcAM9aTUzOonse2qZKrA=;
 b=mgkIZE04GSyocR6PPP6lza7MAKZy3C8ca4U0N5nT6kmMw/gxTeCtv5W1CyyidWGEgJ
 4bkFS5MByHX2qHVjKy3Li8d9GYkg3ZR/sB/DZAbfBjmAU5X9cvB21p4jZcnq9gwJWYvn
 rhDYutjZLaNdN8D/1wL40kI5JqDIcHT/cP5pEEKGUDsMROW8IOLL5W+dpFOkRgQG1Ovh
 tqALGoJZkFEmikt8k4kUJShDrg9+ZlVBFd3EfA/LzWyI82QN81p4LgFUUH4aQGnTsfdb
 oCI5fuxkAzkFKM5aOCfo64Qcbv4tBTC0pjCv9ionsNYOf9wgY1V4aeb4JxNfZ+g4ABMT
 6dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140530; x=1746745330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71cRgUxX/xvkQOIndCsIbPhvcAM9aTUzOonse2qZKrA=;
 b=afRYOLnD5a45z0dlug9xjkYZ6TDP6rIbfZNcFIxWU49SEQmVhwmpK9Epk+EwqIP40c
 UR/ccXWHa91s6bl2x3XE8JLqLCEXWZeWpAVUsBax3UMPK6QUwdqVqvP+A7GGn7q/e/63
 BVgU95/w8uGtmPEqt9ileNbHp9nEkL80UaD5HGgHmNLw5Nl7sR+DyfkZXIPIQJdKj01P
 1RhdxoJ8aNiZM+knlNO0WPkrMYixsOaKTEs3+ZdczZkJ2aFJbzOv7OQyPZA0418skY6t
 zOsnfVQUTqrKetyx/FPkf/3TzmZb/c+5V0u8q5TPfAq5dk0lnKWhmobBlaJ/30BMFrgK
 DeaA==
X-Gm-Message-State: AOJu0Yxi2LURW3Q/A8Di/6rk6tE0irAnHS0+fAH9kf/NGCaVTKJ/CtUP
 vOSisnK2t7oCUXivrFzpzdetRE0EN7l6foSgB9x/2DwXmvKlWMsCi09F0PY1LKYHjETQ7jXKJDk
 Y
X-Gm-Gg: ASbGncsDF4n/HsY/onlwZIQItW2bIxTYueVp9mz76RuKgzJE5NhwVwyOZ6dYqbvfJb0
 EjUE46qTRRuB8D0lRvfDAzlthd+eGhf17P5IqnRE/J4/Da1Maf1liyI47XYis/4UmaUgb++ESSO
 NBnsRXRBUeucFXPFHnV2ZT63AOwv49/4DGTiM8RSwFv0/m6d6P4/SVVRpRHW3pSqfItuQHmMp/b
 E0XBX5dLRTmbhNRvzVixuMxhB1lZjbdxXXctlunUXTQ6KLxp8ZLF/WaGHycEeOVOL/osx84whe7
 0HuaYxyLQ6gqi3qOQWe9wn+hgxxSUu0ExLWcC+XtaBwls1oxgmr56jRh8SMSNWnKT7mWFgNTI+D
 76s5JPJVeV7XFa4QPXY6B
X-Google-Smtp-Source: AGHT+IEksWUSalHmdf1L0lBrQ4kJnb1Zq0e9zprZ1OTx3tRVCreMHfEejwW82x+JiiUe/xwS18W23A==
X-Received: by 2002:a05:6e02:1f82:b0:3d9:6756:14b4 with SMTP id
 e9e14a558f8ab-3d97c288232mr9587435ab.18.1746140529786; 
 Thu, 01 May 2025 16:02:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e7d0c6sm3679665ab.27.2025.05.01.16.02.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 16:02:09 -0700 (PDT)
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
Subject: [PATCH 04/10] hw/core/machine: Remove hw_compat_2_11[] array
Date: Fri,  2 May 2025 01:01:22 +0200
Message-ID: <20250501230129.2596-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501230129.2596-1-philmd@linaro.org>
References: <20250501230129.2596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The hw_compat_2_11[] array was only used by the pc-q35-2.11,
pc-i440fx-2.11 and s390-ccw-virtio-2.11 machines, which got
removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f2f58ec4ed8..16cef33beae 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -826,7 +826,4 @@ extern const size_t hw_compat_3_0_len;
 extern GlobalProperty hw_compat_2_12[];
 extern const size_t hw_compat_2_12_len;
 
-extern GlobalProperty hw_compat_2_11[];
-extern const size_t hw_compat_2_11_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 816d503b2a1..8f1b44b70f7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -230,14 +230,6 @@ GlobalProperty hw_compat_2_12[] = {
 };
 const size_t hw_compat_2_12_len = G_N_ELEMENTS(hw_compat_2_12);
 
-GlobalProperty hw_compat_2_11[] = {
-    { "hpet", "hpet-offset-saved", "false" },
-    { "virtio-blk-pci", "vectors", "2" },
-    { "vhost-user-blk-pci", "vectors", "2" },
-    { "e1000", "migrate_tso_props", "off" },
-};
-const size_t hw_compat_2_11_len = G_N_ELEMENTS(hw_compat_2_11);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


