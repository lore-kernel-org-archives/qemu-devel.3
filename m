Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93404D26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFit-0006gH-I8; Fri, 09 Jan 2026 11:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFir-0006Vg-Gh
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:25 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFip-0007SB-El
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:25 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so3605526f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977541; x=1768582341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNqms3OkOfHCvuzIyaj2nWel2NPNjoAPXnkowRmdl3I=;
 b=xphBOQyu2x8ULRFvI9IVM0wDadfRvpUmmLCNHZVu4ru27DN7fP3bB15IcmfYtx2A6b
 whNUbV4g13WAO4GPEU3S39JRfvIA44ERIQt3n9LgNg6SWJC2OaaQA2LqTA49tRSynXQy
 9Hg0H/w1YhKnN2NoPEtQFA6qY+Cv3gqYAPljBrwCICiCEprl5rF+sYh9kFD64EW5m6mS
 /Mc6kiVRA8BvnSoankWvOUg2yhtRx2I1jpTluLQvhrS7y8VKus+rgoteNYGJCgshojOA
 D7bySnOme+7UgaKTZcGwOkT4CVOpcnA25wCgMEYCl16ZJ2k8mYqkmwgTT/6vsQ9uxP+D
 6f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977541; x=1768582341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNqms3OkOfHCvuzIyaj2nWel2NPNjoAPXnkowRmdl3I=;
 b=jB9sRVp3MqakXwV5/KvQq1/3hk+g27kAXmoJb6ebfjBhif07WgCe2Sm8jClJlnBIU7
 rM38pLc5uQtQGDD4VqT8F0tg/Dp3ajnDyo9LlqmtnUQioMD/5oAli9yjyFcAb5fa4Oq0
 kwwIWIFms7arCe28ahCbtYQmo3mTCtiIrydqwpfM86lRcmFJ+cfeIpK6NwFjo6A64u6R
 L3Dxi0PcAQzf5rp9cUJ2WpcFu6EHsfHt8B/ga/praumpt4xGVtkfLvj5gx2Q47cxisgV
 gOXeEUpnrRICC0ma6zcYkomm8BRsZCqRktygBvO0p7MElwofn7sy68/KMhoAfDWduSwS
 uoLw==
X-Gm-Message-State: AOJu0YzFNbC/OOyYkEEbbyW1h1hmrblCnzARdVdLwZPf9oz8bU5usYcb
 2Cnrv14AK2bvyK43xkpOo937TdxAHaAeAyLYRboH2RMwhPcUXyRmV2QSeN0sWKNIXjFFjJobudx
 C3+RIeF8=
X-Gm-Gg: AY/fxX6Y5Cg1wF9aKwS+OzdjvJ3OTa60YpQrY/ibV8q1MixdWaBoLkTNIraUKAxfmf2
 hnK3sE7eQr0D6je0EB7rFFRzJinpqS7WcKQQwb77lfqeE302dGrI72DMK3zOyHHRBfL11g0JAb1
 KtEn1fblWjSVuo6kEvs/PKgEUXekSrcWLhd8CzZZ3ZnccoKE9y6oJvfBC8JFImgRmFMNemxJmfE
 J2cPuxLxJomKG7DaI3IJ+ldmja7xqzK3xMekOlBwftgQUqP189Ynd51o7vo3dCz+eftsnFCiXD+
 GPDBs3eUqLcuYjZsDS7RrseCQQsn/If6nsO8OWsCCfER+8yKeKzEip14RpWMEsEL7z/xIfKgbY4
 IX2lp+v8ZjnUHE2h3/9ojJpzmXDbXQ7yzf3xrcIINXhuwm3oPNBBb6Fj29y0YEyjiBYJNhgi7uW
 XGLfC6ds3C+oNLROXNNVdyarmDgFXf8uNd+btWbC+R9h6bUTSGCSgzBsynrzIje0ofwloe28E=
X-Google-Smtp-Source: AGHT+IF5l1l85KPDwKS9fveklmIlUVURI0ZT8kZUF/Nlp/cZPzRxsUohv/LTHh7tIOOPwOeS0adNMQ==
X-Received: by 2002:a05:6000:26d1:b0:431:266:d135 with SMTP id
 ffacd0b85a97d-432c37d364dmr13924891f8f.52.1767977541106; 
 Fri, 09 Jan 2026 08:52:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee870sm23394183f8f.36.2026.01.09.08.52.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 12/22] system/memory: Use ldm_p() and stm_p() helpers
Date: Fri,  9 Jan 2026 17:50:48 +0100
Message-ID: <20260109165058.59144-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

address_space_{ld,st}m_internal() take a MemOp argument
so can directly use the {ld,st}m_p() helpers.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory_ldst.c.inc | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 5c8299e0cdc..d51c5feddf7 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -27,7 +27,6 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                                   MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
-    uint8_t *ptr;
     uint64_t val;
     MemoryRegion *mr;
     hwaddr l = size;
@@ -45,12 +44,7 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     } else {
         /* RAM case */
         fuzz_dma_read_cb(addr, size, mr);
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        if ((mop & MO_BSWAP) == MO_LE) {
-            val = ldn_le_p(ptr, size);
-        } else {
-            val = ldn_be_p(ptr, size);
-        }
+        val = ldm_p(qemu_map_ram_ptr(mr->ram_block, addr1), mop);
         r = MEMTX_OK;
     }
     if (result) {
@@ -102,7 +96,6 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                               MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
-    uint8_t *ptr;
     MemoryRegion *mr;
     hwaddr l = size;
     hwaddr addr1;
@@ -116,12 +109,7 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
         r = memory_region_dispatch_write(mr, addr1, val, mop, attrs);
     } else {
         /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        if ((mop & MO_BSWAP) == MO_LE) {
-            stn_le_p(ptr, size, val);
-        } else {
-            stn_be_p(ptr, size, val);
-        }
+        stm_p(qemu_map_ram_ptr(mr->ram_block, addr1), mop, val);
         invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
     }
-- 
2.52.0


