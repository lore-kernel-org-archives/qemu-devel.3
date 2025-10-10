Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07021CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqI-0007BZ-KH; Fri, 10 Oct 2025 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cq7-0006vj-9a
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpK-0003yN-Jo
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so1281472f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101583; x=1760706383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R86oz+iNvRN69XS6d62TZCluTT9+zfgjPz1VdRvohSk=;
 b=Wydmscj/v1eC/DnFGMG3UzDtmJ1bxpFOssCA4D70R69sgWZyaVUsUUFS/VEl6Vw3AI
 KXqyhiHWWLruaDY3EHrHki+2aC3t0BqBBY80asvaH3/8sEdsfA6Ue09xvMUNw+2rSAyp
 DJTuiMQyxuj0DyvX37yOZfh+QQPQaMC9jgN8z5Pms38h0TKFQqrHc8mpUNCvIzarcbSo
 h7f9JR0O9nbN/NLurnPq2LdkAH1YiXS8TjMlla6vf/sP0/6/zK2ED5r0fqdzSF++YJNi
 w3HFG5PeREf6eXq/N8B99lOfYa50VrYgZtfyIj0wGyl7Ayfw4LVVZCO5TZ/9fGdpqxoH
 ab+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101583; x=1760706383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R86oz+iNvRN69XS6d62TZCluTT9+zfgjPz1VdRvohSk=;
 b=mga3xwPXjN5Bn0Zv/8Wq7R0s7Hz2BoEuf1ILj3HHDIxGv+dnkQr2WjZuB4rpVhthiv
 zW8/pl/vgJV53mtMb8rbrOb6u3K+otzyelecz/qFjfy0Np/YZacQfWIgX8Vu38MkvzZl
 2qhyhDCDpR5WqezpXDdrVJEXDRByfgBvQCuQXEIIiulY2+CF2VT9IzPsReoTiVsMD4j5
 g8SS+OLcyhxvrxHowYHxFlOBKE69+VPAQBf5cSXk2K/pN+U85gqnLSjOEXbr0PLWw3jV
 WJiey9v3kZna8t17+IBBtWntPY0LXOMo8vx9Y06KCjWMvayMAqFjKEasA+ReOfMeh7Vp
 6seg==
X-Gm-Message-State: AOJu0YzXLiQqvNSx+bnsGHH05VTGwtRrEYnjS81kxogH8Vw/QbvqtgU0
 hzSEQr/M7ki1TFzOWa18h89X9I6eEs3vOP419lVwakl5io4ryvfipEvul3H2GItQoouqGjLF5Jx
 Uvb1L
X-Gm-Gg: ASbGncu5K1/nkFtNcERknHQH5Vf6C+z++2QL15iSdnihma4Masp1109rwiVPTAN7NIo
 K0sRb1xS2noT3u+Z6styyFY7fuSngnnW3Qd+94Uz2QlDR+IfJsMnQd8A1ZnIXSzk8FNKQU4SuQ9
 ExRymXzAESjIVEqtBSBFbGX0+PJhJ/uarO+dm1SjwfJSevtFscoN8iz1NHYU2AMOj5KEr/c03bT
 pOa2uJTHobKCEHcekHTtmKv8q3CK3H0q2NODQOMi6Qa19xk2qfeMV+978CeX99R1I+aQvUbYcbv
 VFRWKaEIz924yWONa85re8tei/HlJs6BC4UAdZ/5B+2J0das7vnrBJYSj89lKUXOzTcQHb2GVPX
 fOmespeVxPm+yGNSIfTg5oZhzzpQGjAm2L3kUnUAZz2NCY7vsVBLiyy1B5U8FPA==
X-Google-Smtp-Source: AGHT+IE2tZtyvtRVqfiLapzkubyjsorwLXmW3ocHNBIYf3E6Rw7PB69l2jENlDayOyYd5ajbahZ2nw==
X-Received: by 2002:a5d:5f83:0:b0:425:8125:78fd with SMTP id
 ffacd0b85a97d-4266e8d8b1dmr8035770f8f.48.1760101583306; 
 Fri, 10 Oct 2025 06:06:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/76] target/arm: Implement GCSB
Date: Fri, 10 Oct 2025 14:04:58 +0100
Message-ID: <20251010130527.3921602-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-48-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 1 +
 target/arm/tcg/translate-a64.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2ae73f443a6..01b1b3e38be 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -248,6 +248,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
     AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
     ESB         1101 0101 0000 0011 0010 0010 000 11111
+    GCSB        1101 0101 0000 0011 0010 0010 011 11111
     PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
     PACIASP     1101 0101 0000 0011 0010 0011 001 11111
     PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b72aa968cd2..38a1f51ed5e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2080,6 +2080,14 @@ static bool trans_ESB(DisasContext *s, arg_ESB *a)
     return true;
 }
 
+static bool trans_GCSB(DisasContext *s, arg_GCSB *a)
+{
+    if (dc_isar_feature(aa64_gcs, s)) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+    return true;
+}
+
 static bool trans_PACIAZ(DisasContext *s, arg_PACIAZ *a)
 {
     if (s->pauth_active) {
-- 
2.43.0


