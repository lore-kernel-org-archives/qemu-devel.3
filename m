Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D182BD232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Q8-0004x0-Vb; Fri, 09 Jan 2026 01:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PO-0003mt-7X
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:48 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PL-0002q7-O9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:40 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c05d66dbab2so2545324a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941738; x=1768546538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBr/y8Mt2gjaIjzK6CaTi1BSaiLEfEtcTIr7bkjOqJE=;
 b=Xa9eaBJqL8giLEHJzAxEoLL4ZotV+lHQtuE8+8fvILw7xIvpghEGFPJLTjY+dILilJ
 0bSLCag9O8DuqCshzK7SLp7kXslktjXIYT/1Ide+SSNXeqiH9tKQBoav/hVKhQ9DFAGM
 aLJqwsSWB7wBNLRfjpkt7IdRpuJlIA6xQzc4q0kHi5n1FFzb13miGNBI6UaqdMiVnM/E
 DVNgMJckksHB8kzd3/g23w+cDOT7Dc6ida8tggXY36od5JWU6h+MEpwfmRWJP0N0nu0J
 RE+F9akOc6MhFI40toPUKEsqwWvd9ioKkf3ixt3rtCRhh49MtqW46T2VuZ06W6zG0RpG
 Ot+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941738; x=1768546538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WBr/y8Mt2gjaIjzK6CaTi1BSaiLEfEtcTIr7bkjOqJE=;
 b=tr7O+KGBlp2eYL6ZJcU6ft+9CzzTO6EaKpuxS1EaKK6cbeG5mWzRLJhrBRvj9Inur7
 RhJfLbt0gQ+6bNTt0zKRfEnmb1zeGDcenO5AaCuwso+fDWegLkIo9Bf0UOcyjiZTKX0j
 oLOzhQRMjTaUzVmINFRW7F85s/E3LDWBlXs4CqwHNoiWB9f/BLtWxO3kZeWFh5E5zCKW
 LGeIR8DGTPgVxRFBmo1R5+22Qi2xDbCdUr2YsJ/ZnH3JuYxnqYZ65BpNdmc0/D+Mx0Un
 p/lbyRPYclJ15PCjShuLnQl/C44xpuDlFh6vscxfovV50zQQZ8kPndyB+BUw2Cse5gKY
 4HYg==
X-Gm-Message-State: AOJu0YxHDYzTNjxlDWhlt3GqeiNw7LDlfYLGMShb3L4LpZw1xVBO0BnM
 deUu5YhrKIMKlaH7qlevnG+z3+KqYEqLf/ZYviY7Zo7y8epyQkaeB8q5zT44AQ==
X-Gm-Gg: AY/fxX4RDinqNPzbtEp2hCnnA4BeuwfQ5kzqc5iuCfl69POFacQbDlVFfaDCaG8+JZF
 MJFAjrJAwG3ZtbRsSLbf3UkeKBKryISHuH6TPW/1+uDp9IpHDSXudWKXYzvo1vzRZsx7vUGHT23
 8VPYMYvHrf0z9zVoPoYrbCFNIq2tclTAoZnnmy9E5lyiRqYDbsjsGwNpxMTEaXQt6AKjxPFHO2r
 lBNDb3gzlphjXxtsVhT4m7QDsZBTbxsTzIK5Tytg94t9m35awbnrcJw31LaafsEZs+wrtwxcYMk
 70FW3IMJmMyam17giGdrswOR9t+Vejbl+CVO803/d/xBKv2zSzYK+6gy2Eii5XS1fekKoYVY7K9
 QfVBL+5d+Fz24VituLSBJ7mKVmOLPTD9NCWkZAj4Bbd/6kxZ8B4wsJ27UBUF9wB6vY2AtLngnU3
 Oz558beayUfMATM84z9xyVh/IZofsxVV7J7Bhyc5TdyVjSxRHTioOIAwUlMOR8kWcDYlszwDCBF
 cRVgtiXvvc8RrxfLDrRkb9SZ9Fm3g==
X-Google-Smtp-Source: AGHT+IFeSkfuvohSn8YuTdaZGsp6yEW9BcAppraDcUcvvsd1FDeOPTLHjIM5zqeKlKt+p//hSzf7TA==
X-Received: by 2002:a05:6a20:72a0:b0:341:84ee:758d with SMTP id
 adf61e73a8af0-3898f9977e9mr9959930637.40.1767941738063; 
 Thu, 08 Jan 2026 22:55:38 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:37 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/34] hw/riscv/riscv-iommu: Fix MemoryRegion owner
Date: Fri,  9 Jan 2026 16:54:34 +1000
Message-ID: <20260109065459.19987-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

as points to the MemoryRegion itself. s is the device that owns the
MemoryRegion.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027-iommu-v1-1-0fc52a02a273@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index baaadadda1..01730109c7 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1364,7 +1364,7 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
         /* IOVA address space, untranslated addresses */
         memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
             TYPE_RISCV_IOMMU_MEMORY_REGION,
-            OBJECT(as), "riscv_iommu", UINT64_MAX);
+            OBJECT(s), "riscv_iommu", UINT64_MAX);
         address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr), name);
 
         QLIST_INSERT_HEAD(&s->spaces, as, list);
-- 
2.52.0


