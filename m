Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5830CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnA-0007e0-H6; Wed, 24 Sep 2025 15:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ult-0006uy-Ss
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:25 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujt-0007oi-FM
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:17 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3322e63602eso217751a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740473; x=1759345273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLwlRRCUdDBJvJH1M9ZzZRAOVqgIKcGI1AnSosumpK4=;
 b=pQ8ZgucilcnrJWE0dzTxFsSw0+DHiayXO4hHB7rMzz/8PBh71o92eKhTbroIPegB38
 ORjncaW8mtJQNKc5lkjtuk6C+Yewfm211plXJSZrXkq9PqtnVHwXcIOx+VQ/qkTUjpuO
 tUfT7ijFYjrddW0FOf/zLZPDPk+hwaohA6StXzjZ+LRxP+kQaYu+/vgh56J/3y+i1myF
 DnrH0oZtbaX2iJizYy6y+NDByJAnL378OXYZKtwdFL2CEz0KkXn4mv1aHooIpb1eaujZ
 +42B4OmWLDY8afuqXHRoSfFMbiTD7qlQo3qlTz7vlcoNay2fgQ8Tj7SWbM1mRWalXB5M
 fKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740473; x=1759345273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLwlRRCUdDBJvJH1M9ZzZRAOVqgIKcGI1AnSosumpK4=;
 b=XGJg3E0KabyuMw1y/ZhFlU2aKCVbfd8Y67jhLhZgZ8w/yln4CxpjBV89iSL+2VjAkB
 gIL2B3YQBjj3D4HxDOu5N8yykpn8oDWvJ5ivWR+vD15XAPM+wUtDthk2WQUluWhtOF10
 oyn3qNjQR992clxJxXV3ojmuhZyPyfgv7dIor5c8ShEJY9OQLkQGW1XL+SNBBvOB//cp
 vxoD8/RooM5lYkXZdzDHkM9MAxKuuIpoESgoeTPMdEqMmF44EehxJnWVaV1XjjIwfieS
 WZly9+775I/lg58dAdUAB3BX2cMTbAeHmgjpA0qCWnDYZbyqIXQryBXiaprkghrvQ2Uh
 Tk8Q==
X-Gm-Message-State: AOJu0YxceXhGBqr2ybM1sKQI5NuEcgrPQgCuVY6rGpW6FiS1Oeek2SwS
 C/zfgxOfelEhHmhfdwAewaJZmQNBEkzkUN845yg6XYUI6ZgNw+EP3TfuL/HFRutl9pmElhNgWBm
 UJjEO
X-Gm-Gg: ASbGnctR93jDc0CopNUAq0u6vP9nHbICeO12fehTj8fJ2t4J9Kf8H/MSDDwY7l8AfiD
 Uhuf4dtqqfRaNF4ivhjyO5W+j/JIKtw/ubLfV/HM4ojhPB91zGVtIe04R2Bmj1V5TOA+bRiayMl
 dAJidPvcRlMAueBzt35df0Vh5vfrjibuU1wtTg5jzCLawSk2nGcphe+F1hAUi1y5lSncK3X0Sly
 xOFLZyMUGsnnOpL5F3JOgP/0qeAlOPcj2KqPKLsE+2jPjs/HgmXHANarO2yX3wz6SQ/gXSVZAM/
 a+eFcpm3RB+rn2VQ66+DFwUkhX0O9yDHDMLm9qB98WRUMNUxnQjMblWnyp92VGZTKvJomDPm5hM
 Vrt5VS3dWJ/MLnp0qWdsAwj767H8L
X-Google-Smtp-Source: AGHT+IFO+0T0bqr3sD7VfFjJdInQqkyEoeEeh60pge12QzAmhluLFX9SQt0Z4LNdTT+UEUNcjMN01w==
X-Received: by 2002:a17:90b:5627:b0:330:793a:4240 with SMTP id
 98e67ed59e1d1-3342a2c5d9cmr591889a91.31.1758740473168; 
 Wed, 24 Sep 2025 12:01:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 08/32] target/sparc: Loosen decode of RDPSR for v7
Date: Wed, 24 Sep 2025 12:00:41 -0700
Message-ID: <20250924190106.7089-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: 668bb9b755e ("target/sparc: Move RDPSR, RDHPR to decodetree")
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 74848996ae..1c6403ad8a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -158,14 +158,16 @@ CALL    01 i:s30
 }
 
 {
-  RDPSR             10 rd:5  101001 00000 0 0000000000000
-  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
+  [
+    RDHPR_hpstate       10 rd:5  101001 00000 0 0000000000000
+    RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
+    RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
+    RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
+    RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
+    RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
+  ]
+  RDPSR                 10 rd:5  101001 ----- - -------------
 }
-RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
-RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
-RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
-RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
-RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
 
 {
   WRPSR             10 00000 110001 ..... . .............  @n_r_ri
-- 
2.43.0


