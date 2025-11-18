Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4C4CED255
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJR8-0005BW-9C; Tue, 18 Nov 2025 05:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJR6-00057P-IZ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:48 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJR5-0000A6-AV
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:48 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-bc0e89640b9so3680116a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763463585; x=1764068385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYm/oafUQ96KV1KrJ5UIi5YiWsP4bo/zOXkfAj3wvwo=;
 b=RizR/oj4piycARk89LIg+OFMFELZGSh0HFqjzY83Q7o9PUudATtn+Ut0zOy+SdLSGc
 AkXunBSOBph3Rf1hhNMuXyztsqRzSCYzvNCqLZSn9yV5TSx8nYOvv8Rsq6Zv+oTcxH4F
 9R4Dq47uYf40WYy/JTGim1fQZX+QMvEqiAMwhAfivQpyjNAlJS6MxxgDGLn1vGG4TbnJ
 ClTvG0CSpG+UBoTBsJ1XWZgCGz0He6KaZqopv2RmUywLbPYqTjZ33N8AcDq4ShYxV23L
 ZQBCFD4Li/N/bUao1TQvaMKmNzBYNGBnNmbUXCDPfHE729BbjNQ7Okl6IM14UZGYA7HQ
 EKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763463585; x=1764068385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xYm/oafUQ96KV1KrJ5UIi5YiWsP4bo/zOXkfAj3wvwo=;
 b=n2dEE1rjbr66eXRFZbOlVOZCQCanbnXRjSEJa+rK6GYp6Rs1BOxRkUBlqG5tC6MmLX
 l/PIQMmBPpj1OQJo94BQLzRDBgNUi/7cl/hhaPKu3sI/jUZhyBI1Y1P1vrPX3+MajYLv
 eWVJPlEmNmhr+Q9aR1AY8oFDZOMxMILcYTGueNWsWHqU+ZNKBU4DN27rVoEilBOnrcwe
 NpU+zP7zcQsBILbW+Ir/0KBwXFLKkF6wcj9Ub86QedMkuMM+13EFSgCKdf+QkJR1FTZY
 +ht5LvbiL+3QVdf3W8+usiMQ6hunvAqRKpbMl65Ok4MNcO+AUrqAgCV1B+s1X9p4bUWH
 HZ0w==
X-Gm-Message-State: AOJu0YwxhPT5B45l44VfAg3GtGFVX+SKzfadXyxFSRFGJujlwYs/fFqL
 5N22A/01oCJdSVvcjHCh0CVboIS+RH1UKwdGOCmjSC2o3sqMnnKKe7JCr66hk62F26Bhmj/OcKC
 hMv9AykHcyzj/JEfTqyJ7DiJSKRf2WGzM6gUI47nNWj5xrnmdws9A30DBOd8K0x2hDB/9q1+9wQ
 mYS+3lR0r627klV78NnWPa933oGK94MLpNOWINfI34rHc=
X-Gm-Gg: ASbGncvDy32nfL+1ywyKInoNpGT+iCew/6nX+YI5Y/1QyeVp9uMcvQAa/XMKOR1JuMW
 3wxJOPdiCzoZAzJGcPAuwQqT49l3IboZ1pDJ6ESlhA4ZgitM7RF2u62LLbTpWWVmO4d7p6VB2Gh
 iqWAM2JBqxeyC4Ok2+HehdvXfWn84FyzMw5Uqw9pe8TVtxI9uNUBrX4n79FQie5n8XNKCArFPHE
 /K9NbarbyPbnXtODaHn31UXo9MJw27BR1tCcUbFr1hCti5h+hATutBO3ct+jfo6SUYcWW8CFhLt
 NTf5fnC3YDwYVSWWKrRmY7r8llS5Fn6P1p7L4PLMs9O2yTKwEFFXit9j5WOrN8rc4gt+Dkz0rGp
 JiRzYy7VwglrPieiGAV2I1NXbYmz1TiXgm25ylJE26GNVkNdAyE4ms/Eznayu0oWM/Hiq8tirDY
 LPuxLEBqPAnhhCne1u8VOQGRuR5/qb9X5TZX91eI/+hCXA9cZe
X-Google-Smtp-Source: AGHT+IH/Zm526KDj+WaH8ttm5/E8z62aV1zhs++U9UuITo2EzODoxGkPnBboZmi+SkuqkF0DLGtuwQ==
X-Received: by 2002:a05:7300:d581:b0:2a4:83c0:6509 with SMTP id
 5a478bee46e88-2a4abb54ebamr6282350eec.27.1763463585179; 
 Tue, 18 Nov 2025 02:59:45 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db4a36asm43989903eec.5.2025.11.18.02.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:59:44 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 1/3] target/riscv: fix address masking
Date: Tue, 18 Nov 2025 18:59:34 +0800
Message-ID: <20251118105936.2839054-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118105936.2839054-1-frank.chang@sifive.com>
References: <20251118105936.2839054-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52d.google.com
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The pmlen should get the corresponding value before shifting address.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 172296f12e2..9b3f01144d2 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -203,8 +203,8 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
     if (!is_virt_addr) {
         signext = riscv_cpu_virt_mem_enabled(env);
     }
-    addr = addr << pmlen;
     pmlen = riscv_pm_get_pmlen(pmm);
+    addr = addr << pmlen;
 
     /* sign/zero extend masked address by N-1 bit */
     if (signext) {
-- 
2.43.0


