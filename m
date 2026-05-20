Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE3FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkev-0005IA-I5; Wed, 20 May 2026 13:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeu-0005Hf-4A
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkes-0003i2-Fu
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso42447875e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297876; x=1779902676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ua3CUzk6DVk3QCHlxp9NqdvtWDqGXb8iHfHM6jORZfc=;
 b=eLi2u6c6+KUylh9OqDJuy5pafwQJT9YxSzyAOmmXoY7REE3zeVJtFoayP7HkFCTWiz
 iJIhjRhdOB4Nx0xcm5ds9801OFfaW5dQjBemqzRZZ+hdkOLXV6EYJ93oDUe7szTr5z32
 Igu/8Te6WDl7dWftrLB3Jw7+F3AUM5GaJsB9e+LBEixTqx27JULw7lD9R6LfsDF2tRXp
 ThH4upwWHNDJ2uKcJOjPvj6xmxBVrq8pV4rZT0qB7Co4LSM59L3SrslJ7vxxNms1pVPq
 AxjPI47s6ceBsu9FDAAImHFijU1+HP9RbfxaHAigQjIsdhQFplxIMUU+wXbh/WrmzHiC
 3WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297876; x=1779902676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ua3CUzk6DVk3QCHlxp9NqdvtWDqGXb8iHfHM6jORZfc=;
 b=WbTd1g2hKBZd6ydYCxe5DWdWidohZmfez0V4dKMGKy6g59JD5NOdW9i4E+o/ejNoJE
 GaHFrFog/zOTS4kelT/XWOt2pkmBYPHkdk26mzF+vlQle15A24puEBhv/FVsCKhBsccg
 uEqlaRktFbAN+LvSbDj7jSUvIHzMSkUsf/Gce3i92to5Tz9G5D7ExQhaVhleN0mR0otE
 ZJYbpqo5ifhSwNrD9Yznwrg8OePoVscbatxKJYmxaAyI0DVEmA1p9TjwQiNVbEmqDH/N
 T0QvUcC3p519E/HkNxoZ1ZACBJoeZXuJJf+jXDZdOTSun9s2aUezTK6y34PUEC8AdrOB
 DdhA==
X-Gm-Message-State: AOJu0Yw6Z/G11JJc03NgJnCs7uRIaNcgyzh29sVuGGVB1lAP9XnF3jih
 mR5I3Ww9IbtB+GWwT9JpGszZlRPcmYnfz3cZftoFbMYuhp+UgwGPMS5xIUlSLMwpup402uadK/8
 Ffr+hr2s=
X-Gm-Gg: Acq92OHerfTYVN8IDnMMlmzGusX2pAPues13fMT9p2Hdl50VOSiux55i9xE22SMhVc+
 4CQqeg6IjtcFkqBVvETDhZrco55YWfd5tNF8zqxH4JF3XjMuOcLsuFGp1YRltbmdxaNe0aKie3f
 LYbUgqNW5fV5UklsTmWDCBg+7OzEsSWzq1bHupms+znfiIhXCy2BjG3RyQKdnBWutsGdHFFZ4Rj
 jsqdI6NMd3ZJ5fO2IqU0nkY4FhH9aJj45uqLwqLDaLOPST/oo8n+f1ArQffqqOLwjCQuAf3KSZ+
 c5LLUhO45vsmy7D3tXikuNkZpNB6rMEED+4kxMolnGlJE9eluAfoOxTvcX9gV2v9E3RKqp43R4Z
 YdWhJ7JfwQZTEa07p2+A0XkfWItWgkaaHX7l7OvmNu6qy6TpkxkezgNpze/ddxCjHa3gQOxdI8u
 Jr4GDdXdquOMoW09FuEkiN49vpmvFHLeMLhf8ODSC6d7HuKHEI0b8QreAK3GMnoVa75Nq2SQY3N
 G8iWqAJsXU=
X-Received: by 2002:a05:600d:8496:10b0:48f:eb8b:9980 with SMTP id
 5b1f17b1804b1-48feb8b9ademr247620605e9.30.1779297876527; 
 Wed, 20 May 2026 10:24:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab290e1sm218239185e9.2.2026.05.20.10.24.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 11/24] target/mips: add Octeon LHUX instruction
Date: Wed, 20 May 2026 19:22:59 +0200
Message-ID: <20260520172313.23777-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38a..8a755075e8e 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 451737cda1d..f897b42807b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -164,5 +164,6 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);
-- 
2.53.0


