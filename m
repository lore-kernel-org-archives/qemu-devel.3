Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C2AC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPt3-0002i7-5G; Tue, 20 Aug 2024 10:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsH-0001xV-4u; Tue, 20 Aug 2024 10:30:20 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsB-0001sJ-NL; Tue, 20 Aug 2024 10:30:13 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f3eabcd293so11130501fa.2; 
 Tue, 20 Aug 2024 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164208; x=1724769008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nym7Vpc1+HcpD0fJwqv749eMWZaaEovUQaBKn9/MOQM=;
 b=HxBgeRaUk/qeS6HYTDTUwraKmLE8Lv24g6gvUE4xImvVk0SfFdF1PZxXAzbxzZ9J2E
 ER8HA15ErWlerfP7/H82rUCDS2adirTb24tY3WOyQywyPcCBP/yBd9bXEb9w7/PYouAn
 FukmYHlgub308qVzE5+m4fMoBbu+CZvDvvcCs0imNqtJpuQK3En+iIMoCtW8BdR1AmAP
 nbwkytQjMqw42E/PjTcWXDfYBDdi/oaKYAej/KB0y9lFnamtjxdpEqFe6JZXmtrgGw6q
 c5yzRAV+arka8fpwnkdwL6sYveu3Uzeyfgs6Ppiaxqd3iyqQtUi9o9en3BIe09tQEgPj
 bjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164208; x=1724769008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nym7Vpc1+HcpD0fJwqv749eMWZaaEovUQaBKn9/MOQM=;
 b=F+ZphwU8L8VZtnMc6ZHBI+goSkkI+x4X5MaFyeRBex5HcpwH3GAbMw5yaSeYZDyjQN
 aPgM2qs7nm8Y8KXyNZHRYfWEpk7WvGa7K7KYgj0mKUXCL3Sa5XlG8xVuHn6G99xKt93E
 nFloGxm3qU7AYOCjmw/nDfp9tfxsiNWHfderCmZrmMaiNzcsbYSSDVan4ouErTKBp8zf
 +uh1V0L1+lSurBm9aYbwzHgHjV1SvlvNRZ9WVd4XqQmaE0XdIA2I6wZ+v9SCXyXPOlo+
 GpjAjQuECHSqkdfg5ofLsdlnzcoJkTnTg4yB4xy7cm+NE9zSJhyaWEEpP89c30EehXaM
 LC/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgXObRa3l1eLz1z13m4IkmwGiEnDYQeTb/wYWzTv7Cf2lfnaDr/Pny0GD1XP5Zqm7ctYFUVjpMRzWtv75FtvS7x3n6
X-Gm-Message-State: AOJu0YxSq08mGcaXHKBIDrmTGwZ6kQMdX+H+R3qHHVsF7jnNi7sh1gmY
 W793mJAEm6p3LdfIQl3f7881/XsGb0Uf+HRdfh6jh4v7SikTud2m8Zw6jTML
X-Google-Smtp-Source: AGHT+IGvYq0XUQaDgo2b1zhaMjoLQlam8cibWHn5GgbCoSKj72iq1ZAvahi0NkyE48N8bfPt4YQ3Fg==
X-Received: by 2002:a05:651c:b10:b0:2ef:26f2:d3e2 with SMTP id
 38308e7fff4ca-2f3be574b20mr115566071fa.2.1724164207760; 
 Tue, 20 Aug 2024 07:30:07 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f3b7729ca3sm17564031fa.124.2024.08.20.07.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:30:06 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v2 08/12] hw/arm: xenpvh: Rename xen_arm.c -> xen-pvh.c
Date: Tue, 20 Aug 2024 16:29:45 +0200
Message-ID: <20240820142949.533381-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Rename xen_arm.c -> xen-pvh.c to better express that this
is a PVH machine and to align with x86 HVM and future PVH
machine filenames:
hw/i386/xen/xen-hvm.c
hw/i386/xen/xen-pvh.c (in preparation)

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/meson.build              | 2 +-
 hw/arm/{xen_arm.c => xen-pvh.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/arm/{xen_arm.c => xen-pvh.c} (100%)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 074612b40c..4059d0be2e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -61,7 +61,7 @@ arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-e
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
-  'xen_arm.c',
+  'xen-pvh.c',
 ))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen-pvh.c
similarity index 100%
rename from hw/arm/xen_arm.c
rename to hw/arm/xen-pvh.c
-- 
2.43.0


