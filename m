Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C888CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBdd-0004VR-OU; Tue, 26 Mar 2024 14:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBdc-0004Uc-FM
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:35:08 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBda-0002Jo-S8
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:35:08 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29c7512e3b8so4493494a91.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711478105; x=1712082905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d3Y+djHmhYci9G0rS3WbK7XjPwy/e3F6FGyqyBr1W6k=;
 b=OZclBYfkQp31hbj/fOvnuKxUgp+g++I/n8Xs+5mwCxvvC2YurfrVMHxc/sF+RPmdsc
 ddXv+oqJXQpyLgxusFRdmwtEkp66HnYE4uPPTWxOcJgnX4Qt4RFKJB0GN67zfllU9CaA
 VQDNg+emExq0ZrZ008c2YRAs5JknVTrzSNJrw8sYloO1joGxaAAyDqn4kL3aFJzkJBWs
 yl0b/jkvUZXXmDAG65KZMwd4f40ywehZb4AiQ1m0bEuCgvKbzq/OoFYKlzlNVR5gbqmN
 LMMMkqGmD5oliNNYMkoQsoaarAVSxxI16SbhWRSqgBBtaMBd5Mhoq8W2K7LfDZFP6/67
 Y/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711478105; x=1712082905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d3Y+djHmhYci9G0rS3WbK7XjPwy/e3F6FGyqyBr1W6k=;
 b=nbogQCX85LTQEmYTNsHCataPjYVL7FVjDxx7VVhToMqmA6GmGdCKbciaPQ/192dfKD
 djTNnDOjFM0+2mq/LfpBUy313EmXlSVd0WYjKWRBOi7LQb0Er8adexB7gjnVfdzeGTjo
 DBLRaGcUTuDRPoynbteatWAp0UhWlW7uat9CI3J0k9dOlGm/SDA3z8kI0U+DZxCzMeLp
 nj2PRe9JjynfKmcM5R2/J6DdfXImbpyblSICK18rV5qf021rfpwFPbdkZZ9SNTtQvazh
 NbRu8kaxfQJsIoUhgbJUDhAHwRNSBlB8Si65n5VLU9o+CxvqtyroKpO6EgRdqHFHZu9u
 jwCg==
X-Gm-Message-State: AOJu0YxY1KxtDiGWfZ4DKOHcnqVcpWCexskuSQOgMM5XZzJTUeVkbEuz
 QwWvm3b8fNWC13KcRcp64wfeJ5wLk7Az1KqIyWbfIRa3IPUxQHnEm1NIQdkKfxr2+64Yx9XUjAj
 A
X-Google-Smtp-Source: AGHT+IEROIo/GpOiFxrlLd+F4kXwaYHfro9aCYT9j0hWHbJoFYclwFD4ciZf04DTZ2lHC/cuABvZFA==
X-Received: by 2002:a17:90b:70e:b0:29d:f7d2:ccc8 with SMTP id
 s14-20020a17090b070e00b0029df7d2ccc8mr2236640pjz.0.1711478104659; 
 Tue, 26 Mar 2024 11:35:04 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a17090a9a8100b0029e077a9fe6sm12269310pjp.27.2024.03.26.11.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 11:35:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH for-9.0] target/hppa: Clear psw_n for BE on use_nullify_skip
 path
Date: Tue, 26 Mar 2024 08:35:01 -1000
Message-Id: <20240326183501.333914-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Along this path we have already skipped the insn to be
nullified, so the subsequent insn should be executed.

Cc: qemu-stable@nongnu.org
Reported-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 143818c2d9..8a1a8bc3aa 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3948,6 +3948,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
         tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
+        nullify_set(ctx, 0);
     } else {
         copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
         if (ctx->iaoq_b == -1) {
-- 
2.34.1


