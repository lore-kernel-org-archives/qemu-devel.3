Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D536C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVF0-0002EP-5z; Tue, 05 Mar 2024 08:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE7-0000yW-HG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDt-0005yp-Uy
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412e96284b9so5839505e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646768; x=1710251568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKoVEk1QGKUdsSjizVrNW7gmKUKZFVK6gFXUR6BEh58=;
 b=BATeu6Y0VC54DjpZRFLbWJ39l61jZff0kQDAA1CPBUOhaaX14hHeMq1eOANBSD29Xs
 d3WRzY7UqgnaJHHtLyW2EPolKbP6vDMCZJ2eTKRfTkGfhVignKvNyttdoxhBOS/W1HtG
 lNmWVpsRgrHpD/WP0Y6SwIa/X15G2JUWNHKY1c+8T6sKlCAan0vIJ2Ib0yNQ1Y9X4nAN
 4QeglGroIxsK+VDwMusQG/6T2/DNR/gtCshzRWU/eIfRI8JL1tFDgRSl0js/Fg0oTnla
 qrRKnPXCrgzfBjjIGFvvX1MlxgxlfhEd+p4tKEaVRP8y1EGqVr4l/NvlUSwxu5y0qWZ+
 Ss2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646768; x=1710251568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKoVEk1QGKUdsSjizVrNW7gmKUKZFVK6gFXUR6BEh58=;
 b=BpkDm0r/mdMX8BnFmVVQh/hYbQ2I8oolZDXMGdHkwrp0aeHKU0gLlGcl2JdKihcI1P
 BYxf+B+k9Y3FCW7KLSEEQ4LF+Mv6hnjrOGZi7Kjza8laKCFewo7HvEX8EASqQDDKh4Au
 ar390woWCMnkhHmdCyKW/XudH1FI+XVmcd2xUoyQ1Yt5mDO2OFUX87Pf+etxcwoaSVnN
 1MQTGV1lww4lAjmuV/TNS8jhIUjdPN97GQC/Pn+0v6UF8JARhIhffvfbZPN6ex+WwUgq
 Gal0DM9p6vC3hJ0wo0+QGimLsLrbmbufqPe1gqyNzAwe/L1dukyVtxV7wM1SJJCj+cvd
 2OiA==
X-Gm-Message-State: AOJu0YyGkJTGiHAcN+2Fw4l9aWNYE21shAl/G7mzPLKSFFPXr0wF+CkT
 z0iYN32C6JrgDewXCAHrGWE3uVsoSNTUbb4IOj94k7mA5XkXcLpPrpcPXoqa5/rjp1NeRfQ/EPp
 M
X-Google-Smtp-Source: AGHT+IHWVPENsp+FqHTt/+V0Hk1m8S4w64ua1aURcp6+I69ON0MaokItvkuljjN+BgOKabkXCl4YAA==
X-Received: by 2002:a05:600c:444f:b0:412:efed:28e2 with SMTP id
 v15-20020a05600c444f00b00412efed28e2mr630161wmn.41.1709646768591; 
 Tue, 05 Mar 2024 05:52:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] qemu-options.hx: Don't claim "-serial" has limit of 4
 serial ports
Date: Tue,  5 Mar 2024 13:52:37 +0000
Message-Id: <20240305135237.3111642-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Steven Shen <steven.shen@jaguarmicro.com>

Before v2.12, the implementation of serial ports was limited to
a value of MAX_SERIAL_PORTS = 4. We now dynamically allocate
the data structures for serial ports, so this limit is no longer
present, but the documentation for the -serial options still reads:

 "This option can be used several times to simulate up to 4 serial ports."

Update to "This option can be used several times to simulate
multiple serial ports." to avoid misleading.

Signed-off-by: Steven Shen <steven.shen@jaguarmicro.com>
Message-id: 20240305013016.2268-1-steven.shen@jaguarmicro.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 9a47385c157..ac4a30fa834 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4129,7 +4129,7 @@ SRST
     default device is ``vc`` in graphical mode and ``stdio`` in non
     graphical mode.
 
-    This option can be used several times to simulate up to 4 serial
+    This option can be used several times to simulate multiple serial
     ports.
 
     You can use ``-serial none`` to suppress the creation of default
-- 
2.34.1


