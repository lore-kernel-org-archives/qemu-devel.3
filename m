Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CABC3ABA4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eE8-0003ZK-My; Tue, 29 Apr 2025 02:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDb-0002Tl-6Y; Tue, 29 Apr 2025 02:13:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDX-0005Qy-Ka; Tue, 29 Apr 2025 02:13:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fd89d036so69602785ad.1; 
 Mon, 28 Apr 2025 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907196; x=1746511996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5jQ6wutrbKpg8Tugc42Fb3JNM9evspVPMNApKKkwn0=;
 b=DPSH8weerqDMwgHNJqmmFwaQwALgCboqnuG8Y6GrO8IdwB4ApwoioX5fKVjyVt71N7
 Ryt0rcWPecNVbMD/4nk1n1qFZh+9SqxT02HWd4mTG4EihHNiX2lxwFb3HADOJCBTS4g4
 +GzrUnVbq922j4yepjwELryVbmAWAPpT51M8b+e89JhL+iLlTsFtkpLtRdYOsmU8O9dh
 kwdCxnKI2Pc6OpWilUoIa8/mnmhas+E/EIB+D3tPMPM3Yp9My+0kP/+3FixxLNVJJz17
 64FiU1efMhskwN9Q6ByhDgFEWlvzLd/Jc9/0rGCu5XCby9hqtLGIw5mBAU5IaaqMwBma
 FJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907196; x=1746511996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5jQ6wutrbKpg8Tugc42Fb3JNM9evspVPMNApKKkwn0=;
 b=aO8FEeVAqGSWyNZwjUYF5zENR7nx/Nv/lVbUS3Y7lt42wPi+33vi3g7ArdbO7nATsK
 8zVdrXww7URTgwxIJooLW5pBX6mlydCCzhooN97BDHT6aQe8MjxGwrjJlYmvF5uvEalR
 7oPv069RWcjnVWbmJFg5NJieHtc8EtpJNCkvtr82vS9S0OcyG8GTVZG7fzH22JfadSYy
 DjKO6wLX3gguvGs7+HjtRAHZv2T1cTUgOFM32YRydGDxm+g+SIJioYioV1nfrhiWI3H7
 MQO+pRZAc7w5wAgBCX9SOb5RurUE7mWMaZVrlEqM+YBlHurtCm5EldebrmybuAxSA15P
 RByg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvRvhTsSQEC+CluNLDMf7QxBLsjIxCOGYiHRi2+fxso1zbL/PvhoT58NO2SYxHAG5xQ9FT3A+b4IBE@nongnu.org
X-Gm-Message-State: AOJu0Yzz8yWtAhMQMVjF8tAqmdk8ie+9JX03PiuusEqqzpRqCGw0Hu+c
 XtI2Qqm/gbEemfYHWzUtCTUPDY+6XDk1GTrxS/j++ZiRL3ulYVwzc/bmtQ==
X-Gm-Gg: ASbGncvsh35YniiaaZuQbPiuVTvuqngc30SeZOY3ppsIQPUpPCapC+Arb5T7e/BNQ1L
 lZkWovHbVUvYblaw6tIMqRWcXgQs/RwUY43ubXTYiga5Z8Gw7M9W4qItZShlJcFgxAX8kNK/Tv3
 kBv1EYcrUOuKo4tqM5zNTpWx+8Uj0+IuV/IsEw1UMpIVK6N0oJgoXWq4NiTLyLT8+Y+DlqHqbMw
 nLPGVNPa/KEcLsadQ6BOY7BSPpoaSMuL2NOnphUXG6bKDqK6nJQG7OQh6patV6eD0mqkaLySuYg
 mOSddS3KuldYkfgRwZDTrqV7zpQkFyA2wm6+1qT5dnqIq/wcDgA=
X-Google-Smtp-Source: AGHT+IFO6ZhzVehfjitzSOHJLmRRXTnSuJfRp7PiCXE4Bnf8xHb44Lp/5kbNdEsdvFN+GyzIGPS//Q==
X-Received: by 2002:a17:903:2ec8:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22dc69ffb69mr178117665ad.15.1745907196493; 
 Mon, 28 Apr 2025 23:13:16 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:13:15 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/13] hw/riscv/virt: Use setprop_sized_cells for reset
Date: Tue, 29 Apr 2025 15:42:17 +0930
Message-ID: <20250429061223.1457166-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429061223.1457166-1-joel@jms.id.au>
References: <20250429061223.1457166-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cf7e16cc6678..baa894b11aa6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -932,8 +932,9 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
         qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
                                       (char **)&compat, ARRAY_SIZE(compat));
     }
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, s->memmap[VIRT_TEST].base, 0x0, s->memmap[VIRT_TEST].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+                                 2, s->memmap[VIRT_TEST].base,
+                                 2, s->memmap[VIRT_TEST].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
     test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
     g_free(name);
-- 
2.47.2


