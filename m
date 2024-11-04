Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D4FD11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqI-0002KX-GE; Sun, 03 Nov 2024 19:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqH-00029q-17; Sun, 03 Nov 2024 19:21:13 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqF-0002fk-KK; Sun, 03 Nov 2024 19:21:12 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso3001145b3a.0; 
 Sun, 03 Nov 2024 16:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679670; x=1731284470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS5e0cmJm70PoeOBdgGBzyGD/H9fRXlahMrxXsRoESI=;
 b=Kls0iBlXDPLpA2AS+Hrz4Mwi8QeGPt1DpfsSAVoB/LmD53V7nlTSghBU9FeXpYh+1q
 YqoFgyT6WcQwO6iQDevLP4KvmRG6dK59uk6KFElaOG3teEHS/XWocCmxBJmH1Vuqt4Qf
 FFLEpK0y0FRulz+QBi0nrQfkO7nhJ7dmp2oSgZeH+oVaDEvLDLrMeCoIxMGgzT6KExZi
 Xk3o3aMpGmjRtmpQrzxctbQnBbCwQtNSEEhNTlS28XNtLCSsbV6t1VgkClHatxNNG4xQ
 gWM8l9Aae52kjEXPSsTAskLZ8KSlGtc2xGgmUyuepNuCEgoIkv4wC68BgiwtocS5c//E
 KqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679670; x=1731284470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eS5e0cmJm70PoeOBdgGBzyGD/H9fRXlahMrxXsRoESI=;
 b=AwDKg3yApt7rGjCEIa1KnPa4w4iJc9+HrjemaY88PCeUKPsd+fXUJ2znYUbW4Pwtgg
 Uhk+dJ93zwuMEtyupVq+C4dBkZ2GOxhpjutrjcsijiO0l2yWD1A2+2mCfkf2bZoh3DOt
 eyIh8D+TXCfWuNfTLrN4sitRNwKk6V1NFI/xPryVZ+kRfgFpfy8iMdPx3s6OEMB0hSF0
 xC8WGnzttOPjJW3lA2K/dCraDy0d6qIGEFhSN1BqjYCCNyw2O+USijH5YnCyWb+4KMMG
 Q+hyra62oxWrGMmxHfgp/Efrlpcl4F2qrZDpP0JtLlKCfGWwcIGRUCgWMRocyUPiVMIu
 nsEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiASuwPdP3jkPrEVlY18E6++DvgHCRlkhG9DQMdsLXRF22x4x7AH9qDG4kXSKD33fG2pWl/khvig==@nongnu.org
X-Gm-Message-State: AOJu0Ywbdj2xmuMy/ODMp4SMtQwPeMMdRDk2VB6uKf7bmJrOikZcPuci
 lTd5nzO4YDEKkt1LSBkf5Jw9YAyxxN1BZ1GKzaV+mJdRDmZmU7MBUOyiow==
X-Google-Smtp-Source: AGHT+IGBRdiqul7jiaZZZ1AkxZdusZUpcOV5ncl5HpqghuyoJO2uqGmoV7NgACPhz0GmVEtEgymy3A==
X-Received: by 2002:a05:6a20:7289:b0:1d7:86c:189e with SMTP id
 adf61e73a8af0-1dba41828fcmr15888482637.12.1730679669695; 
 Sun, 03 Nov 2024 16:21:09 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Aditya Gupta <adityag@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 32/67] target/ppc: Fix regression due to Power10 and Power11
 having same PCR
Date: Mon,  4 Nov 2024 10:18:21 +1000
Message-ID: <20241104001900.682660-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Aditya Gupta <adityag@linux.ibm.com>

Power11 has the same PCR (Processor Compatibility Register) value, as
Power10.

Due to this, QEMU considers Power11 as a valid compat-mode for Power10,
ie. earlier it was possible to run QEMU with
'-M pseries,max-compat-mode=power11 --cpu power10'

Same PCR also introduced a regression where `-M pseries --cpu power10`
boots as Power11 (ie. logical PVR is of Power11, even though PVR is
Power10).  The regression was due to 'do_client_architecture_support'
checking for valid compat modes and finding Power11 to be a valid compat
mode for Power10 (it happens even without passing 'max-compat-mode'
explicitly).

Fix compat-mode issue and regression, by ensuring a future Power
processor (with a higher logical_pvr value, eg. P11) cannot be valid
compat-mode for an older Power processor (eg. P10)

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index ebef2cccec..5b20fd7ef0 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -132,6 +132,10 @@ static bool pcc_compat(PowerPCCPUClass *pcc, uint32_t compat_pvr,
         /* Outside specified range */
         return false;
     }
+    if (compat->pvr > pcc->spapr_logical_pvr) {
+        /* Older CPU cannot support a newer processor's compat mode */
+        return false;
+    }
     if (!(pcc->pcr_supported & compat->pcr_level)) {
         /* Not supported by this CPU */
         return false;
-- 
2.45.2


