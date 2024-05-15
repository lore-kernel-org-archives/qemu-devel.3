Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538AAC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFl-00042O-G9; Wed, 15 May 2024 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFh-00040c-LM
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFR-0002zv-ON
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420160f8f52so23039865e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785732; x=1716390532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH8p7zFQoa8qKM/2WS7ZfbaGhkQJFlfpHgdlJuwcM/w=;
 b=xPdo6OAlo3KEO6xJFHjlu0nuhvZLkG121q6DtnSFmxRqLd1jPeuEx461Vb+y2Objuq
 Zgd/ZhwnbNMeOieiT9TQBjFY3/BA0Q36una3XMPOsMoYfbox6iLfwINjZWIF+4MnvKoh
 9cqYZGq3SZW+zWz1s9rGgWogJcLInmN0YpIBYtWF8XpFUYMjucSQ5nj5NOdQTAqdhJKc
 eLl6bNbwfTJQfb+KFu/zeHT67Km/N4jYSyLZ/2WY97HAvpt0v4GGst7xITCWh9bqlzRt
 7RI32VKEk7uZcKa/IQNNxYESpoln8c+ft0RX0G+ris2RigcsCEMzFqILbXSQLqOuvZAk
 BU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785732; x=1716390532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cH8p7zFQoa8qKM/2WS7ZfbaGhkQJFlfpHgdlJuwcM/w=;
 b=FjaVZkAMJJ174IfCvuCh9dfeYbP1lgcp+pYmWDFCfR9WbCeMqMbp6gAYvPrVspk9hT
 Bk2XyUbaZistYlUUNYysd6coJKXpr/EKXrl/s8t905qRTxDomhozWtPkSh1P5AGJ3oKI
 HDxP8IBmxQEu2PVrmsSBL8B5b/kXCtqfArE/zfPG93EsEsjSMjyrtjhY6ch96nt2jQmT
 YHsDCJApY8zk8Jq9liX/44o9Oio9t7UiQMkbhnN0GZSy4MpGhvUqZMVCmoES5ofrFpm4
 eMqyoO1HiLiHL5AeDEgIWENGzMxTDljcCfCITXP2cp7Q+EsEK8JfaAmsEL3/QWCPjaMy
 QVMA==
X-Gm-Message-State: AOJu0YyBa/QYHpY/dFbpKJ2QHET5JXUfaBppSWHAARst9PUs6dbSV7hj
 +KgD7qOAT4wGaovcl4Lzqv/fO6MKHqzp1NQzX5uA5QwKpGuvQVIdgzEPj9fLCPsuqowXlJzgs8d
 8Gv4=
X-Google-Smtp-Source: AGHT+IEsyCKTdzO04q/EmIH77R0j5c5N2BdYDrtsMooe/K0YQxTSmAf7nBOJ2TFTtTO6RU38LFL2iw==
X-Received: by 2002:a05:600c:35c2:b0:41c:2313:da92 with SMTP id
 5b1f17b1804b1-41fea93afeemr134412515e9.4.1715785732320; 
 Wed, 15 May 2024 08:08:52 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 16/28] linux-user/i386: Remove xfeatures from
 target_fpstate_fxsave
Date: Wed, 15 May 2024 17:08:25 +0200
Message-Id: <20240515150837.259747-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is easily computed by advancing past the structure.
At the same time, replace the magic number "64".

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 89048ed069..f8064691c4 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -67,7 +67,6 @@ struct target_fpstate_fxsave {
     uint32_t xmm_space[64];
     uint32_t hw_reserved[12];
     struct target_fpx_sw_bytes sw_reserved;
-    uint8_t xfeatures[];
 };
 #define TARGET_FXSAVE_SIZE   sizeof(struct target_fpstate_fxsave)
 QEMU_BUILD_BUG_ON(TARGET_FXSAVE_SIZE != 512);
@@ -266,7 +265,7 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         assert(!(fxsave_addr & 0x3f));
 
         /* Zero the header, XSAVE *adds* features to an existing save state.  */
-        memset(fxsave->xfeatures, 0, 64);
+        memset(fxsave + 1, 0, sizeof(X86XSaveHeader));
         cpu_x86_xsave(env, fxsave_addr, -1);
         __put_user(TARGET_FP_XSTATE_MAGIC1, &fxsave->sw_reserved.magic1);
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
-- 
2.34.1


