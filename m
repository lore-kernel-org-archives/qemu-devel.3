Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C66C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOjT-0008El-4l; Mon, 12 May 2025 04:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiA-0007JE-Dw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:36 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOi6-0001if-Ki
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a0b9625735so2089791f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039223; x=1747644023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2UGc10la9ot912AJoqwkd5n8Ckw6i6P0LfGrrfI+a8=;
 b=rjRv+/nr/LWntTlVN9G9XWIu6mhGB2cMua8BA6TOFWkPgmEQqu0FIqAq1IkJOX/ThS
 BLDlRKWXbHiqVrdUefuD/ekGth6oCNtiSmEunpAn9Fshi930CV8e4bGju+29tlP+iz91
 KbqeEQf1gDktVZifzfcli1CCKDLLw0OL8QZ2Y/yxLfamWuZRsFAP26I+ONjE6VqkuBgz
 hIhGgkLby1aD1+J+MryG//6MEPOdqjk6Pvr0l739tAY/VwCXTWhoxTWIRrXT586Cr2K5
 kHSYGg4GFSgdCrA/hgI0KFwDYWyEDfJjR0w7EBE43CJxlgYx93Nc/8KQBUAjBQibPnW4
 LqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039223; x=1747644023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2UGc10la9ot912AJoqwkd5n8Ckw6i6P0LfGrrfI+a8=;
 b=DzTL03Eu9e8CVxwaHtS35kREhn/MC1xb7y+IcwGokHELxHP7sbJgh2AjdC7Lzkljn4
 6Qcdzmq9jXiqmpAQkedSseQmMfe+AAVk+w6OaoKjQFwHDJ1S+kEmN10CsaEko0MwDQkm
 bEtpTfvfFHIovC7zaF/zhaSWl8mMNJkYtNyhpNi6TKV6SNo9uqwGeUfIXPiWvcXNmaQk
 +b14R2U968iF2DT94JcZ41qnuvnuRuD84SJqQydzg10ErX5wjAUhIZ4OfiOmxbcgBuOr
 idnPYuKqelp4wxuOi9DMT1kQtX77VFdtAgEFdEVR3jlN1BTZNMiNgmjlUoIEWMRjvMZ+
 Ivng==
X-Gm-Message-State: AOJu0YxJ8JJpvOcyw2ykesKVKxPEntuzM8jhuvT4/j0kwMDytOePBnpS
 aGxxZgFRYLAzclva+XZNcKsGTwEMB8mXH3CJPaAQE0/IQAjiN6RXjyiACGCtS6QuKf+OWX4a+z4
 bSG/z8w==
X-Gm-Gg: ASbGnctXqs2bcXYtIEUrPhfZKh4MfLK14IC9vxZlCt6Est2WmDP37SE9MEN8HgtvnQu
 EhTyVPr4eoAWQwBJ2e3EmmL0gADC+vWohL7Fdcr553iyDU3NyhxuM+mokEHrBluQD+1Mqrpouyq
 73jUpgoqyvu9yUzBbNJLnEnQwutB6Qb5mXhxJ1eltj+xY34CXVtgZaP1amw4gn5e6wLRW23yfBM
 V2fCsd6k7PVKgzrNTZmfQZP4O95FcAgPTL4uj9lYLvZ/6CiIKn4GV3Zyxamq7bsMgjUGqCt5s4c
 BmspOA9iv3Df8+ZnRYEW7qyIx+URidHHqGPWiFz0wpcJEgupHuGMEzf7Fd9PQGx9VhuKdqf4687
 KjcffCgqOwQZ+Zav5HzV0AKE=
X-Google-Smtp-Source: AGHT+IHd5zI25DsVmiM5eatiigGUfEGXK1H7xE5Tkzfl2YkOIPHq7I9mHxEs+LxdnBg3bKI5B/M/Og==
X-Received: by 2002:a5d:584b:0:b0:3a0:9dc2:5e0e with SMTP id
 ffacd0b85a97d-3a1f6422323mr8805512f8f.11.1747039223100; 
 Mon, 12 May 2025 01:40:23 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebe00sm11878677f8f.38.2025.05.12.01.40.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:40:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 03/19] hw/i386/pc: Remove pc_compat_2_4[] array
Date: Mon, 12 May 2025 10:39:32 +0200
Message-ID: <20250512083948.39294-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

The pc_compat_2_4[] array was only used by the pc-q35-2.4
and pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 19 -------------------
 2 files changed, 22 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f4a874b17fc..b34aa25fdce 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -301,9 +301,6 @@ extern const size_t pc_compat_2_6_len;
 extern GlobalProperty pc_compat_2_5[];
 extern const size_t pc_compat_2_5_len;
 
-extern GlobalProperty pc_compat_2_4[];
-extern const size_t pc_compat_2_4_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c8bb4a3ee47..2b46714a5ac 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -262,25 +262,6 @@ const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
 GlobalProperty pc_compat_2_5[] = {};
 const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
 
-GlobalProperty pc_compat_2_4[] = {
-    PC_CPU_MODEL_IDS("2.4.0")
-    { "Haswell-" TYPE_X86_CPU, "abm", "off" },
-    { "Haswell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "host" "-" TYPE_X86_CPU, "host-cache-info", "on" },
-    { TYPE_X86_CPU, "check", "off" },
-    { "qemu64" "-" TYPE_X86_CPU, "sse4a", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "abm", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "qemu32" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "Opteron_G2" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "on", }
-};
-const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


