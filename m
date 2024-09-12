Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E03EEB565
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofVu-0003dC-UL; Thu, 12 Sep 2024 04:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVS-0001f9-N7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVP-0000Kj-FT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so6048545e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130926; x=1726735726;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zC1BgrRV5Dt8HdtJeR4S+Wxt3POJ06XSXjcQ2vYdTCg=;
 b=O2gnmYjFmNIOe+nhP2lv+ofZnr4KYcnKDOqRw8KgFSDJOODcuLFfUg4R3d4MmMvj9p
 ZIo1OvN4t5ACRwXbSUnAtL/ovHvqCjvFtITQsVunxk/eOHVB+2rr3ay1CPjV6OjWno3N
 /z6WttxzqJlVBI40CtyaGYfwK6U9Z4IJ/uHj1uvlpXLRigZ3slgF8e9D22+0iBCGDStE
 CpPQFzPS8uuAmzNfhs5CLuxvb1EHqeAcL3I7qf82PqLpwHQwm1svbQbgYiz7N4ozulyv
 ORZ8LpihDv0/yiOegt9bUCKLjwLvKJEwJP0VwxEbXmkphH7Z5421kcaWEf9Q5/w/tA2R
 TRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130926; x=1726735726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zC1BgrRV5Dt8HdtJeR4S+Wxt3POJ06XSXjcQ2vYdTCg=;
 b=pNfCFoXD4ibOmYSpLtY8JKaFiuDFBJPX2pEdomOLxOzqm4XCaiEIIBjwaFROh2Tsz1
 J5kN+Q8dGuICvnCorVC47ijN6WhRdBKaJWGelw2XALFboEHTIhmdzVJMB8fJiEhpX+Yl
 ezMUFxb8nPenf5ixE/7WLlFWoTvRhCIlePDdnFgfWsWj1bOErhpkdLi+CdEkF4l+GpK8
 nMtmIushux4lvT52e5O2VGrFyBDlisMqquIQ90a978/dA9hP6nQKIqIDWaFwjDqbb02h
 i3nRSfumu3pFGgaS0BGIQPGFozfDoEzYxAZ6olfS6mkbcoWXV1pVvDNNd5G0/rokYhCm
 9vog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOjcoDyBjOW5tFUdQtr/hkfU0XepSS/E/rxUHIMns8Ut07hfrnxAWhZ4YGYe2ouVM6IIkbq/vTv0L2@nongnu.org
X-Gm-Message-State: AOJu0Ywdt12AOf8QF5gRVu+3Qd4wU87ni66+tZhrrzCdWBOqVKaBz1xG
 e6+zdU3HCYGF9MchQive7EJtDEGX6ObOvJLO2OhYWQOiKGhb7y/FhDO8hFH40IU=
X-Google-Smtp-Source: AGHT+IFn6kArx7+XH06GRcDXpDUfkDgPALhqwHSCE0usQjx7DspvXODg6LtSKxXRly6xWfTww5FSEw==
X-Received: by 2002:a05:600c:470d:b0:42c:bbd5:af60 with SMTP id
 5b1f17b1804b1-42cdb56aed1mr16553285e9.24.1726130925636; 
 Thu, 12 Sep 2024 01:48:45 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:44 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 06/10] target/riscv: Add `ext_smdbltrp` in RISCVCPUConfig.
Date: Thu, 12 Sep 2024 10:48:25 +0200
Message-ID: <20240912084832.2906991-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This variable is used to determine if the Smdbltrp extension is enabled.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index dd804f95d4..4c4caa2b39 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,7 @@ struct RISCVCPUConfig {
     bool ext_sstc;
     bool ext_smcntrpmf;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
-- 
2.45.2


