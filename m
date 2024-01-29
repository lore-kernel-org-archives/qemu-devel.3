Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDF9C47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb5e-0005Qi-OT; Mon, 29 Jan 2024 18:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5a-0005O1-41
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:54 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5Y-0004zm-3f
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d7858a469aso17975435ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571050; x=1707175850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMktE+uuI7KYrw4qy5OMTFd9gSBzokEqXN4YH9Doa28=;
 b=ulsLexn3B/5d3a8Xp39zbXVqYdQgHD5Tij3M3hEdNGa5oDKQfzpXESKjVcekJsXltE
 Y0jXw2eMG8qhl047OwZP07HBEsgRDpxcjO/199YPruHkikBkiX9dAiMm4ry2mkFhCJ9W
 oaAwkVd9sJqCyoQVxkiZ2H4Clqt3NYNw5iQX+n0qMPE+sDkpx58CtXK2yP8VpUE9eX6N
 J1SdD89Aqt9d46SpKBWFkVZueTOhrPpUyfvw41vtSiCZpi4+F3bD3dPxBZKq/EX1akoz
 hAM3oJqm61u4crRFuDvJ0XYHS14y2xniDSw2doqGiOg+IqjtG48Ufirbd1EehQZTRmsj
 Npxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571050; x=1707175850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMktE+uuI7KYrw4qy5OMTFd9gSBzokEqXN4YH9Doa28=;
 b=tdMwufN9NXQdVJjYkrMLBk/q9btK8UjUkvEShNm3Ezdhdf+8xtDQFWgvH9Of8JcK3u
 /Dlx4QNSNrtxstRAf5vCVDn8HJJgkOWOUR4+T9M18EiJ93+7FpvQ22WfaeeG+5OuMs7V
 aRFT70ZFl+sgZngMQ0/j06hfRlQ0yxeX04WJffKOM3wsUcBMpJhmAkWgcsQ292t0GuPZ
 Q24s5c/E7cwZppyji3fy4cgMZcjoqmZ0JWSqdO5TEy4M/ku9qC7/wiH+3Mft7TPCM6hZ
 IAsToEw8OqNNNkK+aOS77lG5akILWYcv+xA55+gZPh7Xo41iQG5ZCc61manzbEiLc6ph
 CFag==
X-Gm-Message-State: AOJu0Yw2HENhipB11RNIjG865CFrypszYgIiluRg47/xTlxi4eXe5Bad
 3PBlXitvfnDuO9Tu07f/f0YeIwe/NoGl1GpmaZCBPinRZJtJi1pbfllkEvCG9q/R5gKfviUmsbC
 F2I0=
X-Google-Smtp-Source: AGHT+IF2OEHim5J36DDZTsSThCAeoJ3CorTTzEaa4zfC80fIH4p56KINqeDtOAORv82gksqUj2jK6Q==
X-Received: by 2002:a17:902:7681:b0:1d6:ea58:f593 with SMTP id
 m1-20020a170902768100b001d6ea58f593mr3157454pll.9.1706571050282; 
 Mon, 29 Jan 2024 15:30:50 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:30:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 01/33] include/hw/core: Add mmu_index to CPUClass
Date: Tue, 30 Jan 2024 09:30:11 +1000
Message-Id: <20240129233043.34558-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

To be used after all targets have populated the hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2c284d6397..4385ce54c9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -103,6 +103,8 @@ struct SysemuCPUOps;
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
+ * @mmu_index: Callback for choosing softmmu mmu index;
+ *       may be used internally by memory_rw_debug without TCG.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -150,6 +152,7 @@ struct CPUClass {
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
     bool (*has_work)(CPUState *cpu);
+    int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
-- 
2.34.1


