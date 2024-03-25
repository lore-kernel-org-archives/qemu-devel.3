Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC16C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 03:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roadv-0001OP-1L; Sun, 24 Mar 2024 23:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roads-0001La-Po
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roadq-0001sr-5U
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ea7f2d093aso2228248b3a.3
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 20:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711335892; x=1711940692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PY3KDowjiarkyszs3+7iWfbyLgdSa/+Q7K3ImscRK+k=;
 b=nJdq0UgFIsn2Ia+kUYkM5SjPIxJBOrFN45lSYY2s/23zgFLEUyFe7r/fYlP039VXJ7
 F4B8LZMHrcEkKvrY7zIwnkjGJhsbDZm79lk5l3iz6jwCwj14Oga+/l3V50JTqyAW50Ty
 d+6JZhHj9pqqVjVOlDKCMmMVDZ5voAXUbXYxxPNwV0HHYa/Xwr84utRgnjhg3Uim2tJG
 Xt2JwuFEapBFhxtWs/btyOTHht8/bsuIUrGdLiKGBznv48S0Q6XNwnFT0Ukp1NbhrwlU
 fUSJGHmAfif8BU4yRXZyjgDwDn96R1YQiNkJXFTWJAh/zEjea8ngpK0IP6Z1xVX2Muje
 f+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711335892; x=1711940692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PY3KDowjiarkyszs3+7iWfbyLgdSa/+Q7K3ImscRK+k=;
 b=k5hy53Ts5yfj8cB3ieec9RsrPEpgk0AQ6eEE//pyzZaSEiRZl/aSf05y04fAueOSdB
 cIhZ5HL21cc2U7tewI0fbvIlwdaVOUUcHQqUEd2a8BixpvsBSOnXBXA5Jc6+i5Ibu9sT
 LcOwYF/sO67usx5ff8aPR0zAvj4Pe4pkEcftXFteuA6lC6GJA4bULb9wCCJDHHJGmQif
 atgQBWTcSsTS4zpghbP694PhYu795XTtQ9TuHu8KSr9ayppeIbw+qcCB9jsXzP6O5qFK
 ac5k6L1o6OEQv5PAb+1UuOn3gob5BDgsGpfPwLNLOWYn2fuZ45DEPF7PQVrnnsFc1Syc
 /wWA==
X-Gm-Message-State: AOJu0YzmFrJYvyviFiMftOp3k0Z57smXFZNs/FtZtkJWAaQR6aUYhV4g
 aWiSKjAg9e5VCA6QryrrpmPGK+k+Z2Aj5MoJaA0YLl0xMkO+2XX2x4iKU9zgLsOFSBSZ+MxSRaS
 i
X-Google-Smtp-Source: AGHT+IFJZvXcunAbtaFgRBkpH79777y+zgOJjxFlpoi/cOUBg4fyDx5S/juP4uml87OK3CpBlFgCxA==
X-Received: by 2002:a05:6a00:13a1:b0:6ea:89e5:99a3 with SMTP id
 t33-20020a056a0013a100b006ea89e599a3mr6760797pfg.8.1711335892359; 
 Sun, 24 Mar 2024 20:04:52 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q12-20020aa7982c000000b006e6b4c637b6sm3291880pfl.116.2024.03.24.20.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 20:04:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 1/3] targt/hppa: Fix DCOR reconstruction of carry bits
Date: Sun, 24 Mar 2024 17:04:46 -1000
Message-Id: <20240325030448.52110-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325030448.52110-1-richard.henderson@linaro.org>
References: <20240325030448.52110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

The carry bits for each nibble N are located in bit (N+1)*4,
so the shift by 3 was off by one.  Furthermore, the carry bit
for the most significant carry bit is indeed located in bit 64,
which is located in a different storage word.

Use a double-word shift-right to reassemble into a single word
and place them all at bit 0 of their respective nibbles.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e041310207..a3f425d861 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2791,7 +2791,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf_d *a, bool is_i)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_shri_i64(tmp, cpu_psw_cb, 3);
+    tcg_gen_extract2_i64(tmp, cpu_psw_cb, cpu_psw_cb_msb, 4);
     if (!is_i) {
         tcg_gen_not_i64(tmp, tmp);
     }
-- 
2.34.1


