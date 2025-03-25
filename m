Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D747C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3ZH-00011m-FJ; Tue, 25 Mar 2025 08:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3Z8-00010V-AD
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3Z6-0005Fa-Lt
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso37075675e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742906370; x=1743511170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LvpIQaGgz+WyIhLXyfsv0D0CbvtQ9N3s81gzfhIm8jQ=;
 b=r6lfbZtTuvizdhy4uIwzEemu29ntnYCuF4PgkJGiy6CViikNGVeuKF7rYlzWtiA84Q
 lMq3IVEFVKu2bwkWQp2sOMcSZrnGp9VFsttMY7FiNckbFfCNV57NXUZQuM54QcRgEcWX
 Rs7YTbj7bL9zWHCQxeGESWyAmuw1hHy8ge2E0ILS6b11qotwUFEq+RNDLEUnOsF756b0
 Vsnv5Mn8XB8jWfAvVagv15YcUpZhUwdzzTOAfmy16vQAa4gVToxv++hxWUY3DuwOuv7q
 Yspe1G/rBHj2pqaixKIuIovBcDcb8QZjDUW2CBr8xuJ/WHyZbQjGhyFflOuAPZ/Qmn9Z
 ThgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742906370; x=1743511170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LvpIQaGgz+WyIhLXyfsv0D0CbvtQ9N3s81gzfhIm8jQ=;
 b=Ci2vJqGVQt4EYEWEJyR05EvxcVDZB3He1UyJOiAMC5OMwOsVqmDEyJX8fAQpWq8VOb
 Unt09gm8CVsjHyS3dgqHXtkHoQmzRNl2gZzF/RyYD3DB+5+F+XCtCbWy5S4bg9yYSlQW
 ZvCtu9VYoJuGWVaKKONVhORDVnOwXrtttqs0VqjJSTyOGM61OUmPfzKnd5fPfO0BznVs
 +SXfL7dY5YYiEoS2PIai+8VaYpYSx/IpdCbQDIl0y9njHT4e0vesR3YLv6f7DeC3x3wT
 sHWR+AQ2i2mG0BHD3+mk8ZGPcpQecqC3X5IKEQrGf1HGy6rOgSAa9vElPYS3HF8VlEnb
 HI1g==
X-Gm-Message-State: AOJu0YylSkWGAwFGJdhJho+ops0RrJN0ScVmvOVbo7dxnH6ahvRaF+iB
 xJrjgrSORtRi9FahiCEaVjaO8jwFKKArDQbmNyRKJx2wnOXfVLeH+vpZx6Ok9fyXVigPg8p2mA5
 N
X-Gm-Gg: ASbGnctSEhBBwD2DRYxqfHlI43dyJBhw+h+yov+jxLStnOVtV5Z+FOn0AhbQEY+Q7GM
 MVfXXJkEGiTk2SdDa8KodBek/7MOcK3LrJS6S728zPHNT4FuONNyi0O5Q4WjUs++rBmFvh7+duv
 ZVWlG0IApzKKq0NPt11yu9ARolQ7ek4GxQTxYxVPvJ7byrXXaEst7//42byPhWYnhOPnqgWd7qI
 icrQgIZKFoQjk+DRE84c7P4YjzxedTfBFmPAOaoj77BDHJbZYnponwrpVM+kkaFEcL8OiWfsTFL
 kztg6gyj2SvyFlmkzie/RfTIGwozdI8fC8rEDL4XctNMXTk5oRaTposkHoEyIujE/DQajOGrSsh
 t4YlwKB9TEdmS15oplFA=
X-Google-Smtp-Source: AGHT+IF20gTE19DpGV5W4S1bGCbocJ1SsBXtqurQF+ISJEEyPICOhWY2AWzeQ91c9/SfwPTn3TXr4w==
X-Received: by 2002:a05:600c:8719:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-43d50a4ae7dmr125752555e9.26.1742906370024; 
 Tue, 25 Mar 2025 05:39:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43ed6sm198978595e9.13.2025.03.25.05.39.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 05:39:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/4] target/sparc: Spring cleanups around CPU
 features & LEON3
Date: Tue, 25 Mar 2025 13:39:23 +0100
Message-ID: <20250325123927.74939-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Some LEON3 specific flags seems to be disableable, so list them.

Move HW specific code from CPU ENV one layer upper.

Philippe Mathieu-Daudé (4):
  target/sparc: Expose more CPU features
  target/sparc: Restrict SPARC64 specific features
  target/sparc: Log unimplemented ASI load/store accesses
  target/sparc: Move hardware fields from CPUSPARCState to SPARCCPU

 target/sparc/cpu.h             | 10 +++++-----
 target/sparc/cpu-feature.h.inc | 20 +++++++++++--------
 hw/sparc/leon3.c               | 35 +++++++++++++++++-----------------
 target/sparc/cpu.c             |  6 +++++-
 target/sparc/int32_helper.c    |  8 ++++++--
 target/sparc/ldst_helper.c     | 20 +++++++++++++------
 target/sparc/translate.c       | 10 ++++++++--
 7 files changed, 68 insertions(+), 41 deletions(-)

-- 
2.47.1


