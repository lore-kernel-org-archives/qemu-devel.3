Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FED1C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOA-0008B5-F3; Wed, 16 Sep 2026 09:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNf-0007LS-Ra
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:55 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNe-0001Ya-4M
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:55 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so1607246a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564133; x=1790168933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I3PfUMEgvfCYkyvMoeTPYYREMBNAetjBzMiu6XOaCm4=;
 b=lcngLwUhjPeKbcmDoZQZm0X44pyUSBC9MXubrD8iEuHSt57wSVGknq94YqOo9xUftQ
 arm0Ek5B91yjMopK010doKT9Q0Xr9uvysPbIGqmoRSKMnzI/3DIaBx/R+th8uwwz5oY2
 9HN2m2bLT2hucVuPZQUwlQls79GE7f+p7RNKJOVRniQBqO3akoicn8Jnxl0Z2r32fqsJ
 aJX6L5pNfYb3M5tHGTNhT2N2gwy3oCBmL/ugAoP+DLHUr02koWKYXaYtae+Fj49nUG9H
 MDhXqQZd454LWw7entEO59mUYjhynAQXlQDmH0PcJmE2Nf6OmyKjS1YQcLLBtyi89AMa
 Hg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564133; x=1790168933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I3PfUMEgvfCYkyvMoeTPYYREMBNAetjBzMiu6XOaCm4=;
 b=Fd0kHTsqMimNAqMz/AtflSI/OPOy/D00q5wE9/CySB9sIh1vHOZOyX3x9ENyn0zLYe
 gNMJL1wvkq6kUyJtm6YXIuhedHMttbQMjFf8Ki7X5wob/z3fzVRjKMq8+779pKqztPLb
 PRUv+ddQ1TzNFIZyGsGQV/FS0ZNuQWsGODPCGkt8rdPbU7XjRk0/ckZ/l30lYLhWtVTX
 9Ry59IPp40SCzln9Axdof4XNlFykA7+/nVcMYZwZxe4iW9HGi6AKYWxBGBZyrirrLfmY
 k5vM0P/Zthioybb4bn8x0B2JZfZrutgaSNg3kCYjYqZY5WEIl+UDq3J1D5JuYtgsqg0i
 6FvQ==
X-Gm-Message-State: AFuF++lfJvhQL7A61k197rsuzRJXSCpglD2jcdNmr1egKgZSIFpYXtQj
 hZENbTKte+XOBmh0YXtlKIAwit8kyycHANesYrOBKdl8Kbo3WcnyYlNtxNKmJeyOKMXqpGF8o9t
 lESdyP4g=
X-Gm-Gg: AYBFou2F+n97s/sqjJLGnYY/9+8P24wkEjIrexG48yi13AUEdHxjqJ1jYCgMcgKpx2J
 j4yW1EgJwYVSDPFpH9737/R4YwAqWZ99zly9wGgPcf8f9d3Oq0RKnZAX6ExcIOQpdEXj6s6gvDs
 Oi8m14wJEJKhVKvwFhMY4kLEDV39b9EZqUf7O6aKtpQSbE3yW0+e+neKpU7RYEJTNEk1JnVGiJf
 rlDT+/yvO2FTn+9ALgTCmomn5ZG6YK/HGmIOB+JliGCrL1zuPzHG15y4QXGYykHjqLAqEcB2Bnc
 q4tMOIDNNLnrqe/6GgO0FOHGtDgtfdTaocXdk948oyfkWWWbPnZrDJdf9bzN9VZjY6fXoH9LnuG
 BsVGavDZHnD5XaDPMXVX0BOJBOqAvT6Np7Frg15LRoMxp94BAWWn/MR2bKrDkg/Srg/hMYXXY7K
 nYZ99V/kDXRE+UTtfRewFn4AjLWvoP8qS4/nIDBPopKjloRl1tWecyd6xLYFyWqxERxfCl/GfPM
 pts+H0=
X-Received: by 2002:a17:90b:3c08:b0:39e:fe9:c5b8 with SMTP id
 98e67ed59e1d1-39e0fe9c653mr8111268a91.10.1789564132592; 
 Wed, 16 Sep 2026 06:08:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 78/92] tcg: Use umax in ussub if available
Date: Wed, 16 Sep 2026 03:03:53 -1000
Message-ID: <20260916130409.3382710-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1cad8bcbc69..6d32552391c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1207,10 +1207,15 @@ static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 static void gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
-    TCGTemp *zero = tcg_constant_internal(type, 0);
 
-    gen_sub(type, tmp, src1, src2);
-    gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_umax(type, tmp, src1, src2);
+        gen_sub(type, dst, tmp, src2);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        gen_sub(type, tmp, src1, src2);
+        gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    }
     tcg_temp_free_internal(tmp);
 }
 
-- 
2.53.0


