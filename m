Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A01C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJw-0000Yq-OX; Fri, 20 Jun 2025 13:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJv-0000Wv-2Q
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJt-0004Dy-H9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so24073895e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439667; x=1751044467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spEBKrueA2eM2nG48ZzQvzRv6Xoawzk/ovvl68AgWB0=;
 b=Za69zNr5hY/34IebTHUYsYJEPlwfD7VINf3Xu2NDt1n8BWmSCyNWn7KAAI8YHVbt3H
 gWIdostup9L13pqQ+88DybzK0H4QZxNeGD5xxPxb9WTiDNgeHcWGb9U0xnPvT8PJowFN
 +jsRehhI6AETwb0PnBm2yunmRvi+2U1OvUSbk9lC7zdSzyDt10bdSdNn79G9CS+LHNIL
 1jh5eGUdwkm6dTttEjpAymIXkgSq4eGpii/GRkrpM2wbq51ApIX2jaZtjuL8TjDZmRL+
 imrtj1maMd26QOjrVv9P7FhTeb5vT4CNo5c9gCWxMlszjvf+Jrd7El252EFF2z5EbxwN
 qCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439667; x=1751044467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spEBKrueA2eM2nG48ZzQvzRv6Xoawzk/ovvl68AgWB0=;
 b=Z8xHKpuDlhOuNiynswpOudMiqarMrTaT/SGFfSK1JPkO2WL3JkeeYuynEVtHtgQF09
 K6d0InZN1CxvS18fmaMmqmW9UrDcu6OCEDIEdfWDyaBRj8+ky550oShYS+CVL78tzn7S
 0bYHbkT6hgPdVjfku1d9+ergbKPc8b7mXCR4KbEr2meMjz1cIx7mvlEA0NW7cmWVQJq3
 sn7pCyAl0+EqUeHcjnEIhRn8WgTSLSIVuCRAla6oetVIgiRBklNW7kKeYX009qtclBqC
 jZ4REvZ/B1xD89MjUA323qLbQ/hGHnDidEeb7sIfMjbEm9j7DmhnQDZYHS6pHWlaZk0w
 nTPg==
X-Gm-Message-State: AOJu0YyjUL9FxDHtPmzZ+sGwz9iOOne5Tp3boRmCU/aNEjA4F69Cfv0w
 NcSqbAlfad+lTH7ejEvpaJOGbsna2MewfCz2tA94ak4SF0316GTfboSWilBUWNwnNUwyR3XWoBl
 J7c1p3XM=
X-Gm-Gg: ASbGncv8/GU/2AbcBMq3Q+LAHS4y5OPx3qOtmEo8vU/hMb//+GpRpw3nGXAC+WpNniE
 PtHi2eZaBhCHpKTVeoRm+pOgOmVuKJMbIzHb9VkJs0fbCHZAZ95zkk9lVAaY97bJyjrKpGPif4L
 5Wwas2IH2+x//AUX4cX82veLHtcwufHbpq79D2IpYif6LdPw5dXUI09db2v91/FKV7w7/rk2XFu
 pMuvXekS+GayI2tOqjoWkHDbv3SZhI2i82WYtpxz5v10PxnmYYPqyvbc00b/F8XykUiuRzKOSYT
 e2/cf95rzXnhij3FzSKsB98Zi4izciI8nTaTKwCQ7i8Ln7twAaBs5Zqj9vW67aIIRBeu74S3xiN
 nPRnv53aRUlMApctEEpxSxiXZjhr5NrIPZAla
X-Google-Smtp-Source: AGHT+IFTSYFuO8+9B9bz71fuRqICQZnN2gz8FRxS0JRyKluZPuJe3XtHJ4B+zpDTOFQPkRk3aFkJxQ==
X-Received: by 2002:a05:600c:314f:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-453659c0d74mr31027235e9.32.1750439667332; 
 Fri, 20 Jun 2025 10:14:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c663sm2651846f8f.64.2025.06.20.10.14.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 09/48] accel/tcg: Prefer local AccelState over global
 current_accel()
Date: Fri, 20 Jun 2025 19:13:02 +0200
Message-ID: <20250620171342.92678-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 6c5979861cf..4b1238ed345 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -82,7 +82,7 @@ bool one_insn_per_tb;
 
 static int tcg_init_machine(MachineState *ms, AccelState *as)
 {
-    TCGState *s = TCG_STATE(current_accel());
+    TCGState *s = TCG_STATE(as);
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.49.0


