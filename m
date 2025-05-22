Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FD7C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7hL-0005oy-Q6; Thu, 22 May 2025 11:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gh-0005Ik-9O
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7ge-0007kG-JF
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:26 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so6410062a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747927103; x=1748531903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edXpGQQK83lOkWaFk7S4cvE7PVc3Wlv6jUv6RWOBqJ0=;
 b=Z/lxIsh/qTxSO90CB8NeuylbQJn/w1gEBBU4ZsAT6aHjaGvc0r7mn3pLUc9w6TWj5P
 y+UI993fondWRXrtvQiDbhOI1dV46ha3KdvUd/RYsu0+BxrKPNYt/7byMPTPqnsPRbXY
 L1G+dQfgOi0o3YxZtYHasAPzjxmgT1dVhVIgGqLeRtDc1eVCxu4u4XlXgitYNYKgW4qQ
 VSkbjU7uyWHma3fpbitHnlmGI1H/RyONt64HxzkOkJPi6ThHc8HaU0GtSaajnr5Ckb7x
 xxvJnPTUqbjf2GEzbMh9HJQFunAHjJatU1xs42/WYk1F2IV+waNgK8fATXYr4VSY7e7r
 Q/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927103; x=1748531903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edXpGQQK83lOkWaFk7S4cvE7PVc3Wlv6jUv6RWOBqJ0=;
 b=IKk+fxUTSE+sTWk425TDAboNvJ49OEvBDhXuiEktBEwZkN758NU/6UCHaMrQAuzVTg
 Pun7ewDum+westVds9IZB9Na/nXXYLwyraEupUPrtQ626scEmluAZIp9izAwGgaux+7s
 eQsMKxHVcXTqW3K4TObfZ2G5vp+0hXOfDUy5H/dEAiudsBLs12R7TK78QTcWKdPIP6H4
 5VaxrokL1OrBwPBz4Z2zIXywXb7jphen0HGOqedpVEng7AMGVFPOHIuaMTV4WQGnYZfF
 PDsCuBEpksL7zKxGydCmhLhO3VjEnTVr+1pT5U70GbRiXRNiRFqUNVmTDoQ0fV5jOf+9
 8WjA==
X-Gm-Message-State: AOJu0YybHJ94rR5GBs+/Pty8aIb8EdEvYivPHIyD+fGzodYnNLptFSse
 Lt/xUnlGFH8U1vMtja7K2kvPZ+600RK77Gd2AacSSYab34hSWHecbkJGB6vZCQ==
X-Gm-Gg: ASbGncts16p8VHf2jItKTm7oqqS5G1EZ3uBkXZbOJYgTV7kpzfsII+649dbIVm0AIIy
 sj6DmjrIp31bV9w5byihj6aHZE6A8AIas0rHYZgbpsefvYebRpbaS9D36h4f59rVDsuBOYmIlOH
 r2PMlRPXu5+ktRcnZz61CC1jSb8qy33m+cqU8/2FWXXm+6MNOIe8g7GrwkkJuy0XS9FdLdSBw52
 gpm6DMax4wqWNEHIPGIxPwb7caLAz/x5KUgznRfQi1ExQL7LjczztMeYbJePZhYUEM1MYxeShU1
 +n0NjOHclM12ukfDS/Jwuk5GQEoflSV1Uojn5MED2mU2+SEtDuSBwcm05dr5rg==
X-Google-Smtp-Source: AGHT+IGUVf3g1XiI9/kpr82fHFFb6dQtpnyJ8dnGvQGzSzqNH8K7oZoP7yVfd0YjliecXkQUQrJh8w==
X-Received: by 2002:a17:903:2990:b0:22e:1740:e561 with SMTP id
 d9443c01a7336-231d4515b85mr398278555ad.19.1747927103005; 
 Thu, 22 May 2025 08:18:23 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:c732:a88c:b916:8b9f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4b017dasm110443555ad.98.2025.05.22.08.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:18:22 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ktokunaga.mail@gmail.com
Subject: [PATCH 5/5] tci: use tcg_target_ulong when retrieving the pool data
Date: Fri, 23 May 2025 00:17:30 +0900
Message-ID: <3ec0f9bd69a42965f55e079739045ef10f4d4d82.1747922170.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747922170.git.ktokunaga.mail@gmail.com>
References: <cover.1747922170.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
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

TCI's tcg_out_call stores "func" and "cif" as tcg_target_ulong in the TB
using the pool feature. On non-wasm hosts, tcg_target_ulong matches the
pointer size so this commit preserves the original behaviour. On the wasm
host, tcg_target_ulong differs from the pointer size so this change ensures
TCI retrieves the data using the correct type consistent with how it was
stored using the pool feature.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/tci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 700e672616..cee65bceea 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -367,10 +367,12 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 ffi_cif *cif;
                 void *func;
                 unsigned i, s, n;
+                tcg_target_ulong *data;
 
                 tci_args_nl(insn, tb_ptr, &len, &ptr);
-                func = ((void **)ptr)[0];
-                cif = ((void **)ptr)[1];
+                data = ptr;
+                func = (void *)data[0];
+                cif = (void *)data[1];
 
                 n = cif->nargs;
                 for (i = s = 0; i < n; ++i) {
-- 
2.43.0


