Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BCFC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafen-0008Sl-L0; Thu, 15 Feb 2024 12:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeH-0007xa-Ua
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeD-0003w4-LL
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41202eae372so9217135e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018544; x=1708623344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MNTPsQRzoqmftQhTBcbelJfnU9cJQRI1c9iRR59LD4I=;
 b=QPxsSwuHSOwBu+oG35IzOSPE2cQ3mLyPcDiH+b0t1F9QC5GLDqwYPhEooKfY2uI1oH
 yfwXELWVSu1e2UE/oOn0jQKaR0ue1GHtUkTPWog6hTQr5cElCWRyR0Jl1uv19X0Z8Zqi
 OP6w/TtPofUpOjYgd9qn9AeT6WmNejuVFedAt/cxAIPIIhIMeIF90mjxB34CrSskFjIV
 BgE+dQxgNG69l2dAvalkzLI9ToOvqVs/nJQcsbhqZ9pzRDfGAznb2sgbmFVvnY7bqpDs
 VKxH+JO1deLjr70SzNtRcmNKzpf+mPJ6jSJQn1FHKwkUuBjRdlbcz4yPEh2bI8TQpXbm
 vHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018544; x=1708623344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNTPsQRzoqmftQhTBcbelJfnU9cJQRI1c9iRR59LD4I=;
 b=aCSLModuvRJh3JXa/0hu076iCPH1v3l3pX8gxoscV2ABNvOrzfAzDSsw4Uo3cI3Flm
 UpwvjjnA4mxnYLRSVVrXLWNiTCU8GENulbpJn/f3nnhzHkNt/AG8hlnAM1PGt2j7NKHr
 X2zncTzDohTqduiOWdSlOT8vGLMOasfF199LkppFejz+8hkAZ5zXzeUQNpCzG7160+kj
 VWpIVpxKrrZR5QH0h+CFYf8BXs5WGvvs7JtN9VLnozoFAaip1oljDwlYpKxlwE3Vv071
 ipVVDrS6yaWEbsmcRCbfb0jKpO3DHFSvTtVqBCSFeeVWMRJ4dTse2e8Ooz6u82Z1Y8wT
 WobA==
X-Gm-Message-State: AOJu0YzIAxS2m+OEfT9NE4sdYZHfHMflTaO8WpzoE++Uh/WIgGouNk4a
 g3hzNQ/Sx2YtKNhN0dPn9iRiEV3ugre5n0+HfeT/kIKlFLeLEMdveXtKJ+HVjIWQ8Qb8YVGlRX2
 u
X-Google-Smtp-Source: AGHT+IERmWFjsbeDLcROpvXNXkTXjak4bixIsq8uKPKgXKN0kIf3JwGN2FomaOEKdVTPEIin49Y+tA==
X-Received: by 2002:adf:a183:0:b0:33d:4f9:d418 with SMTP id
 u3-20020adfa183000000b0033d04f9d418mr1649124wru.39.1708018544366; 
 Thu, 15 Feb 2024 09:35:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/35] tests/qtest/bios-tables-test: Allow changes to virt GTDT
Date: Thu, 15 Feb 2024 17:35:14 +0000
Message-Id: <20240215173538.2430599-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Allow changes to the virt GTDT -- we are going to add the IRQ
entry for a new timer to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Message-id: 20240122143537.233498-2-peter.maydell@linaro.org
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..7a6d4f80214 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/FACP",
+"tests/data/acpi/virt/GTDT",
-- 
2.34.1


