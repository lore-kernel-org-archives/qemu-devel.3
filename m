Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF73C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr6E-0008Io-C7; Fri, 17 Jan 2025 13:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5n-0005zS-Fa
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:15 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5i-0000Ig-Cu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:15 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so3314930a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138549; x=1737743349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUoH6IderpX2SkSnRqodXnZDFZwnaaVDcCqIjakkjh4=;
 b=W5nStGg3aN00ZrdNnOXMWmUVqO1min0JvFuI9UgXIIpmXcT5TEpLIlw+EA9Ts0mDn6
 Xe9F6POmAHTQXX/54o2zqbMetPt6PbVzMF9IPT3zKQ7EAwhuYpLkPsflc5G46wmcMAB/
 T3mGn7NngNVGT+A08RWsvWnkwxFjt7Ah86N+/NyRbCjackYM9Cd55KXEi98qnCiwP3vG
 99/yAmTTzfYsKuyrhgQ5CyhzOYwR0thOOH3h41yhTOY9GvNy5BXqI0kEbgAXJozDSr7y
 KGOCwo43T83ARVghXZ7rV8xiZkmHTwtb1L5G4B1/OxN921BYouQ9TbFjjGnlT5dfjWBo
 wEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138549; x=1737743349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUoH6IderpX2SkSnRqodXnZDFZwnaaVDcCqIjakkjh4=;
 b=YdRyp1RalFyFkDl8EccMwN5GcY0Y8b9sja1E6vJExC8hgMyQF5ROn0rqqp5qbFTDCm
 TS5/ikDk3Gmm0wylCiCdtocxuNRR9+EOJD+GmFEa7cuEndcrhhKozbcUaDEnb2+sXL3c
 Z12VqjXMFH77IuOQA2P3uruL1V3nH9MvW0Yhmxk2baEtRMphab6f44XyTjPDrKy2jgpu
 e4Te7jiFmQHYpZRMO4LVo/7PHjHqksf1FABVrcbhp/KEAiW5VWezqr+61M1EfrbJSugs
 JTkFgEhwXmYbyIyTvzmUhNBMKIYnkBmMsc29IiTmE2pm5vOoVNmscYTytqe6+Y7QwGW/
 tfew==
X-Gm-Message-State: AOJu0YwvQbqZmgjLvnIZiXyiTQvs1pjp4h+Y4jUEexWlb5XyZVcxn+xi
 8+6HPFcBDkLVbnXmuXsyoOo/Wi8NtOcLAwxIUgkATWqNemwORkg9Ks55SZZ6bCLN8YrZ8bICdQg
 O
X-Gm-Gg: ASbGncue30Pg07EcoRGqArrS+kq+u3kvL81Mo/2i1aUAMe+39N/Dt3/Eq4b4eRHTpan
 SlzlJEtE3VwXwvOsXU2a4BHSTSIstAUIOkRgSxSBtm0BuTm+9HZhYqFPHNZ1jJASZhfzROZY0bD
 IPyLevLjgI2Gy9Jcx12H/FTr++EWD/bX3ORVikjrzND0gOkBAELBZvAHSGIUmmEIMSHbb1XrE8R
 xkWBbkxhzlzIjAvdz6woMNGYOprcB8T4AUfEDmnQaJKglgVTph+lOOH8azT+DXL+Gm8i9Prtqg4
 4DWCgXSuwC8KeJs=
X-Google-Smtp-Source: AGHT+IG5ZxpMeHB+t68ZflVy5z2SeY9Am+MpeeqtkVu1f+Vfhoc+O5JsoGOi6WqDdSt+BWgmBf/q+A==
X-Received: by 2002:a17:90b:51c6:b0:2ee:fdf3:38dd with SMTP id
 98e67ed59e1d1-2f782d38454mr4343574a91.23.1737138548711; 
 Fri, 17 Jan 2025 10:29:08 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 59/68] tcg/tci: Provide TCG_TARGET_{s}extract_valid
Date: Fri, 17 Jan 2025 10:24:47 -0800
Message-ID: <20250117182456.2077110-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Trivially mirrors TCG_TARGET_HAS_{s}extract_*.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 3397403910..2f45ad614f 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -80,4 +80,7 @@
 
 #define TCG_TARGET_HAS_tst              1
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+
 #endif
-- 
2.43.0


