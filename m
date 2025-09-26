Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5201CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298Z-0007Sk-I0; Fri, 26 Sep 2025 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298T-0007JZ-PY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298E-0005fJ-DR
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1874772f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895739; x=1759500539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khGd2vyM0LqffZpI9eeao31QS+mzqXWFdrP3S+/byUk=;
 b=a2d9FwnH66FQnQvFi+TlDOaKjwLpHPQm2BTDhb0XtKpdlQblEmmT65hrXqQqp3ZtbP
 uTwAwzz4yar4NCl9UPILRHzM5rD7mvaZIX6LEdded1Rra5gnbnhTZth/Jyf8CXGspVHc
 aLJzMSbxeApKgoPXTgsx8zieRw6kruPbzMlhu8XOU0XV0B5DLQJXDL3pYJO5b6uf8h5Q
 75JVed+yyvfFDHYCqylIHPBa7p7FjBRlRNIjPTvtivElb9y0wEt+jcaEfo7wRVkWbmq8
 ttEw8h00q6N9mfHz0sIkpmqfFGNZKJ5ei8Xaar9xTYjs9yhy1Y9fJyDKrrFPlgcgJl0x
 HMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895739; x=1759500539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khGd2vyM0LqffZpI9eeao31QS+mzqXWFdrP3S+/byUk=;
 b=rCLajvcfgQS0GqPsTpCt9bKpOBEn1K39BEzcn/4D9/4zL/b4OS4D/dDdcv+n8YccWb
 o4rWySin4Fzox0SX/9uZAADcgHp1jeGEIh/LbaasA/MohnPukPFizqrcE+s17Gh5GGhN
 6lK/rC7utjln/Ed2rWdhK76PcQE87xUqokzdpoY67p6nCjobW4Re7hSSMKmGU9crX1F1
 8sSsjBTw6MgNQMhGIDPfaIzt1pVEhMNrQ1e+o1awLEDdodDADq9Ra+znTEES32PBsDda
 bfDLaF2ptLElEQiHxmTkRh8vss4lfMKMPqeHFavuKMLDP8w+onOHWMitj52ISW62Yy4G
 FX9w==
X-Gm-Message-State: AOJu0Yxw7Zqn0avAFD6nVPipOT3r/CD+jj2Y1rxOu9VXDW/2l2KQu1Eq
 EW0R1cFlLlQ0891X3g/noifQ5tnksPBpYfEQrco3h2v4zfujhiRtXAEUHdTiMiqlHdh3Qgm5RTx
 IJ3jb
X-Gm-Gg: ASbGncvZeZz48qZYiyPOiMRqfCJfi8tdILje8SylnZ3NGyajJD0kSD6GlD8VsulIve1
 iGJDTTuM7lwSwZf6e9Pm22eNU0PACrhgNpB4aRY76ri0sA6+2fAspqF93F2WUa11xgquxyYd3vB
 evkMyXDX5wK/0onBPVm1RiUkpG4GEKCkfQhsn/wb4lyVL2wkFJ0TMarpkvWUlZjnVW2raGi7+I6
 zpAo39hpph/4yVcoOFa+QPpWKN4j5K0n+rizEItgxwhMgczz8o4ohENtk0RSSdXSN88eHka51yL
 Ar0Zzi2o0h5R9k3j6yOpR9WtlO8rdSMMiSyTJRiFH3s1/cdNumU1Bk+9AqiXTjtPHINIaeChzyD
 eVTi++6J1q6hP0XFwAVNL78EiYVBBlXUblaanJekYn3/q4Jbh9w==
X-Google-Smtp-Source: AGHT+IHslPOYx0lwfX8wo0b/kTZjIkOZ2QkWI8vmlCmLEw6vmluthLj8heE3PzcY/gSzqXQCkSdb8Q==
X-Received: by 2002:a05:6000:40e0:b0:3e1:9b75:f0b8 with SMTP id
 ffacd0b85a97d-40e499acc26mr6216180f8f.47.1758895739173; 
 Fri, 26 Sep 2025 07:08:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/44] target/arm: Use raw_write in cp_reg_reset
Date: Fri, 26 Sep 2025 15:08:12 +0100
Message-ID: <20250926140844.1493020-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Reduce the places that know about field types by 1.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c65af7e7614..91ae56dddb2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -192,14 +192,8 @@ static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
      * This is basically only used for fields in non-core coprocessors
      * (like the pxa2xx ones).
      */
-    if (!ri->fieldoffset) {
-        return;
-    }
-
-    if (cpreg_field_is_64bit(ri)) {
-        CPREG_FIELD64(&cpu->env, ri) = ri->resetvalue;
-    } else {
-        CPREG_FIELD32(&cpu->env, ri) = ri->resetvalue;
+    if (ri->fieldoffset) {
+        raw_write(&cpu->env, ri, ri->resetvalue);
     }
 }
 
-- 
2.43.0


