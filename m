Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51C9C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTmK-0002pL-Kv; Tue, 05 Mar 2024 07:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTky-0008Oj-QZ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:56 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTks-0003DN-B6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:52 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412ebda8772so4899755e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709641124; x=1710245924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ibtd8j2iIFl1RCVEa98L1O8fLydOmPGUu0P3W6zXxE=;
 b=fqsQLDin4//iDhHTmNzLHZWSFoi9GPkZjTQoJzl6JtwzLtLzp9yaZQOViT+8YKwx8N
 q/qLp9vDHKqSizcDzyj6eKxEkIekr2vWW2HgiLel5WQ69xw8spnaA7C7fkbIOrwkj1qy
 7dzIrTU+B0uUeHoAYfQ+wiaXPYbADnOARay9Nnz3dT1X6TydVyj5sbdQXx7E/UpyZzzd
 s7l8AjK5rcSb5BnAyJOf2cBt6OmzdPSZU+4X7JFb1wbQ13BhWy39IsVhQRmnfdXCmuP+
 3LR9C8fKcE7eY9YgW0MqQr2YkW5SHsEop7JXNT8WA0qyV+kbFP4Pft6eK2rgOLssTrlY
 0VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641124; x=1710245924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ibtd8j2iIFl1RCVEa98L1O8fLydOmPGUu0P3W6zXxE=;
 b=d56qzNgUGagm0lAdCHxyv50QtV3QFl+IJmLj5QozP5uRasYpdC+OuAPJATmGdkuu+k
 V/t+fQk15lX0C1oVZ8v3neu5n94FuRBdJxDUD1fhQBjZzDYCBwnkz8mfXjuuLMPNUzpD
 d616+Acgzl6sEX9YCl+eM9hT9eZaped0wWzkjWvWWb9gXj5WEUAC+7U6CM9il6neCJUd
 9O2nZIncjPjvyvIaeBrfgrrt4nkByU7uMfqACaTQefxuHp4Wu/G0w5d3VzU5wTXdaSYm
 K0EZMR1LlQQsBx/4IsDoWDAiBYKw26JClpLt52OuI+O3oO8mXre9bYRB/hSNz66qUKdP
 A2MQ==
X-Gm-Message-State: AOJu0YwlfTyj1V44TtBwebhlSmoqSGb+PAp7rfBdfBuO9ftWQ28k7c+e
 Ljy34a5r2URG+LK6cxe5xhlYGiw0RbzPfqvV/3u/DK4fKcTYmd8KOA1V8Gr4UA4=
X-Google-Smtp-Source: AGHT+IHt+GJyylRvf3ZnELcku1HmppBPkHdkuOG4oZm43grjxf4V+Db1DsOmEgWaKJydViUM5V9Y3w==
X-Received: by 2002:a05:600c:3148:b0:412:bf53:51b0 with SMTP id
 h8-20020a05600c314800b00412bf5351b0mr8992277wmo.20.1709641124182; 
 Tue, 05 Mar 2024 04:18:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b00412ebd587ebsm2115487wmo.3.2024.03.05.04.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:18:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F10295F9FF;
 Tue,  5 Mar 2024 12:10:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 27/29] disas/hppa: honour show_opcodes
Date: Tue,  5 Mar 2024 12:10:03 +0000
Message-Id: <20240305121005.3528075-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 disas/hppa.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index 22dce9b41bb..49e2231ae62 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1972,9 +1972,11 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 
   insn = bfd_getb32 (buffer);
 
-  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
-                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
-                (insn >>  8) & 0xff, insn & 0xff);
+  if (info->show_opcodes) {
+      info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
+                         (insn >> 24) & 0xff, (insn >> 16) & 0xff,
+                         (insn >>  8) & 0xff, insn & 0xff);
+  }
 
   for (i = 0; i < NUMOPCODES; ++i)
     {
-- 
2.39.2


