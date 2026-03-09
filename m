Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BB4FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfo2-0003y8-TA; Mon, 09 Mar 2026 14:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo0-0003vx-Be
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfny-0007pK-W1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Z5Z+z6Fq/CCBee7wdpIAUMGF/0DcL3pK1L+V3B+G7c=;
 b=GoHm8IZepdFKCVMI/vePCzfyZ+hx5ANSZMJNbIsjneiJNS+HTqIjJr7McpJcyN3d00IU81
 FUxSND+j+9djFzF1PbXmrnEA4ssrsesmFpsL7kyjUdI3bn5BCI3ui3FFoTrjRI6MpuX3Df
 Tq9wmPoYNh7OZLzbCk1nunXSGx8YmlE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-Ma4PJE9NM4OKSpSiHFa5PQ-1; Mon, 09 Mar 2026 14:58:12 -0400
X-MC-Unique: Ma4PJE9NM4OKSpSiHFa5PQ-1
X-Mimecast-MFC-AGG-ID: Ma4PJE9NM4OKSpSiHFa5PQ_1773082692
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853b0af42aso13128125e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082691; x=1773687491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Z5Z+z6Fq/CCBee7wdpIAUMGF/0DcL3pK1L+V3B+G7c=;
 b=osvfLWdvhwdyMFg7M0yx0Pp3556jOZmT7CEgk9cfuMeYR2QIWFbrnrp7OjPfeYs1mM
 xRAyJTyFfO+DN51G61xdkR8PUvUjgGGrjHLblA5TX8UYYP/XyBbWaJgWDbgJ6idlPbZT
 NrRLPA/xUdQ3O5gkp07tD1TD++tidn9ghd8GBoeUm/hH+H6PNGJ654zstSuYPv1epPb4
 1P3fIBmyRnVbNs7z16ubmZKg6urLBBWvESaoVdUDvGC1v6PEU5qgmYHGI4/XWleSO+N+
 QemG7bqW3HUz9R6yZZzFT3GKXpyd32y+BHrk8mu8xRZbTtczKV0/wr1kHW1GH0VpgcS6
 +dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082691; x=1773687491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Z5Z+z6Fq/CCBee7wdpIAUMGF/0DcL3pK1L+V3B+G7c=;
 b=ouOUy2JFj8d9A9xQ2GvcYrrDC2mZlPYsoWURcjggLIHer+1j7XcfHXp0DirRO4YzaJ
 tJg84KugWex/DY4Zib1/6cVHYqMC0cerSNDCT9EOvEtWkIgBBCPt4+SFrBesFsiowEfp
 jxF3AywpHJhQ0i6XFhANVudwUlktG6DSHf3/w6AUEfm+dxfLj7IXC6FdWPPMaoTAT6p3
 CnbvG3ATRmRQWd+wzO+VyX85nGcB65oiIM32x/2l69SLnoWyEo52ldbcc4+ntzZAloWO
 lw+FmG+ZmdUMLy2V6Z6ObG1HGFINgDQzwbLXfUyqEVzyJEPly2wWlWnlKlMH+FMfAUrw
 T7AQ==
X-Gm-Message-State: AOJu0Yyn1lRhPnv8IPCxcIr1tUDKeV72C1bV8BgnQU8wokAdTLTGvYPC
 srMEqMmKRydao7+Xdw65ZN7E/onTyQULzvTZqg2y4SWfW/UVxvCQ//gI85STCZwNe1vvvNb4H1B
 aqnebPkmjBHmGSBqichkWuc1quSvSing8YH2wKYineRT95Sk1qb4leRzMi9DCbEqx/MuQwWNGOu
 BBY8++hyLNCXLQqQTBVGezdEKohIQQhfY7EPRUHx8P
X-Gm-Gg: ATEYQzzK7MnwW6UAcbFR7F4bPe6Uph6qOsQUuOXQsGfKu7JH5l7YqbOlbapzPbkzcWZ
 T9mOW+WtOQ97yVPwzsp5zDUTIzy5f215zGBaLObcR0+9FkiUil03RB8LhKwi5QAQT0VyY/LRNzy
 kPjRrLmg6/abJAxuyni8NzXbX1BhKetXJHHYo1rVK+Cr+XVGeEFw0FNWHF7+7O912gqOd+nhjB+
 9sdO+Odo9GQ4EfGr2egOkKJ5eAF6to83RfhTUryEUNu88JO7J1I41gZywjCO7xS/iNAq3Tjiljy
 JPG2/PY4YapoVl4weTCF86/MA9sCLScNrfXuQJPQz+E0M4AVKufI8BoWZktR8CuE3OxPQxgbLMR
 vHMzt1F9ig8+QcqgK060i7S/LcoNMsFEj955Wwj+XWfTRcpHH0a/sr85iENdNUqodUPVFB7aERp
 Ax0LydikhULjM3G/BBpw7kIkgP+ck=
X-Received: by 2002:a05:600c:3f06:b0:485:3c66:e21d with SMTP id
 5b1f17b1804b1-4853c66e362mr59859135e9.2.1773082690737; 
 Mon, 09 Mar 2026 11:58:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3f06:b0:485:3c66:e21d with SMTP id
 5b1f17b1804b1-4853c66e362mr59858705e9.2.1773082690241; 
 Mon, 09 Mar 2026 11:58:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48531818b5asm96086905e9.3.2026.03.09.11.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:58:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 07/10] whpx: i386: enable some more enlightenments
Date: Mon,  9 Mar 2026 19:57:49 +0100
Message-ID: <20260309185752.76865-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-7-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9c60295d553..bc82995b33e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2214,9 +2214,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.53.0


