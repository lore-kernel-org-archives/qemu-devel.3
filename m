Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFB7C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17EW-0001Pp-9m; Mon, 31 Aug 2026 14:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17EU-0001P7-2q
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:50 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1x17ES-0000BX-EN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:59:49 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-90cdffe8e3eso697516d6.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788202787; x=1788807587; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q22FbeHXDtMxaPsftwhFKOpil5kY+8aobAw9NdBwCdw=;
 b=D+RzVjBKZiYSWs6rsM7Vb6d9gxz0tvqdnHuCLRLXRxa+2rjcDayMvJjijUDjhZa6gT
 j7MIh/AWIuYg7pCKYHN4GNAxIpjAdqvYXjSV7XUHyZ6Jj01vk39Eph+j7vcJkHOz543o
 Z43Cig+Petf1qNN/CtX0r6nZQKiSISnYcQ6g+NqAVvIDjm4omV2vJPdOhk1UN3lcKBdy
 MVXsBNkvc0Ne7IteOL0VEZU/tWFcWfSVRTddV4CzBaSLOe/CQxRWeX1CjQZlCxTVOSjh
 Y3cAqbCQ2/nRW/cJAQctUgxPl32kw6YrvpvZtvowSyj/cu3BqzB5i8YVazl13He9wM2e
 q3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202787; x=1788807587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q22FbeHXDtMxaPsftwhFKOpil5kY+8aobAw9NdBwCdw=;
 b=LoTx+n6L14wDAA6JTdc5SUUT7l9fucKLErhrozszWTaJKr2nRIqCOVYA7ZhNUl9lSJ
 Rs6crbsUZEDdCksp6YdcZfXjQ4hl3TUf8B6SCeinxJ3t4NG7i2JuB9bcgTH+Py1VszP/
 zFfr/j5yCj4GAHFaoGS6Fdz96Uj9Ufgb279LOXriYCW4fy/0DYhgvgotIviaejMaFGJo
 gkxWWstXjK2l3n5jotsWz0G/Nv6icX49FtEjm2+RYWj/PneelfedU24bVRBMsm+arVnD
 BpshUv0UMxkB7IsPs5QFpa2RRU45XdQ94ae6jrhhANx+Y6seXki+ox2ATtGW3uzFeiYz
 bezA==
X-Gm-Message-State: AFuF++lWX96I2Ldxc+JbJHRMo2aTMQ16zTRB07seKSSTRosZsyBj2DIz
 rniEgQBm+zP3Bc2FobgONs5675tANmtPGDZgYJaVXW7dNxQKJe2IlvYn9w0jtB4EIdM=
X-Gm-Gg: AYBFou3s57VAEFnt9nfv/4RWppctre7rUgVCOFsGZ4OaUY+p3lqoHOxW7FvvRcTD2eY
 6o91EL3Rt8ZA9qEl77Cz70moobim+/nF21Jphx+ZMPvslcC8s7n7RcbCq+tHvdwE2Tux/Meg2IE
 QhAF/HIR5sxo9Qd3JlVdXv98l+cTqDwOGHG69dJ/S0XNoYjYM7mHY/4nCleWRxRfUa6C395b55S
 4di2CDNlhQpb5d9OkuSjq9vS1RmP0Gpqr6U6tnQw5a22lVGyX1LmHNwQ76ATeNc5gHZekknXk7I
 vUor3MNXxLSqUbdyPl3VhHeolJxmgT7pT3jDyo+xv8pjxOl7lS/0RP+W9Jw6lqgg5Lccsjg38se
 ht5tsgmsBelJH2VIs3GuN8bf8a3rI4bVO0HvHsyo48rLffscMAwx91B7lW+h0FmQSrib4msH4oO
 BtCauZnS9VYItagyNvwT6j+WQOLBMuzTYHW7BbgH64CcCt8zigBXcWYYOcSryIy/jEecIEGFKnJ
 2yKfBROZfc=
X-Received: by 2002:a05:6214:4902:b0:8f3:13e4:739d with SMTP id
 6a1803df08f44-90ce0e55d6cmr399378866d6.7.1788202787128; 
 Mon, 31 Aug 2026 11:59:47 -0700 (PDT)
Received: from [192.168.40.230] ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90ce44f5695sm90952986d6.26.2026.08.31.11.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 11:59:46 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 31 Aug 2026 14:59:40 -0400
Subject: [PATCH 2/3] target/riscv: add helper_tlb_flush_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-riscv_tlb_page_flush-v1-2-4fc6af95673a@baylibre.com>
References: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
In-Reply-To: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=tgamblin@baylibre.com; helo=mail-qv1-xf30.google.com
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

Add a page-level counterpart to helper_tlb_flush(), and condition its
internal call to tlb_flush_page() on return value from the new
sfence_vma_allowed() function.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 target/riscv/helper.h        | 1 +
 target/riscv/tcg/op_helper.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4fc2d3a155..652f85a5c7 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -137,6 +137,7 @@ DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
+DEF_HELPER_2(tlb_flush_page, void, env, tl)
 DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 8039df2b48..723a45d181 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -610,6 +610,13 @@ void helper_tlb_flush(CPURISCVState *env)
     }
 }
 
+void helper_tlb_flush_page(CPURISCVState *env, target_ulong addr)
+{
+    if (sfence_vma_allowed(env, GETPC())) {
+        tlb_flush_page(env_cpu(env), addr);
+    }
+}
+
 void helper_tlb_flush_all(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);

-- 
2.55.0


