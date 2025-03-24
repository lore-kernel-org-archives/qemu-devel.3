Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B956EC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewm-0002wG-6w; Mon, 24 Mar 2025 06:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewS-0002ld-Hn
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:04 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewI-000719-JE
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:57 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5bc066283so6100477a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811709; x=1743416509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anRXtUlHElY7q3eBibps8zhum/h3zcEOqynU32vgNmQ=;
 b=Mjk69l0DtWRbb5NyH/nSmM5U7TpOMFT7ZSgR8TrnB/MSdmace9C5GfA9haVMDIOcga
 z3pPrqsM7AfpwAC64gT8aqCZh3R+21xtT7lVBmuYwZovMUQGbV4IZasrDooJlGdllK/H
 TJ9DLaLOlZgh6bK+gBJeJqg4b3xMxQG9oltKK77pqscNmMZ5VhP02+qge/pJQF5vM3wX
 UvBdWFDql/qLAGlxIs3CVT8A3LTAsqPAbHQHSXiTbeAirmLTlZC+8ldeY9fTKPZYHh8A
 /Z3udvgQxNZL9twFWIKnklyi28vN7TL/WtpHFVZdVzFwVvDiqZdGI9rDVolESFakt+xa
 Ufjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811709; x=1743416509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anRXtUlHElY7q3eBibps8zhum/h3zcEOqynU32vgNmQ=;
 b=tZfKGOm2+pbvjsVjWwpv/dDxkbbjAM1xzXXBeBQ4vnCzjo4BKIzUaOf7i1isD9n3t5
 qr9lw298uRI/4uDTItQbZxZ4b9eM1mD7o9JKuUTLgzk9C6BP2x+T/RuV51ZcFvQKR7S7
 K29/AjxnbHvf2p0P+65+Pa5FnOsG7maVNY5i9UhyU9vQzyhpvob4CyM3Rr5cr/iD3oOE
 6jwML6541/rdtti88U5/sAQxAsNqin2kqZojSxIWsdB1Qtwio3Z0XgxpuKfYKoHgiQHY
 ipv1vG1QLYdbh6QyNfe/HKRemqXaShVr7nrUPtjkUArBPsHZUK4mJezPa20UdynUz1XL
 L2pA==
X-Gm-Message-State: AOJu0YxRJcCEqLlC8Nv/TkqWVI7F2nA6KZpACh1qhoE2JU4Wm/ckmMh/
 6g0lzjBKoROEjecMzzIumAcsTFwPTVoZTJXemY+tJWrtSPJ/uiPbHBXlOn9E6wE=
X-Gm-Gg: ASbGncuHyXgfpfLO+UzzMJw340SvoxlBKUNAgh59/xHHcsQQ3dmXKejq0JtDg5DPL2A
 /kzFuyxyIkAqGoqP6O81FNOuHz+VtTjF1uF/iqDnQZ42Lgv1DcDGfsJLQV8miNT7madOpL3Kd0o
 AXSEwjc9UBBF3vU5J8/qgUpCaeZhs1FQ2qaabEQ5xSiOUwdUCZ8W66936rcNaC492uEs0f7EKww
 gldJ//EeW4pQ+m9iVjnppjG6UmbrBRY/kDIlHZNRA5wtuSu0cZ297gMft1Bo0uON695R87w7XHn
 tGoD2ak+E6fO+IQ6r99NgBkLC2FMkkIdRumjjubqEbjTmwQ=
X-Google-Smtp-Source: AGHT+IFOtION1xBThZUSS0Gi/bW/CsiHB5vJFSHH7hDjp4LaP6NYiBydytfxSLpMaxDcS97CrVw1tA==
X-Received: by 2002:a17:907:2d14:b0:abf:75d7:72a2 with SMTP id
 a640c23a62f3a-ac3f24ada3dmr1066907666b.38.1742811708863; 
 Mon, 24 Mar 2025 03:21:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd47f39sm642345566b.169.2025.03.24.03.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 457295FD05;
 Mon, 24 Mar 2025 10:21:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/11] target/ppc: expand comment on FP/VMX/VSX access
 functions
Date: Mon, 24 Mar 2025 10:21:38 +0000
Message-Id: <20250324102142.67022-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mainly as an aid to myself getting confused too many bswaps deep into
the code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/cpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index efab54a068..1e833ade04 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2906,7 +2906,12 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
            (start + nregs > 32 && (rx >= start || rx < start + nregs - 32));
 }
 
-/* Accessors for FP, VMX and VSX registers */
+/*
+ * Access functions for FP, VMX and VSX registers
+ *
+ * The register is stored as a 128 bit host endian value so we need to
+ * take that into account when accessing smaller parts of it.
+ */
 #if HOST_BIG_ENDIAN
 #define VsrB(i) u8[i]
 #define VsrSB(i) s8[i]
-- 
2.39.5


