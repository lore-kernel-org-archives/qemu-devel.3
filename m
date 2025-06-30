Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89755C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGT0-0002Au-LC; Mon, 30 Jun 2025 11:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRn-0000TT-RT
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:39 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0008Ge-RB
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:31 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73afbe149afso1276516a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297364; x=1751902164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWraZuuqlsuFG0Ck4CFI6p/KBtOQl1Lpxhn3Lz1jgKs=;
 b=eBEYXbR7HiA+HlWP4tcKfdSwSxRI9wkiA2fbxYTtIt2uKwBivQEAvVN0L6n4D0ycGz
 hry+RgLs3CCETmlA8/1p846LwGZ2Vh3v2/ov+7p9joq5cUMarDPs9OQwK5dmLm8KC6zE
 CcbEQkB6612vMpcH+rvX8/CjYFvSTRaZPdxkRhLx8XjEdEvVGghoLPJmGUqwF/ruGYS/
 5mV37WEXXEINphstcrHGBuUPMElyO0O8OgnrtJ9iKbkFsavaPeDKOCqsM4U1Y1rIeV/Z
 iau+E+k8lN1I1/Fnvn9KkyE51S4a7YdZnBRXI91jJsOwSbK/8FOj/P9tSNpjzrmbpWjU
 mmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297364; x=1751902164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWraZuuqlsuFG0Ck4CFI6p/KBtOQl1Lpxhn3Lz1jgKs=;
 b=XaCstv4xB39s69LT1irX4MadWtxzXwJgur6jvHArJmX41ug6MyFot0pCpjeT33SCwP
 AtO0L3GYmWmxEtfgyjaBJJG0XAK2oE/IklR3lovcYvLtJQK6+onaZU6epIzrf0gZX19/
 5kMSk7ydZCb0g8VDqIEL2T0YULMmFy4xWZ1xr5ywAdPELUzpD2DweR18rAQHSkENmTsE
 0ZRFyCfDMBwSG99MbB8aDp1oqNfWZ9uEXJByiLtt3mwzI9vi3KAATHM/3kfOtgprLTKq
 P7P+XUTW5jEAu7jMQsCNnkHvo4qFeR0jWiZROpW5tp7A11oJmuACjM+7wtPh6M90KrHQ
 xKwQ==
X-Gm-Message-State: AOJu0Yycu0+CVoD+PPvK6C0IffrvXye7xRLQmMaIMyGK5v2CvMzR5j0t
 m/d8NNZ0iaKmSzZkIoTDyzfg0MtIsBwZL7j2LGF1NZl7E1cAw+l/dl6RI9AKUMfsPV34Gqe/BrQ
 pxJx4
X-Gm-Gg: ASbGncshDBi6xpgzp6n/5Lg1bEu8UqZXITFirzXwDZxC9KjBXKy7lsDZ+mfhIWVtG4x
 aDopK8KK3K7Okte8PbsCOYFQNd8W/dXExa4+VOlN9KVWh8CjWZTaYef9OCyCQOidxFwI+WeuH5D
 B1HcrRMUXXkw7ZBuMGeug1PlR18Z9ovnWBKoE4nBCyZETYYnM9JnHpMxUZAqSlsL75WtZwzYBHJ
 D0NbsN0u7ULAOLb7FopetHcmEsWJvRootpiXM4U7fC0dl/E4VSbHPAOwbdbYIuFiBPNsbcvyG54
 KWqBz664ux/Cc1/O/vdYTb1oRI/SqjFCFOuXdxk5kVRXBfdRhP9biik9/0zmbFTRapyrvA==
X-Google-Smtp-Source: AGHT+IG1HSfrIuEujng6HdYdx4uMNnI/WjU/PEnS35mYXpjDAQCQdODcMf5gwBzCzlLOxabdWAEzUA==
X-Received: by 2002:a05:6830:8008:b0:72b:9bac:c044 with SMTP id
 46e09a7af769-73afc291dd3mr9050399a34.0.1751297364444; 
 Mon, 30 Jun 2025 08:29:24 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 29/29] tcg: Fix constant propagation in tcg_reg_alloc_dup
Date: Mon, 30 Jun 2025 09:28:55 -0600
Message-ID: <20250630152855.148018-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

The scalar constant must be replicated for dup.

Cc: qemu-stable@nongnu.org
Fixes: bab1671f0fa ("tcg: Manually expand INDEX_op_dup_vec")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3002
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index d714ae2889..50d40b9cbe 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5154,7 +5154,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
 
     if (its->val_type == TEMP_VAL_CONST) {
         /* Propagate constant via movi -> dupi.  */
-        tcg_target_ulong val = its->val;
+        tcg_target_ulong val = dup_const(vece, its->val);
         if (IS_DEAD_ARG(1)) {
             temp_dead(s, its);
         }
-- 
2.43.0


