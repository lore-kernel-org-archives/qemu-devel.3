Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3001ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO6P-0003Ft-HD; Tue, 19 May 2026 13:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO6O-0003Ei-4u
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:19:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO6M-0000fn-Gq
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:19:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso31951435e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779211168; x=1779815968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SDNbkGAV8L05E3KZvjyzK6eyhm862vsX7TnX/7m5RSE=;
 b=A+8/hm0P8QcolNQ+KvwzcpS5Q/IqcD/vcfcf2Z9J7zoHuYNRMVIuUR+Tjkt5kzZ14r
 NrOmc3BPQE8IB1kgeZ/+cflh2/sqmLPIAv2CccCoJPu5qbM1HhRDqg9WwAUzIkRAY6Mg
 5fl8ww/vnEBxnOzLkB6l/vXrYZoABMJcmbgOB033NCoA1nVzOtZvX/5WqXgwDB+5fIgG
 y9JJhytQq3dCTe5Ei6AF95eXzbtsaZFcwqO49CCT1sLkkijDCcbFT38X3o0K9jn3PBjW
 KIBAgYLSlfWS+bGVIUEpCRRazYcWxQImY4XH/1F6MZl1OTBhKIgHRtRoA0rXDUtjRjCs
 FxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211168; x=1779815968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDNbkGAV8L05E3KZvjyzK6eyhm862vsX7TnX/7m5RSE=;
 b=NOO3heZVZK9V2do7xArLLCWUVoLtj8OAPaoLMVLAnuSiGLdrAKGCiQMVHDWg5mbzkw
 7jgrO8pWPKK1CV3yen612Cn3Z0mjjxvJz7ep9rTAJt9cgNPq80PUMsUECUvT9YHiLjvM
 2DsEEyhp3Ru59+KZY6KYUI/hsRCW8m7m6ir9Qr2zcHhRxhsim/TuCDzwUWJeJ9mbpO9d
 Cb3466k/vP1oTQOn1GPU4hUqe5zvPMG1dyKNg0KWDax0dl6E25T0sTE/zJaKi7yVXXYZ
 2o7W8G9ORvLJen2WZZo86WDpClW2Amp4XtWYcNSXs4dyIJNmFJrslfVmPtjCtzWHy4Tx
 OOEQ==
X-Gm-Message-State: AOJu0YzR3hdmK0p21q/5jJDpZVz7uwK/JI/dOuRMpMJ209K2nL/QMZyI
 hHUxGy7dQIL+WkcoBSHeMFQV00iSQ+oJWf5X6e+YP67hfpxXvNFu/5UplfaW8G/mIij7of1G9L4
 /UCezw88=
X-Gm-Gg: Acq92OHoKbDtKCJ9iroAAr8XOj/a8y6xBAwVFIaSHy0gAFWAT8pbqY0/MGzRwR91X1V
 RDBpcyf9LnR0pj/qfKacYkk8n8WPpE7IckWGZQtReJWsRFYSF11fiBEYtkYQ/iO/kPwN1cegjLy
 eEJnI3+/srhpVVjPk9QHSpZ+ATpX15k4Hvt2f8ofSTPjAXozYGw6feHeXlzVXeYLfqF1K1RVeOd
 aW7QGeCz38ONeE/01xn5jZ7MuLUH1x/FsieVacx8HO45cZHLt4i6RGwGO7O+iuHc28gvU3BlHIi
 FiNv1H2V0JJ47Oq1YBeBGn2WQHjlLS8PPSdlkLxl5V40MlNOythxT7u/Ztjpall3EPcHNwhVhg9
 MLNfplX0lSzstdvfg/R8m8Th/WMtYFUsmSWckRhARPyKpQlMW65jX54Y3Tb5SNOmjsjK/WlD5ic
 YMIu0UFqN796fPMb5ncyXeYLo63Ffj6RtdSVEFBT0LJUGLNwrhTHx5DuTfLVKnD3xeeQH7b7Edc
 lm0Y3f6RwU=
X-Received: by 2002:a5d:5d12:0:b0:45e:8547:f214 with SMTP id
 ffacd0b85a97d-45e8547f294mr11179675f8f.32.1779211167955; 
 Tue, 19 May 2026 10:19:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a178adsm49821585f8f.18.2026.05.19.10.19.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:19:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
Date: Tue, 19 May 2026 19:19:26 +0200
Message-ID: <20260519171926.98099-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Commit e804f892b90 ("coverity-scan: list components, move model
to scripts/coverity-scan") moved the file but forgot to update
the MAINTAINERS entry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92b875ddfc1..73b7ebf1d7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3260,7 +3260,7 @@ F: util/qemu-option.c
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
-F: scripts/coverity-model.c
+F: scripts/coverity-scan/model.c
 
 Coverity Scan integration
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.53.0


