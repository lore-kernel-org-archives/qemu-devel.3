Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEBBC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 23:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcvg-0000Yy-Pi; Thu, 01 May 2025 19:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvW-0000Uz-N8
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:47 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcvU-0002Nz-Ut
 for qemu-devel@nongnu.org; Thu, 01 May 2025 19:02:46 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d6d6d82633so4996225ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746140556; x=1746745356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dlMcx3WGtPJYiCrgyeoxnRKpVNt5eyt1XvaZehs/1U=;
 b=gsemxs7N9iAG6j8aEhfg3NtMsyc3G2GOGjVbvsX1DBgih+f+NQQjg6cULWydJHruzk
 eUwmrhqn1ln2JjrZFwY5KdM2TJFxYiLiNw4HMw7ozaZVj15oSxeOZFc7WJ58FoiraDks
 xq2ltZ5XwYYCLjHDQIfFseQFRqHh2bEQzhwXxAxyzJNPsfVB/7QkpuB/KCiru1ZMBoEB
 wmfVSpCK/+uWAhgFqYLFMZXmr9A4xt+PJHM4roXcf1FZUC15JOKtMFOxYC9zJx6PcmyD
 gA+U2L9zftobJVSPd2zUHbltQxHySRxFNZJWl76MpwFplS+p24vPSiglmo1D9iKoNv8c
 bxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746140556; x=1746745356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dlMcx3WGtPJYiCrgyeoxnRKpVNt5eyt1XvaZehs/1U=;
 b=JhvxxbMi7CH711wNt+DBG+osCYK43DqfQFTmPV/FhgF0iGOKALZ8MSE+t2cYuRxmB+
 jHc+YS/hu2Cxe7BzVIFxR4EO2GYxVd9UAqixHn40Ds4Ty4Mh/XyrKPjJQDIvT4WQrBWy
 Xu6NILe/z9ZpqEq8iEHDb2JMiOi/fVtCMRdHGwgsm3XKDOhAzufRjr6WKiFuxN5X31Ck
 EO0XwylhZ+oRGCg4SzBlJAjpuhvQnw0hE6TEp8d20Jle4BL64xL56jv9MaJV3WKtQqeB
 bB0CtyPS53ZuVlvzGBMDwXn8RB9WrBjXeiTDtFayv11l/ionE9QQcRfYyzzfxjr2uBPb
 LhYg==
X-Gm-Message-State: AOJu0YyZSD6po2Xl/AOhGBsgEd5WFOsfQcSZ9H7bVSTf6PnlKdIjlk35
 D87b2pVbHdhJwuHoHEp2P5xlraq+aMq9nDtaEAlsv1XsVwsv7J1A/M7eJgrYTsWRfo2Brkgdza/
 J
X-Gm-Gg: ASbGncvD9xvTmcXgqNAwOfSfoiLPy7a0xrMrb6C5Gyd1MU1RHNNvT09Gjm3orROssBP
 UH9m7SUzep5kBYkBTXQipR6ZzU9bcodqetFQ95zZdFnJTFtuVHpRCScABTqmeBe5lfr1HPQlepK
 V9jnGPdi1tu8nwoORH/aACVZ2z36Re+mWzjCt5lJDPlKvOqImvzII/IuuBs6UFWqqZAvtmntW8f
 r8dwKM4KPDqrqenuErnoUs6+Bjkdlpj+d8Tj1GEiPgOPkihjv0GDAUnm+Wm/iaot6FrJRHies+2
 mUz6u/w7o8l5qO4+3GTtRHgp8rdPPGB8zrn7wi3k9IK4AEHfhYJkQ9qUmMJX08FHlsRzVgV4Ggz
 dQBI+9ax4YKSOIC/1y0up
X-Google-Smtp-Source: AGHT+IG3KJ8tW2veGSL0bNPTMdz4dp4JK0KNaJu7AV8FePfOrcHjR1Vw8E5ZFfIwibr3wznGzO2ljw==
X-Received: by 2002:a05:6e02:3702:b0:3d3:fbae:3978 with SMTP id
 e9e14a558f8ab-3d97c1a4cb9mr9373195ab.9.1746140555981; 
 Thu, 01 May 2025 16:02:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aac7e27sm87432173.138.2025.05.01.16.02.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 16:02:35 -0700 (PDT)
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
Subject: [PATCH 07/10] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12
 machine type
Date: Fri,  2 May 2025 01:01:25 +0200
Message-ID: <20250501230129.2596-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501230129.2596-1-philmd@linaro.org>
References: <20250501230129.2596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12f.google.com
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

From: Thomas Huth <thuth@redhat.com>

The s390-ccw-virtio-2.12 machine is older than 6 years, so according to
our machine support policy, it can be removed now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250115073819.15452-9-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2c90702d834..e612030bc18 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1236,20 +1236,6 @@ static void ccw_machine_3_0_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(3, 0);
 
-static void ccw_machine_2_12_instance_options(MachineState *machine)
-{
-    ccw_machine_3_0_instance_options(machine);
-    s390_cpudef_featoff_greater(11, 1, S390_FEAT_PPA15);
-    s390_cpudef_featoff_greater(11, 1, S390_FEAT_BPB);
-}
-
-static void ccw_machine_2_12_class_options(MachineClass *mc)
-{
-    ccw_machine_3_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-}
-DEFINE_CCW_MACHINE(2, 12);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.47.1


