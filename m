Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4744BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYJA-0005uD-5O; Tue, 01 Jul 2025 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYJ8-0005qc-Op; Tue, 01 Jul 2025 06:33:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYJ1-0002Op-Ur; Tue, 01 Jul 2025 06:33:46 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso3847877b3a.0; 
 Tue, 01 Jul 2025 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751366016; x=1751970816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TVIYWzs/Fc2hFT84TP2ybPMoeIM8ttt4z8oppooWkA=;
 b=GjoFdhZEydUyL+8F/wrOxsu8CcNVlnUVdw8WPTbSy8rYmyxzezbt7cRRwBuXpz1lJq
 eHmiY86s39pDwPhPvQcWXTUl/4pE6RJBFhLyH44f3J250iBFyt/eD8ffxSkkremN+WiA
 JfAsqbrJICLfVIuevkXydQHYwtZphxnscgfZkawpSNbE47qWjXZypRHTrGzmxVusfbuv
 3RAKq6+pT4Y7bl/fuw17+p0q6GiM6WhtMXPl4StUsfrkQb4RbreXpreEVkv4xvQEYERM
 xhXZ3UVl5bsEokfk0Hiyq4uc94FPgIYO57/rpCWO1Wxudqj5UHcTQMuOCI+Ikz8jn22d
 eS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751366016; x=1751970816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TVIYWzs/Fc2hFT84TP2ybPMoeIM8ttt4z8oppooWkA=;
 b=bWezNzqw5v3V3QjDArwaCcgL6TSiVycWPQoG7F1CYBH6t9ijK+s+K7XMOMB+ZTzhkF
 UEKIleGGRppcTXzzbpCQxDXSrVMRzjzFugwc7LgO0cChtDZmWwHFmkUpwbT/xp/xRxa2
 MfmIs5Qj0sTiqI19ZiuJCNgeuTOJ+NNlTUBHHNq+Mvx3KZp/YSYeDibzLxRQyL/QA/iG
 ssrGiUKG0RXRJgQu6RQ/wjc5rI34Z3FkGHy/v4MLA19yMtm3veCgdXZSAsIE9jzxJm8+
 y9hjvvUWfVLR3hRrlzMhVKbl4WlGwaacX9AQfy4v78KUQuReLD8dUQHe/4whwExPznuL
 jcdA==
X-Gm-Message-State: AOJu0YyIoK3jYfFkDV/Q4ECKai1y62FYEq37nk199so0b55Kgj+88EhJ
 4hKpcrR8QIbT8fjPdGUlNq6Zea9dBBr7iEO04yDul9UxBoxIrNxx+JtXQGIk7hP6/74=
X-Gm-Gg: ASbGnctu3PSSFIp/QYid6hZ99nclO+rrq02jU/bZx7JcGPUpsqlqZCB9m8SROH9YyBD
 9PLA2u5nfsz2D3JlTnq0LmtnFdiPY2OCqKTv7g3pS1ZdqUZ+a6pRQyBEfeDkuAIlo7RXRZ6wuK4
 LkeyGXbdx3cN/xtX11IkjlQ4Mw0sMMbLtfawNB3cSTulAm/MuIWHo26vgmlBrw6LFNkZmx7fwTL
 xKVn4FwgotGJuEAR1G1GViEHY7b0Zzy/sP0MPvzRdjhkOiB/jtBCEmTDjLU275hYP5dDsaEXExw
 WCuAe+T4DyM0x4AAwA3TTIGSmTqMFIRwed8nUNCf8HhTpDzvz5GVNV2Q0gVo/0vBFiUqgsOP6vq
 THEi33deb53Kz7lqnTcQZQ/wZPM9IV3BsI2WGc7b56dc=
X-Google-Smtp-Source: AGHT+IF7rQknMxumcflw/Vv9U7ZJvPIYci/CgUuZ6JmosKn8lrOhqUTyL5mO42Q6EdN+yluW1NTgwA==
X-Received: by 2002:a05:6a00:929f:b0:748:f750:14c6 with SMTP id
 d2e1a72fcca58-74af6f26d05mr24105152b3a.14.1751366016103; 
 Tue, 01 Jul 2025 03:33:36 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af558102bsm12219844b3a.105.2025.07.01.03.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:33:35 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 11/12] target/arm: Fix VST2 helper store alignment checks
Date: Tue,  1 Jul 2025 20:01:58 +0930
Message-ID: <20250701103159.62661-12-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch adds alignment checks in the store operations in the VST2
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/mve_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index f16877ba45..6dffd9cb35 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -687,6 +687,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -698,7 +700,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
                 qd = (uint8_t *)aa32_vfp_qreg(env, qnidx + (e & 1));    \
                 data = (data << 8) | qd[H1(off[beat] + (e >> 1))];      \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -712,6 +714,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         int e;                                                          \
         uint16_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -723,7 +727,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
                 qd = (uint16_t *)aa32_vfp_qreg(env, qnidx + e);         \
                 data = (data << 16) | qd[H2(off[beat])];                \
             }                                                           \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
@@ -736,6 +740,8 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -744,7 +750,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
             addr = base + off[beat];                                    \
             qd = (uint32_t *)aa32_vfp_qreg(env, qnidx + (beat & 1));    \
             data = qd[H4(off[beat] >> 3)];                              \
-            cpu_stl_le_data_ra(env, addr, data, GETPC());               \
+            cpu_stl_mmu(env, addr, data, oi, GETPC());                  \
         }                                                               \
     }
 
-- 
2.48.1


