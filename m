Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1322C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyXx-0002Kk-KP; Wed, 02 Apr 2025 09:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tzyXs-0002G6-DP; Wed, 02 Apr 2025 09:54:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tzyXq-0004uY-Fc; Wed, 02 Apr 2025 09:54:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225df540edcso15695625ad.0; 
 Wed, 02 Apr 2025 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743602055; x=1744206855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G9PZV4WZkVFc5r3WtXw+MuqZv9ug6Jw0HtjL9BKEMkQ=;
 b=FhZTc0ncRG+dEh04a5jtJi73TOohVY4C5S0k/HLagWDRPVF0mBpVNTe2kDP5LoFr/2
 nSMJrWAaCT/5Rs/qgSssVYuBuD1yfcKbTq6/tXl3mNKaBSJ2n+DoFIvIXLiKiVdz+TOB
 g2MOjIT3yVruNM8oF4Pe1Rwms31p/puq0U/JqQ5tV/DctX7J64Va4oxRSdn5EDPl+r8m
 6hmknU2eh540sdm1lyFkx/zR4ToqJTnWwNbrY4H0gFSSR1Sq91sy9Puv+hc+K92acUUL
 s5PVd6aNVFPt4PZhT7tDbBsU7gpxmkIcQz1IlhkpatrwytCKiB5E8fMKpCoT2mdzXNXW
 ohHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743602055; x=1744206855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G9PZV4WZkVFc5r3WtXw+MuqZv9ug6Jw0HtjL9BKEMkQ=;
 b=eyc5ReVLtLOeiGzpTHCzj6HVoMifwAreYuTPoK6RepAn2PQ0Poi3o4DC8V7/E7jmnV
 OIWp/kFuq3IOo9vR29H/lxFoE6BVCt2ohJSPFMvEw9RCEQfxLYSXKIKx4mJwPeSZGF+/
 Tv3Pl+p27IgnPoXMv/+aa06/yYWs7K3LP/7UHAHWNhGm7/7QirwEBS03VB9s1G2b2IoI
 4pEB8v/LCrLU9MdbuWgCpnzq8yrMQB95VCYtMI6ZX+625BihkQlhOcIPg9CaS/zjmQAt
 8ar+Jcv0bTKkQ+4cg3IJOaLqEQQZ89lQ6Ff2uC7nmoXBPN4k1JNR8ferJPdP2PzD3YLC
 hdaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3XvvpEEOpy0RyIh0f8LjsjVgS1k7SEKCkimZkCF0+ZQ+RmFJ3GGOfS3vPIcauVpSbhPsbbyF4zg==@nongnu.org
X-Gm-Message-State: AOJu0YxZwmaWCiwwvncsCnGYrXe3dc0qMXjZtoF1IIW5A8dnjrLPMR/y
 mFWKedJj1Zu4w5AicW1ymxlF66zCDHTKCeXiT32qZALOSgcv9BO9Vy6inxC6LQM=
X-Gm-Gg: ASbGncsrsXyQMzywZBm2qbg30TYyB3PgGD3theU9DiA2TGVxgJ5utVA/M7UU8V8VwBM
 v4KmXaFysYD2dK3K4uXarvJoqkXP8hOVelQL4knkJ+VvKaMpcWRK4GWk4nBWrdCgzOwEcy1o7Y0
 Vi6kxPDtTFbPZQLhVCPR3pKJTHU+6J47nInwFErOtt8HecSG9efvnrZCEsRw8TmGtJYybW7q1ic
 0q+78KNmY/0qZGJ4yClEbrCIceQ+1soF5XTzDB79QJ9dSNyF86IhU5QCgUJnpA0yfSjxadKA/0G
 WoQ1ZPqRkW26bN2iqBcnv1jhUunQU+C1bt4X2xC0dPPN3w==
X-Google-Smtp-Source: AGHT+IFDdnO+E19g7oa5KwRfSwHB2kK908Iky0AS8ZPRNU5n7V49F9QJLOYvpuI4hrgyB45tI5DgnA==
X-Received: by 2002:a17:902:d4c9:b0:221:1356:10c5 with SMTP id
 d9443c01a7336-2296def2cc3mr26378025ad.9.1743602055173; 
 Wed, 02 Apr 2025 06:54:15 -0700 (PDT)
Received: from localhost.localdomain ([129.227.63.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eedcc5csm108439025ad.66.2025.04.02.06.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 06:54:14 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
Date: Wed,  2 Apr 2025 21:54:02 +0800
Message-ID: <20250402135402.14526-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
is mistakenly set to the default AARCH64 target.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/arm/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a..63649e9543 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3178,9 +3178,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
 #ifdef CONFIG_TCG
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
-#else
+#ifdef TARGET_AARCH64
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
-#endif
+#endif /* TARGET_AARCH64 */
+#endif /* CONFIG_TCG */
     mc->valid_cpu_types = valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
-- 
2.49.0


