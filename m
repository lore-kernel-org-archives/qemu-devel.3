Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8BEC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPsc-0002ER-07; Tue, 20 Aug 2024 10:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsC-0001wz-Bk; Tue, 20 Aug 2024 10:30:20 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs5-0001oZ-N0; Tue, 20 Aug 2024 10:30:11 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f3f07ac2dcso7173381fa.2; 
 Tue, 20 Aug 2024 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164202; x=1724769002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2BvZYxCNM329YOtugIJJq27AP0DG+3t72psalP89h8=;
 b=J97+b223OhGbSMet6kxd3wZ7YX1dnMidT9LVsS7Aep8AuAcg0wxRxkZkk8wz+HORtp
 V3O9+c4BLxd9Re2HgwMQbiko7JQM4I+hWymiBLlzvjDBHE3hXchwb7ODHj9NtBNZzugr
 yGidC5ipfyRoae16R8yK3mt2SkHc9c9+dYdVa0ivRG5qmsq2lba4QsZVVw6Bl2bpB+ai
 CM7oiPuzLjVsRizhDcQNKw0I4oQO3Bw447SlWB9Wt718YfvGXWk178+45y45C7AlgZcB
 Hw6xitE8QszdLqlrspPVRo6e4efmpwDd6LjTO83aixDt/ygur9L9HlWWqcRfer/2hkbw
 eBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164202; x=1724769002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2BvZYxCNM329YOtugIJJq27AP0DG+3t72psalP89h8=;
 b=YVs7MZTIymvArH6wkSP7/YRTH8kdZ0FtVTf7uYbKxImSrzfRCdWdZNiw4+R9BaKgtj
 xRABNX3Q0KYkbbzOUbrfBPz2YW3BAovryFBPucZLx5AVQJEKJJYlD/8yCrF+ls0yIIZF
 SE8N+U+AbKOJY62ciTvf+Y75ImxGwWi/llsKqXNn7kokSXF+MwwlK/4UshqCaGWTsJNm
 sH8CuVsHQVt3vLuOQuAS+N+qDrENiczgVSx1VuGmZ9zhY4H3fcIS0QCuCb8F4XoskMKj
 4J17bBjO7Co4B8xphvWTHzvIYwGFvx76y1vEVDYiqiYSjwWUi7RLq+CO6uFyilP9H7M3
 AC+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5mD2DOhaWpZVoRJQiPyQjzrP+Ppr8T4FVQeBADNlBGKdFXjevGAYM+JU7ee3gGKnYUq2AtvHcTg==@nongnu.org
X-Gm-Message-State: AOJu0YzLWlV1ipJLVOk9QiSQFwnHqmp8BQH5z4tQ5H+zy8ubcycOf76z
 Sx3aOSx0CjfW4Mfrww2clwSXboJUd0uQfJU70KOL4UOEUsuoHu3FFLBiE2QE
X-Google-Smtp-Source: AGHT+IHrRwz7HWObwUTGagmH+INCDwhlgY6mEOdY8uIF9sicK4D/lPSZOM/URWXKGfy0q0Gg5vOZAg==
X-Received: by 2002:a2e:9119:0:b0:2ef:2b45:b71d with SMTP id
 38308e7fff4ca-2f3be5afc99mr87868481fa.24.1724164201963; 
 Tue, 20 Aug 2024 07:30:01 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f3b771ebe5sm17418331fa.116.2024.08.20.07.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:30:01 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v2 05/12] hw/arm: xenpvh: Remove double-negation in warning
Date: Tue, 20 Aug 2024 16:29:42 +0200
Message-ID: <20240820142949.533381-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22c.google.com
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

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index fda65d0d8d..16b3f00992 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -165,7 +165,7 @@ static void xen_arm_init(MachineState *machine)
     xam->state =  g_new0(XenIOState, 1);
 
     if (machine->ram_size == 0) {
-        warn_report("%s non-zero ram size not specified. QEMU machine started"
+        warn_report("%s: ram size not specified. QEMU machine started"
                     " without IOREQ (no emulated devices including virtio)",
                     MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
         return;
-- 
2.43.0


