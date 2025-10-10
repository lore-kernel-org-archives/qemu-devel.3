Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F91CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cqa-0007V7-K7; Fri, 10 Oct 2025 09:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqZ-0007UK-4i
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpX-00041b-0f
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1246512f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101598; x=1760706398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ybBv9KOBzW217hlkvIBBA2/Eg2OPOW21VAjC0SdENbc=;
 b=EL7gwidMZsxM0ZDimiA/aUP82jkiUlQsrg+nQKdwtxOP3gEDuJjSC1LuQUkmiguI9a
 jrFcU+EG1szhIy17Mjzje5sH2Bmf9nPX7Nclgw1BYHScboHfoRD7FDBalhWbbNy4vJO/
 dz001lQI45DPpRBzO8n87phCfk/x+lFtGFIEP6V7WlBTgldO6buglFZfz6ltDZPG8sc0
 QlWqfb4+a6Ggfm8i4HrW3ZE0A4Xs3AE2TOlllU5K5zpO/NN6fl8uvUl83KFNdufVm3ME
 ZQ9sqSQHqRN1OT3Yy5FCiAFvEfQzuini3UwWpkJZU7PGO5TwJwVu9UgT+c0kk4b/S9Qm
 EnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101598; x=1760706398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybBv9KOBzW217hlkvIBBA2/Eg2OPOW21VAjC0SdENbc=;
 b=YnvRKAV0wBK/cHSx4EgDCDRU5EoBJpgioeisCJswesagYOheIbZNy6APnOeXBjGrMX
 lNJnBQxomVezfz7I5t6K7CVA1oxQJ/oAS17cGVbpSnVi8YTG/ozbipz7JHU74BCi7Gs+
 R7cNzgAYoT3FjG0z/rRuScHcYtMpWvXujL65IVx0VumPXBY96aIsfzvvmd1A1Q4prb8t
 /zBj/O0HOfWJbHemZXsTxfoB1e9dCwFr/wHwHmtwAXhhCI8v5gvPDiGzGZTwFmMKSkZi
 Wq3o0WrUR1yVE4KQro9Erjr/n8zLZYI2lhdlPGOqIZ4WPBpdUS7tWzCQOValaeyJxEYu
 ue8Q==
X-Gm-Message-State: AOJu0Yykrnt8bxqzg+ckU+PKHkzd4o2xGdvA1lPJgoRQwNeBMBym3Uiy
 9pHcQJ54vc4JugWOHGUhwUilfzwVFVj/o7zW1NPXCZgPtim4GGfXWca4LyI0I1llHzqfJ3VsPdT
 aPgai
X-Gm-Gg: ASbGncuHoP0LXpfxiXhlNl95mL9t43VTfiRxcMUB3d+kkTVPjB7RwMPj4+28oJCplyb
 tOr93Ckso3+QfWzHSSsZ/yDszlYqm8cspbyW2FGej3QZVrDTYCMmAptVmJ9PTHxdygX7hxVZ66c
 aBdiKhQeCbuKo/VbUVvceg8dS3I8XIE+8BkWTAMmS9PIFpJJBQfKl0DkcFqEUzlJlRoxZ6z5/7H
 eOLaL4QeXJNTbtSPXHwMRHy12whATIk2j5GpdLh0HujkV/vGdWrXFQw77XulDIhO6SO0aQp6agJ
 65F3J2QfCbuZVH39/AjY45R2rpEkE3qmmr17JgsMq94kDJ1MINV1PjJ6hGTFiGyVWrPz9zgebMz
 /wWYGy4cQOxTQDxNEHLgk5uBkFqiHgROSbtN2PPHB3JU3OO6L7gc=
X-Google-Smtp-Source: AGHT+IGhkyWhfevfyXOtQo41Lk85uItDkEIDS/2RSwXF5m+hfJz4YeFs11yPJFrtCpiF8dZjGBtMVQ==
X-Received: by 2002:a05:6000:258a:b0:425:8bc2:9c4b with SMTP id
 ffacd0b85a97d-42666abb51amr6165395f8f.6.1760101598428; 
 Fri, 10 Oct 2025 06:06:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/76] target/arm: Enable FEAT_GCS with -cpu max
Date: Fri, 10 Oct 2025 14:05:13 +0100
Message-ID: <20251010130527.3921602-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-63-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 68d9a4e7342..4496178c48e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -73,6 +73,7 @@ the following architecture extensions:
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
+- FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f024db1d29f..cc42dfdf561 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1280,6 +1280,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
-- 
2.43.0


