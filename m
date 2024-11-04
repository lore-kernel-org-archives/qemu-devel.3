Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5723BD11186
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kq4-000131-Nl; Sun, 03 Nov 2024 19:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kq2-0000oY-LA; Sun, 03 Nov 2024 19:20:58 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kq1-0002eG-4y; Sun, 03 Nov 2024 19:20:58 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso2831985b3a.3; 
 Sun, 03 Nov 2024 16:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679655; x=1731284455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l94YX/AReXz7G4uDRXUPyQl8Y+x+XtS8cAUTSBbRCkw=;
 b=lb3hU0D1WfxLk+uZ1MKKtQ4/aMAp2GfGFFQDCnb9nEnWcJkJdX15r6IkEji5PuRJXg
 yrHebYwTOAoRFXXGsgCwt107ulVQsDd8pgtvf+7be8vf9C37MiSPDErkD+NJUI8rkUUH
 wOU/Id5MIIGalp/ieOV2odz9nLiNc2d54a1hwQZstxhcbe7yEZCNBJQL38aKOR8rRyX+
 yyYc01/ajF3Q5kElkMpKJwZ0SthCvIGvGQc80gGoGvcp3GN9lv5N90kTch4Zg33YDRoH
 qqxfGVKLmbVLHiH14nM7V+rHTdoLXCGBHVq9qdzhc/9K6mhfIX9Lb6TQe5Jor+ku//vf
 EY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679655; x=1731284455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l94YX/AReXz7G4uDRXUPyQl8Y+x+XtS8cAUTSBbRCkw=;
 b=pVearEp1emb/HiF1Lgc6q8AEAWT5zUqqDGVHfQDQKYDvksLQlbDYRHxbUQLSWCLgbE
 6sDlj9veJ4eYamwqInkayRiX2vSTHBH3cWBJwsg3k29m07NHCPbGM/d/T7qzuFWtkzvH
 TC4HEHVKP2p4XTrU4RyrXzqvVcHExVoPmynrVjxKQF1oK9k/1vdHm8aepIowDBFuDPSy
 GRV7F5iiXrEHT//D3Bp1rKMry4XThPM1ISGlbO8xpqxd7DP6wRxRhDaJjz9a5+kBPvaY
 QrqNWnFyi2RxzfNXfdv+WT2sufn2iuglOF7ChuMKupBt2BB7GtWcx7nvZM4E6/Iy4Q/J
 3E1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsOEFpVXwxkM8kPaAXtjnCPwqCANOHOHTU/88Cgm99xxhg+YKAdWCnd/cGVpbGrq4BqqDC4iNzwA==@nongnu.org
X-Gm-Message-State: AOJu0YxKEtluFFyIqKqxMsivU3+7iqoGT9I/wYSiNAE4nBH7xrVs05J3
 bgDXX2ny8lTf0QMK/blGaMk7nWoJTMxhBDuYrUXGaX0YMEl9/2LrVhljuA==
X-Google-Smtp-Source: AGHT+IElnLRQgIUblUlRbMaqqTJtnFjL7sQFstDb/FD50U9/cEmA/5j5FSjF57KxsXyJToawiSzw0Q==
X-Received: by 2002:a05:6a00:1708:b0:71d:f423:e6cc with SMTP id
 d2e1a72fcca58-720c98d5c3dmr16120103b3a.8.1730679654941; 
 Sun, 03 Nov 2024 16:20:54 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:54 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/67] ppc/spapr: remove deprecated machine pseries-2.12-sxxm
Date: Mon,  4 Nov 2024 10:18:17 +1000
Message-ID: <20241104001900.682660-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 0cac0f1b964 marked pseries-2.12 machines as deprecated
with reasons mentioned in its commit log.
Removing pseries-2.12-sxxm specific code with this patch.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index faf88a177b..aba0ad26f1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4731,8 +4731,6 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     DEFINE_SPAPR_MACHINE_IMPL(true, major, minor)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
-#define DEFINE_SPAPR_MACHINE_TAGGED(major, minor, tag) \
-    DEFINE_SPAPR_MACHINE_IMPL(false, major, minor, _, tag)
 
 /*
  * pseries-9.2
@@ -5042,18 +5040,6 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 12);
 
-static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_2_12_class_options(mc);
-    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
-    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
-    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_FIXED_CCD;
-}
-
-DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


