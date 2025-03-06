Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1A4C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDjl-000786-Fa; Thu, 06 Mar 2025 11:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDiX-00061w-NH
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:04 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDiT-00085d-Eb
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:01 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-854a682d2b6so50768539f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277095; x=1741881895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=VIlBLlTPr33gj2ZTnDFpukQC5n08ngxUyis3SddTJ04+z9khVxP7RhfyUeTfdSMH6L
 Z2AJ4vzVEug8rKKh3W9+VuZ92+6OWLdGKnTkdbL0a24A/Fnvl1drvaXDCCel+8903Wn3
 3Gtcovtxkq1P425KzpJmtCbymWC1sz2aQKqTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277095; x=1741881895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=lrpQcDBDU1ANgHIAqkIeFXSKhezOnpOOATv0S5tfUqkk+LAqUYEz7ZnXuZot+kj9P8
 6zC8rC0omo+8Ad6rCvu03Rzpdqs77AD5+kEGmKmCJdTfCtRW9lcMw01VNHJqTco+TxhU
 dlvodaQs4tlGHGAq9cV1u3+0kG99JRJ5Pg2RD0DdljXSLlYDvcxizMcLjDEh0YajQWE9
 IQdbkQDNZGqweuabtuJ8ForeaswPArmfciiFrEHmGP1tvwd7IjxydRZdEO45BrvWP4HP
 OUCf2K5jbJdGWRY32pEsiopr1/dbDogqtBo9L4urlm++jmSFo3+X3YBfYbKe5EKy93uI
 Y4UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw+hG4xqaGAhQxJ4pe18SaozlAhIMIhoR7V+v1sUFCN1mJ0q2P6kTOaJTrEA9K0H50h/yfheq394Ho@nongnu.org
X-Gm-Message-State: AOJu0YzisVgQIhbZH0/Af43u/kEyo5NnUMWAO5iHJ7fPSu8FnpGR8MQ5
 GbAwKwkFIHVSL9/GkkjcHmHTacn0pcYfiazVcI0suCxi5rYOEscJp8qXsEl8YQ==
X-Gm-Gg: ASbGnctoMZGffXVOv8n0DAcipM8Bslp3r4cel4+xRuxB9VEWTyhw5kT5bqba1IS7SFi
 nRzgNYWCgQEZoggZpPPy/h9iCxJumkBVZN+gm00KMQzaYlbFFEdTLv2yJW+3gr4VxEXuCF5Pmcd
 bnLrVdYCIFueTpy1pEmOgKDSdorGbUIziAK/j9Qhy5Xhsrx4soE+GrsbkY7KeCAOJU/BvV74KA3
 9h0HoX+xoPkiVEYMO6OJ3L62yZPaDVgiNa1vNuWAYqI2U0RoyjytBnNYftAqeY5Zbv9Ztldx5Y1
 VwYoGTrl+2SFRd5xX6TwetUjLZiLxAIkQgqn2dEYJCWmnz6ztUEgArT5U0a8aI5WLx2/IwVLosu
 Ub35JSQ==
X-Google-Smtp-Source: AGHT+IFptUsVDgwryU3pACMw9DrREQ9iwYAZSwjMMULniLe8f5QvU7XKJlpZw5jtr9diDtsIm1c6bg==
X-Received: by 2002:a92:cdaf:0:b0:3d4:38a4:388e with SMTP id
 e9e14a558f8ab-3d44187c0f4mr897545ab.1.1741277095097; 
 Thu, 06 Mar 2025 08:04:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 05/47] x86: qemu: Enable dhrystone
Date: Thu,  6 Mar 2025 09:03:32 -0700
Message-ID: <20250306160428.3041057-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index ff2a192ee7d..84b7dc8e99f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -89,4 +89,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index ee5b150e062..d52afa42955 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -66,4 +66,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.43.0


