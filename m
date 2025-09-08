Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1925CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 02:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvRzE-0004uc-Tz; Sun, 07 Sep 2025 22:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uvRz7-0004pY-Jh
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 22:52:01 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uvRyl-0003kU-2u
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 22:51:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7724df82cabso4457832b3a.2
 for <qemu-devel@nongnu.org>; Sun, 07 Sep 2025 19:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757299893; x=1757904693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQTGaMwRsY4E0LA8RI6FgJSJeVNA3/bkP8+cxXGBtWY=;
 b=MSapCeeqFjLD6REwvqWP0NRJuf8W7e2MTbFOVd9JK2NJErojyBCtRmv6edWL8sq/X8
 USrAprnBt+aGyNpcBwKvG2RxnLItGMWVEguQZKfGZWT+ZEQ+24M/kfmg0ylbTZHN4J+u
 tXxxcP96H10V2vMtzBHHl9jV9EhjVAeH2BIDu4Aee5olairP1HgaF9MYgULhFzDH3IL1
 iSVdIiXZHrYHKY8/ooCkoiAoax9g4OTMXchbjACBvRsFWXrKE52YftN5PPVCQwD6Iool
 mcEKuKXzV6yn+65lZi0NfAAGub9tjgFpBrSe+FsZUQF6LGyREw7VqBTufRozLzOBpthI
 3xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757299893; x=1757904693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQTGaMwRsY4E0LA8RI6FgJSJeVNA3/bkP8+cxXGBtWY=;
 b=OtaJNPE2hGeKlusmOqOfM1Y4HHjZ3MDB0AhSwd0I2f/SM0wyq/P6mLpaOxkvVjjAdf
 gxwo7VEk9Cg1RPbCngxLSOor9VuLlCjG1OgoprmQTwkbxmKiDB7VUXWIYM9yKQQxd6jj
 bjoudHsEG5LiuwpN6yHe0TruiK9PnekJz5QiHqeB7fNMXlu+zz5JhHE96D1KyyahrSDV
 f/UT/cr/82whdkiz7cWcSooy4xJRbcUc3bWffh1VlbV5+RgLi3xbdYpw9HhTscyRyhdY
 6VRgkEHIAqDdBe9a5voBf+j9/GFxgdKVz/S1r4Yd47d9qiMWvdDwUBbl+gcfzEbF2BEE
 uJag==
X-Gm-Message-State: AOJu0YzxUGadpvrfOmwQXPOYWQcxPottn2Nq7Gh6t0E3GOGDKy/VXLWu
 0ja+D0fK8KFADiXKappJpi83wY0x8KanI6YSFJuhW36g1D9XLH0rUWQJpHTqFWbHEu5McfavDh+
 m3RWwHnq74GP0CemBX+8NAqKZEBG4H2eoneiZ66OtxA9lrFmK01HhbKvDfGgnrRZCJpjLROFGqi
 7WxbK9LpJkiwYsJplWVUkMzOsWMzoH991Mti2ohAzxyQ==
X-Gm-Gg: ASbGncsOzMGETMofPaUUDDRD1rJVozQe+6e9lFJa0Lg0u1/oG8LQPANPj+QQ8NdpyR6
 TCFPC85ux+QU0VobZiq2QNAHvhI/sIT5UvqkOXs1FDZSf+mKRfwnDW+NFuK9+HpcQ9GTRtNJDUA
 70CkmxBXipC56ETAAdACiv+Bvqk8p7NxfKzzKQMGXMMVr6xp3eUe1ESbun2IupzRBiNt1nsypF4
 zN7NKWv0XJxGw/2Dx6sc/DFv4K6GC7IzSsw5+f8Cz/nXc6zMtONw4GBRZYenR5miZ+Pwxog6hvF
 /N+Z2WpqOv0PYMOShoZNg0IiiODo6OXZYZiBs+3og2e5O55N8m3LhlInAqsB96SebtoHdvB+deC
 EFrnha5uHkunzN28hu1/XmVAGail7dCND6Dgm9rdMfcy2P9eskYcs7NJEdkW6HepM4Lix8Y+q+/
 iTp553B/KJu3TP
X-Google-Smtp-Source: AGHT+IGCsJDONcPps5oWEWTc66jhlG2RbmthH2x/WX9FeFsDsh4/NCzwgDtNvBbug/sEziero9iIWw==
X-Received: by 2002:a05:6a21:998d:b0:24a:78a3:5b1 with SMTP id
 adf61e73a8af0-2534441fad3mr7981953637.35.1757299892472; 
 Sun, 07 Sep 2025 19:51:32 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-772306a1870sm26823834b3a.75.2025.09.07.19.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Sep 2025 19:51:32 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 3/3] target/riscv: Expose Zvqdotq extension as a cpu
 property
Date: Mon,  8 Sep 2025 10:51:17 +0800
Message-ID: <20250908025117.1728895-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908025117.1728895-1-max.chou@sifive.com>
References: <20250908025117.1728895-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d0909f7beb..68fdd2887c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1373,6 +1373,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvqdotq", ext_zvqdotq, false),
 
     { },
 };
-- 
2.39.3


