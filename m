Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63637D11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpu-0000MU-LX; Sun, 03 Nov 2024 19:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpn-0008LG-2x; Sun, 03 Nov 2024 19:20:43 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpl-0002cy-K2; Sun, 03 Nov 2024 19:20:42 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e467c3996so3014259b3a.2; 
 Sun, 03 Nov 2024 16:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679640; x=1731284440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihxo8YcbpgEvneRaDyNs0GlE2KBNePNm98Xoy4GwpxE=;
 b=bdEHjUj1W/FNSyO4/AHIBnqxKvkMEAl8ElBp3zrJG0TuXrNx7ptK+OuOzE+HAobgQi
 ocvcTvdIh6uEgwiRMzabLYCfFbiEmrBRYq/uypQQ1Ncv6kwY5YEMy6eZXs5WEoSQ8Rbl
 ezfbL2gA9WNeozhvNL6vt1XxzPiN0d+anTM31FWW1SSTliXzE8+MlGu7+VNRhVEP6/fp
 FZEaNsmjEOk69xgH6TYXQHQXvCtG5G8Kpwdh/O/LBafLWXIYLXK+OmaXe2mcLDAcEocw
 pzA58XTlrdcw2zzpKlVOS+PFq5v+TO5upgtY6ARtzJuN8ZoyOoazsWlz34se0hcZL2XC
 Ws4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679640; x=1731284440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihxo8YcbpgEvneRaDyNs0GlE2KBNePNm98Xoy4GwpxE=;
 b=HW4OVMPzGKXndyvZIxDg58jLP5rksLTErXlUwv4qt+chbwGU9bM9HNqKAIsvx7364w
 GTND5Mpkq7IPE4QbusqO2jaATjn6yom5QQ3jo97Nw8YlX97EpHcWl/kxGAXwFKh7iJZA
 Ev5VM3TU7TDhkTvHgWjMRM9B7g8TZHr/Cyj2+H16N8OEYMfSQOQoS0uNeW2L6CjGzOHH
 uZnmclKuOK/3npVUibm9G8BUQFfNE4L5nifYxxu001plMjsgy7jycN9tWuQkZ1S6PHqq
 r5HHTKrWvZc72bwgMexr1g0HGgA0VO/Pa9kWe6PRNhHJpOubtswQKkXf8KbP8OcsKHMy
 IdMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcxOtNam1+9kKVeDUNaXLc7Zf2oCvdPxjrHhLtCgimsqhz17slpzYP4mfj06M8dvrD2PqP0A6CTQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyh4TZhNhWJ8fERs/dLhnbaUyxT4dhKfdoRogitOyCSfIqTwwJl
 4gSbU8P5/sB5FLsE8lWWvcZKT0qqBi318g8ltPNeMDEl/tk2r5e/k+0uiA==
X-Google-Smtp-Source: AGHT+IGzOgXgLy/7FcE7S4OLe6ndLIep7YR9CSwkm6npg/doZ+IAWteDlY41YSRpCEuT3HFAlHepZw==
X-Received: by 2002:a05:6a20:c793:b0:1d5:144b:5941 with SMTP id
 adf61e73a8af0-1d9a840afc8mr42896623637.28.1730679639843; 
 Sun, 03 Nov 2024 16:20:39 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:39 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/67] ppc/spapr: remove deprecated machine pseries-2.8
Date: Mon,  4 Nov 2024 10:18:13 +1000
Message-ID: <20241104001900.682660-25-npiggin@gmail.com>
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.8 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c89ab89b97..93decfcbeb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5185,24 +5185,6 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 9);
 
-/*
- * pseries-2.8
- */
-
-static void spapr_machine_2_8_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pcie-extended-configuration-space", "off" },
-    };
-
-    spapr_machine_2_9_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->numa_mem_align_shift = 23;
-}
-
-DEFINE_SPAPR_MACHINE(2, 8);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


