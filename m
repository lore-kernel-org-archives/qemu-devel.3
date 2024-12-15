Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8950E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwW-0001Kz-AY; Sun, 15 Dec 2024 14:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwT-0001J7-5a
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:13 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwR-00017a-9u
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:12 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29fc424237bso1650867fac.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289570; x=1734894370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlAoTFD+08/sI+8RxL3MBAcylSFIhB9jm1qQSnpdSj4=;
 b=gnRGo7VQhnL7BZ7HmukjoP+fj61CCYSX4Kp7eC4ErE4kjKTzLYC8VdbNEIYM4Fvbgd
 0vr6PE1iHXsxy/bnaIWab7cZ3pLW1rh4ZtUmfpdTbfdbIHg3qciDNJYD822nyWut8u7T
 uV+EcC3mYPJ7S7xODjDLX0cjG5nmphUE+38D7nkq3N4kbGhMTNJ0gNeMRiietC8A+k+a
 NLsIirZWSjLA+mCBTdYOH7eIAGh4Sydaw6oO3d5ceBsvvkkOikNPr9YYVI/7doQgz7rZ
 EnlWarwdMPkCqyP8mncW9h8FxEmYI0Rw8U5mq+P/OaHrwYhw9hCkXHfHU124POeuGJR4
 Mx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289570; x=1734894370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlAoTFD+08/sI+8RxL3MBAcylSFIhB9jm1qQSnpdSj4=;
 b=vYL78q3wd+QwZikAk0MlpIvF3S5CRLHg2/+tlsuSp3zW4DqvAR5NpSj0mXL1/6Cefg
 zaXArpPPkUl9M+cXftm3xkfsdGDaiRS1YghgW2+pIM1MJ465ry6zauW2+T8zkDNRwyo/
 U7sVWek4AC38eMbDpxdxayaTxZptoTZCU6z4DANm7lHm0piZpKbEQAufo7q3I1sv+paG
 na7ZDVvtaT7oufbBYPnx843zzmGXU11gDq1ATQZ+h36B9lK/1YrT46MQX70T4JNls/He
 vP6hz4oVKfhPmTWJZi+xz8x6W5+yB5rpXS3/DhKkST/+rCmAIh7sGR5Ef8Q95KcFglPx
 5QAQ==
X-Gm-Message-State: AOJu0YxAzEezc0YrPnDlpa2MiZyZd9kUCyrlrVNct5PTb6XFCz2kisRd
 8fPRM/ODgR+wiwtPCnCkXJEGhUqo4ZlO+Xo18UOWWDbbD3Ou/OcD3+9MS0ucWLfxaQqWe60b8ux
 2OTr9BZ67
X-Gm-Gg: ASbGncssTMWJOfHPHGIMymbVHdGo8IEvP2wUsOgk7LMWFwGi6FKkwt2s4kKMdKNn7JG
 OjbaFD62Lbb8wRdXawLnn56/5rVe4SVIRGY2hsAyRlX9MhHYlcyfRuhxOAaSKvs66si49WAJDXw
 DUqQlQ4jkdRHJq8DqqeQD2YgxEKiiA0+89y6k4ldVc6MXb89s8rcnzyHygtAOs73OmrTPbCnn9G
 oE/bveWhcEOYpsayx9cpaYHHsq4GCBn36BQiX0XwqsAILckpe8YAQLk4GehLnrTfu1XpdLsOpzr
 ioOW/70xM6Pmu22S46DWvJWS3SxkOiMUXpAgk7ukSP8=
X-Google-Smtp-Source: AGHT+IEGZumyOGcggsArKLhsSjq1xvxsthXYALlpPfNS/YswWe1vZi3r2Yy9WShlL6cSnitvWYy+aQ==
X-Received: by 2002:a05:6870:ac90:b0:29f:df27:8b80 with SMTP id
 586e51a60fabf-2a3ac6ee99amr4776591fac.24.1734289570275; 
 Sun, 15 Dec 2024 11:06:10 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/67] hw/cxl: Constify all Property
Date: Sun, 15 Dec 2024 13:04:48 -0600
Message-ID: <20241215190533.3222854-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/cxl/switch-mailbox-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 4f419443ab..3fde0f8aae 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -65,7 +65,7 @@ static void cswmbcci_exit(PCIDevice *pci_dev)
     /* Nothing to do here yet */
 }
 
-static Property cxl_switch_cci_props[] = {
+static const Property cxl_switch_cci_props[] = {
     DEFINE_PROP_LINK("target", CSWMBCCIDev,
                      target, TYPE_CXL_USP, PCIDevice *),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


