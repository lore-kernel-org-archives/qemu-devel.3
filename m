Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A68C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDUT-0003m6-QY; Thu, 06 Mar 2025 10:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDT9-0000Bo-Tp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDT8-0006M2-3D
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so7161125e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276144; x=1741880944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MUTTZ9ZjMGE0zesMow2iRN4HqaCDCLVgPrmD8dOYeq0=;
 b=LbJ29HbZtBY0+K7BiFXUS7Ejz8cMwaiyaF2/CQenRgj59IIvtnhGF6NNCrWm9acrRQ
 gHrBa3oumXcl0/6xKUlp+WcLYOPsniAOcwQYyS/qdNsBwn3N/4LZOk71f5gA41dsLxY5
 15U/1i7euowX+UEOIDn58qvQ/tM1RbukwjdRDphjr2j7T7Ee31IVTTCG0IruDM3X99Gv
 1s6UFrBet6Q9BTZ9KxnwngquttFmEXRKU9NO0sPGLCff1H0LEXNQqZPlc4o4JaavTtrB
 Hxyt8BVz5GNJiXLVb+dj+51cP3ZpnF4LnsUgfYvvvaeCJylv0xUtehbejRxNOx08u7zE
 yWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276144; x=1741880944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUTTZ9ZjMGE0zesMow2iRN4HqaCDCLVgPrmD8dOYeq0=;
 b=hZQMGYGYJS0KQwlwnmrztoYpMRMoqroDiF37c2wflSW7EPBup3ODkvILY8AEaD4NGq
 U72P/A+pkeUe7ARtnNqbvBvGomIG62OXBC/470Sq0uYe6yrTOPoMVkpg/l+lkCJe9FON
 ahVKPrMoMKxXGz4xFaTC6xyQN5O9w6cyH5jQV+X7s6sClnsh5fgLFZLv1Tzh75JwLhGl
 2yhF00oDetqU/BpkeO4xJ5petUh/e919Pps8VKcodSiHOc6um5ObNNm1eE/iMwpEqRRP
 bczTr51ABY/E7Vk4/y4bqhBU9oasfImAqW0nc72W/dZtHYxuLteNdXDC0Jdy8YTS2DCs
 hWeA==
X-Gm-Message-State: AOJu0YxwZ9ZQ68A+0nS3+DsivOcIDm5c/plTUvXZ7leLbYKrE6CoQJeY
 ETzthBwDtgH//yJE4Aa0WveJNkgMv1uLhoOWzPOJZLFdylCUkWtXADVBbtEvbo4vDat6eoL2ani
 ypas=
X-Gm-Gg: ASbGncv7l1Bxv9/JgCZuN71uLtuhxiyFekyGeV7IUcKt/whSDtTu8WEkceYPQoUgXQU
 5kr2bhwVuVuQtyE9oIDjhuqx9UlWjmCJzzm2DAeP5+LC+2F6CtD62VQmYTkYNz/HVYb1IcCz4KB
 ErgotSoi2u6Dp4V3pLTBnY/gBLrYvQR96oGSy0/wgsD0XH01W5YA1irCVbQ0pmTYWZRV7nvMMDC
 EGjqooBjp5dvVsh2I0jdy5dpXnNJWF2qrZ3JdE2M3Rht5k0/3BojOPH0EnwJUd3bSA4ZgPoaYwy
 fGd7MSPTXj6L91DhDNfmast19deJtjTtofuQp/fA/VC38mJJXdVi/df4g4W0TaAbOIRYYX1wVxc
 8VdEVd7+W1V3J5/tUlL4=
X-Google-Smtp-Source: AGHT+IFhVkJPPbUk+3vwT8Cf6Bcc8u9Z7SO6TTn+Atl0a/aWr10ra37GP6yBFhioMER9JPv676+hwg==
X-Received: by 2002:a05:600c:511c:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-43bd2972e1dmr67090175e9.7.1741276144130; 
 Thu, 06 Mar 2025 07:49:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcbcc0c39sm66381085e9.0.2025.03.06.07.49.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/54] accel/kvm: Remove unused 'system/cpus.h' header in
 kvm-cpus.h
Date: Thu,  6 Mar 2025 16:47:01 +0100
Message-ID: <20250306154737.70886-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Missed in commit b86f59c7155 ("accel: replace struct CpusAccel
with AccelOpsClass") which removed the single CpusAccel use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-7-philmd@linaro.org>
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


