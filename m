Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F52FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE75k-00068k-Qw; Wed, 29 Oct 2025 10:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vE75a-00067L-2o
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:23:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vE75N-0008Kl-9P
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:23:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso100368055e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761747810; x=1762352610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+k2zjMvB10MLJYg+WaiVjaqJZ5hHFGUGTiYqjjtMNNI=;
 b=Eu5Ehj8Px0nNVlOOUI24qg8hd67WgThEcHE3fBcluyejTzEB5mpZtFmiZ8z5oR7Z4Y
 Eb8zPLYxG3SRJQVOennll+Fm9VPIJVin78cpYUfFPHrJ86oT2UljjLZOVvX+9BBLkvjA
 UcGo9XtuP/ty0S2+lIfQPxgG0rUPPOBiHzD6yb/9TjCp/gfPQsKpUQwlaeGdrYhe0m87
 77as2cjHTAYCKxxj5MgKQxUgU24osp7H58mfZHSUsHHadaxm+DJozzTUlv3v7SEmbZ4P
 RPHoyZpEidWgEqNtCwHHgMrApGlz0bbY2ekfmLNKZ4VFEktgX8TAu/WC9jLwh6m05VyK
 +Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761747810; x=1762352610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+k2zjMvB10MLJYg+WaiVjaqJZ5hHFGUGTiYqjjtMNNI=;
 b=OwwkTdMYYuWHGblBSb5jL/PWovdCcN2hbcaLbm7+dBnzv/Sl1rpRzARywaBdCobdn5
 A8sg2VefEuWvn0q707O0ACM6UvXuNIsh2jMUoW8sunFfQVvdhxr9jyAUuZuXvW7e30DH
 NwNG8ZUsWVCpRG49ji6uEjro2hLxdu1QfbtVm7mY24s+TjsZ9v+XKLiKt35b4dAg93zu
 cOR2YA5ljtodZcCdpcwjCftTmwwb49hjGyCbB8bOmfHWzw7Co4vDBHW9W/IHys+WwCiy
 ufQ3hvA1OT3GV66WPyi0lVOeMRQ+Gx5mm2vbjXeGhcnmyc+bo6uPCjJboRlC3JTk6nT+
 dv9w==
X-Gm-Message-State: AOJu0YxYsjqDzd3L68zsC6D9EANb0arff19FS5X6ygVZFl4kItKw2Uil
 r9xOUbpRkexc2TIeGOIirjxlsMCLRLdBEiWoqBW687BAiQ0OFPN/s4iER5NMEQ==
X-Gm-Gg: ASbGnct3kyml9AFmCMYKkYsRW6MVZA0mBuOL9udpqvYUe7lTWofcc581cFX5OzYck45
 d3rlAja0U0mmeobOcywlVAatKYeBtboLDxg1V4MQXT4l1PArhd9/vkMGv0dEG+tvIX3uDm7EK9r
 F43I0XVO4WokJK6yOeMIhUwc3Tfz06FvJe2V6A18BHmx6SYJCD/q3tXCWVf6Nvt9Foa3giJoTAo
 aLgRKx4YhhFM9kBVySDH81Y7CIX62iCPqHY9a/euFO5RdeXXdh0RI8sLWMWb9EBXoveq8kl4jP2
 fJlSNPdQRBln7to0LlyLdAry4kda2YT8ZZ6epotDaCppaS5yEUkB1efFYQYKZog4AqJ+Ly7Wxkt
 Na8xDmphlemyVM47TdcZ1HEr1vvprPE33h5qSztHp3Msa8v47cvLLSzbYppL0HCVAUs8pgYqYSm
 rr1trrkieqbGl2jKQcgK73N4ahOvhNu4gJ
X-Google-Smtp-Source: AGHT+IGkbXq8YLYTlrHU3Y/qlQuki8pLt80vcv9+30feu/MLXI59AP0oNkd7Jspqd0uFC6XDgb3Thw==
X-Received: by 2002:a05:600c:46c4:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-4771e183b35mr33153625e9.14.1761747810039; 
 Wed, 29 Oct 2025 07:23:30 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca569sm26038747f8f.12.2025.10.29.07.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:23:29 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 2/2] hw/arm/imx8mp-evk: Fix guest time in KVM mode
Date: Wed, 29 Oct 2025 15:23:11 +0100
Message-ID: <20251029142311.2986-3-shentey@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029142311.2986-1-shentey@gmail.com>
References: <20251029142311.2986-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The imx8mp DTB hardcodes the clock frequency of the system counter to 8MHz.
In KVM mode, the host CPU is used whose system counter runs at a different
frequency, resulting in the guest clock running slower or faster. Fix this
by not hardcoding the clock frequency which makes the Linux driver read
the real clock frequency from the register.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/imx8mp-evk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 80036f8589..e26c62aee1 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -43,6 +43,15 @@ static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
         fdt_nop_property(fdt, offset, "cpu-idle-states");
         offset = fdt_node_offset_by_compatible(fdt, offset, "arm,cortex-a53");
     }
+
+    if (kvm_enabled()) {
+        /* Use system counter frequency from host CPU to fix time in guest */
+        offset = fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-timer");
+        while (offset >= 0) {
+            fdt_nop_property(fdt, offset, "clock-frequency");
+            offset = fdt_node_offset_by_compatible(fdt, offset, "arm,armv8-timer");
+        }
+    }
 }
 
 static void imx8mp_evk_init(MachineState *machine)
-- 
2.51.2


