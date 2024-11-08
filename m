Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90695D5E127
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 03:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Fhb-0008U1-EA; Thu, 07 Nov 2024 22:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fha-0008TH-0D
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:26 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9FhX-0001HH-06
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:25 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a6adaee7acso6158955ab.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 19:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1731036620; x=1731641420;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCrerRQTXGrD00ddnS/Hilq6giLmAcGDIEPH6vUua6s=;
 b=yf7edY8nuNvwnjwDbIv2YMBf7odxM99ZxDWOuxSTFoZsaFcxLWiesKjte/2taylpFP
 jkI9QaUOYrXDIOdRWg6Rs3Eebv2Rwy/F6kQfB0Fn/TrX/nMotpJ/xpoBXiY+1YrHuoR8
 MzvF7vOwruXln6j3PyPnUTiftJUDv4u7it+viQPi0dxyH6nshKqy8IqGTrPIgHkHonxb
 sz99qWbsAcpLTgudZUglG4t8tVUEBVquX9pVeO7u06jirs0VOWfJDTi5thtTg1DDMfI/
 Y5LE6ZZRkJysFAaLkyrtxXPSc3/G1LstrOAcgm5wiBXYPtbZX6PDUmLLjZ0QC5KsP2eI
 9XUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731036620; x=1731641420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCrerRQTXGrD00ddnS/Hilq6giLmAcGDIEPH6vUua6s=;
 b=xMd03D41GmCM+31yRVkjaHDKvIedHKr7L7PHQo34rY6HH1jDRjdy5gRUf7/01x7+qs
 w4QVvTdVeyw2jEvPWqO3yzb3/zk8bzd6mVIwbPQAf1r6iqWUQ2Dd1nsk3Y3idSI31Cp5
 fXdAw0FAZL5y8tfCSFRSjZu4ykpk95JAlR1KCs2RfqebzVS79ufpEVPqKmDA1NpZ8Ax5
 ID8RiE2O+Iwqt1oMHd/05mYg1K/G/MBySYaB39Q3cbU8Vec/n4XstBMtABXvtJn0UbZb
 mq2WzmAHgZm0yE1DvNbzkoLmwaPUhMLCY3FPIgDS6Kt5yFAzXpissEIq4ZWS0i+mtfrn
 9JuQ==
X-Gm-Message-State: AOJu0YxBlFqr/cq3MlR3Fj5klke6zmAsb/8XFLq3MT662xt2BMK3Vosg
 QD1hwhkum2vvEyAjm44Tc8Yz10UKkJQOQB9r/ltFt3DiINUytxCB3zM10hKN7PJANFSXrAkCaKe
 W
X-Google-Smtp-Source: AGHT+IHuAnySDLoX4U4V6syOdK8a1Qm+ZKR4pIxN3TRjyI4qCO35oUlg7cbch09RdEhXS4e3TMF1/w==
X-Received: by 2002:a05:6e02:190e:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a6f19e43cbmr19854955ab.11.1731036619986; 
 Thu, 07 Nov 2024 19:30:19 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65d358sm2326435a12.84.2024.11.07.19.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:30:19 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org (open list:nvme)
Subject: [RFC PATCH 1/5] hw/nvme/ctrl: specify the 'valid' field in
 MemoryRegionOps
Date: Fri,  8 Nov 2024 12:29:45 +0900
Message-ID: <20241108032952.56692-2-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-il1-x12a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

'valid' field in MemoryRegionOps struct indicates how the MemoryRegion
can be accessed by the guest. In the previous code, the 'valid' field
was not specified explicitly. As a result, the CMB area could only be
accessed in units of 4 bytes.

This commit specifies the 'valid' field in MemoryRegionOps of CMB and
the CMB area can be accessed in units of 8 bytes.

Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8e4612e035..acbd10628f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8166,6 +8166,11 @@ static const MemoryRegionOps nvme_cmb_ops = {
         .min_access_size = 1,
         .max_access_size = 8,
     },
+    .valid = {
+        .unaligned = true,
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
 };
 
 static bool nvme_check_params(NvmeCtrl *n, Error **errp)
-- 
2.43.0


