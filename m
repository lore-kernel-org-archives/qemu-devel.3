Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9929EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZE-0003em-KE; Fri, 04 Jul 2025 10:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPN-0002oO-AF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:02 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPK-0001br-8y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:56 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2edec6c5511so332951fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639333; x=1752244133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4S5DImbXjjY+eFLsTDqYqykqt+YEQuqnqHK47/Xsuvg=;
 b=SoNQ71BslvopJNP6wpLo4aRpK+kVPxv1p7u0uX06msz7zNz0C2ipBhITp/2X0fXaCx
 Z5M0wqZyUzS8KoMX53vgNYf1Dipf5ovwG5IvYeU3KkiyOyCSqjcvIo9ln28uvo9S6MWg
 qfD6+XWdCoUeX1uMJz/dzaiYOA5hkEzjuOf1MIw/M0P/XIyba75neThrRohRPpuatMgU
 umM7MIjBXjLIuG5Ofp7+z/il5lwSNl40JaGbqxqeRlrwJcwOH/32OXnOdNcRRFrr0zwy
 pX2E/3bjs+xwqtf1f4e7OeDJtoZEs18m0gmGDAb39NaCfQn4DQixzfR7+JADsrLsi7bU
 k1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639333; x=1752244133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4S5DImbXjjY+eFLsTDqYqykqt+YEQuqnqHK47/Xsuvg=;
 b=K7vY0XYwAj7JJYxMsFMBdCfS9KPnijU2Af1EqbGmQ97iUsSpDLwqMX+IWTV3XFbkzg
 VDBeDyuLybpQiLQGffpomCoR4E1Zw461J6mtZVpE/orkRDZ+WTMglRpuz9Gl/PqmYlql
 zLL6zwIrJr873xAZcZkHHC9JNxZxhza7kmgiw7SsSh36t2a0jDBfKg2LiCcACM4De2pX
 Ral3LGlZwVYQYnhY4R3Hx6wvnBqvW3myB9HrVknJmgZx084+H7RSq0RPcA/jDmGdVsnc
 nMV0xzg++WTrsFMBi5zpvGNnG2n3LMAtATpBgs4SqiXF6v0ajaXcUksMQHSNg3LfmaaS
 ZMGg==
X-Gm-Message-State: AOJu0YwSCVWMPKHfnH21ZNvjBx8+pH72SF2oAtQDS/iQeo1e909WGEIi
 giIH1leAG4q/zagbmwn9JM0Qiu2r1gjYGL0H0c230+0emOnC1/2ERCdOj9uj2MQYKI2BPwnLHQl
 9lUATS/E=
X-Gm-Gg: ASbGncsZmWi9rIw7zHAeSdUoiZbb1tPTO+yXoOsS5V/QeONoc1ia+Rcimmhx76nPhcL
 A7f1o9xiVexZhD4ZhpBncK5iBLGihxOuwQBxNmiAyHW2yAmqxXE6a9yfYESQd3V1adfRSoNmEAF
 ZMlDIl6MTD8RsgnmZBroJteNmk4Jb84lzAVv6v5GyEaztgRcdT9qMHG9IpHZ/7wKckifsQafvyc
 W5RDNc91kQlteLC+qrY63eHenWPV3CUkqmN23ye1O5xY6F+xQSaWqBP5hrQtTaC4YAKtH1OMONS
 ORFRK2BPP/g0UleaahJEzbOiD6xIdmKw+2GNdqp4hCFMYFyp5zF83t41SqndpB/VXnOF5uls9Sv
 Vu1nuRbBPSZiF/Q0mY1bbuWh676/dlurd7Ld4Z6B8kK5Pzanx
X-Google-Smtp-Source: AGHT+IF7znS/79boWlSSG2fV/KDTrZn6U745N63XCz9qtO9xpg4fyywWik8li9Ba7MopFkX/VrvDyA==
X-Received: by 2002:a05:6870:2150:b0:2ef:e34c:e4bc with SMTP id
 586e51a60fabf-2f796c1e893mr1680097fac.25.1751639332594; 
 Fri, 04 Jul 2025 07:28:52 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 094/108] target/arm: Split the ST_zpri and ST_zprr patterns
