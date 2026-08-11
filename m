Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB39C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteX6-0005E6-Di; Tue, 11 Aug 2026 00:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX4-0005Cp-Vf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:10 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX3-0002lD-GD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:10 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so439862a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424168; x=1787028968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MefsC4UE6lFVxPtqPstaD9eR7c3atArJc6pwlLo8zrI=;
 b=jWDCb04lRmBB18DH/2natfXe3b1hh22yi991Hua2yf4T4N/P8iwJWdMCop3C/8ab9T
 4fNAEXmJJW5G/yCOaO9jatuuqhNgsnBDga9HwT+pU5fS2Fue+iYg0DFXGaOig379O0dt
 tZ7mXd683+VPDX6BncKAMB/GoahLfSjuGxasHU6YJzuiVDZpboAnKEt0QKV2fhziUXgU
 4I1oNsqbkXCOX44KuRILYzT8UmhEf9mtQFw3eYaBONjYLp+RA/oFimi3O9fQBA7vA1Xq
 dzNNw2PnWeupFWvHhj1VDYpRjQT349bbS8F6cNhz/06gIF0REdrczDeM5MzIDa5qwaXZ
 X/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424168; x=1787028968;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MefsC4UE6lFVxPtqPstaD9eR7c3atArJc6pwlLo8zrI=;
 b=jhfKCofO4F0wPe9F5/1YiyswrmNUhPMNJItmK+sHBx6PqTrKfMqgQr1EytoPDQnPcx
 vu77+ieic/zofbBzNE0/YuUgiOlsvwhdKy5sGfv6kJSKusXU0W9vCKUC+JILDEeBFJCH
 L8TPWOKdcZ30hzIGJaLANvi9/ZOvDmrcFx6wrAH5yOxREmveQAZI6hp8iN1IHp60c/rd
 YA2Ivi0fV/HwScdCEDwtMJ326WwAlzUzHK0KwUb6K4mZbQJOaZ+x288YzH0GxEzdRK6D
 Qda39sQwdoosMMmtpJO19q/2SBiZapIXgDRpOuhy3W1rODwvYpokoa7jbHX7smMADoqJ
 GjHA==
X-Gm-Message-State: AOJu0YyyLr/Ax4hAQ8SPUgi0xTTcnDmzrROXC5Pse6UGml5hc3E3jH4O
 ao8semG28+EHg8TnIR74ZG4jt8csYHIVUSSdlqlfK+W+QTy4yUMv5apFkjb0yipOZMNfLaiMZJk
 z0cMz
X-Gm-Gg: AR+sD13Mo6fvOXAJp9vMl8YR3cha258pzZn7bPhbk6HkLKdgMbQYG9frW5hIUpWyDT3
 jk7uTQUezzApN4rqO8FGrA5e9idANFe4FOxKVpH7jtbOeo6qaJ0okBCBLhh7IvTvOXpFJlIq0V+
 gyLngpKACi8GwkLonCOQfBvcfg11opLyzt7TeVB9Zko8JZLZ+qJzFhfJmQtT2haD/tu0bXKChaU
 IoEDzgXHCA7izTpL3R+K6XX4lyuqy/QIk3j8RLXbynJEWzt2iV91GhtmU3IzsFfmqow7XgAS50o
 UC+Ko8npUaLNRq+KzwAl82cWG+n/zSYJf4F2MyzDzvINjYW0q04m3fXVf5gagaK4zZvBzwD5xUh
 6XZm7yXgPc7C2pc4ZO4vx11/ze40tPsjmbi/UAx7eHpguoih/urulme/Xbi2u9pgM/VjpH/7UNV
 8uewAgogsyCkO6Nsb85y+Puc7BFEV+K5pTHFbDNRjwM7fPfdQU+PROg6fVExvWL/W9/1G16kPZO
 x+ME8VgridJ7IePXN4u
X-Received: by 2002:a17:90b:54c6:b0:38e:542:6485 with SMTP id
 98e67ed59e1d1-392ec5d6ab5mr738805a91.12.1786424167638; 
 Mon, 10 Aug 2026 21:56:07 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 01/16] tcg: Fix opcode dump for bswap
Date: Mon, 10 Aug 2026 21:55:50 -0700
Message-ID: <20260811045605.1246543-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

We use an array of char for bswap_flag_name, so some
entries in the array are non-null but empty.  Check that.

Fixes: 587195bd590 ("tcg: Add flags argument to bswap opcodes")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1e77f2365a..e023ee8b9a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2951,7 +2951,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     if (flags < ARRAY_SIZE(bswap_flag_name)) {
                         name = bswap_flag_name[flags];
                     }
-                    if (name) {
+                    if (name && name[0]) {
                         col += ne_fprintf(f, ",%s", name);
                     } else {
                         col += ne_fprintf(f, ",$0x%" TCG_PRIlx, flags);
-- 
2.43.0


