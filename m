Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68A0C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqrs-0001eV-TR; Wed, 05 Mar 2025 10:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrk-00013S-Vi
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:41:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrj-0002e4-5d
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:41:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39129017bbbso23467f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189257; x=1741794057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyaw8diXz251XjYJL/kNHyvPJKVoVonVHEPK8PU5vpE=;
 b=flmxNWm5zDF+PZN4QDUAR8lYtofcn9/TrInFQ/m9k8lAGseQohnJnFur0eN66f01v6
 DWnw3nVD+wNTORLiCscF7Rf6m93H73qHQVQT+cns0yq8IlzC8Ask1xQf7rZzLF3Y0ngX
 wBbeZn5QZjTMZ0hyP9T23xpW1XbSghuxLlmUdW/CmQAskPrSl0rVqtZXZEVigQf7CreV
 47l+kT2EjncfopbVLBE8pSS0A1O3PcdSKfBzxkicZS7YVARe+uzPBKx1au2/6u97peNA
 nH7Ryx55r1mxcmbjDoWf3sKsrMLJPOjJ9sqbY57sL6L1O3JzotIvOSZadLVOtfEIpvnh
 q20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189257; x=1741794057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyaw8diXz251XjYJL/kNHyvPJKVoVonVHEPK8PU5vpE=;
 b=Rc2+JUYZkZvZqdy/irjLgl/t7JGEYs2lQAwsl+3PRktTpFO9Jm2CFKIoi8H66QoM6V
 c2S198PmtszNk7FUTtLvExXP3kIju3AeGE1ohOhWFyfnlX/4tR6RSMmxSsNCz9cd7WJx
 6Zk9QU+tRV47ji5+yLleUquEqm2O0orTrec1DPxnNptfBEoinuNTXZ0pjF+2bmfRkPDE
 acdleAolF+lVqKGBweLDSW8JQoXNE6GfFdoLRLLEq1pSO8JG6Cioa3ijtNSEGTgKrTJI
 FpGPRuC4sMREEhSpMvtqM4NTGDPDmHDlgS+DunzSCFbRb470WtcPyiru0Zb2pow0ULV4
 Z6HQ==
X-Gm-Message-State: AOJu0Yy2Pj4yV+M7rLCK9yQwe05hSKIGYm6HT06meYr7ie0ZRvVUMW2y
 tG9lffSLG6ok9J2b9yOiFpkCZzQwimfzYLZGBHQWIQYGGBLW+f3pNlg04cYT2zdDA3xZZ6gl5hP
 uD6M=
X-Gm-Gg: ASbGncsk/hCVXJiG+kKrJFo2l0VvuAwE67DZvZxy0VHdH8y/tRoBDSxYwXd9kao5rvt
 gGJZLYfmJunMbB31DlGToiEU1H132XgzHpjZGgut1LuZs7ImymX2PoRR1WWdxiKAwpkF5lfOOGG
 Yk7B9rn3OU7zHFydRhYVyaudbGkaNL3KsXvVAur/LALeJ3qhGfJw5aKtl9etI0R5hjk+SHJfHYr
 cXJ++A3sk1xu1/TWfBRdQQ5h4a1c4FJDV3Et/ZUhlJ8XNKrei06oKKBopilJAEC6Rb4urrtJO3w
 Hn/dDaSiIU0Q83ZFkzLwErqJFeaApzPn1Bf6R90nZjj5dQXKp1K8ibtDdwHYn041/8f5eB96tzi
 6Fl//gpa2Nh16AGePygc=
X-Google-Smtp-Source: AGHT+IGIVU3JXeqmrpCnTLOC89zGOLFztoxkDbuPQ9sbgQpVMsXRRusob9OkIFQyCDAz0Dw4mp4sJg==
X-Received: by 2002:a05:6000:1788:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-3911f72632cmr2691115f8f.1.1741189257450; 
 Wed, 05 Mar 2025 07:40:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391212eb81esm2396309f8f.9.2025.03.05.07.40.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 18/18] configs/targets: Merge qemu-system-microblaze{el}
 binaries
Date: Wed,  5 Mar 2025 16:39:28 +0100
Message-ID: <20250305153929.43687-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

qemu-system-microblaze and qemu-system-microblazeel binaries
are functionally equivalent (except the default endianness).

By using legacy_binary_is_big_endian() to get the binary
endianness at runtime, we can merge both binaries (using
a symlink).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/microblazeel-softmmu.mak | 8 --------
 meson.build                              | 4 ++--
 2 files changed, 2 insertions(+), 10 deletions(-)
 delete mode 100644 configs/targets/microblazeel-softmmu.mak

diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
deleted file mode 100644
index 52cdeae1a28..00000000000
--- a/configs/targets/microblazeel-softmmu.mak
+++ /dev/null
@@ -1,8 +0,0 @@
-TARGET_ARCH=microblaze
-TARGET_SUPPORTS_MTTCG=y
-# needed by boot.c
-TARGET_NEED_FDT=y
-TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-# System mode can address up to 64 bits via lea/sea instructions.
-# TODO: These bypass the mmu, so we could emulate these differently.
-TARGET_LONG_BITS=64
diff --git a/meson.build b/meson.build
index c2b7ec57739..46f97b1b7a7 100644
--- a/meson.build
+++ b/meson.build
@@ -3251,8 +3251,8 @@ host_kconfig = \
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
-aliased_targets = []
-aliased_target = {}
+aliased_targets = ['microblazeel']
+aliased_target = {'microblaze': 'microblazeel'}
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
-- 
2.47.1


