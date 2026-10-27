Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF460A262B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Px4ezq7s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLftA-0003SP-18; Tue, 27 Oct 2026 08:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsF-0003G4-9A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:59 -0400
Received: from ci-2002i-snip6-11.eps.apple.com ([2a01:b747:3005:206::5d]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsB-0007xf-Eb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:51 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 AECF41801A78; Tue, 27 Oct 2026 12:01:40 +0000 (UTC)
X-ICL-RepId: 01a17d3c-d2c4-7829-8a1f-85a0f49462f7
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQtIAl4CRQdDCUwLQAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793102501; x=1824638501;
 bh=egAN4NyQhfqBcFC+3Ez6KW/lBgRn6lzToVKTUc2J7bY=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=Px4ezq7sFenUtAuxLYFw8t65KutMHJqh6ELjJfl1PmROzYJVK6Egv2sl2nLRLNLED3bCO0HWyf5X7J+mfZJspbSCofNvJUjt7JBG+nHkV5hF7wPF/jDV+9trbk9gDeswwQ1IGJymJd1bfl5Nu91TGo8+0ZWfp76QWaAmwxvwUartDuiRGvQu00fXF2fh4z03qO6Lsgt+Cv/5FIRT7Cx2AUOXezp4Ty0imCGutFvgIeTFlWxVZghPkBD3ufXxb0HiIKrAT8iAID/IAjyw4hUVDjIqEKRbooW5xYxfVu3v0jRW8WzFijB+ma6JYvvIKp5DNEqaRwZbRdPkDK1JRzZbUA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 B6CBF1808315; Tue, 27 Oct 2026 12:01:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 0/6] hvf: arm: fixes for QEMU 11.2
Date: Tue, 27 Oct 2026 13:01:29 +0100
Message-ID: <20261027120135.53048-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfXwJyWE6ILMYFz
 oZJ7DIoOyV3cMEjQuMJ0Fame6zBMdCqNGkZCH/PXtsg8zmhnQd4MLoxqXgPW22FCg6WAEcn1spp
 vh/20Dk3gTr1aqmrUANOY4LwvQNq4x6/CU7aDUOlJszvbI+hRLyH8JdphEqfDmsHY473OjBqAoN
 XKNQSdqOjC1HVY1ZDlJsed6P82wV7M+izoTsp5fhC6Qk7n5lIQpDPyWIrycfZkpj4yUSquCNIR5
 ZcUPpz3qUh8sOLG49tDIWlHHqKRxeQ8N+PDMHfEbKyYt3JZ646snAc2PHzT+kDKkXkP6x/rchlh
 VQXr+J9w1Mu9P8vjaoqnVWQRFQKvdsLc2ZdHGPDN5jQ5I3SOzcwCvsPzIJYjxs=
X-Authority-Info-Out: v=2.4 cv=dPGrWeZb c=1 sm=1 tr=0 ts=6ae092a5
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Yl4DsScOm9x93wG5-FgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lQvA4-ydhyJ2ecf1XPxdPC4cgBIJnwHT
X-Proofpoint-ORIG-GUID: lQvA4-ydhyJ2ecf1XPxdPC4cgBIJnwHT
X-JNJ: AAAAAAABamZh1IGkiwJyH3lSLwZQbvPgKS8E7KyFA9SlhZwrXSJYnPXuOuddkkCo7FM3XdNYPhRTMIiqoBBym3/f5IfKn15LPTSQ7gbsHnIZAbrkJayL28dV8PUwshI17COa9orbqXN4JTQOVMKtriaEvGTy7ks7m+oT/5VXmONc9312Fa/AHL1w9NkzVQHyXHtNtcfSFabqVnLJKixCLfyoCTgGHlIyTb+JjIKlGJMcMWewC+4vGm23JI7jZGV0985+KKJws9PMDdA3j1lEBNsLnmZL+U0IucbwxHv0ty/4VlvpgYNtVlhQ78iBup28HsTYzlkXfTIkC1ADDfjWFhLfJ51+HfaVAckXBEYnB0VLO8/5tRA3TIkNewdRa03a/uAxLHT0stsqFERBVIWGW45GnQ67NmbM+ujMgqo8EACqW1Fa18wjs2U8VBP3T2CajeKLf6i6k17ykZbDkPOYnDxvZGJQW8LSqw8OeKrMwWVtMdCRgmwlvVcn3KqxHPAMsx/KdwKD4ZhxLMoRaFj45lR/cxIFUr7WonE0UfzlRnK0rbicqPoVMPNCSTjq1oH7EUqgVsRmk7ZmSTU4wRYuiVNmkVRjC1kNSerCy1CncCSxkHpb+1+3/m/k7e4QDRiQhzcrB9HfbF3soPLF8152zSAUEGCXsZl4Yx1evIOyduvPTkxjTdKSUjU/HOyDXIm4mvOGHmjhHFhCVhF+nYGj+jAD1u5N5CClEEmO1dsaKqfNhFm3QlR0dqxZRM4NiGltQivDD9pjDNTlu1tebCdFvFAXnpaZU6Vcuz229hxOK2pxfYjhPQXUG4B/dANMF9X5lRBpaTccjG/7uEQ68vO92gG4Sl++aVPSoIpQDqpyMKdgqwCHSVGKvw193Ohj7ecweyM/P23e1ik0n0qyE1Si+2JbOiSo97VmhEvHfIpLvbDT2REAXqDGgF/grgfb+AXaJprt1cF8FfeQfbMWo9yWwGe71PqBXIi
 I4nhNGWO7ZJCdP/g/Vb3l1aLhWr9QrF3eUXLPd77TLo1uztbkIh0RgogoVthnI1TTpmNKT2u++pF0JHzbn/72er57SGoEnwCC9viF0WAltM4bY44dmneZ04R4b8gHwTDFfwcvadOJJkE5a7GEXEjy/zIuaRJdZZSYYiXb0ZgROS4k8XNDEfOC0Jm4Fl7lM2OxjEqtcO73T2tkJOCrRnKnkl264O0KODDZNUfP5IcBUX6L1pPq2NE4eSiUfBJBU9QhBwalzFv/8KpuH4sVjQY=
Received-SPF: pass client-ip=2a01:b747:3005:206::5d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2:
- remove GIC_ISPENDR workaround: currently under further investigation
- simplify SME save/restore patch
- rework the CPU reset strategy, with also taking care of the GIC CPU interface registers.

v1:

- workaround for presumed Hypervisor.framework issue
- save/restore SME state only when SME is on for the CPU
- add ID_AA64PFR0_EL1.GIC sync to advertise the system register interface

Mohamed Mediouni (6):
  hvf: arm: save/restore SME state only when SME on
  hvf: arm: remove broken ID_AA64PFR0_EL1.GIC sync
  hvf: arm: advertise ID_AA64PFR0_EL1.GIC
  hvf: arm: fetch more features
  hvf: gic: sync the CPU interface during a vCPU reset
  hvf: arm: sync vCPU state on PSCI reset

 hw/intc/arm_gicv3_hvf.c | 93 ++++++++++++++++++++++++-----------------
 target/arm/hvf/hvf.c    | 45 +++++++++++++++++---
 2 files changed, 93 insertions(+), 45 deletions(-)

-- 
2.54.0 (Apple Git-157)