Date: Fri,  4 Jul 2025 08:20:57 -0600
Message-ID: <20250704142112.1018902-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The msz > esz encodings are reserved, and some of
them are about to be reused.  Split these patterns
so that the new insns do not overlap.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve.decode | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index bf3d4f4853..7020771898 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -252,7 +252,7 @@
 
 # Stores; user must fill in ESZ, MSZ, NREG as needed.
 @rprr_store         ....... ..    ..     rm:5 ... pg:3 rn:5 rd:5    &rprr_store
-@rpri_store_msz     ....... msz:2 .. . imm:s4 ... pg:3 rn:5 rd:5    &rpri_store
+@rpri_store         ....... ..    .. . imm:s4 ... pg:3 rn:5 rd:5    &rpri_store
 @rprr_store_esz_n0  ....... ..    esz:2  rm:5 ... pg:3 rn:5 rd:5 \
                     &rprr_store nreg=0
 @rprr_scatter_store ....... msz:2 ..     rm:5 ... pg:3 rn:5 rd:5 \
@@ -1334,8 +1334,16 @@ STR_zri         1110010 11 0.     ..... 010 ... ..... .....     @rd_rn_i9
 
 # SVE contiguous store (scalar plus immediate)
 # ST1B, ST1H, ST1W, ST1D; require msz <= esz
-ST_zpri         1110010 .. esz:2  0.... 111 ... ..... ..... \
-                @rpri_store_msz nreg=0
+ST_zpri         1110010 00 esz:2  0.... 111 ... ..... ..... \
+                @rpri_store msz=0 nreg=0
+ST_zpri         1110010 01 esz:2  0.... 111 ... ..... ..... \
+                @rpri_store msz=1 nreg=0
+ST_zpri         1110010 10 10     0.... 111 ... ..... ..... \
+                @rpri_store msz=2 esz=2 nreg=0
+ST_zpri         1110010 10 11     0.... 111 ... ..... ..... \
+                @rpri_store msz=2 esz=3 nreg=0
+ST_zpri         1110010 11 11     0.... 111 ... ..... ..... \
+                @rpri_store msz=3 esz=3 nreg=0
 
 # SVE contiguous store (scalar plus scalar)
 # ST1B, ST1H, ST1W, ST1D; require msz <= esz
@@ -1344,20 +1352,22 @@ ST_zprr         1110010 00 ..     ..... 010 ... ..... ..... \
                 @rprr_store_esz_n0 msz=0
 ST_zprr         1110010 01 ..     ..... 010 ... ..... ..... \
                 @rprr_store_esz_n0 msz=1
-ST_zprr         1110010 10 ..     ..... 010 ... ..... ..... \
-                @rprr_store_esz_n0 msz=2
+ST_zprr         1110010 10 10     ..... 010 ... ..... ..... \
+                @rprr_store msz=2 esz=2 nreg=0
+ST_zprr         1110010 10 11     ..... 010 ... ..... ..... \
+                @rprr_store msz=2 esz=3 nreg=0
 ST_zprr         1110010 11 11     ..... 010 ... ..... ..... \
                 @rprr_store msz=3 esz=3 nreg=0
 
 # SVE contiguous non-temporal store (scalar plus immediate)  (nreg == 0)
 # SVE store multiple structures (scalar plus immediate)      (nreg != 0)
 ST_zpri         1110010 .. nreg:2 1.... 111 ... ..... ..... \
-                @rpri_store_msz esz=%size_23
+                @rpri_store msz=%size_23 esz=%size_23
 
 # SVE contiguous non-temporal store (scalar plus scalar)     (nreg == 0)
 # SVE store multiple structures (scalar plus scalar)         (nreg != 0)
-ST_zprr         1110010 msz:2 nreg:2 ..... 011 ... ..... ..... \
-                @rprr_store esz=%size_23
+ST_zprr         1110010 .. nreg:2 ..... 011 ... ..... ..... \
+                @rprr_store msz=%size_23 esz=%size_23
 
 # SVE 32-bit scatter store (scalar plus 32-bit scaled offsets)
 # Require msz > 0 && msz <= esz.
-- 
2.43.0


