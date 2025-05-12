Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECFAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZa-0006tS-Se; Sun, 11 May 2025 23:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZY-0006t9-Nz; Sun, 11 May 2025 23:11:21 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZW-0006hz-IF; Sun, 11 May 2025 23:11:20 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso3600922a91.3; 
 Sun, 11 May 2025 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019476; x=1747624276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjS7Caa/Jdkyu3/JbXJvHbWcGDcXF3XHk4HHHbK6yHc=;
 b=nnSoWOiCTYWuJ08i+P0Mg6wbjDh7oxym+VS06TwIzX40SukcleXx6XtEiYRGObGXtF
 nL+0qZsXXRbLpZ8cPVpmCB9/88cnvfpiqszfW/LaSswpxTcalu785cEdXAWJMx0kMtBz
 C5jlCfj+4Xm4WGtXB+s3dJJ2aE0clMOohVA/ntlc1PHfni1j6yE18mEoMpK9Z2ST7iF3
 AWsMCoDdu+v02xp1XxDs2lActH5d0Gr4m39Zi5xKAiz+PUxJcEBVytEiHxCO/obO+RFi
 4sIMhGjhCA6x8kX6Y5Z+x3hZGQCRdcfvlOzePyuu7oYjJ7WkZ8iVnwgFsoszeEVNAwSI
 FCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019476; x=1747624276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjS7Caa/Jdkyu3/JbXJvHbWcGDcXF3XHk4HHHbK6yHc=;
 b=WgRdCalIbA6pZ9reB8/9mxby83OgEs3k86K2KLSydzWJx+2K+LAemIVauR45m31Ygu
 dXggGSuff4gdiCkPkB51XxyrWHByj5AaqmpPqpW8ZYO6EpfioIfPs0ANPk9wpE6d53pY
 wK1W/5F/oenFOGJOnUUkTC4yfATeF98BlJ+XwG4TzHTKgeqcbDvCeqqnTjLwQry/1k/S
 VLNHJTO9QfYRpJnKutIJWLmZ0JsQGjJFh5+f1+Yfo+BEnMM7nL4olNUPZ34l2PTGz4Ll
 IlUNz421dpZTEAnGM260RWcw7qCYLUTDrqu3upNBHXRnx7cxO6jUc6AC0n3zZ+Dv1Vmv
 kJOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJlcxatJZ5SN1HDQDIeFHzFEJl1n18A7aajkLFo6mAg2edTcTdI8irTR0dBr08CUI2xKs229wZGoxd@nongnu.org
X-Gm-Message-State: AOJu0Yx6o180Xbu3HcIABVYKtJzeUrST8C8Vdt52/1lQEnrcft0/cnIt
 O+ukQYvrLM7bjtPvdpvi0SW7j3Q0jRSlW3PTrtq4l978nonvRlf1BIqlbQ==
X-Gm-Gg: ASbGncubSNdfDpvFnvu8AewM/2BFxPI8hccdSqQRM9DriZWuAPRZAKVTUUeIngUolxg
 miX8mEB1tgHhnyWCls93opbHnoNM9znVQyCm/S0TmBNWurn4g4JVQwS5IMilPcyBGeA7DoIfCeH
 ob8JGBkcmInUSGj3ArITfd3WHGwqjUEXaxb40Qrpneyc2eexJneT/fJY0QCn0XVIIW8+C2Pc25E
 J21RSNerk6++EmrBz21w/U9LRr+G+f+/i7lg+3HfSUWW+pVZ2AwGwfDCqqssk9/YaQp07WVhdvW
 J8FlgH+CKKiLDap1/9rflJXmFNw/h6IuDVyNno4c6UIgTTjqpstiJ/DQaQ==
X-Google-Smtp-Source: AGHT+IHtHEqoq7qJkXIQejW4V0ntUyBSIcKsd4acgabNCJ5rSVLYLAp5xu+Cx+zMbAcc+SErkFaUbA==
X-Received: by 2002:a17:90b:3c0a:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-30c3d65e84dmr17991070a91.31.1747019476120; 
 Sun, 11 May 2025 20:11:16 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 02/50] ppc/xive: Report access size in XIVE TM operation error
 logs
Date: Mon, 12 May 2025 13:10:11 +1000
Message-ID: <20250512031100.439842-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

Report access size in XIVE TM operation error logs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3eb28c2265..80b07a0afe 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -326,7 +326,7 @@ static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
      */
     if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA @%"
-                      HWADDR_PRIx"\n", offset);
+                      HWADDR_PRIx" size %d\n", offset, size);
         return;
     }
 
@@ -357,7 +357,7 @@ static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
      */
     if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access at TIMA @%"
-                      HWADDR_PRIx"\n", offset);
+                      HWADDR_PRIx" size %d\n", offset, size);
         return -1;
     }
 
@@ -688,7 +688,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
         xto = xive_tm_find_op(tctx->xptr, offset, size, true);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
-                          "@%"HWADDR_PRIx"\n", offset);
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
         } else {
             xto->write_handler(xptr, tctx, offset, value, size);
         }
@@ -727,7 +727,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
         xto = xive_tm_find_op(tctx->xptr, offset, size, false);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
-                          "@%"HWADDR_PRIx"\n", offset);
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
             return -1;
         }
         ret = xto->read_handler(xptr, tctx, offset, size);
-- 
2.47.1


