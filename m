Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE285CFC5F0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syxLa-00089b-Sp; Thu, 10 Oct 2024 13:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxLZ-00089K-CV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:53:09 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxLY-0006AB-06
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:53:09 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so119320a91.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728582786; x=1729187586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfkygRXpawl3aiNihHO54bIZT5dFbF68heyJhlSC/TE=;
 b=F9EjxndnJv7I7YGM45y9CmiCLRcWqH4uVf1RFxcVOE4zvlE4LSWa3n/Q35RWXt7oKG
 7jxetgYnbF9F6wi9OCRQ8Jn4NYMDGGiJlclyTecBXZ6+EQgS6gCW1GkGClZjItEBwfZ0
 RWW0HcNwzLw3dfGx2kTC0NegCkDcjJ3oyiLxoGo/PhvKTe3bg4W46yqA8iw0pm6zAEf0
 lDX9v60j2alXwPXSMp/nft1P607LgLsw+5SLiTvpXBAHBScJLbS7lOH9XaTLn2gFIrTL
 OrQC2sG4sgb3GlReZfcLomQbeEETHn84yVcG297TyUXFTqSSb8gvbp4yibnk9DFhZPLM
 Zwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728582786; x=1729187586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfkygRXpawl3aiNihHO54bIZT5dFbF68heyJhlSC/TE=;
 b=ul+kltywgPtZj38oLxLmy0bmFc/ODrOc9mmUwrJzSa/fgUyVIAhWQq0FD09rtL26CS
 U0thAT3xUH5qt6YB2m9qZ/5LFt/Fqa5JlPxS2bhw1RhAYTDmL30BCw0CBquiRurPEo8r
 cPNOOqObGHrGbf9RzWLbaBthbVJY/KVbN6R2gaYSyROEX5ibbyJoClBlSHDjxZIcx0yu
 K40qHopCxtupgXu/ieUCfm+bZFfJs08oMQZJInMcG2ZUsc3ZO4yqQX8Jo6BqqejYBeMa
 M+1P6bGImgO1IY9alxZeNgez6hKzIV63zi0lwCCRg+HCe/5V+FdsduOPhLoMWNSQqC1S
 NT/g==
X-Gm-Message-State: AOJu0YyjoCuGPGkDuQ0KQuOsnt6UXPI7DPfUdHX0Br4zg+QYzfPZlz4/
 e1z/Ry3WKQTIUnK2+PLqFK8L1P02rRaxwqI/B7q7TIUyNB958mGrgzkjGysU1xh81ZWQvLxZdgl
 7
X-Google-Smtp-Source: AGHT+IG2H0fi7YpSXFj+/UAc/Z/5kmee2YyfY8IUgE6WT840VXLYyIJOm4J2k2bxtENgYJRNHY3g4Q==
X-Received: by 2002:a17:90b:f04:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2e2a2320c28mr7978063a91.9.1728582786331; 
 Thu, 10 Oct 2024 10:53:06 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a5aacf3csm3919559a91.41.2024.10.10.10.53.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 10:53:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 2/2] gdbstub/helpers: Introduce ldtul_$endian_p() helpers
Date: Thu, 10 Oct 2024 14:52:46 -0300
Message-ID: <20241010175246.15779-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010175246.15779-1-philmd@linaro.org>
References: <20241010175246.15779-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce ldtul_le_p() and ldtul_be_p() to use directly
in place of ldtul_p() when a target endianness is fixed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 26140ef1ac0..6f7cc48adcb 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -95,9 +95,13 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
+#define ldtul_le_p(addr) ldq_le_p(addr)
+#define ldtul_be_p(addr) ldq_be_p(addr)
 #else
 #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
 #define ldtul_p(addr) ldl_p(addr)
+#define ldtul_le_p(addr) ldl_le_p(addr)
+#define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
 
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.45.2


