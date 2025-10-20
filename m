Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165FECCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnJG-0002MF-I9; Mon, 20 Oct 2025 06:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnIX-00010N-HC
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnIP-0000IT-F7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so38974135e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956758; x=1761561558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlOXqxMFTMw8d9zFUYVs1rlWsmgPvU0WJ3K5FcKTprA=;
 b=gPzxjBfR06A4wK3HVB92mLK6jDw2ZWg2UJBpfKZGMTTbIOsGLYjuHzBaZjFPeO3rpT
 DWoR55Jta62b5/oCil5YKmwjojl4VDLMh5Fr0TNNT2W6g8sWyO43eW79KkcVksWNSO6h
 D5yw8T6IK7z/WXT0pGC4MGmHC53LvtSCR2JdT6F2RXGnPH+Q6ogDiacdvII4o031AaH/
 OB11KvZ/g9eGLKzwZrgeT8NL8z2QidHGrmlZP6ogZ3R5WADu5nJda5k5eo3WmuE10INS
 gQoWB19UAfSCW1PuJK+wWar6ABk2ZsdheQv7tm287EFMxPQdjzcLzefOC6qnMeaVFpMP
 PJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956758; x=1761561558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlOXqxMFTMw8d9zFUYVs1rlWsmgPvU0WJ3K5FcKTprA=;
 b=T4EHPAomkRCjICdBn2BRQMwNn6AIvahtNnHQTx33n343RrQNwZYN16YXtosTxgE4xP
 W2jcsluqkqkrW8MAWOdFWU9IkUjSBEpf7VmcLJX5VZsHYxGkV5rTShc9Gmc/J4+W4ubr
 mAVB1kXs3nEmTYdYhjWswfubofqu5THKWADK401+R2ZKnsVy1V7jAc2D/0rE/OjJRzdw
 VFgHmvoBgwzLQ11joHVSxw1bzpYpdYWgHCetsiochSoFNFvn3HkXShB+0Fc2+AD4aJj0
 JgElfkxwg63XXsZ7enF2/M9QjbrOi5HaGkP6/nusq8ulm0aROyngaAEfHt+hFB6tzVF4
 wEvw==
X-Gm-Message-State: AOJu0Yy43f5xaMZ7PrWcXPscWQZnUL2sXa/KlOd0dKbivR95qAMACyql
 kCLiJOo1H8gRSNilrF+b0Ee2WCDr7bnnn65chcWDFtLQxRlD3L51szRwQiQVSnasLRRQYKytVJm
 IMkiYD9A=
X-Gm-Gg: ASbGnctVat/uha0YbDIni4XhPUe4rHAQAYa2lPCcwhRCdK+w1RQ8RI9e6Dn9Zy5Z5eU
 2oFC6usnQp82AIhV7QCl/1XqLrhaLjE2piH6gNiNaq8ah87I5Th3Kmc8f2L599svps9dfYdgI0p
 iF2VKdJbkymOYUIz804UwNprnbBzNA8o1KQ3W/Rx4ZZDevWVDsV7zVQTzLwK73xVjS4Y422u3+6
 zSGXXXFKguocs1mOA+qzGnf0OOzuT+ArdxE7H2Mt73cNggwyPM4TNfi6FVXeAl6MUY62iRIQ/Id
 2cZbC78d9ew/jj6BGT4Qmb/W+3ZDI1km5h7lIKAcXrW07Z9NGwIlcziR1aQ7osNXmkNX57OBt0h
 yAJluqGnunC9Xq56Rli6kmHa3VgtTztW0lm13ctms2AW7oB0GlLyqm0KGu86kAt75duzeMUK/Ij
 sXwNuK7yZ3NghdZUTeppfi+w8qKUHLcXPUDHeoUVl74c4OFwO3Rw==
X-Google-Smtp-Source: AGHT+IF7+wUXYpVOjbp8GEPbCSzKhAI9puJAqL3LxJxPnhBl2+aekWdgyEWYzqWjmfgaFsRcy3QGxQ==
X-Received: by 2002:a05:600c:4ec9:b0:471:15c1:45b9 with SMTP id
 5b1f17b1804b1-471179133b2mr99816415e9.29.1760956758432; 
 Mon, 20 Oct 2025 03:39:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a1056sm14700438f8f.2.2025.10.20.03.39.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:39:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/18] hw/ppc/spapr: Remove
 SpaprMachineClass::pre_4_1_migration field
Date: Mon, 20 Oct 2025 12:38:08 +0200
Message-ID: <20251020103815.78415-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
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

The SpaprMachineClass::pre_4_1_migration field was only used by the
pseries-4.0 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 1 -
 hw/ppc/spapr_caps.c    | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 1db67784de8..4c1acd7af5e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,7 +143,6 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0f94c192fd4..f3620b1d9bd 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -336,11 +336,6 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
     spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
 }
 
-static bool cap_hpt_maxpagesize_migrate_needed(void *opaque)
-{
-    return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_1_migration;
-}
-
 static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
                               uint32_t pshift)
 {
@@ -793,7 +788,6 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "int",
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
-        .migrate_needed = cap_hpt_maxpagesize_migrate_needed,
     },
     [SPAPR_CAP_NESTED_KVM_HV] = {
         .name = "nested-hv",
-- 
2.51.0


