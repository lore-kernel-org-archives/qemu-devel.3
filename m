Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C9CCD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPw-0006iW-F9; Wed, 06 May 2026 22:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPu-0006bS-8E
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:46 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPs-0007h6-Tz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:46 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-682fce74c06so252849eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120683; x=1778725483;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxPzwDdNP8oDpYmA2hO0L7kRJDxaNQN6DWWEtCBD4Fo=;
 b=bNkMeq2hfvfzrFTdYsdlZicP9X3iLGKF8EPY617KxRlKXP2SC16GKgumLp+ivtBeFn
 HhGmIDGaK0acSUZF523I5zuiCCpylnADP0YyJUNwBu2D6EyVW0ZcsyaOUq73Z43n9x6k
 JBV/Pub06shjt0A5NcGpNfOjmLjrdSkuVVUAkqttiQ8SWQFt3gdos+kNnq7xF1VcTbjy
 rHXwpipec1vQwNSeRPQ/4z4zi1EkP7wL/RDB9lsF8hF643+/M1GDhMaJBh+uqMTn0fBQ
 XhL4peDMohmerER+JXnMYyMYLBPfGyOy9dSBUjpA2/lVel12ckamqwfAzak5cHu9trIP
 SvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120683; x=1778725483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KxPzwDdNP8oDpYmA2hO0L7kRJDxaNQN6DWWEtCBD4Fo=;
 b=h/tjRTnL18ez9QG/LmpY3HQJYDARMtmXSc1m+gtAq/6XJFJnSJDO66aj3hTQTQBtu7
 MP7IxVt3gSZzs0KunYmvBwuMQB6cEV2+FCjZ47oH02hOIilfH8jqEZ5r4U2eC5FC9SWV
 15nX6A1P+lA66iaNItGyQC/fWP2897GvlOHjgt7JlpMRKT8WGBrnJhrF/3Y0S51ZD1Pq
 HqdX425RBkwXvDD0eMr/uJ/tc6uODxzKF0j8lcuntpcablhxRTeJP8XEYakN9YxbPcuC
 UL6OeGlWgD5131chBRfF1lTbAuQSMwxPcrVBtMJ5txG91HLyLNvQuKqJ70sF4yH0xVJp
 aBXw==
X-Gm-Message-State: AOJu0YzS1kr0uHN/X8lptzrJ+E7iVbk0w4v+SKbZA4kwfJRt842iqU+9
 xJzs073NWa1//AfIDAl7e5l26/tU3Q+IhOi3HNnErF8DRPJ+P76GgIXnyREHFdhEBa28bZhxML0
 69Pk569g=
X-Gm-Gg: AeBDieuWIg6mm+lCoSeoqBFFGB3Dt/wCkubPsZeSH+zlKkw0FHjlF19uAJ9ZcHT4vzU
 +ril34q2Yjg1dVuykxC9QZnZpRs9oirUwjNjQ+D6681XWZUInd5oPukWPHmkOPznoR7UH8hzHdo
 DxIvy9RE5FfeSltynOdvgyMRBvEeTKZ5A/E7u/dP2BP+v9X92k4sZ88+q+UagYxBVeONtNsh9v/
 rc3vYaURzSlJfbLljZtCYOiJ7uE1pDa2uHaGtOAamHYjD6i6Xg2EsZe2Ofq85Fhu9AOIGak53Wr
 EK0G3UQIPU/wWhaph6y6XzPLs1vNKirQchJDOCRTtHH50N5icjLEErWy+0MuKDTcg3CUbS58Fpj
 uv589HCu6dBYIHtBHzgm9GtcujEydMdulvF/lYUGQrBun0BwXP0xxF6phyIP78XO6p4RIKIr7yO
 c0NuEhPSpqpjbBiEQWrpjhFABx7D2n1Ls=
X-Received: by 2002:a05:6820:4c08:b0:696:7d51:79d6 with SMTP id
 006d021491bc7-69998d3338amr3241685eaf.31.1778120683319; 
 Wed, 06 May 2026 19:24:43 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 20/25] bsd-user: Add do_ioctl_unsupported function
Date: Wed,  6 May 2026 20:22:14 -0600
Message-ID: <20260507022219.44171-21-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add handler function for unsupported ioctl commands that returns
TARGET_ENXIO.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 2d84adce71..69d1ea1718 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -241,3 +241,11 @@ static void log_unsupported_ioctl(unsigned long cmd)
     gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
              IOCPARM_LEN(cmd));
 }
+
+static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
+                                     __unused uint8_t *buf_temp,
+                                     __unused int fd, __unused abi_long cmd,
+                                     __unused abi_long arg)
+{
+    return -TARGET_ENXIO;
+}
-- 
2.52.0


