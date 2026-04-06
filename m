Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E4F46C46
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kmF-0003tG-QJ; Mon, 06 Apr 2026 10:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmE-0003t1-Fn
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmD-0004zl-0q
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wWSyFDxGNwzId7cZzvHY1e6vgl0Aec6Tzqgrzda1Nw=;
 b=RsaOQX/ab5Pl9aISHO0VYimJx7SNc4KhXdW/snzvj2TKeWmcrxAyIsbPLeYrpWP79S2MXr
 T+ozSpDDo1t3g3/5JeEUUCz8mf102j1YUlLYZY6ItWvQetmcKF18lPaNYurZvGVA98DRqg
 RshvV5Wr+KHVJoUsn0mZNnNHK8NhjXM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-Y66hmqORO8eoDzLycXi9cw-1; Mon, 06 Apr 2026 10:18:03 -0400
X-MC-Unique: Y66hmqORO8eoDzLycXi9cw-1
X-Mimecast-MFC-AGG-ID: Y66hmqORO8eoDzLycXi9cw_1775485082
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b250d3699aso98568845ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485082; x=1776089882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wWSyFDxGNwzId7cZzvHY1e6vgl0Aec6Tzqgrzda1Nw=;
 b=Di7eiQl80DYVo4dZyJJDxh5viHCF22IwFXqqr9/MZgWZ9NPki0oikOyHxi2yF0SE0V
 cE2IUdjRSfxFSmqVFFmf9Fc4nyEwqLv5Cdbp9Bo9uqq3mWkoOXj4r2Cb57vrUmvsV8eS
 8eyrI6Z0lMmhDwTejZtCnxuMZZpOX7vLR3+JvLomz6NbyVPmWAwT4k8nkA/s0gmyJfAi
 WVCZlC4qt8WoD/CRTSlcHwYRNcYOzpWVt1VCWdik0IV34OUFqrRrefNd5m0v5cwj2Y2O
 R3/eOdrKk34Qs77uMg51Rvx8PSZf+eVz8G//rUonKMKfwLb1lwcCEO0RwhwbSYr0weA7
 UX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485082; x=1776089882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9wWSyFDxGNwzId7cZzvHY1e6vgl0Aec6Tzqgrzda1Nw=;
 b=CCmtP6HDmNLvYDfULny6bgQXsypzc+Z2NyIj7ejyX6Ry8asoeBP7XwPambMRIX555l
 UJm34+43Ic4qtwzS2Y4qbxWRx7MHvop3KuvFhx2Z8fN7P8ZXHFnX6opiMmvsSgysnF/9
 RtcSPriQO8x5SP9MXccwk81ip87of8IxGaouPXt/DlRWeMu6Rudt1kBy1WSRd2PNY6f3
 rWa6yxI48ly8jPzmZEWD+LC907bUa2xTVqPdnIpnJ4KWnkx7FH/lm2QLB4po6hSaG5pe
 3tBD241d7uuNixdov1vreYVuZX0SZSrYwh+g7eeoL+AYJIGewfSE8AMq9dygcob0GoD9
 Fzyw==
X-Gm-Message-State: AOJu0Yxe4ISL5tzaynsgK8jQ3it4COSYgoEgPVecTksm7Oub9FSPVvC0
 JRk0N+Gy+T+RFcNm0x54Z8xbSoPbIb39eX3BFEc5D+t6mzWjiFXkCqNq65xl0dwKq70srTlzGw/
 IKaqpG+jdA83Y1pCp5l1pwc47O1n26vH2cY9IPlC1bYeRpQ5Qq+VwuyuOLBtDUYqOlyTFHWjaWe
 M6xH1/oHGJ8hwdIxSwRcsZbFFRBc+KgV87AAnd0HQ=
X-Gm-Gg: AeBDiet67jngJR2oa31oLZ1/HEbTKl8OrxXTUcJ37szgrAfdEVFDlgl1ja//aCjRK7H
 AE8wbqRLNf3/6NSq/RM3s4bLXnHB5AdrCw/1beHyLS/k7Q7hoSnoIKTQgTfkEyA1vGPgcoJXFbp
 uHArBA8akX9+6SlADbZkhPGAaekkv+hMpkATu9CavIe5P1WOgZhCuhFUOSBEv5p2hXGei3oTI3B
 sViQjmErAevRPH6qh+w7P+lw7AOV0PU9oqMH/DZcdVXWzglTi0s2xoD308ewEZmM7MFp1spZwvh
 8EomHiSFqCN6KhbpOHMA16M2A6MqqMkFw8gXfADTr4Ft++XyU35oUp8wgjOC3WAHW4e1BAQ1FOJ
 NAoiFt61eqY94SkVufIKDfb7cOiq+TXIpOyKqHX1PB3kfdbDmW4HzKyLryBK1yXDFAvk=
X-Received: by 2002:a17:903:32cd:b0:2b2:51e8:2c20 with SMTP id
 d9443c01a7336-2b281760833mr134315345ad.21.1775485081805; 
 Mon, 06 Apr 2026 07:18:01 -0700 (PDT)
X-Received: by 2002:a17:903:32cd:b0:2b2:51e8:2c20 with SMTP id
 d9443c01a7336-2b281760833mr134314845ad.21.1775485081217; 
 Mon, 06 Apr 2026 07:18:01 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:00 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 02/10] hw/tpm: Refactor CRB_CTRL_START register access
Date: Mon,  6 Apr 2026 19:47:27 +0530
Message-ID: <20260406141735.25844-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

Replace manual bitwise operations with ARRAY_FIELD_DP32 macros
No functional changes.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 0a1c7ecdc6..bc55908786 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,7 +145,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             tpm_crb_get_active_locty(s) == locty) {
             void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
             s->cmd = (TPMBackendCmd) {
                 .in = mem,
                 .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
@@ -194,7 +194,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
-- 
2.53.0


