Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E77E6ADCA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVf-0005q4-GZ; Fri, 22 Nov 2024 17:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVd-0005o6-R7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:17 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVc-0003ls-6o
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:17 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e625b00bcso2332708b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315935; x=1732920735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyMS62Wj2zk+Bd6PpwrWdVnzgE/eSQ4f9nG6xzbtWnU=;
 b=P1h7K8GHBtlqgylV7SdWIqXniV4ILj1FKWuta02wHAcbq4zJP8roCyQ1YLvgT0hbbw
 14YJwyXPIWcs0sD1zbZBcJrowxe3LqnNMWx6wtK0lTGS4Dm8Iyb+aISykDgbeJ16j8eO
 coH7ckkeA7UKsMqTh0lfcQADfPJPR616tJ2w0Q1EsKUQkQqSIqIYIT+t4f5m3HEtYcIE
 EJ0Ofvj4LbG31nQ81vOkXoss+2VFacDHiKcrEf61gNV19/isqh7UzjrLbMF1MtgxurDy
 HPxWyD2gO1h80PsP6s1GrPtOOJCdFXTnPYzLJOYN7KPYiaVgLtPfKGsv0R7n0PbM+HdJ
 wC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315935; x=1732920735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyMS62Wj2zk+Bd6PpwrWdVnzgE/eSQ4f9nG6xzbtWnU=;
 b=w9W/4aICQ1aWcgwK3f5Hhfngx41r8BFOIJszmde1UuZWpRKp7/x+Wgcotc4APv8EvC
 F5BGH8qkvFSqHqx6bAlp1quEEEyFHqNSUkxHi40mU+BJ+NjGUEzxWLW5194Lb3w78FgB
 zPUPvySeL/7hWfZE0w8vuRgRLMMv1kTDugmwd28unKnLd/ey0h6KxpCURH2vuDqDkYfw
 S4z9uiFNhfphWuicnKchCG5R5Yqm+I3STsjZJZqo8dKTFGOrwbpBSPtPl35yjslTMwwC
 Na//8HXvt7k5X9dxkcCcCOBeOH8kZnsflvL+ldU0JkI3YN97ODhGCErxclu7DKCBUnk3
 4zHA==
X-Gm-Message-State: AOJu0YwicfkwaKweSteHNlLv6mu/AbcqmNkmAkr83SAMLlcvaUXOkIWm
 yQ0JTRPu8XjSR27P/HVxxTRF+dD9LtRED/2Wc7pOMfPujUv4iIVXoNafjY5W+rgw4+bZvp/TI+9
 Q
X-Gm-Gg: ASbGncumCrQsa2zGtVfWNDWHADdEXjYlZE/QuHBh6MV70nD0ZTzTVmNgGC9H1UkPakq
 dBTixLkzOjFrnMrpqgfRRSxzBoTWdZu+oPPNNN9Iem/PjO4ofbQEeJlHq9+bKIFH3j780nwQ3hZ
 kllELLkQnQcL2FNFwBHF+MpXZYX4mta560m1zf7ET4yt0O4Zjrbtc4sxf005x5nO9TkvODyrZt9
 SrrQDza6AYk0Ds2gWhZZxtWb+EtIHqnlTIukwnhlEuFnqaQ0RKLn+OM0ycBiVNfkq4NEajDx64a
 XvADvhz3h9Ivwg==
X-Google-Smtp-Source: AGHT+IGqHqmgIMXwvUq61VXajd8KTbEubCufIExybbU0aXk2k1aZnPkuFwsh8/O1Ap0RUIbGKO8U5A==
X-Received: by 2002:a17:902:ce91:b0:20b:c287:202d with SMTP id
 d9443c01a7336-2129f75ca43mr45276485ad.55.1732315934976; 
 Fri, 22 Nov 2024 14:52:14 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/12] docs/system/arm/virt: document missing properties
Date: Fri, 22 Nov 2024 14:50:48 -0800
Message-Id: <20241122225049.1617774-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/bypass-iommu.txt    |  2 ++
 docs/system/arm/virt.rst | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
index e6677bddd32..62818e44ed9 100644
--- a/docs/bypass-iommu.txt
+++ b/docs/bypass-iommu.txt
@@ -1,3 +1,5 @@
+.. _bypass_iommu:
+
 BYPASS IOMMU PROPERTY
 =====================
 
diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 11ceb898264..d3d21499ff5 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -169,10 +169,17 @@ iommu
   ``smmuv3``
     Create an SMMUv3
 
+default-bus-bypass-iommu
+  Set ``on``/``off`` to enable/disable `bypass_iommu <bypass_iommu>`_ for
+  default root bus.
+
 ras
   Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
   using ACPI and guest external abort exceptions. The default is off.
 
+acpi
+  Set ``on``/``off``/``auto`` to enable/disable ACPI.
+
 dtb-randomness
   Set ``on``/``off`` to pass random seeds via the guest DTB
   rng-seed and kaslr-seed nodes (in both "/chosen" and
@@ -186,6 +193,14 @@ dtb-randomness
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
 
+x-oem-id
+  Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
+  table header.
+
+x-oem-table-id
+  Set string (up to 8 bytes) to override the default value of field OEM Table ID
+  in ACPI table header.
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.39.5


