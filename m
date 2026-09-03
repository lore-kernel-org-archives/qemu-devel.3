Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D93C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20OP-00086R-Qq; Thu, 03 Sep 2026 01:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OO-00083L-4Z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:44 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OM-0006WO-Hq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:43 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so2005035a91.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414821; x=1789019621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ia4P/jyA4f87m0nyaT4ywXgyJnS0qKlG0zYD7mw5Fo0=;
 b=lDDadWvLig4+G5Wfwai3nfnmMx8i478pJvXLcZI0+PSUmjmpwC+lIzUi0f21rReQsR
 IOOxFx+d6aZM+18GYzXwfpWlS/eQ8bT5oR/ujjhx0rDPC1J3knFyQx+RzlYWzpm67XSD
 R36ZN+Pt3HQCWMSnPSjlEp+m0P3TtUULw3qtenpA93hlXA+VR7WkWsyeEvAiFfnqkijJ
 IlRzcAatQ/DINapn86pnIFEwlObtqFYECggCo/g7v37/P27r+8YMqplpUt0xN9muvwpg
 SuGtNrn65z98IPT5g063+ADniP0tVH6YcoaFPHK2eN30YBbsddc6bSWauhI/ahGvLtLf
 L40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414821; x=1789019621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ia4P/jyA4f87m0nyaT4ywXgyJnS0qKlG0zYD7mw5Fo0=;
 b=sG+x5gO4KeQzqeevHlTcRYSHTPrctyFgy9ePvtJKXN6ftXZGm7IsCvj/qrwaePJbh3
 Wds72R1UCE9cS4/tdwNc2qu+d3mScrEcZ+Pewgz+tZhovxgTM0kJv3PUgliGlJNBREK2
 pUCR9SuDeJZXAO60f7zYvOuuo40UgfjkBlrbSgxZZ/LtmkmcdM5Ny4YkNMNpLMqGHcd9
 1WBceajFC4g3bvVtydwUTT6gKTkS90gzwvAYlThBqbwrdUqOwVX8CvXvSpfgMjaCYhlJ
 ZZXKU5xl6zcSYB6oUcKlPY0fmAgNUsItAh3NzBqjnvGtIESPhKgTRuq29iczm+0C45ud
 tldg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8AGsomHvMugPrYMd3ug7b9WPub+qucZoD1UKQIoM/0V2VNARvlcXXdj+Yk5YiDUFZKOZS2zsCM3hN@nongnu.org
X-Gm-Message-State: AFuF++m2rO5+ItGs/N+Ra3fHfwt8krER8+c7YNy3RjFXE4KbKm499EsD
 pzKDDtHKFnzcKTMmhYlq4d5ETDmZU7598+rZz/olOxJJlKdjZ9lAwtwC
X-Gm-Gg: AYBFou3UnGJSV1wo2SHDkJ+NM0vRMHCwxwAuS/KZw8kzjZBjYJEZw1qLKUKhEd/zmcA
 27qfF8BmZMCSzICao6dMaOtF3BEp07EbMvwitRJAYG0cUt/nQIQF33bPgDxHf6bfh8JDfL89Tld
 cBO4RvNTfkLUE0JWFcnbOeDtYt3JCKl5Snd7+JB4zu9b2U+uTxpOE1qBCw/17rjKzXFqPTZOKo1
 5jHmkWYAo1z/ic71/fnmTEPlMtMY2IVAEPqIJK5dV80PUv5JO0j3KrmZB73FgAuZom12H+Q9lGW
 MpPjHf0tRW2hc1Wq9E++bVQNTbHXo938UE0RpryuWfdGrd2mF7ByxaJpky99SoEOQihaPNtfEcn
 lVNZijk9P1bg+FGh/kBj6UcOKjMMq13McoffaojZiKghghYAShnlBXBecKh3UbYHLS12rWtpxz2
 Jji7UhFtg60QMpgB+HSDxzBJe2sfrfLmVZsAqOs2reCFHrH2KbUCiS+bzvHLjzPzE16BBhVTJUB
 dz3PEKX0OJMzPk4kxfjhCob0Q4Nqs0+2onikZZfrpZWdRany7U3SBAxgl1qAZpswuYEkFLGDhWs
 NUxaLMgzIsFRXmPrY3aj+o6DneVLZ4c=
X-Received: by 2002:a17:90b:268d:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39aee023191mr16722961a91.10.1788414821101; 
 Wed, 02 Sep 2026 22:53:41 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:39 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 14/16] hw/riscv: Add property to hart array to allow
 private memory
Date: Thu,  3 Sep 2026 15:21:28 +0930
Message-ID: <20260903055131.257903-15-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Portia Stephens <portias@oss.tenstorrent.com>

There are platforms where CPUs have different mapping of system memory.
The global system memory does not allow for this. This adds an optional
property on the hart array to assign a specific memory region. The array
passes the region to each hart it creates, so a machine can alias the
harts' memory to system memory, while the harts view memory from their
own memory region.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/riscv_hart.h | 2 ++
 hw/riscv/riscv_hart.c         | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index 197fa1623115..c3cd05a2c877 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -42,6 +42,8 @@ struct RISCVHartArrayState {
     uint64_t *rnmi_irqvec;
     uint32_t num_rnmi_excpvec;
     uint64_t *rnmi_excpvec;
+    /* Optional private memory region for use instead of system memory */
+    MemoryRegion *memory;
     RISCVCPU *harts;
 };
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 747754be6158..32fd39737ff6 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -53,6 +53,8 @@ static const Property riscv_harts_props[] = {
     DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
                       num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
                       uint64_t),
+    DEFINE_PROP_LINK("memory", RISCVHartArrayState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void riscv_harts_cpu_reset(void *opaque)
@@ -117,6 +119,12 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
     qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
 
+    /* Use private memory instead of system_memory if provided */
+    if (s->memory) {
+        object_property_set_link(OBJECT(&s->harts[idx]), "memory",
+                                 OBJECT(s->memory), &error_abort);
+    }
+
     if (s->harts[idx].cfg.ext_smrnmi) {
         if (idx < s->num_rnmi_irqvec) {
             qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
-- 
2.47.3


