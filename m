Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B99CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYm-0002gA-P7; Wed, 20 May 2026 15:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYC-0001Z5-LH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYA-0002TB-Tw
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso4749487f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305149; x=1779909949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NraKQUVW31QbKUPVKIEQlOzsQG6tUpBJXXvOVJ4Ctlc=;
 b=ZkcXHlOg9iA31imYDPUXK6SHNqDKlG4ZIfdq7vFSRHFIgQnIbzZV0lf/+hHsxO9f0n
 9fjYp8tTiIn0Rw3KKfiDD+9g3YLIO7f0Inwl81UOnPtktpUx9ZekQUadIY8r+NStduSf
 W77eCkCtehg91xSMy3VGh32uxryrjJ3TazC+2rAuWpPTy+8vdTxVu45WR8h4Z3Mw+3/E
 nGx5UJnSJ/GiFLQpfMLsOxR7VYq4kWHeKG985wISg4IVrMupsAt0PDr+UYjHrfhC34ok
 OlI0tkio73vOzDEHdYlsqIlVYHQQDK0ncbrqZ6F4YdiceCv44TaAq/ZgyKmGjo4xYDK5
 S8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305149; x=1779909949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NraKQUVW31QbKUPVKIEQlOzsQG6tUpBJXXvOVJ4Ctlc=;
 b=AW9bBfu2kJiMOOTp8ygmHAF5u/vccNs0lsJZIcWH7dNUPJr/5myiRSOM3Th16FougO
 bFZTDVD3Sv7VaJ7be9tRdwSZLoixg/2HrrP5gis5eD7+6FwDx0IBMURVl+CkByIVUrr9
 qzpXE5gB/HNRZ5YfBaxo+2ZOXHliIxz56FukwLUhnjNeGdOBcJXUB1VjHUCjDdvinRj+
 80xbxGU8bBc/ty2hipZxVhrgVivn03cRs1MROrRNysksSpjgpA3DgMN/0O5EEkFxfJ7Q
 tJJ5XsS8lNO2Yx+4D1mPSNFW1g357uvHF/nbmNXVIqW9neTK03QDUvtabVq4ZH8vyXOq
 P/rQ==
X-Gm-Message-State: AOJu0YzJyKNZs14LQ+0IJg4o+gK1H0F1XpdE4XiZaVEvPEKrTQ4RU45c
 yiciPjW2QwrkdqXHWIH7cRzIjuoUYHaTLh14/THaMzYwm6jQTPtqT3uFJHWqT6w7TaSIaxIazkQ
 NsB47ttM=
X-Gm-Gg: Acq92OECPgqfjzpbkEAit7zFHYQ6LzM8HokPoyfKr7S13uFeS0PBx6VGmzYGs8zPKDQ
 fMxGWDY13/QavN7K4CTsg3/Ie/DEgf3DRTH/zoSGC9bffOxCXrjvCnxbiepzTFmEarKmp7XQiLu
 BfY1QPnVRdHyNsv0CqIJHeU/AsWRFGHo4fFFt/H8GwIEPd+TyhgjYOqw3csTWO9SpdjQv9sDcrc
 YmoUl+BcRbfppUCSyscqtDkq1iYBtOssxox6mxVuUUZVnJ+NxwD0sqmFE3LmnGSSoXKDQdkZ49r
 pm+BhuDEM4e99ITKmzn/8fO8MCajfyH3egH3xwsgpxnCozd6Rx6QRK7gpji7AAk1OTFslufmhnX
 OOLcyuk8iuv34tBTWp1XrAyb1jEPEVkVsv/X7YnVbiKSAKirExlDaDZ+h/0jRQJnGBuWjVGASCN
 TZI8friKdbuj3gkL27bJBnUllpupnGjlTPIzrOcgGRU44L088KH7ODmYItMrWFZ2AQiRKz6BAd
X-Received: by 2002:a05:6000:25c6:b0:446:189c:ac4e with SMTP id
 ffacd0b85a97d-45e5c59f684mr40143450f8f.34.1779305148699; 
 Wed, 20 May 2026 12:25:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm56788098f8f.22.2026.05.20.12.25.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/33] target/mips: add Octeon LBX instruction
Date: Wed, 20 May 2026 21:23:23 +0200
Message-ID: <20260520192338.40036-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-11-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d3..efb1a48b38a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5497ddfb108..451737cda1d 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);
-- 
2.53.0


