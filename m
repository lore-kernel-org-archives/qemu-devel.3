Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20589C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJLy-00028L-Qf; Mon, 13 Jul 2026 12:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLt-0001y0-ED
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLq-0008W6-S0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so647555e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959469; x=1784564269; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yuKvQNCVu7vCIqIAJjuxWt6qOmBbIcHDupP9RUnsLC8=;
 b=scFEAJWuWe90vZYPlbkJTLhSqw2/I8HEUHY8LDQSM1Lh2Nyvlt+KOyiN2ogykfczkr
 FDUczJDEmRQRT4XlgU2na5w1uUH8PWAR6oiHHUSdqqe3om5NPvur+UtHenkekeW2rnrR
 gO442CWuyTGsJQTtR4UlOaPnj5BdZRuFkIFDegt9tmRqr1uoMAfqk992VxNLaL+CJndy
 tEnhU1a9ysMh1a/91RVwS16/X52fgi9xoJ30XcIyP78z/44WzZ8P5ypfYxTMsOmZWlBw
 9MgLGMdWezbHetYqfzcI2DJuNVYwUVxtJreRAVt/WSeiIz9BKUeZNnStiWLUNhJDZvBt
 zwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959469; x=1784564269;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yuKvQNCVu7vCIqIAJjuxWt6qOmBbIcHDupP9RUnsLC8=;
 b=qi0xH5k/AR+3tS7Ul7QXOjhY/O6X21zVLeP7xX4ZAMkM2PVcAoc87euRhEY2QljrhQ
 Hpplxd1uamiQ3engeVe2l0lanDrVQ43VYDok4lqqxQe/+UxcRi32H7UqnHky/Uu++pMe
 WRiZQSVLqneKGYTlFiE3lc7s3dJhLOoq6yOsnkFTnopZS5fIejGE5ooAolstwMCRQFBA
 b+6vNRuhKNbTSemZI6mZlFfgW2aDswJgkUFB16GK3XpBlTTU/LZnCfQEpwVAGOWQkFmh
 CsQSyiJ3Y08/HiuDIv/WlpCobjd9xPGwrTB/KgXC+Xfhoznm52JMFRMBMquuiclMFAM1
 OqTA==
X-Gm-Message-State: AOJu0Yyb8fQnSsO3jjQomON1i5dS7uKUO4dsZNHzX8219oVHDyHXk5Ya
 CmS4OKazif8dt/IxOPplKx2DkLKTzJkUZVamLM7qew8yWa42qsNAlh6Ahm4O845cV5Q=
X-Gm-Gg: AfdE7cnqM0JzAYKI9FQVT/o/LBMKP9qXl8D6wOfVFWHpoUCPYGoPLelQtC86RMNG9yN
 gA5mr0Z4XoIH4jmnzNHkfXNjMMkKsGrR/RkJbF5nKkJyt9Rm6Ios4G3WjIOYHk2ntcsqy2U2BaD
 X4pmFrbaRaPl29lX8a9kmKiQ+/fjQRXFl/ZNk7DVes+mzJO1IOy7PK4HLhbEC5l7kHdMhssPnEi
 Z7AvhhZCTqaL0ihRwIewa61GBmbtWQYuZoJdkTLOaZmc8lk6YGizbEaTLrGp07k51w2cHKdeyfW
 DcqS/x6blpARGmr9Dv/4fbFdafOqfkBXyQsyw30ntEJ8s9CV6cCSn9R+kt1sqztv5XiAdpMUUuu
 dqMz0t4uJ44OjDMdgrHfQ3sPmdgi+BsrMKWs70bjcv7vWW/i+PfyUCyru31n67dPiTP6C7aeK2P
 4YfSvlRl2n/h+z
X-Received: by 2002:a05:600c:811b:b0:493:b729:3a9 with SMTP id
 5b1f17b1804b1-493f88295demr96757415e9.27.1783959469290; 
 Mon, 13 Jul 2026 09:17:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c89e5sm361438f8f.34.2026.07.13.09.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CD185F845;
 Mon, 13 Jul 2026 17:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/7] mailmap: Fix Ryan Zhang email address
Date: Mon, 13 Jul 2026 17:17:39 +0100
Message-ID: <20260713161745.53889-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Add a .mailmap entry to fix the invalid email introduced
in commit 490a3e1867f ("ui/sdl2: Set GL ES profile before
creating initial GL context").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260619071422.99061-1-philmd@oss.qualcomm.com>
Message-ID: <20260709080040.4157324-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index 593b6c2c534..7665ea87562 100644
--- a/.mailmap
+++ b/.mailmap
@@ -36,6 +36,7 @@ Jason Wang <jasowangio@gmail.com> Jason Wang <jasowang@redhat.com>
 Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
 Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
 Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
+Ryan Zhang <ryan.zhang@nxp.com> Ryan Zhang <mailto>
 Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
 Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
-- 
2.47.3


