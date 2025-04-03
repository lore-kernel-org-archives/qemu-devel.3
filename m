Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409A9C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTd-0000wF-M7; Thu, 03 Apr 2025 20:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTZ-0000en-L5
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTX-0002hl-Lj
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso906378f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724798; x=1744329598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvcrIr+xAa590f6wvTNM2MpnPt6CecU0UbII1dwjeK4=;
 b=MBfBwDx74Wco+zvEN0+Be9HbSughSishE4wvtvmJMEwgQ6NSJ0jOCvf6zTvdfd+/ZI
 tBlYnBclF3DrSLoLSCPal9AHsLKFSAEiUJy0antihkY7E2SUpY+o5f33tbrEYO1KCr0J
 OIsXxPQuf+wPerz1e/hv+iqk3iGcA3NyXCSrl031nvLqWFfPeeJWfdNJgXjE7+PrWdi7
 2gEc7VHBA9lo5Xv4AgRr36rXaYWfVGST/6d9Vj81zBRu+uWB6hy+EabTVS+Wxy74hmyq
 ZIGD7Fh75K2yCkcOf7iZoIfZiHJEJzpqBpxhGA51QjEdNhFT1vcMZidpxGVAvf7LbueI
 /cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724798; x=1744329598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvcrIr+xAa590f6wvTNM2MpnPt6CecU0UbII1dwjeK4=;
 b=Odjq1/sSrJNahALom2qn/QLkhOtr1y2FWpgaD4vbN4mSQlf1qJpRMt2iLQd6gPVMyb
 uZxfD7FLSDnATlN/5CwvR28v/JNgSNLEZtTSBPM4mfOBmaaT7REL77tX5n4dN2aqiG3V
 MIFKJWUpwk9ewtiM4WyNrZTNh7JoMTbKnoMsDKVCkT4gYkDxOlMkaiHlrsPPqiZ7ZpgU
 jjgZUaPZiQi0qn+UhmFh9qV/ATtJjIZrwz4W6qx/XNUYvmab7WlUYKIhjClFhMd0gCD9
 T4fMkdOakCyXF0djz04zebnoKxQtNd6ozVY9WGnGPN5zE3SEizgK8tTZJq6j1EuiZx5r
 bF+w==
X-Gm-Message-State: AOJu0YxzqFO+jAAidHrxQ1t3143mOKhh3p89EMN2McFLywUQD3bWMfv4
 vCjeFzkzQY+Dgqjg0Plo/HgdtbWNHJT+/ZqJ0N9/DgxSxKEz8uNRARinAuw63GRpcoIPpq4IZMB
 u
X-Gm-Gg: ASbGncuUJllXVjpiltZclL8qSDZ2i5DFE/glpJXhwyYgQiLq6RCGuLmMaecPZnkbZdm
 kw3pn0Cx5hhOjUFzF5nAfhyiaDUgdKT2QIdnzzNXAIcoVpWaE/tdqMjxYC+k+pyWDyRWtP3a2JQ
 JBbS6Y0OAHbWeixW7BC633jHubbN9EvSZaHgKxH3Tu+ifudRKpBkcW+z2v7+wK+eZFV3904TKoR
 RVdrs4eFk88h0zQIA1ZJsRB4K7QC1egOV2861AR6JXDCTtTGts5p8Urxqh55hQ1C3Nfiw1yn666
 scSIXbjP63mOgObfnaFZDoj8FHHuFSZ3z1YIby8/jf7c+OYCi5KhzUS2oxlttm6ba5BaYSUh8mf
 bQKtJ8cPChRJJy823g2A=
X-Google-Smtp-Source: AGHT+IGd7SkkRPU2QGHFp0GqZr0MBex2OxiEPwoGyyLiqWGmtDGGzrLwI4L1j4mbWfEN9G30a8SKMA==
X-Received: by 2002:a05:6000:186e:b0:39a:c9cb:819f with SMTP id
 ffacd0b85a97d-39cba975b19mr788973f8f.37.1743724797739; 
 Thu, 03 Apr 2025 16:59:57 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630ddesm34261865e9.5.2025.04.03.16.59.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 14/39] target/arm/kvm: Include missing
 'cpu-qom.h' header
Date: Fri,  4 Apr 2025 01:57:56 +0200
Message-ID: <20250403235821.9909-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

ARMCPU typedef is declared in "cpu-qom.h". Include it in
order to avoid when refactoring unrelated headers:

  target/arm/kvm_arm.h:54:29: error: unknown type name 'ARMCPU'
     54 | bool write_list_to_kvmstate(ARMCPU *cpu, int level);
        |                             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 05c3de8cd46..2db2f060e6a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -12,6 +12,7 @@
 #define QEMU_KVM_ARM_H
 
 #include "system/kvm.h"
+#include "target/arm/cpu-qom.h"
 
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
-- 
2.47.1


