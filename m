Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EEFE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFh-0007tW-3E; Thu, 19 Dec 2024 20:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFd-0007bs-NP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:26 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFa-0004aV-NF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:25 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-728f1e66418so1269306b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659781; x=1735264581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2jazWrbuU7Wql6HgnR4OcxPEdzrMN59Mrc21VP922M=;
 b=WLWH0UnrkyA8kx/AcVXGQigZqPC2Hr1Kc9V0KnL2I/zhJDJoBS2kgrI0GtZwUdSvYY
 OFitw9ubBx0NZrkHuRK03FPJHujti4sEqbbAdES7isuUPTomDGvWz2EvQu8QERC+tnBk
 Lke/U4URdx7zPCyvaGShKPbyh1JUVr/yuEf2bxn9CEnQizRMypVpneiNlAAftv7/e6r6
 cq1M7khFcrr81aTHauxL5m7VAt5NroZViWklNvpvDrvT89kJrNkTg9JchiqB2FzOX923
 3/yO+2/Mq70cRBSOfXHj020uwF3DhU+Ua2xxWdREogazu0xsTdKyI4g3JWXd0FJ5Hs1F
 3Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659781; x=1735264581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2jazWrbuU7Wql6HgnR4OcxPEdzrMN59Mrc21VP922M=;
 b=HbVg7V20pG/a0Npi47SfZapagBFFeckH1cNh6eqx+cOlPrq0ABXtwvUROY4Ug/R44S
 xj3eauz4lbXpcGtdq3DtXbQYoqb9elUdwZLBbDMrwkMCXdNtOM1SPVZ0PQvgcNemMVZT
 6KTFxXwm+cgLTM5L7gtIe9yA433ev0JsTex5mSbqKgXqJj4Ie4bnqupVbW9fkR5ns3pY
 A+qvN7CDjd4doVbmdTsbiJFr4ReIClo4wcsUNkHW0jZSS6xEVqUNOGfWUXmV7gQDEbVz
 kvnpOIN844w0kJcNsBkQwFzY5EOSvDabk9Yz4F9vyACFBAK2ATpbDzaWJ/328RBdDDDr
 F7Dw==
X-Gm-Message-State: AOJu0YwCrIVYs3IpvjwsEo1YFnQ2zfN8QBagi/h/DajC3ljDuSwYPzp5
 ASPCCvtRizvZ1nX61u+64bKJF6mUTlCj4b4ajkahKzONKCTr9/0AMNgEpmri
X-Gm-Gg: ASbGnct5NKZ3xD4EXjNJllKL85VP9fGMcsRMleoaosdDFCk9e5H34cXiDh7InjJfA3z
 FH1zICSnsl/bHH0MuS86P1QsHLxxJO+9OTVYedmkozZnuQv0nRRqYkh058MQcPPtSpb0fwz1arv
 tcxRnMJidxZ2RVOBRJEexXboCoOTinzBCkl2QVZJX8qlW085kkgT0q6FtGa0gX7UbcIWNiIl+u1
 Jvk+5LGshkvxF3ywmdeTZyR0/iVl4DfUuswMJxYGKLaaQ3cTnR4XRtOLQCHe4pO3e8XERTGaSWG
 jn/alSG2w1rSJyf2rCBHSVj4fgFC2m6Hwt/ibUS5q2bcUU7NYFMqEj+L6cTyd1k=
X-Google-Smtp-Source: AGHT+IFuexxSoYXOBxUsvnsvho1gCeX50YC4icbf900gECK6W08VKiLhpWYjZoXwqb/k2lqFBIoFRA==
X-Received: by 2002:a05:6a21:33a0:b0:1d2:eb91:c0c1 with SMTP id
 adf61e73a8af0-1e5e081d161mr1641748637.42.1734659781039; 
 Thu, 19 Dec 2024 17:56:21 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:20 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 29/39] target/riscv: Add svukte extension capability variable
Date: Fri, 20 Dec 2024 11:54:29 +1000
Message-ID: <20241220015441.317236-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-2-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..d8771ca641 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_svvptc;
+    bool ext_svukte;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.47.1


