Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C59C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVdZ-0001fo-4j; Tue, 04 Jun 2024 10:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdW-0001dE-Oe
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdU-0005CN-5m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35dcff36522so1041454f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513178; x=1718117978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qo7bOaIzAQcUzkTaJnx0P/HxkSLlV0aDBbgft0XvoY8=;
 b=Msf2B/y4MadzJZTbQu9vDXvd7G4/C9mPm69CPdW+Ty/QpALBBCnrrF6MIasfc7rhbx
 uqcMbRF8dphNKlE1F9JJrLgGtxW5RufQkVs0C86zdDVjTg4iUma6p2kURvgMqgr5U58c
 37DRmWiejKDkhpjvkPIyw4QMBxs2Qs8Mw+Z3FBxAPh7KEIiJIEUpJ8elv4xDELkgNy24
 syJJoHxIj51NeHiRCuaONwujIJR5EhC+Rt1HgzSmTIgA4K6OEDGALTqj9TngWC9WSTIE
 W61w+WPJxm3+JQFnKSi5a1eIVnAbEbJvNjnaV299fqyBti3LmirChIrhQ+PH7YdqvuTq
 b8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513178; x=1718117978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qo7bOaIzAQcUzkTaJnx0P/HxkSLlV0aDBbgft0XvoY8=;
 b=uio8M9MWDmopRZZKTY446cPBC/bcbQUkiipwva788WgbbBiamgUF6pw6usZRFgVwYO
 AmbmFvyu+fbLsFka/Mz62xBKQ7GofvPoSc+c2SM69k+GQU4YalEC7ERkn100SnIk/RtF
 8xqpxZTB3fu8Tbux+1Bh3YsnZ/AsfS8rv0BrKXCDTh70ZDzn7v3yhotVlpZGb6/uhQ0+
 JvkzbdFbCcFjwyL+lI5mB9P0swPdIuY544H0Im3gxQmnHUmpONz25jWQIGNCww9NlXEO
 E8Lp9LlKZcOyaKMdVzUO2HDrfD2SVJ2zZRO5pR8yEiCN/ZuHpnJZclr1oc65hVo2K7as
 7CsA==
X-Gm-Message-State: AOJu0YxjNYr9iueh86oIuRpFpgY+r62qasy1RLUuzruD5rskDwutYKz/
 DlShXEt5CdTeePECztodieT903a02CF/a+dAC/1kIPPBQb2pznJ6HnH//h6frZnL9b9s/ZDwdIU
 Y
X-Google-Smtp-Source: AGHT+IFeVxgZ6cebiGI9HC34MEh1jNtKkFkmWbRmTKhOkXDPE61TGy4N2ca1XU0Sz9b3J5Ef8nTklA==
X-Received: by 2002:adf:ec4c:0:b0:35e:8333:28f0 with SMTP id
 ffacd0b85a97d-35e833329bdmr153368f8f.28.1717513178311; 
 Tue, 04 Jun 2024 07:59:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bbb1sm11767869f8f.101.2024.06.04.07.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:59:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/5] scripts/coverity-scan/COMPONENTS.md: Include libqmp in
 testlibs
Date: Tue,  4 Jun 2024 15:59:34 +0100
Message-Id: <20240604145934.1230583-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604145934.1230583-1-peter.maydell@linaro.org>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add libqmp to the testlibs component.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/coverity-scan/COMPONENTS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 3864f8eda07..858190be097 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -154,7 +154,7 @@ sysemu
   ~ .*/qemu(/include/.*)
 
 testlibs
-  ~ .*/qemu(/tests/qtest(/libqos/.*|/libqtest.*))
+  ~ .*/qemu(/tests/qtest(/libqos/.*|/libqtest.*|/libqmp.*))
 
 tests
   ~ .*/qemu(/tests/.*)
-- 
2.34.1


