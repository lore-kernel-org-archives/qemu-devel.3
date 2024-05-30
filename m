Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A4EC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChAh-0007Bc-Ig; Thu, 30 May 2024 10:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAS-0007Ag-FA
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAQ-00024O-Tn
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5785eab8d5dso1116195a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717080849; x=1717685649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4LCP0TPUvNWs+1AuzrihN13r1C08nRA9emJSD2ibmQ=;
 b=fPZGdaoPx+TaiqaTs6IWgab1GpNpuDvLlnrYcUmjmKNg4uE6J5aAY5is3tYrSAr82E
 wo225/C9mXcJ8a7kExl+KI3Ovm9loe86PMThWrMSfNmEaII5mNHu29aQvqyClnYykOSd
 bIaXdAoxBYW5exps5XzCTX58APgzE7SHCdWXz6eLXI4KlIdOjjTs8Dp6aDQkeAjE4EhO
 Qsiu+vC1qR8aZVvLvhlYsaFXlm2PNOuwH89lGc7MPI8NcgKNzq27tFyRI7V/6iPJ2cHt
 aCP9Qaz9eLqSLNcTt2XwvtwOW+XzVmW0eVvzERDV7knqxYgz5UGaWFc0gBUGJ2uo02DN
 +m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717080849; x=1717685649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4LCP0TPUvNWs+1AuzrihN13r1C08nRA9emJSD2ibmQ=;
 b=WsyLAlRPGiRxS1TYu+o85D5mqumM+IizqXiTHZH1/IxtzdKBrEotQNXM7zoC427Urm
 ghoQU5TEqAcsydevXznV/4Rbjr5R0GEUgpMPuNrur+UTXqt3qoVWIEahghbtGiLmfv0P
 0Qhu/tjnctQZGUvDBli8pDS8wOYR7d8LsVvvKNBxV7e2wHyX2pmdkEXk9yc/K5OthgZD
 7TugXcZNQGsdSVJ9cfv8OyVCmFm4S0SgGwM5o33kfLbjDYa3aByrS6m20zjBzDxRrMZ2
 G0Uj8HTtvzQfsTTijyBjVd7St4RgjbuDklHJkUPa1SKzTCogjGfi+/fatzjdz0Zvevxm
 Q0Jw==
X-Gm-Message-State: AOJu0Yz2h0SCmeU4wZz6AlTrHcmdhi9Ueupg58dCw90uJS28eqrsTURg
 AgoPovJ/YwszLK6kDOu2Y/XLLEYGGQeNVdzLPFoi1KyWAoQ9HLTgx19wfS4oTXyh3sY0aa0lZSC
 X
X-Google-Smtp-Source: AGHT+IHz+K882uB2dlMJu9lMvZu6etAUzdrAfauuxRTDdF8Q8Q8fMSJpPqPdnN6e/+ex+1yAs9EYEw==
X-Received: by 2002:a50:aad6:0:b0:57a:1fe6:d39 with SMTP id
 4fb4d7f45d1cf-57a1fe60db8mr792942a12.15.1717080849231; 
 Thu, 30 May 2024 07:54:09 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524bbb5dsm9907101a12.95.2024.05.30.07.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 07:54:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] semihosting: Restrict to TCG
Date: Thu, 30 May 2024 16:53:49 +0200
Message-ID: <20240530145349.41309-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530145349.41309-1-philmd@linaro.org>
References: <20240530145349.41309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Semihosting currently uses the TCG probe_access API.
It is pointless to have it in the binary when TCG isn't.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 semihosting/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/Kconfig b/semihosting/Kconfig
index eaf3a20ef5..fbe6ac87f9 100644
--- a/semihosting/Kconfig
+++ b/semihosting/Kconfig
@@ -1,6 +1,7 @@
 
 config SEMIHOSTING
        bool
+       depends on TCG
 
 config ARM_COMPATIBLE_SEMIHOSTING
        bool
-- 
2.41.0


