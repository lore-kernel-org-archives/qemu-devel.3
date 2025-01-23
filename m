Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E19C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sa-0006LR-3l; Thu, 23 Jan 2025 18:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sY-0006JN-0Q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sV-0003yK-Gr
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso15565265e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675890; x=1738280690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VK0JABDJF/QMP4ClWDlwjdLf62KvnH3DnM23ZO9feXo=;
 b=ymH3z41q7DT98Z3mTLQ3dPO8bRehaNOzLrCHVnYwJcHW1sc2cLZ7/JEwH68OQoeEEy
 Z5nFIwdFqJ6iCWugo66MKB+WvAaLkhIPd2FzXMlG1TgOSu3aQu2LE2mZ7V3sTSA8SaXv
 S0vLfct7eunB0hdb3qkN4Uj9QC9I7xa3BJJJlF7BF2ZuHeZo9ARiNWqV9N4d9Y9LLyAt
 eACRY+RyG8DhRy8Pc8SHrR93c1lMoBNf8gAvm8/M3TibwipQEeIrPoZPp41x8uHhnm5k
 g5jS/cn+JRcxcnu/KLqFugnycUX743zyuuLTLJ3CLv2IByGqsIz3gCtbToiSj3xU+h8L
 yhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675890; x=1738280690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VK0JABDJF/QMP4ClWDlwjdLf62KvnH3DnM23ZO9feXo=;
 b=XQQRN1UTr9aqbOP3SKfnojlijCh3GYfEPoEcmCH7k4+NCSLy+nXJYzmk/13rJlzCiD
 rV2BMlRT0C08Epm7Uz1T40f9avUPnElTb/lJ7uD4X+NvwEPyCUXCi/SjfS4IOV9HdYSA
 a+79lr1JatJAAY5xrCIAaP4JIJyShsoCCHQwnPvriJvJO0gN55reoHhhOPfpuBbYqMRb
 sUFX5uRCq9J57HIAeGvV2Zmwfpko1TTJwAOYYtq5Lx60JiMTX3vIniGAGJbQPRlSOVyH
 Mj06UUMGAmAWpgbvo/5e/EVKDLG9FCUw8OKilBoOVRYc18ZCi4NNzTesZSVvONSOcwh2
 XkFw==
X-Gm-Message-State: AOJu0Yw710xUOWecKlLNM3RsAOywdhvZPm46beEszej5hDPxxECaUzpO
 bU+IPKbO3q+86J7zufVd26ZcEqE5MqcUMDoP6Wl32EzubviD41CTNDfyKYCzpMkgEAG3LOF0qCg
 OU9o=
X-Gm-Gg: ASbGncu6IsduWuZUb3UCEt/bj/0VTKCirxvwv3rF/bUrxPyFyMaCYtGj+0tSx11wMxx
 vFQBbKMkG9xcariotJNViH2oY6g+bmZ/BxXVXshjv3KWRh33Hbmx5YqL9awcF7y9ISpfh9/+LpS
 aQ0TJwlc/buIr28AYzyyK1aeVqsqxexIYvoibluSzEAK/dAXExVyODLvE/aNjDVfFGepVQXYvOW
 BmTYa5vjfergRhfALPyBjYA5r2LJ+WqRTORvclEEqmYaB1fAYTjz0SREBQfm+DUb0p/UrWmx4L2
 TL1DvW4sA14/4zI0PsbWLKPZhmYeXhGse6B5io6L9kgpPZb1qOD/v7A=
X-Google-Smtp-Source: AGHT+IGSMRqXknIm20dxUVJ6YnBSj5qdwQEIsknPsDpqx1Ro9qYQKL2SDEG840LoeQHivalI7LVk8Q==
X-Received: by 2002:a5d:64a1:0:b0:386:3262:28c6 with SMTP id
 ffacd0b85a97d-38bf5677c09mr24857649f8f.5.1737675889741; 
 Thu, 23 Jan 2025 15:44:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4161sm952291f8f.88.2025.01.23.15.44.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:44:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/20] accel/kvm: Remove unused 'system/cpus.h' header in
 kvm-cpus.h
Date: Fri, 24 Jan 2025 00:44:00 +0100
Message-ID: <20250123234415.59850-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Missed in commit b86f59c7155 ("accel: replace struct CpusAccel
with AccelOpsClass") which removed the single CpusAccel use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-cpus.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index b5435286e42..688511151c8 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -10,8 +10,6 @@
 #ifndef KVM_CPUS_H
 #define KVM_CPUS_H
 
-#include "system/cpus.h"
-
 int kvm_init_vcpu(CPUState *cpu, Error **errp);
 int kvm_cpu_exec(CPUState *cpu);
 void kvm_destroy_vcpu(CPUState *cpu);
-- 
2.47.1


