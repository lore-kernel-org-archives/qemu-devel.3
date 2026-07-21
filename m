Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D4C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bn-0005NE-To; Tue, 21 Jul 2026 04:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bm-0005MO-BZ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bk-0005ft-Tn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so23988415e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623855; x=1785228655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pcVlEqr/bB3gW9K7U5eUl2N8mxO8truIrpOolaMbkfE=;
 b=e5uihLcUi+yiLJerGqyjXau+N1GnSvd78r9XoGqPrZfVwAxlpL8+j2MzBJ+Cz81gAF
 H6NTX1+7ELvboHXzBDyjufi4swuE2hmlYx1jjbiDVXr19BFqbrnNIEQ4JOmF7pBIXAXy
 eYQ46XdvUSSFxG66usJQlKavZL/GftFAppBuJN16ZbgFOiC757YO/5IXjjTsX6QRFrUE
 Dap3fh3W1cAsBfuykaW0WNfpzCr50vswaFGnP1BTFk3y92v9ZJwC3y38AuMWOdQM6vNZ
 eATmvsz9/B7djyFByyVuOIcn8sY26PWXyrR/YTzYF9sRVAGn/Z+TxKA1lOyOhHTRWtvl
 4eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623855; x=1785228655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pcVlEqr/bB3gW9K7U5eUl2N8mxO8truIrpOolaMbkfE=;
 b=Yff1oq0/VXdPCzS0Ig9qVLbEWzXLTo0OIsG+QhGf81hktFdsasM4OZ47M0raoW4DA1
 e4E2sxnqXgg1Kik1HkKIhoqztx/WGXANIxjEglzIrMPiL9uTzT0Hy2NchzpdW+K4g/YU
 NGAfpjFo6EhKDxg4Mc9RXkJ+MZ89YKeuJxbW5DiarnZENqyUuCceQlCPpWJk3gynReo4
 EKG5twjy3T5ust4WRAbXLzW6psQql6xk6y1rWjDz03cUaDcG2c0ImKqxRhsg6OikJC3y
 +r+D1YuG38JkL4i8Z7m38zQny3xr5oywoeZzI0/INrX5mmB4OcdsMxZ1379iixLPygwp
 pXNQ==
X-Gm-Message-State: AOJu0Yx1zvXa7SjzeS/+ZS/C51JwcmGEIF7NP6ab0XQynKpDxgQorPgo
 hMvmfFaAk6MYjOfmPlin2zfpF4LM1mD/2OVbsyeZh95vWbRVqpvuD7QEEv7icrmz6aobOAvPk5A
 Aq7JGLa/NMA==
X-Gm-Gg: AfdE7clHSz6UW5tGkR9EUcKWsIvL9WICyUWnhxJi3BE+YqzBDB7AtUdqXPwLzY0PYnZ
 4bkW/S/eQQRyZEBqyMc0rjOU0cqDJpHjb4s1PrmgonqOHsb7Pa7qBvXVCCs1/l63p1bHyLEVP83
 P7WwauPPS6dFylczXeyHkCiOuXzzC76O+qRWM1qU05psdliQLZqjGcYDwR84Y3USyIW9Do42mF8
 JTcUnF6OF7Xy9rx9QCRksErf4yWFqNSONedtSOG2efTfw9mx7nX1BHuTT/GlJiLnfP/pC33bCMy
 sqUwzEvFtug/CJ3RRTbzpXpbpsAiV5jUVn1+w0UR49+s1f0fLbBQX4szTAgrkqYBOMZ0eYNGB9u
 XZovttjHo7B/X+tPupjVIlwyCI5sXIVbrcUu3UJancZLemMPUnVjFZnpyemJjOaDvtH5gqFM1SC
 /ZoCSVrYRjvovovSSmeuW/4wtMg0px3UOWMY5YF2zzYawoGNjH/69qfvPL7n3DeTYe/RmoEU8Y1
 FwLkw7p3xA=
X-Received: by 2002:a05:600c:524c:b0:495:4cb6:71c3 with SMTP id
 5b1f17b1804b1-4954cb67f3dmr201107495e9.39.1784623855515; 
 Tue, 21 Jul 2026 01:50:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.50.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:50:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] hw/net/xilinx_axienet: Fix PHY register 17 link status
 reporting
Date: Tue, 21 Jul 2026 09:50:36 +0100
Message-ID: <20260721085050.421257-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Jay Chang <jay.chang@sifive.com>

The Marvell 88E1111 PHY register 17 (PHY Specific Status Register)
bit 10 reports real-time link status. Previously, this register
returned a fixed value of 0x8800 with bit 10 always cleared,
causing U-Boot to always detect "No link" even when the link
was up.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Message-id: 20260713064617.85374-1-jay.chang@sifive.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/xilinx_axienet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 970732b162b..9f5f65ecfac 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -103,6 +103,9 @@ static unsigned int tdk_read(struct PHY *phy, unsigned int req)
         case 17:
             /* Marvell PHY on many xilinx boards.  */
             r = 0x8000; /* 1000Mb  */
+            if (phy->link) {
+                r |= 0x0400; /* Link is up */
+            }
             break;
         case 18:
             {
-- 
2.43.0


