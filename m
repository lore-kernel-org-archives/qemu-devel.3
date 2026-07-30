Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE2EC54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLte-00077s-Hj; Thu, 30 Jul 2026 04:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtZ-000740-M3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:38 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtW-00017t-Dt
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:37 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1f5208b38dso347419966b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399211; x=1786004011; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/tnwXOj7t/cEFP1sOccYZtkZUzB7jHG24UF0J+549AY=;
 b=EY526k9M9ytdaYss+uvIlWOtDLwjmLI+JF8I8wR6Ts4ViUKzLoeFPV4jTSAnRJlYPD
 21Lno+cOungxNt7EuxV3EporYl/vRXhXVb6tMf2B4Ys6+8BHI4RBBNIctdqvpLnckxsJ
 0PMcaKC7AEWcClblmZAc6RonTr9G5VrapKDLMgJukpR4Atnrc1i5NXtYhki8VklovALK
 XeyfaCrmOQX/bU+iiENFcj1Q++qmtHlMZnbd/klYXQ4YN2I4bnZksVkmN3sHS7jh9rbS
 eF9aTP24ZynMpih/07hdcGd2THMTM7nElzwRNCsldPNFsrp/96eHcj+bdXZNvGWOxLoR
 q2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399211; x=1786004011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/tnwXOj7t/cEFP1sOccYZtkZUzB7jHG24UF0J+549AY=;
 b=dZ5aQbuVTl2HRXnTLviy4abVspYE2PXIupxvnlxIcejbqeUf3CQPucSkOmmF6d1BDl
 ghZG7GNeHoKU4G/PmvcZGbHjMwbMa6sSsQaCxuXZK+wbpVMGTKus4DW7K0O8S/9ChinW
 dU6K6wCTRTexfP/CpACFNtPIIxbM2AtwgS9DrUAO9TI+rLac3JIbjn+x0jaPvCiYShRF
 +sx7W7CNoaoUaNowDRRANrq2PmiDfUA/dlx6D4mpsh4L0DqfRPTrAHnHxYUY60gTZB32
 hdAmVtOIxtQd+hOZn0NbBteUWwDrJJiPVzvd0JY4uPzQTCVkRcqWHQoH2xe9dw/GGoq0
 t1Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoI9bNixJVprSSMXaAVLw+4MRNz63Zgim2JMO/7F9hpjGHiv5kYrx3OE7pH1rN/K38lVD6fHz23tdje@nongnu.org
X-Gm-Message-State: AOJu0Yw//pV4MBRCTLwMYDIW1lwPn5PsmD1gojGBy1fD7Be8q+vDGPSr
 NFduxmvgMkCRGbSr/TUX3QDewwDEspUVhu+eoiMMU78Lhfj5M2jg7rhhYiERBa5iwrg=
X-Gm-Gg: AR+sD10BuTBzUaR5lTcspcX3UX0eMEqKXnMvR/el4Z9zsVDQgASfMPfc4Mt2TNGxSDm
 5p9dhuIm171tgsqFsXRnOqtZFvAXPASzS0M6QVmJ7olSipmxZ1OJR9Xp0l57dt/GRJ2UWOYGW1a
 JxuWu2uOAU9tpuvr1mnc81aCF1OPsH+6F3qjj9uN1t2DCcuD5Up03LpGAB5e75f0vsC1UZPSDrN
 Psdp2Gc6widMyEuN/JosVTQdrCBYKTDtW0ItzYUPpWc5kkvKu7MbJZ0i0m3Pdb5XhR1wY45Cyoo
 wwGEKKoA9KUL2zeovT4XH56QZktz+0NG2haQ/3GDoyftDmaJL7mKe82D/IJeWaJ2c9itnNXCvbp
 RDLMtb8DwDTvtqSSOH9zkdBzY0D44wpeIyQlVjfNCyBh3WpZLCge3I4Rmb+Anf6PH8OMGhxK56L
 21fPasgoW9Lijny4t5MKLlFatg8rHfLbUZZXqTF2bkB4Bhzl+d0Q==
X-Received: by 2002:a17:907:802:b0:c16:5f28:4575 with SMTP id
 a640c23a62f3a-c1fa58706f1mr77845666b.31.1785399211000; 
 Thu, 30 Jul 2026 01:13:31 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:30 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 3/8] tests/qtest/ide-test: add a multi-sector ATAPI DMA read
 test
Date: Thu, 30 Jul 2026 10:13:19 +0200
Message-ID: <20260730081325.1816193-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730081325.1816193-1-den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=den@openvz.org; helo=mail-ej1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

test_cdrom_pio_large() already exercises a multi-sector PIO read.
Add the DMA counterpart through the same cdrom_read_impl() helper so
the multi-block ATAPI DMA read path gets equivalent coverage.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ide-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 0fcfd0688c..2c674edf15 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1159,6 +1159,11 @@ static void test_cdrom_dma(void)
     cdrom_read_impl(1, CDROM_DMA);
 }
 
+static void test_cdrom_dma_large(void)
+{
+    cdrom_read_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE, CDROM_DMA);
+}
+
 int main(int argc, char **argv)
 {
     const char *base;
@@ -1218,6 +1223,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio", test_cdrom_pio);
     qtest_add_func("/ide/cdrom/pio_large", test_cdrom_pio_large);
     qtest_add_func("/ide/cdrom/dma", test_cdrom_dma);
+    qtest_add_func("/ide/cdrom/dma_large", test_cdrom_dma_large);
 
     ret = g_test_run();
 
-- 
2.53.0


