Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2160CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsoX-0003jY-0j; Tue, 26 May 2026 10:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmt-0001QN-C4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmr-0001Uo-VK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so5697898f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805780; x=1780410580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+7f90FAkva5cg6nPQHCs82ewt/oQ5gQh3x0FYc7aFZI=;
 b=q3jyP3qz2VFr8Ju349pIWluYB92vwi9QeOV+zYK8JFCbjFOB+1rQ262mDr444o80V/
 YAJwt3KBUn6A+9VTauYWoxcW3wHM6ujbvf/gsJ/GCpeQrU8YP+Z/bZi93H+PPLKssfAm
 sJBs8XHz/Fg4D9k9I1Y1+Zo8wvorJ8E07NVlPcDCVvle1vHTnPZ9DYfnS8YY3G3PS9Wz
 wE3On3Lo3RZgnSxnWMNoM1zzxk732W01Dm2BOgwcsNlhjBBK8fLXWVMSApap7gn0Axye
 2HdvfR+7LiCoLjNxPuDoH4AISF+pHaDGJXEDl21gindZBTuqeopq1bIzFJo4Xp8VilTZ
 SaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805780; x=1780410580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+7f90FAkva5cg6nPQHCs82ewt/oQ5gQh3x0FYc7aFZI=;
 b=aB5YuJzWl29cYkrio4DTS8A5r6ftgVs5EhvGhWD1HeSvoGboLvf3zc+4KYwUt307l9
 fTorFwtnSrNwLO7e/7ww73fojEH4g6TCkVME/1AwTiDfvlsj7c3E9Ov4+fYgAiTn0vH2
 W/bUFPIbhs4WiJMpfdXlb4LODJAwPz98RMe2wOTpF9fb7sFdVzjfkadscEDSWFa2o05t
 pdT80RLwXjp02tj6iNwnJKJ6ewmhiLSX23oTb0f6OSfIrELR1gn/emno/6SI/ZdnexfD
 aZSk9T6GR2cO4iQF3VLqR+cFwkkbV41yNqA3iLw1ebQM/KQxr1+ZLLzVsYcrnRyEx+Yd
 J01w==
X-Gm-Message-State: AOJu0Yx2UMs142zwLYOhQ/qFzGEddDjVLIr/IESJeaGUs214M2xIpwIY
 UdlmzZ6AeAVoAviMI9vo219JOPEj9Z5M50PQ1dpakFs9YIznshXbr/g17exVG56zRqTL7sEpHnC
 4BDEN
X-Gm-Gg: Acq92OFsP3b107rLyoFl/iU6kSKVxIPnJjZm2eCJGLa9utOzbNJlL1cIQ5ooal8fo1F
 PM3v6Q7UoujICb1UntnaOsZ9N8whDKIVo4yXuFWHf+k7QAmLI8bMG/3WFSTIcKiBuiuux4sug3W
 a1Blq86oWxbMJeHRAnm2HVDZ9qcpAAR+Yfi4zTbJXYqoeIp2sWJlSfS0ZQtgP7qfbwFTB3bRsP6
 nnrHsJ0Mh/hkJcz0fe2YPPJrgpcaJXTpaFh+kNM6tmNUyEr802Y2+w/0o1w/aymZpX1LnLsgAw9
 jQxQ4ouuFOMYTJnRkp8Jbe1HYhtKa+KsfEINL3fRD1xiiAtckjIS3fyMgcI3h3HmojCZE8RsRGe
 Q9S/IMTjhaTbn9N7t3skoihWJxvYlmuEJTkjEl0j9qmvpZm9boWzwZ3NrbBspRQaOOM9R7mzgT+
 ItoXTRo+EinZejjujqhZCPjwodiywymUiRxx/KpKftsA420qzzCKEfMxKhTLwBtwefCv8WIeLOu
 gu9c8J/3Xhnn986qmdUXwBETT+JgALaxBiONVe6Sg==
X-Received: by 2002:a05:6000:4010:b0:43d:7b90:fa23 with SMTP id
 ffacd0b85a97d-45eb38b7b7cmr32864486f8f.29.1779805780446; 
 Tue, 26 May 2026 07:29:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/54] target/arm: Add isar_feature_aa64_f8cvt
Date: Tue, 26 May 2026 15:28:46 +0100
Message-ID: <20260526142850.2326589-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1bb77d78da..1fde3e9231 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1569,6 +1569,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
-- 
2.43.0


