Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC48EFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAX-00062Q-G8; Mon, 27 Apr 2026 02:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAQ-0005Yx-0L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:10:03 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAO-0000uW-Ev
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:10:01 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso6047035a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270199; x=1777874999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Db4BIQG1gAcG9d057Bda1sVlVDq6zFiMCktQi3Fpjs4=;
 b=Z/Vmm4ZWBYJQWc52zdRS58oU7jvgKTEgPaK5TnmwC0zYhOn1ubzrIXRDIqZHEfbc9G
 /sLuYkm21xzBXYLXWjuQabTvovgFCLaYKh5kQEdK9XFdf33Sbyq6GziJfeCy96yTu3Tp
 Phbs3vFsNdWq77F36GlNyvlq1Lzab7u/WyvJjGvCAHhaQ2K7ab0r3owvUHkIHLQmYhIc
 CdtTpnK7UNzWsg7oK0l18w7pAxlPkEjJw90/nQzjlxa4WMvnNyYS8VAXbJsh36cphs7C
 oucr3jWvJI2ox2Z0wHFY726zkXV1HEwBSlMjDcisqFz2/FrM4wnkXDCxosyFJRHKZlZp
 j6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270199; x=1777874999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Db4BIQG1gAcG9d057Bda1sVlVDq6zFiMCktQi3Fpjs4=;
 b=AKmocE3NKZmqjf9vbWSdGHwtkypiY0crUPO+rlXtuydeWInvQNl6iMDS4vwFYYeAnI
 7KEUt+5lWxFEr+YvA3l4VPKoSnHJAq5wl3baDHaZEStMb+RIOgnlwgLCshKrsAjtcuoc
 aoLbfsSxahRrW43x/7FHkPYNtbSojEkM6PfSYs4yH+HZ3+8GhFb4acFOYnu6IQTyY+nD
 hIpFLRlo6ukFBN5Xgz9Z2sb76Rh+nV1gQ0cDHbIuGsRVraMgrZ6wucrdI+I36DZ/MKGH
 2oWsOTV5Dr/uZau0g45ftClkpfILusjvE7FOavz1GnGqHOAUuJuHvoyl0WtximQQ58wu
 /ElA==
X-Gm-Message-State: AOJu0Yw6UjanK90FByxtIOHF4mMBJurbgh90EkIhzUuAtjZBsFLDICnk
 ZLFGvtMJcCabSZ+yTt6bYR6p3FLgo9I+LNPjie1xFCZeBqMuyvo2fNHHA9JGN+oD0x+Q6IwH8HI
 Dozi+2ELkhbKh4aZA07Qb8qsYHYi7WM9m5mal4vjzCr0Y3M7UyEkscxPswhkknfZwdTQVK9kgyB
 NA2AHgrNCoh/AVCLIRMMDEnMP1lhu3HZfNqKeGYbI=
X-Gm-Gg: AeBDietwhQtegn9G0WOMRCnAOsqy4xEg+TPhY/CROwhVIEmVq4WkU3XENwkWKuiYYoP
 p6rLnGM+qwMiM0MSyffdmO9X2+j8FTdEIFC6eUTlMVfQDY65tXbpqWVYtbtvwwd2SVxWWNpXZRP
 /2COvphFm87HgY1SFDiO8rQUrI/SgZw6NwgLSylysaXpgCyeu9Utlx851nCHxj2YqtZMzTQj2Vb
 AJJNu2SePP7XnBX2jA+cHvFI1ci962djh7FBuqcsFAckgnEUnW6rEBkqooa8Pk9/eaiFIyC2k8y
 OOulX3DIV17Uubvvd3JYF7BFcNgsoB4mfVPGNLrGjLlb2XHKTXquB/8VC3Wzq+/BMIJ2SmuH2VK
 NuTSzMvDjgi0H7yo89MNu2CTZsNBIHSJgwZT3mCGSGK1u8ZlI+uYDnXk/fWYdsTFW4IaXxUqRqQ
 pjHsIstuE70oVfAUw1Tcu+cd+1XDaKtNdX3UMPC5KINpfsYBHb4ZmYYCsKf+KZH2Zzc6j8RQoF0
 L3PFZevLSaWfRPY2XGHCEYL+1dPkvfGq6//5ClDdLaXOlFa
X-Received: by 2002:a17:90b:3cc3:b0:35f:b69d:7292 with SMTP id
 98e67ed59e1d1-3614046c8b0mr42643351a91.15.1777270198901; 
 Sun, 26 Apr 2026 23:09:58 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:58 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 8/9] target/riscv: Expose Zvfofp8min property
Date: Mon, 27 Apr 2026 14:09:27 +0800
Message-ID: <20260427060928.2322570-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3746c79b01..4bd7075427 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1273,6 +1273,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
+    MULTI_EXT_CFG_BOOL("zvfofp8min", ext_zvfofp8min, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
     MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
-- 
2.52.0


