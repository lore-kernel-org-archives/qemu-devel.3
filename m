Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E934FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdA-00018y-Vv; Fri, 17 Jan 2025 08:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0000x5-IN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002D9-8e
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:07 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d932eac638so4156158a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121381; x=1737726181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VoavrIr417Jut4poNQurXRcCbKSqVL6eDWL02YIVTs=;
 b=fFM9F6sPiEcKqKuQ1fOk7rSuVGlisfoSviJegPfsbnTiFbcsB5mK5vZv3g3xMS2LEQ
 pnLORanv8suQ9EmIdmxYigdCuz//+T6VTNjqydoGLiWRDMYJmipxtf6xZeszcxoCQ9np
 ecWnC9LvnWQl+vrMltbN75fKPdj32aEBkesYf8szDxyV3hbMryuTqCpJ9jwvcIEVZ4KR
 OMp/AuGeWwUC0kS9st2Kn/w82RfB0z84B8dfhKoT4lG7xoZs74AvHbKiaMYGlPRqAIbQ
 HDYpfEYLlBw50vNzEYzuV/NqERG3n12MiilQF5OEDlohTpPB7LfH2rqxTQ21s+x6O5Wv
 OD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121381; x=1737726181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VoavrIr417Jut4poNQurXRcCbKSqVL6eDWL02YIVTs=;
 b=W4RLN+N6fS3cLCU4r9lPLilBXmjISgiOUqUpH1ynBMuv2edxjlr1zZJPqQJYPGn+1l
 3D7MMppfh3o/+LGb/Sj/e23sgACvwV6AEEgqyrYZ+Rqh4CHYz7iS9PozXrlK3TYeyx24
 mBD8E7Q+UzYKevEeiOgRyLuonH3zNTVGceTm0opg3bbC6G4ybLQSYwE2ZrdZUxgNJUVI
 YQgJ+ZgAmh+BvXgazej/MO8DTdPS1+1gZUHAKnqSTM0cK5402TRrT0Owr8zQEuSPm/Vl
 e7f/iUeOuaNSNmzL/3WtuZJWUV5EoqXRLkH29JnzWHNNlI4JveuD+4SY5+ms3p4PBkxz
 idTw==
X-Gm-Message-State: AOJu0YyygASydgh/2cTqWHZamB/J97+DLXYw4pHrgz37Rxzc9DFh5GLh
 EQopNGlfxTSaL+oB0i+Az7QjDHDZ+Pii/CbPdFQAk+chAjC+tNsa7nk8gzodxIv8OseJQU5lLKb
 rW3M=
X-Gm-Gg: ASbGncsLVhm+8ds4F1eW7l3iXDZpcstT4HIICyMnO2qOa5qmQE/zaS3fWtTbF0n6Zfw
 WQIklhvmLUzFj4VdWUr/Vf3PEpguOzWG4p5XlvhzsJU5mpo29Y6aTIeAMWLTpP8EevEM4JNg4UZ
 wbl7jH1Nl1OvkNKkZzK5WMNxPCHgv+GVORKLFZt8c59aPaz4nGYmx2teEQgQXdBWjUbDZyER0S9
 DaCEf/h5JbOyGGn3Hw9mSwy3uogcryneMedalbmC5s6E1ygrAfC6Oc=
X-Google-Smtp-Source: AGHT+IGghSK6EBRcnNWRat+qlJI9x6+vfc81c3FyFI6E1VuG9/5l5urI9iP9EofcALk6DD6ZNop2lA==
X-Received: by 2002:a05:6402:2803:b0:5d2:723c:a568 with SMTP id
 4fb4d7f45d1cf-5db7d2f105fmr2103569a12.10.1737121381278; 
 Fri, 17 Jan 2025 05:43:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73eb59dcsm1513790a12.61.2025.01.17.05.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:42:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DCFA60859;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 04/37] semihosting/uaccess: Include missing 'exec/cpu-all.h'
 header
Date: Fri, 17 Jan 2025 13:42:23 +0000
Message-Id: <20250117134256.2079356-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

TLB_INVALID_MASK is defined in "exec/cpu-all.h".
Include it in order to avoid when refactoring:

  ../semihosting/uaccess.c:41:21: error: use of undeclared identifier 'TLB_INVALID_MASK'
     41 |         if (flags & TLB_INVALID_MASK) {
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-5-alex.bennee@linaro.org>

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index dc587d73bc..382a366ce3 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-all.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
-- 
2.39.5


