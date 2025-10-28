Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64507CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd3O-0001G5-0b; Tue, 28 Oct 2025 02:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd2z-000141-Iv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:19:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd2w-0007oq-Ah
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:19:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so3510164f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632344; x=1762237144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Kvjs75qZYXzJtgjOCgCUdq6Pu4BO5ORL4SkTS1d+ok=;
 b=Y4vJXHi3tmswAuf81Z8JcZprjwxGWAqZDGVf8TWpO9+OO6jlp1V56OEUzPakUpcFBi
 v2X8WckM5qGdua8jye8RbQ6rXIp7hO0Gw8Zo95H0rkU00jz6K577esOIzeQbYgcGiZrm
 tMhW7PjmQ31E+9WDvzWzrz29gQnEHOFVKMCWmHc/GFiZlxQ6HD6qfAoni5CqF9Glt3Yd
 kyE0mnMcvTFEF262pSwcrRs70QxB2vTUp5TueUaN61ZRwcLslB8tUVngO0JZOwIVCOmi
 aenPEHEwRz8MQt2TnZxh0ScI7i51VX9PFyx/TSjQOI1x8IOKweXWB/FWkc8rRtbkIIYH
 hOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632344; x=1762237144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Kvjs75qZYXzJtgjOCgCUdq6Pu4BO5ORL4SkTS1d+ok=;
 b=Qw3jOzUKtQLhr0ZrQomFAVwzC0m0aLU9GSgb6ZUT/+pkrwSRadzDcU6je92sz6KcjB
 gBs93OCOGWDjtd2TXNutgS96MKES2h+6nrBG5moBTl+nm3jXOqs3eZPZu7u87fuQfs9y
 l6CPlJ3VRlPNWRCKQqq77r/mIqHAsz0yNwkJf1USbNMi5TOli8LGQ2W5blZfMyeuROjH
 lZcg4wUYHSW4qLN03/88DsSdgz489mLCCgGEy6upaCt44FD7oQD0wUorwVWXGWBA1vM3
 j/WxFXmHMOPYgk3k9FW8PXyKXlHKVIG1FMmVqCt6i736sc3sl1bZTVe4977CRID46R9c
 +vXA==
X-Gm-Message-State: AOJu0YzODOOvD7abc9EUCTpl/MNUhtJKCA4FzlyduR5x1VlzexUOkfBK
 WFAJqkA8DWlGAeS2dfX7ilRin0GaEG3NTbL0C7tSj/47GZMnM7Y39NSxAGsV/fG14vOHzWZxp/E
 j7BnK/zM=
X-Gm-Gg: ASbGncsDvrsdTptbOkxWLjROQbM45SMYIZyKHA5pXbxoHbJ/dO9zvUIjtuVRZ22rBk/
 s2YX0N2BGCH/yUhCbQdwHCRMzL93bGTDP8C7jAJ+St7NvMlGUQ/MUxl+NwhQVROqG9gY6JXRTDV
 a18VMXsMPG3QXFP8x5Gf6s78NtAkkEfgKzTcUKQvA4gw0FNmGbbeYifjQcjTqNwvDD+D5t42ZBJ
 OrvjnmSIhWeRriZQ6tlKzcQ1FotXa7rfhKl4wd+RMoj3RxxwFmHeGKosmq5LoET4vkUQKVRwGHk
 tP4BbXnITT1QGVsDkSddZ/8tb4e7AahGtjmhtbXZIfRaXEiEN3ZW5HF4P3blacjpxAr8oZIN/NP
 1bneGhSwjjsJHcylPfi6PDAVDI5zzlbmaEXJ2XznoZ7YaaC6SBZh2qYrIN7dMG3wCe3CUhRViEy
 dYNxWQ5cBy2YcU9u/tosuCEnh2JSGeb5cX8FJ7HeNi8BAiaSslq+8XQcE=
X-Google-Smtp-Source: AGHT+IGKhwHrlJVM5NYbrDV9LNRC/S/8U5kMwZwPMrjJPFbgVZ+Sf6yeev9hbQkIEnM+2p3z38L0Vw==
X-Received: by 2002:a05:6000:611:b0:426:ff8f:a0a3 with SMTP id
 ffacd0b85a97d-429a7e7320dmr1478581f8f.34.1761632343758; 
 Mon, 27 Oct 2025 23:19:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb55asm18382097f8f.17.2025.10.27.23.19.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:19:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 51/59] hw/arm/virt: Warn when HVF doesn't report IPA bit
 length
Date: Tue, 28 Oct 2025 06:42:27 +0100
Message-ID: <20251028054238.14949-52-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Emit a warning when HVF doesn't return the IPA bit length
and return -1 as "this accelerator is not usable", allowing
QEMU to try with the next one (when using '-accel hvf:tcg').

Reported-by: Ivan Krasilnikov
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a7..1d65fa471dc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3225,8 +3225,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
 
-    int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
-    int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
+    uint32_t default_ipa_size = hvf_arm_get_default_ipa_bit_size();
+    uint32_t max_ipa_size = hvf_arm_get_max_ipa_bit_size();
+    if (!default_ipa_size || !max_ipa_size) {
+        warn_report("HVF didn't report IPA bit length");
+        return -1;
+    }
 
     /* We freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_ipa_size);
-- 
2.51.0


