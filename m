Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1177CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nNN-0004nx-BY; Fri, 17 Oct 2025 12:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNJ-0004m3-D1
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNF-0001Bl-2q
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:17 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso1377650a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760718730; x=1761323530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+w5No0Ep1LX3XR7FDPjD+GZNr16ogOShPRDBWgvVMw0=;
 b=yDiXWyeoct5wRxpDWrOjMWaao7b6Md99AhY9HjgPSH8nN/J6BUx+fMWglMOV/KvJt3
 IA7w14yRJ2ds0zsq4q2jWWZhAWPQyDARl+4NeFiF4CZwYINB25WNbutgc5afvBsaIQvP
 4+nxUsFl4RhAaXxojiTmgha0y0LU0OP0zmAgb+NtEJAhgKU00F6OpbHha+3L8uWHZtA/
 vGlsyh3HNf3JESTfbnESr5I2MIIuA8NxF5CaEDqFJfhJzrHvUAY0UdxOXqkYiBWwJ5Bi
 0P3jyX13zt/ZXHBYlUiuuN9bFlipUheQj4RU34Hr7uhAnmh/v/+0qol7Fod291uYjbhm
 QjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760718730; x=1761323530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+w5No0Ep1LX3XR7FDPjD+GZNr16ogOShPRDBWgvVMw0=;
 b=e0OHZGKPgcYKkClf4USokNRXlm9RgItfFSHB0Dkw/jeYS8hwrGfDP1aXDaLMK20j6i
 tEwwvpUK+19NJDNvHctAh2sgid7obthbu6ipl23M92Y+JWEIOleOuGcGOI2Y0djqf10W
 mvsXTiBlXLWXFGz6mADQUY2sCfWEqAECQg7ArggUoE5TUqTnYwgCnjSOmfTtR+vZPxLO
 PqE68LMisB9tlKRXCIaaCiS+0OeJnBvc+o6C38NvEvT9x/RB8njJnldwX2vO/w+l7GJp
 62Olevnm+TF7qhwNOChJB0omSQGclpiW7WDacErSRS8U2PLeY6ZxNviAPHRHih1Yi2x8
 iKHQ==
X-Gm-Message-State: AOJu0YzvvPLkDcQavyDyyxkR0oNArYx4iq263A9cJs9S4x2JIHWT0yl/
 PrE25GF91VpTFH1HXjhc6jwZBG4TSV66s/YKPS68ketDZBXoSDSvtCDI0b0pNHHE/nYTjP94b4V
 7iq9RV5Y=
X-Gm-Gg: ASbGncvZ2m1gLtiiA8JZ95Bl7FwQvmwpQkmxycI57AKD/+fgzR8/NRkaHi+YteKs3Ab
 ffFZhTfmFVHi0cIibOzJxqAa5j/zkUXGKpkqUWEkqt5HPdo0JjpoV0dIxpIErP2VYfbE/9OAOiu
 oIP1Aw5oimWLuWeQbbbKBa9FSJQS50P8Nrozw4YnpvzAjg+JPyuBd3hPKDkPf0AvT1J2kVqXTWH
 L7YNW3rh8c7iFmNRQB5dSq77GzPyrsN1cQV/nCypL0J82ZGiI/7sFakwueCm82L2rpsEwvduYqa
 zXZC2JlNtX4mOtiRP9aYGG4Kd/hmK8ANv7vNpyPk8MigFxLuQLu4py9pL2G2+X4uWw5zdWREoUI
 pSyr7qdngduWpNaPlMCzDhGiawiKBBZURLAZTHEaBpOTDYIXpdPfj/5jZ3DN5KhZ4MT8FKTzOEd
 aNsXh8jw==
X-Google-Smtp-Source: AGHT+IGHIyOF8131dxJslO5u9lN/8eRSx10M45MtPuQvyC0hEMmOdmBn2nm2ldIDQ4VZWsSsZo9h0g==
X-Received: by 2002:a17:902:e5cf:b0:290:91b1:2a69 with SMTP id
 d9443c01a7336-290cb7560b8mr60958515ad.52.1760718729875; 
 Fri, 17 Oct 2025 09:32:09 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm68667715ad.65.2025.10.17.09.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 3/9] kvm/mips: Remove support for 32-bit hosts
Date: Fri, 17 Oct 2025 09:32:00 -0700
Message-ID: <20251017163206.344542-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017163206.344542-1-richard.henderson@linaro.org>
References: <20251017163206.344542-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-7-philmd@linaro.org>
---
 meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meson.build b/meson.build
index afaefa0172..c5710a6a47 100644
--- a/meson.build
+++ b/meson.build
@@ -295,8 +295,6 @@ elif cpu == 'ppc'
   kvm_targets = ['ppc-softmmu']
 elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
-elif cpu == 'mips'
-  kvm_targets = ['mips-softmmu', 'mipsel-softmmu']
 elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
 elif cpu == 'riscv32'
-- 
2.43.0


