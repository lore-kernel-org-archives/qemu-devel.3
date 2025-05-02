Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D830C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAguh-0004Fy-B2; Thu, 01 May 2025 23:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgua-00045e-FO
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:05 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguY-0003zd-Ti
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso1433057b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155881; x=1746760681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4QqPt240JeB7hjh0OkecHrTdb+ZtBLKIB7bPU4Cqdw=;
 b=R6iHV9QwqxA1HCEDjYd6Pmmb+TWzYKxY1SQbP8lSSoO9q4/E62G5iACfsK7ccGme2i
 OTEnHF3ooWWESS4NHTwnR068G13pozc3lr1sr6Tt3BwWk0IIUHUVUewNwDbtr47SPv+S
 vl4HC1b8Qk3F5b19gXMuig2QdUrOnJb9HEAe3NJXQWZyh+xWvvQEsB2EfD6IQZZBFRtD
 8Ubj+Bk7NnQHnNezuP5t1HL7SN9aJ6ePnbKPcAd1cAIAKT1TPH7n+qRL5F2pS2IhO48t
 w+EaHUk6Jj2nNr80xmwJ/54TuX67Kx22Yn/UVHbVl43nV8KTNmwuenjYAtaAE7/LuWs0
 3mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155881; x=1746760681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4QqPt240JeB7hjh0OkecHrTdb+ZtBLKIB7bPU4Cqdw=;
 b=bzIwze0v0YY8AcJ+17jmzaXYIus0e4Y2viwhNafxRL7W7IvoZUeedvRB5uiu9Onwtl
 w2NFdmkE8x2stE3BF+R03zm1vE4MiNgHM4rGETv+cfiSAuCWhoJjyvTpICNvZvef6k7+
 /zAuQjq3UJ/nLAazb3ohrhO7ZDl2+zx3OWjMVo3nSD1kwz4ckFyCKLNcESA5FqgHOFTi
 xDM2FU01I45NR297zNqFSTQAUXgaYGPqhywoOn3msMNfIl9MkSDBK6jIhwubDHY3bYbL
 OZcy8FJSlJBDo5PxjmbYEiEmDwdeKFcFIEYNgYL/8kxEtbI8+3A7flSUyytXviLnATzr
 ckBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9lhwp0jdezUjjRHhQUVRZysCmjVGfo9TWUqrngpQdJZ3UEQQd4kM8vPQHAm3s0wAySswuEDOa/H22@nongnu.org
X-Gm-Message-State: AOJu0YykK6T0RqzjjXr88SI5DzJZ/szzhEp8D5YBnGrR1W11abyZd+q0
 XmhA38rnhjAtcQuwAgqBUgT04phTlk1y9QqqtyK1z6gGaxUg64sQ
X-Gm-Gg: ASbGncv9i23iHUTMcWJuH3REZWInsLt+kZyCXzMrHemPukmhcS0UoNidywL5xkm2PJY
 r7MlkquXpE0SgrZ/GuaN7VTvqDzQqmCqd0zqfmtyGaJkOGy1nMWZfZGyUKR430TQrGTPoQhk3gk
 ijX6q+uN2gHUEmVkdLIaOIsN9+Hu1ASxL5HT3ZXTqqI8TQqDOH/JZmpR0P4qFpcIwe+Fxuu0hNF
 WPz4Ydgf6jGgU0imIVQr3OTxGNP1x+ICT7jj6qshDKatapjJ960nHBKI/2WEFEY3tw6E0WwR9FJ
 0DKSPS3ANlmALWCRwBUYl18PjpuwrlhhDtFcPI5Ejfb6
X-Google-Smtp-Source: AGHT+IF3FZRxTD8+cRIoOYfIktJ0/OnEm+G4+fcejmszQ8lCw6Txqk02bWPbqJfl/CFa2LIfrdV67w==
X-Received: by 2002:a05:6a21:78d:b0:1f5:8622:5ecb with SMTP id
 adf61e73a8af0-20ce04e7581mr2186136637.34.1746155881616; 
 Thu, 01 May 2025 20:18:01 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:18:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 09/12] hw/net/e1000e: Do not auto-clear cause on postponed
 msix interrupt
Date: Fri,  2 May 2025 13:17:01 +1000
Message-ID: <20250502031705.100768-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

If an interrupt is postponed, it should not do cause auto-clearing
or auto-masking. That is done when the interrupt processing occurs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 5969f49e8fd..022884a2ea0 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2057,10 +2057,11 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
     if (E1000_IVAR_ENTRY_VALID(int_cfg)) {
         uint32_t vec = E1000_IVAR_ENTRY_VEC(int_cfg);
         if (vec < E1000E_MSIX_VEC_NUM) {
-            if (!e1000e_eitr_should_postpone(core, vec)) {
-                trace_e1000e_irq_msix_notify_vec(vec);
-                msix_notify(core->owner, vec);
+            if (e1000e_eitr_should_postpone(core, vec)) {
+                return;
             }
+            trace_e1000e_irq_msix_notify_vec(vec);
+            msix_notify(core->owner, vec);
         } else {
             trace_e1000e_wrn_msix_vec_wrong(cause, int_cfg);
         }
-- 
2.47.1


