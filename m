Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D93DE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSG4-0001fb-EK; Thu, 19 Dec 2024 20:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFq-0000Wo-6B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:39 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFo-0004be-Iq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:37 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725f2f79ed9so1192971b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659795; x=1735264595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYkEPiVTZPcrOR2pDmsygVgNKgeEe5hJGYqQAVm5GOs=;
 b=UTIViYdsyQS60YKeF5LsIYkhM462v0/uljM/rZGVoL1EOKNa8divgwVly+2JsQDG+H
 B+RQtLOP51X3QpPzU9Ndr5KctqDSA5LiQkuCI9IO8OOTfXDCZaR8YyyFT8OOiCdu9wxB
 ENA+IpWHX1S1F2YQlkKqYtR3lL6pKdB3xrYAOT807pljnd0V/min5FgdZxO5fNvyYz7W
 VVBp3CXp9pZCNFmzVThoP+L7xvrUtIN9M5mEgDJ7RHa73ibYdR7SwVmSaY1EybTXt1bO
 MLuYjKsJUCEX8vK9XjmPAhe2wsSNluSAa1rXuT66Da0roA0+2y9OaXuzj+D4Ertdg85g
 UMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659795; x=1735264595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYkEPiVTZPcrOR2pDmsygVgNKgeEe5hJGYqQAVm5GOs=;
 b=WNdho9UnyN3HEv7/fDf2yIJWls73Y0ivNHuV+Sv6+G7UFcNaAm9ew4Rf8GNCfN1Iba
 kFuDHujixeS1yr1ksVY+DEQyZus5ln6k+/JlLmidR/V+ziNdLhWdM4cc5ff5rSgGfVsl
 TJA3/WhA/RzCH6yPIESyJdTTmADwtXaORJ5cTPcIl3HqcoC2cVS6nsGJ75pzbOsUWPBb
 /M6xfrSWQQt/7kkXbiI1cWbufQn+H3ZWOyYM+oA4ogSvD4szGf5l/MhUYPzBJDZ8FqpF
 48SeRV14d2ufYaK6viBusGFDtlu1nR3dYjBbPjg8noF4gQYesxxzMiuzyfrQMQd7pr+E
 owDQ==
X-Gm-Message-State: AOJu0YwXJHrP5vZ8JYX+pcIEwuSrLRvGMYJ8hpc9ugBqnTmIgR9hUPct
 9ECTr3xrfxStFN9a8KEbuvfljB4XW3KtliEwOAtjO63M5AxdgcM/8qmUaKNH
X-Gm-Gg: ASbGnctkMuHkXT7xDBiZLdYR3NazvKkDBEa77IROYZZttbzjqweBnjQNYiXpoxBxV8G
 tCieB9dQSRxyW1bUWubpzOw/gX47TwJzqGa6Q3daJrlSW0X8ZYyj1u/Df8vnvRFU1RQ7rQjp3nU
 yX/sg0wlgPzVYh04Av6QcCcRNwZqyfo8GdP6CEMbAizhgyE3ofYIN2Im3rPGayBChLdbGKN4h3a
 cVpu41iAf8NzmmDyxOPch7TXN4SWUDiMhtzNonOksJyOo7O8sMkGsKbvA3/e5MD7ABULRXiE9PO
 hg9NL3I/GIkU4t8ww3ri2lTaNaNoMGkc7K6XyvbfKHcwlQh5bxkC90xJvT04jTA=
X-Google-Smtp-Source: AGHT+IEU1sEra7OD1L1E3G9QVw1WITBVTEoC2JBvh2EzsqfAUsH4dPlt8W/g9R094HZ/vYMIzMJW8Q==
X-Received: by 2002:a05:6a00:8d8c:b0:71e:a3:935b with SMTP id
 d2e1a72fcca58-72abdee2117mr1476662b3a.25.1734659794960; 
 Thu, 19 Dec 2024 17:56:34 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 33/39] target/riscv: Expose svukte ISA extension
Date: Fri, 20 Dec 2024 11:54:33 +1000
Message-ID: <20241220015441.317236-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Add "svukte" in the ISA string when svukte extension is enabled.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-6-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 66e00ed260..18f4d94b6e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -199,6 +199,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1663,6 +1664,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.47.1


