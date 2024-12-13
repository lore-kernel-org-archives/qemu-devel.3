Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98ADE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB79-0006WH-At; Fri, 13 Dec 2024 14:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6x-0006CT-2P
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:03 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6t-0007VL-1x
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:02 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-29e61fcc3d2so1616999fac.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117237; x=1734722037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiW+nVfejzKaY0iptH499hOz00aUO6MutHuzR37Z/m0=;
 b=AwRwh+25T8+CXpngTjJBJP5G7E6kciV3InQg/fPVQhKgGajnxkLwtL5QbGklZiRefE
 px+348etybMUjdNN0OdaW7wC0DKlTar1bZUxGKGCN6SXEJmXBsreY3W7JWyld+/bTLnJ
 uv4lbc9GcxftPz34SuOKbDx7gFVzGYfWEl/T44kisGoxJrgOvod1PARCbxS+zkjuKlo8
 srglzu/SyvOdZN0cqzfJECkwim7/ijvgSbABbab9nCTYvXEhhueeAewYlot0p7AaSGkf
 oqwiyQ7A4QuCQZxz/LsgU9jW0QR2RjXmNkLl4x9OwcOWdgdgK/RefUUkyJjkmDBklabe
 PMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117237; x=1734722037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiW+nVfejzKaY0iptH499hOz00aUO6MutHuzR37Z/m0=;
 b=Px3lEy/dUVSxnHmrIcRMXaaS/1gleEelEEZXVUFlgF72CYJYigVCXV4kBhPxEjwgGY
 yVDHZRJoXsoWUP8y3QMbwi+cH97FvSCI8p9hOA8JS9s1dJF6GFKi1vLwQDmIsgWDusLN
 Efo/l+SUQl6ngms+ib//QIoZT5xDw0h88VKN/tw/89llBUo7G3POZkDtosk1zNnngaIK
 qbRW+kZpBueAZuLGPbCSLXhH7zKO5SUPDgF8OeVeB5nf2wflyfeTZMcsXRxU7ZCttUrm
 66HRf/q2wxLV8xwV8KdelwdGUjByOZlv34qAOXPyZIv7Oyu+6cfV0+qrSH80pWj2xEGh
 I3zw==
X-Gm-Message-State: AOJu0Yxi6cRAvB6bhrarhovpST/GlS6fwe/7phQxejgWr9teRP0JXGkS
 7tRktiKXvJf5rQOoXncE+psLxKwtEqpKf1mA/hle2A1SQkzvqbp0NIzhkAyhaV92RR+XGPjPuG0
 msOj30ywG
X-Gm-Gg: ASbGncuH5Mqg0+mpk0X9tR7h8x7WhuLcx1THDzm0W5b1B6/xuG93ncxggAZ5fZnLCzZ
 dhnN6prbI5PEFa486IDTFv8uEQDsABitLMyDD/heXwShQnN0BTaXuq4YGYUPvDAyXRCPtMbAArp
 djyRrSNeB8iqY2rrnCKR5vhDfJqtguyzdYQCZj4HEsy0lypfYWMXJJic4OV8h75//j5F2Ve7Wqh
 kIcRrAG0EU9JcFsEUDERyj2+FY7uXSROKrJI4vM0JjH1ExyGxtEgyXyJxzswZxb
X-Google-Smtp-Source: AGHT+IEG51rF8aMmGoMqatA1nitSyJifEw6DrRgS4x3z/9CxWQvMDzX6vDhwOr3mGaAX8nLThD54TA==
X-Received: by 2002:a05:6808:158c:b0:3eb:6351:c265 with SMTP id
 5614622812f47-3eba6864516mr2393535b6e.16.1734117237556; 
 Fri, 13 Dec 2024 11:13:57 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:13:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org (open list:nvme)
Subject: [PATCH 43/71] hw/nvme: Constify all Property
Date: Fri, 13 Dec 2024 13:07:17 -0600
Message-ID: <20241213190750.2513964-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/nvme/ctrl.c   | 2 +-
 hw/nvme/ns.c     | 2 +-
 hw/nvme/subsys.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ec75419566..33a3062466 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8927,7 +8927,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     memory_region_del_subregion(&n->bar0, &n->iomem);
 }
 
-static Property nvme_props[] = {
+static const Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 526e15aa80..192b80f18d 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -799,7 +799,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     nvme_attach_ns(n, ns);
 }
 
-static Property nvme_ns_props[] = {
+static const Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_BOOL("detached", NvmeNamespace, params.detached, false),
     DEFINE_PROP_BOOL("shared", NvmeNamespace, params.shared, true),
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 77deaf2c2c..3171c3888c 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -216,7 +216,7 @@ static void nvme_subsys_realize(DeviceState *dev, Error **errp)
     nvme_subsys_setup(subsys, errp);
 }
 
-static Property nvme_subsystem_props[] = {
+static const Property nvme_subsystem_props[] = {
     DEFINE_PROP_STRING("nqn", NvmeSubsystem, params.nqn),
     DEFINE_PROP_BOOL("fdp", NvmeSubsystem, params.fdp.enabled, false),
     DEFINE_PROP_SIZE("fdp.runs", NvmeSubsystem, params.fdp.runs,
-- 
2.43.0


