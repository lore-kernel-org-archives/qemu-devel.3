Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C1BD3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0A3-0003g1-3F; Tue, 09 Dec 2025 11:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09i-0003bF-Ep
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:38 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09h-0003rm-0c
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:38 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so6228252b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765296095; x=1765900895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5NxF7Pe8hs6KBkWQA57i0KsjqT2//4vx5sNUoS3nSU=;
 b=LjOOdRo3y86N7NQjgW3F5B9P1BhSsDkR2Ny1fI3PXwbwcL1ccBXIc1yDIDwmoaFsY0
 JNxgYF5YsiHcLwlYFOe5cbpanPbj08tbWyoKRoUvUAkPrseSAgqOMAy2z78CyINTZEAh
 1fa8823ZVZQ5ejjPsRfLJFXa5Rt5ONWlxB3qm/FaXvVPKadxTfUVweq2pgeVKbSj2LNX
 Dqb5210UE81WIvilFrN6mmNp+EZ50TK0lZm5ciUyW/enE12wBS1wKHbumGQCsPBWvjaY
 ZVVQrplBaRtwJCIqcwuPiQcgJ38K1H/DWIB8zMRCg9K2oPk5s7ZxUCzaWmkNYX+e8qSF
 rPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765296095; x=1765900895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N5NxF7Pe8hs6KBkWQA57i0KsjqT2//4vx5sNUoS3nSU=;
 b=fKjhkg4LFzE4v2XTteAnEkEDwICVuseU9wWhSl7U5jFYx99TtFH55vlxiczqN84Qdg
 ZxZWltVTAT16fyQ7bYS/UItvaA4LMtAFAo2RQ1jnnmGhq2f91f2Zrz71IAnRPP6+pfgN
 6k6yseKOjZIEaCSgvk4NbHuF0L/Hh7PJSChNgOGPNm1N07F/iHUduQMim2Vxt9sjaZUH
 6mxGeVEJJuQxM+BN8UHjbqa5Thade2IYvah7MrgIab9qtEI4gdtbPc3+AkEyrED3UwbA
 CukNCIvRCTbaf9d4nDIQ+lefDYUkFJdmdwUAXo54gdB7arlB1WeihFKZeNlCSMkMcY/N
 L4Ng==
X-Gm-Message-State: AOJu0YxlmwJslpmpAQ//VUzu2OdKoC0FNHFsCnBdHTmGG5EwevdvqMSZ
 M6P6nhy2AE+VRnIH2SJkFrn1nqtEOqN8IuOy1B61f/YY/chOZ5hUCKbJ4j+FyXDWxMtr7qVnyJw
 O0aN475DeWdChKKAH4Lx78pEOyOKYWLw36FQ1rpxnz6Rxt05JuRaKPof+If/ZMyZEZ9fgUbggC5
 mwPX3bFWoZ+pEgylnLErhqPdvGHgoVytl6/IajgOKVJ7I=
X-Gm-Gg: ASbGncsMrOLeNJICcvswS0nDbUYP0rw+J/4vGqw7+DeuByqmtJ7BLEOfzL3laoQfnEn
 kDP6CU4QpWmdz5ZoFf45GjWVRu9vjqAjPFUkHfErREiEyKeO4qIChk59AoKSn6EFdQK/AszGZfg
 UyVpVokvmIzFcGSc4AlpEkIhXesO5t25XzheKyJzocTdm7BhayylYDzMDjKBQ+oK7QRpnMw6poX
 rKMDN4PoQKB8Mj8/mPDV75ENWhs3ChrsLQAEWRobJDFK5UTLhQMRLLZgycNTqQfyxEqhdjk1NHM
 mJa5hWA19recJ37waMlKe2jpO/8UGt7OC4Q7anGKiwz0tsxuFmOOngK961qinCpRevC3l1g9v2m
 JsXGB2BjtFN9eLtzVa9/Fj4WbKwR6Xq2bkbrK0GkRIJEmZCVOpR2ZSHpqSPhYJs2FhwOAG58zgX
 QhA/98PrfZfHq8Vmge9Ep+U8O7f+81oTzmWoKDdA==
X-Google-Smtp-Source: AGHT+IG29GwXRiTwUUiGVvlccJVRzTxyC3SlTfXgoJj1DhIwTZ7OqWcJUXsgDO1f7O/MCvVaXvHojg==
X-Received: by 2002:a05:6a00:1812:b0:7b9:dbf2:3bae with SMTP id
 d2e1a72fcca58-7e8c1c30b46mr13083068b3a.24.1765296094490; 
 Tue, 09 Dec 2025 08:01:34 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e29ff6c68csm16475242b3a.19.2025.12.09.08.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:01:34 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 3/4] hw/char: sifive_uart: Update IRQ when rxctrl is written
Date: Wed, 10 Dec 2025 00:01:16 +0800
Message-ID: <20251209160117.1239596-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209160117.1239596-1-frank.chang@sifive.com>
References: <20251209160117.1239596-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When rxctl is updated, we also need to check whether the IRQ should be
raised, as the user may activate the Rx channel or change the Rx FIFO
watermark level.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/char/sifive_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index eff1766274e..c3bb9d5ba66 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -216,6 +216,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
+        sifive_uart_update_irq(s);
         return;
     case SIFIVE_UART_DIV:
         s->div = val64;
-- 
2.43.0


