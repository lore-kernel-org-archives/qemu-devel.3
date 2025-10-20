Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F54CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyFB-00050u-QC; Mon, 20 Oct 2025 18:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyF9-0004yp-Tp
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyF8-0007W9-Af
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso4553475f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998840; x=1761603640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=indys5qvTm5p7EFIlGC7oRX4yQdNN7gLExqQ4tJBSas=;
 b=fGLHsyjNSyn4CsssPvobkOOIdZ2ucg35hZqeX13ObZjwk9w71Riv3bA50HXxqJ8eqo
 Dkw5nzZTbJqmufOegr1nBexdklpfJCpnyyenILorxUY0PTdkNHLD9L4WZKQ078GvMOmb
 IV+6CV4MtWp3B5NEyzH/px//+l0tiToZbjcp75/fWT9edovWXKgW52OIUzUP7uqE2ZGq
 6ZM/BYDIPv+7RfBIh2VGNSeeepFKIh+PS5ciCKKBB5b0vda43ygP/ADCkZpNT5K3NvoJ
 mEXlXfHqrg9+oAvsOOyZ5CQIy3ERgHhe7+UdWe5QVE0mEaFHt/zvsqtgBve3H8O5yE6f
 3BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998840; x=1761603640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=indys5qvTm5p7EFIlGC7oRX4yQdNN7gLExqQ4tJBSas=;
 b=PKBRwFSdg7CJKUFG4mfwAff4AUdkvCpyyhsANeuKhAeBZpulCrMMtS/UdCpYAfIgu2
 azJwH4lKlzbpIv2vrvu6ui5At6ZYSnAwpkX83M5kGSgtENMwcT3s9s9jh4LYxv6xBV9d
 araih0y1M7vtqc+Qef7J0JoGvekFQ6YmZsbB90e0u4GhAdfimZYa2wbV0JaV0HwIREi4
 MOVA0nHlW0248F+MVWpcqTWFYBMXNSX1rkX/qMHXgKxMzsHCJJw3D7KXab4ljXV+J2SO
 Sn3tckyPLe59Rbs13ojiT3hP4qFYKmosQjinqYZCD6hAWAqnDe1RbW4c/p7UYPQCqK3x
 ksKA==
X-Gm-Message-State: AOJu0YzBQEPQs1GPp4kjIVVQwNPBXChSONNgJSFC40/rT9+BjfK0Y3Ya
 Lj5Lsykp38sbP9zjfNXrSpH3jP93DreNzBFTEe5Rlu9hUBigAkIyumrFAo6Qc86M9MZiqKtpsds
 sQUT+Wu8=
X-Gm-Gg: ASbGnctU0VyUqVm9bC2OhKJsEWCLepEhthYm+RwxsTBbuYwJxTvZwYuUkECKkKD8uDz
 y3fz2Y0XeCW3cDRD3pKMCcwwfZdgnjCc8kELdy6OX89vUkB7PBcTTp3LLJzFuDEnly3RLs5oP5G
 KfF3Y6sPmF4f0CHCNi2lSelLLCq6RfNsENH6khHBEIf85fIkpd2eUVJZ0UKoi/Y/PkYsEbmhh/v
 0be/j90TWpXiHExNt7Lsnbh73PTos3jAquxwo5sM4jxgV/kfdn1IdZAaW+7cfzop8FsxSbq3ZPG
 tEaytUUKtMWmR3J/PKHdZatK4wWDWQtSzNwtCNVQU3w+Ev3rh+FoHUxu4lKej9RjeBYgG84nF17
 AyQhkLVkAt+RkRg2rrv1aAS6xGcOPSdFm6Z91tcCJPYor+C0mZKP5Hsz2gFn+QXNnw6C31lbkDb
 sOEBaTGg98+MSZT8aBpEToRQoa+bDVwbNY+N+Jk4wKbuYqEVlL1A==
X-Google-Smtp-Source: AGHT+IEepxUdmfaIRfd8THD5M38KTjDjBUxXcLBxyIS3B3cqPzgXsAL1mx1gF0qah7bwRJXfwwXcGA==
X-Received: by 2002:a05:6000:491d:b0:427:55b:cf6 with SMTP id
 ffacd0b85a97d-427055b0cf8mr10642338f8f.7.1760998840419; 
 Mon, 20 Oct 2025 15:20:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fdfsm17084508f8f.40.2025.10.20.15.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:20:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 30/30] hw/arm/meson: Remove now unused arm_ss[] source set
Date: Tue, 21 Oct 2025 00:20:10 +0200
Message-ID: <20251020222010.68708-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 28106de94b0..de562c22625 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,4 +1,3 @@
-arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
@@ -87,5 +86,4 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(files('boot.c'))
 
-hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.51.0


