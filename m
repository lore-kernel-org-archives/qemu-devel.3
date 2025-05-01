Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43606C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb8I-0004Sr-L2; Thu, 01 May 2025 17:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7b-0003U5-2Z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:08 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7Z-0006nS-Bs
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:06 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-86192b64d0bso128886139f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133623; x=1746738423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1TIfqPI6KIjdWpPpNOR70tHHt9G+GWWZtqNrt0CoWM=;
 b=i1DD/FRQ3mlTl65g1WbBQNkpy1k0WbeloXEkeWp6Dv26z2Hje/C6OXVaWoMGnH0CPa
 2rYcqYW0FCYcaSbe/NPV4265ofHGd/lZlHffIYh192Px89ORoM5t6ZWIFHHHHBGZEU73
 Z+Lobk2mlJg5gPsyb8i/52A/wp/FDlNkfApMcIfQ6o6ZfJD1GDpg769m8rhA82MlndZz
 oSREaYFr62q9KjuWlgVEnsB6325mbhVyd88Ti2OwBNeNgxLtXPmL27qQxJ0vkvdsXCQl
 wEcl5ShsQrNXt5WPelRt9ArerqOU1QDNhBqmEB2HIiPt6bBW6s2WDC9FFV2PpZyXZ2M6
 RIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133623; x=1746738423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1TIfqPI6KIjdWpPpNOR70tHHt9G+GWWZtqNrt0CoWM=;
 b=b1UnGazgvtlB6NGx9unHmSBMT0Fdoec3mlh/adt4ayOy24HiC/RVzexjd4akrVjHxy
 SHLiMm6M+MpWIEsLxJjuIK9jCYAWxODlYGXS23NKnukVhGxM2N2q2TDBjL0Lf5t0jGwZ
 SoMgVp3QwnkuE5d+qCckdqDeOcTmVnYqZdIKiMWbjkS4lyvNRuiXdtagZJVStriwWyen
 4qBQ9MB4cdCrTZJ0dUCCpLaLgqGsfAySw0a/FxXse7TxDyDwzxJE29t0FEeBb/B4JsEa
 NFmoIBY07xziF1cWEubllS1hOwvk/W35gc8bSOnaIOkjgNVIDqkhuXDjFLqTyBAlOfav
 4QZA==
X-Gm-Message-State: AOJu0Yyez7FZTQkAMqogGRFCPyfC+Zz+FhcebaijBUuKsBVsOqWOf2M3
 AEV1HVyHn1ovY8AorPdXxrbL7paW9qxrxd1JyW6lF6Jw5qMiwRiNsnefTsmxh4tOk8gtr3hbt8w
 h
X-Gm-Gg: ASbGncsIsniju93AZRTyj2ItF6bXS3c1siA3Vmt2OSA3LQGoU3At1qvgvasSB42Hnsb
 zXBRwrsHT+d2O5auTY5KRRbQuNyiP2qddOlQ2+iqHXNM0Xr9BbhjjQir1ojaMjAyEtwNEUOVzVt
 y1c+5ntISh7Ff/oqUyHmcUgvhDrPs/EUjjUElPFg+yGAIyu2jRPKe7h/lEABtWo7QcYS11GVTkX
 GlKPvXGPlDllNppHWwMZC39J8Jyuzrf9uhwELPboZtWlTO8ahqEeb7+pUBGCI6OQLfLykjuelns
 S9F7uPra9vLSMD0ZPh4m/PAVKUi3V+Gu9A8VlgniMK65ImUIuWgnRL2suYYysXgDO33MWPKOQfS
 Vyrnb94skWauQ/6Tt5kWj8NbXyQ==
X-Google-Smtp-Source: AGHT+IE7Yzbqlal6SPe2LTp+pABmJwRFh7MNZudOdQMIfWV4/1j5QYxzfwKqREJI31pgqsB5GmVVMQ==
X-Received: by 2002:a05:6e02:1d84:b0:3d8:8900:9a28 with SMTP id
 e9e14a558f8ab-3d97c2d395bmr6279525ab.20.1746133623583; 
 Thu, 01 May 2025 14:07:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a91638fsm49050173.46.2025.05.01.14.07.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:07:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 14/18] hw/i386/pc: Remove pc_compat_2_9[] array
Date: Thu,  1 May 2025 23:04:52 +0200
Message-ID: <20250501210456.89071-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2b.google.com
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

The pc_compat_2_9[] array was only used by the pc-q35-2.9
and pc-i440fx-2.9 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index db02cbc0d65..455b869cce9 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -283,9 +283,6 @@ extern const size_t pc_compat_2_11_len;
 extern GlobalProperty pc_compat_2_10[];
 extern const size_t pc_compat_2_10_len;
 
-extern GlobalProperty pc_compat_2_9[];
-extern const size_t pc_compat_2_9_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5f07a44d447..298091932ab 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -227,11 +227,6 @@ GlobalProperty pc_compat_2_10[] = {
 };
 const size_t pc_compat_2_10_len = G_N_ELEMENTS(pc_compat_2_10);
 
-GlobalProperty pc_compat_2_9[] = {
-    { "mch", "extended-tseg-mbytes", "0" },
-};
-const size_t pc_compat_2_9_len = G_N_ELEMENTS(pc_compat_2_9);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


