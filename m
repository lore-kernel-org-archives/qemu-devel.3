Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C61CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OI-0000DI-Dz; Thu, 07 May 2026 19:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OG-0000BL-MV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:24 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OE-000106-Fy
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:24 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dcd689829eso1261836a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197461; x=1778802261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHaqfL3jimyccNFpxwTItrJ53CxfHkBqEkZT8Php2Dg=;
 b=Qb8laVCvTYG/Bh/JdQ8R0fLdpiLSmxB5cupyXvzF8dhkLNunfpgrXDleaVvbnIJWiY
 CL6MlWnZWU2cgDkuJy11+/Xmuimn3qNLXVcoGeVTJhG5uAsNt7Ivvit8XguoQESxYuoQ
 zWwCSqkV90DH6ORXq0M5uKiDEFHOIe/7Vc8Lw5ZbtDEElb2ITcB2qpkGNp8VcfHq+vYK
 I058zzZW//2aLHiY3fHxR2Yq23tkKjw3chMx7RgwjaglVow1b5JpQpWvbYtv3x+36dJ8
 PVqya97uq/J6vCAQ9p4AUPTP+NCtGzUjwfmeYpy+LpUG0XsoTR1b0y9vdaZtsnyuyu2y
 cyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197461; x=1778802261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DHaqfL3jimyccNFpxwTItrJ53CxfHkBqEkZT8Php2Dg=;
 b=MgBwqwoo4HInBG++c1kw/N0b2Jt+yNlOFFvhC/K7waqKXltiPewhqbJfSV23QykqMJ
 tweu+Fvcz9DB6kfrQMvm40OB9VOoIEEeG65mdAoedrUQ2WajFDZGPsClG1Xud0zPdKk9
 EWoWQZsVdKNZWcejBbodciKAKYeTdIAnHLuP8SorWDHWxCGMAhwNdhi+ocHlyzbZbuum
 p1+2nwcnR0mtAS2szv33E96aGOPTTUgDaR0rffWHwcYRkx4f1h4PbwjRWpbKifPVfEZh
 u3BLSVtY3fVcZ2cR9uKZesUPWZL9AOr6hTnlzE6SHO4GZTOstFLnRgp8/mueZv9nlTYx
 60FA==
X-Gm-Message-State: AOJu0Yx36ggvOlPhcGib+t8TJ1onhWtViys1PtRwiHeLBEUpVqPxZqMx
 PKPlQk4EUTyxKm/+9gnv96H1Unaot00AhxhUv2Q/iSm7DHn0/E/fQ9n+p1JfhEW2eUGeEfh1D4I
 B38qR
X-Gm-Gg: AeBDieuWFoPvpuClGS63NKEEA7/IMyOLxJqS1WVpIHc1RLHhOLK0quVGxA/Yz03WjPi
 5Qs3Hl2qy8LqZQaAB/9gmI7h8Yg3aCgYhKXHd3tUBE7an7ULM3AMs47Bb7tolIg2/pfmH7kdRjE
 i1M4lC1ZHPEPUSRN4kkMfT93DCvVaB9l0jYnC8lNR1NiKQYK2zZxFewtZepZHL7H48VuLYeagLh
 eC+nureTVU5btxixytfEsSN8qxemqZI1KcQApNkiQK8fSMeMrLKElSHMVbkr6DY8MnCKiM/RJfu
 k7L/A8b+mic4G600V7M1lgtqg3geUyq713IaXznogHjvyQdBQLTopmex1LtTEE0ox8PPWmTqHRD
 LfalS7I9NhmBRtlLBbHJAUQO0JaE9NWsNdRkrRuMZeFaxfmFqBqhY8t1P+TFSelbhqTXEiQzRuM
 Jp7UcxBD70AB6GTTs6nGS95QjrFCvN91mXJ1aPfnrhIIdpCg==
X-Received: by 2002:a05:6830:210f:b0:7dc:c926:4f87 with SMTP id
 46e09a7af769-7e3666cef1amr439558a34.16.1778197461427; 
 Thu, 07 May 2026 16:44:21 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 06/60] target/arm: Update SCR bits for Arm ARM M.a.a
Date: Thu,  7 May 2026 18:43:19 -0500
Message-ID: <20260507234413.643512-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0b9755533b..aeba70e6fc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1795,6 +1795,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_AIEN              (1ULL << 46)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
+#define SCR_ENFPM             (1ULL << 50)
+#define SCR_TMEA              (1ULL << 51)
+#define SCR_TWERR             (1ULL << 52)
+#define SCR_PFAREN            (1ULL << 53)
+#define SCR_SRMASKEN          (1ULL << 54)
+#define SCR_ENIDCP128         (1ULL << 55)
+#define SCR_DSE               (1ULL << 57)
+#define SCR_ENDSE             (1ULL << 58)
+#define SCR_FGTEN2            (1ULL << 59)
+#define SCR_HDBSSEN           (1ULL << 60)
+#define SCR_HACEBSEN          (1ULL << 61)
 #define SCR_NSE               (1ULL << 62)
 
 /* GCSCR_ELx fields */
-- 
2.43.0


