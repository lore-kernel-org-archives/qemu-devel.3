Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B781FC35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzE5-0004xf-Rw; Tue, 11 Mar 2025 09:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCn-0002JI-Ku; Tue, 11 Mar 2025 08:59:34 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCi-0007y9-Dm; Tue, 11 Mar 2025 08:59:33 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so7757705a91.2; 
 Tue, 11 Mar 2025 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697966; x=1742302766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhoSht0TisSg7cbroKzPBDpRepZ7Wrpxv0wxqbEmqv4=;
 b=initoQA76VoLv+MXY1mw1KGCP1UENAMazhjLvxhU5wXEMC417+RliIbiM5T9KvYIV3
 kPDop2eGCeV5ARimT90YLTeWaPYuAHS1emozpo2Um0cCviirGf9Dr5m03vsMn6MJ7UpU
 SO3yalhN1s+gGHWY1UMVtL8VJKaMTd6I1OE5Q0PTRz8lJtp70OaLOI6Mpb3WtYj7HO/0
 YugE4+34B0m4DIjnNuZ7lEM7JvIai97/mIaNhumFqJHVAm3hAWtGecBFHLL4Fex963o1
 nZO9jKc1XSPeLBe3CsO4mOEcuUYDwTCoh+JILm0fgHEg8+mfO2EyHL0OM6CebTmXCn2M
 WysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697966; x=1742302766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhoSht0TisSg7cbroKzPBDpRepZ7Wrpxv0wxqbEmqv4=;
 b=JY8MTl2cwBBfud+6MApVDd3c89ZO/fK3NzgMlD7JhvI3SY72qPDBBDJKzKcwCM9bSe
 ji6bhWbghp3p1cT1hFbU59n7yhB/CUdxR9ezmb98fQwxAdfVQinUVoWd0JNwUmoxAgSN
 8MPQ1o+XRyvxeSlUu1loauL+gKVX/5fmtwOFa3d3v3hmL1qhvsxAHOJ7AfYzGJzxz5AO
 bBhJu2ipHzIsr1o3B1oAxK5JpQiimh66EJOXJFo3y20q6wu7Uv3KcebNaDLUnQwSOSxf
 /gQf40NgjvmoQ3H0zDmxlcjVYhNFEAadrixKGZNroSDMs7jjg1nPAE740FS5SCoZYXVZ
 Za3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo7YXE0OEmW5SRtZ6xfes+ZBrAU97z/3/edC3g9WQ44A1YXY/uK2bWSkeVV6NYxXh+0lZ4I0ziKQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyfs7GR4bQnM+bBsZ6vn8j0JqkMCyxYDvxWXdl0zH6vlzA+bxZM
 gzwL+NzSOx76ZgMxW/kOGlAqazwPxUGBYHRFpwP5HY87eANQCsfmrDBesA==
X-Gm-Gg: ASbGncs7H321GTd2zMMUzcAYPOyf/YRluCSAd0TS9nWrx2lU9Z68GbEZxABR29YuqP0
 8WE6+Atf5672gKaOryI7ODbv7gLksV0CiGK8R191aTVxirQRyGwh2SUz2EmNEvL6xPnE/22z/yU
 KRwk/mymB1LkWcLqKdo7hTn2yZwD5TyNaZ5kO/dpl6CR1638NVQSDMe3WEteBXl2hWCN9yXQb/u
 E3y9MQQ9r7G06n2YdFPjhLgL7qNJjCyaf4jGVLETWPIeZISw9i4JjPqEmwRVeDfspJFOdiih3p3
 ekE64ppPQdAW9ATxvCO8zIM6+TQfKsfVu9LimNt1ONw1FuY1yOU=
X-Google-Smtp-Source: AGHT+IFMIafJM2wQ6gch2cDeaw1K/Ib/xE2lL58g/EsLcp2EJihtrxyjeceWntpOYYS9OTkpwwA6Qg==
X-Received: by 2002:a17:90b:180b:b0:2ff:5357:1c7f with SMTP id
 98e67ed59e1d1-2ff7cf3d0bfmr23969660a91.30.1741697965689; 
 Tue, 11 Mar 2025 05:59:25 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 18/72] ppc/pnv: raise no-response errors if an LPC transaction
 fails
Date: Tue, 11 Mar 2025 22:57:12 +1000
Message-ID: <20250311125815.903177-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If nothing responds to an LPC access, the LPC host controller should
set an IRQSTAT error. Model this behaviour.

skiboot uses this error to "probe" LPC accesses, among other things to
determine if a SuperIO chip is present. After this change it recognizes
there is no SuperIO present and does not keep trying to access it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d0fccc165d..0e02ce6e94 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -353,6 +353,8 @@ static const MemoryRegionOps pnv_lpc_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void pnv_lpc_opb_noresponse(PnvLpcController *lpc);
+
 static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     PnvLpcController *lpc = PNV_LPC(opaque);
@@ -376,6 +378,7 @@ static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     if (result != MEMTX_OK) {
+        pnv_lpc_opb_noresponse(lpc);
         qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
                       HWADDR_PRIx "\n", addr);
     }
@@ -406,6 +409,7 @@ static void pnv_lpc_mmio_write(void *opaque, hwaddr addr,
     }
 
     if (result != MEMTX_OK) {
+        pnv_lpc_opb_noresponse(lpc);
         qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
                       HWADDR_PRIx "\n", addr);
     }
@@ -511,6 +515,12 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
     qemu_set_irq(lpc->psi_irq_lpchc, lpc->opb_irq_stat != 0);
 }
 
+static void pnv_lpc_opb_noresponse(PnvLpcController *lpc)
+{
+    lpc->lpc_hc_irqstat |= LPC_HC_IRQ_SYNC_NORESP_ERR;
+    pnv_lpc_eval_irqs(lpc);
+}
+
 static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
 {
     PnvLpcController *lpc = opaque;
-- 
2.47.1


