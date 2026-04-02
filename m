Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A0DD3942C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILI-0008NU-EV; Thu, 02 Apr 2026 09:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8IKz-0005fW-9l
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:43:57 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXl-0008R7-JO
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:53:06 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-358ed696623so343945a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134381; x=1775739181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BqX8UQg9KUWbojxnPu3eGGk/RRBDX/yfnAOvQONcjo=;
 b=lhFTmB/fHXzAdt/5Tx2/gRMcuRcRUlISZZKGkeJbdOYPZryGlMaerQ1c6H3DHMThGg
 G0jaSiDjHU7OA4GzKnswzJLU6+/BR8c6PJVk54w6PiYsOiUu+e4WRrGdaAA+wPCvlsfz
 XSHPkKbB5DXJJuzsFGEbJ9hyudiIba1s/TYftg629t6mwzKa3BoG88Byf2zNFlW5WWjF
 wChXk736CaZh4qId7+ka7BQ4Dpq/8rcTvk9qk+KODTq16DJGGj7dP0poPAuF3m64lPRP
 w2A6JuFmjLj1bFY8ZMMgwglyVT/48f5tBapg0LgaRpkpwhvNMkGEsGV1fIweU4jh+lwt
 AMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134381; x=1775739181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5BqX8UQg9KUWbojxnPu3eGGk/RRBDX/yfnAOvQONcjo=;
 b=sRvAjPwF4t9effeHsN2AZ6I5u5aPAdXwJcnSAUZbEefu7AdGou3VMZZgw32cKPM+mk
 t8tqEl54GW28/cj4HMuGWqBIbq1kDfICgYAjIyxhuhdPgPMO3ceQy07Jszoekp0ale5A
 3uTZAVoeHReeb9k+ZN1nVZqUXFJu3+HaiA5teSb/IJLzI9b6Ih72QQIZxhiINfPD83KV
 qdsIFaPLq1MwGgY8Jmcm5Du0vLc4iyYgL1Rj8hVFA+mTY7PN2mqUCBXiXSXCIH6b/qrh
 7pBs3g+fvAuejMUGEZG+cNKXhKd/rj5o51uZu3RPGY3z6QsohQ6Ltqgbp24S4N/nW+qF
 pEog==
X-Gm-Message-State: AOJu0YwxeHuwTMQLaDA9kjqHivbdtmAzjMIBHVC+ex2Jm1j/LKqC+qxL
 u5XA0814juxNwxY8PtdZJfpJahvfF82U3XFyrkFh382vuIDB5LBOdlGERU9+jg651zAN0Pv6jB3
 1guJ0qzp+m1ifwxbn38kwkqSogHjJDwYl79m6oTybvGYxTdRSJfDXCVZUHkeNTvXr+MVOlSH+Ip
 jOtWsyBBcr2i9UYRYwyDf37VG/nyL80QPCuu83Zyo=
X-Gm-Gg: AeBDievKcWYbkq//t4eiXqKDaYdsNZZlkajW7hT7VsZQYBujCGLmsj/TNXOBj8lCw9I
 3w45f3x9G9uEJnue33gcZu5TknHIF8AYLY15wPK9+8RBWq8T5HnrXRY1bc0RYOHMXZCNjao8uzx
 9OIRzMSRRhI+NLRothj26oa8U87z6SeYQEF+R4NYl+KXvpgvVbE7l1pPtfZ0AZBmA5IiwDNc1/1
 zv+wpMgvzh3JySi307iYTyqYJSnctfOVkbszFIsb472ApDy6LVweaegdNQnmzrg/CfKHp0AA2sr
 nApK/celdfEpc26libPY6g6TvWGaykBnCIBzJLVs/TpwXM119pqXnUzdicQh7nzkinlV0nPKAbo
 vNflSrC+Ur2aJa66txYe3FwQE9MRp/GclQwvF8/EOeEH1Bho9ESAcLuklxm/IPvT4t1KLAEUL7I
 fFcPEHouDXUrOBAGuAH6VRc3ztryIcBSYPXSS57UK4UEQ2N/mjf6lihWCPGBmXJZaUHPAFbMdGW
 ss8Lxh88B9jEDIEF4VCu6/6Tn0=
X-Received: by 2002:a17:90b:3c81:b0:35d:9560:3efc with SMTP id
 98e67ed59e1d1-35dc6f7abb8mr6557952a91.14.1775134381421; 
 Thu, 02 Apr 2026 05:53:01 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:53:01 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 9/9] target/riscv: Expose Zvfbfa extension as a cpu property
Date: Thu,  2 Apr 2026 20:52:34 +0800
Message-ID: <20260402125234.1371897-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bbab96385b..38286b6b40 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1266,6 +1266,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
+    MULTI_EXT_CFG_BOOL("zvfbfa", ext_zvfbfa, false),
     MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
     MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
-- 
2.52.0


