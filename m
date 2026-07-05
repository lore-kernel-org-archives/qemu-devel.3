Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41E8C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgGOn-0002eN-Vx; Sun, 05 Jul 2026 02:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOV-0002cd-Fq
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:32:03 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOT-0002Gf-L6
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:31:58 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BC793F282
 for <qemu-devel@nongnu.org>; Sun,  5 Jul 2026 06:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783233115;
 bh=x9yibJvbs3//wu2HDE/wmt268pELTI1g6qpdDbH0/1U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=m3NQxwS1Yc9qO5F+9oNN2o8/DJI9vzq2Juur0jbgjC1MpekYYYgGUEcPi6l0s94gp
 lKjSC8iG6XtmiPGjImEUe6VQObZQaPeLNIEJ/+IvFX88HmJCfPiZMYph7LduwrzeS8
 AKImAg/4FOFm1gVXaLYKbG/OQLQ2hh1p/A6YcpLKTBEPKzhV1umlw2PgF/Eb/1KLzr
 U1bSzo4KpKGmxe9YNykaB+KI3qXwymEuAGtq+JhcjFyOkw221Vew/R2q5pBWg26uYN
 A0THF/2f786DIl3l7WVLQxsSixZMwJ0lVFrMnz3gakp1NvMHSIP3s0UWNq99Dvuo0b
 SD3gB+gd0UD3ld7INXoihdH7SGEmAkBMCV3AQiWUqYj6TAk0QpQnYsi5DBaZmKmV6d
 Q/C+/+0GkSILTZfjC4t7V4jW4tpIcsp60NllYL1Wlt/vjCOUvACE/Mk42U0GnG8H9L
 M051mE6PgiEHYF++tka5sr7tcLdUjBAQs0j0rX8PY5ufQJQAjlOOeiADG2evQqDd2g
 UgwbLftFGmn2E9XhSJF7D6VxqE15PI9jqIkZR4w86wbX9XVNao8A/4Hq5v6lFf92mD
 ywLZuL/5WbR8KuV9d6Y8IrZtPjYukesvxNj3wCY2Rw5so/G6q1Rx6Wh1cPsFsB32Af
 JmgEhf9pAzpLgfR25fk+172g=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473e18559b2so957499f8f.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 23:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783233115; x=1783837915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x9yibJvbs3//wu2HDE/wmt268pELTI1g6qpdDbH0/1U=;
 b=Aqn6inJPsGicdK69tugf9bN/OeSrMGGiB/SapETpsRQkYErvC8n87FhJowI1jocKbu
 aeM5TPndxkZeHO6NTJQuR1L15N1EXA4npQExQ/jPSbmEZ5AVsT/cus3fPJSvJGUFZuzS
 yh2j/JrPtC8yw+oqdoPj/+IG+MW1f/NwTWmduWvWXrN1FJxPSyRpI5KVEQ2Bb0GcFIvp
 mT4jEClaSlrBBRxxSghMElvutARzVLcfit5gq9nrT+8+EW11ti91llLXLeD7vCZD6N4q
 i7DruwQIV27+3XaT4th4ZAaLpDGRyfShsmxSKTBaU7BJ7daybnVzOXEmpXleOhgnhAIf
 DYOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSMh163pCgKEhP59HzRkvHjkYAHUd9TZwMahpQaazxYulxwRvh6YO4/WbpHUZNS2kTmgpnxAto1puu@nongnu.org
X-Gm-Message-State: AOJu0Yww27HvGLdl/D5fTY+w7DIHIP5oVdN2zmwY0HgX/ARNcZpgG6KE
 8ruYwE+UuVo1bNSpZSthjS8/FZLsOiA4Kwgn6L7y14SeX2TA543tyvJbXt9y0uGYZCQt2EdNOin
 +MDeImQQmbxF5FrReQaUo7jgvSN29oKIDjrpfdnbYnJbCJUinnY6zGVkHYpYYnGsSlK1DoGI5
X-Gm-Gg: AfdE7cnAfAPaJ+9/mHwowM7IgtvTXyRR/Om+USfajIVhY5n22lcjL5/bkxyOwadoyDf
 vp4vt1g2yN1XRcn2hH+nROoO72E80MN3HN0J9XJ+3NNRTZXp9TOjAi9KqjwBhTZrmIWScy5CJSj
 LHLFm+eHPFmiiNmOTcqh03tYMFgn/ErUsLTs8HdteV8ZmnhY+rWmz842G/Q80hiEu07KElRRvsA
 eQ8MhbiXYPevZjxWVmgS8kzmQ6YKnD1bZd4RcuCsqN8dy0Ho50w6yim/2RgH8TbnETJkkYrNZLX
 NWM1KrP4VD5C0eY2NVWh/iBPiSoEwBzuRpIPenu4HxO2m/+xLQ2M6wFrZkGbjlZM2Ys+AzqV3/K
 MCSay+ZzL3RZZmLk3SCQDcJEQGLDQAK2INQQPsyWlAx2gdED75d5em4q2RV/rdQqOIA==
X-Received: by 2002:a05:6000:46c7:b0:474:6a5b:860b with SMTP id
 ffacd0b85a97d-47aac4ecc24mr3849811f8f.37.1783233115130; 
 Sat, 04 Jul 2026 23:31:55 -0700 (PDT)
X-Received: by 2002:a05:6000:46c7:b0:474:6a5b:860b with SMTP id
 ffacd0b85a97d-47aac4ecc24mr3849793f8f.37.1783233114832; 
 Sat, 04 Jul 2026 23:31:54 -0700 (PDT)
Received: from workstation5 ([2a02:3035:683:e876:a486:6b9b:f6eb:790f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm14293266f8f.26.2026.07.04.23.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:31:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v5 1/3] tests: allow differences in SPCR
Date: Sun,  5 Jul 2026 08:31:45 +0200
Message-ID: <20260705063147.199732-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
References: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For easier bisection add the SPCR table to bios-tables-test-allowed-diff.h.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v5:
	new patch
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..2c7086d9de 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/loongarch64/virt/SPCR",
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.53.0


