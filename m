Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84C2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 21:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGl15-0002S5-4Y; Wed, 05 Nov 2025 16:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGl13-0002R0-1k
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:26:05 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGl10-0002DM-VY
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:26:04 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-4330dfb6ea3so1213045ab.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 13:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762377961; x=1762982761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QM3K60OsI5L4i2OEIbf7h5rJNwATR23lL1MzRBepSwk=;
 b=NQ8sih3Tn80jsLZnZlCMFDh8tLvRXIUrtCGlI7p4X+bT6XqIfJY2fOmW4m81i/8/wn
 vRVGPJcsOfLAWH9pUeivtmZhxa6+0q9XtcHEibWC3CL6RDW1RfRbw4uBn4SSzQxjsXZ6
 JIxzhxVZQxgbdck+xVex9cpGBou4iDIebxD1BvBXA+BM0uwmjvYiiYd5aKLnsYmS4N3M
 XZfiGFCuDpq0Il40q8yRTP+4nCfdqus5SXo0ONpx/sw4Y4b/ETJeDCdGneUCfaLH8qI+
 kgMEYKpWYGMsIrp2y62ppChTfRJ6v0pnPJ7xAsBdJjXN9wW5hKmCrUCCBbTBFweDNHor
 3b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762377961; x=1762982761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QM3K60OsI5L4i2OEIbf7h5rJNwATR23lL1MzRBepSwk=;
 b=tExwBs8/A/bG4rID8RT0xCbRoY2v12+4wuFE7nFEWQ5f9BIYMyBXdTrKg68Foc516/
 3yLANf1Juajt0zeGeSBnX659vUl2gAni6Kp8kW69hnv0a/PnTnVxEBWx+PqdCEnkmztJ
 pPcYRbCqQ9ZqfrZuvqWcCBSw75k06b7Ci/xGdxvxavDBuAobBnan0KWAn+wY2MOISrFp
 3Qd2EJ9jvRf8r2X/uxQT18HWUdAmLsJVIKvgMxPyNp+/MpbAf2xuD8H8oKCr4/xfiAQU
 xi0hFwCePyZR7suQqUTmELxIJO3wjLERggt0k8DHsE3Dz/1TmV2zoBu5xcWjDxOzI4vQ
 CWfw==
X-Gm-Message-State: AOJu0Yy1f9WFkWw9wvUeqLNoeWEIdzJqjReAkyb9KnVCG12z2I7gw8kS
 QzPMuK6S8Gld+7f6vpIvkVll77oatEbq2aSpdnj8K61IhfIDW72ia8b+3MWOwvz6Vb4=
X-Gm-Gg: ASbGncv0skp2FuzF5rOMjjdaQ7zrSyggW9hN9/GWSNgja+fF3JfGOynbwEAOGOdiu65
 PG4urH7O4ppyDdH4Ra+K79ImVf+z0JmM9uBreiBs8tj4RHd+Ty1PnIe9F8jb0GDx3689y0uopYQ
 3Yyp/E3nrd5xwfOXkBHhbpH+TxlW0T0jZbs08vrBYr40K0AGzFBK/M5D3RajH20rOpdlWXR6vbr
 da9sdILx/5dRzkZ6FyXzlVRwQ3qmfQmFBmCaltmt87FpF+5BIFWsS7JEShwECSSMQiLQZO+FB+0
 UkrSFod5K8fZLPbCE1M5HlKx6dRVuGNBLYlzp6vUrf99cRuEvJ+qntk5Xa8XHRJ2c6mjZvkD5pw
 FpjtiFXDW/qW1o9Bt76I/ZVZF2Rfd0pu7jEM/epAdtEofWqBaJNWp5f66EMJ3NoU/e2O2E27YDZ
 VOQgOYVNobmB2CGHrOZCb4qmk1+NLUD+p2CZfniErFkkz9/mwEFJ3qswNTG9DiXhEUNw==
X-Google-Smtp-Source: AGHT+IFxEoixYAmFcUGsjf/sq+3gwgk+BA5F01xOR8Ty/vemCY2FC3KlydrnybB7o1Ko0hdBERvzbw==
X-Received: by 2002:a05:6e02:3182:b0:433:27c1:75c4 with SMTP id
 e9e14a558f8ab-433407dac54mr77782055ab.31.1762377961371; 
 Wed, 05 Nov 2025 13:26:01 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7467d5a0asm127785173.2.2025.11.05.13.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 13:26:00 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 3/3] Hexagon (tests/tcg/hexagon) Add test for USR changes
 in packet
