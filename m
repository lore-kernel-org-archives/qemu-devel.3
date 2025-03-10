Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65F8C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEX-0003Dc-GZ; Mon, 10 Mar 2025 00:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEI-0002o6-3i
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:06 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEG-0008Er-Hz
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225477548e1so20296065ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582743; x=1742187543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTI1e75Far6tkvgIJWf413Q47HXvE/J/3XXxjgsh6yQ=;
 b=kgO0I2Z2i8woKAk8FaddliG1tD2SGpko1sMhM+i5IQXACXbaKOwwihut3SnG2h712+
 glozo+AUSNN1lywt1nNQCH+y2KAxze+SUy45gskM6vzvkm4wj+EPtZdCgsyJm2WJOywL
 uFlcDWpE47jXMBmU3R24hhjYPZdEHl26w+dn2qjBw0kw6ZQsutu0E7bwWcvn5ifMObKC
 MMlTLFHRx7zIasTuHthRWFNdcxlnNbVCyaScT1tgKSAx2evD/uydIIIgH0hoSexFxPEm
 ZKW2hOyvnnT2ZZQ6AmX0EHbQcJyblgN0ip0T4SI1Pl6a/63QNFSAG3TmzITdBct83Yrn
 qCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582743; x=1742187543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTI1e75Far6tkvgIJWf413Q47HXvE/J/3XXxjgsh6yQ=;
 b=KtoxcYFmrg54ExbqB0QanzyTo4lTGFZP/O9Gt8EJ2fBgM0Cwuec4Hd6y7aFFycT2H5
 VqL7cmJCylHrSQZ62I6Gy0yhtHNq39QKg31VRp2ticBpX5y8xhlVpem1KNgCpBn9XYLo
 ojB7G+MtAT6jIJAasOuhthUU3umgVzRsZM/Mm2zG5y/YKxsZ4lAcAVZ8+P3a5A+qw9Sb
 EAkUNBD3i/N9LzJUw6rcfDtak5MmvbfcjZGy/tBrm0xcnVfUkiffAlxH3tBL573ebfOW
 ZsF9nxjBhsEJnFYHmBWVm4AfdVG9VrN1gjjd2IsPLcm4S1XFmdW3s4WxEmD0OVpGdHyf
 Mpvw==
X-Gm-Message-State: AOJu0YzOlfnxoCpjLZsgAwJeobLHtMm9DPPzjD2sAUnE3kZzgZqpxyVZ
 IemQraBIKjR6h3t4YmDyYM6NT7USC5zqwuajBPT4NvCreOGqLd38AvHXGbVV+2G6955bSpNAMoX
 Ak0U=
X-Gm-Gg: ASbGnct+unumZJSS3x9/D+rK/zyA496t+2RmTyS+oa2GiB4GVsHF3Z/f+KNScHVUUmB
 IKDzcwtROndrVOypT39Voud3d1Y4H8uqXatxULb+Yp4jPF2/Arqgr8/px4uGHkJk2w5xsIpB019
 FOjLKiQY0fg+DYD7vf3v5RNXmnmCAZY6P2dkCPpxy7ni/7CsBJVkBFzMTPiKb+XnS34LQ0kIvhK
 KzahFQee1LE+FQsBE2dkwYUX2Uk1+tOdVV/u3Wnp3pc/mhPvYmutFvu4/XBZ6P8U7t1/6WehBUh
 gF8D/GBf9l5geVpG/n5LsOsbiCjaiSSBTEYaUmq2WmNv
X-Google-Smtp-Source: AGHT+IEJmFw/36nK1SG72X+BhxhrmIBbQ3tB+znRJTwS+V3kz822OtyZYcKaYIi+o8+TLN45WlwkAA==
X-Received: by 2002:a17:903:32c5:b0:224:3c9:19ae with SMTP id
 d9443c01a7336-22428c07361mr200227865ad.34.1741582743213; 
 Sun, 09 Mar 2025 21:59:03 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:59:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/16] system/kvm: make kvm_flush_coalesced_mmio_buffer()
 accessible for common code
Date: Sun,  9 Mar 2025 21:58:37 -0700
Message-Id: <20250310045842.2650784-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

This function is used by system/physmem.c will be turn into common code
in next commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a551..21da3b8b052 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -210,11 +210,11 @@ bool kvm_arm_supports_user_irq(void);
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
-
 void kvm_flush_coalesced_mmio_buffer(void);
 
+#ifdef COMPILING_PER_TARGET
+#include "cpu.h"
+
 /**
  * kvm_update_guest_debug(): ensure KVM debug structures updated
  * @cs: the CPUState for this cpu
-- 
2.39.5


