Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83902F94CBE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLx-0008Tp-5J; Wed, 22 Apr 2026 17:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLv-0008Sj-Ai
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:23 -0400
Received: from p-east2-cluster1-host6-snip4-6.eps.apple.com ([57.103.76.99]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLt-0007UW-02
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:23 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 18D6D180095E; Wed, 22 Apr 2026 21:43:20 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkKXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894200; x=1779486200;
 bh=nflalHNpsd+cwF/uF35esRRPVFTNfgzM4VSaQ5bZG+E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=U9WpHyiIxhD6Zjh1nZ2HUELI1TAx6qNh/j6WStBNbd/ea2nBHiepun2kh7VsuvOfuoILsOrHUGGpP9951j6mF2qc77vCyeA4michdjYgmB5nF5VG6rh7ef/zbr17HhxX1nUF0q849Evrzpl+mozrHgl/5OcbLNZvficioNL7JogUly8KgEdrF7uGMiL3RjWW535V51A1FIsucI116DXkR4yX8Pi00M92OJEEvJ+Psbj5x9JdkZuPex01dHgvy3NlUytTDEemSvO9P3e6H830TrdJJeTbvYku7zxcO+Dk/pnJu83GArsblbPBYzt2Ir1Mw53Ii+joDuxJwGUT8IHBEg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 611B018006FB; Wed, 22 Apr 2026 21:43:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 27/37] target/i386: make xsave_buf present unconditionally
Date: Wed, 22 Apr 2026 23:42:15 +0200
Message-ID: <20260422214225.2242-28-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BWpQPBG5CWTX2TnI6n7bd8jD7A6Q4HPi
X-Proofpoint-ORIG-GUID: BWpQPBG5CWTX2TnI6n7bd8jD7A6Q4HPi
X-Authority-Info-Out: v=2.4 cv=TY2bdBQh c=1 sm=1 tr=0 ts=69e940f8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EWkIHKX3_8ZzwOJz1Y8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX+dRIcZv1rR4Z
 Zt0om2PrlZ4mLfhoxLq0x3FcFL3CqRPyItr4nQXTEwGDlhi3xa3+6B2bpdypJLaD0HIxdXp9UUB
 wrVkvSbe2zYNj3NuFwFVtPZFeQwOfJBaBqylr6J1C19bktZergOlpej8x78SAxu+i8NbKdlAAjL
 Vm2hrQRnmg8yAtAu+dV+GdBphZtNHIHfkR+YJ+dnayiaxGjYqE5pVSLOaHNorp5OaetDBTB7EKG
 ovwlFqm536uSC/Tjs5A3urCIp3MoOye98FsJgiyL0XhOSLEBlxn+ogLJaxxYsnIRoYkEUlzgXM9
 5LHJND93M9/yr+MrwtvJi0It0qtelGaC3wQfAIbTYZcB/xOSnTAO/NBrRMFG08=
Received-SPF: pass client-ip=57.103.76.99;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is necessary for the xsave_helper helpers to compile.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67f508dc10..0af7bdf85a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2269,10 +2269,8 @@ typedef struct CPUArchState {
     int64_t user_tsc_khz; /* for sanity check only */
     uint64_t apic_bus_freq;
     uint64_t tsc;
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
     void *xsave_buf;
     uint32_t xsave_buf_len;
-#endif
 #if defined(CONFIG_KVM)
     struct kvm_nested_state *nested_state;
     MemoryRegion *xen_vcpu_info_mr;
-- 
2.50.1 (Apple Git-155)


