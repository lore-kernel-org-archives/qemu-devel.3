Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CA9C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGh-0008Bi-4r; Tue, 28 Jul 2026 06:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGg-0008BH-Fu
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:38 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGe-0008JU-63
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:38 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c16794450aeso466332766b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235355; x=1785840155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhfeGe/4CB094Qsb3YMVun3IRBzdJrjy7hL+hy4mT8o=;
 b=brCi/5pbNulNclOxdctmlDqMk6UokhWcd5iPfu+XtGrnv051GlUS7flt8Wycc9dqjQ
 ZR/iU138boftnlZ3AwIonD+AWKayClls6vMfHZ0mWAF2GmVIGA6wnSgaFrLtkJicVVol
 tNi9kxZ574JqIi9xVyNi0nwE/mWDEIMi5klqdhuecTKJFocl29UKZwtju3MbPaSLokpO
 8DBfMXJzCIM8jQhvQiepkg5hUUoFGFKA+zjYtfQDCPB2nLbgUTRdNyWwZXoHSaS35Dt1
 dKMRdm2NmwAnpenFAYIzyp6FPsFghJUh6CSOSHaUtJWlxNyv54FPT1JYQIJmIZ73P9c5
 v99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235355; x=1785840155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhfeGe/4CB094Qsb3YMVun3IRBzdJrjy7hL+hy4mT8o=;
 b=qIfjRGUl8xpVAVEHR1PSLLzpNxQi+TrIIelOu3no2W7OMSkplvFVz4/CjqZ8NZX7bV
 wrIs9OZEXdEP3KoK1kvZDqpID+B++tym9+H7Ea/NZsCLhAhIwMoTF7gjg3Oby8TsPcjL
 EyiTg+GzqJssbIXwumtiR2VLxiA8m2X5nvkZveyTr6Aog960rPTTgpPeaZdBDC2CnXeT
 yCbkqi51ft7cXB7zPfOJ7KgJPWlGhgNFjeabcd9j11tXgOi9YUz31ZLNpTqi3ZPJlDqF
 BvdO9039VwEPgQtUoltUBoYWAjxIoS6V9RkeA7fWlXm4SLGrKfPRGwk5Eez17owBhTn8
 kdBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8qsAfsXWT+t+xhM8g+gDSqgAKQooyoEWDkELa6aydPCOBhbl/ZSd6qmXK+ZPDzxH3mai9JyzpZSLs@nongnu.org
X-Gm-Message-State: AOJu0YyZet70Dz455QWNjCMxw6k5JzDr8EFzQWRYE6r5yPyv4vUg1VGw
 O0OJqAquueh7U2aCkX3P1HYTeNX2yTfY7uqrYTCA+5hgUrZyBVTSUe2yEpmjE4WnZXA=
X-Gm-Gg: AR+sD11Cr967dDIFDMOyZfm4wIe1toB1fP0w232ifDVXY32iKayS4FBXLG4OS5/Tvw3
 9HpJa0LNBTxtD0pnRJUFfvuaezUyvVEKDgy6uJYqf+5WLWCGuc7f9FBwEoXdgC9mPRWth9hN3CD
 yGYfTpvIzaLMhC3+Vkz5mpGTBSUyb4VywQ4yE1ZbvLW8jBy1WhXPCYQ7iY6Xip2PQRMEpaYhnyu
 9qkAT5r5bOkRKjkEnnm3RP8fj2QMn2Qb6vXPDsBIJg06p7+KLuxb6ZYVwV/mrC9GmcfjUWCAD1r
 wS+/d1U+qLREuYbjrLJvyCBNHRnxgFzmIO45RYX7ct1I1Jf7dhviQEXdHKhPKK1KV+Wcn9jOMDb
 +dXtLEul2cq7Va7Vt+wWYWR56W8siRzy2nxgzyjSd/gDu+TO7MowRmJDnsrqhIWP/Rg==
X-Received: by 2002:a17:907:eccc:b0:c1f:13ec:bcbe with SMTP id
 a640c23a62f3a-c1f720ef007mr101326866b.30.1785235354705; 
 Tue, 28 Jul 2026 03:42:34 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 9/9] MAINTAINERS: update parallels tree location
Date: Tue, 28 Jul 2026 12:42:21 +0200
Message-ID: <20260728104221.3981592-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
References: <20260728104221.3981592-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=den@openvz.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

src.openvz.org is become unmaintained, point to the GitLab tree
instead.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a28935c898..902db77218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4393,7 +4393,7 @@ F: block/parallels.c
 F: block/parallels-ext.c
 F: docs/interop/parallels.rst
 F: docs/interop/prl-xml.rst
-T: git https://src.openvz.org/scm/~den/qemu.git parallels
+T: git https://gitlab.com/dlunev/qemu.git parallels
 
 qed
 M: Stefan Hajnoczi <stefanha@redhat.com>
-- 
2.53.0


