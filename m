Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E8DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76BV-0001P3-P8; Tue, 22 Apr 2025 01:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76BT-0001Ni-Iv; Tue, 22 Apr 2025 01:28:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76BR-0007p4-4V; Tue, 22 Apr 2025 01:28:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso39860055ad.1; 
 Mon, 21 Apr 2025 22:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299714; x=1745904514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gefJdCUJSQLppbT4glOadpiD7A44LdH0heN3S2uo/nk=;
 b=mknTGNJ2mc0gQmnRYvSI5g4CiEI4d7Kn49/AQrSrupQf+uI33oQjpYvYnlIVE4g5A5
 acgxsgbD5ikHY9CEa5JJhOsa/5J4d67VGYIq6cf7C7ERt2xemzaiByhZ2uVa17PaKmdJ
 r/g+YP/JOeBQgefwQUS858/oxGaknTCUl0AbBBfmmwUPNCOLcTZxRJm6ehR95UT6HUr9
 hK4uRwc/pNMD1V65tV5Au4hoGvZhgCXoGxO+gfs61vzn1I/oumWZhzPE1t8o5ugnZfXX
 n9lEOSM8wh4NhAzmYhl1nw9TXYpXI4ks6mUA81bDQTiaNm3Hp5b7RzwM0fY41YkEDCCL
 b9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299714; x=1745904514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gefJdCUJSQLppbT4glOadpiD7A44LdH0heN3S2uo/nk=;
 b=nHCc4CZrUzgPai6LpgZKbSaBSDno2gDpnADKPZz7FP22Hzyg+NOE4bRaN23Istb1Lz
 I3QJ+FTvU1sI2RjLLta3Id+ou0SNbNRAU1CT1eva968LpXSd8Bohvw/yR3TtdmwhHifu
 VrWtwk5BsAaTQ1HsFHH8MEs7EhY5DREWshPQhc+6EOMkPhOJF1fETcf8JpLnNSK+SAX0
 6FwtfjxP6Gye/UiwCudN40JZshFa+nBk8F4LLha6YDI4YlefUyFjj9YOX69+LgF6MfAx
 cRuSh/eT/4pghHr7OJTQrh4oCUD59RAbNCMNO3kPIEazCJOmqEqexBxzMrz4QmFYegID
 KiTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeHxBnU8e9EitsnXu/RvBEyIbsZuyYS/XW3qYs9+5vkVPlSgDb3XCe8nUXSteWYV42wpXK3nKs0itjgw==@nongnu.org,
 AJvYcCUlDLyafjht3Rbf53vWgWSVAgxmBViSMv6vG7eVJOdGyTyOfAdIUJzdH1upDJHzj0uyYh3jCB+MFg==@nongnu.org,
 AJvYcCX6jux7xmIftiHR4buOfx7WsgQLQLcGosdl5QVe57ljUq3fTH4510EDVda83gKrOZ6vUJya81b2Vks=@nongnu.org,
 AJvYcCXsgQX10vEbebSPwxhCHZ9uWC4z5jSy97QXxnzUz1dD5jFki1O3PWC7i0tV9oEO7Bef2/xrNxKrbttevA==@nongnu.org
X-Gm-Message-State: AOJu0Yy0PRTFbm8L0zXvv+suT1/SG+LhcAY2EO666fX8UFiI3LfD/WqY
 1/7yJwZm/mFAI8F79CLtdsetHWuh3ulK3zqJZbY0PcSM8Q21SXtfq3Shzl47
X-Gm-Gg: ASbGncsHKSFc/DKnxhnm8Wpsg5S2EtRP7/65bDIvcveMxDnuKov4ETDPjFA9gvzOU2w
 426gqGVi/DFgvBgiawQLQOlLibGv8CiToAAntv6NkRiCM0OYC13v80DCbyaU8cI4eDE/V4M4tQ8
 CGXA70Cy9frrjbkoD3AW9oeQihPyIEe213dayywNISPeAbSkbzYAUFDC8Ah13XWv8rKvF5xxaP5
 YcoVMw5dzvNEipkexCrGuLfrV7fcoc51KQLupzCcQ4cO+VmvdpNFu6a5TU3X4eya9oZtF1++NkB
 w/5fuhtlteV6hdprD4ENH7JWrTrCJBKvHopFcct933/zdqXg10t5LLVmhJ4=
X-Google-Smtp-Source: AGHT+IGVYb84wyPd+77TwHY4qOu4PjCNVs7VMfmGdBcJLq1yY+ZnLAJVW3AbGcK0d3SEFuBDPWyZaw==
X-Received: by 2002:a17:902:e884:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-22c53f17338mr213065555ad.25.1745299714132; 
 Mon, 21 Apr 2025 22:28:34 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:33 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 04/20] target/arm/helper.c: Fix type conflict of GLib
 function pointers
Date: Tue, 22 Apr 2025 14:27:08 +0900
Message-Id: <01b21c849b459660453eb905d12ff0da4c65f53c.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb445e30cd..05793a6c97 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -220,7 +220,7 @@ static void count_cpreg(gpointer key, gpointer opaque)
     }
 }
 
-static gint cpreg_key_compare(gconstpointer a, gconstpointer b)
+static gint cpreg_key_compare(gconstpointer a, gconstpointer b, void *d)
 {
     uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
     uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
@@ -244,7 +244,7 @@ void init_cpreg_list(ARMCPU *cpu)
     int arraylen;
 
     keys = g_hash_table_get_keys(cpu->cp_regs);
-    keys = g_list_sort(keys, cpreg_key_compare);
+    keys = g_list_sort_with_data(keys, cpreg_key_compare, NULL);
 
     cpu->cpreg_array_len = 0;
 
-- 
2.25.1


