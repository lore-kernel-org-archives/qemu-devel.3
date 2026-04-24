Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF84FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMAa-0003ZA-BQ; Fri, 24 Apr 2026 15:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAY-0003SQ-RD
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAX-0001YB-89
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso53005165e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058787; x=1777663587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a3W4eM2x/CLE97cGb/OjgAFNHt4NwclYuyxbReGj0M0=;
 b=cgRtGdV/ciEwWuxK9236giDFhg3pmo3ZEYEGhRO/E6ki3mVU42/dfFvQAFjCTRRsJl
 PPpARJCE525BqPn8fQctSJhvgZ7kSnP2VCedJGRjTu+ISC9dlA21u7+0SfYREs2fUGHg
 XUTemWzPc92vnLTEtrCA4ZkLPJWYlwQf+G91/CCd6huQJYFHS1x674OfdBMgy7AD/zni
 cF+Y3kkws++bV6IEjDCzAHgzxUJSoT1tLeOOlxbBko3X5I1y4v+f+kY2aIJT29kWcMOw
 ECP9KP8u0ND6jStpAe+ehBPuZyGbd2JCS/wiz+ixD2NsHazAwQwQ9Co+6ZZG9pXrvoYL
 zG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058787; x=1777663587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a3W4eM2x/CLE97cGb/OjgAFNHt4NwclYuyxbReGj0M0=;
 b=tZ8ObJzmZTESZnU5BrzU3hOMoit5yyzuPNUAXlUCdDCOXKfB5ccflGGPyDI3SXxvPd
 PO5CYe3zMO8ktetCCUjArcoJRwPO2KvUc4m1Uyl27L2G2e9QZ8330o/xw0sqxkOG6t/4
 EBHdKz2ObGORLpbDRdVW3uo1jKMoQARmKYbRTyb0S2dpQ9F+lsxvGf/1ZP2mODxKdeNQ
 UuV4liHjlDz9zP+LH2XLjzMPZPtx4Eg1TaAv502nI1xRFVkU47bPfVseHKpv8AoZBMbp
 WqYl5FvWZ4frtCjr4bZ6YhwWV3QyzF3GJkaLlnHLUpN9Ti0dGSDnEhqK2kpGNA2VQ/Rm
 FyDg==
X-Gm-Message-State: AOJu0Yxo9bFvRuLAqYtMM41cj2F56CgsAxNCDaX9Okl9ZB73mNDCHtZq
 3a/eCdYA3rHYkfocLLNvNou0N2vZCvhMS1PGrlWA1ayYhwxTvxVniPr6cNgIGEUDI3rF1/LIV15
 f6jz6Xd4=
X-Gm-Gg: AeBDiesEcZ2v8jUIQx542JYeRH5nrW+7Yov5kNj90CGfXYpUJvpky5HreDqH50lGGHH
 AQOE9xgVzE1PQlMqt75OiNutTQxbqMfOAXFLWR7mqMmEppz3BEurEqaGA5n7XHLc87uydEraOU7
 O8p3ZkEHY/iDgo16MJmM6cpRTIji1q3/3pP0ZYkiZ7/F1lbPwfhxOm54eknTT92QSR+/DNGWi2z
 ARlBYtDkectcgSHPakf9QdiAJInsONVLn0sV8TQtWb37TWj8z9trl3YVLZBCG9VtE78NXDGkG6r
 HWIy1ABfqe4HYjZyDTIRhYVZ/c+OlidL9ubltpiNFuImJUBSAwyMlQ0bwFK4ExubksHpfPe1Ngn
 HgiB/3YIqzHrZgBm/PmO5V779z7IUrvtt51ve31jh2gG/ieP26OwKi+r5DwPZabsJa3c4Nzi7Uq
 U+kp/007M8e7Spw/QK65gN3iA1B26HM/DtazQxCvixgkEyLKbBR4EFiQV4wyLsi3rYVUm6UWFIg
 hZ2K9UGapM=
X-Received: by 2002:a05:600c:19d3:b0:489:1ae1:4eb9 with SMTP id
 5b1f17b1804b1-4891ae14f23mr323790995e9.28.1777058787194; 
 Fri, 24 Apr 2026 12:26:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891df9e50asm329548175e9.0.2026.04.24.12.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 50/62] hw/usb/hcd-ehci: Remove unused EHCIfstn structure and
 dead code
Date: Fri, 24 Apr 2026 21:25:38 +0200
Message-ID: <20260424192543.22614-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The EHCIfstn structure, defined according to EHCI spec section 3.7,
is currently unused in the EHCI implementation. Remove it to reduce
unused code and improve maintainability.

Additionally, drop a block of disabled (#if 0) code in
ehci_state_advqueue() that was never implemented. This code path
is incomplete and has no functional impact.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260424080508.53992-3-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.h | 7 -------
 hw/usb/hcd-ehci.c | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 0ae8c06331a..3aec0e047c9 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -202,13 +202,6 @@ typedef struct EHCIqh {
 #define BUFPTR_SBYTES_SH              5
 } EHCIqh;
 
-/*  EHCI spec version 1.0 Section 3.7
- */
-typedef struct EHCIfstn {
-    uint32_t next;                    /* Standard next link pointer */
-    uint32_t backptr;                 /* Standard next link pointer */
-} EHCIfstn;
-
 enum async_state {
     EHCI_ASYNC_NONE = 0,
     EHCI_ASYNC_INITIALIZED,
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 57f930b0998..23167bf96f3 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1756,16 +1756,10 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int async)
 /* Section 4.10.2 - paragraph 3 */
 static int ehci_state_advqueue(EHCIQueue *q)
 {
-#if 0
     /* TO-DO: 4.10.2 - paragraph 2
      * if I-bit is set to 1 and QH is not active
      * go to horizontal QH
      */
-    if (I-bit set) {
-        ehci_set_state(ehci, async, EST_HORIZONTALQH);
-        goto out;
-    }
-#endif
 
     /*
      * want data and alt-next qTD is valid
-- 
2.53.0


