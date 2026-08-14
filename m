Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687D0C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuwoG-0007pi-A2; Fri, 14 Aug 2026 14:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuwoD-0007oJ-LE
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:39:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuwoA-0007F0-95
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:39:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so14457505e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786732742; x=1787337542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W2Mx3aydHoSpb8gvA1hKFXObL3SKPHYA2L1UoMCL1VU=;
 b=SQrcIBr/alN9+YsOFlQM8X8IVp23qV0Dgak+VK6PbUhQwHiZBx+eSpHZLLqEattsjx
 opfnQYuub4P0fhVdgJFKZika9RhUvBpT8NIpj9SZm9Ue1kzCiUArYE19AXi2LMj+Oe+K
 BNDvd1k20tBsTHQK67G4tGu5gRlX8cv44mlg50+pJN3pFmuXjqhi8aNsAhKzVxyRVKcA
 wxzHf9cgpFtstHZbP+XOsRdJmYeCTENniTY1VQL4FK7eq8l9GPgIADUBUL6oASLW1Tvo
 Mw9tfRnr+zmGT4++xOjciAzUUFdG9TxHRLzsdbbAcyBIHm3dE/IXEEIn8fmShbtg1zj3
 e0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732742; x=1787337542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W2Mx3aydHoSpb8gvA1hKFXObL3SKPHYA2L1UoMCL1VU=;
 b=AXJQBTrGBDx84lfpqsNmqjrnvfqSB3qqNoviBEALjmzHpRIt+qYq56Tsg7LlKttKy7
 5t+MyzKdpF+aWlZjLO8TffjWAmKd6n2/K7GNcyI4SDcAqLeroHXIU1u1SBDgzjKG4wUr
 4pqwsL5KL9jBcItNSXyQc9VG8HRQvu2tCULfmHa5GLM3WUbFPyWkdE1PmZK+h1j9/4Gm
 shDxPyrYKLSPGL1YL4fRyxJR4WYeYy8udhUf4KFCzZ133v9m2tBmKdPW3ibf8zcsUGAJ
 cYrIRw5QdEnmxhBHsG3dVugo/nw3yguHbKFVIKP+RxXsAMAHTOCKcaKOzLpT3pdhGdzq
 Wtww==
X-Gm-Message-State: AOJu0YxZCkm26YASnbOM7Xvjxs4vwC7zBGiHyaOlS+mCoPW+j8UAa+CZ
 ZOEQ/BNZSvI4bVEYAtG91PeelU5rZl+iC2qWiSkijbh+t4ks6XOUMxyAHkTs1Lisr/mJuY1KBcV
 vGufK
X-Gm-Gg: AR+sD12S7c3P4+so7vKXbrhayB8neJHjEUdqjcgpef0OF/dE7tSafp1/sYw3/1qgMQ/
 gfJaYUzhmh9pdBK0N2xanr7JDJVZT/yiTTV1XSwLRvO8gQeHjuJlhT4KBaWJ/a2vJq7cLmVq+VR
 3r3Mn3ofAatDQfsS4WocdNe9JJ+4vL26tirm9qzAhRHh4aQ6t/17RsX76836PsRwlwv9yfbnMDa
 91wVRN3jomRn1PaiJpaJuPNv8cMmZr0Cfs+7/WOTzMdjuNvG6No0imlV+jj9vK8O0cvpnQxowjE
 XXyshtFkxXNVHPrd0lBvU8oAIXKepZvCZ3HzTg4Lz1yqbdkQRKT1P2rsw8m9rv2F6BX4j3gEyvF
 074ZkmwzZXXXTJQ/GHHjjoH5pKsOmaAVei89rsmOZxcFYrVBN/C3MwD7oounvmbdYUkQ8B3iRt6
 P0zY0C3FyAFDQYRQN7xQOosUpZY8ZZWptJrbj/O0OcRToMfJQLPQLrs91/fYQNOjrmHrRo
X-Received: by 2002:a05:600c:a4d:b0:496:ca1f:a428 with SMTP id
 5b1f17b1804b1-49987981e52mr116300975e9.19.1786732742024; 
 Fri, 14 Aug 2026 11:39:02 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4baa:5b4e:5d38:b960])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d5548sm61175825e9.1.2026.08.14.11.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH] hw/sd: give the RPMB vmstate subsection a name of its own
Date: Fri, 14 Aug 2026 20:38:59 +0200
Message-ID: <20260814183859.4034017-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

emmc_rpmb_vmstate and emmc_extcsd_vmstate are both called
"sd-card/ext_csd_modes-state" and both sit in sd_vmstate.subsections, so
a card with an RPMB partition sends two subsections under one name:
192 bytes of ext_csd_rw and 353 bytes of RPMB state.

vmstate_get_subsection() returns the first entry whose name matches, so
the destination parses both of them as emmc_extcsd_vmstate. The RPMB
section is 161 bytes longer than the fields being loaded from it, the
stream is left mid-section, and the load fails:

  (qemu) migrate file:vm.mig
  ... on the destination:
  load of migration failed: Invalid argument:
  Section footer error, section_id: 38

Reproduced with

  qemu-system-x86_64 -M q35 -device sdhci-pci,id=mmc \
    -drive if=none,id=d0,file=emmc.raw,format=raw \
    -device emmc,bus=sd-bus,drive=d0,rpmb-partition-size=131072

Name it "sd-card/rpmb-state". A stream written by an affected version
cannot be loaded by any version, this one included, so there is no
working format to stay compatible with.

Cc: qemu-stable@nongnu.org
Fixes: 8ef4260a3f ("hw/sd/sdcard: Add basic support for RPMB partition")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a30c541df0..674ca09b49 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1022,7 +1022,7 @@ static bool vmstate_needed_for_rpmb(void *opaque)
 }
 
 static const VMStateDescription emmc_rpmb_vmstate = {
-    .name = "sd-card/ext_csd_modes-state",
+    .name = "sd-card/rpmb-state",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_needed_for_rpmb,
-- 
2.53.0


