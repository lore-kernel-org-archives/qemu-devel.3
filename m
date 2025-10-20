Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0D8CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyF0-0004vs-MU; Mon, 20 Oct 2025 18:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEy-0004v6-Fw
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEw-0007UI-Mn
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso4858025f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998829; x=1761603629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsIzqC21swzey0dvr5OhOwwY9jaXKLDHI4qDTK4V2Dk=;
 b=Vawg/Q4opZTH8NfjxdlWslzVpNQFow0YrPBwPyjnJknihdwVYgvExyKXEAx7zfJdrO
 JGmkOen4KApdXPv9zIDdvgmY+OCEMex6hNeYOCsKFRbzbD/dMFSsDtbinPg1LM+4/e3x
 KbxlADrV4qN3fw0UsfRy41ihSZmCT3QyI20e+l/4U8PxEgTBznLR/thT0CP7IUvQRkdB
 sE13tBRs0XIzjwIzFpQ78lgOPlx5+HBG2hm9IEl2TPwtrmZ6HJsimyf0ZJcX+hm6g08X
 9oFE31Qd7fV8CKK0EwZtQf4To1/rQ+77s1FlsImONvfqRTYGwPxkTDBUHWqw8cDTY5BN
 BpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998829; x=1761603629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsIzqC21swzey0dvr5OhOwwY9jaXKLDHI4qDTK4V2Dk=;
 b=I1DVbgOPBb4qDMCUOBB8LALF4h+5AseXN0s/xC+OEbZXHulQkVKlFGhoOF8MZToqIU
 kZXObWhvJthGeC17B+waVpdwBHHyhXU131Z5x1s2joAd53TY7hfot1xqQFN48yO5/wL7
 rk0N8pdTW7XggQx6YgJ4IMFRTB+2zXX5NCGaYIqYZoDViov2aOhJptqhFwWomVzPmp3q
 eDOTgYsCWQdntCsAbBESGt9KX+W9xI7nZ9l3XUiWuS4v5l47avqmBjAeC+FkvUTeFgFh
 YxLYZmaMB2os+irzAthoLVUb8x8dhTLjEd0BKfXK0QNa9T0sEKAAtp/9+AGlM+6IzQDP
 +urw==
X-Gm-Message-State: AOJu0YzBgLIhI7LPfyLRhYhK6d0AwEOu8V6fDDKIWTYAh0pfEwHoL0uw
 ekLGEkiv0v2m7vTC13RmtW4RQgkvKl1LM5Vtt5viRFACnAIAGbxoyUcUacS0DDcNzzhen17QklB
 X8juWWnM=
X-Gm-Gg: ASbGncv3jJS9uU2rwilQP/gbil6I4ty1Jb3Tadqj42aMq9foX5UTPcuzid4NJlFfxmJ
 WKb0qOutSSh1PbAD+smsvZ5lLJMdHdADQSNj99+fkHmk/p8VpxpreEv22HrgYB/bsc5XYTziLmX
 BzRsHBkU8uKcL9MmOkWiNxYssYqgfZ8Qh8AxL+HG4k3YhWO9lARhk3oPoq2PLVfG+Lv5kH9rIIJ
 UqHqrxpKyJ8NYP+P0cHHCEw3MP3X4jXPf2cpcV0KYdLEaLcH6pdidMz9jUnsQSFAy99bMUIUfoq
 hneywPe5E6iVRNE3aETKCyKL2VEKgVfo5M8V7JXyPTuq8qU2+ofAr4c4UfjZh1ywX8AXYn+BIOf
 HjAEUh5xmYrcKfM6lvheHH4ZL9NrV9PVSlRvvopvKDzPigI5Waj9y64yV2+SJxbEfciTarbGtdQ
 qFRofc3X6ey8qlOohi5fsQixezoonfpSISuJHaHJFFLXSlpxEQQg==
X-Google-Smtp-Source: AGHT+IHvp6d/pCqH2l1QXX+wLlTpbM/T3p/Adqx9xag8fn/3lI5Idl/j2sL31vh0ju5y4Ftk5E8gSQ==
X-Received: by 2002:a05:6000:609:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-42704da9dc5mr10761195f8f.33.1760998828747; 
 Mon, 20 Oct 2025 15:20:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a1056sm17168844f8f.2.2025.10.20.15.20.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:20:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 28/30] hw/arm/virt: Build only once
Date: Tue, 21 Oct 2025 00:20:08 +0200
Message-ID: <20251020222010.68708-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
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

Previous commits removed the TARGET_AARCH64 uses in virt.c,
we can now move it to arm_common_ss[] and build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4dfc7813191..f9d615e360b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
-arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
-- 
2.51.0


