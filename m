Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F168AE68958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MhB-0006Xr-1s; Thu, 31 Oct 2024 00:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mh9-0006XS-DF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mh6-0006pu-Kh
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:03 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f53973fdso463422e87.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348518; x=1730953318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNeqiCOGTFAEwkUEnfoTPzEYRHaxcy1ybzEL1jmSNcs=;
 b=hd+KRJBx1haaDZjQr9vZvEvAdiBeMvJDX0LlFejf6IyFcgKqc+8I0EDVboipSBY/7S
 EbHlR+bCCNGLjq147MC1sJIo2gXw/XBXnfil5A5ijTtWh2oginrfdRYCWlCLV4Wu0lc7
 Fkhrk+LnAaO0Qzj/1GLjDPOTB5XZx14LJYxSY4Ey716pggfHsRJfmbydMTuEeY2qqbkr
 3NXuG/Oz+mOCuNtOq5VnNdQ1tiX8eOAbhWBIlp8dbGi9iQ0KTkidc/IXbK3MV306IYhW
 x/xW4GsW6vwjfz7eP1VHn8pZBZJVxHMoImQvvGHJIlCRLrfQSLspwS6ch6qRWakc6zPc
 x4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348518; x=1730953318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNeqiCOGTFAEwkUEnfoTPzEYRHaxcy1ybzEL1jmSNcs=;
 b=UD0leziesAGwyvWwnOxyS5jrx8dZJaPywQQBPkkc0ncdEtELppQ71ecLWjfyup63Vw
 hkRL9juuvlrWmDCmoVcZepQY8b8Ki9XwbWigX/7Ub/nS1uptgIa84wG90y23Ggjy5V8z
 cXFH11tDd1OmzhtP5s84H9DL/X6piOI16ZFD+KxACbrJ2NdFMRVxVNkomQ/eUj8OpDFl
 +5bXm3ohbmhf8MVGGrKodv3/NtQyOk1Gi75jPSFPDvHKGoM9qsIvkUrQDCxPUPyyl/1j
 LaFiv4Usmyi+ozmfRspcwpSQZe6UsWfMF6v3f16oxFbZum7XCDeir3iljAVxbEt7AdTa
 YfNw==
X-Gm-Message-State: AOJu0Yz3yJckpVhhKORhRlMERU2NB1QtNbmqxolinNcXGB8fZbVN1lkC
 T7mHYZmteLsiJg90zq+9g65v+xQnzciCQNnHRNPeFO+AG1IIGkEynV2oKCnLe+d8RdUqOheeUHf
 8
X-Google-Smtp-Source: AGHT+IHNcdEDadsP5tw69YLuznnaDEq/bRWd9h75I/NO6zV9dh/vz+jNv5X3cB6ygSCr+/B6H46vLg==
X-Received: by 2002:a19:5f04:0:b0:533:415e:cd9a with SMTP id
 2adb3069b0e04-53c7bc0c91dmr219786e87.23.1730348518203; 
 Wed, 30 Oct 2024 21:21:58 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc958b5sm79608e87.41.2024.10.30.21.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:21:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] target/mips: Migrate TLB MemoryMapID register
Date: Thu, 31 Oct 2024 01:21:17 -0300
Message-ID: <20241031042130.98450-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

From: Yongbok Kim <yongbok.kim@mips.com>

Include CP0 MemoryMapID register in migration state.

Fixes: 99029be1c28 ("target/mips: Add implementation of GINVT instruction")
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
Message-ID: <AM9PR09MB4851FB6034EDB7FA191BA47E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/sysemu/machine.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 213fd637fcb..91cd9f19002 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -142,6 +142,7 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,
     qemu_get_betls(f, &v->VPN);
     qemu_get_be32s(f, &v->PageMask);
     qemu_get_be16s(f, &v->ASID);
+    qemu_get_be32s(f, &v->MMID);
     qemu_get_be16s(f, &flags);
     v->G = (flags >> 10) & 1;
     v->C0 = (flags >> 7) & 3;
@@ -167,6 +168,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
     r4k_tlb_t *v = pv;
 
     uint16_t asid = v->ASID;
+    uint32_t mmid = v->MMID;
     uint16_t flags = ((v->EHINV << 15) |
                       (v->RI1 << 14) |
                       (v->RI0 << 13) |
@@ -183,6 +185,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
     qemu_put_betls(f, &v->VPN);
     qemu_put_be32s(f, &v->PageMask);
     qemu_put_be16s(f, &asid);
+    qemu_put_be32s(f, &mmid);
     qemu_put_be16s(f, &flags);
     qemu_put_be64s(f, &v->PFN[0]);
     qemu_put_be64s(f, &v->PFN[1]);
@@ -204,8 +207,8 @@ static const VMStateInfo vmstate_info_tlb = {
 
 static const VMStateDescription vmstate_tlb = {
     .name = "cpu/tlb",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(nb_tlb, CPUMIPSTLBContext),
         VMSTATE_UINT32(tlb_in_use, CPUMIPSTLBContext),
-- 
2.45.2


