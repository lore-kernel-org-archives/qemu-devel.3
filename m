Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A34C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4h-0000zZ-ID; Tue, 02 Apr 2024 10:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4b-0000uI-FT
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4Z-0007yu-8h
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34379b447c3so187668f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067909; x=1712672709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQbqgStHmRhecsY4PYqLfYr9cNfbGSMKT9lGuv09ipA=;
 b=PneklPK3VWzq7Rpn5MJMwrcOmZ+1kZlnIIZfc+UQ6NsFTudEX/wZu+9IcIIeFsc4Ef
 oRer9N1Y2vi2RSUgioIWehUSUb4Hg276okTDBY8R25IhjroBe2gx2rdl9ps5ea5oahdN
 iovT3uf6a18kuyIieZKCzeHwnW7dBNMns2VWDPOUt27srLXMgkH6UABqxVENPh3k3K8p
 D+BM8KEuLSFNaBpclbzdqvoIDyzXPde86eZjyiJhQ48a1aBaVW0j8DJ9HZzOG3ZqE4e8
 3eS0eJpKGLK94BVWnYnU9m1XEA7Xzpno6r7WrK4WbzeocHAmtUiWelYzuItG1FpUwDVt
 eBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067909; x=1712672709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQbqgStHmRhecsY4PYqLfYr9cNfbGSMKT9lGuv09ipA=;
 b=isorFe72NsLftnwgEIWa43tLub1oNBiK0n6GzLe0cNU8SQoCwResqgUOZTFqfWdPnp
 pF/YIAKmfypRUB+y3VxbnoV5u9JbYSCtJu/ID8C6RVm0eNUyDkzstaR7AWE188PaVVP3
 jueltugWrTsBmaLAGa3lD45YFXyND5Jtgijqimm1E3kmaJb5WAViSml2WRm05ew8M7Bo
 BVBB9gaj0bTq3AsYw7VxY6kgy1kCTO5zdG3TCBWmAi0vTCN7QNCjWELXX50yGkj/YHcd
 L8ve735RNRDE0yg5m36ghXqQjIvD9GibniPaptsEDJ+4x19UCXo7UPM4jhwWJuiU9mZf
 EAxw==
X-Gm-Message-State: AOJu0Yx8H8JU5fMGAHnUcUb53leDfULdENRETB0fj4fmX6eqk0L3imMm
 +xokawmwx/piUBRgUMVEf6Uw7jW9KDdYP95T7MYIljSI2Gl7+Hj9u2MN2gjywi09yif6YgfIcxu
 XhwE=
X-Google-Smtp-Source: AGHT+IEvAnNvIwgwLIrQxcahNxqgsQYLujeuY26GIPu8RvmY1wHjDx3uISSi1gyraARLOTr3pZLG4w==
X-Received: by 2002:a5d:56cb:0:b0:343:8022:dd08 with SMTP id
 m11-20020a5d56cb000000b003438022dd08mr327218wrw.0.1712067908944; 
 Tue, 02 Apr 2024 07:25:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 bx26-20020a5d5b1a000000b0034356c434d0sm2796273wrb.117.2024.04.02.07.25.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/15] hw/arm/smmu: Avoid using inlined functions with external
 linkage again
Date: Tue,  2 Apr 2024 16:24:20 +0200
Message-ID: <20240402142431.70700-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Similarly to commit 9de9fa5cf2 ("hw/arm/smmu-common: Avoid using
inlined functions with external linkage"):

  None of our code base require / use inlined functions with external
  linkage. Some places use internal inlining in the hot path. These
  two functions are certainly not in any hot path and don't justify
  any inlining, so these are likely oversights rather than intentional.

Fix:

  C compiler for the host machine: clang (clang 15.0.0 "Apple clang version 15.0.0 (clang-1500.3.9.4)")
  ...
  hw/arm/smmu-common.c:203:43: error: static function 'smmu_hash_remove_by_vmid' is
  used in an inline function with external linkage [-Werror,-Wstatic-in-inline]
      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
                                            ^
  include/hw/arm/smmu-common.h:197:1: note: use 'static' to give inline function 'smmu_iotlb_inv_vmid' internal linkage
  void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
  ^
  static
  hw/arm/smmu-common.c:139:17: note: 'smmu_hash_remove_by_vmid' declared here
  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
                ^

Fixes: ccc3ee3871 ("hw/arm/smmuv3: Add CMDs related to stage-2")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240313184954.42513-2-philmd@linaro.org>
---
 hw/arm/smmu-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 4caedb4998..c4b540656c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -197,7 +197,7 @@ void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
 }
 
-inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
+void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
 {
     trace_smmu_iotlb_inv_vmid(vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
-- 
2.41.0


