Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446A9C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyl-0000Dp-Eu; Sun, 16 Feb 2025 18:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwg-0004OT-Ua
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:10 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwX-0006RY-Ek
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:03 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso5266946a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748053; x=1740352853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PyhEgN0mIJGGiyzE5W2aicp1atbl6/eoYjpO/+ehjjo=;
 b=b+Y0p8SF+Vw7B3Q85WrCP420LlHWFGrd47eEzOXZbQ17vICK+7duU753bm2iUVLY/s
 FvwAiYFqbiLNj1+ivKOD3XN1z4fNOQ6iE9xJEV6Ck76MyOzT8ruHiZIxGNKFZ24dJiWf
 uJ/r/PsONS0LgjoG8dNSJ/iUMaVSou8pBqaN5Bwpv1yZat5DeHhSVoZeBCtY3UjJpjPw
 RWgR0nbD8wuiStdfsIVnB30PR9xRyei95IZ9Vmp3RQmSAwijwozyaHy41c1i9SGyHWeE
 hyoHINIZ7jW2sjrtKD8cQJQWxNAjfTKN24RZTGhZhS5MC6ml90y+hW2joPxkGNQpswt8
 jK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748053; x=1740352853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyhEgN0mIJGGiyzE5W2aicp1atbl6/eoYjpO/+ehjjo=;
 b=cDS6P9bByi4zW4qtu4IxErWWIaKAlB8MKBlOtdHNAuVzxSplw98o/dXpiGt3gV5jN/
 aS+J3AI/bf1+/0z/pPKhbgO7mU3TyrvGRPRHdKY5NNCaxoPRhBscwr0DJPu7LrZjVa3q
 2TDspPFPinzuWlWncAxkis+1YKsaYQy1UbRSm79jzhN/CmvX21dCV+Qy5rNfEoTrwMci
 nnJ+RwPTSXeWAKoDqX2/Dc5LC8AfQWVuhyIXL4IVad954ZURWEiHpA5kP80k4cA/Gonz
 WvsNAFFQOvVQE2tTjQCzas2RuV/obbZfiAXQg0fxqws78ODzEcJBfW1a16xR7NWP1ROw
 EUPA==
X-Gm-Message-State: AOJu0YyxImxR0pi74UUiybKn4wNRSo933VNNG17DXxsSIUBc9HXyzByb
 ebdPMylxtBAA7tJydQH378JGoHwZaE8td6/TkH5fNKHDlgzJP+gwhmbTY/Ja6InJQ9qvyIIUTyI
 s
X-Gm-Gg: ASbGncuv46ZLNBQDGeuR0mFOJzaftXNjs6eTd2ySp9IerpfueukOBICFY8uHMPczAgx
 7W5ZyER+BJ6i1/QtFg9o5gbz4k2W8D5vrtofGa28affl5ANSDDWJDXzfdGpqP62KWTPwQwPDQMN
 lUxm5KrrT4IwlJbI0vOtHoO9uOdkbuLowOrtRQsy2pGvBr2YvS8fs7Vk77UUmNIqnE7lnMUcjDz
 dlaxULaxasC7J6zFp5+OfQyaUvCnIjvqnJZpL9Yf5qyMQO6IA1RlgFdzYejcsV4K1pEV+R+pFMG
 o1U1yx16Pm7ur6hm1B0u6Iwj+HoY1ggPgemwh8U+BlKmahc=
X-Google-Smtp-Source: AGHT+IGjygxy6++b3JeAFL56DK/nNo1WD7zVibzoxBWM1fGFU2cmExXETQbwBjZjh3TJUNBXx2GEpg==
X-Received: by 2002:a17:90b:4c0b:b0:2ee:aa95:6de9 with SMTP id
 98e67ed59e1d1-2fc4115c7a5mr12201314a91.33.1739748053057; 
 Sun, 16 Feb 2025 15:20:53 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 130/162] target/sparc: Use tcg_gen_addcio_tl for
 gen_op_addcc_int
Date: Sun, 16 Feb 2025 15:09:39 -0800
Message-ID: <20250216231012.2808572-131-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bfe63649db..392b51196a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -395,8 +395,7 @@ static void gen_op_addcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
     TCGv z = tcg_constant_tl(0);
 
     if (cin) {
-        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
-        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
+        tcg_gen_addcio_tl(cpu_cc_N, cpu_cc_C, src1, src2, cin);
     } else {
         tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
     }
-- 
2.43.0


