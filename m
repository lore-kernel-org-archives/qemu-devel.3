Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCB4C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYno-0002PS-Cj; Thu, 01 May 2025 14:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnH-0000KZ-PA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:03 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnE-0008Ad-K2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:58 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85ea482e3adso82855639f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124675; x=1746729475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVL17Qw9Pu2E631HFpa6VOArtgxoydyEsXC8wSAHBfg=;
 b=BAd41zSkDlk74zr7cp5pRMBxqxvCoQYA+zScB5mrYS3sQ0Goe1IlARGtIHIXwqJwY3
 sOJncMeISF1mGy3fN650UOL51EbsIgbB4Z+3eAAH23w78eGBI/6QtPiLZLWo35odfMy2
 zua3n9enr1ytPFoDj6IH4W7oQUJp+9L1Hj/dO8cidQz5WEQUDDYsKbx2GT1zPSvvQxV/
 G/rijq8O+dRMf0cojqeNdjzE/orsgyFm452QN2GHYso0qIdGvakz7TP+yb8WbHlWfKFk
 aCO4fIxeWmtK/I1/O0TNzblWJVydR9s1BnsnHAKCYgQsxebQiyocCtf1xWoHxLqpZYx9
 Evsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124675; x=1746729475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVL17Qw9Pu2E631HFpa6VOArtgxoydyEsXC8wSAHBfg=;
 b=Tid5GDF0y1iYsCj2TNgIaGaP1ylAhdWPDouvVh20hekzLqJ6Uq5r41v1ilmt/35Y48
 S4uBcl91I7eQslbkxlKExJFblcEmoPGR7uYrCyHj3D/mmI2tuseY5tptO2M/mG73IPjD
 NgrEgHe6iOpKvFkW8ptVieWEm1N/topRhAyLpzoUqGPJunrlVz8jvaEUjHEJG887cruJ
 2XLydb0gVPdwDtC1NYHvh55B/J4gvHltNdx3E5gX7VynGeaCLC0E+bXKY35oVX49z/QD
 E9JY8K3WD17S6Y1SJopl+OXbBDXYiQjRBzRp1AhYFKJLTohes167VH1HJY5w1nM/qSAw
 9o2A==
X-Gm-Message-State: AOJu0YyfHjUY1HuzixSidUQmJtqBvjrkvuk4EhFSnN4Am66wcElfHsKE
 FAwZHquerMTstR9n0Xuypta87/DqjtJfOD+bNOvny3ILLs394VFDh+5bsMe1jF/nfSQYQ9wq0ET
 w
X-Gm-Gg: ASbGncutZY9Mv9ye6zlHy/fxybVZ2aR5gopeXedP9teJDu3EBtAxAzu3NIPBBCtuUMZ
 avsIwavE253ZKtaHZ3FbO9Nv+iIjJPD1cuckhuh7v5+d6Sd1V+x1O33+aHLd4ma+Urp+SQar1iU
 IISiyCSS2L4PWoAt5JObAn1GHoetaprcXYfEZKGjjON4EXvVU2OQw7xUQMuqG5NdVn/R8Nqqyvb
 KJgr7jcWKZsGmIP92RDQfrza07y+TNk85fTmOHjWPaS08rPN6vShRuV8N5Vw36R9ng5KjyRxkq7
 2hK2eIrtvbCaj0do3YAFhfxo7jo4JcTMD1w/Ro5eNOxLqxr9SzAlFWBPcy3aKOL2IsjuaGHJw+m
 UizsM+srYvdO/6GJUbhd2
X-Google-Smtp-Source: AGHT+IGG5OE/Ixh3jZxgfI4pUDnTZJ66lGC95ewqKj05gxccuEJpwmcOAGiSDD2gJZDzC7J+6zAtnQ==
X-Received: by 2002:a05:6e02:1211:b0:3d4:346e:8d49 with SMTP id
 e9e14a558f8ab-3d970b7753cmr37711295ab.9.1746124675173; 
 Thu, 01 May 2025 11:37:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303c055sm303070173.138.2025.05.01.11.37.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:37:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 09/16] hw/i386/pc: Remove pc_compat_2_7[] array
Date: Thu,  1 May 2025 20:36:21 +0200
Message-ID: <20250501183628.87479-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2d.google.com
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

The pc_compat_2_7[] array was only used by the pc-q35-2.7
and pc-i440fx-2.7 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4fb2033bc54..319ec82f709 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -289,9 +289,6 @@ extern const size_t pc_compat_2_9_len;
 extern GlobalProperty pc_compat_2_8[];
 extern const size_t pc_compat_2_8_len;
 
-extern GlobalProperty pc_compat_2_7[];
-extern const size_t pc_compat_2_7_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7573b880905..ee7095c89a8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -241,16 +241,6 @@ GlobalProperty pc_compat_2_8[] = {
 };
 const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
 
-GlobalProperty pc_compat_2_7[] = {
-    { TYPE_X86_CPU, "l3-cache", "off" },
-    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
-    { "isa-pcspk", "migrate", "off" },
-};
-const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


