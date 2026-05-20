Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464BDCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf4m-0001Qm-38; Wed, 20 May 2026 07:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf42-0000sM-FS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:26:16 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf3y-0003mN-1n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:26:13 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso758598566b.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276363; x=1779881163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ua3CUzk6DVk3QCHlxp9NqdvtWDqGXb8iHfHM6jORZfc=;
 b=EmKURZhtsYCp5sH+T+S825D3m0SMdcMoPzonllZ4CszWQDwBLpYqJmUdOtUWkCdf6O
 M7SPQzyhi8VLs5roz6MCnrxYPRB2ETwjYnZh0sLqWGZ8lmkji9dpn7BXtjcJlQhOALvn
 Mw+nOMOLGCf/jNJOx0oq9oeAuVDABwO0F8xWkytgbrP8Vu2EJaWz/CH9AY395B3HR1fj
 DgeT7MjW8pUzw5dRWGmUolHEQ7IuDOVVeTPcknee2wDxtFcdSubM4oyagrUfqRLGLsiO
 i2S2im5LxTLM11Yffxkc8ze5Z0fRV6hUAiWuG4RPmqqyO1vfpOMthq+qpllYU0gMiSY4
 ivqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276363; x=1779881163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ua3CUzk6DVk3QCHlxp9NqdvtWDqGXb8iHfHM6jORZfc=;
 b=X8rX/aT2nta2qhh3qMe1E27f4zgyonh9IZV6acAtpKbWdu+8NokoKl9DP4nOrWhY6N
 vL/l27BP8vN9yGJ3yJwf6EH4/pYVJRmqJDpELKUcElcKEmu56vXbkNc0kMHUi5r+57n3
 xdoYbjBMZ3MXww4W2PBu7sRqqLpAkfKSP6fSob6JFWN/QRB+Q/LpBqSwbPdKT37o5qBu
 K/FshX8M0D35ydocdT0+cOcRjQrKJJOdBY7XdxVE5xseNjWg4kPBzkfXN5PFiVEMiHPd
 MotFyBWQz3DjhT9ZRcuMUfXcF8d+EpADaR5pVZZeuqauOlhhRde4MpKFa5QmF1+s4D0V
 Jpew==
X-Gm-Message-State: AOJu0Yw/0PdJ80NfFgYBe437fkMzpmqUgx+eVpy7+IKx5mlJndLwu0j9
 IWe9WydqpqN4e1neezHO0ABC3uaXfYbOOsfHutwDu2QE/U++jRNB1zdK678lWk0RkggBKJgIVbE
 MkKr76ng=
X-Gm-Gg: Acq92OEnp4KZOjzPGZi9EmeYTltz5pvxG2k6e5mBY/Q2vmMabtx8dUIDqnQlCl9oCEU
 1XZGNCPhmjfNSe8jVC00LAzDNBqicS7k5z9IJ4XIRaw4EgwgmJfHxReIPFC33nBelh3pIutsW4e
 Maa1GlVDZb2ww4vgfK1NvSTMsfTqaKNGzZ3e6CNqhRwPZAClHkrhiFDNsTsrEcffZksD1o/RPzU
 doObfaYLmVGyQTaEKOf1OkxBiM0LaU8ssYN3lh4V4ROIiAEsIlgzw52S9MsxP5lBxIe4A2b7bad
 wLH8MSQI5jf+jmFS0hjRW9PU1IlSHKdXcr7cvoyldFwBizVDGLkt3rLK6gBTiDQa1I3v1d8wODr
 OSeXoMsrQbvbiwU+JjI3GPSGZxl/AVfBreJZiFcFyTJmou/L6Hy6/1+hByzXNWSZDV/Ra01MFEK
 SqdjatlqZm9zuao1KIhhe2skqk9sP8+JDnKk2xfI6zhrsh3xGx4QP+wRF2SBoHFWobML6RQ8w4u
 KsPpA==
X-Received: by 2002:a05:6000:1885:b0:45e:8978:f176 with SMTP id
 ffacd0b85a97d-45e8978f1aemr10822533f8f.0.1779272372324; 
 Wed, 20 May 2026 03:19:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a178adsm55902378f8f.18.2026.05.20.03.19.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 11/24] target/mips: add Octeon LHUX instruction
Date: Wed, 20 May 2026 12:17:52 +0200
Message-ID: <20260520101807.9971-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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