Date: Wed,  5 Nov 2025 14:25:54 -0700
Message-ID: <20251105212554.127017-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
References: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12f.google.com
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/usr.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c
index f0b23d312b..ef1787c64c 100644
--- a/tests/tcg/hexagon/usr.c
+++ b/tests/tcg/hexagon/usr.c
@@ -608,6 +608,58 @@ TEST_CMP_xx(uint32_t, uint32_t, FUNC, SRC1, SRC2, RES, USR_RES)
 #define TEST_CMP_PP(FUNC, SRC1, SRC2, RES, USR_RES) \
 TEST_CMP_xx(uint64_t, uint64_t, FUNC, SRC1, SRC2, RES, USR_RES)
 
+static void test_usr_packets(void)
+{
+    uint32_t usr_out;
+    /* Test setting USR bits inside and outside packets */
+    asm(CLEAR_USRBITS \
+        "r10 = satub(%[val_0xfff])                   /* Set usr.OVF */\n\t"
+        "{\n\t"
+        "    r11 = convert_uw2sf(%[val_0x010020a5])  /* Set usr.FPINPF */\n\t"
+        "    r10 = memw(%[err])                      /* Force pkt commit */\n\t"
+        "}\n\t"
+        "{\n\t"
+        "    r11 = sfadd(%[SF_one], %[SF_SNaN])      /* Set usr.FPINVF */\n\t"
+        "    r10 = add(r10, #1)                      /* No pkt commit */\n\t"
+        "}\n\t"
+        "%[usr_out] = usr\n\t"
+        : [usr_out]"=r"(usr_out)
+        : [val_0xfff]"r"(0xfff),
+          [SF_one]"r"(SF_one), [SF_SNaN]"r"(SF_SNaN),
+          [val_0x010020a5]"r"(0x010020a5),
+          [err]"m"(err)
+        : "r2", "r10", "r11", "usr");
+    check32(usr_out & 0x3f, USR_OVF | USR_FPINVF | USR_FPINPF);
+
+    /* Test setting several USR bits in the same packet (no pkt commit) */
+    asm(CLEAR_USRBITS \
+        "{\n\t"
+        "    r10 = satub(%[val_0xfff])               /* Set usr.OVF */\n\t"
+        "    r12 = sfadd(%[SF_one], %[SF_SNaN])      /* Set usr.FPINVF */\n\t"
+        "}\n\t"
+        "%[usr_out] = usr\n\t"
+        : [usr_out]"=r"(usr_out)
+        : [val_0xfff]"r"(0xfff),
+          [SF_one]"r"(SF_one), [SF_SNaN]"r"(SF_SNaN)
+        : "r2", "r10", "r11", "r12", "usr");
+    check32(usr_out & 0x3f, USR_OVF | USR_FPINVF);
+
+    /* Test setting several USR bits in the same packet (with pkt commit) */
+    asm(CLEAR_USRBITS \
+        "{\n\t"
+        "    r10 = satub(%[val_0xfff])               /* Set usr.OVF */\n\t"
+        "    r11 = convert_uw2sf(%[val_0x010020a5])  /* Set usr.FPINPF */\n\t"
+        "    r12 = memw(%[err])                      /* Force pkt commit */\n\t"
+        "}\n\t"
+        "%[usr_out] = usr\n\t"
+        : [usr_out]"=r"(usr_out)
+        : [val_0xfff]"r"(0xfff),
+          [val_0x010020a5]"r"(0x010020a5),
+          [err]"m"(err)
+        : "r2", "r10", "r11", "r12", "usr");
+    check32(usr_out & 0x3f, USR_OVF | USR_FPINPF);
+}
+
 int main()
 {
     TEST_R_OP_R(satub,       0,         0,         USR_CLEAR);
@@ -1097,6 +1149,8 @@ int main()
     TEST_Rp_OP_R(sfinvsqrta, SF_small_neg,  SF_HEX_NaN,       0x00, USR_FPINVF);
     TEST_Rp_OP_R(sfinvsqrta, SF_SNaN,       SF_HEX_NaN,       0x00, USR_FPINVF);
 
+    test_usr_packets();
+
     puts(err ? "FAIL" : "PASS");
     return err;
 }
-- 
2.43.0


